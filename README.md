# ansible-practice

Nginx + PHP-FPM 構成のサーバを EC2インスタンス上に構築する Ansible Playbook (習作)

# 注意点
- AMIは AmazonLinux2 を使用することを前提にしています。
- ターゲットノードにSSH接続する際に公開鍵のフィンガープリントチェックを無効化していますが、有効にすると以下のようなエラーがでるためそうしています。(なぜ以下のようなエラーがでるかは正直よく分かっていない)

```
PLAY [Setup NGINX and PHP on Amazon Linux] *************************************

TASK [Gathering Facts] *********************************************************
fatal: [server]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: Host key verification failed.", "unreachable": true}

PLAY RECAP *********************************************************************
server                     : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0  
```

# Usage 
- AMIとしてAmazonLinux2を指定してEC2インスタンスを立ち上げる
- 立ち上げたEC2インスタンスにSSHで接続する
- .ssh ディレクトリ配下に EC2インスタンス作成時に設定した公開鍵と対になる秘密鍵をコピーする
- .ssh ディレクトリ配下に ~/.ssh/known_hosts をコピーする
- ansible/inventory.ini の ansible_host に立ち上げたEC2インスタンスのパブリックIPアドレスを書く
- ansible/inventory.ini の ansible_ssh_private_key_file に秘密鍵の名前で「sandbox-us-east.pem」を置き換える
- `docker image build --tag my-ansible:$(date '+%s') .` を実行する
- `docker container run <先ほど作成したイメージのタグ>` を実行する

# 補足
- install.sh はこの Ansible Plybook でやってる処理と同じ処理を行うシェルスクリプトです。