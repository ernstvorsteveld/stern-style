#!/bin/sh

# Generate a pdf file from a adoc file
# adoc file is first parameter

check_output_file_parameter () {
    PARAM_CHECK_FILE=$1
    if [ -z $PARAM_CHECK_FILE ]
    then
        return 0
    else
        if [[ "$PARAM_CHECK_FILE" == "y" ]]
        then 
            return 1
        else 
            echo "Error: Value for checking file not recognized."
            echo "Exiting script!"
            exit 1
        fi
    fi
}

check_output_file_exists () {
    FULLNAME=$1
    CHECK_FILE=$2
    if [[ "$CHECK_FILE" == "1" ]]
    then
        FULLNAME=$1
        extension="${FULLNAME##*.}"
        filename="${FULLNAME%.*}"

        outputFilename="${filename}.pdf"
        echo "Checking if output file ${outputFilename} already exists."

        if [ -f $outputFilename ]; then
            echo "Error: Output file ${outputFilename} already exists!"
            echo "Exiting script!"
            exit 1;
        fi
    fi
}

check_output_file_parameter $2
CHECK_FILE=$?
PARAM_FILENAME=$1
ADOC_PDF_THEME=/Users/ernstvorsteveld/git/asciidoctor/generate-docx/stern.yml
ADOC_FONTS_DIR=/Users/ernstvorsteveld/git/asciidoctor/generate-docx/fonts

echo "Generating PDF file."
echo "Using input file:     " $PARAM_FILENAME
echo "Checking output:      " $CHECK_FILE
echo "With theme file:      " $ADOC_PDF_THEME
echo "And fonts directory:  " $ADOC_FONTS_DIR

check_output_file_exists $PARAM_FILENAME $CHECK_FILE

#asciidoctor-pdf -v -a pdf-theme=./stern.yml -a pdf-fontsdir=./fonts $1
asciidoctor-pdf -v \
    -a pdf-theme=$ADOC_PDF_THEME \
    -a pdf-fontsdir=$ADOC_FONTS_DIR \
    $1

