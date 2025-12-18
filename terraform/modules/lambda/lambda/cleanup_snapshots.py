import boto3
from datetime import datetime, timedelta

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    snapshots = ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']
    cutoff = datetime.now() - timedelta(days=7)

    deleted = []

    for snap in snapshots:
        if snap['StartTime'].replace(tzinfo=None) < cutoff:
            ec2.delete_snapshot(SnapshotId=snap['SnapshotId'])
            deleted.append(snap['SnapshotId'])

    return {
        'statusCode': 200,
        'body': f'Deleted snapshots: {deleted}'
    }
#YOU CAN CHANGE

#days=7 → keep snapshots longer if needed
