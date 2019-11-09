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
Action[ACTION_CONST_DRUID_BALANCE] = {
  StreakingStars                         = Action.Create({Type = "Spell", ID = 272871 }),
  ArcanicPulsarBuff                      = Action.Create({Type = "Spell", ID = 287790 }),
  ArcanicPulsar                          = Action.Create({Type = "Spell", ID = 287773 }),
  StarlordBuff                           = Action.Create({Type = "Spell", ID = 279709 }),
  Starlord                               = Action.Create({Type = "Spell", ID = 202345 }),
  TwinMoons                              = Action.Create({Type = "Spell", ID = 279620 }),
  MoonkinForm                            = Action.Create({Type = "Spell", ID = 24858 }),
  SolarWrath                             = Action.Create({Type = "Spell", ID = 190984 }),
  Starsurge                              = Action.Create({Type = "Spell", ID = 78674 }),
  CelestialAlignmentBuff                 = Action.Create({Type = "Spell", ID = 194223 }),
  IncarnationBuff                        = Action.Create({Type = "Spell", ID = 102560 }),
  Berserking                             = Action.Create({Type = "Spell", ID = 26297 }),
  CaIncBuff                              = Action.Create({Type = "Spell", ID =  }),
  MoonfireDebuff                         = Action.Create({Type = "Spell", ID = 164812 }),
  SunfireDebuff                          = Action.Create({Type = "Spell", ID = 164815 }),
  StellarFlare                           = Action.Create({Type = "Spell", ID = 202347 }),
  StellarFlareDebuff                     = Action.Create({Type = "Spell", ID = 202347 }),
  GuardianofAzeroth                      = Action.Create({Type = "Spell", ID =  }),
  ShiverVenomDebuff                      = Action.Create({Type = "Spell", ID =  }),
  BloodoftheEnemy                        = Action.Create({Type = "Spell", ID =  }),
  CaInc                                  = Action.Create({Type = "Spell", ID =  }),
  MemoryofLucidDreams                    = Action.Create({Type = "Spell", ID =  }),
  PurifyingBlast                         = Action.Create({Type = "Spell", ID =  }),
  RippleInSpace                          = Action.Create({Type = "Spell", ID =  }),
  ConcentratedFlame                      = Action.Create({Type = "Spell", ID =  }),
  TheUnboundForce                        = Action.Create({Type = "Spell", ID =  }),
  RecklessForceBuff                      = Action.Create({Type = "Spell", ID =  }),
  WorldveinResonance                     = Action.Create({Type = "Spell", ID =  }),
  FocusedAzeriteBeam                     = Action.Create({Type = "Spell", ID =  }),
  Thorns                                 = Action.Create({Type = "Spell", ID =  }),
  WarriorofElune                         = Action.Create({Type = "Spell", ID = 202425 }),
  Innervate                              = Action.Create({Type = "Spell", ID = 29166 }),
  LivelySpirit                           = Action.Create({Type = "Spell", ID = 279642 }),
  Incarnation                            = Action.Create({Type = "Spell", ID = 102560 }),
  CelestialAlignment                     = Action.Create({Type = "Spell", ID = 194223 }),
  ForceofNature                          = Action.Create({Type = "Spell", ID = 205636 }),
  MemoryofLucidDreamsBuff                = Action.Create({Type = "Spell", ID =  }),
  LivelySpiritBuff                       = Action.Create({Type = "Spell", ID = 279646 }),
  FuryofElune                            = Action.Create({Type = "Spell", ID = 202770 }),
  Starfall                               = Action.Create({Type = "Spell", ID = 191034 }),
  LunarEmpowermentBuff                   = Action.Create({Type = "Spell", ID = 164547 }),
  SolarEmpowermentBuff                   = Action.Create({Type = "Spell", ID = 164545 }),
  Sunfire                                = Action.Create({Type = "Spell", ID = 93402 }),
  Moonfire                               = Action.Create({Type = "Spell", ID = 8921 }),
  NewMoon                                = Action.Create({Type = "Spell", ID = 274281 }),
  HalfMoon                               = Action.Create({Type = "Spell", ID = 274282 }),
  FullMoon                               = Action.Create({Type = "Spell", ID = 274283 }),
  LunarStrike                            = Action.Create({Type = "Spell", ID = 194153 }),
  WarriorofEluneBuff                     = Action.Create({Type = "Spell", ID = 202425 })
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
Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })


-- Variables
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

HL:RegisterForEvent(function()
  VarAzSs = 0
  VarAzAp = 0
  VarSfTargets = 0
end, "PLAYER_REGEN_ENABLED")

local EnemyRanges = {40}
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

local function FutureAstralPower()
  local AstralPower=Player:AstralPower()
  if not Player:IsCasting() then
    return AstralPower
  else
    if Player:IsCasting(S.NewnMoon) then
      return AstralPower + 10
    elseif Player:IsCasting(S.HalfMoon) then
      return AstralPower + 20
    elseif Player:IsCasting(S.FullMoon) then
      return AstralPower + 40
    elseif Player:IsCasting(S.StellarFlare) then
      return AstralPower + 8
    elseif Player:IsCasting(S.SolarWrath) then
      return AstralPower + 8
    elseif Player:IsCasting(S.LunarStrike) then
      return AstralPower + 12
    else
      return AstralPower
    end
  end
end


local function EvaluateCycleAzsharasFontofPower67(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff) and Unit(unit):HasDeBuffs(A.SunfireDebuff) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff))) and (not Unit("player"):HasBuffs(A.CaIncBuff))
end

local function EvaluateCycleGuardianofAzeroth84(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff) and Unit(unit):HasDeBuffs(A.SunfireDebuff) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff))) and ((not A.Starlord:IsSpellLearned() or Unit("player"):HasBuffs(A.StarlordBuff)) and not Unit("player"):HasBuffs(A.CaIncBuff))
end

local function EvaluateCycle105(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff) and Unit(unit):HasDeBuffs(A.SunfireDebuff) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff))) and (not Unit("player"):HasBuffs(A.CaIncBuff))
end

local function EvaluateCycleShiverVenomRelic122(unit)
    return (Unit(unit):HasDeBuffsStacks(A.ShiverVenomDebuff) >= 5) and (not Unit("player"):HasBuffs(A.CaIncBuff) and not Unit("player"):HasHeroism)
end

local function EvaluateCycleMemoryofLucidDreams137(unit)
    return (Unit(unit):HasDeBuffs(A.SunfireDebuff) > 10 and Unit(unit):HasDeBuffs(A.MoonfireDebuff) > 10 and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff) > 10)) and (not Unit("player"):HasBuffs(A.CaIncBuff) and (FutureAstralPower < 25 or A.CaInc:GetCooldown() > 30))
end

local function EvaluateCycleTheUnboundForce162(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff) and Unit(unit):HasDeBuffs(A.SunfireDebuff) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff))) and (Unit("player"):HasBuffs(A.RecklessForceBuff))
end

local function EvaluateCycleFocusedAzeriteBeam181(unit)
    return (Unit(unit):HasDeBuffs(A.MoonfireDebuff) and Unit(unit):HasDeBuffs(A.SunfireDebuff) and (not A.StellarFlare:IsSpellLearned() or Unit(unit):HasDeBuffs(A.StellarFlareDebuff))) and ((not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff)))
end

local function EvaluateCycleIncarnation227(unit)
    return (Unit(unit):HasDeBuffs(A.SunfireDebuff) > 8 and Unit(unit):HasDeBuffs(A.MoonfireDebuff) > 12 and (Unit(unit):HasDeBuffs(A.StellarFlareDebuff) > 6 or not A.StellarFlare:IsSpellLearned())) and (not Unit("player"):HasBuffs(A.CaIncBuff) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) or ((A.MemoryofLucidDreams:GetCooldown() > 20 or not bool(essence.memory_of_lucid_dreams.major)) and bool(ap_check))) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) or bool(ap_check)))
end

local function EvaluateCycleCelestialAlignment250(unit)
    return ((Unit(unit):HasDeBuffs(A.SunfireDebuff) > 2 and Unit(unit):HasDeBuffs(A.MoonfireDebuff) and (Unit(unit):HasDeBuffs(A.StellarFlareDebuff) or not A.StellarFlare:IsSpellLearned()))) and (not Unit("player"):HasBuffs(A.CaIncBuff) and (not A.Starlord:IsSpellLearned() or Unit("player"):HasBuffs(A.StarlordBuff)) and (Unit("player"):HasBuffs(A.MemoryofLucidDreamsBuff) or ((A.MemoryofLucidDreams:GetCooldown() > 20 or not bool(essence.memory_of_lucid_dreams.major)) and bool(ap_check))) and (not A.LivelySpirit:GetAzeriteRank or Unit("player"):HasBuffs(A.LivelySpiritBuff)))
end

local function EvaluateCycleSunfire373(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.SunfireDebuff)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste)) * MultiUnits:GetByRangeInCombat(40, 5, 10) >= math.ceil (math.floor (2 / MultiUnits:GetByRangeInCombat(40, 5, 10)) * 1.5) + 2 * MultiUnits:GetByRangeInCombat(40, 5, 10) and (MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 + num(A.TwinMoons:IsSpellLearned()) or Unit(unit):HasDeBuffs(A.MoonfireDebuff)) and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(prev.sunfire)) and (Unit("player"):HasBuffs(A.CaIncBuff) > Unit(unit):HasDeBuffs(A.SunfireDebuff) or not Unit("player"):HasBuffs(A.CaIncBuff)))
end

local function EvaluateCycleMoonfire436(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.MoonfireDebuff)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste)) * MultiUnits:GetByRangeInCombat(40, 5, 10) >= 6 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(prev.moonfire)) and (Unit("player"):HasBuffs(A.CaIncBuff) > Unit(unit):HasDeBuffs(A.MoonfireDebuff) or not Unit("player"):HasBuffs(A.CaIncBuff)))
end

local function EvaluateCycleStellarFlare471(unit)
    return (Unit(unit):HasDeBuffsRefreshable(A.StellarFlareDebuff)) and (bool(ap_check) and math.floor (Unit(unit):TimeToDie() / (2 * Player:SpellHaste)) >= 5 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(prev.stellar_flare)))
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
     local Precombat
   UpdateRanges()
   Everyone.AoEToggleEnemiesUpdate()
       local function Precombat(unit)
        -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- variable,name=az_ss,value=azerite.streaking_stars.rank
    if (true) then
      VarAzSs = A.StreakingStars:GetAzeriteRank
    end
    -- variable,name=az_ap,value=azerite.arcanic_pulsar.rank
    if (true) then
      VarAzAp = A.ArcanicPulsar:GetAzeriteRank
    end
    -- variable,name=sf_targets,value=4
    if (true) then
      VarSfTargets = 4
    end
    -- variable,name=sf_targets,op=add,value=1,if=azerite.arcanic_pulsar.enabled
    if (A.ArcanicPulsar:GetAzeriteRank) then
      VarSfTargets = VarSfTargets + 1
    end
    -- variable,name=sf_targets,op=add,value=1,if=talent.starlord.enabled
    if (A.Starlord:IsSpellLearned()) then
      VarSfTargets = VarSfTargets + 1
    end
    -- variable,name=sf_targets,op=add,value=1,if=azerite.streaking_stars.rank>2&azerite.arcanic_pulsar.enabled
    if (A.StreakingStars:GetAzeriteRank > 2 and A.ArcanicPulsar:GetAzeriteRank) then
      VarSfTargets = VarSfTargets + 1
    end
    -- variable,name=sf_targets,op=sub,value=1,if=!talent.twin_moons.enabled
    if (not A.TwinMoons:IsSpellLearned()) then
      VarSfTargets = VarSfTargets - 1
    end
    -- moonkin_form
    if A.MoonkinForm:IsReady(unit) then
        return A.MoonkinForm:Show(icon)
    end
    -- use_item,name=azsharas_font_of_power
    if A.AzsharasFontofPower:IsReady(unit) then
      A.AzsharasFontofPower:Show(icon)
    end
    -- potion,dynamic_prepot=1
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- solar_wrath
    if A.SolarWrath:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
        return A.SolarWrath:Show(icon)
    end
    -- solar_wrath
    if A.SolarWrath:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
        return A.SolarWrath:Show(icon)
    end
    -- starsurge
    if A.Starsurge:IsReady(unit) then
        return A.Starsurge:Show(icon)
    end
    end
     -- call precombat
  if not inCombat and Unit(unit):IsExists() and Action.GetToggle(1, "DBM") and unit ~= "mouseover" and not Unit(unit):IsTotem() then 
    local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
  end
     if Everyone.TargetIsValid() then
          -- potion,if=buff.celestial_alignment.remains>13|buff.incarnation.remains>16.5
    if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):HasBuffs(A.CelestialAlignmentBuff) > 13 or Unit("player"):HasBuffs(A.IncarnationBuff) > 16.5) then
      A.BattlePotionofIntellect:Show(icon)
    end
    -- berserking,if=buff.ca_inc.up
    if A.Berserking:IsReady(unit) and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.CaIncBuff)) then
        return A.Berserking:Show(icon)
    end
    -- use_item,name=azsharas_font_of_power,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
    if A.AzsharasFontofPower:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.AzsharasFontofPower, 40, EvaluateCycleAzsharasFontofPower67) then
            return A.AzsharasFontofPower:Show(icon) 
        end
    end
    -- guardian_of_azeroth,if=(!talent.starlord.enabled|buff.starlord.up)&!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
    if A.GuardianofAzeroth:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.GuardianofAzeroth, 40, EvaluateCycleGuardianofAzeroth84) then
            return A.GuardianofAzeroth:Show(icon) 
        end
    end
    -- use_item,effect_name=cyclotronic_blast,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
    if A.:IsReady(unit) then
        if Action.Utils.CastTargetIf(A., 40, EvaluateCycle105) then
            return A.:Show(icon) 
        end
    end
    -- use_item,name=shiver_venom_relic,if=!buff.ca_inc.up&!buff.bloodlust.up,target_if=dot.shiver_venom.stack>=5
    if A.ShiverVenomRelic:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.ShiverVenomRelic, 40, EvaluateCycleShiverVenomRelic122) then
            return A.ShiverVenomRelic:Show(icon) 
        end
    end
    -- blood_of_the_enemy,if=cooldown.ca_inc.remains>30
    if A.BloodoftheEnemy:IsReady(unit) and (A.CaInc:GetCooldown() > 30) then
        return A.BloodoftheEnemy:Show(icon)
    end
    -- memory_of_lucid_dreams,if=!buff.ca_inc.up&(astral_power<25|cooldown.ca_inc.remains>30),target_if=dot.sunfire.remains>10&dot.moonfire.remains>10&(!talent.stellar_flare.enabled|dot.stellar_flare.remains>10)
    if A.MemoryofLucidDreams:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.MemoryofLucidDreams, 40, EvaluateCycleMemoryofLucidDreams137) then
            return A.MemoryofLucidDreams:Show(icon) 
        end
    end
    -- purifying_blast
    if A.PurifyingBlast:IsReady(unit) then
        return A.PurifyingBlast:Show(icon)
    end
    -- ripple_in_space
    if A.RippleInSpace:IsReady(unit) then
        return A.RippleInSpace:Show(icon)
    end
    -- concentrated_flame
    if A.ConcentratedFlame:IsReady(unit) then
        return A.ConcentratedFlame:Show(icon)
    end
    -- the_unbound_force,if=buff.reckless_force.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
    if A.TheUnboundForce:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.TheUnboundForce, 40, EvaluateCycleTheUnboundForce162) then
            return A.TheUnboundForce:Show(icon) 
        end
    end
    -- worldvein_resonance
    if A.WorldveinResonance:IsReady(unit) then
        return A.WorldveinResonance:Show(icon)
    end
    -- focused_azerite_beam,if=(!variable.az_ss|!buff.ca_inc.up),target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
    if A.FocusedAzeriteBeam:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.FocusedAzeriteBeam, 40, EvaluateCycleFocusedAzeriteBeam181) then
            return A.FocusedAzeriteBeam:Show(icon) 
        end
    end
    -- thorns
    if A.Thorns:IsReady(unit) then
        return A.Thorns:Show(icon)
    end
    -- use_items,slots=trinket1,if=!trinket.1.has_proc.any|buff.ca_inc.up
    -- use_items,slots=trinket2,if=!trinket.2.has_proc.any|buff.ca_inc.up
    -- use_items
    -- warrior_of_elune
    if A.WarriorofElune:IsReady(unit) then
        return A.WarriorofElune:Show(icon)
    end
    -- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
    if A.Innervate:IsReady(unit) and (A.LivelySpirit:GetAzeriteRank and (A.Incarnation:GetCooldown() < 2 or A.CelestialAlignment:GetCooldown() < 12)) then
        return A.Innervate:Show(icon)
    end
    -- force_of_nature,if=(variable.az_ss&!buff.ca_inc.up|!variable.az_ss&(buff.ca_inc.up|cooldown.ca_inc.remains>30))&ap_check
    if A.ForceofNature:IsReady(unit) and ((bool(VarAzSs) and not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(VarAzSs) and (Unit("player"):HasBuffs(A.CaIncBuff) or A.CaInc:GetCooldown() > 30)) and bool(ap_check)) then
        return A.ForceofNature:Show(icon)
    end
    -- incarnation,if=!buff.ca_inc.up&(buff.memory_of_lucid_dreams.up|((cooldown.memory_of_lucid_dreams.remains>20|!essence.memory_of_lucid_dreams.major)&ap_check))&(buff.memory_of_lucid_dreams.up|ap_check),target_if=dot.sunfire.remains>8&dot.moonfire.remains>12&(dot.stellar_flare.remains>6|!talent.stellar_flare.enabled)
    if A.Incarnation:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Incarnation, 40, EvaluateCycleIncarnation227) then
            return A.Incarnation:Show(icon) 
        end
    end
    -- celestial_alignment,if=!buff.ca_inc.up&(!talent.starlord.enabled|buff.starlord.up)&(buff.memory_of_lucid_dreams.up|((cooldown.memory_of_lucid_dreams.remains>20|!essence.memory_of_lucid_dreams.major)&ap_check))&(!azerite.lively_spirit.enabled|buff.lively_spirit.up),target_if=(dot.sunfire.remains>2&dot.moonfire.ticking&(dot.stellar_flare.ticking|!talent.stellar_flare.enabled))
    if A.CelestialAlignment:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.CelestialAlignment, 40, EvaluateCycleCelestialAlignment250) then
            return A.CelestialAlignment:Show(icon) 
        end
    end
    -- fury_of_elune,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&solar_wrath.ap_check
    if A.FuryofElune:IsReady(unit) and ((Unit("player"):HasBuffs(A.CaIncBuff) or A.CaInc:GetCooldown() > 30) and bool(solar_wrath.ap_check)) then
        return A.FuryofElune:Show(icon)
    end
    -- cancel_buff,name=starlord,if=buff.starlord.remains<3&!solar_wrath.ap_check
    if (Unit("player"):HasBuffs(A.StarlordBuff) < 3 and not bool(solar_wrath.ap_check)) then
      -- if HR.CancelA.StarlordBuff then return ""; end
    end
    -- starfall,if=(buff.starlord.stack<3|buff.starlord.remains>=8)&spell_targets>=variable.sf_targets&(target.time_to_die+1)*spell_targets>cost%2.5
    if A.Starfall:IsReady(unit) and ((Unit("player"):HasBuffsStacks(A.StarlordBuff) < 3 or Unit("player"):HasBuffs(A.StarlordBuff) >= 8) and MultiUnits:GetByRangeInCombat(40, 5, 10) >= VarSfTargets and (Unit(unit):TimeToDie() + 1) * MultiUnits:GetByRangeInCombat(40, 5, 10) > A.Starfall:Cost() / 2.5) then
        return A.Starfall:Show(icon)
    end
    -- starsurge,if=(talent.starlord.enabled&(buff.starlord.stack<3|buff.starlord.remains>=5&buff.arcanic_pulsar.stack<8)|!talent.starlord.enabled&(buff.arcanic_pulsar.stack<8|buff.ca_inc.up))&spell_targets.starfall<variable.sf_targets&buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4&buff.solar_empowerment.stack<3&buff.lunar_empowerment.stack<3&(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)|target.time_to_die<=execute_time*astral_power%40|!solar_wrath.ap_check
    if A.Starsurge:IsReady(unit) and ((A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.StarlordBuff) < 3 or Unit("player"):HasBuffs(A.StarlordBuff) >= 5 and Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff) < 8) or not A.Starlord:IsSpellLearned() and (Unit("player"):HasBuffsStacks(A.ArcanicPulsarBuff) < 8 or Unit("player"):HasBuffs(A.CaIncBuff))) and MultiUnits:GetByRangeInCombat(40, 5, 10) < VarSfTargets and Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff) + Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff) < 4 and Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff) < 3 and Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff) < 3 and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(prev.starsurge)) or Unit(unit):TimeToDie() <= A.Starsurge:GetSpellCastTime() * FutureAstralPower / 40 or not bool(solar_wrath.ap_check)) then
        return A.Starsurge:Show(icon)
    end
    -- sunfire,if=buff.ca_inc.up&buff.ca_inc.remains<gcd.max&variable.az_ss&dot.moonfire.remains>remains
    if A.Sunfire:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff) and Unit("player"):HasBuffs(A.CaIncBuff) < A.GetGCD() and bool(VarAzSs) and Unit(unit):HasDeBuffs(A.MoonfireDebuff) > Unit(unit):HasDeBuffs(A.SunfireDebuff)) then
        return A.Sunfire:Show(icon)
    end
    -- moonfire,if=buff.ca_inc.up&buff.ca_inc.remains<gcd.max&variable.az_ss
    if A.Moonfire:IsReady(unit) and (Unit("player"):HasBuffs(A.CaIncBuff) and Unit("player"):HasBuffs(A.CaIncBuff) < A.GetGCD() and bool(VarAzSs)) then
        return A.Moonfire:Show(icon)
    end
    -- sunfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=ceil(floor(2%spell_targets)*1.5)+2*spell_targets&(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)&(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up)
    if A.Sunfire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Sunfire, 40, EvaluateCycleSunfire373) then
            return A.Sunfire:Show(icon) 
        end
    end
    -- moonfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=6&(!variable.az_ss|!buff.ca_inc.up|!prev.moonfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up)
    if A.Moonfire:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.Moonfire, 40, EvaluateCycleMoonfire436) then
            return A.Moonfire:Show(icon) 
        end
    end
    -- stellar_flare,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.stellar_flare)
    if A.StellarFlare:IsReady(unit) then
        if Action.Utils.CastTargetIf(A.StellarFlare, 40, EvaluateCycleStellarFlare471) then
            return A.StellarFlare:Show(icon) 
        end
    end
    -- new_moon,if=ap_check
    if A.NewMoon:IsReady(unit) and (bool(ap_check)) then
        return A.NewMoon:Show(icon)
    end
    -- half_moon,if=ap_check
    if A.HalfMoon:IsReady(unit) and (bool(ap_check)) then
        return A.HalfMoon:Show(icon)
    end
    -- full_moon,if=ap_check
    if A.FullMoon:IsReady(unit) and (bool(ap_check)) then
        return A.FullMoon:Show(icon)
    end
    -- lunar_strike,if=buff.solar_empowerment.stack<3&(ap_check|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up)|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
    if A.LunarStrike:IsReady(unit) and (Unit("player"):HasBuffsStacks(A.SolarEmpowermentBuff) < 3 and (bool(ap_check) or Unit("player"):HasBuffsStacks(A.LunarEmpowermentBuff) == 3) and ((Unit("player"):HasBuffs(A.WarriorofEluneBuff) or Unit("player"):HasBuffs(A.LunarEmpowermentBuff) or MultiUnits:GetByRangeInCombat(40, 5, 10) >= 2 and not Unit("player"):HasBuffs(A.SolarEmpowermentBuff)) and (not bool(VarAzSs) or not Unit("player"):HasBuffs(A.CaIncBuff)) or bool(VarAzSs) and Unit("player"):HasBuffs(A.CaIncBuff) and bool(prev.solar_wrath))) then
        return A.LunarStrike:Show(icon)
    end
    -- solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
    if A.SolarWrath:IsReady(unit) and (VarAzSs < 3 or not Unit("player"):HasBuffs(A.CaIncBuff) or not bool(prev.solar_wrath)) then
        return A.SolarWrath:Show(icon)
    end
    -- sunfire
    if A.Sunfire:IsReady(unit) then
        return A.Sunfire:Show(icon)
    end
     end
    end

-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 