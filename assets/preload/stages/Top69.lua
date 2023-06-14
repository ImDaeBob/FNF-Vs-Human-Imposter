local xx = -50; --750
local yy = 1350; --750
local xx2 = 175; --1500
local yy2 = 1350; --750
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = false;
local beating = true;
local beat_skip = 0;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
end

function onCreate()
	--background boi
	
	makeLuaSprite('floor','BG/green/mirafg', -2750, 800)
	scaleObject('floor',1.25,1.25)
	makeLuaSprite('bg','BG/green/mirabg', -2750, 800)
	scaleObject('bg',1.25,1.25)
	makeLuaSprite('table','BG/green/table_bg', -2750, 800)
	scaleObject('table',1.25,1.25)
	
    addLuaSprite('bg')
	addLuaSprite('floor')
	addLuaSprite('table')

	
end

function onStepHit()
    if curStep == 896 then
	yy = 1450;
	yy2 = 1450;
	triggerEvent('Camera Follow Pos',xx,yy)
	end
	if curStep == 1024 then
	yy = 1350;
	yy2 = 1350;
	triggerEvent('Camera Follow Pos',xx,yy)
	end
    if curStep == 1344 then
	xx = 0
	xx2 = 0
	triggerEvent('Camera Follow Pos',xx,yy)
	end
	if curStep == 1604 then
	xx = -50
	xx2 = 175
	triggerEvent('Camera Follow Pos',xx,yy)
	end
end

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
			end

        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
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

