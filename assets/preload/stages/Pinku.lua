
local del = 0;
local del2 = 0;
local damage = false;
local beating = true;
local beat_skip = 0;



function onCreate()
	--background boi
	
	makeLuaSprite('floor','Mira/glasses', -1500, -100)
	makeLuaSprite('sky','Mira/bg sky', -1650, -200)
	makeLuaSprite('what is this','Mira/what is this', -300, 0)
	makeLuaSprite('front pot','Mira/front pot', -1300, 1250)
	setScrollFactor('front pot', 0.9, 0.9);
	makeLuaSprite('lmao','Mira/lmao', -1050, 650)
	
	makeAnimatedLuaSprite('vines','Mira/vines', -1200, -600)
	addAnimationByPrefix('vines','loop','green',24,true)
    objectPlayAnimation('vines','loop',true);
	setScrollFactor('vines', 0.9, 0.9);
	

    makeAnimatedLuaSprite('grey','uglyass', -750, 500)
	addAnimationByPrefix('grey','loop','grey',24,false)
    objectPlayAnimation('grey','loop',false);
	
	makeAnimatedLuaSprite('coral','uglyass', 300, 600)
	addAnimationByPrefix('coral','loop','CT',24,false)
    objectPlayAnimation('coral','loop',false);
	
	makeAnimatedLuaSprite('flowerguy','Backgroundbois', -1200, 600)
	addAnimationByPrefix('flowerguy','loop','flowerguy',24,false)
    objectPlayAnimation('flowerguy','loop',false);
	setScrollFactor('flowerguy', 0.9, 0.9);
	
	makeAnimatedLuaSprite('righthandman','Backgroundbois', 800, 800)
	addAnimationByPrefix('righthandman','loop','righthandman',24,false)
    objectPlayAnimation('righthandman','loop',false);
	setScrollFactor('righthandman', 0.9, 0.9);

    addLuaSprite('sky')
	addLuaSprite('floor')
	addLuaSprite('grey')
	addLuaSprite('coral')
	addLuaSprite('what is this')
	addLuaSprite('lmao')
	
	
	
	addLuaSprite('flowerguy', true)
	addLuaSprite('righthandman', true)
	addLuaSprite('front pot', true)
	addLuaSprite('vines', true)
	

	
	
end

function onBeatHit()
    if curBeat % 1 == 0 then
		 playAnim('flowerguy','loop', true);
	end
    if curBeat % 2 == 0 then
	     playAnim('grey','loop', true);
		 playAnim('righthandman','loop', true);
		 playAnim('coral','loop', true);
	end
end

function opponentNoteHit()
	
    health = getProperty('health')
    if damage == true then
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end
end

