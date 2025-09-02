local addonName, addonTable = ...
local L = {}
addonTable.L = L

local locale = GetLocale()

-- Español
if locale == "esES" or locale == "esMX" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Necesitas al menos 5 menas para prospectar"
    L["UI not initialized"] = "UI no inicializada"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Click izquierdo: Abrir/Cerrar interfaz del Prospect Helper, click derecho: mostrar información"
    L["Left click: Toggle UI"] = "Click izquierdo: Abrir/Cerrar interfaz"
    L["Right click: Info"] = "Click derecho: Información"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Otros"

-- Deutsch
elseif locale == "deDE" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Du benötigst mindestens 5 Erze zum Prospektieren"
    L["UI not initialized"] = "UI nicht initialisiert"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Linksklick: UI öffnen/schließen, Rechtsklick: Info anzeigen"
    L["Left click: Toggle UI"] = "Linksklick: UI öffnen/schließen"
    L["Right click: Info"] = "Rechtsklick: Info"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Andere"

-- Français
elseif locale == "frFR" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Vous avez besoin d'au moins 5 minerais pour prospecter"
    L["UI not initialized"] = "UI non initialisée"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Clic gauche: ouvrir/fermer l'UI, clic droit: infos"
    L["Left click: Toggle UI"] = "Clic gauche: ouvrir/fermer l'UI"
    L["Right click: Info"] = "Clic droit: infos"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Autres"

-- Italiano
elseif locale == "itIT" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Hai bisogno di almeno 5 minerali per prospezionare"
    L["UI not initialized"] = "UI non inizializzata"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Click sinistro: apri/chiudi UI, click destro: info"
    L["Left click: Toggle UI"] = "Click sinistro: apri/chiudi UI"
    L["Right click: Info"] = "Click destro: info"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Altri"

-- Português (Brasil)
elseif locale == "ptBR" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Você precisa de pelo menos 5 minérios para prospectar"
    L["UI not initialized"] = "UI não inicializada"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Clique esquerdo: abrir/fechar UI, clique direito: informações"
    L["Left click: Toggle UI"] = "Clique esquerdo: abrir/fechar UI"
    L["Right click: Info"] = "Clique direito: informações"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Outros"

-- Русский
elseif locale == "ruRU" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "Необходимо как минимум 5 руд для просеивания"
    L["UI not initialized"] = "UI не инициализирован"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Левый клик: открыть/закрыть UI, правый клик: информация"
    L["Left click: Toggle UI"] = "Левый клик: открыть/закрыть UI"
    L["Right click: Info"] = "Правый клик: информация"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Другое"

-- 한국어
elseif locale == "koKR" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "보석 가공하려면 광석이 최소 5개 필요합니다"
    L["UI not initialized"] = "UI가 초기화되지 않았습니다"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "왼쪽 클릭: UI 열기/닫기, 오른쪽 클릭: 정보"
    L["Left click: Toggle UI"] = "왼쪽 클릭: UI 열기/닫기"
    L["Right click: Info"] = "오른쪽 클릭: 정보"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "기타"

-- 简体中文
elseif locale == "zhCN" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "需要至少5个矿石才能勘探"
    L["UI not initialized"] = "界面未初始化"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "左键点击: 打开/关闭界面，右键点击: 信息"
    L["Left click: Toggle UI"] = "左键点击: 打开/关闭界面"
    L["Right click: Info"] = "右键点击: 信息"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "其他"

-- 繁體中文
elseif locale == "zhTW" then
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "需要至少5個礦石才能勘探"
    L["UI not initialized"] = "介面未初始化"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "左鍵點擊: 開啟/關閉界面，右鍵點擊: 資訊"
    L["Left click: Toggle UI"] = "左鍵點擊: 開啟/關閉界面"
    L["Right click: Info"] = "右鍵點擊: 資訊"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "其他"

-- Default: Inglés
else
    L["Prospect Helper"] = "|cffd597ffProspect Helper|r"
    L["NeedAtLeast5"] = "You need at least 5 ores to prospect"
    L["UI not initialized"] = "UI not initialized"
    L["Left click to toggle the Prospect Helper UI, right click for this info."] = "Left click to toggle the Prospect Helper UI, right click for this info."
    L["Left click: Toggle UI"] = "Left click: Toggle UI"
    L["Right click: Info"] = "Right click: Info"
    L["Classic"] = "Classic"
    L["The Burning Crusade"] = "The Burning Crusade"
    L["Wrath of the Lich King"] = "Wrath of the Lich King"
    L["Cataclysm"] = "Cataclysm"
    L["Mists of Pandaria"] = "Mists of Pandaria"
    L["Other"] = "Other"
end