local xx = 600;
local yy = 350;
local xx2 = 700;
local yy2 = 420; 
local ofs = 35;
local followchars = true;
local CZoom = 0.65;
local CZoom1 = 0.7;

local startCam = false;

local FlashCol = '0xFFFFFF';
local FlashingOffBonusTimer = 0;

function onCreate()
	addCharacterToList('BF_90s', 'boyfriend')
	addCharacterToList('BF_90s_sus', 'boyfriend')
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_90s')

    makeLuaSprite('BG', 'The90s/bg', -640, -340)
    addLuaSprite('BG')   
	
    makeLuaSprite('BG_Front', 'The90s/front bg', getProperty('BG.x'), getProperty('BG.y'))
    addLuaSprite('BG_Front')
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeLuaSprite('BlackScreen', '', 0, 0)
	makeGraphic('BlackScreen', 1300, 750, '000000')
	setObjectCamera('BlackScreen','hud')
	addLuaSprite('BlackScreen', false)
	
	makeLuaSprite('BarUp', '', 0, -130)	--Default y = 0
	makeGraphic('BarUp', 1280, 125, '000000')
	setObjectCamera('BarUp', 'camHUD')
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 125, '000000')
	setObjectCamera('BarDown', 'camHUD')
	addLuaSprite('BarDown')
	
	makeAnimatedLuaSprite('Static', 'hudStuffs/daSTAT', 0, 0)
	addAnimationByPrefix('Static', 'static', '', 24, true)
	setObjectCamera('Static', 'other')
	scaleObject('Static', 3.3, 2.5)
	setProperty('Static.alpha', 0.05)
	setBlendMode('Static', 'ADD')
	addLuaSprite('Static', true)
	
	makeAnimatedLuaSprite('Grain', 'hudStuffs/grain', 0, 0)
	addAnimationByPrefix('Grain', 'Grain', '', 24, true)
	setObjectCamera('Grain', 'other')
	scaleObject('Grain', 1.25, 1.25)
	addLuaSprite('Grain', true)
	
	cinematicView(true, 0.25, 'long')
end

function onCreatePost()
	if not flashingLights then
		FlashCol = '0x000000';
		FlashingOffBonusTimer = 0.25;
	end
	setProperty('scoreTxt.alpha', 0)
	setProperty('healthBar.alpha', 0)
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	
	midCam(true);
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeLuaSprite('OppShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('dad.x')-30, getProperty('dad.y')+getProperty('dad.height'))
	setProperty('OppShadow.alpha', 0.35)
	setProperty('OppShadow.angle', -3)
	scaleObject('OppShadow', 4.25, 1.3)
	addLuaSprite('OppShadow')
	
	makeLuaSprite('BFShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('boyfriend.x')+30, getProperty('boyfriend.y')+getProperty('boyfriend.height')-65)
	setProperty('BFShadow.alpha', 0.45)
	scaleObject('BFShadow', 4.15, 1.25)
	addLuaSprite('BFShadow')
	
	if getRandomBool(10) then
		triggerEvent('Change Character', '0', 'BF_90s_sus')
		setProperty('BFShadow.alpha', 0.3)
		setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_90s_sus')
	end
	if boyfriendName == 'BF_90s_sus' then
		makeAnimatedLuaSprite('susGf', 'characters/The90s/gf-amogus', 1200, 350)
		addAnimationByPrefix('susGf', 'idle', 'amongus-gf', bpm/6, true)
		addLuaSprite('susGf')
		
		makeLuaSprite('GFShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('susGf.x'), getProperty('susGf.y')+getProperty('susGf.height')-90)		
		setProperty('GFShadow.alpha', 0.4)
		scaleObject('GFShadow', 4, 1.15)
		setObjectOrder('GFShadow', getObjectOrder('susGf')-1)
		addLuaSprite('GFShadow')	
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	setProperty('scoreTxt.color', getColorFromHex('474747'))
end

function cinematicView(bool, transitionTimer, range)
	if bool then
		if range == 'short' then
			doTweenY('BarUpY', 'BarUp', -20, transitionTimer, 'sineOut')
			doTweenY('BarDownY', 'BarDown', 640, transitionTimer, 'sineOut')
		elseif range == 'long' then
			doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
			doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
		else 
			doTweenY('BarUpY', 'BarUp', -20, transitionTimer, 'sineOut')
			doTweenY('BarDownY', 'BarDown', 640, transitionTimer, 'sineOut')
		end
	elseif not bool then
		doTweenY('BarUpY', 'BarUp', -130, transitionTimer, 'sineIn')
		doTweenY('BarDownY', 'BarDown', 735, transitionTimer, 'sineIn')
	end
end

function midCam(bool)
	if bool then
		xx = 635;	xx2 = 635;	yy = 350;	yy2 = 350;	CZoom = 0.6;	CZoom1 = 0.6;
	elseif not bool then
		xx = 550; 	xx2 = 700;	yy = 380; 	yy2 = 450;	CZoom = 0.6;	CZoom1 = 0.7;
	end
end

function flashDark()
	cameraFlash('camOther', '0x000000', 1, true)
end

local Alpha = 1;

function onStepHit()
	if mustHitSection and Alpha == 1 and not startCam and getProperty('BlackScreen.alpha') == 0 and not middlescroll then
		Alpha = 0;
		for i=0, 3 do
			noteTweenAlpha('StrumFade'..i, i, 0.4, 0.3)
		end
	elseif not mustHitSection and Alpha == 0 and not startCam and getProperty('BlackScreen.alpha') == 0 and not middlescroll then
		Alpha = 1;
		for i=0, 3 do
			noteTweenAlpha('StrumFade'..i, i, 1, 0.3)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'NeedleMan' then
		if curStep == 63 then
			CZoom = 0.8;
			CZoom1 = CZoom;
			ofs = 15;
		end
		if curStep >= 64 and curStep < 128 then
			CZoom = CZoom - 0.005;
			CZoom1 = CZoom;
		end
	
		if curStep >= 48 and getPropertyFromGroup('strumLineNotes', 4, 'alpha') == 0  then
			for i=0, 3 do
				if not middlescroll then
					noteTweenAlpha('NoteAlpha'..i, i, 1, 2)
					noteTweenAlpha('NoteAlpha'..i+4, i+4, 1, 2)
				elseif middlescroll then
					noteTweenAlpha('NoteAlpha'..i, i, 0.5, 2)
					noteTweenAlpha('NoteAlpha'..i+4, i+4, 1, 2)	
				end
			end
		end
		if curStep == 64 then
			doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0.4, 6.4)
		end
		if curStep >= 128 and getProperty('BlackScreen.alpha') ~= 0 then
			cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
			cancelTween('BlackScreenAlpha')
			setProperty('BlackScreen.alpha', 0)
			setProperty('scoreTxt.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			
			ofs = 35;
			midCam(false);
			cinematicView(false, 1, '0')
		end
		
		if curStep == 256 then
			cinematicView(true, 0.5, 'long')
		end
		if curStep == 512 then
			cinematicView(false, 1, '0')
		end
		if curStep == 896 then
			cinematicView(true, 0.5, 'long')
			flashDark();
		end
		if curStep == 1024 then
			cinematicView(false, 1, '0')
			flashDark();
		end
		if curStep == 1408 then
			flashDark();
		end
		if curStep == 1664 then
			cinematicView(true, 0.5, 'short')
		end
		if curStep == 1792 then
			cinematicView(false, 1, '0')
			flashDark();
		end
		if curStep == 2048 then
			flashDark();
		end
		
		if curStep == 2177 then
			setProperty('camGame.alpha', 0)
			setProperty('camHUD.alpha', 0)
		end
		
		if curStep == 576 then
			midCam(true);
		end
		if curStep == 640 then
			midCam(false);
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Unknown Danger' then		
		if curStep == 16 then
			doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0.5, 5)
			doTweenZoom('camGameZoom', 'camGame', 0.85, 7, 'sineInOut')
		end
		if curStep >= 64 and getProperty('BlackScreen.alpha') ~= 0 then
			cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
			cancelTween('BlackScreenAlpha')
			cancelTween('camGameZoom')
			setProperty('BlackScreen.alpha', 0)
			setProperty('scoreTxt.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			
			for i=0, 3 do
				if not middlescroll then
					setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
					setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 1)
				elseif middlescroll then
					setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.5)
					setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 1)
				end
			end
			
			midCam(false);
			cinematicView(true, 0.5, 'short')
		end
		
		if curStep == 188 then
			doTweenZoom('camGameZoomIn', 'camGame', 0.8, 0.365, 'sineIn')
		end
		
		if curStep == 192 or curStep == 448 then
			flashDark();
		end
		
		if curStep == 704 then
			flashDark();
			cinematicView(true, 1, 'short')
		end
		if curStep == 960 then
			cinematicView(true, 0.6, 'long')
		end
		if curStep == 1216 then
			cinematicView(true, 0.5, 'short')
		end
		if curStep == 1472 then
			flashDark();
			cinematicView(false, 0.5, '')
		end
		if curStep == 1584 then
			doTweenZoom('camGameZoomIn', 'camGame', 0.93, 1.43, 'sineIn')
		end
		if curStep == 1600 then
			flashDark();
			cinematicView(true, 0.5, 'short')
		end
		if curStep == 1716 or curStep == 1720 then
			CZoom1 = CZoom1 + 0.06
		end
		if curStep == 1728 then
			flashDark();
			cinematicView(true, 0.5, 'long')
		end
		
		if curStep == 640 or curStep == 1216 or curStep == 1472 or curStep == 1856 then
			midCam(true);
		end
		if curStep == 688 or curStep == 1344 or curStep == 1584 then
			midCam(false);
		end
		
		if curStep == 1856 then
			CZoom = 0.8;
			CZoom1 = CZoom;
			ofs = 20;
			flashDark();
		end
		if curStep > 1856 and curStep <= 1984 then
			CZoom = CZoom - 0.0015;
			CZoom1 = CZoom;
		end
		
		if curStep == 1984 then
			for i=0, 7 do
				noteTweenAlpha('NoteAlpha'..i, i, 0, 5)
			end
		end
	end
end

function onBeatHit()
	if curBeat % 4 == 0 then
		objectPlayAnimation('theamonguslys', 'walk', true)
	end
end

function onUpdate(elapsed)
	if curStep <= 5 then
		for i=0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
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

local NotesHold = {0, 0, 0, 0}

function onTimerCompleted(tag, loops, loopsLeft)
	for i=0, 3 do
		if tag == 'ResetNoteHoldValue'..i then
			NotesHold[i+1] = 0;
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if startCam then
		startCam = false;
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Unknown Danger' then
		if direction == 0 then
			cancelTimer('ResetNoteHoldValue'..direction)
			NotesHold[1] = 1;
			runTimer('ResetNoteHoldValue'..direction, 0.1)
		end
		
		if direction == 1 then
			cancelTimer('ResetNoteHoldValue'..direction)
			NotesHold[2] = 1;
			runTimer('ResetNoteHoldValue'..direction, 0.1)
		end
		
		if direction == 2 then
			cancelTimer('ResetNoteHoldValue'..direction)
			NotesHold[3] = 1;
			runTimer('ResetNoteHoldValue'..direction, 0.1)
		end
	
		if direction == 3 then
			cancelTimer('ResetNoteHoldValue'..direction)
			NotesHold[4] = 1;
			runTimer('ResetNoteHoldValue'..direction, 0.1)
		end
		
		if NotesHold[1] + NotesHold[2] + NotesHold[3] + NotesHold[4] >= 2 then
			setProperty('health', getProperty('health')-0.025*getProperty('health'))
		end
		
		-- debugPrint(NotesHold[1]..' '..NotesHold[2]..' '..NotesHold[3]..' '..NotesHold[4])
	end
end