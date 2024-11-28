local utility=loadstring(game:HttpGet("https://raw.githubusercontent.com/SoftieGrey/Doors-hardcore-mode-assets-crafter/refs/heads/main/ExampleSpawner.lua"))()
function download(url)
  local i=url:split("/")[9]
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
   Audio1.SoundId="rbxassetid://0"
   Audio1.Name="Spawn"
   Audio1.Volume=3
   local Audio2=Instance.new("Sound", AudioListFolder)
   Audio2.SoundId="rbxassetid://0"
   Audio2.Name="Footsteps"
   Audio2.Volume=3
  utility:Spawn(Attach, AudioListFolder, "Quick", 100, {1,2}, false, "Guiding", false, "Guiding", {"You died to Name", "wait what?", "its called..", "Name!?"})
end
