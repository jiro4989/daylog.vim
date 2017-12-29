@echo off

python upd_last_change.py
git add . 
git commit
git push origin master
