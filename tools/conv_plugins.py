import re
import chardet

file_path = './resources/raw_plugins.txt'  # Replace with the full path if necessary
output_file = './resources/plugins.txt'

# Read the raw plugin list
with open(file_path, 'rb') as f:
    raw_data = f.read()

# Detect encoding
detected_encoding = chardet.detect(raw_data)

encoding = detected_encoding.get('encoding', 'utf-8')
print(f"Detected encoding: {encoding}")

# Open the file with the detected encoding
with open(file_path, 'r', encoding=encoding) as f:
    lines = f.readlines()

# Print the content to check if it’s readable
# print("File content:")
# for line in lines:
#     print(line.strip())


# Prepare the output
plugins = []

for line in lines:
    # Match lines with the plugin and version format
    match = re.match(r'^(\S+)\s+.*\s+([\d\.\-v]+)', line)
    if match:
        plugin_name = match.group(1)
        plugins.append(f"{plugin_name}")

# Write to plugins.txt
with open(output_file, 'w') as output_file:
    output_file.write("\n".join(plugins))

print("Plugins converted and saved to plugins.txt")