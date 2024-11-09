# Generate the list of currently installed packages with date in the filename
echo "Generating list of installed packages with date in the filename..."

# Define a filename with the current date
filename="installed_packages_$(date +%Y-%m-%d).txt"

# Create the file with the list of installed packages
apt list --installed | awk -F/ '{print $1}' > "$filename"

echo "Installed packages saved in $filename"

