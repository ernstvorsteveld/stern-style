asciidoctor --backend docbook --out-file - architectuur-review-v0.2.adoc | \
    pandoc --from=docbook --to=docx --reference-doc=step-by-step.docx --output=output.docx


# asciidoctor --backend docbook --out-file - architectuur-review-v0.2.adoc | \
#     pandoc --from=docbook --to=docx --reference-doc=new-reference.docx --output=output.docx    