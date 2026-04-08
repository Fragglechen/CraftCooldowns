local addonName = "CraftCooldowns"

local CCD = CreateFrame("Frame")
_G.CraftCooldowns = CCD

local locale = GetLocale and GetLocale() or "enUS"

local STRINGS = {
  enUS = {
    unknown = "Unknown",
    ready = "Ready",
    no_bank_snapshot = "No bank snapshot yet. Open bank once.",
    materials_for = "Materials for ",
    are_partially_in_bank = " are partially in the bank:",
    missing_materials_for = "Missing materials for ",
    materials_for_recipe = "Materials for %s are partially in the bank:",
    missing_materials_for_recipe = "Missing materials for %s:",
    materials_line_total = "%s: %d/%d (Bags %d, Bank %d)",
    materials_line_bags_bank = "%s: Bags %d/%d, Bank %d",
    recipe_not_learned = "Recipe is not learned.",
    cooldown_not_ready = "Cooldown is not ready yet.",
    recipe_not_visible = "Recipe is not visible in the open profession window.",
    automatic_craft_failed = "Automatic craft could not be started.",
    atsw_could_not_select = "ATSW could not select the recipe.",
    atsw_selected_other = "ATSW selected a different recipe: ",
    open_profession_once = "Open profession once to scan recipes",
    no_learned_recipe = "No learned cooldown recipe found",
    no_professions = "No professions with known craft cooldowns found",
    craft_now = "Craft now",
    minimap_left_click = "Left-click: toggle window",
    minimap_right_click = "Right-click: open options",
    minimap_drag = "Drag: move button",
    title = "Craft Cooldowns",
    options_title = "Craft Cooldowns Options",
    options_save = "Save",
    options_show_minimap = "Show minimap button",
    options_lock_frame = "Lock cooldown frame",
    options_show_profession_headers = "Show profession headers",
    options_ready_sound = "Play ready sound",
    options_ready_message = "Show ready message",
    options_recipe_list = "Cooldown recipes",
    options_button_tooltip = "Open options",
    no_enabled_recipe = "No enabled cooldown recipe selected",
    no_config_recipes = "No learned cooldown recipes available yet.",
    options_test = "Test",
    ready_again = "%s is ready again",
    ready_multiple = "Ready again: %s",
    test_recipe_name = "Mooncloth",
  },
  deDE = {
    unknown = "Unbekannt",
    ready = "Frei",
    no_bank_snapshot = "Kein Bank-Snapshot. Einmal Bank oeffnen.",
    materials_for = "Materialien fuer ",
    are_partially_in_bank = " sind teilweise auf der Bank:",
    missing_materials_for = "Fehlende Materialien fuer ",
    materials_for_recipe = "Materialien fuer %s sind teilweise auf der Bank:",
    missing_materials_for_recipe = "Fehlende Materialien fuer %s:",
    materials_line_total = "%s: %d/%d (Taschen %d, Bank %d)",
    materials_line_bags_bank = "%s: Taschen %d/%d, Bank %d",
    recipe_not_learned = "Rezept ist nicht gelernt.",
    cooldown_not_ready = "Cooldown ist noch nicht bereit.",
    recipe_not_visible = "Rezept im offenen Berufsfenster nicht sichtbar.",
    automatic_craft_failed = "Automatischer Craft konnte nicht gestartet werden.",
    atsw_could_not_select = "ATSW konnte das Rezept nicht auswaehlen.",
    atsw_selected_other = "ATSW hat ein anderes Rezept ausgewaehlt: ",
    open_profession_once = "Beruf einmal oeffnen, um Rezepte zu scannen",
    no_learned_recipe = "Kein gelerntes Cooldown-Rezept gefunden",
    no_professions = "Keine Berufe mit bekannten Craft-Cooldowns gefunden",
    craft_now = "Jetzt herstellen",
    minimap_left_click = "Linksklick: Fenster ein/aus",
    minimap_right_click = "Rechtsklick: Optionen oeffnen",
    minimap_drag = "Ziehen: Button verschieben",
    title = "Craft Cooldowns",
    options_title = "Craft Cooldowns Optionen",
    options_save = "Speichern",
    options_show_minimap = "Minimap-Button anzeigen",
    options_lock_frame = "Cooldown-Fenster sperren",
    options_show_profession_headers = "Berufskopfzeilen anzeigen",
    options_ready_sound = "Ready-Sound abspielen",
    options_ready_message = "Ready-Meldung anzeigen",
    options_recipe_list = "Cooldown-Rezepte",
    options_button_tooltip = "Optionen oeffnen",
    no_enabled_recipe = "Kein aktiviertes Cooldown-Rezept ausgewaehlt",
    no_config_recipes = "Noch keine gelernten Cooldown-Rezepte verfuegbar.",
    options_test = "Test",
    ready_again = "%s ist wieder bereit",
    ready_multiple = "Wieder bereit: %s",
    test_recipe_name = "Mondstoff",
  },
  frFR = {
    unknown = "Inconnu",
    ready = "Pret",
    no_bank_snapshot = "Aucun instantane de banque. Ouvrez la banque une fois.",
    materials_for = "Materiaux pour ",
    are_partially_in_bank = " sont en partie a la banque :",
    missing_materials_for = "Materiaux manquants pour ",
    materials_for_recipe = "Les materiaux pour %s sont en partie a la banque :",
    missing_materials_for_recipe = "Materiaux manquants pour %s :",
    materials_line_total = "%s : %d/%d (Sacs %d, Banque %d)",
    materials_line_bags_bank = "%s : Sacs %d/%d, Banque %d",
    recipe_not_learned = "La recette n'est pas apprise.",
    cooldown_not_ready = "Le temps de recharge n'est pas pret.",
    recipe_not_visible = "La recette n'est pas visible dans la fenetre de metier ouverte.",
    automatic_craft_failed = "Le craft automatique n'a pas pu demarrer.",
    atsw_could_not_select = "ATSW n'a pas pu selectionner la recette.",
    atsw_selected_other = "ATSW a selectionne une autre recette : ",
    open_profession_once = "Ouvrez le metier une fois pour analyser les recettes",
    no_learned_recipe = "Aucune recette a recharge connue n'a ete trouvee",
    no_professions = "Aucun metier avec des crafts a recharge connus n'a ete trouve",
    craft_now = "Fabriquer",
    minimap_left_click = "Clic gauche : afficher ou masquer la fenetre",
    minimap_right_click = "Clic droit : ouvrir les options",
    minimap_drag = "Glisser : deplacer le bouton",
    title = "Craft Cooldowns",
    options_title = "Options Craft Cooldowns",
    options_save = "Enregistrer",
    options_show_minimap = "Afficher le bouton de la minicarte",
    options_lock_frame = "Verrouiller la fenetre des cooldowns",
    options_show_profession_headers = "Afficher les en-tetes de metier",
    options_ready_sound = "Jouer le son de disponibilite",
    options_ready_message = "Afficher le message de disponibilite",
    options_recipe_list = "Recettes a cooldown",
    options_button_tooltip = "Ouvrir les options",
    no_enabled_recipe = "Aucune recette a cooldown activee",
    no_config_recipes = "Aucune recette a cooldown apprise disponible.",
    options_test = "Test",
    ready_again = "%s est de nouveau disponible",
    ready_multiple = "De nouveau disponibles : %s",
    test_recipe_name = "Etoffe lunaire",
  },
  esES = {
    unknown = "Desconocido",
    ready = "Listo",
    no_bank_snapshot = "Aun no hay instantanea del banco. Abre el banco una vez.",
    materials_for = "Materiales para ",
    are_partially_in_bank = " estan parcialmente en el banco:",
    missing_materials_for = "Materiales que faltan para ",
    materials_for_recipe = "Los materiales para %s estan parcialmente en el banco:",
    missing_materials_for_recipe = "Materiales que faltan para %s:",
    materials_line_total = "%s: %d/%d (Bolsas %d, Banco %d)",
    materials_line_bags_bank = "%s: Bolsas %d/%d, Banco %d",
    recipe_not_learned = "La receta no esta aprendida.",
    cooldown_not_ready = "El tiempo de reutilizacion aun no esta listo.",
    recipe_not_visible = "La receta no esta visible en la ventana de profesion abierta.",
    automatic_craft_failed = "No se pudo iniciar la fabricacion automatica.",
    atsw_could_not_select = "ATSW no pudo seleccionar la receta.",
    atsw_selected_other = "ATSW selecciono una receta diferente: ",
    open_profession_once = "Abre la profesion una vez para escanear las recetas",
    no_learned_recipe = "No se encontro ninguna receta con reutilizacion aprendida",
    no_professions = "No se encontraron profesiones con cooldowns conocidos",
    craft_now = "Fabricar ahora",
    minimap_left_click = "Clic izquierdo: mostrar u ocultar ventana",
    minimap_right_click = "Clic derecho: abrir opciones",
    minimap_drag = "Arrastrar: mover boton",
    title = "Craft Cooldowns",
    options_title = "Opciones de Craft Cooldowns",
    options_save = "Guardar",
    options_show_minimap = "Mostrar boton del minimapa",
    options_lock_frame = "Bloquear ventana de cooldowns",
    options_show_profession_headers = "Mostrar encabezados de profesion",
    options_ready_sound = "Reproducir sonido de listo",
    options_ready_message = "Mostrar mensaje de listo",
    options_recipe_list = "Recetas con cooldown",
    options_button_tooltip = "Abrir opciones",
    no_enabled_recipe = "No hay ninguna receta con cooldown activada",
    no_config_recipes = "Aun no hay recetas con cooldown aprendidas.",
    options_test = "Probar",
    ready_again = "%s vuelve a estar disponible",
    ready_multiple = "Disponibles de nuevo: %s",
    test_recipe_name = "Tela lunar",
  },
  ruRU = {
    unknown = "Neizvestno",
    ready = "Gotovo",
    no_bank_snapshot = "Net snimka banka. Otkroyte bank odin raz.",
    materials_for = "Materialy dlya ",
    are_partially_in_bank = " chastichno lezhat v banke:",
    missing_materials_for = "Ne hvataet materialov dlya ",
    materials_for_recipe = "Materialy dlya %s chastichno lezhat v banke:",
    missing_materials_for_recipe = "Ne hvataet materialov dlya %s:",
    materials_line_total = "%s: %d/%d (Sumki %d, Bank %d)",
    materials_line_bags_bank = "%s: Sumki %d/%d, Bank %d",
    recipe_not_learned = "Retsept ne izuchen.",
    cooldown_not_ready = "Vremya vosstanovleniya eshche ne zakonchilos.",
    recipe_not_visible = "Retsept ne vidim v otkrytom okne professii.",
    automatic_craft_failed = "Ne udalos zapustit avtomaticheskiy kraft.",
    atsw_could_not_select = "ATSW ne smog vybrat retsept.",
    atsw_selected_other = "ATSW vybral drugoy retsept: ",
    open_profession_once = "Otkroyte professiyu odin raz, chtoby proskenirovat retsepty",
    no_learned_recipe = "Ne naydeno izuchennyh retseptov s kuldaunom",
    no_professions = "Ne naydeno professiy s izvestnymi kuldaunami krafta",
    craft_now = "Sozdat",
    minimap_left_click = "Levyy klik: pokazat ili skryt okno",
    minimap_right_click = "Pravyy klik: otkryt nastroiki",
    minimap_drag = "Peretashchit: peremestit knopku",
    title = "Craft Cooldowns",
    options_title = "Nastroiki Craft Cooldowns",
    options_save = "Sohranit",
    options_show_minimap = "Pokazyvat knopku u minimapy",
    options_lock_frame = "Zablokirovat okno kuldaunov",
    options_show_profession_headers = "Pokazyvat zagolovki professiy",
    options_ready_sound = "Proigryvat zvuk gotovnosti",
    options_ready_message = "Pokazyvat soobshchenie o gotovnosti",
    options_recipe_list = "Retsepty s kuldaunom",
    options_button_tooltip = "Otkryt nastroiki",
    no_enabled_recipe = "Net vklyuchennyh retseptov s kuldaunom",
    no_config_recipes = "Net dostupnyh izuchennyh retseptov s kuldaunom.",
    options_test = "Test",
    ready_again = "%s snova gotov",
    ready_multiple = "Snova gotovy: %s",
    test_recipe_name = "Lunnaya tkan",
  },
  zhCN = {
    unknown = "未知",
    ready = "就绪",
    no_bank_snapshot = "还没有银行快照。请先打开一次银行。",
    materials_for = "",
    are_partially_in_bank = " 的部分材料在银行中：",
    missing_materials_for = "",
    materials_for_recipe = "%s 的部分材料在银行中：",
    missing_materials_for_recipe = "%s 缺少以下材料：",
    materials_line_total = "%s: %d/%d（背包 %d，银行 %d）",
    materials_line_bags_bank = "%s: 背包 %d/%d，银行 %d",
    recipe_not_learned = "尚未学会该配方。",
    cooldown_not_ready = "冷却时间尚未结束。",
    recipe_not_visible = "该配方在当前打开的专业窗口中不可见。",
    automatic_craft_failed = "无法启动自动制作。",
    atsw_could_not_select = "ATSW 无法选中该配方。",
    atsw_selected_other = "ATSW 选中了其他配方：",
    open_profession_once = "请打开一次专业窗口以扫描配方",
    no_learned_recipe = "未找到已学会的冷却配方",
    no_professions = "未找到已知制作冷却的专业",
    craft_now = "立即制作",
    minimap_left_click = "左键：显示或隐藏窗口",
    minimap_right_click = "右键：打开选项",
    minimap_drag = "拖动：移动按钮",
    title = "Craft Cooldowns",
    options_title = "Craft Cooldowns 选项",
    options_save = "保存",
    options_show_minimap = "显示小地图按钮",
    options_lock_frame = "锁定冷却窗口",
    options_show_profession_headers = "显示专业标题",
    options_ready_sound = "播放就绪提示音",
    options_ready_message = "显示就绪提示",
    options_recipe_list = "冷却配方",
    options_button_tooltip = "打开选项",
    no_enabled_recipe = "未选择启用的冷却配方",
    no_config_recipes = "还没有可用的已学会冷却配方。",
    options_test = "测试",
    ready_again = "%s 已再次就绪",
    ready_multiple = "已再次就绪：%s",
    test_recipe_name = "月布",
  },
  koKR = {
    unknown = "알 수 없음",
    ready = "준비",
    no_bank_snapshot = "은행 스냅샷이 없습니다. 은행을 한 번 열어 주세요.",
    materials_for = "",
    are_partially_in_bank = " 재료 일부가 은행에 있습니다:",
    missing_materials_for = "",
    materials_for_recipe = "%s 재료 일부가 은행에 있습니다:",
    missing_materials_for_recipe = "%s 제작에 필요한 재료가 부족합니다:",
    materials_line_total = "%s: %d/%d (가방 %d, 은행 %d)",
    materials_line_bags_bank = "%s: 가방 %d/%d, 은행 %d",
    recipe_not_learned = "해당 제조법을 배우지 않았습니다.",
    cooldown_not_ready = "재사용 대기시간이 아직 끝나지 않았습니다.",
    recipe_not_visible = "열린 전문 기술 창에서 해당 제조법이 보이지 않습니다.",
    automatic_craft_failed = "자동 제작을 시작할 수 없습니다.",
    atsw_could_not_select = "ATSW가 제조법을 선택하지 못했습니다.",
    atsw_selected_other = "ATSW가 다른 제조법을 선택했습니다: ",
    open_profession_once = "제조법을 스캔하려면 전문 기술 창을 한 번 열어 주세요",
    no_learned_recipe = "배운 쿨다운 제조법을 찾지 못했습니다",
    no_professions = "알려진 제작 쿨다운이 있는 전문 기술을 찾지 못했습니다",
    craft_now = "지금 제작",
    minimap_left_click = "왼쪽 클릭: 창 표시 또는 숨기기",
    minimap_right_click = "오른쪽 클릭: 옵션 열기",
    minimap_drag = "드래그: 버튼 이동",
    title = "Craft Cooldowns",
    options_title = "Craft Cooldowns 옵션",
    options_save = "저장",
    options_show_minimap = "미니맵 버튼 표시",
    options_lock_frame = "쿨다운 창 잠금",
    options_show_profession_headers = "전문 기술 제목 표시",
    options_ready_sound = "준비 소리 재생",
    options_ready_message = "준비 메시지 표시",
    options_recipe_list = "쿨다운 제조법",
    options_button_tooltip = "옵션 열기",
    no_enabled_recipe = "활성화된 쿨다운 제조법이 없습니다",
    no_config_recipes = "사용 가능한 배운 쿨다운 제조법이 아직 없습니다.",
    options_test = "테스트",
    ready_again = "%s 사용 가능",
    ready_multiple = "다시 사용 가능: %s",
    test_recipe_name = "달빛 옷감",
  },
  zhTW = {
    unknown = "未知",
    ready = "就緒",
    no_bank_snapshot = "尚未建立銀行快照。請先打開一次銀行。",
    materials_for = "",
    are_partially_in_bank = " 的部分材料在銀行：",
    missing_materials_for = "",
    materials_for_recipe = "%s 的部分材料在銀行：",
    missing_materials_for_recipe = "%s 缺少以下材料：",
    materials_line_total = "%s: %d/%d（背包 %d，銀行 %d）",
    materials_line_bags_bank = "%s: 背包 %d/%d，銀行 %d",
    recipe_not_learned = "尚未學會此配方。",
    cooldown_not_ready = "冷卻時間尚未結束。",
    recipe_not_visible = "此配方在目前開啟的專業視窗中不可見。",
    automatic_craft_failed = "無法啟動自動製作。",
    atsw_could_not_select = "ATSW 無法選取此配方。",
    atsw_selected_other = "ATSW 選取了其他配方：",
    open_profession_once = "請先打開一次專業視窗以掃描配方",
    no_learned_recipe = "未找到已學會的冷卻配方",
    no_professions = "未找到有已知製作冷卻的專業",
    craft_now = "立即製作",
    minimap_left_click = "左鍵：顯示或隱藏視窗",
    minimap_right_click = "右鍵：開啟選項",
    minimap_drag = "拖曳：移動按鈕",
    title = "Craft Cooldowns",
    options_title = "Craft Cooldowns 選項",
    options_save = "儲存",
    options_show_minimap = "顯示小地圖按鈕",
    options_lock_frame = "鎖定冷卻視窗",
    options_show_profession_headers = "顯示專業標題",
    options_ready_sound = "播放就緒提示音",
    options_ready_message = "顯示就緒提示",
    options_recipe_list = "冷卻配方",
    options_button_tooltip = "開啟選項",
    no_enabled_recipe = "未選擇啟用的冷卻配方",
    no_config_recipes = "尚無可用的已學會冷卻配方。",
    options_test = "測試",
    ready_again = "%s 已再次可用",
    ready_multiple = "已再次可用：%s",
    test_recipe_name = "月布",
  },
}

local L = STRINGS[locale] or STRINGS.enUS

local function T(key)
  return L[key] or STRINGS.enUS[key] or key
end

local LOCALIZED_PROFESSIONS = {
  Alchemy = {
    enUS = "Alchemy",
    deDE = "Alchimie",
    frFR = "Alchimie",
    esES = "Alquimia",
    ruRU = "Alhimija",
    zhCN = "Alchemy",
    koKR = "Alchemy",
    zhTW = "Alchemy",
    spellId = 2259,
  },
  Tailoring = {
    enUS = "Tailoring",
    deDE = "Schneiderei",
    frFR = "Couture",
    esES = "Sastreria",
    ruRU = "Portnyazhnoe delo",
    zhCN = "Tailoring",
    koKR = "Tailoring",
    zhTW = "Tailoring",
    spellId = 3908,
  },
  Gardening = {
    enUS = "Gardening",
    deDE = "Gaertnerei",
    frFR = "Gardening",
    esES = "Jardineria",
    ruRU = "Gardening",
    zhCN = "Gardening",
    koKR = "Gardening",
    zhTW = "Gardening",
  },
  Survival = {
    enUS = "Survival",
    deDE = "Ueberleben",
    frFR = "Survival",
    esES = "Supervivencia",
    ruRU = "Survival",
    zhCN = "Survival",
    koKR = "Survival",
    zhTW = "Survival",
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
  Gardening = {},
  Survival = {},
}

local PROFESSIONS_WITH_COOLDOWNS = {
  "Alchemy",
  "Tailoring",
  "Gardening",
  "Survival",
}

local RECIPE_BY_ID = {}
local function registerRecipeDef(recipeDef, professionKey)
  if not recipeDef or not recipeDef.id then
    return
  end

  recipeDef.profession = professionKey or recipeDef.profession
  RECIPE_BY_ID[recipeDef.id] = recipeDef
end

for professionKey, recipes in pairs(KNOWN_COOLDOWNS) do
  for _, recipeDef in ipairs(recipes) do
    registerRecipeDef(recipeDef, professionKey)
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
local refreshFrame
local updateMinimapButtonVisibility
local openConfigFrame

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
  local playerName = UnitName("player") or L.unknown
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

  if data.spellId and GetSpellInfo then
    local spellName = GetSpellInfo(data.spellId)
    if spellName and spellName ~= "" then
      return spellName
    end
  end

  return data[locale] or data.enUS or professionKey
end

local function getRecipeDisplayName(recipeDef)
  if recipeDef.spellId and GetSpellInfo then
    local spellName = GetSpellInfo(recipeDef.spellId)
    if spellName and spellName ~= "" then
      return spellName
    end
  end

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

local function showCenterMessage(msg)
  if RaidWarningFrame and RaidWarningFrame.AddMessage then
    RaidWarningFrame:AddMessage(tostring(msg), 1.0, 0.82, 0.0)
    return
  end

  printCombatMessage(msg, 1.0, 0.82, 0.0)
end

local function playReadySound()
  if PlaySound then
    PlaySound("RaidWarning")
    return true
  end

  if PlaySoundFile then
    return pcall(PlaySoundFile, "Interface\\AddOns\\BigWigs\\Sounds\\Beware.wav")
  end

  return nil
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
    if name == professionKey then
      return professionKey
    end

    if localized.spellId and GetSpellInfo and name == GetSpellInfo(localized.spellId) then
      return professionKey
    end

    for _, localizedName in pairs(localized) do
      if type(localizedName) == "string" and name == localizedName then
        return professionKey
      end
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

  if recipeDef.spellId and GetSpellInfo then
    local spellName = GetSpellInfo(recipeDef.spellId)
    if spellName and loweredName == lowercase(spellName) then
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
  CCD.db.frame = CCD.db.frame or { point = "CENTER", relativePoint = "CENTER", x = 0, y = 0, width = 220, height = 140 }
  CCD.db.configFrame = CCD.db.configFrame or { point = "CENTER", relativePoint = "CENTER", x = 20, y = -20 }
  CCD.db.minimap = CCD.db.minimap or { angle = 45 }
  CCD.db.recipes = CCD.db.recipes or {}
  CCD.db.recipeFilters = CCD.db.recipeFilters or {}
  CCD.db.dynamicRecipes = CCD.db.dynamicRecipes or {}
  CCD.db.professions = CCD.db.professions or {}
  CCD.db.scanned = CCD.db.scanned or {}
  CCD.db.bank = CCD.db.bank or { counts = {}, lastUpdate = 0 }
  CCD.db.options = CCD.db.options or {}
  CCD.db.readyState = CCD.db.readyState or {}
  CCD.db.visible = CCD.db.visible

  if CCD.db.visible == nil then
    CCD.db.visible = true
  end

  if CCD.db.options.showMinimapButton == nil then
    CCD.db.options.showMinimapButton = true
  end

  if CCD.db.options.lockFrame == nil then
    CCD.db.options.lockFrame = false
  end

  if CCD.db.options.showProfessionHeaders == nil then
    CCD.db.options.showProfessionHeaders = true
  end

  if CCD.db.options.readySound == nil then
    CCD.db.options.readySound = true
  end

  if CCD.db.options.readyMessage == nil then
    CCD.db.options.readyMessage = true
  end

  for professionKey, recipes in pairs(CCD.db.dynamicRecipes) do
    for _, recipeDef in pairs(recipes or {}) do
      registerRecipeDef(recipeDef, professionKey)
    end
  end
end

local function getRecipesForProfession(professionKey)
  local recipes = {}
  local seen = {}

  local function makeRecipeKey(recipeDef)
    if not recipeDef then
      return nil
    end

    local displayName = getRecipeDisplayName(recipeDef)
    if displayName and displayName ~= "" then
      return lowercase(trim(displayName))
    end

    if recipeDef.names then
      for _, localizedName in pairs(recipeDef.names) do
        if localizedName and localizedName ~= "" then
          return lowercase(trim(localizedName))
        end
      end
    end

    return recipeDef.id
  end

  local function addRecipe(recipeDef)
    local key = makeRecipeKey(recipeDef)
    if not key or seen[key] then
      return
    end

    seen[key] = true
    table.insert(recipes, recipeDef)
  end

  for _, recipeDef in ipairs(KNOWN_COOLDOWNS[professionKey] or {}) do
    addRecipe(recipeDef)
  end

  if CCD.db and CCD.db.dynamicRecipes and CCD.db.dynamicRecipes[professionKey] then
    for _, recipeDef in pairs(CCD.db.dynamicRecipes[professionKey]) do
      addRecipe(recipeDef)
    end
  end

  return recipes
end

local function getAllKnownCooldownRecipes()
  local recipes = {}

  for _, professionKey in ipairs(PROFESSIONS_WITH_COOLDOWNS) do
    for _, recipeDef in ipairs(getRecipesForProfession(professionKey)) do
      table.insert(recipes, recipeDef)
    end
  end

  table.sort(recipes, function(a, b)
    if a.profession ~= b.profession then
      return getProfessionDisplayName(a.profession) < getProfessionDisplayName(b.profession)
    end

    return getRecipeDisplayName(a) < getRecipeDisplayName(b)
  end)

  return recipes
end

local function getConfigurableRecipes()
  local recipes = {}

  for _, professionKey in ipairs(PROFESSIONS_WITH_COOLDOWNS) do
    if CCD.db.professions[professionKey] then
      for _, recipeDef in ipairs(getRecipesForProfession(professionKey)) do
        local recipeState = CCD.db.recipes[recipeDef.id]
        if recipeState and recipeState.learned then
          table.insert(recipes, recipeDef)
        end
      end
    end
  end

  table.sort(recipes, function(a, b)
    if a.profession ~= b.profession then
      return getProfessionDisplayName(a.profession) < getProfessionDisplayName(b.profession)
    end

    return getRecipeDisplayName(a) < getRecipeDisplayName(b)
  end)

  return recipes
end

local function isRecipeEnabled(recipeId)
  if not CCD.db or not CCD.db.recipeFilters then
    return true
  end

  local value = CCD.db.recipeFilters[recipeId]
  if value == nil then
    return true
  end

  return value and true or nil
end

local function triggerReadyNotification(recipeDef)
  local recipeName = getRecipeDisplayName(recipeDef)
  local message = string.format(T("ready_again"), recipeName)

  if CCD.db.options.readySound then
    playReadySound()
  end

  if CCD.db.options.readyMessage then
    showCenterMessage(message)
    printMessage(message)
  end
end

local function triggerReadyNotifications(recipeDefs)
  local names = {}

  for _, recipeDef in ipairs(recipeDefs or {}) do
    table.insert(names, getRecipeDisplayName(recipeDef))
  end

  if table.getn(names) == 0 then
    return
  end

  if table.getn(names) == 1 then
    triggerReadyNotification(recipeDefs[1])
    return
  end

  local message = string.format(T("ready_multiple"), table.concat(names, ", "))

  if CCD.db.options.readySound then
    playReadySound()
  end

  if CCD.db.options.readyMessage then
    showCenterMessage(message)
    printMessage(message)
  end
end

local function updateReadyNotifications()
  if not CCD.db or not CCD.db.recipes then
    return
  end

  local now = time()
  local readyRecipes = {}
  for recipeId, recipeState in pairs(CCD.db.recipes) do
    local recipeDef = RECIPE_BY_ID[recipeId]
    if recipeDef and recipeState and recipeState.learned then
      CCD.db.readyState[recipeId] = CCD.db.readyState[recipeId] or {}
      local readyState = CCD.db.readyState[recipeId]
      local isOnCooldown = recipeState.expiresAt and recipeState.expiresAt > now

      if readyState.wasOnCooldown == nil then
        readyState.wasOnCooldown = isOnCooldown and true or false
      elseif readyState.wasOnCooldown and not isOnCooldown then
        readyState.wasOnCooldown = false
        if isRecipeEnabled(recipeId) then
          table.insert(readyRecipes, recipeDef)
        end
      else
        readyState.wasOnCooldown = isOnCooldown and true or false
      end
    end
  end

  if table.getn(readyRecipes) > 0 then
    table.sort(readyRecipes, function(a, b)
      if a.profession ~= b.profession then
        return getProfessionDisplayName(a.profession) < getProfessionDisplayName(b.profession)
      end

      return getRecipeDisplayName(a) < getRecipeDisplayName(b)
    end)
    triggerReadyNotifications(readyRecipes)
  end
end

local function makeDynamicRecipeId(professionKey, recipeName)
  local normalized = lowercase(trim(recipeName or "")) or "recipe"
  normalized = string.gsub(normalized, "[^%w]+", "_")
  normalized = string.gsub(normalized, "^_+", "")
  normalized = string.gsub(normalized, "_+$", "")

  if normalized == "" then
    normalized = "recipe"
  end

  return "dynamic_" .. professionKey .. "_" .. normalized
end

local function rememberDynamicCooldownRecipe(professionKey, recipeName)
  if not CCD.db or not professionKey or not recipeName or recipeName == "" then
    return nil
  end

  CCD.db.dynamicRecipes[professionKey] = CCD.db.dynamicRecipes[professionKey] or {}

  for _, recipeDef in ipairs(KNOWN_COOLDOWNS[professionKey] or {}) do
    if recipeMatchesName(recipeDef, recipeName) then
      registerRecipeDef(recipeDef, professionKey)
      return recipeDef
    end
  end

  for recipeId, recipeDef in pairs(CCD.db.dynamicRecipes[professionKey]) do
    if recipeMatchesName(recipeDef, recipeName) then
      registerRecipeDef(recipeDef, professionKey)
      return recipeDef
    end
  end

  local recipeId = makeDynamicRecipeId(professionKey, recipeName)
  local recipeDef = {
    id = recipeId,
    profession = professionKey,
    names = {
      enUS = recipeName,
    },
  }
  recipeDef.names[locale] = recipeName

  CCD.db.dynamicRecipes[professionKey][recipeId] = recipeDef
  registerRecipeDef(recipeDef, professionKey)
  return recipeDef
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
  local definitions = getRecipesForProfession(professionKey)

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
  local recipeDefinitions = getRecipesForProfession(professionKey)

  for index = 1, GetNumTradeSkills() do
    local recipeName, recipeType = GetTradeSkillInfo(index)
    if recipeType ~= "header" then
      local cooldown = GetTradeSkillCooldown(index)
      if cooldown and cooldown > 0 then
        local dynamicRecipe = rememberDynamicCooldownRecipe(professionKey, recipeName)
        if dynamicRecipe then
          foundRecipes[dynamicRecipe.id] = true
          saveRecipeCooldown(professionKey, dynamicRecipe, cooldown, captureTradeSkillReagents(index))
        end
      end

      for _, recipeDef in ipairs(recipeDefinitions) do
        if recipeMatchesName(recipeDef, recipeName) then
          foundRecipes[recipeDef.id] = true
          saveRecipeCooldown(professionKey, recipeDef, cooldown, captureTradeSkillReagents(index))
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
  local recipeDefinitions = getRecipesForProfession(professionKey)

  for index = 1, GetNumCrafts() do
    local recipeName, _, recipeType = GetCraftInfo(index)
    if recipeType ~= "header" then
      local cooldown = GetCraftCooldown and GetCraftCooldown(index)
      if cooldown and cooldown > 0 then
        local dynamicRecipe = rememberDynamicCooldownRecipe(professionKey, recipeName)
        if dynamicRecipe then
          foundRecipes[dynamicRecipe.id] = true
          saveRecipeCooldown(professionKey, dynamicRecipe, cooldown, captureCraftReagents(index))
        end
      end

      for _, recipeDef in ipairs(recipeDefinitions) do
        if recipeMatchesName(recipeDef, recipeName) then
          foundRecipes[recipeDef.id] = true
          saveRecipeCooldown(professionKey, recipeDef, cooldown, captureCraftReagents(index))
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
      table.insert(result.lines, string.format(T("materials_line_total"), reagentName, total, required, inBags, inBank))
    elseif inBags < required then
      table.insert(result.lines, string.format(T("materials_line_bags_bank"), reagentName, inBags, required, inBank))
    end
  end

  return result
end

local function printMaterialMessage(recipeId, materialState)
  local recipeState = CCD.db.recipes[recipeId]
  local recipeName = recipeState and recipeState.name or recipeId
  local snapshotMissing = not (CCD.db.bank and CCD.db.bank.lastUpdate and CCD.db.bank.lastUpdate > 0)

  if materialState.hasEnoughTotal and not materialState.canCraftFromBags then
    printMessage(string.format(T("materials_for_recipe"), recipeName))
  else
    printMessage(string.format(T("missing_materials_for_recipe"), recipeName))
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
    local snapshotMessage = L.no_bank_snapshot
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
    notifyMessage(L.recipe_not_learned, 1.0, 0.1, 0.1)
    CCD.pendingCraftRecipeId = nil
    CCD.pendingCraftOpenRecipeId = nil
    CCD.pendingCraftDeadline = nil
    CCD.pendingCraftNextAttempt = nil
    CCD.pendingCraftExpanded = nil
    return
  end

  if recipeState.expiresAt and recipeState.expiresAt > time() then
    notifyMessage(L.cooldown_not_ready, 1.0, 0.1, 0.1)
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

    notifyMessage(L.recipe_not_visible, 1.0, 0.1, 0.1)
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
    local reason = L.automatic_craft_failed
    if isVisible(_G.ATSWFrame) and _G.ATSW_RecipeSelected then
      local selectedName = _G.ATSW_RecipeSelected()
      if not selectedName or selectedName == "" then
        reason = L.atsw_could_not_select
      else
        reason = L.atsw_selected_other .. selectedName
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
      if not CCD.db.scanned[professionKey] then
        -- Do not show empty profession categories before any cooldown recipe was found.
      else
        local learnedAny = nil
        local visibleEntries = {}

        for _, recipeDef in ipairs(getRecipesForProfession(professionKey)) do
          local recipeState = CCD.db.recipes[recipeDef.id]
          if recipeState and recipeState.learned then
            learnedAny = true
            if isRecipeEnabled(recipeDef.id) then
              local remaining = 0
              if recipeState.expiresAt and recipeState.expiresAt > time() then
                remaining = recipeState.expiresAt - time()
              end

              table.insert(visibleEntries, {
                label = "  " .. getRecipeDisplayName(recipeDef),
                status = remaining > 0 and formatDuration(remaining) or L.ready,
                isReady = remaining <= 0,
                isCooldown = remaining > 0,
                recipeId = recipeDef.id,
              })
            end
          end
        end

        if table.getn(visibleEntries) > 0 then
          hasAnyProfession = true

          if CCD.db.options.showProfessionHeaders then
            table.insert(entries, {
              label = getProfessionDisplayName(professionKey),
              status = "",
              isHeader = true,
            })
          end

          for _, entry in ipairs(visibleEntries) do
            table.insert(entries, entry)
          end
        end
      end
    end
  end

  if not hasAnyProfession then
    table.insert(entries, {
      label = L.no_professions,
      status = "",
      isHint = true,
    })
  end

  return entries
end

local MAIN_FRAME_MIN_WIDTH = 220
local MAIN_FRAME_MIN_HEIGHT = 70
local MAIN_FRAME_MAX_WIDTH = 420
local MAIN_FRAME_MAX_HEIGHT = 600

local function clamp(value, minValue, maxValue)
  if value < minValue then
    return minValue
  end

  if value > maxValue then
    return maxValue
  end

  return value
end

local function updateRowWidths(frameWidth)
  for _, row in ipairs(CCD.rows or {}) do
    row.left:SetWidth(math.max(70, frameWidth - 102))
  end
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
      GameTooltip:AddLine(L.craft_now)
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

  local autoWidth = math.max(MAIN_FRAME_MIN_WIDTH, math.min(360, math.ceil(longestWidth) + 110))
  local targetWidth = autoWidth

  if CCD.db.frame.userSized and CCD.db.frame.width then
    local storedWidth = math.max(MAIN_FRAME_MIN_WIDTH, math.min(MAIN_FRAME_MAX_WIDTH, CCD.db.frame.width))
    if storedWidth >= autoWidth then
      targetWidth = storedWidth
    else
      CCD.db.frame.userSized = nil
      CCD.db.frame.width = autoWidth
      CCD.db.frame.height = nil
    end
  end

  CCD.frame:SetWidth(targetWidth)
  updateRowWidths(targetWidth)
end

local function saveConfigFramePosition()
  if not CCD.configFrame then
    return
  end

  local point, _, relativePoint, xOfs, yOfs = CCD.configFrame:GetPoint()
  CCD.db.configFrame.point = point
  CCD.db.configFrame.relativePoint = relativePoint
  CCD.db.configFrame.x = xOfs
  CCD.db.configFrame.y = yOfs
end

local function applyFrameLockState()
  if not CCD.frame then
    return
  end

  CCD.frame:SetMovable(not CCD.db.options.lockFrame)
  CCD.frame:RegisterForDrag("LeftButton")
  if CCD.frame.resizeButton then
    if CCD.db.options.lockFrame then
      CCD.frame.resizeButton:Hide()
    else
      CCD.frame.resizeButton:Show()
    end
  end
end

local function updateConfigFrameLayout()
  if not CCD.configFrame then
    return
  end

  local total = table.getn(CCD.configRecipeList or {})
  local visibleRows = math.min(math.max(total, 1), 12)
  local listHeight = math.max(38, 10 + (visibleRows * 20))
  local frameHeight = 296 + listHeight

  CCD.configFrame.listBg:SetHeight(listHeight)
  CCD.configFrame.testButton:ClearAllPoints()
  CCD.configFrame.testButton:SetPoint("BOTTOM", CCD.configFrame, "BOTTOM", 0, 44)
  CCD.configFrame.saveButton:ClearAllPoints()
  CCD.configFrame.saveButton:SetPoint("BOTTOM", CCD.configFrame, "BOTTOM", 0, 16)
  CCD.configFrame:SetHeight(frameHeight)
end

local function updateConfigRecipeList()
  if not CCD.configFrame or not CCD.configFrame:IsShown() then
    return
  end

  CCD.configRecipeList = getConfigurableRecipes()
  updateConfigFrameLayout()
  if table.getn(CCD.configRecipeList) == 0 then
    CCD.configFrame.emptyText:Show()
  else
    CCD.configFrame.emptyText:Hide()
  end

  local rows = CCD.configRows or {}
  local total = table.getn(CCD.configRecipeList)
  local visible = table.getn(rows)
  local offset = 0

  if total > visible then
    CCD.configScroll:Show()
  else
    CCD.configScroll:Hide()
  end

  if FauxScrollFrame_GetOffset then
    FauxScrollFrame_Update(CCD.configScroll, total, visible, 18)
    offset = FauxScrollFrame_GetOffset(CCD.configScroll)
  end

  for index, row in ipairs(rows) do
    local recipeDef = CCD.configRecipeList[index + offset]
    if recipeDef then
      local recipeName = getRecipeDisplayName(recipeDef)
      local professionName = getProfessionDisplayName(recipeDef.profession)
      row.recipeId = recipeDef.id
      row.label:SetText(professionName .. ": " .. recipeName)
      row.check:SetChecked(CCD.pendingRecipeFilters[recipeDef.id] and 1 or nil)
      row:Show()
    else
      row.recipeId = nil
      row.label:SetText("")
      row.check:SetChecked(nil)
      row:Hide()
    end
  end
end

local function refreshConfigFrame()
  if not CCD.configFrame then
    return
  end

  CCD.pendingOptions = CCD.pendingOptions or {}
  CCD.pendingRecipeFilters = CCD.pendingRecipeFilters or {}

  CCD.configFrame.showMinimap:SetChecked(CCD.pendingOptions.showMinimapButton and 1 or nil)
  CCD.configFrame.lockFrame:SetChecked(CCD.pendingOptions.lockFrame and 1 or nil)
  CCD.configFrame.showHeaders:SetChecked(CCD.pendingOptions.showProfessionHeaders and 1 or nil)
  CCD.configFrame.readySound:SetChecked(CCD.pendingOptions.readySound and 1 or nil)
  CCD.configFrame.readyMessage:SetChecked(CCD.pendingOptions.readyMessage and 1 or nil)
  updateConfigRecipeList()
end

local function saveConfig()
  CCD.db.options.showMinimapButton = CCD.pendingOptions.showMinimapButton and true or false
  CCD.db.options.lockFrame = CCD.pendingOptions.lockFrame and true or false
  CCD.db.options.showProfessionHeaders = CCD.pendingOptions.showProfessionHeaders and true or false
  CCD.db.options.readySound = CCD.pendingOptions.readySound and true or false
  CCD.db.options.readyMessage = CCD.pendingOptions.readyMessage and true or false

  CCD.db.recipeFilters = CCD.db.recipeFilters or {}
  for recipeId, value in pairs(CCD.pendingRecipeFilters or {}) do
    CCD.db.recipeFilters[recipeId] = value and true or false
  end

  updateMinimapButtonVisibility()
  applyFrameLockState()
  refreshFrame()
  if CCD.configFrame then
    CCD.configFrame:Hide()
  end
end

local function createConfigFrame()
  if CCD.configFrame then
    return
  end

  local frame = CreateFrame("Frame", "CraftCooldownsConfigFrame", UIParent)
  CCD.configFrame = frame

  frame:SetWidth(420)
  frame:SetHeight(230)
  frame:SetFrameStrata("DIALOG")
  frame:SetToplevel(true)
  frame:SetClampedToScreen(true)
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function()
    this:StartMoving()
  end)
  frame:SetScript("OnDragStop", function()
    this:StopMovingOrSizing()
    saveConfigFramePosition()
  end)
  frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
  })
  frame:SetBackdropColor(0.05, 0.05, 0.05, 0.95)
  frame:SetBackdropBorderColor(0.7, 0.7, 0.7, 1.0)
  frame:Hide()
  if UISpecialFrames then
    table.insert(UISpecialFrames, "CraftCooldownsConfigFrame")
  end

  local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  title:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -10)
  title:SetText(T("options_title"))

  local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
  closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
  closeButton:SetScript("OnClick", function()
    frame:Hide()
  end)

  frame.showMinimap = CreateFrame("CheckButton", "CraftCooldownsConfigShowMinimap", frame, "UICheckButtonTemplate")
  frame.showMinimap:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -34)
  getglobal(frame.showMinimap:GetName() .. "Text"):SetText(T("options_show_minimap"))
  frame.showMinimap:SetScript("OnClick", function()
    CCD.pendingOptions.showMinimapButton = this:GetChecked() and true or false
  end)

  frame.lockFrame = CreateFrame("CheckButton", "CraftCooldownsConfigLockFrame", frame, "UICheckButtonTemplate")
  frame.lockFrame:SetPoint("TOPLEFT", frame.showMinimap, "BOTTOMLEFT", 0, -4)
  getglobal(frame.lockFrame:GetName() .. "Text"):SetText(T("options_lock_frame"))
  frame.lockFrame:SetScript("OnClick", function()
    CCD.pendingOptions.lockFrame = this:GetChecked() and true or false
  end)

  frame.showHeaders = CreateFrame("CheckButton", "CraftCooldownsConfigShowHeaders", frame, "UICheckButtonTemplate")
  frame.showHeaders:SetPoint("TOPLEFT", frame.lockFrame, "BOTTOMLEFT", 0, -4)
  getglobal(frame.showHeaders:GetName() .. "Text"):SetText(T("options_show_profession_headers"))
  frame.showHeaders:SetScript("OnClick", function()
    CCD.pendingOptions.showProfessionHeaders = this:GetChecked() and true or false
  end)

  frame.readySound = CreateFrame("CheckButton", "CraftCooldownsConfigReadySound", frame, "UICheckButtonTemplate")
  frame.readySound:SetPoint("TOPLEFT", frame.showHeaders, "BOTTOMLEFT", 0, -4)
  getglobal(frame.readySound:GetName() .. "Text"):SetText(T("options_ready_sound"))
  frame.readySound:SetScript("OnClick", function()
    CCD.pendingOptions.readySound = this:GetChecked() and true or false
  end)

  frame.readyMessage = CreateFrame("CheckButton", "CraftCooldownsConfigReadyMessage", frame, "UICheckButtonTemplate")
  frame.readyMessage:SetPoint("LEFT", frame.readySound, "RIGHT", 150, 0)
  getglobal(frame.readyMessage:GetName() .. "Text"):SetText(T("options_ready_message"))
  frame.readyMessage:SetScript("OnClick", function()
    CCD.pendingOptions.readyMessage = this:GetChecked() and true or false
  end)

  local listLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  listLabel:SetPoint("TOPLEFT", frame.readySound, "BOTTOMLEFT", 4, -38)
  listLabel:SetText(T("options_recipe_list"))

  local listBg = CreateFrame("Frame", nil, frame)
  frame.listBg = listBg
  listBg:SetPoint("TOPLEFT", listLabel, "BOTTOMLEFT", -2, -6)
  listBg:SetWidth(384)
  listBg:SetHeight(60)
  listBg:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 8,
    edgeSize = 12,
    insets = { left = 2, right = 2, top = 2, bottom = 2 },
  })
  listBg:SetBackdropColor(0.03, 0.03, 0.03, 0.85)
  listBg:SetBackdropBorderColor(0.4, 0.4, 0.4, 1.0)

  local emptyText = listBg:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  frame.emptyText = emptyText
  emptyText:SetPoint("CENTER", listBg, "CENTER", 0, 0)
  emptyText:SetText(T("no_config_recipes"))
  emptyText:Hide()

  local scroll = CreateFrame("ScrollFrame", "CraftCooldownsConfigScroll", frame, "FauxScrollFrameTemplate")
  frame.scroll = scroll
  CCD.configScroll = scroll
  scroll:SetPoint("TOPLEFT", listBg, "TOPLEFT", 0, -4)
  scroll:SetPoint("BOTTOMRIGHT", listBg, "BOTTOMRIGHT", -24, 4)
  scroll:SetScript("OnVerticalScroll", function()
    FauxScrollFrame_OnVerticalScroll(18, updateConfigRecipeList)
  end)

  CCD.configRows = CCD.configRows or {}
  for index = 1, 12 do
    local row = CreateFrame("Frame", "CraftCooldownsConfigRecipeRow" .. index, listBg)
    row:SetWidth(348)
    row:SetHeight(18)
    row:SetPoint("TOPLEFT", listBg, "TOPLEFT", 8, -8 - ((index - 1) * 20))
    row.check = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
    row.check:SetWidth(24)
    row.check:SetHeight(24)
    row.check:SetPoint("LEFT", row, "LEFT", 0, 0)
    row.label = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.label:SetPoint("LEFT", row.check, "RIGHT", 2, 0)
    row.label:SetWidth(314)
    row.label:SetJustifyH("LEFT")
    row.label:SetText("")
    row.check:SetScript("OnClick", function()
      local parent = this:GetParent()
      if parent and parent.recipeId then
        CCD.pendingRecipeFilters[parent.recipeId] = this:GetChecked() and true or false
      end
    end)
    row:Hide()
    table.insert(CCD.configRows, row)
  end

  local saveButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  frame.saveButton = saveButton
  saveButton:SetWidth(100)
  saveButton:SetHeight(22)
  saveButton:SetText(T("options_save"))
  saveButton:SetScript("OnClick", function()
    saveConfig()
  end)

  local testButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  frame.testButton = testButton
  testButton:SetWidth(100)
  testButton:SetHeight(22)
  testButton:SetText(T("options_test"))
  testButton:SetScript("OnClick", function()
    if CCD.pendingOptions.readySound then
      playReadySound()
    end
    if CCD.pendingOptions.readyMessage then
      showCenterMessage(string.format(T("ready_again"), T("test_recipe_name")))
    end
  end)

  local point = CCD.db.configFrame.point or "CENTER"
  local relativePoint = CCD.db.configFrame.relativePoint or "CENTER"
  local x = CCD.db.configFrame.x or 20
  local y = CCD.db.configFrame.y or -20
  frame:SetPoint(point, UIParent, relativePoint, x, y)
  updateConfigFrameLayout()
end

openConfigFrame = function()
  createConfigFrame()
  CCD.pendingOptions = {
    showMinimapButton = CCD.db.options.showMinimapButton and true or false,
    lockFrame = CCD.db.options.lockFrame and true or false,
    showProfessionHeaders = CCD.db.options.showProfessionHeaders and true or false,
    readySound = CCD.db.options.readySound and true or false,
    readyMessage = CCD.db.options.readyMessage and true or false,
  }
  CCD.pendingRecipeFilters = {}
  for _, recipeDef in ipairs(getConfigurableRecipes()) do
    CCD.pendingRecipeFilters[recipeDef.id] = isRecipeEnabled(recipeDef.id) and true or false
  end
  CCD.configFrame:Show()
  CCD.configFrame:Raise()
  refreshConfigFrame()
end

refreshFrame = function()
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

  local autoHeight = math.max(MAIN_FRAME_MIN_HEIGHT, 40 + (table.getn(entries) * 18) + 14)
  local height = autoHeight

  if CCD.db.frame.userSized and CCD.db.frame.height then
    local storedHeight = math.max(MAIN_FRAME_MIN_HEIGHT, math.min(MAIN_FRAME_MAX_HEIGHT, CCD.db.frame.height))
    if storedHeight >= autoHeight then
      height = storedHeight
    else
      CCD.db.frame.userSized = nil
      CCD.db.frame.height = autoHeight
      if not CCD.db.frame.width then
        CCD.db.frame.width = CCD.frame:GetWidth()
      end
    end
  end

  CCD.frame:SetHeight(height)
end

local function saveFramePosition()
  local point, _, relativePoint, xOfs, yOfs = CCD.frame:GetPoint()
  CCD.db.frame.point = point
  CCD.db.frame.relativePoint = relativePoint
  CCD.db.frame.x = xOfs
  CCD.db.frame.y = yOfs
  CCD.db.frame.width = CCD.frame:GetWidth()
  CCD.db.frame.height = CCD.frame:GetHeight()
end

local function stopFrameResize()
  CCD.isResizingFrame = nil

  if CCD.frame and CCD.frame.resizeButton then
    CCD.frame.resizeButton:SetScript("OnUpdate", nil)
  end

  if CCD.frame then
    saveFramePosition()
    refreshFrame()
  end
end

local function startFrameResize()
  if not CCD.frame or CCD.db.options.lockFrame then
    return
  end

  local cursorX, cursorY = GetCursorPosition()
  local scale = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
  cursorX = (cursorX or 0) / scale
  cursorY = (cursorY or 0) / scale

  CCD.db.frame.userSized = true
  CCD.isResizingFrame = {
    startCursorX = cursorX,
    startCursorY = cursorY,
    startWidth = CCD.frame:GetWidth() or MAIN_FRAME_MIN_WIDTH,
    startHeight = CCD.frame:GetHeight() or MAIN_FRAME_MIN_HEIGHT,
  }

  CCD.frame.resizeButton:SetScript("OnUpdate", function()
    if not CCD.isResizingFrame then
      this:SetScript("OnUpdate", nil)
      return
    end

    local currentX, currentY = GetCursorPosition()
    currentX = (currentX or 0) / scale
    currentY = (currentY or 0) / scale

    local width = clamp(CCD.isResizingFrame.startWidth + (currentX - CCD.isResizingFrame.startCursorX), MAIN_FRAME_MIN_WIDTH, MAIN_FRAME_MAX_WIDTH)
    local height = clamp(CCD.isResizingFrame.startHeight + (CCD.isResizingFrame.startCursorY - currentY), MAIN_FRAME_MIN_HEIGHT, MAIN_FRAME_MAX_HEIGHT)

    CCD.frame:SetWidth(width)
    CCD.frame:SetHeight(height)
    updateRowWidths(width)
  end)
end

local function createFrame()
  if CCD.frame then
    return
  end

  local frame = CreateFrame("Frame", "CraftCooldownsFrame", UIParent)
  CCD.frame = frame

  frame:SetWidth(CCD.db.frame.width or MAIN_FRAME_MIN_WIDTH)
  frame:SetHeight(CCD.db.frame.height or 140)
  if frame.SetMinResize then
    frame:SetMinResize(MAIN_FRAME_MIN_WIDTH, MAIN_FRAME_MIN_HEIGHT)
  end
  if frame.SetMaxResize then
    frame:SetMaxResize(MAIN_FRAME_MAX_WIDTH, MAIN_FRAME_MAX_HEIGHT)
  end
  if frame.SetResizable then
    frame:SetResizable(true)
  end
  frame:SetClampedToScreen(true)
  if frame.SetClipsChildren then
    frame:SetClipsChildren(true)
  end
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function()
    if CCD.db.options.lockFrame then
      return
    end
    this:StartMoving()
  end)
  frame:SetScript("OnDragStop", function()
    this:StopMovingOrSizing()
    saveFramePosition()
  end)
  frame:SetScript("OnSizeChanged", function()
    updateRowWidths(this:GetWidth() or MAIN_FRAME_MIN_WIDTH)
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
  title:SetText(L.title)

  frame.measureFS = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  frame.measureFS:Hide()

  local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
  closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
  closeButton:SetScript("OnClick", function()
    frame:Hide()
    CCD.db.visible = false
  end)

  local optionsButton = CreateFrame("Button", nil, frame)
  frame.optionsButton = optionsButton
  optionsButton:SetWidth(18)
  optionsButton:SetHeight(18)
  optionsButton:SetPoint("RIGHT", closeButton, "LEFT", 2, 0)
  optionsButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
  optionsButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
  optionsButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
  optionsButton:GetNormalTexture():SetTexCoord(0.16, 0.84, 0.17, 0.83)
  optionsButton:GetPushedTexture():SetTexCoord(0.16, 0.84, 0.17, 0.83)
  optionsButton:GetHighlightTexture():SetTexCoord(0.16, 0.84, 0.17, 0.83)
  local optionsIcon = optionsButton:CreateTexture(nil, "ARTWORK")
  optionsButton.icon = optionsIcon
  optionsIcon:SetTexture("Interface\\Icons\\INV_Gizmo_02")
  optionsIcon:SetWidth(9)
  optionsIcon:SetHeight(9)
  optionsIcon:SetPoint("CENTER", optionsButton, "CENTER", 0, 0)
  optionsIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  optionsIcon:SetVertexColor(1, 1, 1)
  optionsButton:SetScript("OnClick", function()
    openConfigFrame()
  end)
  optionsButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT")
    GameTooltip:AddLine(T("options_button_tooltip"))
    GameTooltip:Show()
  end)
  optionsButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  local resizeButton = CreateFrame("Frame", nil, frame)
  frame.resizeButton = resizeButton
  resizeButton:SetWidth(20)
  resizeButton:SetHeight(20)
  resizeButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
  resizeButton:SetFrameStrata("HIGH")
  resizeButton:SetFrameLevel(frame:GetFrameLevel() + 5)
  resizeButton:EnableMouse(true)
  local resizeBg = resizeButton:CreateTexture(nil, "BACKGROUND")
  resizeButton.bg = resizeBg
  resizeBg:SetTexture("Interface\\Buttons\\WHITE8X8")
  resizeBg:SetPoint("TOPLEFT", resizeButton, "TOPLEFT", 4, -4)
  resizeBg:SetPoint("BOTTOMRIGHT", resizeButton, "BOTTOMRIGHT", -4, 4)
  resizeBg:SetVertexColor(0.08, 0.08, 0.08, 0.45)
  local resizeIcon = resizeButton:CreateTexture(nil, "ARTWORK")
  resizeButton.icon = resizeIcon
  resizeIcon:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  resizeIcon:SetAllPoints()
  resizeIcon:SetVertexColor(0.9, 0.9, 0.9)
  local resizeHighlight = resizeButton:CreateTexture(nil, "HIGHLIGHT")
  resizeButton.highlight = resizeHighlight
  resizeHighlight:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  resizeHighlight:SetAllPoints()
  resizeHighlight:SetVertexColor(1.0, 1.0, 1.0)
  resizeHighlight:SetBlendMode("ADD")
  if resizeButton.SetHitRectInsets then
    resizeButton:SetHitRectInsets(-4, -1, -1, -4)
  end
  resizeButton:SetScript("OnMouseDown", function()
    if this.icon then
      this.icon:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      this.icon:SetVertexColor(1.0, 0.82, 0.0)
    end
    startFrameResize()
  end)
  resizeButton:SetScript("OnMouseUp", function()
    if this.icon then
      this.icon:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
      this.icon:SetVertexColor(0.9, 0.9, 0.9)
    end
    stopFrameResize()
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

  applyFrameLockState()
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

updateMinimapButtonVisibility = function()
  if not CCD.minimapButton then
    return
  end

  if CCD.db.options.showMinimapButton then
    CCD.minimapButton:Show()
    updateMinimapButtonPosition()
  else
    CCD.minimapButton:Hide()
  end
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
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

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
    if arg1 == "RightButton" then
      openConfigFrame()
    else
      toggleFrame()
    end
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
    GameTooltip:AddLine(L.title)
    GameTooltip:AddLine(L.minimap_left_click, 1, 1, 1)
    GameTooltip:AddLine(T("minimap_right_click"), 1, 1, 1)
    GameTooltip:AddLine(L.minimap_drag, 0.7, 0.7, 0.7)
    GameTooltip:Show()
  end)

  button:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  updateMinimapButtonVisibility()
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

  if msg == "config" or msg == "options" then
    openConfigFrame()
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
    updateReadyNotifications()
    refreshFrame()
  end
end)

CCD:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == addonName then
    initializeDatabase()
    updateProfessionList()
    createFrame()
    createMinimapButton()
    updateMinimapButtonVisibility()
    refreshFrame()
  elseif event == "PLAYER_LOGIN" then
    updateProfessionList()
    updateMinimapButtonPosition()
    updateMinimapButtonVisibility()
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
