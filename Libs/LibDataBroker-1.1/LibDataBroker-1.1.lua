local lib, oldminor = LibStub:NewLibrary("LibDataBroker-1.1", 4)
if not lib then return end
lib.objects = lib.objects or {}

function lib:NewDataObject(name, dataobj)
    if self.objects[name] then return end
    self.objects[name] = dataobj
    return dataobj
end

function lib:GetDataObjectByName(name) return self.objects[name] end
function lib:DataObjectIterator() return pairs(self.objects) end
