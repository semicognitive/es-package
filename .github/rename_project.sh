#!/usr/bin/env bash
while getopts a:n:u:d: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        u) urlname=${OPTARG};;
        d) description=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project Name: $name";
echo "Project URL name: $urlname";
echo "Description: $description";

echo "Renaming project..."

original_author="semicognitive"
original_name="es-package"
original_urlname="semicognitive/es-package"
original_description="A template for creating and publishing an ES module\n\nStart by [using this template](https://github.com/semicognitive/es-package/generate)"
# for filename in $(find . -name "*.*") 
for filename in $(git ls-files) 
do
    sed -i "s/$original_author/$author/g" $filename
    sed -i "s/$original_name/$name/g" $filename
    sed -i "s/$original_urlname/$urlname/g" $filename
    sed -i "s/$original_description/$description/g" $filename
    echo "Renamed $filename"
done

mv project_name $name

# This command runs only once on GHA!
if [ -f .github/workflows/project_name.yml ]; then
    mv .github/workflows/rename_project.yml .github/workflows/rename_project.yml.disabled
fi