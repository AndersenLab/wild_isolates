import json, csv

data = json.loads(open("wormbase_wildisolates.json", "r").read())

allstrains = [[strain["isolated_by"]["label"],
    strain["landscape"],
    strain["latitude"],
    strain["longitude"],
    strain["place"],
    strain["species"],
    strain["strain"]["id"],
    strain["substrate"]]
    if strain["isolated_by"] and strain["strain"]
    else
    ["NA",
        strain["landscape"],
        strain["latitude"],
        strain["longitude"],
        strain["place"],
        strain["species"],
        "NA",
        strain["substrate"]]
    if strain["isolated_by"]
    else
    ["NA",
        strain["landscape"],
        strain["latitude"],
        strain["longitude"],
        strain["place"],
        strain["species"],
        strain["strain"]["id"],
        strain["substrate"]]
    if strain["strain"]
    else
    [strain["isolated_by"]["label"],
        strain["landscape"],
        strain["latitude"],
        strain["longitude"],
        strain["place"],
        strain["species"],
        "NA",
        strain["substrate"]]
    for strain in data["fields"]]

with open("wormbase_wildisolates.csv", "wt") as csvfile:
    writer = csv.writer(csvfile)
    head = ["isolated_by",
        "landscape",
        "latitude",
        "longitude",
        "place",
        "species",
        "strain",
        "substrate"]
    writer.writerow(head)
    writer.writerows(allstrains)