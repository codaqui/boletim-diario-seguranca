#!/bin/bash

# Get Text from 'https://boletimsec.com.br/boletim-diario-ciberseguranca/' to boletim.html file
curl -s https://boletimsec.com.br/boletim-diario-ciberseguranca/ > boletim1.txt

# Get element by js path from boletim.html file to boletim.txt file
xmllint --html --xpath "/html/body/div[1]/main/section[2]/div/div/div[2]/div/div/div[2]" boletim1.txt 1> boletim2.txt 2> /dev/null

# Format date to dd/mm/yyyy
DATE=$(date +%d/%m/%Y)

# Create file and header
echo "# Boletim de Segurança" > boletim_final.txt
echo "--> Data: $DATE" >> boletim_final.txt

# Get all data to boletim3.txt
awk '{gsub(/<[^>]*>/,"")}1' boletim2.txt >> boletim_final.txt

# Delete last four lines
sed -i '$ d' boletim_final.txt
sed -i '$ d' boletim_final.txt
sed -i '$ d' boletim_final.txt
sed -i '$ d' boletim_final.txt

# For any line start with '*' insert blank line before
sed -i 's/^\*/\n*/g' boletim_final.txt

# For any line start with '*' remove it and insert ':arrow_right: ' before it
sed -i 's/^\*/:arrow_right: /g' boletim_final.txt

# On end of file insert
# Agradecimentos ao Thierre Madureira de Souza
# Automação desenvolvida pelo /tisautomation/
echo "" >> boletim_final.txt
echo "" >> boletim_final.txt
# echo "_Agradecimentos ao Thierre Madureira de Souza pela inspiração_" >> boletim_final.txt
# echo "_Automação desenvolvida por /Enderson Menezes/ e /Elias Júnior/_" >> boletim_final.txt
# echo "_Aprenda a programar em Codaqui.dev_" >> boletim_final.txt
# echo "Fonte: \`https://boletimsec.com.br/boletim-diario-ciberseguranca/\`" >> boletim_final.txt
