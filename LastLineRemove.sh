
yourfilenames=`ls -R ./*.html`
#yourfilenames=`find . -name *.html`
for eachfile in $yourfilenames 
do
    echo $eachfile
    if grep -Fq "https://nicepage.com/website-templates" "$eachfile"
    then 
    echo here
    head -n -13 $eachfile > temp.html ; mv temp.html $eachfile
    echo '</body></html>'>>$eachfile
    fi
done

$SHELL
#https://nicepage.com/website-templates