## 起動方法
- local でAndroidシミュレータを起動
- VSCode 上で開発コンテナを起動
```bash
adb connect host.docker.internal:5555
flutter run -d host.docker.internal:5555
```

## トラブルシューティング
- flutter run でエラーが出る場合、下記を試してから再実行.
```bash
rm -rf ~/.gradle/caches
./gradlew clean
flutter clean
flutter pub get
```
