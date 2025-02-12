<!-- Image from repository -->
<img src=email.jpg width="1000px"><br>
## **Subfinder - Subdomain Enumeration & Live Checker Tool**

**Subfinder** is a powerful tool designed for penetration testers and security researchers. It allows you to discover subdomains of a target domain and checks the live status of each subdomain. Using tools like **assetfinder** and **httprobe**, Subfinder automates the process of subdomain enumeration and live probing, offering fast and accurate results.

---

## **Features**

- **Subdomain Discovery**: Utilizes `assetfinder` to find potential subdomains for a given domain.
- **Live Subdomain Check**: Uses `httprobe` to check which discovered subdomains are live and responding.
- **Domain Validation**: Ensures the domain input is correctly formatted before proceeding.
- **Interactive Prompts**: Easy-to-follow prompts guide the user through the entire process.
- **Colorful and Engaging Output**: Enhanced terminal output with color-coded results for better readability.
- **Efficient and Fast**: Asynchronous subdomain enumeration and live probing for improved performance.

---

## **Installation**

### Prerequisites

To run **Subfinder**, you will need the following tools:

- **assetfinder**: A tool for discovering subdomains.
- **httprobe**: A tool for probing and checking live subdomains.

To install the prerequisites, run the following commands:

```bash
# Install assetfinder
go install github.com/tomnomnom/assetfinder@latest

# Install httprobe
go install github.com/tomnomnom/httprobe@latest
```

### Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/km-sneha/Subfinder.git
cd Subfinder
```

Make the script executable:

```bash
chmod +x script.sh
```

---

## **Usage**

To run **Subfinder**, execute the following command:

```bash
./script.sh
```

### **Steps**

1. **Enter Domain**: When prompted, input the domain you want to scan (e.g., `example.com`).
2. **Domain Validation**: The script validates the domain format to ensure it's correctly typed.
3. **Subdomain Discovery**: **Subfinder** uses `assetfinder` to gather potential subdomains.
4. **Live Subdomain Check**: The script uses `httprobe` to check which subdomains are live and responding.
5. **Output**: Live subdomains are displayed, sorted, and color-coded for easy reading.
6. **Next Steps**: After the scan, you will be prompted whether you'd like to continue with another domain or exit the tool.

---

## **Example Output**

```bash
Subfinder - Subdomain Enumeration & Live Checker Tool
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

**Subfinder** can be easily customized:

- Modify the `assetfinder` or `httprobe` options as needed.
- Adjust the domain validation pattern if you are targeting specific types of domains.
- Change the color scheme or animation delay to suit your preferences.

---

## **Contributing**

We welcome contributions! If you'd like to help improve **Subfinder**, feel free to fork the repository and submit pull requests. Please report bugs or suggest new features via GitHub Issues.

---

## **License**

This project is licensed under the MIT License.

---

## **Contact**

For any questions or inquiries, feel free to reach out by opening an issue on GitHub or via email at [your.email@example.com](mailto:your.email@example.com).

---



