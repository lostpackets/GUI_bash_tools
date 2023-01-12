#!/bin/bash

# Create a list of actions and corresponding scripts
actions=(
    ""
    "Action 1:./action1.sh"
    ""
    "Action 2:./action2.sh"
    ""
    "Action 3:./action3.sh"
    ""
    "Action 4:./action4.sh"
    ""
    "Action 5:./action5.sh"
    ""
    "Action 6:./action5.sh"
    ""
    "Action 7:./action5.sh"
    ""
    "Action 8:./action5.sh"
    ""
    "Action 9:./action5.sh"
    ""
    "Action 10:./action5.sh"
    ""
    "Action 11:./action5.sh"
)

# Create a Zenity dialog with checkboxes for different actions and allow multiple selections
result=$(zenity --list --checklist --title "Zenity Example" --text "Choose actions:" --column "Select" --column "Actions" "${actions[@]%%:*}")

# Exit if user cancels or closes the dialog
[[ -z $result ]] && exit

# Display the selected actions
zenity --info --title "Selected actions" --text "You have selected the following actions: $(echo '\n'$result | tr '|' '\n')"

# Split the result into an array
IFS=$'\n' read -r -a selected_actions <<< "$result"

# Iterate over the selected actions and execute the corresponding script
for selected_action in "${selected_actions[@]}"; do
    for action in "${actions[@]}"; do
        if [[ $selected_action = ${action%%:*} ]]; then
            # Execute the script
            ${action##*:}
            break
        fi
    done
done

