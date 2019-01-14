import requests
import json
from urllib.parse import urljoin


class Vault:

    def __init__(self, root_token, base_path='secrets', base_url='http://localhost:8200',
                 ssl_verify=True):
        self.root = root_token
        self.base = base_path
        self.vault_address = base_url
        self.ssl_verify = ssl_verify

    def add(self, secrets):
        failed = []
        for secret in secrets:
            try:
                self.__request(secret)
            except requests.HTTPError as e:
                f_secret = secret.copy()
                f_secret['value'] = '*'
                failed.append({
                    'exception': e,
                    'secret': f_secret
                })
        if len(failed) > 0:
            return failed
        return True

    def __request(self, secret):
        data = { 'data' : {
                            "value": secret['value']
                          }
        }
        #print (json.dumps(data))
        url = urljoin(self.vault_address, '/'.join(['v1', self.base , '/data/', secret['path'], '/', secret['service']]))
        headers = {
            'X-Vault-Token': self.root
        }
        r = requests.post(url, data=json.dumps(data), headers=headers, verify=self.ssl_verify)
        r.raise_for_status()
        return r
