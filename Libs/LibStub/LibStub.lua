-- LibStub minimal
local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2
local LibStub = _G[LIBSTUB_MAJOR]

if not LibStub or LibStub.minor < LIBSTUB_MINOR then
    LibStub = LibStub or {libs = {}, minors = {}}
    _G[LIBSTUB_MAJOR] = LibStub
    LibStub.minor = LIBSTUB_MINOR

    function LibStub:NewLibrary(major, minor)
        assert(type(major) == "string", "Bad argument #1 to NewLibrary (string expected)")
        minor = assert(tonumber(minor), "Bad argument #2 to NewLibrary (number expected)")
        local oldminor = self.minors[major]
        if oldminor and oldminor >= minor then return nil end
        local lib = self.libs[major] or {}
        self.libs[major], self.minors[major] = lib, minor
        return lib
    end

    function LibStub:GetLibrary(major, silent)
        local lib = self.libs[major]
        if not lib and not silent then
            error(("Library %q not found."):format(tostring(major)), 2)
        end
        return lib, self.minors[major]
    end

    function LibStub:IterateLibraries() return pairs(self.libs) end
end
