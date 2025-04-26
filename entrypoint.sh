#!/bin/bash
set -e

# PIDファイルが残っていたら削除
rm -f tmp/pids/server.pid

# 本番環境で1回だけアセットをプリコンパイル（存在チェック）
if [ "$RAILS_ENV" = "production" ] && [ ! -f public/assets/.sprockets-manifest*.json ]; then
  echo "== Running assets:precompile =="
  bundle exec rake assets:precompile
fi

# 最後に指定されたコマンドを実行
exec "$@"

