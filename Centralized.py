import json
from github import Github
import os
import subprocess

g = Github('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')

with open('Selling.cfg', 'r') as f:
    data = json.load(f)

with open('MilkConfig.json', 'r') as f:
    milkconfig = json.load(f)

selling_list = data['Booths']['Selling']['SellingList']
selling_list.sort(key=lambda x: int(x['Price']), reverse=True)
data['Booths']['Selling']['Options'] = []

for item in selling_list:
    data['Booths']['Selling']['Options'].append(item['Type'])

data['Booths']['Selling']['Options'].append([])

with open('Selling.cfg', 'w') as f:
    json.dump(data, f, separators=(',', ':'))

with open('Selling.cfg', 'r') as f:
    data = json.load(f)

data['SnipeWebhook'] = "https://discord.com/api/webhooks/1087767388902133850/EPwgwO3ERE6Tivrw2S7YTU8XX5NAFc0cw12IcMusT1vbD0Mhm6zxAjODMn5pEWmQSz6U"
data['Booths']['Extra']['BoothServerHop'] = "false"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\\V1\\Selling.cfg', 'w') as f:
    json.dump(data, f, separators=(',', ':'))

data['SnipeWebhook'] = "https://discord.com/api/webhooks/1095711070896795681/6iC1hl3fvPeclRCSxF4TpC6vJ_8JGxaMuCa79M9WtrLM7UxxsVCSW9uPFxezeEKcoqya"

with open('C:\\Users\\Admin\\Desktop\\Psx_M\\Configurations\\V2\\Selling.cfg', 'w') as f:
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
