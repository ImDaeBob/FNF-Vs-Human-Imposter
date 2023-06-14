local beating = false;
local red = false;
local shake = false;

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
	setProperty('flash.alpha', 0);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'hud');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'hud');
	
	
	makeLuaSprite('Name','makeshift', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	
end

function onBeatHit()
	if curBeat % 2 == 0 then
	  if beating == true then
	  triggerEvent('Add Camera Zoom', 0.06, 0.05)
	  end
	end
end

function onStepHit()
   if curStep == 839 or curStep == 855 or curStep == 903 or curStep == 919 or curStep == 1367 or curStep == 1383 or curStep == 1431 or curStep == 1447 then
   shake = true;
   end
   if curStep == 847 or curStep == 864 or curStep == 912 or curStep == 927 or curStep == 1375 or curStep == 1392 or curStep == 919 or curStep == 1440 or curStep == 1455 then
   shake = false;
   end
   if curStep == 576 then
   flash();
   beating = true;
   setProperty('camHUD.visible', true);
   end
   if curStep == 513 then
   setProperty('camHUD.visible', false);
   end
   if curStep == 1 then
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 9999 or curStep == 9999 then
   beating = false;
   end
   if curStep == 9999 or curStep == 9999 then
   beating = true;
   end
   if curStep == 576 or curStep == 9999 then
   cuton()
   end
   if curStep == 509 or curStep == 9999 then
   cutoff()
   end
   if curStep == 1104 or curStep == 1360 then
   flash()
   end
   if curStep == 2392 then
   beating = false;
   doTweenAlpha('darkyetdarker', 'flash', 1, 8, 'linear');
   end
end

function flash()
    setProperty('flashwhite.alpha', 1);
	doTweenAlpha('flashdown', 'flashwhite', 0, 0.5, 'linear');
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'Name', -500, 2, 'CircInOut');
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
if shake == true then
    triggerEvent('Screen Shake','0.02, 0.02','0.1, 0.01');
end
end