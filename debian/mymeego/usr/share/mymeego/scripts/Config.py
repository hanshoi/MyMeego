'''
Created on Mar 25, 2011

@group: Raw Dimension
'''

import XmlData
from XmlGenerator import fileToXml


class Config(object):
    device_type = ""
    device_name = ""
    temp_folder = ""
    coherence_conf = ""
    fake_actions = True
    share_folders = []
    def __init__(self):
        self._is_loaded = False
    def load(self,filename):
        data = fileToXml(filename)
        
        if data.name != "config":
            print "ERROR: file was not a config file"
            return
        
        try:
            for child in data.getChildren():
                if child.name == "device":
                    self.device_type = child.getAttribute("type").value
                    print "DeviceType:",self.device_type
                if child.name == "name":
                    self.device_name = child.getAttribute("value").value
                    print "DeviceName:",self.device_name
                if child.name == "temp_folder":
                    self.temp_folder = child.getAttribute("path").value
                    print "TempFolder:",self.temp_folder
                if child.name == "coherence_config":
                    self.coherence_conf = child.getAttribute("path").value
                    print "CoherenceConfig:",self.coherence_conf      
                if child.name == "fake_actions":
                    val = child.getAttribute("use_fake").value
                    if val == "true":
                        self.fake_actions = True
                    else:
                        self.fake_actions = False             
                if child.name == "folders":
                    for folder in child.getChildren():
                        if folder.name == "folder":
                            path = folder.getAttribute("path").value
                            self.share_folders.append(path)
                            print "SharePath:",path
        except AttributeError as e:
            print "Does not find config attribute",e.value
            
            
        self._is_loaded = True
    def isLoaded(self):
        return self._is_loaded
    
#global instance of the config class
config = Config()
