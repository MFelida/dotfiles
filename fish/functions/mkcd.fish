function mkcd -d "Create director and set as current directory"
	if test ! -d $argv
		mkdir $argv
	end
	cd $argv
end
