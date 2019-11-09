--- ====================== ACTION HEADER ============================ ---
local Action                                 = Action
local TeamCache                              = Action.TeamCache
local EnemyTeam                              = Action.EnemyTeam
local FriendlyTeam                           = Action.FriendlyTeam
--local HealingEngine                        = Action.HealingEngine
local LoC                                    = Action.LossOfControl
local Player                                 = Action.Player
local MultiUnits                             = Action.MultiUnits
local UnitCooldown                           = Action.UnitCooldown
local Unit                                   = Action.Unit
local Pet                                    = LibStub("PetLibrary")
local Azerite                                = LibStub("AzeriteTraits")
local setmetatable                           = setmetatable

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_PROTECTION] = {
  LightsJudgment                         = Action.Create({Type = "Spell", ID = 255647 }),
  Fireblood                              = Action.Create({Type = "Spell", ID = 265221 }),
  AvengingWrathBuff                      = Action.Create({Type = "Spell", ID = 31884 }),
  Seraphim                               = Action.Create({Type = "Spell", ID = 152262 }),
  ShieldoftheRighteous                   = Action.Create({Type = "Spell", ID = 53600 }),
  AvengingWrath                          = Action.Create({Type = "Spell", ID = 31884 }),
  SeraphimBuff                           = Action.Create({Type = "Spell", ID = 152262 }),
  BastionofLight                         = Action.Create({Type = "Spell", ID = 204035 }),
  AvengersValorBuff                      = Action.Create({Type = "Spell", ID =  }),
  Consecration                           = Action.Create({Type = "Spell", ID = 26573 }),
  Judgment                               = Action.Create({Type = "Spell", ID = 20271 }),
  CrusadersJudgment                      = Action.Create({Type = "Spell", ID =  }),
  AvengersShield                         = Action.Create({Type = "Spell", ID = 31935 }),
  BlessedHammer                          = Action.Create({Type = "Spell", ID = 204019 }),
  HammeroftheRighteous                   = Action.Create({Type = "Spell", ID = 53595 })
  -- Trinkets
  TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }), 
  TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
  AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }), 
  PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }), 
  RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }), 
  ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }), 
  AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }), 
  TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }), 
  VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }), 
  -- Potions
  PotionofUnbridledFury                  = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }), 
  PotionTest                             = Action.Create({ Type = "Potion", ID = 142117, QueueForbidden = true }), 
  -- Trinkets
  GenericTrinket1                        = Action.Create({ Type = "Trinket", ID = 114616, QueueForbidden = true }),
  GenericTrinket2                        = Action.Create({ Type = "Trinket", ID = 114081, QueueForbidden = true }),
  TrinketTest                            = Action.Create({ Type = "Trinket", ID = 122530, QueueForbidden = true }),
  TrinketTest2                           = Action.Create({ Type = "Trinket", ID = 159611, QueueForbidden = true }), 
  AzsharasFontofPower                    = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
  PocketsizedComputationDevice           = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
  RotcrustedVoodooDoll                   = Action.Create({ Type = "Trinket", ID = 159624, QueueForbidden = true }),
  ShiverVenomRelic                       = Action.Create({ Type = "Trinket", ID = 168905, QueueForbidden = true }),
  AquipotentNautilus                     = Action.Create({ Type = "Trinket", ID = 169305, QueueForbidden = true }),
  TidestormCodex                         = Action.Create({ Type = "Trinket", ID = 165576, QueueForbidden = true }),
  VialofStorms                           = Action.Create({ Type = "Trinket", ID = 158224, QueueForbidden = true }),
  GalecallersBoon                        = Action.Create({ Type = "Trinket", ID = 159614, QueueForbidden = true }),
  InvocationOfYulon                      = Action.Create({ Type = "Trinket", ID = 165568, QueueForbidden = true }),
  LustrousGoldenPlumage                  = Action.Create({ Type = "Trinket", ID = 159617, QueueForbidden = true }),
  ComputationDevice                      = Action.Create({ Type = "Trinket", ID = 167555, QueueForbidden = true }),
  VigorTrinket                           = Action.Create({ Type = "Trinket", ID = 165572, QueueForbidden = true }),
  FontOfPower                            = Action.Create({ Type = "Trinket", ID = 169314, QueueForbidden = true }),
  RazorCoral                             = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
  AshvanesRazorCoral                     = Action.Create({ Type = "Trinket", ID = 169311, QueueForbidden = true }),
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_PROTECTION)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_PROTECTION], { __index = Action })



local EnemyRanges = {}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end


local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
	--------------------
	---  VARIABLES   ---
	--------------------
   local isMoving = A.Player:IsMoving()
   local inCombat = Unit("player"):CombatTime() > 0
   local ShouldStop = Action.ShouldStop()
   local Pull = Action.BossMods_Pulling()
   local CanMultidot = HandleMultidots()
   local unit = "player"
   ------------------------------------------------------
   ---------------- ENEMY UNIT ROTATION -----------------
   ------------------------------------------------------
   local function EnemyRotation(unit)
     local Precombat, Cooldowns
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- potion
    if A.BattlePotionofStamina:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofStamina:Show(icon)
    end
    -- lights_judgment
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
        return A.LightsJudgment:Show(icon)
    end
    end
    local function Cooldowns(unit)
        -- fireblood,if=buff.avenging_wrath.up
    if A.Fireblood:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.AvengingWrathBuff)) then
        return A.Fireblood:Show(icon)
    end
    -- seraphim,if=cooldown.shield_of_the_righteous.charges_fractional>=2
    if A.Seraphim:IsReady(unit) and (A.ShieldoftheRighteous:ChargesFractionalP() >= 2) then
        return A.Seraphim:Show(icon)
    end
    -- avenging_wrath,if=buff.seraphim.up|cooldown.seraphim.remains<2|!talent.seraphim.enabled
    if A.AvengingWrath:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff) or A.Seraphim:GetCooldown() < 2 or not A.Seraphim:IsSpellLearned()) then
        return A.AvengingWrath:Show(icon)
    end
    -- bastion_of_light,if=cooldown.shield_of_the_righteous.charges_fractional<=0.5
    if A.BastionofLight:IsReady(unit) and (A.ShieldoftheRighteous:ChargesFractionalP() <= 0.5) then
        return A.BastionofLight:Show(icon)
    end
    -- potion,if=buff.avenging_wrath.up
    if A.BattlePotionofStamina:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.AvengingWrathBuff)) then
      A.BattlePotionofStamina:Show(icon)
    end
    -- use_items,if=buff.seraphim.up|!talent.seraphim.enabled
    -- use_item,name=merekthas_fang,if=!buff.avenging_wrath.up&(buff.seraphim.up|!talent.seraphim.enabled)
    if A.MerekthasFang:IsReady(unit) and (not Unit("player"):HasBuffs(A.AvengingWrathBuff) and (Unit("player"):HasBuffs(A.SeraphimBuff) or not A.Seraphim:IsSpellLearned())) then
      A.MerekthasFang:Show(icon)
    end
    -- use_item,name=razdunks_big_red_button
    if A.RazdunksBigRedButton:IsReady(unit) then
      A.RazdunksBigRedButton:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- auto_attack
    -- call_action_list,name=cooldowns
    if (true) then
      local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
    end
    -- shield_of_the_righteous,if=(buff.avengers_valor.up&cooldown.shield_of_the_righteous.charges_fractional>=2.5)&(cooldown.seraphim.remains>gcd|!talent.seraphim.enabled)
    if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengersValorBuff) and A.ShieldoftheRighteous:ChargesFractionalP() >= 2.5) and (A.Seraphim:GetCooldown() > A.GetGCD() or not A.Seraphim:IsSpellLearned())) then
        return A.ShieldoftheRighteous:Show(icon)
    end
    -- shield_of_the_righteous,if=(buff.avenging_wrath.up&!talent.seraphim.enabled)|buff.seraphim.up&buff.avengers_valor.up
    if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengingWrathBuff) and not A.Seraphim:IsSpellLearned()) or Unit("player"):HasBuffs(A.SeraphimBuff) and Unit("player"):HasBuffs(A.AvengersValorBuff)) then
        return A.ShieldoftheRighteous:Show(icon)
    end
    -- shield_of_the_righteous,if=(buff.avenging_wrath.up&buff.avenging_wrath.remains<4&!talent.seraphim.enabled)|(buff.seraphim.remains<4&buff.seraphim.up)
    if A.ShieldoftheRighteous:IsReady(unit) and ((Unit("player"):HasBuffs(A.AvengingWrathBuff) and Unit("player"):HasBuffs(A.AvengingWrathBuff) < 4 and not A.Seraphim:IsSpellLearned()) or (Unit("player"):HasBuffs(A.SeraphimBuff) < 4 and Unit("player"):HasBuffs(A.SeraphimBuff))) then
        return A.ShieldoftheRighteous:Show(icon)
    end
    -- lights_judgment,if=buff.seraphim.up&buff.seraphim.remains<3
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.SeraphimBuff) and Unit("player"):HasBuffs(A.SeraphimBuff) < 3) then
        return A.LightsJudgment:Show(icon)
    end
    -- consecration,if=!consecration.up
    if A.Consecration:IsReady(unit) and (not bool(consecration.up)) then
        return A.Consecration:Show(icon)
    end
    -- judgment,if=(cooldown.judgment.remains<gcd&cooldown.judgment.charges_fractional>1&cooldown_react)|!talent.crusaders_judgment.enabled
    if A.Judgment:IsReady(unit) and ((A.Judgment:GetCooldown() < A.GetGCD() and A.Judgment:ChargesFractionalP() > 1 and A.Judgment:GetCooldown() == 0) or not A.CrusadersJudgment:IsSpellLearned()) then
        return A.Judgment:Show(icon)
    end
    -- avengers_shield,if=cooldown_react
    if A.AvengersShield:IsReady(unit) and (A.AvengersShield:GetCooldown() == 0) then
        return A.AvengersShield:Show(icon)
    end
    -- judgment,if=cooldown_react|!talent.crusaders_judgment.enabled
    if A.Judgment:IsReady(unit) and (A.Judgment:GetCooldown() == 0 or not A.CrusadersJudgment:IsSpellLearned()) then
        return A.Judgment:Show(icon)
    end
    -- lights_judgment,if=!talent.seraphim.enabled|buff.seraphim.up
    if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and (not A.Seraphim:IsSpellLearned() or Unit("player"):HasBuffs(A.SeraphimBuff)) then
        return A.LightsJudgment:Show(icon)
    end
    -- blessed_hammer,strikes=3
    if A.BlessedHammer:IsReady(unit) then
        return A.BlessedHammer:Show(icon)
    end
    -- hammer_of_the_righteous
    if A.HammeroftheRighteous:IsReady(unit) then
        return A.HammeroftheRighteous:Show(icon)
    end
    -- consecration
    if A.Consecration:IsReady(unit) then
        return A.Consecration:Show(icon)
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 