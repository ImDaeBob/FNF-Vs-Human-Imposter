local xx = -100; --750
local yy = 1250; --750
local xx2 = 200; --1500
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
	setProperty('gf.alpha', 0);
end

function onCreate()
	--background boi
	
	makeLuaSprite('floor','BG/maroon/cooking/platform', -900, 1600)
	scaleObject('floor', 1.5, 1);
	makeLuaSprite('overlay','BG/maroon/cooking/LAVA OVERLAY IN GAME', -1300, 550)
	scaleObject('overlay', 1.5, 1);
	makeLuaSprite('schot','BG/maroon/cooking/schot', 0, 0)

	makeAnimatedLuaSprite('wall','BG/maroon/cooking/wallBP', -2200, 250)
	addAnimationByPrefix('wall','loop','Back wall and lava',24,true)
    objectPlayAnimation('wall','loop',true);
	
	makeAnimatedLuaSprite('bubb','BG/maroon/cooking/bubbles', -2200, 250)
	addAnimationByPrefix('bubb','loop','Lava Bubbles',24,true)
    objectPlayAnimation('bubb','loop',true);

	
	addLuaSprite('wall')
	addLuaSprite('bubb')
	addLuaSprite('floor')
	addLuaSprite('overlay', true)
	addLuaSprite('schot', true)

	
	setProperty('overlay.alpha', 0.5);
	setBlendMode('overlay', 'add')
	setBlendMode('schot', 'add')
	
	setObjectCamera('schot', 'other');
	setProperty('schot.alpha', 0);
	
end

function onStepHit()
   if curStep == 1 then
   doTweenAlpha('sohotomg', 'schot', 0.5, 160, 'linear');
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

