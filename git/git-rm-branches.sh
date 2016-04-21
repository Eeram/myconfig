git branch --merged | grep -v master | grep -v release | grep -v Develop > branchToDelete

cat branchToDelete;

read -p "Do you want to delete those branches (Y/N) " -n 1 -r

echo    # (optional) move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cat branchToDelete | xargs -n 1 git branch -d
fi
        
rm branchToDelete
