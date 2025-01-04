

# **Subdomain Finder and Live Checker Tool**

A powerful script to help penetration testers and security enthusiasts quickly discover subdomains and check their live status using **assetfinder** and **httprobe**. This tool automates the process of subdomain enumeration and live probing, making it an essential addition to your toolkit.

---

## **Features**

- **Automated Subdomain Discovery**: Uses `assetfinder` to gather potential subdomains for a given domain.
- **Live Subdomain Checking**: Checks the live status of discovered subdomains using `httprobe`.
- **Domain Validation**: Validates the entered domain to ensure it's properly formatted.
- **Color-Coded Output**: Uses ANSI colors for easy-to-read output.
- **Interactive**: User-friendly prompts guide you through the process.

---

## **Installation**

### Prerequisites

Before running the script, ensure the following tools are installed:

- **assetfinder**: Subdomain discovery tool.
- **httprobe**: Tool for checking live subdomains.

Install them with the following commands:

```bash
# Install assetfinder
go install github.com/tomnomnom/assetfinder@latest

# Install httprobe
go install github.com/tomnomnom/httprobe@latest
```

### Cloning the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/yourusername/subdomain-finder.git
cd subdomain-finder
```

Make the script executable:

```bash
chmod +x subdomain-finder.sh
```

---

## **Usage**

To start the tool, run:

```bash
./subdomain-finder.sh
```

### **Steps**

1. **Enter Domain**: Input the target domain when prompted (e.g., `example.com`).
2. **Domain Validation**: The script ensures the domain is correctly formatted.
3. **Subdomain Discovery**: The script uses `assetfinder` to find potential subdomains.
4. **Live Subdomain Checking**: The script uses `httprobe` to check which subdomains are live.
5. **Output**: Live subdomains will be displayed in a color-coded format.
6. **Continue or Exit**: Choose to scan another domain or exit the tool.

---

## **Example**
```bash
Subdomain Finder and Live Checker Tool
==================================================================
Target domain: example.com
Finding subdomains for example.com....
Checking for live subdomains....
Live subdomains:
www.example.com
api.example.com
...

Do you want to continue with another domain? (yes/no):
```

---

## **Customization**

You can easily modify the script to fit your needs by:

- Adjusting the `assetfinder` and `httprobe` options.
- Changing the domain validation rules.
- Customizing the colors and animation delay.

---

## **Contributing**

Contributions are welcome! Fork the repository, submit pull requests, and create issues for bugs or feature requests.

---

## **License**

This project is licensed under the MIT License.

---

## **Contact**

If you have any questions, feel free to open an issue on GitHub or contact me directly at [your.email@example.com](mailto:your.email@example.com).

---

This version provides a clean and professional `README.md` for your subdomain enumeration and live checking script. Let me know if you'd like any further adjustments!
