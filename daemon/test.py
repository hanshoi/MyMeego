from XmlData import XmlData, Attribute
from XmlGenerator import xmlToFile,fileToXml
from EventHandler import EventHandler, Command,Event
from Module import DbusModule, WorkerModule, UpnpModule
from TransferList import TransferList
from Config import Config,config

def _compareXmlData(dat1,dat2):
    try:
        assert dat1.name == dat2.name, "names are different: "+dat1.name+" and "+dat2.name
        amount1 = len(dat1.getAttributeList())
        amount2 = len(dat2.getAttributeList())
        assert amount1 == amount2, "different amount of attributes in "+dat1.name+" and"+dat2.name
        if amount1 > 0 and amount2 > 0:
            for index in range(amount1):
                att1 = dat1.getAttributeList()[index]
                att2 = dat2.getAttributeList()[index]
                assert att1.name == att2.name, "different attribute names: "+att1.name+" and "+att2.name
                assert att1.value == att2.value, "different attrubute values: "+att1.value+" and "+att2.value
        assert len(dat1.getChildren()) == len(dat2.getChildren()), "different amount of children in "+dat1.name+" and "+dat2.name
        for index in range(len(dat1.getChildren())):
            child1 = dat1.getChildren()[index]
            child2 = dat2.getChildren()[index]
            _compareXmlData(child1,child2)
    except AssertionError as err:
        print "ERROR:",err
        

def xmlTest():
    print "xml test set"
    print "create xml data"
    root = XmlData("root")
    child1 = XmlData("child1")
    child1.addAttribute(Attribute("name","gettomaster"))
    child1.addAttribute(Attribute("vip","34"))
    child11 = XmlData("child11")
    child1.addChild(child11)
    root.addChild(child1)
    child2 = XmlData("child2")
    root.addChild(child2)
    print "xml created"
    
    print "create file"
    xmlToFile(root,"data/asdad.xml")
    
    print "read xml from file"
    rootxml = fileToXml("data/asdad.xml")
    print "loaded root node: ",rootxml.name
        
    print "Test get child & attribute functions"
    c1 = rootxml.getChild("child1")
    c1.getAttribute("name")
    try:
        rootxml.getChild("xxx")
        rootxml.getAttribute("yyy")
    except:
        pass
    else:
        print "ERROR: no exception raised."
        
    print "compare results"
    _compareXmlData(root,rootxml)
    print "results compared"
    
    
def eventHandlingTest():
    print "event handler test set"
    print "init test set"
    event_handler = EventHandler()    
    # init modules
    dbus_module = DbusModule(event_handler,"dbus","org.mymeego.Ui","/org/mymeego/Ui","org.mymeego.Ui")
    upnp_module = UpnpModule(event_handler,"upnp")
    worker_module = WorkerModule(event_handler,"worker")  
    #init commands  
    event_handler.addCommand(Command("ReturnUiData",dbus_module))
    event_handler.addCommand(Command("DataRequest",worker_module)) # this is the default command from UI
    event_handler.addCommand(Command("GetDeviceList",upnp_module))
    event_handler.addCommand(Command("GetFileList",upnp_module))
    event_handler.addCommand(Command("TransferFiles",upnp_module))
    
    print "start tests"
    event_handler.handleEvent(Event("DataRequest",1,"GetDeviceList"))
    event_handler.handleEvent(Event("DataRequest",1,"GetFileList"))
    event_handler.handleEvent(Event("DataRequest",1,"TransferFiles"))
    event_handler.handleEvent(Event("ReturnUiData",1,"TransferFiles"))


def transferListTest():
    print "transfer list test"
    valuestringlist = []
    valuestringlist.append("4:5:6")
    valuestringlist.append("3:2:1:2:4:5")
    valuestringlist.append("1:4")
    valuestringlist.append("")
    
    tr = TransferList()
    print tr
    tr.source = "2"
    tr.target = "5"
    tr.file_list.append("12")
    tr.file_list.append("124")
    print tr
    
    print "import as string value tests"    
    for valuestring in valuestringlist:    
        tr = TransferList()
        tr.importAsString(valuestring)
        print tr    
    print "transfer list test set ended"


def configTest():
    print "config test set"
    config.load("data/test.conf")
    
    try:
        assert config.name == "name", "Was not able to load name from config file"
        assert config.coherence_conf == "coherence_path", "Was not able to load coherence config path from config file"
        assert config.temp_folder == "temp_folder", "Was not able to load temp folder path from config file"
        assert config.device_type == "phone", "Was not able to load device type from config file"
        assert len(config.share_folders) == 2, "Was not able to load all shared folders from config file"
        assert config.share_folders[0] == "folder_path1", "Was not able to load first folder path from config file"
        assert config.share_folders[1] == "folder_path2", "Was not able to load second folder path from config file"
    except AssertionError as err:
        print "ERROR:",err
    

if __name__ == '__main__':
    # run the xml test set
    xmlTest()
    # transfer list test set 
    transferListTest()
    # run config test set
    configTest()
    # run event handling test
    eventHandlingTest()