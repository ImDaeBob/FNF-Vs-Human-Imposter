
local damage = false;
local beating = true;
local beat_skip = 0;



function onCreate()
	--background boi
	
	makeLuaSprite('floor','BG/maroon/newstage', -1500, 0)
	makeLuaSprite('overlay','BG/maroon/newoverlay', -1500, 0)
	makeLuaSprite('sky','BG/maroon/newsky', -1500, 50)

	makeAnimatedLuaSprite('snow','BG/red/snow', -1200, 350)
	addAnimationByPrefix('snow','loop','cum',24,true)
    objectPlayAnimation('snow','loop',true);
	scaleObject('snow', 2.25, 2.25);
	

    addLuaSprite('sky')
	addLuaSprite('floor')
	addLuaSprite('overlay', true)

	addLuaSprite('snow', true)
	setProperty('overlay.alpha', 0.5);
	setBlendMode('overlay', 'add')
	
end

function opponentNoteHit()
	
    health = getProperty('health')
    if damage == true then
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
    end
end

