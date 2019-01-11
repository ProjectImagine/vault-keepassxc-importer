# vault-importer

A script designed to CSV exports into Hashicorp Vault KV use V2 API

CSV example:
"some/path","KeyName","SomeValue"


## Usage
```
vault_import
    --csv CSV      Location of the CSV file.
    --base BASE    Base path of your secrets in the vault.
    --url URL      URL of the Vault. Include the port.
    --token TOKEN  Token for the Vault
```

## Installation
Execute `python3 setup.py install --user` to install.
