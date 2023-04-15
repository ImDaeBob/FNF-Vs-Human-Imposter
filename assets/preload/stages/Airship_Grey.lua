local xx = -100; --750
local yy = 1000; --750
local xx2 = 200; --1500
local yy2 = 1000; --750
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
	
	makeLuaSprite('floor','gray/graybg', -1500, 300)
	makeLuaSprite('darky','gray/graymultiply', -1500, 300)
	makeLuaSprite('overlay','gray/grayoverlay', -1500, 300)
	
	makeAnimatedLuaSprite('grayglowy','gray/grayglowy', 425, 750)
	addAnimationByPrefix('grayglowy','loop','jar??',24,true)
    objectPlayAnimation('grayglowy','loop',true);
	
	makeAnimatedLuaSprite('black','gray/black-watching', -1150, 450)
	addAnimationByPrefix('black','loop','daddy',24,false)
    objectPlayAnimation('black','loop',false);

	addLuaSprite('floor')
	addLuaSprite('grayglowy')
	addLuaSprite('black')
	
	addLuaSprite('darky', true)
	addLuaSprite('overlay', true)
	
	setProperty('darky.alpha', 1);
	setProperty('overlay.alpha', 0.25);
	
	makeLuaSprite('darkSC','DarkSC', 0, 0)
	addLuaSprite('darkSC')
	setObjectCamera('darkSC', 'other');
	setProperty('darkSC.alpha', 0.65);

	
	
end

function onBeatHit()
    if curBeat % 2 == 0 then
	     playAnim('grayglowy','loop', true);
		 playAnim('black','loop', true);
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

