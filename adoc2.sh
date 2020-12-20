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

check_output_type () {
    OUTPUT_PARAM=$1
    REQUESTED_TYPE=$2
    if [[ "$OUTPUT_PARAM" == $REQUESTED_TYPE ]]
    then
        return 1
    else
        return 0
    fi
    echo "Error: input value for output type not recognized."
    exit 1
}

do_pdf () {
    PARAM_FILENAME=$1
    OUTPUT_TYPE_PDF=$2
    ADOC_PDF_THEME=$3
    ADOC_FONTS_DIR=$4

    if [[ $OUTPUT_TYPE_PDF == "1" ]]
    then
        asciidoctor-pdf -v \
            -a pdf-theme=$ADOC_PDF_THEME \
            -a pdf-fontsdir=$ADOC_FONTS_DIR \
            $PARAM_FILENAME
    fi
}

do_html () {
    PARAM_FILENAME=$1
    OUTPUT_TYPE_HTML=$2
    ADOC_CSS_THEME=$3

    if [[ $OUTPUT_TYPE_HTML == "1" ]]
    then
        asciidoctor \
            -a stylesheet=$ADOC_CSS_THEME \
            $PARAM_FILENAME
    fi
}

PARAM_FILENAME=$1
PARAM_OUTPUT_TYPE=$2
PARAM_CHECK_FILE=$3

check_output_type $PARAM_OUTPUT_TYPE "PDF"
OUTPUT_TYPE_PDF=$?
check_output_type $PARAM_OUTPUT_TYPE "HTML"
OUTPUT_TYPE_HTML=$?

check_output_file_parameter $PARAM_CHECK_FILE
CHECK_FILE=$?

ADOC_PDF_THEME=~/git/asciidoctor/generate-docx/stern.yml
ADOC_FONTS_DIR=~/git/asciidoctor/generate-docx/fonts
ADOC_CSS_THEME=~/git/asciidoctor/generate-docx/stern.css

echo "Generating PDF file."
echo "Using input file:     " $PARAM_FILENAME
echo "Checking output:      " $CHECK_FILE
echo "With theme file:      " $ADOC_PDF_THEME
echo "And fonts directory:  " $ADOC_FONTS_DIR

check_output_file_exists $PARAM_FILENAME $CHECK_FILE

do_pdf $PARAM_FILENAME $OUTPUT_TYPE_PDF $ADOC_PDF_THEME $ADOC_FONTS_DIR
do_html $PARAM_FILENAME $OUTPUT_TYPE_HTML $ADOC_CSS_THEME
