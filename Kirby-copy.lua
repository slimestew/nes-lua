-- kirby's adventure powerup changer thing
-- sleep code stolen from Haseeb Mir. (haseebmir.hm@gmail.com)

bodyAdd = 0x05E0
powerupAdd = 0x05E3
powerup2Add = 0x076D
stateAdd = 0x004E
state2Add = 0x0639
hpAdd = 0x0597
usesAdd = 0x0598
livesAdd = 0x0599
hudFlickerAdd = 0x004D

powerup = memory.readbyte(powerupAdd)+1
hp = 0x0

abilities = {}
abilities[0] = {"Fire","Kirby can breathe\nfire! Enemies\nbeware, or you're\ngonna get burned!"}
abilities[1] = {"Spark","Kirby can create\nfireworks-like\nsparks from his\nbody! This is a\ngreat defense!"}
abilities[2] = {"Cutter","Kirby can throw a\nseries of cutters\nthat return like\nboomerangs!"}
abilities[3] = {"Sword","Use the sword to\ndefeat enemies!\nIf you attack in\nmidair, Kirby will\nspin and slash!"}
abilities[4] = {"Fireball","Kirby can turn\ninto a flying fire-\nball! Jump and\nattack in a flash\nof fire!"}
abilities[5] = {"Laser","Kirby can fire a\nlaser beam! This\nbeam will bounce\noff slopes,so try\nit in many places!"}
abilities[6] = {"Mike","Kirby can sing his\nfavorite song three\ntimes! I wonder\nwhy that song hurts\nenemies..."}
abilities[7] = {"Wheel","Kirby turns into a\nwheel and can move\nat super speed! But\nwatch out for obstacles\nand excess speed!"}
abilities[8] = {"Hammer","This weapon is\nvery powerful. Use\nit on stubborn bad\nguys to clear your\npath!"}
abilities[9] = {"Parasol","Open your parasol\nand take a nice\nwalk! Do you think\nthis might have\nother uses, too?"}
abilities[10] = {"Sleep","...Please...\n...Let me sleep...\n...A little more...\n...Please..."}
abilities[11] = {"Needle","Lots of needles,\njust like a\nporcupine's, come\nout of Kirby! It's\na great defense!"}
abilities[12] = {"Ice","Kirby can freeze\nenemies with his\n cold breath! He\ncan then throw\nthem into others!"}
abilities[13] = {"Freeze","Kirby can create a\nshield to freeze\nenemies! He can\nthen knock away\nthe frozen blocks!"}
abilities[14] = {"Hi-Jump","Kirby can jump many\ntimes higher than\nusual! Jump and\ndive attack to\nbeat the enemy!"}
abilities[15] = {"Beam","Kirby fires a beam\nlike that used by\nsome enemies!\nThis is an easy\nweapon to use!"}
abilities[16] = {"Stone","Kirby's body turns\ninto a solid rock!\nIn this form, he\ncannot be hurt by\nenemy attacks!"}
abilities[17] = {"Ball","Kirby can roll into\na smooth ball! If\nyou hold the A\nButton,he will\njump higher!"}
abilities[18] = {"Tornado","Kirby can now spin\nand bump away his\nfoes! Hold the B\nButton to spin\ninto the air!"}
abilities[19] = {"Crash","This power will\ndefeat all enemies\non the screen, but\nyou can use it\nonly once!"}
abilities[20] = {"Light","Dark areas can be\nspooky! This lets\nKirby set off fire-\nworks! It works\nonly in the dark!"}
abilities[21] = {"Back Drop","Kirby can use a\npowerful wrestling\ntechnique, the back\ndrop, to defeat\nhis opponents!"}
abilities[22] = {"Throw","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
abilities[23] = {"UFO","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
abilities[24] = {"Star Rod","Make the final\neffort! Shoot the\nstar to defeat the\nfinal enemy!"}
abilities[25] = {"Bye Bye","Congratulations!"}
abilities[26] = {"Normal[Crash]","Deletes save file\nwhen attempting to\npause."}
abilities[255] = {"Normal","Hit the Down Arrow\nwhen Kirby has an\nenemy in his mouth\nto copy the enemy's\nspecial ability!"}

bodies = {}
bodies[0x00] = "normal"
bodies[0x01] = "inhaled"
bodies[0x02] = "powerup normal"
bodies[0x03] = "sword"
bodies[0x04] = "hammer"
bodies[0x05] = "parasol"
bodies[0x06] = "star rod"
bodies[0x07] = "sleep"
bodies[0x08] = "stone"
bodies[0x09] = "fireball"
bodies[0x0A] = "wheel"
bodies[0x0B] = "ball"
bodies[0x0C] = "tornado"
bodies[0x0D] = "ufo"
bodies[0x0E] = "final boss"

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
		local r,g,b,palette = emu.getscreenpixel(pixx,pixy,true)
		gui.drawpixel(pixx+nx, pixy+ny, {r,g,b,255})
	end
end
return nil
end

function moveRegion(ox1,ox2,oy1,oy2,nx,ny)
--ox1 leftmost x boundary
--ox2 rightmost x boundary
--nx offest for new region(0 will make no difference)
--same goes for y params
--if the region overlaps there will be a hall of mirrors effect
for pixx=ox1,ox2,1 do
	for pixy=oy1,oy2,1 do
		local r,g,b,palette = emu.getscreenpixel(pixx,pixy,true)
			gui.drawbox(pixx+nx,pixy+ny,pixx+nx+1,pixy+ny+1,{r,g,b,255})
	end
end
return nil
end
--function getPix(px,py)

--return nil
--end

sleep(1,"Hiiiii <('.')> \n\n	Hold 'H' Key for HELP")


while(true)do

--hudState = memory.readbyte(hudStateAdd)

--if(hudState == 
	moveReg(149,191,180,230,-140,0)

hp = ((memory.readbyte(hpAdd)+1)/8)

if(input.get().T)then
	powerup = 0
    memory.writebyte(powerupAdd,255)
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
	--   memory.writebyte(invincible,0x0)--Makes Player Invincible.
	  
	--  InvincibleCounter = 0x0
	--  end 
end

gui.text(50,180,"                                   \n                                   \n                                   \n                                   \n                                   \n                                   \n","#7c0800","#fcd8a8")

gui.text(51,188,"HP "..(hp),"#7c0800","#fcd8a8")
gui.text(50,205,"Lives "..memory.readbyte(livesAdd),"#7c0800","#fcd8a8")

gui.box(80,182,144,202,"#fcd8a8")
for hpBit=0,5 do
	if(hpBit <= hp - 1) then
		if(memory.readbyte(hudFlickerAdd) == 122 or memory.readbyte(hudFlickerAdd) == 124) then
			gui.box(80 + (hpBit*11),182,89 + (hpBit*11),202,"#fc9838","#7c0800")
		else
			gui.box(80 + (hpBit*11),182,89 + (hpBit*11),202,"#fcd8a8","#7c0800")
		end
	else
		gui.box(80 + (hpBit*11),191,89 + (hpBit*11),193,"#fc9838","#7c0800")
	end
end

gui.text(108,218,"id "..memory.readbyte(powerupAdd),"#7c0800","#fcd8a8")
if(memory.readbyte(usesAdd) > 0x0) then
gui.text(88,218,"*x"..memory.readbyte(usesAdd),"#7c0800","#fcd8a8")
end

if(input.get().Y)then
	
	gui.text(50,218,abilities[memory.readbyte(powerupAdd)][1],"#7c0800","#fcd8a8")
	gui.text(154,185,abilities[memory.readbyte(powerupAdd)][2],"#7c0800","#fcd8a8")
end
if(input.get().J)then
	memory.writebyte(hpAdd,47)
end

	if(input.get().H)then
		gui.text(20,40,"Change Copy Ability : KEY : G","#7c0800","#fcd8a8")
		gui.text(20,50,"Show Copy Ability Debug : KEY : Y","#7c0800","#fcd8a8")
		gui.text(20,60,"Heal to full : KEY : J","#7c0800","#fcd8a8")
		gui.text(20,70,"Empty Copy Ability : KEY : T","#7c0800","#fcd8a8")
	end

emu.frameadvance()
end
