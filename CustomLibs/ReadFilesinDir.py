import os

# Function to get all the files as list in currect directory path
# This is useful to verify number of downloaded files, downloaded file content etc

current_dir_path = 'C:\\Users\\BLR153\\Desktop\\Sample CSV Files\\'


class ReadFilesinDir(object):

    def get_files_from_dir(self, path):
        allfiles = []
        number = 1
        listoffiles = os.listdir(current_dir_path)
        for folder in listoffiles:
            allfiles.append(folder)
            number = number + 1
        return allfiles
