.PHONY:
	sync-to-config-dir
	sync-to-current-dir
	prepare-push-remote
	push-remote
	pull-remote

# 設定ファイルが保存されているディレクトリ
CONFIG_DIR := ~/.config/zed

# ファイルパス
SETTINGS_FILE := settings.json
KEYMAP_FILE := keymap.json

# ローカルディレクトリから設定ディレクトリへファイルを同期するタスク
sync-to-config-dir:
	@echo "Syncing files to config directory..."
	cp $(SETTINGS_FILE) $(CONFIG_DIR)/
	cp $(KEYMAP_FILE) $(CONFIG_DIR)/

# 設定ディレクトリからローカルディレクトリへファイルを同期するタスク
sync-to-current-dir:
	@echo "Syncing files to current directory..."
	cp $(CONFIG_DIR)/$(SETTINGS_FILE) .
	cp $(CONFIG_DIR)/$(KEYMAP_FILE) .

# リモートリポジトリにプッシュするためにファイルを準備するタスク
prepare-push-remote:
	@echo "Preparing files for remote push..."
	make sync-to-current-dir

# ローカルの変更をリモートリポジトリにプッシュするタスク
push-remote:
	@echo "Pushing changes to remote repository..."
	git add *
	git commit -m "Update settings"
	git push origin

pull-remote:
	@echo "Pulling changes from remote repository..."
	git pull origin master
	make sync-to-current-dir
