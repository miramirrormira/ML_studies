import zipfile

def unzip(filename, destination):
    local_zip = filename
    zip_ref = zipfile.ZipFile(filename,'r')
    zip_ref.extractall(destination)
    zip_ref.close()
    