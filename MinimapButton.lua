-- MinimapButton.lua
local addonName, addonTable = ...
local L = addonTable.L
local icon = LibStub("LibDBIcon-1.0", true)
local settings = ProspectHelperSettings or { minimap = { hide = false } }

-- Obtiene la UI del addon
local function GetUI()
    if not addonTable.uiFrame then
        if addonTable.ProspectHelper and addonTable.ProspectHelper.UpdateUI then
            addonTable.ProspectHelper.UpdateUI()
        end
    end
    return addonTable.uiFrame
end

-- DataBroker
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("ProspectHelper", {
    type = "data source",
    text = "ProspectHelper",
    icon = "Interface\\Icons\\inv_misc_gem_bloodgem_01",
    OnClick = function(_, button)
        local ui = GetUI()
        if not ui then
            print("|cffffff00[|r|cffd597ffProspectHelper|r|cffffff00]|r "..L["UI not initialized"])
            return
        end

        if button == "LeftButton" then
            if ui:IsShown() then
                ui:Hide()
            else
                if addonTable.ProspectHelper and addonTable.ProspectHelper.UpdateUI then
                    addonTable.ProspectHelper.UpdateUI()
                end
                ui:Show()
            end
        elseif button == "RightButton" then
            print("|cffffff00[|r|cffd597ffProspectHelper|r|cffffff00]|r "..L["Left click to toggle the Prospect Helper UI, right click for this info."])
        end
    end,
    OnTooltipShow = function(tt)
        tt:AddLine(L["Prospect Helper"])
        tt:AddLine(L["Left click: Toggle UI"])
        tt:AddLine(L["Right click: Info"])
    end,
})

-- Inicializa el minimap button
local function ProspectHelper_InitMinimap()
    if icon and not icon:IsRegistered("ProspectHelper") then
        icon:Register("ProspectHelper", LDB, settings.minimap)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", ProspectHelper_InitMinimap)
