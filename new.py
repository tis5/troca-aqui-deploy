import boto3
import datetime
import pprint
import collections

def lambda_handler(event, context):
    
    ec2 = boto3.resource('ec2')
    ec2c = boto3.client('ec2')
    reservations = ec2c.describe_instances(
            Filters=[
                {
                    'Name': 'tag:daily-backup',
                    'Values': ['yes']
                }
            ]
        )["Reservations"]
    
    instances = sum([[i for i in r['Instances']] for r in reservations], [])
    print("Found %d instances that need backing up" % len(instances))
    
    tagging = collections.defaultdict(list)
    
    for instance in instances:
        try:
            retention_days = [
                int(t.get('Value')) for t in instance['Tags']
                if t['Key'] == 'Retention'][0]
        except IndexError:
            retention_days = 5
        finally:
            
            create_time = datetime.datetime.now()
            create_fmt = create_time.strftime('%Y-%m-%d--%H-%M-%S')
            
            image = ec2c.create_image(InstanceId=instance['InstanceId'], Name="Daily Backup AMI - " + instance['InstanceId'] + " from " + create_fmt, Description="Backup AMI of instance " + instance['InstanceId'] + " from " + create_fmt, NoReboot=True, DryRun=False)
            #pprint.pprint(instance)
            
            tagging[retention_days].append(image['ImageId'])
            
            print("Retention for AMI %s, instance %s, is set for %d days" % (image['ImageId'],instance['InstanceId'],retention_days,))
            print(tagging.keys())
            
            for retention_days in tagging.keys():
                delete_date = datetime.date.today() + datetime.timedelta(days=retention_days)
                delete_fmt = delete_date.strftime('%d-%m-%Y')
                print("A total of %d AMIs will be deleted on %s" % (len(tagging[retention_days]), delete_fmt))
                
                ec2c.create_tags(
                    Resources=tagging[retention_days],
                    Tags=[
                        {'Key': 'delete-on', 'Value': delete_fmt},
                    ]
                )
            
            inst = ec2.Instance(instance['InstanceId'])
            img = ec2.Image(image['ImageId'])
            
            for ec2tags in inst.tags:
                if not ec2tags["Key"].startswith('aws'):
                    img.create_tags(
                        Tags=[
                            {
                                'Key': ec2tags["Key"],
                                'Value': ec2tags["Value"]
                            }
                        ]
                    )
            
            imgdevices=ec2c.describe_images(
                ImageIds=[image['ImageId']]
            )['Images'][0]['BlockDeviceMappings']
            
            for ec2tags in inst.tags:
                if not ec2tags["Key"].startswith('aws'):
                    for device in imgdevices:
                        snapid=device['Ebs']['SnapshotId']
                        snap=ec2.Snapshot(snapid)
                        snap.create_tags(
                            Tags=[
                                {
                                    'Key': ec2tags["Key"],
                                    'Value': ec2tags["Value"]
                                }
                            ]
                        )
            
    return 'AMIs generated.'