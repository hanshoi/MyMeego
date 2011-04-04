'''
Created on Feb 21, 2011

@group: Raw Dimension
'''

import xml.dom.minidom
from XmlData import XmlData, Attribute
import os

def _createElement(document, XmlData):
    el = document.createElement(XmlData.name)
    
    # attributes
    for att in XmlData.getAttributeList():
        el.setAttribute(att.getName(),att.getValue())
    
    # children
    for child in XmlData.getChildren():
        el.appendChild(_createElement(document,child))
        
    return el
    
def _xmlDataToDom(XmlData):
    doc = xml.dom.minidom.Document()
    doc.appendChild(_createElement(doc,XmlData))
    return doc

def _parseElement(element):
    xmlData = XmlData(element.nodeName)
    
    # attributes
    if element.hasAttributes():
        indexlist = range(element.attributes.length)
        indexlist.reverse()     # order has to be reversed (for some reason)
        for index in indexlist:
            att = element.attributes.item(index)
            xmlData.addAttribute(Attribute(att.name, att.value))
        
    # children
    if element.hasChildNodes():
        for child in element.childNodes:
            if child.nodeType == 1: # 1 is the symbolic equivalent of element node.
                xmlData.addChild(_parseElement(child))
    
    return xmlData

def xmlToFile(XmlData,filename):
    file = open(filename,"w")
    dom = _xmlDataToDom(XmlData)
    file.write(dom.toprettyxml())
    file.close()
    
def fileToXml(filename):
    document = xml.dom.minidom.parse(filename)  
    root = _parseElement(document.documentElement)
    return root
    
    
