local utility = {}
function utility:Spawn(Speed, Attach, Audio, Name, Dmg, Rb, E, CrossType, CrossFail, DeathType, Hints, jmps)
  local Config = {
	Entity = {
			Jumpscare=jmps
    Attach = Attach or nil,
    AudioList = Audio or nil,
		Name = Name,
		Asset = "https://github.com/RegularVynixu/Utilities/blob/main/Doors%20Entity%20Spawner/Models/Rush.rbxm?raw=true",
		HeightOffset = 0
	},
	Movement = {
		Speed = Speed*100,
		Delay = 2,
		Reversed = false
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Rebounding = {
		Enabled = Rb~=nil and Rb[1]~=0 and Rb[2]~=0,
		Type = "Ambush", -- "Blitz"
		Min = Rb[1],
		Max = Rb[2],
		Delay = 2
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = E
	},
	CameraShake = {
		Enabled = true,
		Values = {1.5, 20, 0.1, 1}, -- Magnitude, Roughness, FadeIn, FadeOut
		Range = 100
	},
	Crucifixion = {
		Type = CrossType or "Guiding", -- "Guiding"
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = CrossFail
	},
	Death = {
		Type = DeathType or "Guiding", -- "Curious"
		Hints = Hints,
        Cause = ""
	}
}
---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/Utilities/Spawner.lua"))()

---====== Create entity ======---

local entity = spawner.Create(Config)

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
end
--example to spawn:
-- local Attach=Instance.new("Attachment")
-- local AudioListFolder=Instance.new("Folder")
-- local Audio1=Instance.new("Sound", AudioListFolder)
-- Audio1.SoundId="rbxassetid://0"
-- Audio1.Name="Spawn"
-- Audio1.Volume=3
-- local Audio2=Instance.new("Sound", AudioListFolder)
-- Audio2.SoundId="rbxassetid://0"
-- Audio2.Name="Footsteps"
-- Audio2.Volume=3
-- utility:Spawn(Attach, AudioListFolder, "Namw", 100, {2, 6}, false, "Guiding", false, "Guiding", {"You died to Name", "wait what?", "its called..", "Name!?"})
return utility
