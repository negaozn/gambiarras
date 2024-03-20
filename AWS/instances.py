import boto3

client = boto3.client('ec2',)
regions = client.describe_regions()
Region_list = []
for r in regions:
    Region_list.append(r['RegionName'])

print(Region_list)

# ec2 = boto3.resource('ec2', region_name='sa-east-1')

# response = ec2



# for i in ec2.instances.all():
#     if i.state['Name' == 'running']:
#         i.id

# print(ec2.instances.all())