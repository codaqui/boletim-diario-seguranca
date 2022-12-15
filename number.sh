curl 'https://api.github.com/repos/codaqui/boletim-diario-seguranca/issues' | jq -r '.[0].number' >> numero_final.txt
