local beating = false;

function onCreate()
    setProperty('camHUD.visible', false);
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
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'other');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'other');
	
	objectsOverlap('pinky', 'pinky2')
	
	makeLuaSprite('Name','OVERdelusion', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	
	makeLuaSprite('text1','BG/OVgrey/heisoutof', 0, 0)
	addLuaSprite('text1')
	setObjectCamera('text1', 'hud');
	setProperty('text1.alpha', 0);
	scaleObject('text1',0.7,0.7)
	
	makeLuaSprite('text2','BG/OVgrey/fucking control', 0, 0)
	addLuaSprite('text2')
	setObjectCamera('text2', 'hud');
	setProperty('text2.alpha', 0);
	scaleObject('text2',0.7,0.7)
	
	makeLuaSprite('text3','BG/OVgrey/overload', 0, 0)
	addLuaSprite('text3')
	setObjectCamera('text3', 'hud');
	setProperty('text3.alpha', 0);
	scaleObject('text3',0.7,0.7)
	
end

function onBeatHit()
	if curBeat % 1 == 0 then
		if beating == true then
	        triggerEvent('Add Camera Zoom', 0.03, 0.03)
		end
	end
end

function onStepHit()
   if curStep == 256 then
   setProperty('text1.alpha', 1);
   end
   if curStep == 268 then
   setProperty('text2.alpha', 1);
   end
   if curStep == 288 then
   flash()
   setProperty('text1.alpha', 0);
   setProperty('text2.alpha', 0);
   end
   if curStep == 928 then
   setProperty('flash.alpha', 1);
   end
   if curStep == 944 then
   setProperty('flash.alpha', 0);
   setProperty('text3.alpha', 1);
   end
   if curStep == 960 then
   flash()
   setProperty('text3.alpha', 0);
   end
   if curStep == 1 then
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 160 then
   beating = true;
   flash()
   end
   if curStep == 416 or curStep == 800 or curStep == 1056 then
   beating = false;
   end
   if curStep == 544 then
   beating = true;
   end
   if curStep == 1 then
   setProperty('flash.alpha', 0);
   flash()
   setProperty('camHUD.visible', true);
   cutoff()
   end
   if curStep == 32 then
   flash()
   end
   if curStep == 288 then
   cuton()
   end
   if curStep == 416 or curStep == 1056 then
   cutoff()
   end
   if curStep == 1212 then
   setProperty('red.alpha', 1);
   end
   if curStep == 1205 then
   doTweenAlpha('endfade', 'flash', 1, 0.5, 'linear');
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
	doTweenX('NameTweenX2', 'Name', -500, 2, 'CircInOut');
    end
end

function cuton()
    doTweenY('CSUPY', 'csup', 0, 1, 'CircInOut');
    doTweenY('SCDOWNY', 'csdown', 0, 1, 'CircInOut');
	setProperty('healthBar.alpha', tonumber(0))
    setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
end

function cutoff()
    doTweenY('CSUPYend', 'csup', -100, 1, 'CircInOut');
    doTweenY('SCDOWNYend', 'csdown', 100, 1, 'CircInOut');
	setProperty('healthBar.alpha', tonumber(1))
    setProperty('iconP1.alpha', tonumber(1))
    setProperty('iconP2.alpha', tonumber(1))
end