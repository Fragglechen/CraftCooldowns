local addonName = "CraftCooldowns"

local CCD = CreateFrame("Frame")
_G.CraftCooldowns = CCD

local locale = GetLocale and GetLocale() or "enUS"

local LOCALIZED_PROFESSIONS = {
  Alchemy = {
    enUS = "Alchemy",
    deDE = "Alchimie",
  },
  Tailoring = {
    enUS = "Tailoring",
    deDE = "Schneiderei",
  },
}

local KNOWN_COOLDOWNS = {
  Alchemy = {
    { id = "transmute_iron_to_gold", spellId = 11479, names = { enUS = "Transmute: Iron to Gold", deDE = "Transmutieren: Eisen in Gold" } },
    { id = "transmute_mithril_to_truesilver", spellId = 11480, names = { enUS = "Transmute: Mithril to Truesilver", deDE = "Transmutieren: Mithril in Echtsilber" } },
    { id = "transmute_arcanite", spellId = 17187, names = { enUS = "Transmute: Arcanite", deDE = "Transmutieren: Arkanit" } },
    { id = "transmute_air_to_fire", spellId = 17559, names = { enUS = "Transmute: Air to Fire", deDE = "Transmutieren: Luft zu Feuer" } },
    { id = "transmute_fire_to_earth", spellId = 17560, names = { enUS = "Transmute: Fire to Earth", deDE = "Transmutieren: Feuer zu Erde" } },
    { id = "transmute_earth_to_water", spellId = 17561, names = { enUS = "Transmute: Earth to Water", deDE = "Transmutieren: Erde zu Wasser" } },
    { id = "transmute_water_to_air", spellId = 17562, names = { enUS = "Transmute: Water to Air", deDE = "Transmutieren: Wasser zu Luft" } },
    { id = "transmute_undeath_to_water", spellId = 17563, names = { enUS = "Transmute: Undeath to Water", deDE = "Transmutieren: Untod zu Wasser" } },
    { id = "transmute_water_to_undeath", spellId = 17564, names = { enUS = "Transmute: Water to Undeath", deDE = "Transmutieren: Wasser zu Untod" } },
    { id = "transmute_life_to_earth", spellId = 17565, names = { enUS = "Transmute: Life to Earth", deDE = "Transmutieren: Leben zu Erde" } },
    { id = "transmute_earth_to_life", spellId = 17566, names = { enUS = "Transmute: Earth to Life", deDE = "Transmutieren: Erde zu Leben" } },
    { id = "transmute_elemental_fire", spellId = 25146, names = { enUS = "Transmute: Elemental Fire", deDE = "Elementarfeuer transmutieren" } },
  },
  Tailoring = {
    { id = "mooncloth", spellId = 18560, names = { enUS = "Mooncloth", deDE = "Mondstoff" } },
  },
}

local PROFESSIONS_WITH_COOLDOWNS = {
  "Alchemy",
  "Tailoring",
}

local RECIPE_BY_ID = {}
for professionKey, recipes in pairs(KNOWN_COOLDOWNS) do
  for _, recipeDef in ipairs(recipes) do
    recipeDef.profession = professionKey
    RECIPE_BY_ID[recipeDef.id] = recipeDef
  end
end

local findVisibleTradeSkillIndex
local findVisibleCraftIndex
local isTradeSkillWindowVisible
local isCraftWindowVisible
local processPendingCraftRequest
local tryExpandProfessionHeaders
local tryATSWCraft
local isVisible
local resetATSWState
local executeTradeSkillCraft
local executeCraftCraft

local function lowercase(value)
  if not value then
    return nil
  end

  return string.lower(value)
end

local function trim(value)
  if not value then
    return value
  end

  value = string.gsub(value, "^%s+", "")
  value = string.gsub(value, "%s+$", "")
  return value
end

local function getCharKey()
  local playerName = UnitName("player") or "Unknown"
  local realmName = GetRealmName and GetRealmName() or ""

  if realmName and realmName ~= "" then
    return playerName .. " - " .. realmName
  end

  return playerName
end

local function formatDuration(seconds)
  seconds = math.max(0, math.floor(seconds or 0))

  local days = math.floor(seconds / 86400)
  local hours = math.floor(math.mod(seconds, 86400) / 3600)
  local minutes = math.floor(math.mod(seconds, 3600) / 60)
  local secs = math.mod(seconds, 60)

  if days > 0 then
    if hours > 0 then
      return string.format("%dt %dh", days, hours)
    end
    return string.format("%dt", days)
  end

  if hours > 0 then
    if minutes > 0 then
      return string.format("%dh %dm", hours, minutes)
    end
    return string.format("%dh", hours)
  end

  if minutes > 0 then
    return string.format("%dm %02ds", minutes, secs)
  end

  return string.format("%ds", secs)
end

local function getProfessionDisplayName(professionKey)
  local data = LOCALIZED_PROFESSIONS[professionKey]
  if not data then
    return professionKey
  end

  return data[locale] or data.enUS or professionKey
end

local function getRecipeDisplayName(recipeDef)
  return recipeDef.names[locale] or recipeDef.names.enUS or recipeDef.id
end

local function printMessage(msg)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("|cff7fd4ff[CraftCooldowns]|r " .. tostring(msg))
  end
end

local function printCombatMessage(msg, r, g, b)
  if UIErrorsFrame and UIErrorsFrame.AddMessage then
    UIErrorsFrame:AddMessage(tostring(msg), r or 1, g or 0.2, b or 0.2, 1.0)
  end
end

local function notifyMessage(msg, r, g, b)
  printMessage(msg)
  printCombatMessage(msg, r, g, b)
end

local function getItemIdFromLink(link)
  if not link then
    return nil
  end

  local _, _, itemId = string.find(link, "item:(%d+):")
  return tonumber(itemId)
end
 
local function getItemNameFromLink(link)
  if not link then
    return nil
  end

  local _, _, itemName = string.find(link, "%[(.+)%]")
  return itemName
end

local function captureTradeSkillReagents(index)
  local reagents = {}

  for reagentIndex = 1, (GetTradeSkillNumReagents and GetTradeSkillNumReagents(index) or 0) do
    local reagentName, _, reagentRequired = GetTradeSkillReagentInfo(index, reagentIndex)
    local reagentLink = GetTradeSkillReagentItemLink(index, reagentIndex)
    table.insert(reagents, {
      name = reagentName or getItemNameFromLink(reagentLink),
      link = reagentLink,
      id = getItemIdFromLink(reagentLink),
      required = reagentRequired or 0,
    })
  end

  return reagents
end

local function captureCraftReagents(index)
  local reagents = {}

  for reagentIndex = 1, (GetCraftNumReagents and GetCraftNumReagents(index) or 0) do
    local reagentName, _, reagentRequired = GetCraftReagentInfo(index, reagentIndex)
    local reagentLink = GetCraftReagentItemLink(index, reagentIndex)
    table.insert(reagents, {
      name = reagentName or getItemNameFromLink(reagentLink),
      link = reagentLink,
      id = getItemIdFromLink(reagentLink),
      required = reagentRequired or 0,
    })
  end

  return reagents
end

local function getReagentName(reagent)
  if not reagent then
    return "?"
  end

  if reagent.name and reagent.name ~= "" then
    return reagent.name
  end

  if reagent.link then
    return getItemNameFromLink(reagent.link) or "?"
  end

  return "?"
end

local function getProfessionKeyByLocalizedName(name)
  name = trim(name)
  if not name then
    return nil
  end

  for professionKey, localized in pairs(LOCALIZED_PROFESSIONS) do
    if name == professionKey or name == localized.enUS or name == localized.deDE then
      return professionKey
    end
  end

  return nil
end

local function recipeMatchesName(recipeDef, recipeName)
  local loweredName = lowercase(trim(recipeName))
  if not loweredName then
    return nil
  end

  for _, localizedName in pairs(recipeDef.names) do
    if loweredName == lowercase(localizedName) then
      return true
    end
  end

  return nil
end

local function initializeDatabase()
  CraftCooldownsDB = CraftCooldownsDB or {}
  CraftCooldownsDB.characters = CraftCooldownsDB.characters or {}

  local charKey = getCharKey()
  CraftCooldownsDB.characters[charKey] = CraftCooldownsDB.characters[charKey] or {}

  CCD.db = CraftCooldownsDB.characters[charKey]
  CCD.db.frame = CCD.db.frame or { point = "CENTER", relativePoint = "CENTER", x = 0, y = 0 }
  CCD.db.minimap = CCD.db.minimap or { angle = 45 }
  CCD.db.recipes = CCD.db.recipes or {}
  CCD.db.professions = CCD.db.professions or {}
  CCD.db.scanned = CCD.db.scanned or {}
  CCD.db.bank = CCD.db.bank or { counts = {}, lastUpdate = 0 }
  CCD.db.visible = CCD.db.visible

  if CCD.db.visible == nil then
    CCD.db.visible = true
  end
end

local function buildBagCounts()
  local counts = {}

  for bag = 0, 4 do
    for slot = 1, (GetContainerNumSlots and GetContainerNumSlots(bag) or 0) do
      local itemLink = GetContainerItemLink(bag, slot)
      if itemLink then
        local itemId = getItemIdFromLink(itemLink)
        local itemName = getItemNameFromLink(itemLink)
        local _, itemCount = GetContainerItemInfo(bag, slot)
        itemCount = itemCount or 1

        if itemId then
          counts[itemId] = (counts[itemId] or 0) + itemCount
        end

        if itemName then
          counts[itemName] = (counts[itemName] or 0) + itemCount
        end
      end
    end
  end

  return counts
end

local function saveBankSnapshot()
  if not CCD.db then
    return
  end

  local counts = {}

  for slot = 1, 24 do
    local itemLink = GetContainerItemLink(BANK_CONTAINER, slot)
    if itemLink then
      local itemId = getItemIdFromLink(itemLink)
      local itemName = getItemNameFromLink(itemLink)
      local _, itemCount = GetContainerItemInfo(BANK_CONTAINER, slot)
      itemCount = itemCount or 1

      if itemId then
        counts[itemId] = (counts[itemId] or 0) + itemCount
      end

      if itemName then
        counts[itemName] = (counts[itemName] or 0) + itemCount
      end
    end
  end

  for bag = 5, 10 do
    for slot = 1, (GetContainerNumSlots and GetContainerNumSlots(bag) or 0) do
      local itemLink = GetContainerItemLink(bag, slot)
      if itemLink then
        local itemId = getItemIdFromLink(itemLink)
        local itemName = getItemNameFromLink(itemLink)
        local _, itemCount = GetContainerItemInfo(bag, slot)
        itemCount = itemCount or 1

        if itemId then
          counts[itemId] = (counts[itemId] or 0) + itemCount
        end

        if itemName then
          counts[itemName] = (counts[itemName] or 0) + itemCount
        end
      end
    end
  end

  CCD.db.bank.counts = counts
  CCD.db.bank.lastUpdate = time()
end

local function getStoredBankCount(reagent)
  if not CCD.db or not CCD.db.bank or not CCD.db.bank.counts then
    return 0
  end

  if reagent.id and CCD.db.bank.counts[reagent.id] then
    return CCD.db.bank.counts[reagent.id]
  end

  if reagent.name and CCD.db.bank.counts[reagent.name] then
    return CCD.db.bank.counts[reagent.name]
  end

  return 0
end

local function getBagCount(bagCounts, reagent)
  if not reagent then
    return 0
  end

  if reagent.id and bagCounts[reagent.id] then
    return bagCounts[reagent.id]
  end

  if reagent.name and bagCounts[reagent.name] then
    return bagCounts[reagent.name]
  end

  return 0
end

local function updateProfessionList()
  if not CCD.db then
    return
  end

  local known = {}
  local count = GetNumSkillLines and GetNumSkillLines() or 0

  for index = 1, count do
    local skillName, isHeader = GetSkillLineInfo(index)
    if skillName and not isHeader then
      local professionKey = getProfessionKeyByLocalizedName(skillName)
      if professionKey and KNOWN_COOLDOWNS[professionKey] then
        known[professionKey] = true
      end
    end
  end

  CCD.db.professions = known
end

local function saveRecipeCooldown(professionKey, recipeDef, cooldown, reagents)
  local recipeState = CCD.db.recipes[recipeDef.id] or {}
  recipeState.profession = professionKey
  recipeState.learned = true
  recipeState.name = getRecipeDisplayName(recipeDef)
  recipeState.lastSeen = time()
  recipeState.reagents = reagents or recipeState.reagents or {}

  cooldown = tonumber(cooldown)
  if cooldown and cooldown > 0 then
    recipeState.expiresAt = time() + cooldown
  else
    recipeState.expiresAt = 0
  end

  CCD.db.recipes[recipeDef.id] = recipeState
end

local function markMissingRecipesAsUnknown(professionKey, foundRecipes)
  local definitions = KNOWN_COOLDOWNS[professionKey] or {}

  for _, recipeDef in ipairs(definitions) do
    if not foundRecipes[recipeDef.id] then
      local recipeState = CCD.db.recipes[recipeDef.id] or {}
      recipeState.profession = professionKey
      recipeState.learned = false
      recipeState.name = getRecipeDisplayName(recipeDef)
      CCD.db.recipes[recipeDef.id] = recipeState
    end
  end
end

local function scanTradeSkillFrame()
  if not GetTradeSkillLine or not GetNumTradeSkills then
    return
  end

  if CCD.tradeSkillScanInProgress then
    return
  end

  CCD.tradeSkillScanInProgress = true

  local professionName = GetTradeSkillLine()
  local professionKey = getProfessionKeyByLocalizedName(professionName)
  if not professionKey or not KNOWN_COOLDOWNS[professionKey] then
    CCD.tradeSkillScanInProgress = nil
    return
  end

  if CCD.pendingCraftRecipeId and ExpandTradeSkillSubClass then
    local pendingRecipe = RECIPE_BY_ID[CCD.pendingCraftRecipeId]
    if pendingRecipe and pendingRecipe.profession == professionKey then
      ExpandTradeSkillSubClass(0)
    end
  end

  local foundRecipes = {}
  local recipeDefinitions = KNOWN_COOLDOWNS[professionKey]

  for index = 1, GetNumTradeSkills() do
    local recipeName, recipeType = GetTradeSkillInfo(index)
    if recipeType ~= "header" then
      for _, recipeDef in ipairs(recipeDefinitions) do
        if recipeMatchesName(recipeDef, recipeName) then
          foundRecipes[recipeDef.id] = true
          saveRecipeCooldown(professionKey, recipeDef, GetTradeSkillCooldown(index), captureTradeSkillReagents(index))
          break
        end
      end
    end
  end

  markMissingRecipesAsUnknown(professionKey, foundRecipes)
  CCD.db.scanned[professionKey] = time()
  CCD.tradeSkillScanInProgress = nil

  if CCD.pendingCraftRecipeId then
    local recipeDef = RECIPE_BY_ID[CCD.pendingCraftRecipeId]
    local recipeIndex = recipeDef and findVisibleTradeSkillIndex(recipeDef) or nil
    if recipeIndex then
      executeTradeSkillCraft(recipeIndex)
      CCD.pendingCraftRecipeId = nil
      CCD.pendingCraftOpenRecipeId = nil
      CCD.pendingCraftDeadline = nil
      CCD.pendingCraftNextAttempt = nil
    end
  end
end

local function scanCraftFrame()
  if not GetCraftName or not GetNumCrafts then
    return
  end

  if CCD.craftScanInProgress then
    return
  end

  CCD.craftScanInProgress = true

  local professionName = GetCraftDisplaySkillLine and GetCraftDisplaySkillLine() or GetCraftName()
  local professionKey = getProfessionKeyByLocalizedName(professionName)
  if not professionKey or not KNOWN_COOLDOWNS[professionKey] then
    CCD.craftScanInProgress = nil
    return
  end

  if CCD.pendingCraftRecipeId and ExpandCraftSkillLine then
    local pendingRecipe = RECIPE_BY_ID[CCD.pendingCraftRecipeId]
    if pendingRecipe and pendingRecipe.profession == professionKey then
      ExpandCraftSkillLine(0)
    end
  end

  local foundRecipes = {}
  local recipeDefinitions = KNOWN_COOLDOWNS[professionKey]

  for index = 1, GetNumCrafts() do
    local recipeName, _, recipeType = GetCraftInfo(index)
    if recipeType ~= "header" then
      for _, recipeDef in ipairs(recipeDefinitions) do
        if recipeMatchesName(recipeDef, recipeName) then
          foundRecipes[recipeDef.id] = true
          saveRecipeCooldown(professionKey, recipeDef, GetCraftCooldown and GetCraftCooldown(index), captureCraftReagents(index))
          break
        end
      end
    end
  end

  markMissingRecipesAsUnknown(professionKey, foundRecipes)
  CCD.db.scanned[professionKey] = time()
  CCD.craftScanInProgress = nil

  if CCD.pendingCraftRecipeId then
    local recipeDef = RECIPE_BY_ID[CCD.pendingCraftRecipeId]
    local recipeIndex = recipeDef and findVisibleCraftIndex(recipeDef) or nil
    if recipeIndex then
      executeCraftCraft(recipeIndex)
      CCD.pendingCraftRecipeId = nil
      CCD.pendingCraftOpenRecipeId = nil
      CCD.pendingCraftDeadline = nil
      CCD.pendingCraftNextAttempt = nil
    end
  end
end

findVisibleTradeSkillIndex = function(recipeDef)
  if not recipeDef or not GetTradeSkillLine or not GetNumTradeSkills then
    return nil
  end

  if not isTradeSkillWindowVisible() then
    return nil
  end

  local professionKey = getProfessionKeyByLocalizedName(GetTradeSkillLine())
  if professionKey ~= recipeDef.profession then
    return nil
  end

  for index = 1, GetNumTradeSkills() do
    local recipeName, recipeType = GetTradeSkillInfo(index)
    if recipeType ~= "header" and recipeMatchesName(recipeDef, recipeName) then
      return index
    end
  end

  return nil
end

findVisibleCraftIndex = function(recipeDef)
  if not recipeDef or not GetCraftName or not GetNumCrafts then
    return nil
  end

  if not isCraftWindowVisible() then
    return nil
  end

  local professionName = GetCraftDisplaySkillLine and GetCraftDisplaySkillLine() or GetCraftName()
  local professionKey = getProfessionKeyByLocalizedName(professionName)
  if professionKey ~= recipeDef.profession then
    return nil
  end

  for index = 1, GetNumCrafts() do
    local recipeName, _, recipeType = GetCraftInfo(index)
    if recipeType ~= "header" and recipeMatchesName(recipeDef, recipeName) then
      return index
    end
  end

  return nil
end

local function isRecipeProfessionOpen(recipeDef)
  if not recipeDef then
    return nil
  end

  if isTradeSkillWindowVisible() and GetTradeSkillLine and GetNumTradeSkills then
    local tradeSkillProfession = getProfessionKeyByLocalizedName(GetTradeSkillLine())
    if tradeSkillProfession == recipeDef.profession then
      return true
    end
  end

  if isCraftWindowVisible() and GetCraftName and GetNumCrafts then
    local craftProfession = getProfessionKeyByLocalizedName(GetCraftDisplaySkillLine and GetCraftDisplaySkillLine() or GetCraftName())
    if craftProfession == recipeDef.profession then
      return true
    end
  end

  return nil
end

executeTradeSkillCraft = function(index)
  if not index or not DoTradeSkill then
    return nil
  end

  if SelectTradeSkill then
    SelectTradeSkill(index)
  end

  DoTradeSkill(index, 1)
  return true
end

executeCraftCraft = function(index)
  if not index or not DoCraft then
    return nil
  end

  if SelectCraft then
    SelectCraft(index)
  end

  DoCraft(index)
  return true
end

local function openProfession(recipeDef)
  if not recipeDef or not CastSpellByName then
    return nil
  end

  CastSpellByName(getProfessionDisplayName(recipeDef.profession))
  return true
end

tryExpandProfessionHeaders = function(recipeDef)
  if not recipeDef then
    return nil
  end

  if isTradeSkillWindowVisible() and GetTradeSkillLine and ExpandTradeSkillSubClass then
    local professionKey = getProfessionKeyByLocalizedName(GetTradeSkillLine())
    if professionKey == recipeDef.profession then
      ExpandTradeSkillSubClass(0)
      return true
    end
  end

  if isCraftWindowVisible() and GetCraftName and ExpandCraftSkillLine then
    local professionKey = getProfessionKeyByLocalizedName(GetCraftDisplaySkillLine and GetCraftDisplaySkillLine() or GetCraftName())
    if professionKey == recipeDef.profession then
      ExpandCraftSkillLine(0)
      return true
    end
  end

  return nil
end

isVisible = function(frame)
  return frame and frame.IsShown and frame:IsShown()
end

isTradeSkillWindowVisible = function()
  if isVisible(_G.ATSWFrame) then
    return true
  end

  if isVisible(_G.TradeSkillFrame) then
    return true
  end

  return false
end

isCraftWindowVisible = function()
  if isVisible(_G.CraftFrame) then
    return true
  end

  return false
end

resetATSWState = function()
  if not isVisible(_G.ATSWFrame) then
    return nil
  end

  if _G.ATSWSearchBox and _G.ATSWSearchBox.SetText then
    _G.ATSWSearchBox:SetText("")
    if _G.ATSWSearchBox.ClearFocus then
      _G.ATSWSearchBox:ClearFocus()
    end
  end

  if SetTradeSkillSubClassFilter then
    SetTradeSkillSubClassFilter(0, 1, 1)
  end

  if SetTradeSkillInvSlotFilter then
    SetTradeSkillInvSlotFilter(0, 1, 1)
  end

  if ExpandTradeSkillSubClass then
    ExpandTradeSkillSubClass(0)
  end

  if _G.ATSW_GetRecipesSorted then
    _G.ATSW_GetRecipesSorted(true)
  end

  return true
end

tryATSWCraft = function(recipeDef)
  if not recipeDef or not isVisible(_G.ATSWFrame) then
    return nil
  end

  local localizedName = getRecipeDisplayName(recipeDef)
  local englishName = recipeDef.names and recipeDef.names.enUS or nil
  local function hasATSWRecipe(name)
    if not name or name == "" then
      return nil
    end

    if _G.ATSW_GetPositionFromGame and _G.ATSW_GetPositionFromGame(name) then
      return true
    end

    if _G.ATSW_GetRecipePosition and _G.ATSW_GetRecipePosition(name) then
      return true
    end

    return nil
  end

  local function resolveATSWRecipeName()
    if hasATSWRecipe(localizedName) then
      return localizedName
    end

    if englishName and englishName ~= localizedName and hasATSWRecipe(englishName) then
      return englishName
    end

    return localizedName or englishName
  end

  resetATSWState()

  local recipeName = resolveATSWRecipeName()
  if not recipeName or recipeName == "" then
    return nil
  end

  if _G.ATSW_ShowRecipe then
    _G.ATSW_ShowRecipe(recipeName)
  end

  if _G.ATSW_SelectRecipe then
    _G.ATSW_SelectRecipe(recipeName)
  end

  if _G.ATSW_ShowSelection then
    _G.ATSW_ShowSelection()
  end

  if _G.ATSWAmountBox and _G.ATSWAmountBox.SetText then
    _G.ATSWAmountBox:SetText("1")
  end

  if _G.ATSW_Craft and hasATSWRecipe(recipeName) then
    _G.ATSW_Craft(recipeName, 1)
    return true
  end

  if _G.ATSWCreateButton_OnClick then
    _G.ATSWCreateButton_OnClick()
    return true
  end

  return nil
end

local function checkRecipeMaterials(recipeId)
  local recipeState = CCD.db.recipes[recipeId]
  local reagents = recipeState and recipeState.reagents or nil
  local bagCounts = buildBagCounts()
  local result = {
    canCraftFromBags = true,
    hasEnoughTotal = true,
    lines = {},
  }

  if not reagents or table.getn(reagents) == 0 then
    return result
  end

  for _, reagent in ipairs(reagents) do
    local required = reagent.required or 0
    local inBags = getBagCount(bagCounts, reagent)
    local inBank = getStoredBankCount(reagent)
    local total = inBags + inBank
    local reagentName = getReagentName(reagent)

    if inBags < required then
      result.canCraftFromBags = nil
    end

    if total < required then
      result.hasEnoughTotal = nil
      table.insert(result.lines, string.format("%s: %d/%d (Taschen %d, Bank %d)", reagentName, total, required, inBags, inBank))
    elseif inBags < required then
      table.insert(result.lines, string.format("%s: Taschen %d/%d, Bank %d", reagentName, inBags, required, inBank))
    end
  end

  return result
end

local function printMaterialMessage(recipeId, materialState)
  local recipeState = CCD.db.recipes[recipeId]
  local recipeName = recipeState and recipeState.name or recipeId
  local snapshotMissing = not (CCD.db.bank and CCD.db.bank.lastUpdate and CCD.db.bank.lastUpdate > 0)

  if materialState.hasEnoughTotal and not materialState.canCraftFromBags then
    printMessage((locale == "deDE" and "Materialien fuer " or "Materials for ") .. recipeName ..
      (locale == "deDE" and " sind teilweise auf der Bank:" or " are partially in the bank:"))
  else
    printMessage((locale == "deDE" and "Fehlende Materialien fuer " or "Missing materials for ") .. recipeName .. ":")
  end

  local combatLines = {}
  for _, line in ipairs(materialState.lines or {}) do
    printMessage(" - " .. line)
    table.insert(combatLines, line)
  end

  if table.getn(combatLines) > 0 then
    for _, line in ipairs(combatLines) do
      printCombatMessage(line, materialState.hasEnoughTotal and 1.0 or 1.0, materialState.hasEnoughTotal and 0.82 or 0.5, 0.1)
    end
  end

  if snapshotMissing then
    local snapshotMessage = locale == "deDE" and "Kein Bank-Snapshot. Einmal Bank oeffnen." or "No bank snapshot yet. Open bank once."
    printMessage(snapshotMessage)
    printCombatMessage(snapshotMessage, 1.0, 0.1, 0.1)
  end
end

local function tryCraftRecipe(recipeId)
  local recipeDef = RECIPE_BY_ID[recipeId]
  if not recipeDef then
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local recipeState = CCD.db.recipes[recipeId]
  if not recipeState or not recipeState.learned then
    notifyMessage(locale == "deDE" and "Rezept ist nicht gelernt." or "Recipe is not learned.", 1.0, 0.1, 0.1)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  if recipeState.expiresAt and recipeState.expiresAt > time() then
    notifyMessage(locale == "deDE" and "Cooldown ist noch nicht bereit." or "Cooldown is not ready yet.", 1.0, 0.1, 0.1)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local materialState = checkRecipeMaterials(recipeId)
  if not materialState.canCraftFromBags then
    printMaterialMessage(recipeId, materialState)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local tradeSkillIndex = findVisibleTradeSkillIndex(recipeDef)
  if tradeSkillIndex then
    executeTradeSkillCraft(tradeSkillIndex)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local craftIndex = findVisibleCraftIndex(recipeDef)
  if craftIndex then
    executeCraftCraft(craftIndex)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  if isRecipeProfessionOpen(recipeDef) then
    tryExpandProfessionHeaders(recipeDef)

    tradeSkillIndex = findVisibleTradeSkillIndex(recipeDef)
    if tradeSkillIndex then
      executeTradeSkillCraft(tradeSkillIndex)
      CCD.pendingCraftRecipeId = nil
      CCD.pendingCraftOpenRecipeId = nil
      CCD.pendingCraftDeadline = nil
      CCD.pendingCraftNextAttempt = nil
      CCD.pendingCraftExpanded = nil
      return
    end

    craftIndex = findVisibleCraftIndex(recipeDef)
    if craftIndex then
      executeCraftCraft(craftIndex)
      CCD.pendingCraftRecipeId = nil
      CCD.pendingCraftOpenRecipeId = nil
      CCD.pendingCraftDeadline = nil
      CCD.pendingCraftNextAttempt = nil
      CCD.pendingCraftExpanded = nil
      return
    end

    notifyMessage(locale == "deDE" and "Rezept im offenen Berufsfenster nicht sichtbar." or "Recipe is not visible in the open profession window.", 1.0, 0.1, 0.1)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  CCD.pendingCraftRecipeId = recipeId
  CCD.pendingCraftOpenRecipeId = recipeId
  CCD.pendingCraftExpanded = nil
  CCD.pendingCraftDeadline = GetTime() + 8
  CCD.pendingCraftNextAttempt = 0
  openProfession(recipeDef)
end

processPendingCraftRequest = function()
  if not CCD.pendingCraftRecipeId then
    return
  end

  local now = GetTime and GetTime() or 0
  if CCD.pendingCraftDeadline and now > CCD.pendingCraftDeadline then
    local reason = locale == "deDE" and "Automatischer Craft konnte nicht gestartet werden." or "Automatic craft could not be started."
    if isVisible(_G.ATSWFrame) and _G.ATSW_RecipeSelected then
      local selectedName = _G.ATSW_RecipeSelected()
      if not selectedName or selectedName == "" then
        reason = locale == "deDE" and "ATSW konnte das Rezept nicht auswaehlen." or "ATSW could not select the recipe."
      else
        reason = (locale == "deDE" and "ATSW hat ein anderes Rezept ausgewaehlt: " or "ATSW selected a different recipe: ") .. selectedName
      end
    end
    notifyMessage(reason, 1.0, 0.1, 0.1)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  if CCD.pendingCraftNextAttempt and now < CCD.pendingCraftNextAttempt then
    return
  end

  CCD.pendingCraftNextAttempt = now + 0.2

  local recipeDef = RECIPE_BY_ID[CCD.pendingCraftRecipeId]
  if not recipeDef then
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  if not isRecipeProfessionOpen(recipeDef) then
    return
  end

  if not CCD.pendingCraftExpanded then
    CCD.pendingCraftExpanded = tryExpandProfessionHeaders(recipeDef)
  end

  if tryATSWCraft(recipeDef) then
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local tradeSkillIndex = findVisibleTradeSkillIndex(recipeDef)
  if tradeSkillIndex then
    executeTradeSkillCraft(tradeSkillIndex)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  local craftIndex = findVisibleCraftIndex(recipeDef)
  if craftIndex then
    executeCraftCraft(craftIndex)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end
end

local function getRowTextColor(isHeader, isHint, isReady, isCooldown)
  if isHeader then
    return 1.0, 0.82, 0.0
  end

  if isHint then
    return 0.7, 0.7, 0.7
  end

  if isCooldown then
    return 1.0, 0.25, 0.25
  end

  if isReady then
    return 0.35, 1.0, 0.35
  end

  return 1.0, 1.0, 1.0
end

local function buildEntries()
  local entries = {}
  local hasAnyProfession = nil

  for _, professionKey in ipairs(PROFESSIONS_WITH_COOLDOWNS) do
    if CCD.db.professions[professionKey] then
      hasAnyProfession = true
      table.insert(entries, {
        label = getProfessionDisplayName(professionKey),
        status = "",
        isHeader = true,
      })

      if not CCD.db.scanned[professionKey] then
        table.insert(entries, {
          label = locale == "deDE" and "Beruf einmal oeffnen, um Rezepte zu scannen" or "Open profession once to scan recipes",
          status = "",
          isHint = true,
        })
      else
        local learnedAny = nil
        for _, recipeDef in ipairs(KNOWN_COOLDOWNS[professionKey]) do
          local recipeState = CCD.db.recipes[recipeDef.id]
          if recipeState and recipeState.learned then
            learnedAny = true

            local remaining = 0
            if recipeState.expiresAt and recipeState.expiresAt > time() then
              remaining = recipeState.expiresAt - time()
            end

            table.insert(entries, {
              label = "  " .. getRecipeDisplayName(recipeDef),
              status = remaining > 0 and formatDuration(remaining) or (locale == "deDE" and "Frei" or "Ready"),
              isReady = remaining <= 0,
              isCooldown = remaining > 0,
              recipeId = recipeDef.id,
            })
          end
        end

        if not learnedAny then
          table.insert(entries, {
            label = locale == "deDE" and "Kein gelerntes Cooldown-Rezept gefunden" or "No learned cooldown recipe found",
            status = "",
            isHint = true,
          })
        end
      end
    end
  end

  if not hasAnyProfession then
    table.insert(entries, {
      label = locale == "deDE" and "Keine Berufe mit bekannten Craft-Cooldowns gefunden" or "No professions with known craft cooldowns found",
      status = "",
      isHint = true,
    })
  end

  return entries
end

local function ensureRows(count)
  CCD.rows = CCD.rows or {}

  while table.getn(CCD.rows) < count do
    local rowIndex = table.getn(CCD.rows) + 1
    local row = CreateFrame("Frame", nil, CCD.frame)
    row:SetHeight(18)
    row:SetPoint("TOPLEFT", CCD.frame, "TOPLEFT", 12, -28 - ((rowIndex - 1) * 18))
    row:SetPoint("TOPRIGHT", CCD.frame, "TOPRIGHT", -12, -28 - ((rowIndex - 1) * 18))

    row.left = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.left:SetPoint("LEFT", row, "LEFT", 0, 0)
    row.left:SetWidth(118)
    row.left:SetJustifyH("LEFT")

    row.right = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.right:SetPoint("RIGHT", row, "RIGHT", -28, 0)
    row.right:SetWidth(56)
    row.right:SetJustifyH("RIGHT")

    row.button = CreateFrame("Button", nil, row)
    row.button:SetWidth(16)
    row.button:SetHeight(16)
    row.button:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    row.button:SetNormalTexture("Interface\\Icons\\INV_Hammer_09")
    row.button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    row.button:GetNormalTexture():SetAllPoints()
    row.button:SetScript("OnClick", function()
      local recipeId = this.recipeId
      if recipeId then
        tryCraftRecipe(recipeId)
      end
    end)
    row.button:SetScript("OnEnter", function()
      GameTooltip:SetOwner(this, "ANCHOR_LEFT")
      GameTooltip:AddLine(locale == "deDE" and "Jetzt herstellen" or "Craft now")
      GameTooltip:Show()
    end)
    row.button:SetScript("OnLeave", function()
      GameTooltip:Hide()
    end)
    row.button:Hide()

    table.insert(CCD.rows, row)
  end
end

local function updateFrameWidth(entries)
  if not CCD.frame then
    return
  end

  local longestWidth = 0
  for _, entry in ipairs(entries or {}) do
    if entry and entry.label then
      CCD.frame.measureFS:SetText(entry.label)
      local width = CCD.frame.measureFS:GetStringWidth() or 0
      if width > longestWidth then
        longestWidth = width
      end
    end
  end

  local targetWidth = math.max(220, math.min(360, math.ceil(longestWidth) + 110))
  CCD.frame:SetWidth(targetWidth)

  for _, row in ipairs(CCD.rows or {}) do
    row.left:SetWidth(targetWidth - 102)
  end
end

local function refreshFrame()
  if not CCD.frame then
    return
  end

  local entries = buildEntries()
  ensureRows(table.getn(entries))
  updateFrameWidth(entries)

  for index, row in ipairs(CCD.rows) do
    local entry = entries[index]
    if entry then
      local leftR, leftG, leftB = getRowTextColor(entry.isHeader, entry.isHint, nil, nil)
      local rightR, rightG, rightB = getRowTextColor(nil, entry.isHint, entry.isReady, entry.isCooldown)

      row.left:SetText(entry.label or "")
      row.right:SetText(entry.status or "")
      row.left:SetTextColor(leftR, leftG, leftB)
      row.right:SetTextColor(rightR, rightG, rightB)

      if entry.recipeId and entry.isReady then
        row.button.recipeId = entry.recipeId
        row.button:Show()
      else
        row.button.recipeId = nil
        row.button:Hide()
      end

      row:Show()
    else
      row.button.recipeId = nil
      row.button:Hide()
      row:Hide()
    end
  end

  local height = math.max(70, 40 + (table.getn(entries) * 18) + 14)
  CCD.frame:SetHeight(height)
end

local function saveFramePosition()
  local point, _, relativePoint, xOfs, yOfs = CCD.frame:GetPoint()
  CCD.db.frame.point = point
  CCD.db.frame.relativePoint = relativePoint
  CCD.db.frame.x = xOfs
  CCD.db.frame.y = yOfs
end

local function createFrame()
  if CCD.frame then
    return
  end

  local frame = CreateFrame("Frame", "CraftCooldownsFrame", UIParent)
  CCD.frame = frame

  frame:SetWidth(220)
  frame:SetHeight(140)
  frame:SetClampedToScreen(true)
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function()
    this:StartMoving()
  end)
  frame:SetScript("OnDragStop", function()
    this:StopMovingOrSizing()
    saveFramePosition()
  end)
  frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
  })
  frame:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
  frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1.0)

  local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  title:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -10)
  title:SetText(locale == "deDE" and "Craft Cooldowns" or "Craft Cooldowns")

  frame.measureFS = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  frame.measureFS:Hide()

  local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
  closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
  closeButton:SetScript("OnClick", function()
    frame:Hide()
    CCD.db.visible = false
  end)

  local point = CCD.db.frame.point or "CENTER"
  local relativePoint = CCD.db.frame.relativePoint or "CENTER"
  local x = CCD.db.frame.x or 0
  local y = CCD.db.frame.y or 0
  frame:SetPoint(point, UIParent, relativePoint, x, y)

  if CCD.db.visible then
    frame:Show()
  else
    frame:Hide()
  end
end

local function toggleFrame()
  if not CCD.frame then
    return
  end

  if CCD.frame:IsShown() then
    CCD.frame:Hide()
    CCD.db.visible = false
  else
    CCD.frame:Show()
    CCD.db.visible = true
    refreshFrame()
  end
end

local function resetFramePosition()
  CCD.frame:ClearAllPoints()
  CCD.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  saveFramePosition()
end

local function updateMinimapButtonPosition()
  if not CCD.minimapButton or not Minimap then
    return
  end

  local angle = CCD.db and CCD.db.minimap and CCD.db.minimap.angle or 45
  local radius = 78
  local x = math.cos(math.rad(angle)) * radius
  local y = math.sin(math.rad(angle)) * radius

  CCD.minimapButton:ClearAllPoints()
  CCD.minimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local function createMinimapButton()
  if CCD.minimapButton or not Minimap then
    return
  end

  local button = CreateFrame("Button", "CraftCooldownsMinimapButton", Minimap)
  CCD.minimapButton = button

  button:SetWidth(36)
  button:SetHeight(36)
  button:SetFrameStrata("MEDIUM")
  button:SetMovable(true)
  button:EnableMouse(true)
  button:RegisterForDrag("LeftButton")

  local border = button:CreateTexture(nil, "OVERLAY")
  button.border = border
  border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
  border:SetWidth(58)
  border:SetHeight(58)
  border:SetPoint("CENTER", button, "CENTER", 10, -10)

  local highlight = button:CreateTexture(nil, "HIGHLIGHT")
  button.highlight = highlight
  highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
  highlight:SetBlendMode("ADD")
  highlight:SetWidth(48)
  highlight:SetHeight(48)
  highlight:SetPoint("CENTER", button, "CENTER", 0, 0)

  local icon = button:CreateTexture(nil, "BACKGROUND")
  button.icon = icon
  icon:SetWidth(20)
  icon:SetHeight(20)
  icon:SetPoint("CENTER", button, "CENTER", -2, 2)
  icon:SetTexture("Interface\\Icons\\INV_Scroll_03")
  icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  button:SetScript("OnClick", function()
    toggleFrame()
  end)

  button:SetScript("OnDragStart", function()
    this.dragging = true
  end)

  button:SetScript("OnDragStop", function()
    this.dragging = nil
  end)

  button:SetScript("OnUpdate", function()
    if not this.dragging then
      return
    end

    local mx, my = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()
    local cx, cy = Minimap:GetCenter()
    mx = mx / scale
    my = my / scale

    local angle = math.deg(math.atan2(my - cy, mx - cx))
    CCD.db.minimap.angle = angle
    updateMinimapButtonPosition()
  end)

  button:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT")
    GameTooltip:AddLine("Craft Cooldowns")
    GameTooltip:AddLine(locale == "deDE" and "Linksklick: Fenster ein/aus" or "Left-click: toggle window", 1, 1, 1)
    GameTooltip:AddLine(locale == "deDE" and "Ziehen: Button verschieben" or "Drag: move button", 0.7, 0.7, 0.7)
    GameTooltip:Show()
  end)

  button:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  updateMinimapButtonPosition()
end

SLASH_CRAFTCOOLDOWNS1 = "/craftcd"
SLASH_CRAFTCOOLDOWNS2 = "/ccd"
SlashCmdList.CRAFTCOOLDOWNS = function(msg)
  msg = lowercase(trim(msg or ""))

  if msg == "reset" then
    resetFramePosition()
    refreshFrame()
    return
  end

  if msg == "scan" then
    scanTradeSkillFrame()
    scanCraftFrame()
    refreshFrame()
    return
  end

  toggleFrame()
end

CCD:SetScript("OnUpdate", function()
  CCD.updateElapsed = (CCD.updateElapsed or 0) + arg1

  if CCD.pendingTradeSkillScan then
    CCD.pendingTradeSkillScan = nil
    scanTradeSkillFrame()
    refreshFrame()
  end

  if CCD.pendingCraftScan then
    CCD.pendingCraftScan = nil
    scanCraftFrame()
    refreshFrame()
  end

  processPendingCraftRequest()

  if CCD.updateElapsed >= 1 then
    CCD.updateElapsed = 0
    refreshFrame()
  end
end)

CCD:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == addonName then
    initializeDatabase()
    updateProfessionList()
    createFrame()
    createMinimapButton()
    refreshFrame()
  elseif event == "PLAYER_LOGIN" then
    updateProfessionList()
    updateMinimapButtonPosition()
    refreshFrame()
  elseif event == "SKILL_LINES_CHANGED" then
    updateProfessionList()
    refreshFrame()
  elseif event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" or event == "PLAYERBANKBAGSLOTS_CHANGED" then
    saveBankSnapshot()
  elseif event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" then
    CCD.pendingTradeSkillScan = true
    if CCD.pendingCraftRecipeId then
      scanTradeSkillFrame()
      processPendingCraftRequest()
      refreshFrame()
    end
  elseif event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" then
    CCD.pendingCraftScan = true
    if CCD.pendingCraftRecipeId then
      scanCraftFrame()
      processPendingCraftRequest()
      refreshFrame()
    end
  end
end)

CCD:RegisterEvent("ADDON_LOADED")
CCD:RegisterEvent("PLAYER_LOGIN")
CCD:RegisterEvent("SKILL_LINES_CHANGED")
CCD:RegisterEvent("BANKFRAME_OPENED")
CCD:RegisterEvent("BANKFRAME_CLOSED")
CCD:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
CCD:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
CCD:RegisterEvent("TRADE_SKILL_SHOW")
CCD:RegisterEvent("TRADE_SKILL_UPDATE")
CCD:RegisterEvent("CRAFT_SHOW")
CCD:RegisterEvent("CRAFT_UPDATE")
