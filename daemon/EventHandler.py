'''
Created on Dec 14, 2010

@group: RawDimension
'''

import threading

class Event(object):
    command = ""
    deviceId = ""
    type = ""
    value = ""
    def __init__(self,command,deviceId,type,value=""):
        self.command = command
        self.deviceId = deviceId
        self.type = type
        self.value = value
    def __str__(self):
        stri = ""
        stri += "Command: "+str(self.command)+"\n"
        stri += "DeviceId: "+str(self.deviceId)+"\n"
        stri += "Type: "+str(self.type)+"\n"
        stri += "Value: "+str(self.value)+"\n"
        return stri
#    def setCommand(self, command):
#        self.command = command
#    def getCommand(self):
#        return self.command
#    def setType(self,type):
#        self.type = type
#    def getType(self):
#        return self.type
#    def setValue(self, value):
#        self.value = value
#    def getValue(self):
#        return self.value
#    def getDeviceId(self):
#        return self.deviceId
    
class Command(object):
    name = ""
    module = None
    def __init__(self,name,module):
        self.name = name
        self.module = module
    def getName(self):
        return self.name
    def getModule(self):
        return self.module
    
class EventHandler(threading.Thread):
    threads = []
    def __init__(self,mainloop=None):
        self._commands = []
        self._mainloop = mainloop
        threading.Thread.__init__(self)
    def addCommand(self,command):
        self._commands.append(command)
    def removeCommand(self,commandName):
        for comm in self._commands:
            if comm.name == commandName:
                self._commands.remove(comm)
                break
    def run(self):
        self._mainloop.run()
    def close(self):
        print "eventhandler close()"
        # wait for working threads to terminate
        for thread in self.threads:
            thread.join()
        print "dbus mainloop quit"
        # terminate the gobject mainloop
        self._mainloop.quit()
    def handleEvent(self,event):
        #lock thread
        lock = threading.Lock()
        lock.acquire()
        print "start handling event"
        for comm in self._commands:
            if comm.name == event.command:
                try:
                    print type(comm.module)
                    thread = type(comm.module)()
                    thread.copy(comm.module)
                    thread.event = event
                    thread.start()
                    "event handled: ", event.command
                    self.threads.append(thread)
                except:
                    print "ERROR: module thread could not be started"
                break
        #release thread
        lock.release()
    
                        
        