local addonName, addonTable = ...
local PH = {}
_G["ProspectHelper"] = PH

local L = addonTable.L

-- SavedVariables
ProspectHelperSettings = ProspectHelperSettings or { minimap = { hide = false }, showTooltip = true }

local prospectableByID = {
    -- Classic
    [2770] = true, -- Cobre
    [2771] = true, -- Estaño
    [2772] = true, -- Hierro
    [3858] = true, -- Mitrilo
    [10620] = true, -- Torio
    [11370] = true, -- Hierro Negro
    [2776] = true, -- Oro
    [2775] = true, -- Plata
    [11138] = true, -- Cobre de Rethban

    -- The Burning Crusade
    [23424] = true, -- Hierro Fel
    [23425] = true, -- Adamantita
    [23427] = true, -- Khorium
    [23426] = true, -- Eternio

    -- Wrath of the Lich King
    [36910] = true, -- Saronite
    [36912] = true, -- Titanio
    [36909] = true, -- Cobalto

    -- Cataclysm
    [53038] = true, -- Obsidium
    [52185] = true, -- Elementium
    [52188] = true, -- Tormenta de Hierro

    -- Mists of Pandaria
    [72092] = true, -- Hierro Fantasma
    [72093] = true, -- Kyparita
    [72094] = true, -- Trillium Negro
    [72103] = true, -- Trillium Blanco
}

local expansionByID = {
    -- Classic
    [2770] = "Classic", [2771] = "Classic", [2772] = "Classic",
    [3858] = "Classic", [10620] = "Classic", [11370] = "Classic",
    [2776] = "Classic", [2775] = "Classic", [11138] = "Classic",
    -- The Burning Crusade
    [23424] = "The Burning Crusade", [23425] = "The Burning Crusade",
    [23427] = "The Burning Crusade", [23426] = "The Burning Crusade",
    -- Wrath of the Lich King
    [36910] = "Wrath of the Lich King", [36912] = "Wrath of the Lich King",
    [36909] = "Wrath of the Lich King",
    -- Cataclysm
    [53038] = "Cataclysm", [52185] = "Cataclysm", [52188] = "Cataclysm",
    -- Mists of Pandaria
    [72092] = "Mists of Pandaria", [72093] = "Mists of Pandaria",
    [72094] = "Mists of Pandaria", [72103] = "Mists of Pandaria",
    [72238] = "Mists of Pandaria",
}

-- Crear UI
local ui
local function CreateUI()
    ui = CreateFrame("Frame", "ProspectHelperFrame", UIParent, "BasicFrameTemplateWithInset")
    ui:SetSize(320, 400)
    ui:SetPoint("CENTER")
    ui:SetMovable(true)
    ui:EnableMouse(true)
    ui:RegisterForDrag("LeftButton")
    ui:SetScript("OnDragStart", ui.StartMoving)
    ui:SetScript("OnDragStop", ui.StopMovingOrSizing)
    ui:Hide()

    ui.title = ui:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ui.title:SetPoint("TOP", ui.TitleBg, "TOP", 0, -2)
    ui.title:SetText("|cffd597ffProspect Helper|r")
    ui.title:SetJustifyH("CENTER")

    -- Scroll
    ui.scroll = CreateFrame("ScrollFrame", nil, ui, "UIPanelScrollFrameTemplate")
    ui.scroll:SetPoint("TOPLEFT", ui, "TOPLEFT", 10, -34)
    ui.scroll:SetPoint("BOTTOMRIGHT", ui, "BOTTOMRIGHT", -30, 10)
    ui.content = CreateFrame("Frame", nil, ui.scroll)
    ui.content:SetSize(280, 1)
    ui.scroll:SetScrollChild(ui.content)

    ui.entries = {}

    addonTable.uiFrame = ui
end

-- Escanea inventario
local function scanInventory()
    local found = {}
    for bag = 0, NUM_BAG_SLOTS do
        local slots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, slots do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.itemID and prospectableByID[info.itemID] then
                local name, link = GetItemInfo(info.itemID)
                if not name then
                    if info.hyperlink then
                        link = info.hyperlink
                        name = "item:"..info.itemID
                    else
                        name = "item:"..info.itemID
                        link = "item:"..info.itemID
                    end
                end
                found[info.itemID] = found[info.itemID] or {name = name, link = link, count = 0}
                found[info.itemID].count = found[info.itemID].count + (info.stackCount or 1)
            end
        end
    end
    return found
end

-- Actualiza UI y maneja macros
PH.selectedItems = PH.selectedItems or {}
function PH.UpdateUI()
    if not ui then return end

    -- Limpiar UI existente
    for _, entry in ipairs(ui.entries) do
        if entry.checkbox then entry.checkbox:Hide() end
        if entry.button then entry.button:Hide() end
        if entry.header then entry.header:Hide() end
    end
    wipe(ui.entries)

    local found = scanInventory()
    local itemsByExpansion = {}
    for id, data in pairs(found) do
        local exp = expansionByID[id] or L["Other"]
        itemsByExpansion[exp] = itemsByExpansion[exp] or {}
        table.insert(itemsByExpansion[exp], {id = id, name = data.name, link = data.link, count = data.count})
    end

    -- Orden de expansiones
    local expansionOrder = {L["Classic"], L["The Burning Crusade"], L["Wrath of the Lich King"], L["Cataclysm"], L["Mists of Pandaria"], L["Other"]}

    local y = -5
    for _, exp in ipairs(expansionOrder) do
        local items = itemsByExpansion[exp]
        if items and #items > 0 then
            -- Header de expansión
            local header = ui.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            header:SetPoint("TOPLEFT", ui.content, "TOPLEFT", 5, y)
            header:SetText(exp)
            table.insert(ui.entries, {header = header})  -- guardar header para limpiar después
            y = y - 20

            for _, data in ipairs(items) do
                local entry = {}
                local state = PH.selectedItems[data.id] or {checked = false, showButton = false, macroName = nil}

                -- Checkbox
                local cb = CreateFrame("CheckButton", nil, ui.content, "UICheckButtonTemplate")
                cb:SetPoint("TOPLEFT", ui.content, "TOPLEFT", 20, y)
                local txt = cb:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                txt:SetPoint("LEFT", cb, "RIGHT", 6, 0)
                txt:SetText(data.name.." ("..data.count..")")
                cb.itemLink = data.link
                cb.itemID = data.id
                cb:SetChecked(state.checked)
                entry.checkbox = cb

                -- Botón Prospectar
                local btn = CreateFrame("Button", nil, ui.content, "SecureActionButtonTemplate")
                btn:SetSize(24, 24)
                btn:SetPoint("RIGHT", cb, "RIGHT", 200, 0)
                btn:SetNormalTexture("Interface\\Icons\\inv_misc_gem_bloodgem_01")
                btn:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
                btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
                btn:SetShown(state.showButton)
                entry.button = btn

                if data.count < 5 then
                    cb:SetEnabled(false)
                    cb:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                        GameTooltip:SetText(L["NeedAtLeast5"], 1, 1, 1, 1, true)
                        GameTooltip:Show()
                    end)
                    cb:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                    end)
                else
                    cb:SetScript("OnClick", function(self)
                        local checked = self:GetChecked()
                        state.checked = checked

                        local macroName = state.macroName
                        if not macroName then
                            macroName = "Prospect_"..data.name:gsub("%s+",""):gsub("[^%w]","")
                            state.macroName = macroName
                        end

                        if checked then
                            -- Crear macro y mostrar botón
                            local spellName = GetSpellInfo(31252)
                            local macroText = "/use "..spellName.."\n/use "..data.name

                            if GetMacroIndexByName(macroName) == 0 then
                                CreateMacro(macroName, "inv_misc_gem_bloodgem_01", macroText, false)
                            else
                                EditMacro(GetMacroIndexByName(macroName), macroName, "inv_misc_gem_bloodgem_01", macroText, false)
                            end

                            btn:SetAttribute("type", "macro")
                            btn:SetAttribute("macro", macroName)
                            btn:Show()
                            state.showButton = true
                        else
                            btn:Hide()
                            local idx = GetMacroIndexByName(macroName)
                            if idx > 0 then DeleteMacro(idx) end
                            state.showButton = false
                        end

                        PH.selectedItems[data.id] = state
                    end)
                end

                -- Restaurar estado del botón y macro si estaba activo al refrescar
                if state.showButton and state.macroName then
                    btn:SetAttribute("type", "macro")
                    btn:SetAttribute("macro", state.macroName)
                    btn:Show()
                end

                table.insert(ui.entries, entry)
                y = y - 26
            end
        end
    end

    ui.content:SetHeight(math.max(1, -y + 10))
end

-- Crear UI
CreateUI()

-- Evento para refrescar UI cuando se cargan datos de items
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("GET_ITEM_INFO_RECEIVED")
ev:SetScript("OnEvent", function(_, event, itemID)
    if event == "PLAYER_LOGIN" or (event == "GET_ITEM_INFO_RECEIVED" and prospectableByID[itemID]) then
        PH.UpdateUI()
    end
end)


local invUpdate = CreateFrame("Frame")
invUpdate:RegisterEvent("BAG_UPDATE")
invUpdate:RegisterEvent("BAG_UPDATE_DELAYED")
invUpdate:SetScript("OnEvent", function()
    PH.UpdateUI()
end)

-- Exportar referencias
addonTable.UpdateCheckboxes = PH.UpdateUI
addonTable.ProspectHelper = PH
