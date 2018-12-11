import csv


class csvLibrary(object):

    def read_csv_file(self, filename):
        '''This creates a keyword named "Read CSV File"

        This keyword takes one argument, which is a path to a .csv file. It
        returns a list of rows, with each row being a list of the data in
        each column.
        '''
        data = []
        # with open(filename, 'r') as csvfile:
        #     reader = csv.reader(csvfile, delimiter=',')
        #     for row in reader:
        #         for i in row:
        #             data.append(i)

        with open(filename, 'r') as csvfile:
            reader = csv.DictReader(csvfile, delimiter=',')
            for row in reader:
                name = row['Incentive Amt ($)']
                data.append(name)
        return data
