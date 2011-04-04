'''
Created on Mar 14, 2011

@author: Raw Dimension
'''

class TransferList(object):
    source = ""
    target = ""
    file_list = []
    def __init__(self,source = "", target = "", file_list = []):
        self.source = source
        self.target = target
        self.file_list = file_list
    def __str__(self):
        stri = "Source: "+str(self.source)
        stri += ", Target: "+str(self.target)
        stri += ", Files: "
        for file in self.file_list:
            stri += str(file)+", "
        return str(stri)
    def importAsString(self,string_value):
        value_list = string_value.split(":")
        # check if valid
        if len(value_list) < 3:
            print "ERROR: string doesn't have minimum required parameters. eg. (source:target:file)"
            return
        
        self.source = value_list.pop(1)
        self.target = value_list.pop(1)
        self.file_list = value_list