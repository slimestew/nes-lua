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

[+ -- ..] P1:
Left: Move down the pause menu
Right: Increment the selected menu item

[+ -- ..] P2:
Up: Move up the pause menu
Down: Move down the pause menu
A: Increment the selected menu item
B: Decrement the selected menu item
Select: Reset the selected menu item
]]

recoloring = false
newhud = false
invinc = false
selector = 0
metaknight = false
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
]]
controllerAdd = 0x003C --controller, only active for one frame unlike 003A
controllerAdd2 = 0x00E6 --other controller one pointer
controller2Add = 0x003D --second controller, same as above but instead of 003B
titleScreen = 0x0180 --title screen
xposAdd = 0x0203 --kirby xpos
yposAdd = 0x0204 --kirby ypos
cannonAdd = 0x050C --is in a cannon?
scoreAdd = 0x0593 --score address
powerAdd = 0x05E0 --powerup held
bodyAdd = 0x05E0
powerupAdd = 0x05E3 --current powerup
powerup2Add = 0x076D
stateAdd = 0x004E
state2Add = 0x0639
hpAdd = 0x0597 --current health 255 for 0 hp, 47 for 6 hp
usesAdd = 0x0598 --uses of ltd powerups like crash or mike
livesAdd = 0x0599 --current lives
livesDisplay = 0x059D --00 lives only 01 power and lives rest are overworld lives only
yveloAdd = 0x05BE
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

names = {}
names[0x00] = {"Fire","Kirby can breathe\nfire! Enemies\nbeware, or you're\ngonna get burned!"}
names[0x01] = {"Spark","Kirby can create\nfireworks-like\nsparks from his\nbody! This is a\ngreat defense!"}
names[0x02] = {"Cutter","Kirby can throw a\nseries of cutters\nthat return like\nboomerangs!"}
names[0x03] = {"Sword","Use the sword to\ndefeat enemies!\nIf you attack in\nmidair, Kirby will\nspin and slash!"}
names[0x04] = {"Fireball","Kirby can turn\ninto a flying fire-\nball! Jump and\nattack in a flash\nof fire!"}
names[0x05] = {"Laser","Kirby can fire a\nlaser beam! This\nbeam will bounce\noff slopes,so try\nit in many places!"}
names[0x06] = {"Mike","Kirby can sing his\nfavorite song three\ntimes! I wonder\nwhy that song hurts\nenemies..."}
names[0x07] = {"Wheel","Kirby turns into a\nwheel and can move\nat super speed! But\nwatch out for obstacles\nand excess speed!"}
names[0x08] = {"Hammer","This weapon is\nvery powerful. Use\nit on stubborn bad\nguys to clear your\npath!"}
names[0x09] = {"Parasol","Open your parasol\nand take a nice\nwalk! Do you think\nthis might have\nother uses, too?"}
names[0x0A] = {"Sleep","...Please...\n...Let me sleep...\n...A little more...\n...Please..."}
names[0x0B] = {"Needle","Lots of needles,\njust like a\nporcupine's, come\nout of Kirby! It's\na great defense!"}
names[0x0C] = {"Ice","Kirby can freeze\nenemies with his\n cold breath! He\ncan then throw\nthem into others!"}
names[0x0D] = {"Freeze","Kirby can create a\nshield to freeze\nenemies! He can\nthen knock away\nthe frozen blocks!"}
names[0x0E] = {"Hi-Jump","Kirby can jump many\ntimes higher than\nusual! Jump and\ndive attack to\nbeat the enemy!"}
names[0x0F] = {"Beam","Kirby fires a beam\nlike that used by\nsome enemies!\nThis is an easy\nweapon to use!"}
names[0x10] = {"Stone","Kirby's body turns\ninto a solid rock!\nIn this form, he\ncannot be hurt by\nenemy attacks!"}
names[0x11] = {"Ball","Kirby can roll into\na smooth ball! If\nyou hold the A\nButton,he will\njump higher!"}
names[0x12] = {"Tornado","Kirby can now spin\nand bump away his\nfoes! Hold the B\nButton to spin\ninto the air!"}
names[0x13] = {"Crash","This power will\ndefeat all enemies\non the screen, but\nyou can use it\nonly once!"}
names[0x14] = {"Light","Dark areas can be\nspooky! This lets\nKirby set off fire-\nworks! It works\nonly in the dark!"}
names[0x15] = {"Back Drop","Kirby can use a\npowerful wrestling\ntechnique, the back\ndrop, to defeat\nhis opponents!"}
names[0x16] = {"Throw","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
names[0x17] = {"UFO","Kirby can grab an\nenemy and toss it\naway, like a star!\nUse an enemy\nto beat others!"}
names[0x18] = {"Star Rod","Make the final\neffort! Shoot the\nstar to defeat the\nfinal enemy!"}
names[0x19] = {"Bye Bye","Congratulations!"}
names[0x1A] = {"Normal[Crash]","Deletes save file\nwhen attempting to\nunpause."}
names[0x1B] = {"Custom 1[Crash]","Deletes save file\nwhen attempting to\nunause."}
names[0x1C] = {"Custom 2[Crash]","Deletes save file\nwhen attempting to\nunpause."}
names[0x1D] = {"Custom 3[Crash]","Deletes save file\nwhen attempting to\nunpause."}
names[0x1E] = {"Custom 4[Crash]","Deletes save file\nwhen attempting to\nunpause."}
names[0x1F] = {"Custom 5[Crash]","Deletes save file\nwhen attempting to\nunpause."}
names[0xFF] = {"Normal","Hit the Down Arrow\nwhen Kirby has an\nenemy in his mouth\nto copy the enemy's\nspecial ability!"}
names[0x100] = {"Meta Knight","Use the Galaxia\nto battle your way\nthrough a more\nchallenging game!"}

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
pwr = names[memory.readbyte(powerupAdd)][1]
if(pwr == nil) then pwr = "kerbe" end

--based on modern kirby fire powerups
if(pwr == "Fire") then
	memory.writebyte(body,col.carrot)
	memory.writebyte(feet,col.scarlet)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.chartreuse)
	memory.writebyte(feet2,col.carrot)
	memory.writebyte(line2,col.red)
	memory.writebyte(body4,col.carrot)
	memory.writebyte(feet4,col.scarlet)
	memory.writebyte(line4,col.black)
--based on plasma from modern kirby games
elseif(pwr == "Spark") then
	memory.writebyte(body,col.chartreuse)
	memory.writebyte(feet,col.springgreen)
	memory.writebyte(line,col.leaf)
	memory.writebyte(body2,col.chartreuse)
	memory.writebyte(feet2,col.springgreen)
	memory.writebyte(line2,col.leaf)
	memory.writebyte(body4,col.chartreuse)
	memory.writebyte(feet4,col.springgreen)
	memory.writebyte(line4,col.leaf)
--projectile coloring based on modern cutter kirby's
elseif(pwr == "Cutter") then
	memory.writebyte(body,col.rose)
	memory.writebyte(feet,col.yellow)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.iron)
	memory.writebyte(line2,col.yellow)
	memory.writebyte(body4,col.rose)
	memory.writebyte(feet4,col.yellow)
	memory.writebyte(line4,col.black)
--based on modern kirby sword powerups
elseif(pwr == "Sword") then
	memory.writebyte(body,col.silver)
	memory.writebyte(feet,col.snow)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.snow)
	memory.writebyte(feet2,col.silver)
	memory.writebyte(line2,col.darkblue)
	memory.writebyte(body4,col.lightpink)
	memory.writebyte(feet4,col.salmon)
	memory.writebyte(line4,col.black)
--custom
elseif(pwr == "Fireball") then
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.salmon)
	memory.writebyte(line,col.wine)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.carrot)
	memory.writebyte(line2,col.blush)
	memory.writebyte(body4,col.beige)
	memory.writebyte(feet4,col.salmon)
	memory.writebyte(line4,col.wine)
--custom
elseif(pwr == "Laser") then
	memory.writebyte(body,col.marigold)
	memory.writebyte(feet,col.yellow)
	memory.writebyte(line,col.gold)
	memory.writebyte(body2,col.canary)
	memory.writebyte(feet2,col.gold)
	memory.writebyte(line2,col.yellow)
	memory.writebyte(body4,col.marigold)
	memory.writebyte(feet4,col.orange)
	memory.writebyte(line4,col.black)
--based off of mike wazowski
elseif(pwr == "Mike") then
	memory.writebyte(body,col.white)
	memory.writebyte(feet,col.blue)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.blue)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.lime)
	memory.writebyte(feet4,col.green)
	memory.writebyte(line4,col.forest)
--custom, looks like a wheel
elseif(pwr == "Wheel") then
	memory.writebyte(body,col.silver)
	memory.writebyte(feet,col.stone)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.silver)
	memory.writebyte(feet2,col.stone)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.silver)
	memory.writebyte(feet4,col.stone)
	memory.writebyte(line4,col.black)
--based off his smash brothers and modern hammer colors
elseif(pwr == "Hammer") then
	memory.writebyte(body,col.rose)
	memory.writebyte(feet,col.blush)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.yellow)
	memory.writebyte(feet2,col.orange)
	memory.writebyte(line2,col.brown)
	memory.writebyte(body4,col.rose)
	memory.writebyte(feet4,col.scarlet)
	memory.writebyte(line4,col.black)
--based off of the parasol seen in the manual and in modern games
elseif(pwr == "Parasol") then
	memory.writebyte(body,col.white)
	memory.writebyte(feet,col.snow)
	memory.writebyte(line,col.red)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.canary)
	memory.writebyte(line2,col.scarlet)
	memory.writebyte(body4,col.lightpink)
	memory.writebyte(feet4,col.pink)
	memory.writebyte(line4,col.black)
--based off of the color palette of noddy in-game
elseif(pwr == "Sleep") then
	memory.writebyte(body,col.white)
	memory.writebyte(feet,col.snow)
	memory.writebyte(line,col.red)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.canary)
	memory.writebyte(line2,col.scarlet)
	memory.writebyte(body4,col.white)
	memory.writebyte(feet4,col.emerald)
	memory.writebyte(line4,col.black)
--custom
elseif(pwr == "Needle") then
	memory.writebyte(body,col.yellow)
	memory.writebyte(feet,col.gold)
	memory.writebyte(line,col.brown)
	memory.writebyte(body2,col.marigold)
	memory.writebyte(feet2,col.yellow)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.yellow)
	memory.writebyte(feet4,col.gold)
	memory.writebyte(line4,col.brown)
--unchanged
elseif(pwr == "Ice") then
	memory.writebyte(body,col.white)
	memory.writebyte(feet,col.cerulean)
	memory.writebyte(line,col.blue)
	memory.writebyte(body2,col.beige)
	memory.writebyte(feet2,col.salmon)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.white)
	memory.writebyte(feet4,col.cerulean)
	memory.writebyte(line4,col.blue)
-- based off of modern ice kirby powerups
elseif(pwr == "Freeze") then
	memory.writebyte(body,col.skyblue)
	memory.writebyte(feet,col.lightblue)
	memory.writebyte(line,col.darkblue)
	memory.writebyte(body2,col.beige)
	memory.writebyte(feet2,col.salmon)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.skyblue)
	memory.writebyte(feet4,col.lightblue)
	memory.writebyte(line4,col.darkblue)
-- based off of cherry spraypaint from amazing mirror
elseif(pwr == "Hi-Jump") then
	memory.writebyte(body,col.rose)
	memory.writebyte(feet,col.blush)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.canary)
	memory.writebyte(line2,col.orange)
	memory.writebyte(body4,col.pink)
	memory.writebyte(feet4,col.springgreen)
	memory.writebyte(line4,col.black)
-- based off of beam powerup in later games / keeby
elseif(pwr == "Beam") then
	memory.writebyte(body,col.yellow)
	memory.writebyte(feet,col.gold)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.marigold)
	memory.writebyte(feet2,col.yellow)
	memory.writebyte(line2,col.black)
	memory.writebyte(body4,col.yellow)
	memory.writebyte(feet4,col.gold)
	memory.writebyte(line4,col.black)
-- based off of carbon spraypaint from amazing mirror
elseif(pwr == "Stone") then
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.salmon)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.silver)
	memory.writebyte(line2,col.gray)
	memory.writebyte(body4,col.gray)
	memory.writebyte(feet4,col.carrot)
	memory.writebyte(line4,col.black)
--based off the first ball of within a deep forest
elseif(pwr == "Ball") then
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.salmon)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.marigold)
	memory.writebyte(feet2,col.yellow)
	memory.writebyte(line2,col.gold)
	memory.writebyte(body4,col.lightblue)
	memory.writebyte(feet4,col.slate)
	memory.writebyte(line4,col.black)
--custom
elseif(pwr == "Tornado") then
	memory.writebyte(body,col.mauve)
	memory.writebyte(feet,col.royalpurple)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.snow)
	memory.writebyte(feet2,col.silver)
	memory.writebyte(line2,col.gray)
	memory.writebyte(body4,col.mauve)
	memory.writebyte(feet4,col.royalpurple)
	memory.writebyte(line4,col.black)
--custom
elseif(pwr == "Crash") then
	flicker = memory.readbyte(hudFlickerAdd)
	if(flicker == 123 or flicker == 124) then
		memory.writebyte(body,col.carrot)
		memory.writebyte(feet,col.scarlet)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.beige)
		memory.writebyte(feet2,col.salmon)
		memory.writebyte(line2,col.black)
		memory.writebyte(body4,col.carrot)
		memory.writebyte(feet4,col.scarlet)
		memory.writebyte(line4,col.black)
	else
		memory.writebyte(body,col.white)
		memory.writebyte(feet,col.beige)
		memory.writebyte(line,col.wine)
		memory.writebyte(body2,col.beige)
		memory.writebyte(feet2,col.salmon)
		memory.writebyte(line2,col.black)
		memory.writebyte(body4,col.white)
		memory.writebyte(feet4,col.beige)
		memory.writebyte(line4,col.wine)
	end
--it doesn't flicker as the palette address can only be hooked onto when the game writes to it, like with crash
-- one is custom and one is based on gameboy kirby 
elseif(pwr == "Light") then
	flicker = memory.readbyte(hudFlickerAdd)
	if(flicker == 123 or flicker == 124) then
		memory.writebyte(body,col.chartreuse)
		memory.writebyte(feet,col.beige)
		memory.writebyte(line,col.gold)
		memory.writebyte(body2,col.chartreuse)
		memory.writebyte(feet2,col.beige)
		memory.writebyte(line2,col.gold)
		memory.writebyte(body4,col.chartreuse)
		memory.writebyte(feet4,col.beige)
		memory.writebyte(line4,col.gold)
	else
		memory.writebyte(body,col.chartreuse)
		memory.writebyte(feet,col.beige)
		memory.writebyte(line,col.gold)
		memory.writebyte(body2,col.chartreuse)
		memory.writebyte(feet2,col.beige)
		memory.writebyte(line2,col.gold)
		memory.writebyte(body4,col.white)
		memory.writebyte(feet4,col.stone)
		memory.writebyte(line4,col.black)
	end
--custom
elseif(pwr == "Backdrop") then
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.scarlet)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.canary)
	memory.writebyte(line2,col.orange)
	memory.writebyte(body4,col.beige)
	memory.writebyte(feet4,col.scarlet)
	memory.writebyte(line4,col.black)
--based on grape kirby from the amazing mirror
elseif(pwr == "Throw") then
	memory.writebyte(body,col.lavender)
	memory.writebyte(feet,col.blush)
	memory.writebyte(line,col.hotpink)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.blush)
	memory.writebyte(line2,col.hotpink)
	memory.writebyte(body4,col.pink)
	memory.writebyte(feet4,col.magenta)
	memory.writebyte(line4,col.violet)
--custom
elseif(pwr == "UFO") then
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.scarlet)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.chartreuse)
	memory.writebyte(feet2,col.mint)
	memory.writebyte(line2,col.lime)
	memory.writebyte(body4,col.snow)
	memory.writebyte(feet4,col.royalpurple)
	memory.writebyte(line4,col.slate)
--based off promo and modern depictions of the star rod
elseif(pwr == "Star Rod") then
	memory.writebyte(body,col.rose)
	memory.writebyte(feet,col.blush)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.canary)
	memory.writebyte(feet2,col.beige)
	memory.writebyte(line2,col.red)
	memory.writebyte(body4,col.rose)
	memory.writebyte(feet4,col.blush)
	memory.writebyte(line4,col.black)
--normal kirby
elseif(pwr == "Bye Bye") then
		memory.writebyte(body,col.rose)
		memory.writebyte(feet,col.blush)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.white)
		memory.writebyte(feet2,col.canary)
		memory.writebyte(line2,col.orange)
		memory.writebyte(body4,col.rose)
		memory.writebyte(feet4,col.blush)
		memory.writebyte(line4,col.black)
--just an aesthetically pleasing kirby
elseif(pwr == "Custom 1[Crash]") then
	memory.writebyte(body,col.mint)
	memory.writebyte(feet,col.springgreen)
	memory.writebyte(line,col.darkblue)
	memory.writebyte(body2,col.ice)
	memory.writebyte(feet2,col.white)
	memory.writebyte(line2,col.blue)
	memory.writebyte(body4,col.periwinkle)
	memory.writebyte(feet4,col.springgreen)
	memory.writebyte(line4,col.slate)
--unchanged, although flashing with a copyable enemy has been overwritten. several hidden colors are also accessable via a glitch
elseif(pwr == "Normal") then
	splash = memory.readbyte(powerAdd)
	states = memory.readbyte(statesAdd)
	if(states ~= 7 and splash ~= 0) then --7 is dropping powerup
		if(splash == 2) then -- splash
		memory.writebyte(body,col.rose)
		memory.writebyte(feet,col.blush)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.white)
		memory.writebyte(feet2,col.canary)
		memory.writebyte(line2,col.orange)
		memory.writebyte(body4,col.snow)
		memory.writebyte(feet4,col.turquoise)
		memory.writebyte(line4,col.royalblue)
		if(states == 8) then memory.writebyte(body4,col.skyblue) end --8 is splashing
		--due to how the game calls colors it'll usually only get called one time in the room unless you pause, rather than toggle
		end
		if(splash == 3) then --meta knight
		memory.writebyte(body,col.rose)
		memory.writebyte(feet,col.blush)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.marigold)
		memory.writebyte(feet2,col.carrot)
		memory.writebyte(line2,col.gold)
		memory.writebyte(body4,col.lavender)
		memory.writebyte(feet4,col.darkblue)
		memory.writebyte(line4,col.black)
		end
		if(splash == 4) then --dedede
		memory.writebyte(body,col.rose)
		memory.writebyte(feet,col.blush)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.marigold)
		memory.writebyte(feet2,col.carrot)
		memory.writebyte(line2,col.crimson)
		memory.writebyte(body4,col.lightblue)
		memory.writebyte(feet4,col.marigold)
		memory.writebyte(line4,col.black)
		end
		if(splash == 5) then --default powerup color, as it is otherwise unused
		memory.writebyte(body,col.beige)
		memory.writebyte(feet,col.salmon)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.white)
		memory.writebyte(feet2,col.canary)
		memory.writebyte(line2,col.orange)
		memory.writebyte(body4,col.beige)
		memory.writebyte(feet4,col.salmon)
		memory.writebyte(line4,col.black)
		end
	else --default
		memory.writebyte(body,col.rose)
		memory.writebyte(feet,col.blush)
		memory.writebyte(line,col.black)
		memory.writebyte(body2,col.white)
		memory.writebyte(feet2,col.canary)
		memory.writebyte(line2,col.orange)
		memory.writebyte(body4,col.rose)
		memory.writebyte(feet4,col.blush)
		memory.writebyte(line4,col.black)
	end
else --default powerup, this specifically should probably never get called unless you have one of the weird ones like Goodbye
	memory.writebyte(body,col.beige)
	memory.writebyte(feet,col.salmon)
	memory.writebyte(line,col.black)
	memory.writebyte(body2,col.white)
	memory.writebyte(feet2,col.canary)
	memory.writebyte(line2,col.orange)
	memory.writebyte(body4,col.beige)
	memory.writebyte(feet4,col.salmon)
	memory.writebyte(line4,col.black)
end
return nil
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

--[[
if(not(memory.readbyte(pauseAdd) == 0x19 or memory.readbyte(pauseAdd) == 0x25)) then
if(memory.readbyte(livesDisplay) > 0x01) then
  moveReg(149,191,180,230,-140,0) --moves copy ability box
else
  moveReg(149,191,180,230,-140,0) --moves copy ability box
end
elseif(memory.readbyte(pauseAdd) == 0x19) then
  moveReg(22,58,183,225,-10,0) --moves copy ability box
end
]]

if(not(memory.readbyte(pauseAdd) == 0x25)) then
gui.text(50,180,"                                   \n                                   \n                                   \n                                   \n                                   \n                                   \n","#7c0800","#fcd8a8")

gui.text(50,184,"HP "..((memory.readbyte(hpAdd)+1)/8),"#7c0800","#fcd8a8")
gui.text(50,205,"Lives:"..memory.readbyte(livesAdd),"#7c0800","#fcd8a8")

gui.box(80,182,144,202,"#fcd8a8")
for hpBit=0,5 do
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

gui.text(50,218,names[memory.readbyte(powerupAdd)][1],"#7c0800","#fcd8a8")
gui.text(154,185,names[memory.readbyte(powerupAdd)][2],"#7c0800","#fcd8a8")

end
end

function pausee()
if(memory.readbyte(pauseAdd) == 0x25) then
 gui.box(40,40,215,135,"P30");
 gui.text(80,24," >MOVE <CHANGE ","P16","#ffffff")
 gui.text(51,40,"Recolors: "..(function() if recoloring then return 'ON' else return 'off' end end)(),"P16","clear")
 gui.text(51,48,"LUA-Based Hud: "..(function() if newhud then return 'ON' else return 'off' end end)(),"P27","clear")
 gui.text(51,56,"Health: "..(function()if (memory.readbyte(hpAdd)==0xFF) then return '0' elseif (memory.readbyte(hpAdd)==0x37) then return "INF" else return (memory.readbyte(hpAdd)+0x01)/0x08 end end)(),"P28","clear")
 gui.text(51,64,"Lives: "..(memory.readbyte(livesAdd)),"P2A","clear")
 gui.text(51,72,"Powerup: "..(names[memory.readbyte(powerupAdd)][1]),"P2B","clear")
 gui.text(51,80,"Powerup State: "..(bodies[memory.readbyte(bodyAdd)]),"P2C","clear")
 gui.text(51,88,"Powerup Uses: "..(memory.readbyte(usesAdd)),"P11","clear")
 --gui.text(51,96,"Thing: "..(0),"P14","clear")
 --gui.text(51,104,"Thing: "..(0),"P24","clear")
 --gui.text(51,112,"Thing: "..(0),"P00","clear")
 --gui.text(51,120,"Thing: "..(0),"P0F","clear")
 gui.text(51,128,"Meta Knightmare: "..(function() if metaknight then return 'ON' else return 'off' end end)(),"P07","clear")
 gui.text(42,40+(selector*8),">","#000","clear")

 if(AND(memory.readbyte(controller2Add),0x08) == 0x08) then
 selector = selector-1
 if(selector == -1) then selector=11 end
 end
 
 if(AND(memory.readbyte(controllerAdd),0x01) == 0x01 or AND(memory.readbyte(controller2Add),0x04) == 0x04) then
 selector = selector+1
 if(selector == 12) then selector=0 end
 end
 
 if(AND(memory.readbyte(controller2Add),0x20) == 0x20) then
 if(selector==0) then recoloring = false end
 if(selector==1) then newhud = false end
 if(selector==2) then memory.writebyte(hpAdd, 0x2F) end
 if(selector==3) then memory.writebyte(livesAdd, 0x04) end
 if(selector==4) then memory.writebyte(powerupAdd, 0xFF) end
 if(selector==5) then memory.writebyte(bodyAdd, 0x00) end
 if(selector==6) then memory.writebyte(usesAdd, 0x00) end
 if(selector==11) then metaknight = false end
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
 memory.writebyte(bodyAdd,0x03) --sword state
 memory.writebyte(powerupAdd,0xFF) --normal powerup, stops other copy abilities
 memory.writebyte(body,col.rose)
 memory.writebyte(feet,col.blush)
 memory.writebyte(line,col.black)
 memory.writebyte(body2,col.marigold)
 memory.writebyte(feet2,col.carrot)
 memory.writebyte(line2,col.gold)
 memory.writebyte(body4,col.white) --nes metaknight coloring
 memory.writebyte(feet4,col.purple)
 memory.writebyte(line4,col.black)
 --meta knight falls faster, but can recover with floating much quicker, and can hover with aerial attacks
 if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and not (AND(memory.readbyte(controllerAdd),0x08) == 0x08)) then memory.writebyte(yveloAdd,0x02) end
 if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and (AND(memory.readbyte(controllerAdd),0x08) == 0x08)) then memory.writebyte(yveloAdd,0xFE) end
 if((memory.readbyte(yveloAdd) > 0x00) and (memory.readbyte(yveloAdd) < 0x03) and (AND(memory.readbyte(controllerAdd),0x40) == 0x40)) then memory.writebyte(yveloAdd,0x00) end
 --draws a mask onto his face poorly
 gui.box(memory.readbyte(xposAdd)+10,memory.readbyte(yposAdd)+8,memory.readbyte(xposAdd)+16,memory.readbyte(yposAdd)+6,"P0F") --P03 --P20
 end

--delays for n amount of time.
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
memory.register(pauseAdd, 0x01, pausee())

if(invinc) then memory.writebyte(hpAdd,0x37) end
if(metaknight) then knightmare() end
--memory.register(powerAdd, 60, recolor())
emu.frameadvance()
end
