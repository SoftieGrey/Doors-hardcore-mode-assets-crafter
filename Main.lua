local utility=loadstring(game:HttpGet("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/ExampleSpawner.lua"))()
function download(url)
  local path=url:split("/")[9]
  if not isfile(path) then
    writefile(path, url)
  end
  return getcustomasset(path)
end
function quick()
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
        {"You died to who you call Quick", "Listen for any cues that might hint it's arrival", "Find a hiding spot quickly! It's speed has been proved to be quite menacing", ""} --death messages
        jumpscare=function()
        
    end
    )
end
local entityChances={
  Quick={Door=10, Chance=35}
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
