def add_gitignore_txt
<<-TXT

# Ignore .env file containing credentials.
.env*

# Ignore Mac and Linux file system files
*.swp
.DS_Store
.bundle
log/*.log
tmp/**/*
tmp/*
!log/.keep
!tmp/.keep
public/assets
public/packs
public/packs-test
node_modules
yarn-error.log
.byebug_history
TXT
end