'''
Created on Feb 21, 2011

@group: Raw Dimension
'''

class Attribute(object):
    name = ""
    value = ""
    def __init__(self,name,value):
        self.name = name
        self.value = value
    def getName(self):
        return self.name
    def getValue(self):
        return self.value

class XmlData(object):
    name = ""
    def __init__(self, name):
        self.name = name
        self._attribute_list = []
        self._child_list = []
    def addAttribute(self,attribute):
        self._attribute_list.append(attribute)
    def addChild(self,child):
        self._child_list.append(child)
    def getChildren(self):
        return self._child_list
    def getAttributeList(self):
        return self._attribute_list
    def getChild(self,name):
        for child in self._child_list:
            if child.name == name:
                return child
        raise AttributeError("WARNING: no child with name",name,"found")
    def getAttribute(self,name):
        for att in self._attribute_list:
            if att.name == name:
                return att
        raise AttributeError("WARNING: no attribute with name",name,"found")
#    def getName(self):
#        return self.name
