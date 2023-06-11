local xx = -280; --750
local yy = 1300; --750
local xx2 = -380; --1500
local yy2 = 1400; --750
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
local damage = false;
local useless = false;
local dadZoom = 1; --1.2
local bfZoom = 0.6; --0.9

local beating = false;

function onCreatePost()
    triggerEvent('Camera Follow Pos',xx,yy)
	middle = getPropertyFromClass('ClientPrefs', 'middleScroll')
	if middle == false then
		for i = 0,7 do
			xValue = getPropertyFromGroup('strumLineNotes', i, 'x')
			if i < 3.5 then
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue+640)
			else
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue-640)
			end
		end
	end
end

function onCreate()
    makeLuaSprite('red','redbg', 0, 0)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
    addLuaSprite('red')
	addLuaSprite('flash')
	addLuaSprite('flashwhite')
	
	
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	
	
	setProperty('red.alpha', 0);
	setObjectCamera('red', 'other');
	setProperty('flash.alpha', 1);
	setObjectCamera('flash', 'hud');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'hud');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'hud');
	
	makeLuaSprite('Name','mania', 1000, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	
end

function onBeatHit()
	if curBeat % 2 == 0 then
	  if beating == true then
	  triggerEvent('Add Camera Zoom', 0.03, 0.03)
	  end
	end
end


function onStepHit()
   if curStep == 1 then
		doTweenX('NameTweenX', 'Name', 200, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 1 then
   flash()
   setProperty('flash.alpha', 0);
   setObjectCamera('flash', 'other');
   end
   if curStep == 1536 then
   setProperty('flash.alpha', 1);
   bfZoom = 1;
   xx2 = -680;
   yy2 = 1500;
   end
   if curStep == 2048 then
   flash()
   setProperty('flash.alpha', 0);
   bfZoom = 0.6;
   xx2 = -380;
   yy2 = 1400;
   end
   if curStep == 1592 or curStep == 4208 then
   doTweenAlpha('cutscenefade1', 'flash', 0.5, 1.5, 'linear');
   end
   if curStep == 4096 then
   doTweenAlpha('cutscenefade2', 'flash', 1, 3, 'linear');
   end
   if curStep == 4200 then
   triggerEvent('Change Character', 0, 'yellowghost');
   triggerEvent('Change Character', 1, '1stpink');
   setCharacterX('bf', -400);
   setCharacterX('dad', -600);
   setCharacterY('dad', 800);
   xx = -380;
   yy = 1200;
   yy2 = 1400;
   bfZoom = 1;
   dadZoom = 0.65;
   middle = getPropertyFromClass('ClientPrefs', 'middleScroll')
	if middle == false then
		for i = 0,7 do
			xValue = getPropertyFromGroup('strumLineNotes', i, 'x')
			if i < 3.5 then
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue-320)
			else
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue+320)
			end
		end
	end
   end
   if curStep == 4217 then
   flash()
   setProperty('flash.alpha', 0);
   end
   if curStep == 256 or curStep == 512 then
   beating = true
   end
   if curStep == 448 or curStep == 9999 then
   beating = false
   end
   if curStep == 768 or curStep == 1280 or curStep == 3328 then
   flash()
   end
   if curStep == 448 or curStep == 9999 then
   cuton()
   end
   if curStep == 9999 or curStep == 9999 then
   cutoff()
   end
   if curStep == 448 then
   flashdark()
   setProperty('camHUD.visible', false);
   end
   if curStep == 512 then
   flash()
   setProperty('camHUD.visible', true);
   end
end

function flash()
    setProperty('flashwhite.alpha', 1);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end

function flashdark()
    setProperty('flash.alpha', 1);
	doTweenAlpha('flashdowndark', 'flash', 0, 1.5, 'linear');
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'Name', 1000, 2, 'CircInOut');
    end
end

function cuton()
    doTweenY('CSUPY', 'csup', 0, 1, 'CircInOut');
    doTweenY('SCDOWNY', 'csdown', 0, 1, 'CircInOut');
end

function cutoff()
    doTweenY('CSUPYend', 'csup', -100, 1, 'CircInOut');
    doTweenY('SCDOWNYend', 'csdown', 100, 1, 'CircInOut');
end

function opponentNoteHit()
    health = getProperty('health')
        if getProperty('health') > 0.4 then
            setProperty('health', health- 0.02);
		end
end
	
function onUpdate(elapsed)
    if useless == false then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',dadZoom)

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

            setProperty('defaultCamZoom',bfZoom)

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