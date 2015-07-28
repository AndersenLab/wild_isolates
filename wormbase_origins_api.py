import requests
import json
import csv
import time

f = open("strains.txt", "r")
strains = f.readlines()
strains2 = [x.strip() for x in strains]
strains3 = [x.strip('"') for x in strains2]

def get_data(strain):
    url = "http://www.wormbase.org/rest/widget/strain/" + strain + "/origin"
    headers = {"content-type": "application/json"}
    data = requests.get(url, headers=headers)
    try:
        jsondata = json.loads(data.text)
        fields = jsondata.get('fields', {})
        straininfo = []
        straininfo.append(fields.get('name', {}).get('data', {}).get('id', 'NA'))
        straininfo.append(fields.get('date_isolated', {}).get('data', 'NA'))
        straininfo.append(fields.get('gps_coordinates', {}).get('data', {}).get('latitude', 'NA'))
        straininfo.append(fields.get('gps_coordinates', {}).get('data', {}).get('longitude', 'NA'))
        straininfo.append(fields.get('isolated_by', {}).get('data', {}).get('label', 'NA')) if fields.get('isolated_by', {}).get('data', {}) != None else straininfo.append('NA')
        straininfo.append(fields.get('landscape', {}).get('data', 'NA'))
        straininfo.append(fields.get('place', {}).get('data', 'NA'))
        straininfo.append(fields.get('sampled_by', {}).get('data', 'NA'))
        straininfo.append(fields.get('substrate', {}).get('data', 'NA'))
        print("Success with strain " + strain)
        f = open('WBStrainsInfo.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(straininfo)
    except:
        pass


# def get_data(strain):
#     print(strain)
#     url = "http://www.wormbase.org/rest/widget/strain/" + strain + "/origin"
#     headers = {"content-type": "application/json"}
#     data = requests.get(url, headers=headers)
#     with open("wormbasejson/" + strain + ".json", "wt") as f:
#         f.w(data.text)
#         f.close()

# if __name__ == '__main__':
#     i = 1
#     for strain in strains3:
#         print("Strain " + str(i) + " of " + str(len(strains3)))
#         get_data(strain)
#         i += 1

if __name__ == '__main__':
    n = 0
    for i in range(n, len(strains3)):
        print("Strain " + str(i) + " of " + str(len(strains3)))
        get_data(strains3[i])
        n += 1
