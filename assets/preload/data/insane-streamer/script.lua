local beating = false;

function onCreate()
    makeLuaSprite('red','redbg', -600, -400)
	makeLuaSprite('flash','Flash', 0, 0)
	makeLuaSprite('flashwhite','flashwhite', 0, 0)
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
	
	addLuaSprite('flash')
	addLuaSprite('flashwhite')
	addLuaSprite('red')
	
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	makeAnimatedLuaSprite('jumpscare','BG/jerma/jerma_mungus_jump_scare', -400, -700)
	addAnimationByPrefix('jumpscare','loop','JERMA jump',24,false)
    objectPlayAnimation('jumpscare','loop',false);
	setObjectCamera('jumpscare', 'other');
	addLuaSprite('jumpscare')
	setProperty('jumpscare.alpha', 0);
	
	setProperty('red.alpha', 0);
	setProperty('flash.alpha', 0);
	setObjectCamera('flash', 'other');
	setProperty('flashwhite.alpha', 0);
	setObjectCamera('flashwhite', 'other');
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'other');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'other');
	
	makeLuaSprite('Name','insanestreamer', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
end

function onBeatHit()
    if curBeat % 4 == 0 then
	    if beating == true then
		 triggerEvent('Add Camera Zoom', 0.02, 0.02)
		 end
	end
end

function onStepHit()
   if curStep == 1 then
   cutoff()
		doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
		runTimer('nameout', 5);
   end
   if curStep == 1010 then
   setProperty('jumpscare.alpha', 1);
   objectPlayAnimation('jumpscare','loop',false);
   end
   if curStep == 1024 then
   flash()
   setProperty('jumpscare.alpha', 0);
   end
   if curStep == 9999 then
   flash()
   end
   if curStep == 1 or curStep == 9999 then
   beating = true;
   end
   if curStep == 9999 or curStep == 9999 then
   beating = false;
   end
   if curStep == 9999 or curStep == 9999 or curStep == 9999 then
   cuton()
   end
   if curStep == 1 or curStep == 9999 then
   cutoff()
   end
   if curStep == 9999 then
   setProperty('camHUD.visible', false);
   doTweenAlpha('endfade', 'flash', 1, 5, 'linear');
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

function beating()
    heartbeat = true;
    setProperty('pinky.alpha', 0.75);
	setProperty('pinky2.alpha', 0.75);
	doTweenAlpha('SCheart start', 'SCheart', 1, 1, 'linear');
end

function beatingoff()
    heartbeat = false;
	doTweenAlpha('pinky end', 'pinky', 0, 1, 'linear');
	doTweenAlpha('pinky2 end', 'pinky2', 0, 1, 'linear');
	doTweenAlpha('SCheart end', 'SCheart', 0, 1, 'linear');
end