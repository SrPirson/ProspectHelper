local DBICON, oldminor = LibStub:NewLibrary("LibDBIcon-1.0", 5)
if not DBICON then return end

DBICON.objects = DBICON.objects or {}

function DBICON:Register(name, dataobj, db)
    if not dataobj.icon then return end
    local button = CreateFrame("Button", "LibDBIcon10_"..name, Minimap)
    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button.dataObject, button.db = dataobj, db
    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetSize(20, 20)
    button.icon:SetPoint("CENTER")
    button.icon:SetTexture(dataobj.icon)

    button:SetScript("OnEnter", function(self)
        if dataobj.OnTooltipShow then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            dataobj.OnTooltipShow(GameTooltip)
            GameTooltip:Show()
        end
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    button:SetScript("OnClick", function(_, btn) if dataobj.OnClick then dataobj.OnClick(_, btn) end end)

    if not db.hide then button:Show() else button:Hide() end
    DBICON.objects[name] = button
end

function DBICON:Hide(name) if self.objects[name] then self.objects[name]:Hide() end end
function DBICON:Show(name) if self.objects[name] then self.objects[name]:Show() end end
