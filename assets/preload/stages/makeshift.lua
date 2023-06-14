local xx = -380; --750
local yy = 1400; --750
local xx2 = -380; --1500
local yy2 = 1400; --750
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = false;
local beating = true;
local beat_skip = 0;
local useless = false;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
	setProperty('boyfriend.alpha', 0);
	setProperty('gf.alpha', 0);
	setProperty('OppSplash', false);
	
	addCharacterToList('grey')
end

function onCreate()
	--background boi
	makeLuaSprite('bg','BG/grey/greyroom', -1900, 0)
	makeLuaSprite('OV','BG/grey/overlay', -1900, 0)
	makeLuaSprite('DarkSC','DarkSC', 0, 0)
    addLuaSprite('bg')
	addLuaSprite('OV', true)
	addLuaSprite('DarkSC', true)
	
	setBlendMode('OV', 'MULTIPLY')
	setProperty('OV.alpha', 1);
	
	setObjectCamera('DarkSC', 'other');
	setProperty('DarkSC.alpha', 0.75);
	
	--grey week
	makeLuaSprite('floor','BG/grey/graybg', -1500, 300)
	makeLuaSprite('darky','BG/grey/graymultiply', -1500, 300)
	
	makeAnimatedLuaSprite('grayglowy','BG/grey/grayglowy', 425, 750)
	addAnimationByPrefix('grayglowy','loop','jar??',24,true)
    objectPlayAnimation('grayglowy','loop',true);


	addLuaSprite('floor')
	addLuaSprite('grayglowy')
	
	addLuaSprite('darky', true)
	
	setProperty('floor.alpha', 0);
	setProperty('grayglowy.alpha', 0);
	setProperty('black.alpha', 0);
	setProperty('darky.alpha', 0);
	
	makeLuaSprite('darkSC','DarkSC', 0, 0)
	addLuaSprite('darkSC')
	setObjectCamera('darkSC', 'other');
	setProperty('darkSC.alpha', 0.65);
	
	makeLuaSprite('flashback','flashback', 0, 0)
	addLuaSprite('flashback')
	setObjectCamera('flashback', 'other');
	setBlendMode('flashback', 'MULTIPLY')
	setProperty('flashback.alpha', 0);
end

function onUpdate(elapsed)
    if useless == false then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
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
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
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

function onStepHit()
   if curStep == 1104 then
    setProperty('boyfriend.alpha', 1);
    xx = -100; --750
    yy = 1000; --750
    xx2 = 200; --1500
    yy2 = 1000;
	ofs = 15;
    triggerEvent('Change Character', 1, 'grey');
	setCharacterX('dad', -650);
	setCharacterY('dad', 725);
	setCharacterX('bf', 300);
	setCharacterY('bf', 625);
    setProperty('floor.alpha', 1);
    setProperty('grayglowy.alpha', 1);
    setProperty('darky.alpha', 1);
	setProperty('flashback.alpha', 0.5);
	setProperty('bg.alpha', 0);
	end
	if curStep == 1360 then
    setProperty('boyfriend.alpha', 0);
    xx = -380; --750
    yy = 1400; --750
    xx2 = -380; --1500
    yy2 = 1400; --750
	ofs = 35;
	setProperty('camFollowPos.x',xx)
    setProperty('camFollowPos.y',yy)
    triggerEvent('Change Character', 1, '1stgrey');
	setCharacterX('dad', -600);
	setCharacterY('dad', 1050);
    setProperty('floor.alpha', 0);
    setProperty('grayglowy.alpha', 0);
    setProperty('darky.alpha', 0);
	setProperty('flashback.alpha', 0);
	setProperty('bg.alpha', 1);
	end
end
