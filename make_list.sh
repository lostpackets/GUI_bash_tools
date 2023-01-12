
#!/bin/bash

# Create an array to hold the list of text boxes
text_boxes=()

# Create a function to add a new text box to the list
add_text_box() {
    text_boxes+=($(zenity --entry --text "Enter text for new text box:"))
}

# Create a function to display the list of text boxes and allow dragging and moving
display_text_boxes() {
    while true; do
        # Use Zenity to display the list of text boxes and allow dragging and moving
        selected_text_box=$(zenity --list --text "Text Boxes" --column "Text" "${text_boxes[@]}" --editable --separator=",")

        # If the user cancels, exit the loop
        if [ $? -ne 0 ]; then
            break
        fi

        # Update the array with the new order of text boxes
        IFS=',' read -a text_boxes <<< "$selected_text_box"
    done
}

# Add an initial text box
add_text_box

# Display the list of text boxes and allow dragging and moving
display_text_boxes

# add new text boxes in an infinite loop until the user cancels
while true; do
    # Use Zenity to display a button to add a new text box
    zenity --question --text "Add a new text box?" --ok-label "Add" --cancel-label "Done"

    # If the user clicks "Add", call the add_text_box function
    if [ $? -eq 0 ]; then
        add_text_box
        # display the list of text boxes and allow dragging and moving
        display_text_boxes
    else
        # If the user clicks "Done", exit the loop
        break
    fi
done

