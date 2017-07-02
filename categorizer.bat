@ECHO OFF
SETLOCAL enabledelayedexpansion

ECHO This program categorizes(by moving) files into relevant subdirectories by their extensions.
ECHO Default subfolders are: documents, programs, media\images, media\music, media\videos, compressed and others.

SET /P currpath="Enter path(or relative path) of the folder which you want to categorize (just press enter if this program is in folder): "
IF "!currpath!"=="" (SET currpath=.)

SET /P naming="Program uses default folder naming, do you want to name yourself (y/n)? "

CALL :DATA
CALL :EXT

IF %naming%==y (CALL :NAMING)
IF %naming%==n (CALL :FOLDING)

ECHO Categorization completed.
ECHO You can see your subdirectories in the "!currpath!" folder.
EXIT /B

:NAMING
	SET /P documents="Enter name for documents folder: "
	SET /P programs="Enter name for programs folder: "
	SET /P media="Enter name for media folder: "
	SET /P compressed="Enter name for compressed folder: "
	SET /P others="Enter name for others folder: "
	GOTO :FOLDING

:FOLDING
	IF EXIST "!currpath!\!documents!" (
	ECHO Verified: folder "!documents!" exists.
	) ELSE (
	ECHO !currpath!
	MKDIR "!currpath!\!documents!"
	ECHO Folder "!documents!" created.
	)
	
	IF EXIST !currpath!\!programs! (
	ECHO Verified: folder "!programs!" exists.
	) ELSE (
	MKDIR !currpath!\!programs!
	ECHO Folder "!programs!" created.
	)
	
	IF EXIST !currpath!\!media! (
	ECHO Verified: folder "!media!" exists.
	) ELSE (
	MKDIR !currpath!\!media!
	ECHO Folder "!media!" created.
	)
	
	IF EXIST !currpath!\!media!\images (
	ECHO Verified: folder "!media!\images" exists.
	) ELSE (
	MKDIR !currpath!\!media!\images
	ECHO Folder "!media!\images" created.
	)
	
	IF EXIST !currpath!\!media!\music (
	ECHO Verified: folder "!media!\music" exists.
	) ELSE (
	MKDIR !currpath!\!media!\music
	ECHO Folder "!media!\music" created.
	)	
	
	IF EXIST !currpath!\!media!\videos (
	ECHO Verified: folder "!media!\videos" exists.
	) ELSE (
	MKDIR !currpath!\!media!\videos
	ECHO Folder "!media!\videos" created.
	)
	
		IF EXIST !currpath!\!compressed! (
	ECHO Verified: folder "!compressed!" exists.
	) ELSE (
	MKDIR !currpath!\!compressed!
	ECHO Folder "!compressed!" created.
	)
	
	IF EXIST !currpath!\!others! (
	ECHO Verified: folder "!others!" exists.
	) ELSE (
	MKDIR !currpath!\!others!
	ECHO Folder "!others!" created.
	)
	
	GOTO :MOVE

:MOVE
	ECHO Folders are okay. Now moving operation started. This may take a while...
	robocopy !currpath! !currpath!\!documents! !documentsEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!programs! !programsEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!media!\images !imagesEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!media!\music !musicEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!media!\videos !videosEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!compressed! !compressedEXT! /mov /XC /XN /XO  > nul 2> nul
	robocopy !currpath! !currpath!\!others! *.* /mov /XF /XC /XN /XO %~nx0 !compressedEXT! !videosEXT! !musicEXT! !imagesEXT! !programsEXT! !documentsEXT! > nul 2> nul
	GOTO :EOF
	
:EXT
	SET documentsEXT=*.doc *.docx *.pdf *.ppt *.pptx *.xls *.xlsx 
	SET programsEXT=*.exe 
	SET imagesEXT=*.jpeg *.jpg *.gif *.png 
	SET musicEXT=*.mp3 *.ogg *.wav 
	SET videosEXT=*.mp4 *.avi *.3gp *.mkv *.wmv *.flv *.mov 
	SET compressedEXT=*.tar *.rar *.zip
	GOTO :EOF

:DATA
	SET documents=documents
	SET programs=programs
	SET media=media
	SET compressed=compressed
	SET others=others
	GOTO :EOF
	
ENDLOCAL