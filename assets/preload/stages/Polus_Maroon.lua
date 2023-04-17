local xx = 100; 
local yy = 1345; 
local xx2 = 400; 
local yy2 = 1370;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local CZoom = 0.72;
local CZoom1 = 0.85;
local cam = 0; --Just for the Fancy Mid Cam at the start of the Song, nothing else :v

local HPDrain = false;

function onCreate()
	if songName == 'Ashes' or songName == 'Magmatic' then
		makeLuaSprite('Sky','Polus/Maroon/OnLand/newsky', -1500, 50)
		addLuaSprite('Sky')
		
		makeLuaSprite('Clouds','Polus/Maroon/OnLand/newcloud', -1500, 0)
		setProperty('Clouds.alpha', 0.7)
		addLuaSprite('Clouds')
		
		makeLuaSprite('Rocks','Polus/Maroon/OnLand/newrocks', -1500, 0)
		setProperty('Rocks.alpha', 0.8)
		addLuaSprite('Rocks')
		
		makeLuaSprite('Stage','Polus/Maroon/OnLand/newstage', -1500, 0)
		addLuaSprite('Stage')
		
		makeLuaSprite('LavaGlow','Polus/Maroon/OnLand/newlava', -1500, 380)
		setProperty('LightOverlay.alpha', 1)
		setBlendMode('LavaGlow', 'ADD')
		scaleObject('LavaGlow', 1, 0.7)
		addLuaSprite('LavaGlow')
		
		makeAnimatedLuaSprite('SnowBack', 'Polus/Maroon/OnLand/snowback', -1500, 400)
		addAnimationByPrefix('SnowBack', 'Snow', 'Snow', 24, true)
		setProperty('SnowBack.alpha', 0.13)
		scaleObject('SnowBack', 3.2, 3.25)
		-- setBlendMode('SnowBack', 'ADD')
		addLuaSprite('SnowBack')
		
		makeAnimatedLuaSprite('SnowFront', 'Polus/Maroon/OnLand/snowfront', -1250, 550)
		addAnimationByPrefix('SnowFront', 'Snow', 'snow', 24, true)
		setProperty('SnowFront.alpha', 0.3)
		scaleObject('SnowFront', 2.4, 2)
		setBlendMode('SnowFront', 'ADD')
		addLuaSprite('SnowFront', true)
		
		makeLuaSprite('MainOverlay', 'Polus/Maroon/OnLand/newoverlay', -1500, 0)
		setProperty('MainOverlay.alpha', 0.44)
		setBlendMode('MainOverlay', 'ADD')
		addLuaSprite('MainOverlay', true)
		
		makeLuaSprite('LightOverlay', 'Polus/Maroon/OnLand/newoverlay', -1500, 0)
		setProperty('LightOverlay.alpha', 0.21)
		setBlendMode('LightOverlay', 'ADD')
		addLuaSprite('LightOverlay', true)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Boiling Point' then
		makeAnimatedLuaSprite('wall','Polus/Maroon/InVolcano/wallBP', -2900, -100)
		addAnimationByPrefix('wall','loop','Back wall and lava',24,true)
		scaleObject('wall', 1.4, 1.3)
		addLuaSprite('wall')
		
		makeAnimatedLuaSprite('bubb','Polus/Maroon/InVolcano/bubbles', -1000, 1800)
		addAnimationByPrefix('bubb','loop','Lava Bubbles',24,true)
		scaleObject('bubb', 1.3, 1.3)
		addLuaSprite('bubb')
		
		makeLuaSprite('floor','Polus/Maroon/InVolcano/platform', -950, 1525)
		scaleObject('floor', 1.5, 2)
		addLuaSprite('floor')
		
		makeLuaSprite('OrangeGlow', 'Polus/Maroon/InVolcano/OrangeGlowOverlay', -1280, 420)
		setBlendMode('OrangeGlow', 'ADD')
		setProperty('OrangeGlow.alpha', 0.1)
		scaleObject('OrangeGlow', 2, 2)
		addLuaSprite('OrangeGlow', true)
			
		makeLuaSprite('Overlay', 'Polus/Maroon/InVolcano/overlaythjing', -1350, 300)
		setBlendMode('Overlay', 'ADD')
		scaleObject('Overlay', 2, 2)
		addLuaSprite('Overlay', true)
			
		setProperty('cameraSpeed', 1.5)
		HPDrain = true;
	end
	
	makeLuaSprite('RedFlash', '', 0, 0)
	makeGraphic('RedFlash', 1300, 750, 'FF1000')
	setObjectCamera('RedFlash','hud')
	setProperty('RedFlash.alpha', 0.0001)
	addLuaSprite('RedFlash', true)
	
	makeLuaSprite('RedFlash_Above', 'Polus/Maroon/InVolcano/RedFlash_Above', -1400, 400)
	setProperty('RedFlash_Above.alpha', 0.0001)
	scaleObject('RedFlash_Above', 1.47, 1.1)
	addLuaSprite('RedFlash_Above', true)	
end

function onCreatePost()
	if songName == "Boiling Point" then
		setProperty('defaultCamZoom', 0.65)
		setProperty('dad.x', -650)
		setProperty('dad.y', 1000)
		setProperty('boyfriend.x', 550)
		setProperty('boyfriend.y', 1290)
		setProperty('gf.visible', false)
		xx = 50; 
		yy = 1180; 	
		xx2 = 400; 	
		yy2 = 1400;
		CZoom = 0.5;
		CZoom1 = 0.7;	
		
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	midCam(true);
	setProperty('scoreTxt.color', getColorFromHex('AC3632'))
end

function flash(flashType, startAlpha, fadeTimer)
	if songName == 'Ashes' or songName == 'Magmatic' then
		if flashType == "Red" and flashingLights then
			setProperty('RedFlash.alpha', startAlpha)
			doTweenAlpha('FlashBye', 'RedFlash', 0, fadeTimer, 'sineInOut')
			triggerEvent('Add Camera Zoom', 0.035, 0.06)
			playSound('Alarm', 0.3)
		end
	elseif songName == 'Boiling Point' then
		if flashType == "Red" and flashingLights then
			setProperty('RedFlash_Above.alpha', startAlpha)
			doTweenAlpha('RedFlash_AboveBye', 'RedFlash_Above', 0, fadeTimer, 'sineInOut')
			triggerEvent('Add Camera Zoom', 0.035, 0.06)
		end
	end
end

function midCam(bool)
	if songName == 'Ashes' or songName == 'Magmatic' then
		if bool then
			xx = 250;	xx2 = 250;	yy = 1250;	yy2 = 1250;	CZoom = 0.65;	CZoom1 = 0.65;
		elseif not bool then
			xx = 100; 	xx2 = 400;	yy = 1345; 	yy2 = 1370;	CZoom = 0.72;	CZoom1 = 0.85;
		end
	end
	if songName == 'Boiling Point' then
		if bool then
			xx = 100;	xx2 = 100;	yy = 1190;	yy2 = 1190;	CZoom = 0.57;	CZoom1 = 0.57;
		elseif not bool then
			xx = 50; 	xx2 = 400;	yy = 1180; 	yy2 = 1400;	CZoom = 0.5;	CZoom1 = 0.7;
		end	
	end
end

local Particle = 0;
local ParRate = 5;

local Breath = 0;

function onStepHit()
	if songName == 'Ashes' then
		if curStep == 96 or curStep == 736 or curStep == 928 or curStep == 1024 or curStep == 1264 then
			midCam(true)
		end
		if curStep == 132 or curStep == 864 or curStep == 960 or curStep == 1168 or curStep == 1308 then
			midCam(false)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Magmatic' then
		if curStep == 800 then
			midCam(true)
		end
		if curStep == 1056 then
			midCam(false)
		end
		
		if curStep == 1184 then
			characterPlayAnim('dad', 'hey', true)
			setProperty('dad.specialAnim', true)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Boiling Point' then
		if curStep == 512 or curStep == 1024 or curStep == 1296 or curStep == 1568 then
			midCam(true)
		end
		if curStep == 640 or curStep == 1152 or curStep == 1553 then
			midCam(false)
		end
		
		if curStep == 880 or curStep == 884 or curStep == 888 or curStep == 892 then CZoom = CZoom + 0.1; xx = xx - 80; yy = yy - 45 end  
		if curStep == 944 or curStep == 948 or curStep == 952 or curStep == 956 then CZoom = CZoom - 0.1; xx = xx + 80; yy = yy + 45 end  
		
		if (curStep == 304 or curStep == 368 or curStep == 432 or curStep == 752 or curStep == 1152 or curStep == 1342 or curStep == 1824) and not lowQuality then
			ParRate = 1;
		end
		if (curStep == 400 or curStep == 1552) and not lowQuality then
			ParRate = 2;
		end
		if (curStep == 1168 or curStep == 1376) and not lowQuality then
			ParRate = 3;
		end
		if (curStep == 512 or curStep == 896) and not lowQuality then
			ParRate = 4;
		end
		if curStep == 336 or curStep == 464 or curStep == 640 or curStep == 782 then
			ParRate = 5;
		end
		
		if curStep == 1552 then
			triggerEvent('Change Scroll Speed', 1.025, 1.11)
		end
		if curStep == 1824 then
			triggerEvent('Change Scroll Speed', 1.075, 1.11)
		end
		
		if curStep % ParRate == 0 and (curStep < 1952 or curStep >= 2240) then
			ParticleX = getRandomInt(-1000, 2000)
			makeAnimatedLuaSprite('particle'..Particle, 'Polus/Maroon/InVolcano/ember', ParticleX, 1400)
			addAnimationByPrefix('particle'..Particle, 'Ember', 'ember', 24, true)
			rngScroll = getRandomInt(5,10)/10;
			setScrollFactor('particle'..Particle, rngScroll, rngScroll)
			rngScale = getRandomInt(5,12)/10;
			scaleObject('particle'..Particle, rngScale, rngScale)
			setProperty('particle'..Particle..'.alpha', getRandomInt(60, 100)/100)
			setBlendMode('particle'..Particle, 'ADD')
			if getRandomInt(1,2) == 1 then addLuaSprite('particle'..Particle, true) else addLuaSprite('particle'..Particle) setObjectOrder('particle'..Particle, getObjectOrder('floor')-1) end
			TweenTime = getRandomInt(10,60)/10;
			doTweenY('particleY'..Particle, 'particle'..Particle, getProperty('particle'..Particle..'.y')-1700, TweenTime, 'linear')
			doTweenX('particleX'..Particle, 'particle'..Particle, ParticleX+getRandomInt(-600, 600), TweenTime, 'linear')
			SmallTime = getRandomInt(-30, 7)/10;
			doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			Particle=Particle+1; if Particle >= 50 then Particle = 0 end
		end
		-------------------------------------------------------------------------------------------------------------------------------------------
		if curStep >= 1824 and not lowQuality then
			ParticleX = getRandomInt(0, 1300)
			makeAnimatedLuaSprite('particle'..Particle, 'Polus/Maroon/InVolcano/ember', ParticleX, 770)
			addAnimationByPrefix('particle'..Particle, 'Ember', 'ember', 24, true)
			rngScale = getRandomInt(9,22)/10;
			scaleObject('particle'..Particle, rngScale, rngScale)
			setProperty('particle'..Particle..'.alpha', getRandomInt(50, 90)/100)
			setBlendMode('particle'..Particle, 'ADD')
			setObjectCamera('particle'..Particle, 'camHUD')
			addLuaSprite('particle'..Particle, true)
			TweenTime = getRandomInt(10,40)/10;
			doTweenY('particleY'..Particle, 'particle'..Particle, -100, TweenTime, 'linear')
			doTweenX('particleX'..Particle, 'particle'..Particle, ParticleX+getRandomInt(-200, 200), TweenTime, 'linear')
			SmallTime = getRandomInt(-20, 7)/10;
			doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			Particle=Particle+1; if Particle >= 500 then Particle = 0 end
		end
	end
end

function onBeatHit()
	if songName == 'Ashes' then
		if curBeat % 8 == 0 and ((curBeat >= 0 and curBeat <= 24) or (curBeat >= 292 and curBeat <= 317)) then
			flash('Red', 0.2, 0.4)
		end
		if curBeat == 28 or curBeat == 320 or curBeat == 323 then
			flash('Red', 0.3, 0.4)
		end
		if curBeat % 2 == 0 and (curBeat >= 160 and curBeat <= 286) then
			flash('Red', 0.2, 0.3)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Magmatic' then
		if (curBeat-8) % 16 == 0 and ((curBeat >= 40 and curBeat <= 88) or (curBeat >= 136 and curBeat <= 184)) then
			flash('Red', 0.3, 0.4)
		end
		
		if curBeat % 8 == 0 and (curBeat >= 200 and curBeat <= 256) then
			flash('Red', 0.3, 0.4)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Boiling Point' then
		doTweenAlpha('OrangeGlowAlpha', 'OrangeGlow', getRandomInt(0, 50)/100, 1, 'sineInOut')
		
		if curBeat == 391 or curBeat == 406 or curBeat == 422 then
			flash('Red', 0.4, 0.35)
		end
		
		if curBeat % 4 == 0 and (curBeat >= 396 and curBeat <= 552) then
			flash('Red', 0.4, 0.35)
		end
	end
end

function onTweenCompleted(tag)
	for p=0, Particle do
		if tag == 'particleY'..p then
			removeLuaSprite('particle'..p)
		end
	end
	for f=0, Breath do
		if tag == 'Fire'..f then
			removeLuaSprite('Fire'..f)
		end
	end
end

function onUpdate(elapsed)
	if songName == 'Boiling Point' then
		if curStep % 4 == 0 and curStep >= 1952 and curStep <= 2239 and not lowQuality then
			ParticleX = getRandomInt(-1000, 2000)
			makeAnimatedLuaSprite('particle'..Particle, 'Polus/Maroon/InVolcano/ember', ParticleX, 1400)
			addAnimationByPrefix('particle'..Particle, 'Ember', 'ember', 24, true)
			rngScroll = getRandomInt(5,10)/10;
			setScrollFactor('particle'..Particle, rngScroll, rngScroll)
			rngScale = getRandomInt(5,20)/10;
			scaleObject('particle'..Particle, rngScale, rngScale)
			setProperty('particle'..Particle..'.alpha', getRandomInt(60, 100)/100)
			setBlendMode('particle'..Particle, 'ADD')
			if getRandomInt(1,2) == 1 then addLuaSprite('particle'..Particle, true) else addLuaSprite('particle'..Particle) setObjectOrder('particle'..Particle, getObjectOrder('floor')-1) end
			TweenTime = getRandomInt(10,60)/10;
			doTweenY('particleY'..Particle, 'particle'..Particle, getProperty('particle'..Particle..'.y')-1700, TweenTime, 'linear')
			doTweenX('particleX'..Particle, 'particle'..Particle, ParticleX+getRandomInt(-600, 600), TweenTime, 'linear')
			SmallTime = getRandomInt(-30, 7)/10;
			doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			Particle=Particle+1; if Particle >= 500 then Particle = 0 end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if del > 0 then
		del = del - 1;
	end
	if del2 > 0 then
		del2 = del2 - 1;
	end
    if followchars then
        if mustHitSection == false then
			setProperty('defaultCamZoom', CZoom)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' or getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
			end
        else
			setProperty('defaultCamZoom', CZoom1)
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

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if cam == 0 then
		cam = 1;
		midCam(false);
		doTweenZoom('CamGameCoolZoomy', 'camGame', 0.65, 0.65, 'sineInOut')
	end
	
	if songName == "Boiling Point" then
		triggerEvent('Add Camera Zoom', 0.02, 0.02)
		cameraShake('camGame', 0.009, 0.1); --Intensity, Duration
		cameraShake('hud', 0.002, 0.1)
		if HPDrain and not isSustainNote then
			setProperty('health', getProperty('health')-0.02*getProperty('health'))
		elseif HPDrain and isSustainNote then
			setProperty('health', getProperty('health')-0.008*getProperty('health'))
		end
	end
	
	if dadName == 'Maroon_Parasite' and not lowQuality and framerate >= 220 then
		if direction == 0 then
			MaxBreath = 40;
			FireX = -740;	StartRadiusX = 0;
			FireY = 1000;	StartRadiusY = 0;
			DirectionX = 5000;
			DirectionY = -3000;
			SpreadX = 2000;
			SpreadY = 0;
			TweenTime = 0.6;
			Angle = 1; --Can not be 0;
		elseif direction == 1 then
			MaxBreath = 10;
			FireX = -430;	StartRadiusX = 70;
			FireY = 1370;	StartRadiusY = 0;
			DirectionX = 0;
			DirectionY = -2000;
			SpreadX = 500;
			SpreadY = 800;
			TweenTime = 0.2;
			Angle = 1; --Can not be 0;
		elseif direction == 2 then
			MaxBreath = 30;
			FireX = -410;	StartRadiusX = 70;
			FireY = 850;	StartRadiusY = 0;
			DirectionX = 0;
			DirectionY = -2000;
			SpreadX = 500;
			SpreadY = 800;
			TweenTime = 0;
			Angle = 1; --Can not be 0;
		elseif direction == 3 then
			MaxBreath = 50;
			FireX = 90;	StartRadiusX = 0;
			FireY = 1130;	StartRadiusY = 50;
			DirectionX = 2000;
			DirectionY = 0;
			SpreadX = 500;
			SpreadY = 300;
			TweenTime = 0.1;
			Angle = 1; --Can not be 0;
			setProperty('health', getProperty('health')-0.02*getProperty('health')) --Double the Damage when Maroons sings Right
		end
		for i=0, getRandomInt(5, MaxBreath) do
			makeAnimatedLuaSprite('Fire'..Breath, 'Polus/Maroon/InVolcano/ember', FireX+getRandomInt(-1*StartRadiusX, StartRadiusX), FireY+getRandomInt(-1*StartRadiusY, StartRadiusY))
			addAnimationByPrefix('Fire'..Breath, 'Ember', 'ember', 24, true)
			
			rngScale = getRandomInt(5,12)/10;
			scaleObject('Fire'..Breath, rngScale, rngScale)
			
			setProperty('Fire'..Breath..'.alpha', getRandomInt(70, 100)/100)
			setBlendMode('Fire'..Breath, 'ADD')
			
			addLuaSprite('Fire'..Breath, true)
			
			doTweenX('FireX'..Breath, 'Fire'..Breath, getProperty('Fire'..Breath..'.x')+DirectionX+getRandomInt(-1*SpreadX, SpreadX), (TweenTime+getRandomInt(10,30)/10)/Angle, 'linear')
			doTweenY('FireY'..Breath, 'Fire'..Breath, getProperty('Fire'..Breath..'.y')+DirectionY+getRandomInt(-1*SpreadY, SpreadY), TweenTime+getRandomInt(10,30)/10, 'linear')
			
			SmallTime = getRandomInt(-30, 7)/10;
			doTweenX('FireYScale'..Breath, 'Fire'..Breath..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			doTweenY('FireXScale'..Breath, 'Fire'..Breath..'.scale', 0.01, TweenTime-SmallTime, 'smootherStepInOut')
			
			Breath=Breath+1; if Breath >= 250 then Breath = 0 end
		end
	end
end