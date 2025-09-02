local MAJOR, MINOR = "CallbackHandler-1.0", 7
local CallbackHandler = LibStub:NewLibrary(MAJOR, MINOR)

if CallbackHandler then
    local function errorhandler(err) return geterrorhandler()(err) end
    local function Register(self, event, method, ...)
        if type(method) ~= "function" and type(self[method]) ~= "function" then
            error("CallbackHandler: you must provide a function or method name", 2)
        end
        self.events[event] = self.events[event] or {}
        self.events[event][method] = true
    end
    local function Unregister(self, event, method)
        if self.events[event] then self.events[event][method] = nil end
    end
    local function Fire(self, event, ...)
        if self.events[event] then
            for method in pairs(self.events[event]) do
                local func = type(method) == "string" and self[method] or method
                xpcall(func, errorhandler, self, ...)
            end
        end
    end
    function CallbackHandler:New(target)
        target.events, target.RegisterCallback, target.UnregisterCallback, target.FireCallbacks =
            {}, Register, Unregister, Fire
        return target
    end
end
