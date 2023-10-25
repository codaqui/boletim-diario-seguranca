# Verify the last issue number
curl 'https://api.github.com/repos/codaqui/boletim-diario-seguranca/issues' > response.json

# How many issues are open?
ISSUES_OPEN=$(cat response.json | jq '. | length')

# Get the last issue number is not a Pull Request
ISSUE_NUMBER=$(cat response.json | jq -r '.[] | select(.pull_request == null) | .number' | head -n 1)
if [ -z "$ISSUE_NUMBER" ]
then
    echo "pr" > numero_final.txt
else
    echo $ISSUE_NUMBER > numero_final.txt
fi