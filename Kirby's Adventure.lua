--[[
asdasd
Kirby's Super Adventure
featuring a slew of visual and gameplay tweaks!
. colors for every copy ability
. a new hud
. health, energy, powerup management
. debug access
. minor readditions such as the cannon status
. knightmare mode
. exhaustive menu for editing various variables

[+ -- ..] P1:
Left: Move down the pause menu
Right: Increment the selected menu item

[+ -- ..] P2:
Up: Move up the pause menu / RAM table / move up by 16
Down: Move down the pause menu / RAM table / move down by 16
Left: Move forward in the menus / RAM table / move down by 1
Right: Move backwards in the menus / RAM table / move up by 1
A: Grab the selected menu item / RAM address
Select: Reset the selected menu item / exit RAM table
]]

selector = 0
pauseLevel = 0
pauseColor = {"P16","P27","P28","P2A","P2B","P2C","P11","P14","P24","P00","P0F","P07"}
ramwatch = false
ramoffset = 0

recoloring = false
newhud = false
invinc = false
metaknight = true
jumpsLeft = 4
--[[
memory addresses of some use not featured here
006A kirby particle xpos
0071 subtile xpos movement?
0083 kirby map xpos(within current region, not visually)
00B9 kirby map ypos
0095 kirby x map region
00CB kirby y map region
1a5 tileset for tiles bigger than 8x8
0203 kirby weapon particles
020b kirby weapon particles 2
0593 score 10s place
0594 score 2560s place
0595 score 655360s place
6117 kirby fall speed
7960-79ff empty ram
]]
controllerAdd = 0x003C --controller, only active for one frame unlike 003A
controllerAdd2 = 0x00E6 --other controller one pointer
controller2Add = 0x003D --second controller, same as above but instead of 003B
titleScreen = 0x0180 --title screen
xposAdd = 0x0203 --kirby xpos
yposAdd = 0x0204 --kirby ypos
cannonAdd = 0x050C --is in a cannon?
scoreAdd = 0x0593 --score address
bodyAdd = 0x05E0 --powerup state ie hammer normal sleeping
powerAdd = 0x05E1 --move being done
inhaledAdd = 05E2 --power of enemy in mouth
powerupAdd = 0x05E3 --current powerup
powerup2Add = 0x076D
stateAdd = 0x004E
state2Add = 0x0639
hpAdd = 0x0597 --current health 255 for 0 hp, 47 for 6 hp
usesAdd = 0x0598 --uses of ltd powerups like crash or mike
livesAdd = 0x0599 --current lives
livesDisplay = 0x059D --00 lives only 01 power and lives rest are overworld lives only
yveloAdd = 0x05BE
groundedAdd = 0x05FB --grounded
statesAdd = 0x0604 --various states
hudFlickerAdd = 0x004D --used for abilities like crash with flickering colors
pauseAdd = 0x018D --color palette used to track state changes

body  = 0x0193
body2 = 0x0197
body3 = 0x0101
body4 = 0x6011
feet  = 0x0194
feet2 = 0x0198
feet4 = 0x6012
line  = 0x0195
line2 = 0x0199
line4 = 0x6013

col = {} --every different nes color named, for future use
col.gray = 0x00
col.blue = 0x01
col.darkblue = 0x02
col.purple = 0x03
col.violet = 0x04
col.wine = 0x05
col.red = 0x06
col.crimson = 0x07
col.brown = 0x08
col.wreath = 0x09
col.leaf = 0x0A
col.forest = 0x0B
col.slate = 0x0C
col.black = 0x0F
col.silver = 0x10
col.azure = 0x11
col.royalblue = 0x12
col.royalpurple = 0x13
col.magenta = 0x14
col.hotpink = 0x15
col.scarlet = 0x16
col.orange = 0x17
col.gold = 0x18
col.green = 0x19
col.thistle = 0x1A
col.springgreen = 0x1B
col.teal = 0x1C
col.snow = 0x20
col.cerulean = 0x21
col.lightblue = 0x22
col.lavender = 0x23
col.pink = 0x24
col.blush = 0x25
col.salmon = 0x26
col.carrot = 0x27
col.yellow = 0x28
col.lime = 0x29
col.emerald = 0x2A
col.aquamarine = 0x2B
col.turquoise = 0x2C
col.stone = 0x2D
col.white = 0x30
col.skyblue = 0x31
col.periwinkle = 0x32
col.mauve = 0x33
col.lightpink = 0x34
col.rose = 0x35
col.beige = 0x36
col.canary = 0x37
col.marigold = 0x38
col.chartreuse = 0x39
col.mint = 0x3A
col.ice = 0x3B
col.cyan = 0x3C
col.iron = 0x3D

powerups = {}
powerups[0x00][1] = {"Fire","Kirby can breathe\nfire! Enemies\nbeware, or you're\ngonna get burned!"}
powerups[0x00][2] = {col.carrot,col.scarlet,col.black,col.chartreuse,col.carrot,col.red,col.carrot,col.scarlet,col.black} --based on modern kirby fire powerups
powerups[0x01][1] = {"Spark","Kirby can create\nfireworks-like\nsparks from his\nbody! This is a\ngreat defense!"}
powerups[0x01][2] = {col.chartreuse,col.springgreen,col.leaf,col.chartreuse,col.springgreen,col.leaf,col.chartreuse,col.springgreen,col.leaf} --based on plasma from modern kirby games
powerups[0x02][1] = {"Cutter","Kirby can throw a\nseries of cutters\nthat return like\nboomerangs!"}
powerups[0x02][2] = {col.rose,col.yellow,col.black,col.white,col.iron,col.yellow,col.rose,col.yellow,col.black} --projectile coloring based on modern cutter kirby's
powerups[0x03][1] = {"Sword","Use the sword to\ndefeat enemies!\nIf you attack in\nmidair, Kirby will\nspin and slash!"}
powerups[0x03][2] = {col.silver,col.snow,col.black,col.snow,col.silver,col.darkblue,col.lightpink,col.salmon,col.black} --based on modern kirby sword powerups
powerups[0x04][1] = {"Fireball","Kirby can turn\ninto a flying fire-\nball! Jump and\nattack in a flash\nof fire!"}
powerups[0x04][2] = {col.beige,col.salmon,col.wine,col.white,col.carrot,col.blush,col.beige,col.salmon,col.wine} --custom
powerups[0x05][1] = {"Laser","Kirby can fire a\nlaser beam! This\nbeam will bounce\noff slopes,so try\nit in many places!"}
powerups[0x05][2] = {col.marigold,col.yellow,col.gold,col.canary,col.gold,col.yellow,col.marigold,col.orange,col.black} --custom
powerups[0x06][1] = {"Mike","Kirby can sing his\nfavorite song three\ntimes! I wonder\nwhy that song hurts\nenemies..."}
powerups[0x06][2] = {col.white,col.blue,col.black,col.white,col.blue,col.black,col.lime,col.green,col.forest} --based off of mike wazowski
powerups[0x07][1] = {"Wheel","Kirby turns into a\nwheel and can move\nat super speed! But\nwatch out for obstacles\nand excess speed!"}
powerups[0x07][2] = {col.silver,col.stone,col.black,col.silver,col.stone,col.black,col.silver,col.stone,col.black} --custom, looks like a wheel
powerups[0x08][1] = {"Hammer","This weapon is\nvery powerful. Use\nit on stubborn bad\nguys to clear your\npath!"}
powerups[0x08][2] = {col.rose,col.blush,col.black,col.yellow,col.orange,col.brown,col.rose,col.scarlet,col.black} --based off his smash brothers and modern hammer colors
powerups[0x09][1] = {"Parasol","Open your parasol\nand take a nice\nwalk! Do you think\nthis might have\nother uses, too?"}
powerups[0x09][2] = {col.white,col.snow,col.red,col.white,col.canary,col.scarlet,col.lightpink,col.pink,col.black} --based off of the parasol seen in the manual and in modern games
powerups[0x0A][1] = {"Sleep","...Please...\n...Let me sleep...\n...A little more...\n...Please..."}
powerups[0x0A][2] = {col.white,col.snow,col.red,col.white,col.canary,col.scarlet,col.white,col.emerald,col.black} --based off of the color palette of noddy in-game
powerups[0x0B][1] = {"Needle","Lots of needles,\njust like a\nporcupine's, come\nout of Kirby! It's\na great defense!"}
powerups[0x0B][2] = {col.yellow,col.gold,col.brown,col.marigold,col.yellow,col.black,col.yellow,col.gold,col.brown} --custom
powerups[0x0C][1] = {"Ice","Kirby can freeze\nenemies with his\n cold breath! He\ncan then throw\nthem into others!"}
powerups[0x0C][2] = {col.white,col.cerulean,col.blue,col.beige,col.salmon,col.black,col.white,col.cerulean,col.blue} --unchanged
powerups[0x0D][1] = {"Freeze","Kirby can create a\nshield to freeze\nenemies! He can\nthen knock away\nthe frozen blocks!"}
powerups[0x0D][2] = {col.skyblue,col.lightblue,col.darkblue,col.beige,col.salmon,col.black,col.skyblue,col.lightblue,col.darkblue} --based off of modern ice kirby powerups
powerups[0x0E][1] = {"Hi-Jump","Kirby can jump many\ntimes higher than\nusual! Jump and\ndive attack to\nbeat the enemy!"}
powerups[0x0E][2] = {col.rose,col.blush,col.black,col.white,col.canary,col.orange,col.pink,col.springgreen,col.black} --based off of cherry spraypaint from amazing mirror
powerups[0x0F][1] = {"Beam","Kirby fires a beam\nlike that used by\nsome enemies!\nThis is an easy\nweapon to use!"}
powerups[0x0F][2] = {col.yellow,col.gold,col.black,col.marigold,col.yellow,col.black,col.yellow,col.gold,col.black} --based off of beam powerup in later games / keeby
powerups[0x10][1] = {"Stone","Kirby's body turns\ninto a solid rock!\nIn this form, he\ncannot be hurt by\nenemy attacks!"}
powerups[0x10][2] = {col.beige,col.salmon,col.black,col.white,col.silver,col.gray,col.gray,col.carrot,col.black} --based off of carbon spraypaint from amazing mirror
powerups[0x11][1] = {"Ball","Kirby can roll into\na smooth ball! If\nyou hold the A\nButton,he will\njump higher!"}
powerups[0x11][2] = {col.beige,col.salmon,col.black,col.marigold,col.yellow,col.gold,col.lightblue,col.slate,col.black} --based off the first ball of within a deep forest
powerups[0x12][1] = {"Tornado","Kirby can now spin\nand bump away his\nfoes! Hold the B\nButton to spin\ninto the air!"}
powerups[0x12][2] = {col.mauve,col.royalpurple,col.black,col.snow,col.silver,col.gray,col.mauve,col.royalpurple,col.black} --custom
powerups[0x13][1] = {"Crash","This power will\ndefeat all enemies\non the screen, but\nyou can use it\nonly once!"}
powerups[0x13][2] = {col.carrot,col.scarlet,col.black,col.beige,col.salmon,col.black,col.carrot,col.scarlet,col.black} --custom
powerups[0x13][3] = {col.white,col.beige,col.wine,col.beige,col.salmon,col.black,col.white,col.beige,col.wine}
powerups[0x14][1] = {"Light","Dark areas can be\nspooky! This lets\nKirby set off fire-\nworks! It works\nonly in the dark!"}
powerups[0x14][2] = {col.chartreuse,col.beige,col.gold,col.chartreuse,col.beige,col.gold,col.chartreuse,col.beige,col.gold} --it doesn't flicker as the palette address can only be hooked onto when the game writes to it, like with crash
powerups[0x14][3] = {col.chartreuse,col.beige,col.gold,col.chartreuse,col.beige,col.gold,col.white,col.stone,col.black} --one is custom and one is based on gameboy kirby 
powerups[0x15][1] = {"Back Drop","Kirby can use a\npowerful wrestling\ntechnique, the back\ndrop, to defeat\nhis opponents!"}
powerups[0x15][2] = {col.beige,col.scarlet,col.black,col.white,col.canary,col.orange,col.beige,col.scarlet,col.black} --custom
powerups[0x16][1] = {"Throw","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
powerups[0x16][2] = {col.lavender,col.blush,col.hotpink,col.white,col.blush,col.hotpink,col.pink,col.magenta,col.violet} --based on grape kirby from the amazing mirror
powerups[0x17][1] = {"UFO","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
powerups[0x17][2] = {col.beige,col.scarlet,col.black,col.chartreuse,col.mint,col.lime,col.snow,col.royalpurple,col.slate} --custom
powerups[0x18][1] = {"Star Rod","Make the final\neffort! Shoot the\nstar to defeat the\nfinal enemy!"}
powerups[0x18][2] = {col.rose,col.blush,col.black,col.canary,col.beige,col.red,col.rose,col.blush,col.black} --based off promo and modern depictions of the star rod
powerups[0x19][1] = {"Bye Bye","Congratulations!"}
powerups[0x19][2] = {col.rose,col.blush,col.black,col.white,col.canary,col.orange,col.rose,col.blush,col.black} --normal kirby
powerups[0x1A][1] = {"Normal[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0x1A][2] = {col.mint,col.springgreen,col.darkblue,col.ice,col.white,col.blue,col.periwinkle,col.springgreen,col.slate} --just an aesthetically pleasing kirby
powerups[0x1B][1] = {"Custom 1[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0x1C][1] = {"Custom 2[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0x1D][1] = {"Custom 3[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0x1E][1] = {"Custom 4[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0x1F][1] = {"Custom 5[Crash]","Deletes save file\nwhen attempting to\nunpause."}
powerups[0xFF][1] = {"Normal","Hit the Down Arrow\nwhen Kirby has an\nenemy in his mouth\nto copy the enemy's\nspecial ability!"}
powerups[0xFF][0] = {col.rose,col.blush,col.black,col.white,col.canary,col.orange,col.rose,col.blush,col.black} --default
powerups[0xFF][2] = {col.rose,col.blush,col.black,col.white,col.canary,col.orange,col.snow,col.turquoise,col.royalblue} --2 is "splash", 8 is actual splashing
powerups[0xFF][3] = {col.rose,col.blush,col.black,col.marigold,col.carrot,col.gold,col.lavender,col.darkblue,col.black} --meta knight
powerups[0xFF][4] = {col.rose,col.blush,col.black,col.marigold,col.carrot,col.crimson,col.lightblue,col.marigold,col.black} --king dedede
powerups[0xFF][5] = {col.beige,col.salmon,col.black,col.white,col.canary,col.orange,col.beige,col.salmon,col.black} --default powerup color, as it is otherwise unused
powerups[0x100][1] = {"Meta Knight","Use the Galaxia\nto battle your way\nthrough a more\nchallenging game!"} --custom for meta knightmare mode
powerups[0x100][2] = {col.rose,col.blush,col.black,col.marigold,col.carrot,col.gold,col.white,col.purple,col.black} --nes metaknight coloring

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

menus = {}
for i=0,12,1
do
  menus[i] = {}
end
menus[0][0] = "      MENU     "
menus[0][1] = "Basics"
menus[0][2] = "Enhancements"
menus[0][3] = "Powers"
menus[0][4] = "Physics"
menus[0][5] = "RAM"
menus[1][0] = "     BASICS    "
menus[1][1] = "" --dynamic health
menus[1][2] = "" --dynamic lives
menus[2][0] = "  ENHANCEMENTS "
menus[2][1] = "" --dynamic recolors
menus[2][2] = "" --dynamic lua menu
menus[2][3] = "" --dynamic knightmare
menus[3][0] = "    POWERS     "
menus[3][1] = "" --dynamic power
menus[3][2] = "" --dynamic power state
menus[3][3] = "" --dynamic power uses
menus[4][0] = "    PHYSICS    "
menus[4][1] = "" --dynamic gravity
menus[5][0] = "      RAM      "

--[[other palette locations if it finds a use
feet3 = 0x0102
line3 = 0x0103
enemy1 = 0x019B
enemy2 = 0x019C
enemy3 = 0x019D
fg1 = 0x018F
fg2 = 0x0190
fg3 = 0x0191
bg1 = 0x0183
bg2 = 0x0184
bg3 = 0x0185
]]--

function recolor()
pwr = memory.readbyte(powerupAdd)
	if(#powerups[pwr] == 1)
		memory.writebyte(body,col.beige)
		memory.writebyte(feet,col.salmon)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.white)
		memory.writebyte(feet2,col.canary)
		memory.writebyte(line2,col.orange)
		memory.writebyte(body4,col.beige)
		memory.writebyte(feet4,col.salmon)
		memory.writebyte(line4,col.black)
		return nil
	end
	if(#powerups[pwr] == 2)
		memory.writebyte(body,powerups[pwr][2][1])
		memory.writebyte(feet,powerups[pwr][2][2])
		memory.writebyte(line,powerups[pwr][2][3])
		memory.writebyte(body2,powerups[pwr][2][4])
		memory.writebyte(feet2,powerups[pwr][2][5])
		memory.writebyte(line2,powerups[pwr][2][6])
		memory.writebyte(body4,powerups[pwr][2][7])
		memory.writebyte(feet4,powerups[pwr][2][8])
		memory.writebyte(line4,powerups[pwr][2][9])
		return nil
	end
	if(#powerups[pwr] == 3)
		flicker = memory.readbyte(hudFlickerAdd)
		if(flicker == 123 or flicker == 124) then
			memory.writebyte(body,powerups[pwr][2][1])
			memory.writebyte(feet,powerups[pwr][2][2])
			memory.writebyte(line,powerups[pwr][2][3])
			memory.writebyte(body2,powerups[pwr][2][4])
			memory.writebyte(feet2,powerups[pwr][2][5])
			memory.writebyte(line2,powerups[pwr][2][6])
			memory.writebyte(body4,powerups[pwr][2][7])
			memory.writebyte(feet4,powerups[pwr][2][8])
			memory.writebyte(line4,powerups[pwr][2][9])
		else
			memory.writebyte(body,powerups[pwr][3][1])
			memory.writebyte(feet,powerups[pwr][3][2])
			memory.writebyte(line,powerups[pwr][3][3])
			memory.writebyte(body2,powerups[pwr][3][4])
			memory.writebyte(feet2,powerups[pwr][3][5])
			memory.writebyte(line2,powerups[pwr][3][6])
			memory.writebyte(body4,powerups[pwr][3][7])
			memory.writebyte(feet4,powerups[pwr][3][8])
			memory.writebyte(line4,powerups[pwr][3][9])
		end
		return nil
	end
	if(#powerups[pwr] == 7)
		splash = memory.readbyte(powerAdd)
		states = memory.readbyte(statesAdd)
		memory.writebyte(body,powerups[pwr][splash][1])
		memory.writebyte(feet,powerups[pwr][splash][2])
		memory.writebyte(line,powerups[pwr][splash][3])
		memory.writebyte(body2,powerups[pwr][splash][4])
		memory.writebyte(feet2,powerups[pwr][splash][5])
		memory.writebyte(line2,powerups[pwr][splash][6])
		memory.writebyte(body4,powerups[pwr][splash][7])
		memory.writebyte(feet4,powerups[pwr][splash][8])
		memory.writebyte(line4,powerups[pwr][splash][9])
		if(splash == 2 and states == 8) then memory.writebyte(body4,col.skyblue) end --due to how the game calls colors it'll usually only get called one time in the room unless you pause, rather than toggle
		return nil
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
end

function drawhud()
	if(not(memory.readbyte(pauseAdd) == 0x19 or memory.readbyte(pauseAdd) == 0x25)) then --19 is continue/exit pause, 25 is normal pause
		if(memory.readbyte(livesDisplay) > 0x01) then
			moveReg(149,191,180,230,-140,0) --moves copy ability box
		else
			moveReg(149,191,180,230,-140,0) --moves copy ability box
		end
		elseif(memory.readbyte(pauseAdd) == 0x19) then
			moveReg(22,58,183,225,-10,0) --moves copy ability box
		end

	if(not(memory.readbyte(pauseAdd) == 0x25)) then
		gui.text(50,180,"                                   \n                                   \n                                   \n                                   \n                                   \n                                   \n","#7c0800","#fcd8a8")
		gui.text(50,184,"HP "..((memory.readbyte(hpAdd)+1)/8),"#7c0800","#fcd8a8")
		gui.text(50,205,"Lives:"..memory.readbyte(livesAdd),"#7c0800","#fcd8a8")
		gui.box(80,182,144,202,"#fcd8a8")
	
		for hpBit=0,5 do --health points
			if(hpBit <= ((memory.readbyte(hpAdd))/8)) then
				if(memory.readbyte(hudFlickerAdd) == 122 or memory.readbyte(hudFlickerAdd) == 124) then
					gui.box(80 + (hpBit*11),182,89 + (hpBit*11),192,"#fc9838","#7c0800")
				else
					gui.box(80 + (hpBit*11),182,89 + (hpBit*11),192,"#fcd8a8","#7c0800")
				end
			else
				gui.box(80 + (hpBit*11),186,89 + (hpBit*11),188,"#fc9838","#7c0800")
			end
		end

		gui.text(118,218,"id "..memory.readbyte(powerupAdd),"#7c0800","#fcd8a8")
		if(memory.readbyte(usesAdd) > 0x0) then
			gui.text(90,205,"*x"..memory.readbyte(usesAdd),"#7c0800","#fcd8a8")
		end

		gui.text(50,218,powerups[memory.readbyte(powerupAdd)][1][1],"#7c0800","#fcd8a8")
		gui.text(154,185,powerups[memory.readbyte(powerupAdd)][1][2],"#7c0800","#fcd8a8")

	end
end

function paused()
if(memory.readbyte(pauseAdd) == 0x25) then
	pauseText = {"","","","","","","","","","","",""}
	for i=0,#(menus[pauseLevel]),1 do
		pauseText[i] = menus[pauseLevel][i]
	end
	dynamic()

	gui.text(80,24,pauseText[0],"P16","#ffffff")
	if(ramwatch) then
		gui.box(40,40,215,160,"P30") --blank screen
		gui.text(100+(selector%8)*12,40+math.floor((selector)/8)*8,"00","#000","#000")
		for i=0,15 do
			gui.text(67,40+(i*8),ramLine(i),pauseColor[5],"clear")
		end
	else
		gui.box(40,40,215,135,"P30") --blank screen
		for i=1,12 do
			gui.text(51+(pauseLevel>0 and 16 or 0),40+(i*8),pauseText[i],pauseLevel>0 and pauseColor[pauseLevel] or pauseColor[i],"clear")
		end
		gui.text(42+(pauseLevel>0 and 16 or 0),40+(selector*8),">","#000","clear")
	end
	if(pauseLevel>0) then gui.text(42,32+(pauseLevel*8)," > ","clear",pauseColor[pauseLevel]) end

	if(AND(memory.readbyte(controller2Add),0x01) == 0x01) then --right
		if(ramwatch) then
			selector = selector+1
		else
			if(pauseLevel == 0) then pauseLevel=selector+1 end
			selector=0
			if(pauseLevel == 5) then ramwatch = true end
		end
	end
 
	if(AND(memory.readbyte(controller2Add),0x02) == 0x02) then --left
		if(ramwatch) then
			selector = selector-1
		else
			selector = pauseLevel-1
			if (selector == -1) then selector = 0 end
			pauseLevel = 0
		end
	end
 
	if(AND(memory.readbyte(controller2Add),0x04) == 0x04) then --down
		if(ramwatch) then
			selector = selector + 8
			if(selector>127) then
				selector = selector%128
				ramoffset = ramoffset + 128
			end
			if(ramoffset>65408) then ramoffset = 0 end
		else
			selector = selector+1
			if(selector == #(menus[pauseLevel])) then selector=0 end
		end
	end
 
	if(AND(memory.readbyte(controller2Add),0x08) == 0x08) then --up
		if(ramwatch) then
			selector = selector - 8
			if(selector<0) then
				selector = selector%128
				ramoffset = ramoffset - 128
			end
			if(ramoffset<0) then ramoffset = 65408 end
		else
			selector = selector-1
			if(selector == -1) then selector=#(menus[pauseLevel]) - 1 end
		end
	end
 
if(AND(memory.readbyte(controller2Add),0x20) == 0x20) then --select
	selector=0
	pauseLevel=0
	ramwatch = false
end
 
 if(AND(memory.readbyte(controller2Add),0x40) == 0x40) then
 if(selector==0) then recoloring = not recoloring end
 if(selector==1) then newhud = not newhud end
 if(selector==2) then invinc = false memory.writebyte(hpAdd, memory.readbyte(hpAdd)-0x08) end
 if(selector==3) then memory.writebyte(livesAdd, memory.readbyte(livesAdd)-0x01) end
 if(selector==4) then memory.writebyte(powerupAdd, memory.readbyte(powerupAdd)-0x01) end
 if(selector==5) then memory.writebyte(bodyAdd, memory.readbyte(bodyAdd)-0x01) end
 if(selector==6) then memory.writebyte(usesAdd, memory.readbyte(usesAdd)-0x01) end
 if(selector==11) then metaknight = not metaknight end
 
 if(memory.readbyte(hpAdd)==0xF7) then invinc=true else invinc = false end
 if(memory.readbyte(livesAdd)==0xFF) then memory.writebyte(livesAdd,0x63) end
 if(memory.readbyte(powerupAdd)==0xFE) then memory.writebyte(powerupAdd,0x1F) end
 if(memory.readbyte(bodyAdd)==0xFF) then memory.writebyte(bodyAdd,0x0E) end
 if(memory.readbyte(usesAdd)==0xFF) then memory.writebyte(usesAdd,0x0F) end
 end

 
 if(AND(memory.readbyte(controllerAdd),0x02) == 0x02 or AND(memory.readbyte(controller2Add),0x80) == 0x80) then
 if(selector==0) then recoloring = not recoloring end
 if(selector==1) then newhud = not newhud end
 if(selector==2) then invinc = false memory.writebyte(hpAdd, memory.readbyte(hpAdd)+0x08) end
 if(selector==3) then memory.writebyte(livesAdd, memory.readbyte(livesAdd)+0x01) end
 if(selector==4) then memory.writebyte(powerupAdd, memory.readbyte(powerupAdd)+0x01) end
 if(selector==5) then memory.writebyte(bodyAdd, memory.readbyte(bodyAdd)+0x01) end
 if(selector==6) then memory.writebyte(usesAdd, memory.readbyte(usesAdd)+0x01) end
 if(selector==11) then metaknight = not metaknight end
 
 if(memory.readbyte(hpAdd)>0x37) then memory.writebyte(hpAdd,0xFF) end
 if(memory.readbyte(hpAdd)==0x37 or invinc) then invinc=true else invinc = false end
 if(memory.readbyte(livesAdd)>0x63) then memory.writebyte(livesAdd,0x00) end
 if(memory.readbyte(powerupAdd)>0x1F) then memory.writebyte(powerupAdd,0xFF) end
 if(memory.readbyte(bodyAdd)>0x0E) then memory.writebyte(bodyAdd,0x00) end
 if(memory.readbyte(usesAdd)>0x0F) then memory.writebyte(usesAdd,0x00) end
 end
end
return nil
end

function knightmare()
	if(memory.readbyte(groundedAdd) == 0x04) then jumpsLeft = 4 end
	memory.writebyte(bodyAdd,0x03) --sword state
	memory.writebyte(powerupAdd,0xFF) --normal powerup, stops other copy abilities
	--meta knight falls faster, but can recover with floating much quicker, and can hover with aerial attacks
	if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and not (AND(memory.readbyte(controllerAdd),0x08) == 0x08)) then memory.writebyte(yveloAdd,0x02) end --sink
	if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and (AND(memory.readbyte(controllerAdd),0x08) == 0x08)) then memory.writebyte(yveloAdd,0xFE) end --float
	if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and (memory.readbyte(powerAdd) == 0x0C)) then memory.writebyte(yveloAdd,(-1*jumpsLeft)) jumpsLeft=jumpsLeft-1 end --hover
	--(AND(memory.readbyte(controllerAdd),0x40) == 0x40) --FD is max height that feels ok, 00 was meant for when it registered once per button press instead of once per action
	-- also feels much better with weighted limited jumps
	--draws a mask onto his face poorly
	gui.box(memory.readbyte(xposAdd)+10,memory.readbyte(yposAdd)+8,memory.readbyte(xposAdd)+16,memory.readbyte(yposAdd)+6,"P0F") --P03 --P20
end
 
function dynamic()
	menus[1][1] = "Health: "..((memory.readbyte(hpAdd)==0xFF) and "0" or ((memory.readbyte(hpAdd)==0x37) and "INF" or ((memory.readbyte(hpAdd)+0x01)/0x08)))
	menus[1][2] = "Lives: "..(memory.readbyte(livesAdd))
	menus[2][1] = "Recolors: "..(recoloring and "ON" or "off")
	menus[2][2] = "LUA-Based Hud: "..(newhud and "ON" or "off")
	menus[2][3] = "Meta Knightmare: "..(metaknight and "ON" or "off")
	menus[3][1] = "Powerup: "..(powerups[memory.readbyte(powerupAdd)][1][1])
	menus[3][2] = "Powerup State: "..(bodies[memory.readbyte(bodyAdd)])
	menus[3][3] = "Powerup Uses: "..(memory.readbyte(usesAdd))
end

function ramLine(l)
	rline = {}
	rline = memory.readbyterange(ramoffset+(l*8),8)
	s=string.upper(string.format("%4x",ramoffset+(l*8)))..": "
	for i=1,8,1 do
		s = s..string.upper(string.format("%2x",string.byte(rline,i)))
	end
	return s
end

--delays for n amount of time.
--Haseeb Mir. (haseebmir.hm@gmail.com)
function sleep(n,str)
  local t = os.clock()
  while os.clock() - t <= n do
    -- nothing
	gui.text(20,90,str)
	emu.frameadvance()
  end
end

while(true)do
 if(memory.readbyte(titleScreen) == 0) then gui.text(88,40,"LUA ENHANCEMENT","P0F","#00000000") end
 if(recoloring) then memory.register(body3, 0x199, recolor()) end
 if(newhud) then drawhud() end
 memory.register(pauseAdd, 0x01, paused())

 if(invinc) then memory.writebyte(hpAdd,0x37) end
 if(metaknight) then knightmare() end
 --memory.register(powerAdd, 60, recolor())
 memory.writebyte(0x4029,0x7F)
 emu.frameadvance()
end
