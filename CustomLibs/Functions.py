# Change only Current_Dir_Path to get files in any dir
import os
current_dir_path = 'C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\'
def get_files_from_dir(path):
    allfiles = []
    number = 1
    listoffiles = os.listdir(current_dir_path)
    for folder in listoffiles:
        allfiles.append(folder)
        number = number + 1
    return allfiles

Alldirs = get_files_from_dir(current_dir_path)
print(Alldirs)


