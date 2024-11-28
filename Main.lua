local utility=loadstring(game:HttpGet("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/ExampleSpawner.lua"))()
function download(url)
  local path=url:split("/")[9]
  if not isfile(path) then
    writefile(path, url)
  end
  return getcustomasset(path)
end
function spawnItem(itemName)
    ---====== Define spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Item%20Spawner/V1/Source.lua"))();

---====== Create item ======---

local tools = {
		Crucifix=LoadCustomInstance("https://github.com/RegularVynixu/Utilities/raw/main/Doors/Item%20Spawner/Assets/Crucifix.rbxm");
	}
local handle = tools[itemName].Handle
local size = handle.Size

local offsets = {
    flat_random = CFrame.Angles(math.rad(-90), 0, math.rad(math.random(-360, 360))) + Vector3.new(0, 0, size.Z / 2),
    doorframe = CFrame.Angles(math.rad(-5), 0, 0) + Vector3.new(0, size.Y / 2, 0),
    wall = CFrame.new(0, 0, -size.Z / 2)
}

local item = spawner.Create({
    Item = {
        Name = itemName,
        Asset = tools[itemName],
        DestroyOnPickup = true,
        PickupOnTouch = false
    },
    Prompt = {
        Range = 7,
        Duration = 0,
        LineOfSight = false
    },
    Locations = {
        Dresser = {
            Enabled = false
        },
        Drawer = {
            Enabled = true, Offset = offsets.flat_random
        },
        Table = {
            Enabled = true, Offset = offsets.flat_random
        },
        Chest = {
            Enabled = true, Offset = offsets.flat_random
        },
        Bed = {
            Enabled = false
        },
        Floor = {
            Enabled = false
        },
        Fireplace = {
            Enabled = false
        },
        Doorframe = {
            Enabled = true, Offset = offsets.doorframe
        },
        Wall = {
            Enabled = true, Offset = offsets.wall
        }
    }
})

---====== Spawn item ======---

local currentRoomIndex = game:GetService("Players").LocalPlayer:GetAttribute("CurrentRoom") -- current room number index
local currentRoom = workspace.CurrentRooms[currentRoomIndex] -- current room instance

item:Spawn(currentRoom)
end
function quick()
  local jmpsImg=download("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/beepquickbop.mp4")
  local image=download("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/Uraveragerushclone.png")
  local Attach=Instance.new("Attachment")
  local ParticleEmitter=Instance.new("ParticleEmitter", Attach)
  ParticleEmitter.Texture = image
  ParticleEmitter.Size = NumberSequence.new(4) -- `Size` must be a NumberSequence, not a number.
  ParticleEmitter.Speed = NumberRange.new(0.1) -- `Speed` must be a NumberRange, not a single number.
  ParticleEmitter.Drag = 5 -- `Drag` is fine as is.
  ParticleEmitter.Transparency = NumberSequence.new(0.99, 0.995) -- This is correct if you want a linear transition.
  ParticleEmitter.SpreadAngle = Vector2.new(180, 180) -- `SpreadAngle` must be a Vector2.
   local AudioListFolder=Instance.new("Folder")
   local Audio1=Instance.new("Sound", AudioListFolder)
   Audio1.SoundId="rbxassetid://8654282340"
   Audio1.Name="Spawn"
   Audio1.Volume=3
   local Audio2=Instance.new("Sound", AudioListFolder)
   Audio2.SoundId="rbxassetid://8654282340"
   Audio2.Name="Footsteps"
   Audio2.Volume=3
  utility:Spawn(
        1.5, --speed
        Attach, --attachment for custom particles
        AudioListFolder, --audios
        "Quick", --entity name
        100, --damage
        {1, 2}, --rebounds ({0,0} means no rebounds, nil is the same)
        false, --eathquakes
        "Guiding", --Crucifix Type ("Guiding" or "Curious")
        false, --Crucifix fails?
        "Guiding", --Death type ("Curious" or "Guiding")
        {"You died to who you call Quick", "Listen for any cues that might hint it's arrival", "Find a hiding spot quickly! It's speed has been proved to be quite menacing", ""}, --death messages
        function() --jumpscare
	local videoFrame = Instance.new("VideoFrame")
    videoFrame.Parent =Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    videoFrame.Size = UDim2.new(1,0,1,0)
    videoFrame.Video = videoFile 
    videoFrame:Play()
        end)
end
local entityChances={
  Quick={Door=10, Chance=35, callback=quick};
}
local canEntitiesSpawn=game.ReplicatedStorafe.ChaseInSession
local roomsBlacklist={50,99,100}
function canEntitySpawn()
  local room=game.ReplicatedStorage.LatestRoom.Value
  if canEntitiesSpawn.Value==false and not table.find(roomsBlacklist, room) then
    return true
  else
    return false
  end
end
local crosschance=30
local ondoorchanged=game.ReplicatedStorage.GameData.LatestRoom
ondoorchanged.Changed:Connect(function()
      for _, entity in ipairs(entityChances) do
          if math.random(1,100)<=entity.Chance and ondoorchanged.Value>=entity.Door then
                  entity.callback()
      end
    end
    if math.random(1,100)<=crosschance then
      spawnItem("Crucifix")
    end
  end)
