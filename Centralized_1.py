import json
from github import Github
import os
import subprocess

g = Github('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')

with open('Selling.json', 'r') as f:
    data = json.load(f)

with open('MilkConfig.json', 'r') as f:
    milkconfig = json.load(f)

data = sorted(data, key=lambda x: x[1], reverse=True)

with open('Selling.json', 'w') as f:
    json.dump(data, f, indent=2)

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\\V1\\Selling.json', 'w') as f:
    json.dump(data, f, separators=(',', ':'))

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\\V2\\Selling.json', 'w') as f:
    json.dump(data, f, separators=(',', ':'))

sniping_list = milkconfig['Booths']['Sniping']['SnipingList']

milkconfig['Booths']['Sniping']['Options'] = []
milkconfig['Booths']['Sniping']['Rarities'] = []

for item in sniping_list:
    milkconfig['Booths']['Sniping']['Options'].append(item['Type'])
    if item['Rarity'] == "None":
        milkconfig['Booths']['Sniping']['Rarities'].append([])
    else:
        milkconfig['Booths']['Sniping']['Rarities'].append(item['Rarity'])

milkconfig['Booths']['Sniping']['Options'].append([])
milkconfig['Booths']['Sniping']['Rarities'].append([])

with open('MilkConfig.json', 'w') as f:
    json.dump(milkconfig, f, indent=2)

milkconfig['Webhooks']['SnipeWebhook']['ChoosenWebhook'] = "https://discord.com/api/webhooks/1087767285688709163/ZYboDxOJV1jZVR-OHsdGQ4KqASjEgs1lXnrFvHcASabc6_dzkcMgsYCgvOTT_QdeVxuN"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\V1\\Sniping\\DefaultConfig.json', 'w') as f:
    json.dump(milkconfig, f, separators=(',', ':'))

milkconfig['Webhooks']['SnipeWebhook']['ChoosenWebhook'] = "https://discord.com/api/webhooks/1095710826343694386/ZnIOdAYN20-aZsfj3QQ3ta-00eYfEZPIgjusNPTtrliJliWYTt3JBMyVbftgbozN47LD"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\V2\\Sniping\\DefaultConfig.json', 'w') as f:
    json.dump(milkconfig, f, separators=(',', ':'))

milkconfig['Booths']['Sniping']['SnipingList'] = milkconfig['Booths']['Sniping']['SnipingList'][2:]
milkconfig['Booths']['Sniping']['Options'] = milkconfig['Booths']['Sniping']['Options'][2:]
milkconfig['Booths']['Sniping']['Rarities'] = milkconfig['Booths']['Sniping']['Rarities'][2:]

milkconfig['Webhooks']['SnipeWebhook']['ChoosenWebhook'] = "https://discord.com/api/webhooks/1087767285688709163/ZYboDxOJV1jZVR-OHsdGQ4KqASjEgs1lXnrFvHcASabc6_dzkcMgsYCgvOTT_QdeVxuN"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\V1\\Purging\\DefaultConfig.json', 'w') as f:
    json.dump(milkconfig, f, separators=(',', ':'))

milkconfig['Webhooks']['SnipeWebhook']['ChoosenWebhook'] = "https://discord.com/api/webhooks/1095710826343694386/ZnIOdAYN20-aZsfj3QQ3ta-00eYfEZPIgjusNPTtrliJliWYTt3JBMyVbftgbozN47LD"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\V2\\Purging\\DefaultConfig.json', 'w') as f:
    json.dump(milkconfig, f, separators=(',', ':'))

repo = g.get_user('Mayhem00E').get_repo('Psx_M')

os.chdir(r"c:\Users\Admin\Desktop\Psx_M")

subprocess.run(['git', 'add', '.'], check=True)

commit_message = 'Changed Config'
subprocess.run(['git', 'commit', '-m', commit_message], check=True)

subprocess.run(['git', 'push'], check=True)
