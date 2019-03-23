on run (argv)
	tell application "iTunes"
		set filename to POSIX file (argv's item 1 as string) as alias
		try
			set trackRef to (add filename)
			refresh trackRef
		end try
	end tell
end run
