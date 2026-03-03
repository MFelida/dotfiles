function ta -d "Attaches to tmux session given as argument, creates the session if it doesn't exist." -a name
	command tmux attach -t $name
	if test $status = 1
		command tmux new-session -s $name
	end
end
