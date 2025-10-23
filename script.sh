#!/bin/bash

# Verify curl and xmllint
if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed.' >&2
  exit 1
fi
if ! [ -x "$(command -v xmllint)" ]; then
  echo 'Error: xmllint is not installed.' >&2
  exit 1
fi

# Get Text from 'https://boletimsec.com.br/boletim-diario-ciberseguranca/' to boletim1.txt file
curl -L https://boletimsec.com.br/boletim-diario-ciberseguranca/ > boletim1.txt

# Get element by path from boletim1.txt file to boletim2.txt file
XPATH="//div[@class='w-post-elm post_content us_custom_a92b9290 has_text_color']"
if ! xmllint --html --xpath "${XPATH}" boletim1.txt > boletim2.txt; then
  echo 'Error: xmllint failed to extract data.' >&2
  exit 1
fi
# Check if the extraction was successful
if [ ! -s boletim2.txt ]; then
  echo 'Error: No data extracted to boletim2.txt.' >&2
  exit 1
fi
# Format date to dd/mm/yyyy
DATE=$(date +%d/%m/%Y)

# Create file and header
echo "# Boletim de Segurança" > boletim_final.txt

# Get all data to boletim_final.txt
awk '{gsub(/<[^>]*>/,"")}1' boletim2.txt >> boletim_final.txt

# For any line start with '*' insert blank line before
sed -i 's/^\*/\n*/g' boletim_final.txt

# For any line start with '*' remove it and insert ':arrow_right: ' before it
sed -i 's/^\*/:arrow_right: /g' boletim_final.txt

# On end of file insert
# Agradecimentos ao Thierre Madureira de Souza
# Automação desenvolvida pelo /tisautomation/
echo "" >> boletim_final.txt
echo "_Agradecimentos ao Thierre Madureira de Souza pela inspiração_" >> boletim_final.txt
echo "_Automação desenvolvida por /Enderson Menezes/ e /Elias Júnior/_" >> boletim_final.txt
echo "_Aprenda a programar em Codaqui.dev_" >> boletim_final.txt
echo "Fonte: \`https://boletimsec.com.br/boletim-diario-ciberseguranca/\`" >> boletim_final.txt
