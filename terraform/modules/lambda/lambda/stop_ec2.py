import boto3

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    instances = ec2.describe_instances(
        Filters=[
            {'Name': 'tag:Environment', 'Values': ['dev']}
        ]
    )

    instance_ids = []
    for r in instances['Reservations']:
        for i in r['Instances']:
            if i['State']['Name'] == 'running':
                instance_ids.append(i['InstanceId'])

    if instance_ids:
        ec2.stop_instances(InstanceIds=instance_ids)

    return {
        'statusCode': 200,
        'body': f'Stopped instances: {instance_ids}'
    }
#IMPORTANT NOTE

#EC2 must have tag:

#Environment = dev
