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
Action[ACTION_CONST_MAGE_FROST] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    -- Generics
    ArcaneIntellectBuff                    = Action.Create({ Type = "Spell", ID = 1459 }),
    ArcaneIntellect                        = Action.Create({ Type = "Spell", ID = 1459 }),
    SummonWaterElemental                   = Action.Create({ Type = "Spell", ID = 31687 }),
    MirrorImage                            = Action.Create({ Type = "Spell", ID = 55342 }),
    Frostbolt                              = Action.Create({ Type = "Spell", ID = 116 }),
    FrozenOrb                              = Action.Create({ Type = "Spell", ID = 84714 }),
    Blizzard                               = Action.Create({ Type = "Spell", ID = 190356 }),
    CometStorm                             = Action.Create({ Type = "Spell", ID = 153595 }),
    IceNova                                = Action.Create({ Type = "Spell", ID = 157997 }),
    Flurry                                 = Action.Create({ Type = "Spell", ID = 44614 }),
    Ebonbolt                               = Action.Create({ Type = "Spell", ID = 257537 }),
    BrainFreezeBuff                        = Action.Create({ Type = "Spell", ID = 190446 }),
    IciclesBuff                            = Action.Create({ Type = "Spell", ID = 205473 }),
    GlacialSpike                           = Action.Create({ Type = "Spell", ID = 199786 }),
    IceLance                               = Action.Create({ Type = "Spell", ID = 30455 }),
    FingersofFrostBuff                     = Action.Create({ Type = "Spell", ID = 44544 }),
    RayofFrost                             = Action.Create({ Type = "Spell", ID = 205021 }),
    ConeofCold                             = Action.Create({ Type = "Spell", ID = 120 }),
    IcyVeinsBuff                           = Action.Create({ Type = "Spell", ID = 12472 }),
    RuneofPowerBuff                        = Action.Create({ Type = "Spell", ID = 116014 }),
    IcyVeins                               = Action.Create({ Type = "Spell", ID = 12472 }),
    RuneofPower                            = Action.Create({ Type = "Spell", ID = 116011 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    LightsJudgment                         = Action.Create({ Type = "Spell", ID = 255647 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Blink                                  = Action.Create({ Type = "Spell", ID = 1953 }),
    IceFloes                               = Action.Create({ Type = "Spell", ID = 108839 }),
    IceFloesBuff                           = Action.Create({ Type = "Spell", ID = 108839 }),
    WintersChillDebuff                     = Action.Create({ Type = "Spell", ID = 228358 }),
    GlacialSpikeBuff                       = Action.Create({ Type = "Spell", ID = 199844 }),
    SplittingIce                           = Action.Create({ Type = "Spell", ID = 56377 }),
    FreezingRain                           = Action.Create({ Type = "Spell", ID = 240555 })
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
    BattlePotionOfAgility                  = Action.Create({ Type = "Potion", ID = 163223, QueueForbidden = true }), 
    SuperiorBattlePotionOfAgility          = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }), 
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
    -- Misc
    Channeling                             = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),	-- Show an icon during channeling
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),	-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),		-- spell_magic_polymorphrabbit
    CyclotronicBlast                       = Action.Create({ Type = "Spell", ID = 293491, Hidden = true}),
    ConcentratedFlameBurn                  = Action.Create({ Type = "Spell", ID = 295368, Hidden = true}),
    RazorCoralDebuff                       = Action.Create({ Type = "Spell", ID = 303568, Hidden = true     }),
    ConductiveInkDebuff                    = Action.Create({ Type = "Spell", ID = 302565, Hidden = true     }),
    -- Hidden Heart of Azeroth
    -- added all 3 ranks ids in case used by rotation
    VisionofPerfectionMinor                = Action.Create({ Type = "Spell", ID = 296320, Hidden = true}),
    VisionofPerfectionMinor2               = Action.Create({ Type = "Spell", ID = 299367, Hidden = true}),
    VisionofPerfectionMinor3               = Action.Create({ Type = "Spell", ID = 299369, Hidden = true}),
    UnleashHeartOfAzeroth                  = Action.Create({ Type = "Spell", ID = 280431, Hidden = true}),
    BloodoftheEnemy                        = Action.Create({ Type = "HeartOfAzeroth", ID = 297108, Hidden = true}),
    BloodoftheEnemy2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298273, Hidden = true}),
    BloodoftheEnemy3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 298277, Hidden = true}),
    ConcentratedFlame                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295373, Hidden = true}),
    ConcentratedFlame2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299349, Hidden = true}),
    ConcentratedFlame3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299353, Hidden = true}),
    GuardianofAzeroth                      = Action.Create({ Type = "HeartOfAzeroth", ID = 295840, Hidden = true}),
    GuardianofAzeroth2                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299355, Hidden = true}),
    GuardianofAzeroth3                     = Action.Create({ Type = "HeartOfAzeroth", ID = 299358, Hidden = true}),
    FocusedAzeriteBeam                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295258, Hidden = true}),
    FocusedAzeriteBeam2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299336, Hidden = true}),
    FocusedAzeriteBeam3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299338, Hidden = true}),
    PurifyingBlast                         = Action.Create({ Type = "HeartOfAzeroth", ID = 295337, Hidden = true}),
    PurifyingBlast2                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299345, Hidden = true}),
    PurifyingBlast3                        = Action.Create({ Type = "HeartOfAzeroth", ID = 299347, Hidden = true}),
    TheUnboundForce                        = Action.Create({ Type = "HeartOfAzeroth", ID = 298452, Hidden = true}),
    TheUnboundForce2                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299376, Hidden = true}),
    TheUnboundForce3                       = Action.Create({ Type = "HeartOfAzeroth", ID = 299378, Hidden = true}),
    RippleInSpace                          = Action.Create({ Type = "HeartOfAzeroth", ID = 302731, Hidden = true}),
    RippleInSpace2                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302982, Hidden = true}),
    RippleInSpace3                         = Action.Create({ Type = "HeartOfAzeroth", ID = 302983, Hidden = true}),
    WorldveinResonance                     = Action.Create({ Type = "HeartOfAzeroth", ID = 295186, Hidden = true}),
    WorldveinResonance2                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298628, Hidden = true}),
    WorldveinResonance3                    = Action.Create({ Type = "HeartOfAzeroth", ID = 299334, Hidden = true}),
    MemoryofLucidDreams                    = Action.Create({ Type = "HeartOfAzeroth", ID = 298357, Hidden = true}),
    MemoryofLucidDreams2                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299372, Hidden = true}),
    MemoryofLucidDreams3                   = Action.Create({ Type = "HeartOfAzeroth", ID = 299374, Hidden = true}), 
    RecklessForceBuff                      = Action.Create({ Type = "Spell", ID = 302932, Hidden = true     }),	 
};

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_MAGE_FROST)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_MAGE_FROST], { __index = Action })





local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

--A.FrozenOrb.EffectID = 84721
--A.Frostbolt:RegisterInFlight()

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods_Pulling()
    local unit = "player"

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
        local Precombat, Aoe, Cooldowns, Movement, Single, TalentRop
        --Precombat
        local function Precombat(unit)
            -- flask
            -- food
            -- augmentation
            -- arcane_intellect
            if A.ArcaneIntellect:IsReady(unit) and Unit("player"):HasBuffsDown(A.ArcaneIntellectBuff.ID, true, true) then
                return A.ArcaneIntellect:Show(icon)
            end
            -- summon_water_elemental
            if A.SummonWaterElemental:IsReady(unit) then
                return A.SummonWaterElemental:Show(icon)
            end
            -- snapshot_stats
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- potion
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- frostbolt
            if A.Frostbolt:IsReady(unit) and inCombat and Unit(unit):IsExists() and unit ~= "mouseover" and not Unit(unit):IsTotem() then
                return A.Frostbolt:Show(icon)
            end
        end
        
        --Aoe
        local function Aoe(unit)
            -- frozen_orb
            if A.FrozenOrb:IsReady(unit) then
                return A.FrozenOrb:Show(icon)
            end
            -- blizzard
            if A.Blizzard:IsReady(unit) then
                return A.Blizzard:Show(icon)
            end
            -- comet_storm
            if A.CometStorm:IsReady(unit) then
                return A.CometStorm:Show(icon)
            end
            -- ice_nova
            if A.IceNova:IsReady(unit) then
                return A.IceNova:Show(icon)
            end
            -- flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike)
            if A.Flurry:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Ebonbolt) or bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) and (Unit("player"):GetSpellLastCast(A.Frostbolt) and (Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) < 4 or not A.GlacialSpike:IsSpellLearned()) or Unit("player"):GetSpellLastCast(A.GlacialSpike))) then
                return A.Flurry:Show(icon)
            end
            -- ice_lance,if=buff.fingers_of_frost.react
            if A.IceLance:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true))) then
                return A.IceLance:Show(icon)
            end
            -- ray_of_frost
            if A.RayofFrost:IsReady(unit) then
                return A.RayofFrost:Show(icon)
            end
            -- ebonbolt
            if A.Ebonbolt:IsReady(unit) then
                return A.Ebonbolt:Show(icon)
            end
            -- glacial_spike
            if A.GlacialSpike:IsReady(unit) then
                return A.GlacialSpike:Show(icon)
            end
            -- cone_of_cold
            if A.ConeofCold:IsReady(unit) then
                return A.ConeofCold:Show(icon)
            end
            -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.TidestormCodex:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                A.TidestormCodex:Show(icon)
            end
            -- frostbolt
            if A.Frostbolt:IsReady(unit) then
                return A.Frostbolt:Show(icon)
            end
            -- call_action_list,name=movement
            if (true) then
                local ShouldReturn = Movement(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- ice_lance
            if A.IceLance:IsReady(unit) then
                return A.IceLance:Show(icon)
            end
        end
        
        --Cooldowns
        local function Cooldowns(unit)
            -- icy_veins
            if A.IcyVeins:IsReady(unit) and A.BurstIsON(unit) then
                return A.IcyVeins:Show(icon)
            end
            -- mirror_image
            if A.MirrorImage:IsReady(unit) and A.BurstIsON(unit) then
                return A.MirrorImage:Show(icon)
            end
            -- rune_of_power,if=prev_gcd.1.frozen_orb|time_to_die>10+cast_time&time_to_die<20
            if A.RuneofPower:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.FrozenOrb) or Unit(unit):TimeToDie() > 10 + A.RuneofPower:GetSpellCastTime() and Unit(unit):TimeToDie() < 20) then
                return A.RuneofPower:Show(icon)
            end
            -- call_action_list,name=talent_rop,if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains
            if (A.RuneofPower:IsSpellLearned() and MultiUnits:GetByRangeInCombat(40, 5, 10) == 1 and A.RuneofPower:FullRechargeTimeP() < A.FrozenOrb:GetCooldown()) then
                local ShouldReturn = TalentRop(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- potion,if=prev_gcd.1.icy_veins|target.time_to_die<70
            if A.BattlePotionofIntellect:IsReady(unit) and Action.GetToggle(1, "Potion") and (Unit("player"):GetSpellLastCast(A.IcyVeins) or Unit(unit):TimeToDie() < 70) then
                A.BattlePotionofIntellect:Show(icon)
            end
            -- use_items
            -- blood_fury
            if A.BloodFury:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.BloodFury:Show(icon)
            end
            -- berserking
            if A.Berserking:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Berserking:Show(icon)
            end
            -- lights_judgment
            if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) then
                return A.LightsJudgment:Show(icon)
            end
            -- fireblood
            if A.Fireblood:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.Fireblood:Show(icon)
            end
            -- ancestral_call
            if A.AncestralCall:AutoRacial(unit) and Action.GetToggle(1, "Racial") and A.BurstIsON(unit) then
                return A.AncestralCall:Show(icon)
            end
        end
        
        --Movement
        local function Movement(unit)
            -- blink,if=movement.distance>10
            if A.Blink:IsReady(unit) and (Unit(unit):GetRange() > 10) then
                return A.Blink:Show(icon)
            end
            -- ice_floes,if=buff.ice_floes.down
            if A.IceFloes:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.IceFloesBuff.ID, true))) then
                return A.IceFloes:Show(icon)
            end
        end
        
        --Single
        local function Single(unit)
            -- ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up
            if A.IceNova:IsReady(unit) and (A.IceNova:GetCooldown() == 0 and Unit(unit):HasDeBuffs(A.WintersChillDebuff.ID, true)) then
                return A.IceNova:Show(icon)
            end
            -- flurry,if=talent.ebonbolt.enabled&prev_gcd.1.ebonbolt&(!talent.glacial_spike.enabled|buff.icicles.stack<4|buff.brain_freeze.react)
            if A.Flurry:IsReady(unit) and (A.Ebonbolt:IsSpellLearned() and Unit("player"):GetSpellLastCast(A.Ebonbolt) and (not A.GlacialSpike:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) < 4 or bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)))) then
                return A.Flurry:Show(icon)
            end
            -- flurry,if=talent.glacial_spike.enabled&prev_gcd.1.glacial_spike&buff.brain_freeze.react
            if A.Flurry:IsReady(unit) and (A.GlacialSpike:IsSpellLearned() and Unit("player"):GetSpellLastCast(A.GlacialSpike) and bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true))) then
                return A.Flurry:Show(icon)
            end
            -- flurry,if=prev_gcd.1.frostbolt&buff.brain_freeze.react&(!talent.glacial_spike.enabled|buff.icicles.stack<4)
            if A.Flurry:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Frostbolt) and bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) and (not A.GlacialSpike:IsSpellLearned() or Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) < 4)) then
                return A.Flurry:Show(icon)
            end
            -- frozen_orb
            if A.FrozenOrb:IsReady(unit) then
                return A.FrozenOrb:Show(icon)
            end
            -- blizzard,if=active_enemies>2|active_enemies>1&cast_time=0&buff.fingers_of_frost.react<2
            if A.Blizzard:IsReady(unit) and (MultiUnits:GetByRangeInCombat(35, 5, 10) > 2 or MultiUnits:GetByRangeInCombat(35, 5, 10) > 1 and A.Blizzard:GetSpellCastTime() == 0 and Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true) < 2) then
                return A.Blizzard:Show(icon)
            end
            -- ice_lance,if=buff.fingers_of_frost.react
            if A.IceLance:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true))) then
                return A.IceLance:Show(icon)
            end
            -- comet_storm
            if A.CometStorm:IsReady(unit) then
                return A.CometStorm:Show(icon)
            end
            -- ebonbolt
            if A.Ebonbolt:IsReady(unit) then
                return A.Ebonbolt:Show(icon)
            end
            -- ray_of_frost,if=!action.frozen_orb.in_flight&ground_aoe.frozen_orb.remains=0
            if A.RayofFrost:IsReady(unit) and (not A.FrozenOrb:IsSpellInFlight() and Player:FrozenOrbGroundAoeRemains() == 0) then
                return A.RayofFrost:Show(icon)
            end
            -- blizzard,if=cast_time=0|active_enemies>1
            if A.Blizzard:IsReady(unit) and (A.Blizzard:GetSpellCastTime() == 0 or MultiUnits:GetByRangeInCombat(35, 5, 10) > 1) then
                return A.Blizzard:Show(icon)
            end
            -- glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|active_enemies>1&talent.splitting_ice.enabled
            if A.GlacialSpike:IsReady(unit) and (bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) or Unit("player"):GetSpellLastCast(A.Ebonbolt) or MultiUnits:GetByRangeInCombat(40, 5, 10) > 1 and A.SplittingIce:IsSpellLearned()) then
                return A.GlacialSpike:Show(icon)
            end
            -- ice_nova
            if A.IceNova:IsReady(unit) then
                return A.IceNova:Show(icon)
            end
            -- use_item,name=tidestorm_codex,if=buff.icy_veins.down&buff.rune_of_power.down
            if A.TidestormCodex:IsReady(unit) and (bool(Unit("player"):HasBuffsDown(A.IcyVeinsBuff.ID, true)) and bool(Unit("player"):HasBuffsDown(A.RuneofPowerBuff.ID, true))) then
                A.TidestormCodex:Show(icon)
            end
            -- frostbolt
            if A.Frostbolt:IsReady(unit) then
                return A.Frostbolt:Show(icon)
            end
            -- call_action_list,name=movement
            if (true) then
                local ShouldReturn = Movement(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- ice_lance
            if A.IceLance:IsReady(unit) then
                return A.IceLance:Show(icon)
            end
        end
        
        --TalentRop
        local function TalentRop(unit)
            -- rune_of_power,if=talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time)
            if A.RuneofPower:IsReady(unit) and (A.GlacialSpike:IsSpellLearned() and Unit("player"):HasBuffsStacks(A.IciclesBuff.ID, true) == 5 and (bool(Unit("player"):HasBuffsStacks(A.BrainFreezeBuff.ID, true)) or A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime())) then
                return A.RuneofPower:Show(icon)
            end
            -- rune_of_power,if=!talent.glacial_spike.enabled&(talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9)
            if A.RuneofPower:IsReady(unit) and (not A.GlacialSpike:IsSpellLearned() and (A.Ebonbolt:IsSpellLearned() and A.Ebonbolt:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.CometStorm:IsSpellLearned() and A.CometStorm:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.RayofFrost:IsSpellLearned() and A.RayofFrost:GetCooldown() < A.RuneofPower:GetSpellCastTime() or A.RuneofPower:ChargesFractionalP() > 1.9)) then
                return A.RuneofPower:Show(icon)
            end
        end
        
-- call precombat
if not Player:AffectingCombat() and (not Player:IsCasting() or Player:IsCasting(S.WaterElemental)) then
  local ShouldReturn = Precombat(unit); if ShouldReturn then return ShouldReturn; end
end

        -- In Combat
        if inCombat and Unit(unit):IsExists() and not Unit(unit):IsTotem() then
                    -- counterspell
            -- ice_lance,if=prev_gcd.1.flurry&!buff.fingers_of_frost.react
            if A.IceLance:IsReady(unit) and (Unit("player"):GetSpellLastCast(A.Flurry) and not bool(Unit("player"):HasBuffsStacks(A.FingersofFrostBuff.ID, true))) then
                return A.IceLance:Show(icon)
            end
            -- call_action_list,name=cooldowns
            if A.BurstIsON(unit) then
                local ShouldReturn = Cooldowns(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=aoe,if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4
            if (MultiUnits:GetByRangeInCombat(40, 5, 10) > 3 and A.FreezingRain:IsSpellLearned() or MultiUnits:GetByRangeInCombat(40, 5, 10) > 4) then
                local ShouldReturn = Aoe(unit); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=single
            if (true) then
                local ShouldReturn = Single(unit); if ShouldReturn then return ShouldReturn; end
            end
        end
    end

    -- End on EnemyRotation()

    -- Defensive
    --local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if EnemyRotation(unit) then 
            return true 
        end 
    end 

    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 

    end
end
-- Finished

-- [4] AoE Rotation
A[4] = function(icon)
    return A[3](icon, true)
end
 -- [5] Trinket Rotation
-- No specialization trinket actions 
-- Passive 
--[[local function FreezingTrapUsedByEnemy()
    if     UnitCooldown:GetCooldown("arena", 3355) > UnitCooldown:GetMaxDuration("arena", 3355) - 2 and
    UnitCooldown:IsSpellInFly("arena", 3355) and 
    Unit("player"):GetDR("incapacitate") >= 50 
    then 
        local Caster = UnitCooldown:GetUnitID("arena", 3355)
        if Caster and Unit(Caster):GetRange() <= 40 then 
            return true 
        end 
    end 
end 
local function ArenaRotation(icon, unit)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then
        -- Note: "arena1" is just identification of meta 6
        if unit == "arena1" and (Unit("player"):GetDMG() == 0 or not Unit("player"):IsFocused("DAMAGER")) then 
            -- Reflect Casting BreakAble CC
            if A.NetherWard:IsReady() and A.NetherWard:IsSpellLearned() and Action.ShouldReflect(EnemyTeam()) and EnemyTeam():IsCastingBreakAble(0.25) then 
                return A.NetherWard:Show(icon)
            end 
        end
    end 
end 
local function PartyRotation(unit)
    if (unit == "party1" and not A.GetToggle(2, "PartyUnits")[1]) or (unit == "party2" and not A.GetToggle(2, "PartyUnits")[2]) then 
        return false 
    end

  	-- SingeMagic
    if A.SingeMagic:IsCastable() and A.SingeMagic:AbsentImun(unit, Temp.TotalAndMag) and IsSchoolFree() and Action.AuraIsValid(unit, "UseDispel", "Magic") and not Unit(unit):InLOS() then
        return A.SingeMagic:Show(icon)
    end
end 

A[6] = function(icon)
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)
    local Party = PartyRotation("party1") 
    if Party then 
        return Party:Show(icon)
    end 
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)
    local Party = PartyRotation("party2") 
    if Party then 
        return Party:Show(icon)
    end     
    return ArenaRotation(icon, "arena3")
end]]--

