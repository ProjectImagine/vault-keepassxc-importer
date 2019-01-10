import csv


class Csv:
    def __init__(self, csv_file):
        self.reader = csv.reader(open(csv_file, newline=''), delimiter=',')

    def parse(self):
        parsed = []
        for row in self.reader:
            secret = {
                'path': row[0],
                'service': row[1],
                'value': row[2]
            }
            parsed.append(secret)
        return parsed
