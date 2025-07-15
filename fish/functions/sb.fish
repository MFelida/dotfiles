function sb -d "Open Second_Brain dir in new tmux window"
	command tmux new-window -c "$SB_DIR" -n "Second Brain"
end
