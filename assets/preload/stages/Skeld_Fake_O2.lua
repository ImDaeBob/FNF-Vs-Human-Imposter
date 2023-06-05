local xx = 580;
local yy = 370;
local xx2 = 880;
local yy2 = 440;
local ofs = 20;
local CZoom = 0.65;
local CZoom1 = 0.75;
local cam = 0; --Just for the Fancy Mid Cam at the start of the Song, nothing else :v
local followchars = true;

local NoteTimer = 0;

function onCreate()
	addCharacterToList('BF_Dead', 'boyfriend')
	addCharacterToList('BF_Fake_O2', 'boyfriend')
	addCharacterToList('bf', 'boyfriend')
	addCharacterToList('JermagusXasix', 'dad')
	addCharacterToList('JermagusYasix', 'dad')
	addCharacterToList('JermagusZasix', 'dad')
	
	NoteTimer = getRandomFloat(0.1, 0.4)

	makeLuaSprite('O2_Room', 'Skeld/O2/O2Background', -670, -270)
	addLuaSprite('O2_Room')
	
	makeLuaSprite('Switch', 'Skeld/O2/switch', getProperty('O2_Room.x')+120, getProperty('O2_Room.y')+500)
	scaleObject('Switch', 1.25, 1.25)
	addLuaSprite('Switch')
	
	makeAnimatedLuaSprite('Fans', 'Skeld/O2/fansss', getProperty('O2_Room.x')+430, getProperty('O2_Room.y')+300)
	addAnimationByPrefix('Fans', 'spin', 'fansss', 12, true)
	addLuaSprite('Fans')
	
	makeLuaSprite('O2_Room_Diagonal', 'Skeld/FakeO2/bg', getProperty('O2_Room.x')-40, getProperty('O2_Room.y'))
	scaleObject('O2_Room_Diagonal', 0.9, 0.9)
	setProperty('O2_Room_Diagonal.alpha', 0)
	addLuaSprite('O2_Room_Diagonal')
	
	makeAnimatedLuaSprite('Jump', 'Skeld/FakeO2/jerma_mungus_jump_scare', 0, 0)
	addAnimationByPrefix('Jump', 'Jump', 'JERMA', 24, false)
	setObjectCamera('Jump', 'other')
	scaleObject('Jump', 0.95, 0.85)
	screenCenter('Jump')
	setProperty('Jump.alpha', 0.001)
	addLuaSprite('Jump')
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeLuaSprite('SuperVignette', 'hudStuffs/vignetteButDarker', 0, 0)
	setObjectCamera('SuperVignette', 'camOther')
	scaleObject('SuperVignette', 1, 1)
	-- setProperty('SuperVignette.alpha', 0.8)
	addLuaSprite('SuperVignette', true)
	
	makeLuaSprite('BlackScreen', '', 0, 0)
	makeGraphic('BlackScreen', 1300, 750, '000000')
	setObjectCamera('BlackScreen', 'hud')
	setProperty('BlackScreen.alpha', 0.001)
	addLuaSprite('BlackScreen')
	
	makeLuaSprite('BarUp', '', 0, -110)	--Default y = 0
	makeGraphic('BarUp', 1280, 105, '000000')
	setObjectCamera('BarUp', 'camHUD')
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 105, '000000')
	setObjectCamera('BarDown', 'camHUD')
	addLuaSprite('BarDown')
	
	makeAnimatedLuaSprite('Static', 'hudStuffs/daSTAT', 0, 0)
	addAnimationByPrefix('Static', 'static', '', 24, true)
	setObjectCamera('Static', 'other')
	scaleObject('Static', 3.3, 2.5)
	setProperty('Static.alpha', 0.035)
	setBlendMode('Static', 'ADD')
	addLuaSprite('Static', true)
	
	setProperty('losingValue', 35)
end

function onCreatePost()
	makeLuaSprite('OppShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('dad.x')+290, getProperty('dad.y')+getProperty('dad.height')+15)
	setProperty('OppShadow.alpha', 0.45)
	setProperty('OppShadow.angle', -3)
	scaleObject('OppShadow', 5, 1.4)
	addLuaSprite('OppShadow')
	
	makeLuaSprite('OppLeftHandShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('OppShadow.x')-250, getProperty('OppShadow.y')+15)
	setProperty('OppLeftHandShadow.alpha', 0.28)
	setProperty('OppLeftHandShadow.angle', -10)
	scaleObject('OppLeftHandShadow', 2.9, 1.2)
	addLuaSprite('OppLeftHandShadow')
	
	makeLuaSprite('OppRightHandShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('OppShadow.x')+410, getProperty('OppShadow.y')+10)
	setProperty('OppRightHandShadow.alpha', 0.2)
	scaleObject('OppRightHandShadow', 3, 1.3)
	addLuaSprite('OppRightHandShadow')
	
	makeLuaSprite('BFShadow', 'MiraHQ/Pink/Happy/BlackParticle', getProperty('boyfriend.x')+5, getProperty('boyfriend.y')+getProperty('boyfriend.height')-100)
	setProperty('BFShadow.alpha', 0.45)
	scaleObject('BFShadow', 4.15, 1.25)
	addLuaSprite('BFShadow')
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	setProperty('scoreTxt.angle', -90)
	setProperty('scoreTxt.x', -600)
	setProperty('scoreTxt.y', 350)
	setProperty('scoreTxt.color', getColorFromHex('ACA800'))
	cinematicView(true, 0.25)
end

function cinematicView(bool, transitionTimer)
	if bool then
		doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
		doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
	elseif not bool then
		doTweenY('BarUpY', 'BarUp', -110, transitionTimer, 'sineIn')
		doTweenY('BarDownY', 'BarDown', 735, transitionTimer, 'sineIn')
	end
end

function jumpscare()
	soundFadeOut('', 0.5, 0.5)
	playSound('Jumpscare', 1, 'Boo')
	cameraFlash('camOther', '0xFFFFFF', 0.25, true)
	setProperty('BlackScreen.alpha', 1)
	setProperty('Static.alpha', 0.35)
	doTweenAlpha('StaticAlpha', 'Static', 0.035, 1.25)
	setProperty('Jump.alpha', 1)
	objectPlayAnimation('Jump', 'Jump', true)
	
	setProperty('scoreTxt.color', getColorFromHex('FF0000'))
	doTweenColor('scoreTxtColor', 'scoreTxt', 'ACA800', 3)
	triggerEvent('Add Camera Zoom', 0, 0.05)
	
	if curStep <= 1600 then
		runTimer('JumpAlphaGone', 0.82)
	end
end

function stageSet(stage)
	cameraFlash('camHUD', '0x000000', 0.7, true)
	for i=0, 3 do
		if not middlescroll then
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
		end
		setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 1)
	end
	setProperty('winningAltAnim', false)
	
	if stage == 'x' then
		setProperty('O2_Room.alpha', 1)
		setProperty('Switch.alpha', 1)
		setProperty('Fans.alpha', 1)
		setProperty('O2_Room_Diagonal.alpha', 0)
		
		triggerEvent('Change Character', '0', 'bf')
		triggerEvent('Change Character', '1', 'JermagusXasix')
		
		setProperty('dad.x', -300)
		setProperty('dad.y', 50)
		setProperty('boyfriend.x', 1100)
		setProperty('boyfriend.y', 350)
		setProperty('boyfriend.alpha', 1)
		
		setProperty('scoreTxt.color', getColorFromHex('ACA800'))
		
		xx = 580;
		yy = 370;
		xx2 = 880;
		yy2 = 440;
		ofs = 20;
		CZoom = 0.65;
		CZoom1 = 0.75;
	elseif stage == 'z' then
		setProperty('O2_Room.alpha', 0)
		setProperty('Switch.alpha', 0)
		setProperty('Fans.alpha', 0)
		setProperty('O2_Room_Diagonal.alpha', 1)
		
		triggerEvent('Change Character', '0', 'BF_Fake_O2')
		triggerEvent('Change Character', '1', 'JermagusZasix')

		setProperty('dad.x', getProperty('dad.x')-80)
		setProperty('dad.y', getProperty('dad.y')+30)
		setProperty('boyfriend.x', 1250)
		setProperty('boyfriend.y', 530)
		setProperty('boyfriend.alpha', 1)
		
		setProperty('scoreTxt.color', getColorFromHex('FFFFFF'))

		xx = 470;
        yy = 400;
        xx2 = 540;
        yy2 = 410;
		ofs = 20;
		CZoom = 0.6;
		CZoom1 = 0.55;
	elseif stage == 'y' then
		setProperty('O2_Room.alpha', 0)
		setProperty('Switch.alpha', 0)
		setProperty('Fans.alpha', 0)
		setProperty('O2_Room_Diagonal.alpha', 0)
		
		triggerEvent('Change Character', '1', 'JermagusYasix')
		
		setProperty('boyfriend.alpha', 0)
		setProperty('scoreTxt.color', getColorFromHex('ACA800'))
		
		for i=0, 3 do
			if not middlescroll then
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.75)
			end
			setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 0.75)
		end
		
		xx = 230;
		yy = 520;
		xx2 = 230;
		yy2 = 520;
		ofs = 30;
		CZoom = 0.5;
		CZoom1 = 0.45;
	end
	
	if mustHitSection then
		setProperty('camFollowPos.x', xx)
		setProperty('camFollowPos.y', yy)
		setProperty('camFollow.x', xx)
		setProperty('camFollow.y', yy)
		doTweenZoom('camGameIntantZoom', 'camGame', CZoom, 0.001)
	elseif not mustHitSection then
		setProperty('camFollowPos.x', xx2)
		setProperty('camFollowPos.y', yy2)
		setProperty('camFollow.x', xx2)
		setProperty('camFollow.y', yy2)
		doTweenZoom('camGameIntantZoom', 'camGame', CZoom1, 0.001)
	end
end

function onBeatHit()
	if curBeat % 4 == 0 then
		doTweenAlpha('VignetteAlpha', 'SuperVignette', getRandomFloat(0.5, 1), getRandomFloat(1, 3))
	end
	
	if curBeat % getRandomInt(4, 16) == 0 then
		setProperty('Static.alpha', getRandomFloat(0.2, 0.3))
		doTweenAlpha('StaticAlpha', 'Static', 0.035, getRandomFloat(0.5, 2))
	end
end

function onStepHit()
	if curStep == 256 then
		stageSet('z');
	end
	if curStep == 768 then
		jumpscare();
		stageSet('x');
		setProperty('beatboxingTime', true)
	end
	if curStep == 896 then
		setProperty('beatboxingTime', false)
	end
	if curStep == 960 then
		stageSet('y')
	end
	if curStep == 1280 then
		stageSet('z')
	end
	if curStep == 1408 then
		stageSet('y')
	end
	if curStep == 1536 then
		stageSet('x')
	end
	if curStep == 1600 then
		jumpscare();
		setProperty('camGame.alpha', 0)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if getProperty('health') <= getProperty('losingValue')/50 and getProperty('health') >= 0.05 then
		setProperty('health', getProperty('health')-0.0145)
	end
end

function onUpdatePost(elapsed)
	if getProperty('health') == 2 and getProperty('winningAltAnim') == false and getProperty('boyfriend.animation.curAnim.name') == 'idle' and boyfriendName == 'bf' then
		setProperty('winningAltAnim', true)
	elseif getProperty('health') < 2 and getProperty('winningAltAnim') == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' and boyfriendName == 'bf' then
		setProperty('winningAltAnim', false)
	end
	
	if getProperty('health') >= getProperty('winningValue')/50 then
		setProperty('iconP2.angle', getRandomFloat(-5,5))
	elseif  getProperty('health') <= getProperty('losingValue')/50 then
		setProperty('iconP2.angle', getRandomFloat(-10, 10))
	elseif getProperty('health') < getProperty('winningValue')/50 and getProperty('health') > getProperty('losingValue') and getProperty('iconP2') ~= 0 then
		setProperty('iconP2.angle', 0)
	end
	
	if dadName == 'JermagusXasix' then
        if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0.2, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0.17, 0.15)
        end
        if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0.28, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0.2, 0.15)
        end
        if getProperty('dad.animation.curAnim.name') == 'singUP' then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0, 0.15)
        end
        if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0.1, 0.15)
		end
		if getProperty('dad.animation.curAnim.name') == 'idle' then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0.28, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0.2, 0.15)
		end
	elseif dadName ~= 'JermagusXasix' and (getProperty('OppLeftHandShadow') ~= 0 or getProperty('OppRightHandShadow') ~= 0) then
		   doTweenAlpha('OppLeftHandShadowAlpha', 'OppLeftHandShadow', 0, 0.15)
		   doTweenAlpha('OppRightHandShadowAlpha', 'OppRightHandShadow', 0, 0.15)
	end
end

function onUpdate(elapsed)
	if dadName == 'JermagusXasix' or dadName == 'JermagusZasix' then --Trippy Notes!
		currentBeat = (getSongPosition() / 1000) * (bpm / 60);
		for i=0, 3 do		
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 1 * 16 * math.sin(currentBeat*NoteTimer + i)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] + -1 * 16 * math.sin(currentBeat*NoteTimer + (i+4))) 

			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 1 * (16/2) * math.sin(currentBeat*NoteTimer + i * 2)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 1 * (16/2) * math.sin(currentBeat*NoteTimer + (i+4) * 2))
		end
	elseif dadName == 'JermagusYasix' then
		currentBeat = (getSongPosition() / 1000) * (bpm / 60);
		for i=0,3 do
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] + -1 * 16 * math.sin(currentBeat*NoteTimer + (i+4))) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + -1 * 16 * math.sin(currentBeat*NoteTimer + (i+4))) 
			
			
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 1 * 16 * math.sin(currentBeat*NoteTimer + i)) 
			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + -1 * 16 * math.sin(currentBeat*NoteTimer + i)) 
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
    if followchars then
        if not mustHitSection then
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
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-beatbox' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-beatbox' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' or getProperty('boyfriend.animation.curAnim.name') == 'idle-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'JumpAlphaGone' then
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 0.5)
		soundFadeIn('', 1, 0.5, 1)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
		cameraShake('hud', 0.0015, 0.1)
	end
	if getRandomBool(35) and getProperty('health') > getProperty('losingValue')/50 and not isSustainNote then
		setProperty('health', getProperty('health')-0.03*getProperty('health'))
	end
end