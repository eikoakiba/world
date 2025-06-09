#!/bin/bash

PROJECT_NAME=$1
DIST=./dist/$PROJECT_NAME
files=()

function file_must_exists() {
  if [ ! -f $1 ]; then
    echo "Must have a $1 file!"
    rm -rf $DIST # if something goes wrong just reset everything
    exit 1
  fi
}

# function make_page {
# }

function make_loader() {
  for i in ${files[@]}; do
    # TODO: If it is file render it like that, and it is dir render it like that
    tag_a+="<a href='$i.html'>$(basename $i)</a>        Programming source file<br/>"
  done

  cat >dist/index.html <<EOF
<html>
<h3>My programs from this website</h3>
<hr/>
<pre>
$ cd /Programming

<a href=".">.</a>       Current dir
<a href="../">..</a>      Go back 1 dir
$tag_a
</pre>
</html>
EOF
}

function make_file() {
  file_name=$PROJECT_NAME/$1
  file_name_base=$(basename $file_name)
  exte=${file_name_base:((${#file_name_base} - 5)):5}
  file_must_exists $file_name

  # echo $file_name_base

  if [[ $exte != ".html" ]]; then
    file_name=$PROJECT_NAME/$1.html
  fi

  echo $file_name
  # echo dist/$file_name
  cat >dist/$file_name <<EOF
<html>
<pre>
$(cat $PROJECT_NAME/$1)
</pre>
</html>
EOF
  files+=($file_name)
}

if [ ! -d $PROJECT_NAME ]; then
  echo "There is not any project with this name or you didn't provide anything at all"
  echo "Usage: prj <project-name>"
  exit 1
fi

echo "Creating a project called $PROJECT_NAME"
mkdir -p $DIST # Create the project folder
# # touch $PROJECT_NAME/README.md

make_file "README"
make_file "LINKS"
make_file "$PROJECT_NAME.html"
make_file "docs"
make_file "TODO"
make_file "changelog"
make_loader

# Copy the content to the root dir
cp -r dist/* ../
# UNIT
