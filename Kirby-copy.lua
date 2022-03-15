-- kirby's adventure powerup changer thing
-- bits of code stolen from Haseeb Mir. (haseebmir.hm@gmail.com)

powerupAdd = 0x05E3
powerup2Add = 0x076D
stateAdd = 0x004E
state2Add = 0x0639
hpAdd = 0x0597
powerup = 0x0
local r,g,b,palette = emu.getscreenpixel(0, 0, false)

names = {}
names[0] = "Fire"
names[1] = "Spark"
names[2] = "Cutter"
names[3] = "Sword"
names[4] = "Fireball"
names[5] = "Laser"
names[6] = "Mike"
names[7] = "Wheel"
names[8] = "Hammer"
names[9] = "Parasol"
names[10] = "Sleep"
names[11] = "Needle"
names[12] = "Ice"
names[13] = "Freeze"
names[14] = "Hi-Jump"
names[15] = "Beam"
names[16] = "Stone"
names[17] = "Ball"
names[18] = "Tornado"
names[19] = "Crash"
names[20] = "Light"
names[21] = "Backdrop"
names[22] = "Throw"
names[23] = "UFO"
names[24] = "Star Rod"
names[255] = "Normal"

desc = {}
desc[0] = "Kirby can breathe\nfire! Enemies\nbeware, or you're\ngonna get burned!"
desc[1] = "Kirby can create\nfireworks-like\nsparks from his\nbody! This is a\ngreat defense!"
desc[2] = "Kirby can throw a\nseries of cutters\nthat return like\nboomerangs!"
desc[3] = "Use the sword to\ndefeat enemies!\nIf you attack in\nmidair, Kirby will\nspin and slash!"
desc[5] = "Laser"
desc[6] = "Mike"
desc[7] = "Wheel"
desc[11] = "Needle"
desc[12] = "Ice"
desc[13] = "Freeze"
desc[15] = "Kirby fires a beam\nlike that used by\nsome enemies!\nThis is an easy\nweapon to use!"
desc[16] = "Stone"
desc[18] = "Tornado"
desc[19] = "Crash"
desc[21] = "Backdrop"
desc[255] = "Hit the Down Arrow\nwhen Kirby has an\nenemy in his mouth\nto copy the enemy's\nspecial ability!"

--delays for n amount of time.
function sleep(n,str)
  local t = os.clock()
  while os.clock() - t <= n do
    -- nothing
	gui.text(20,90,str)
	emu.frameadvance()
  end
end

function moveReg(ox1,ox2,oy1,oy2,nx,ny)
--ox1 leftmost x boundary
--ox2 rightmost x boundary
--nx offest for new region(0 will make no difference)
--same goes for y params
--if the region overlaps there will be a hall of mirrors effect
for pixx=ox1,ox2,1 do
	for pixy=oy1,oy2,1 do
		r,g,b,palette = emu.getscreenpixel(pixx,pixy,false)
		gui.drawpixel(pixx+nx, pixy+ny, {r,g,b,255})
	end
end
return nil
end

sleep(1,"Hiiiii <('.')> \n\n	Hold 'H' Key for HELP")


while(true)do
emu.registerbefore(moveReg(150,190,180,230,-140,0))

--Checking input for Invincible.

if(input.get().T)then
    memory.writebyte(powerupAdd,255)
	powerup = 0x0
	end

if(input.get().G)then
    memory.writebyte(powerupAdd,powerup)
	if(memory.readbyte(stateAdd) == 65) then
		memory.writebyte(stateAdd,67)
	end
	if(memory.readbyte(state2Add) == 4) then
		memory.writebyte(state2Add,8)
	end
	if(memory.readbyte(powerup2Add) == -100) then
		memory.writebyte(state2Add,-90)
	end
	sleep(0.1,"waiting")
    powerup = powerup + 1
	 
	--else
	-- if(input.get().I and InvincibleCounter == 0x1)then
	--   memory.writebyte(invincible,0x0);--Makes Player Invincible.
	  
	--  InvincibleCounter = 0x0
	--  end 
end


gui.text(128,218,memory.readbyte(powerupAdd))
gui.text(128,118,((memory.readbyte(hpAdd)+1)/8))
if(input.get().Y)then
	gui.text(50,218,names[memory.readbyte(powerupAdd)])
end
if(input.get().J)then
	gui.text(154,185,desc[memory.readbyte(powerupAdd)])
end

	if(input.get().H)then
		gui.text(20,40,"Change Copy Ability : KEY : G")
		gui.text(20,50,"Show Copy Ability Name : KEY : Y")
		gui.text(20,60,"Show Copy Ability Desc : KEY : J")
		gui.text(20,70,"Empty Copy Ability : KEY : T")
	end

emu.frameadvance()
end
