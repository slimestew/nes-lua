--recolors several copy abilities for visual appeal (and so its not just the same 2 colors)
--by slimestew
--i can only *really* write to a palette buffer, it works in a lot of cases but sometimes the part2 effects have issues lingering
--in those cases you can just pause to fix it

powerAdd = 0x05E0 --powerup held
powerupAdd = 0x05E3 --current powerup
statesAdd = 0x0604 --various states
hudFlickerAdd = 0x004D --used for abilities like crash with flickering colors
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
names[25] = "Bye Bye"
names[26] = "err"
names[255] = "Normal"

--other palette locations if it finds a use
--feet3 = 0x0102
--line3 = 0x0103
--enemy1 = 0x019B
--enemy2 = 0x019C
--enemy3 = 0x019D
--fg1 = 0x018F
--fg2 = 0x0190
--fg3 = 0x0191
--bg1 = 0x0183
--bg2 = 0x0184
--bg3 = 0x0185

function recolor()
pwr = names[memory.readbyte(powerupAdd)]
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
--custom
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
elseif(pwr == "err") then
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

while(true)do
memory.register(body3, 0x199, recolor())
--memory.register(powerAdd, 60, recolor())
emu.frameadvance()
end
