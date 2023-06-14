

local beating = true;
local beat_skip = 0;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
end

function onCreate()
	--background boi
	
	makeLuaSprite('floor','BG/green/reactorOV/floornew', -1550, 250)
	makeLuaSprite('BP1','BG/green/reactorOV/backbars', -1550, 250)
	makeLuaSprite('wall','BG/green/reactorOV/wallbgthing', -1550, 250)
	makeLuaSprite('darksc','BG/green/reactorOV/frontblack', 0, 0)
	
	makeAnimatedLuaSprite('core','BG/green/reactorOV/ball lol', -275, 250)
	addAnimationByPrefix('core','loop','core instance',24,true)
    objectPlayAnimation('core','loop',true);
	setScrollFactor('core', 0.9, 0.9);
	
	makeAnimatedLuaSprite('mungus1','BG/green/reactorOV/bgmungus1', -650, 1150)
	addAnimationByPrefix('mungus1','loop','yallow',24,false)
    objectPlayAnimation('mungus1','loop',false);
	
	makeAnimatedLuaSprite('mingus2','BG/green/reactorOV/bgmungus2', -1050, 1150)
	addAnimationByPrefix('mingus2','loop','brown',24,false)
    objectPlayAnimation('mingus2','loop',false);
	scaleObject('mingus2', 1.25, 1.25);
	
	makeAnimatedLuaSprite('mingus3','BG/green/reactorOV/bgmungus2', -1550, 1150)
	addAnimationByPrefix('mingus3','loop','brown',24,false)
    objectPlayAnimation('mingus3','loop',false);
	scaleObject('mingus3', 1.25, 1.25);
	
	
	addLuaSprite('wall')
	addLuaSprite('floor')
	addLuaSprite('mungus1')
	addLuaSprite('BP1')
	addLuaSprite('core')
	
	addLuaSprite('mingus2')
	addLuaSprite('mingus3')
	
	
	addLuaSprite('darksc')
	
	setProperty('darksc.alpha', 0.25);
	setObjectCamera('darksc', 'other');

	
end

function onStepHit()
   
end

function onBeatHit()
	if curBeat % 4 == 0 then
    objectPlayAnimation('core','loop',true);
	objectPlayAnimation('mungus1','loop',true);
	objectPlayAnimation('mingus2','loop',true);
	objectPlayAnimation('mingus3','loop',true);
	end
end




