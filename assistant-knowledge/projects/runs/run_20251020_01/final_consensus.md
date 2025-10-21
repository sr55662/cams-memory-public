# Final consensus (publishable snapshot)

- **Unified equities** fixed and readable; schema consistent (`symbol: string`, `date: timestamp[ns]`).
- **Backups policy**: all prior files retained under `.../backups/*.bak_<UTC>.parquet`.
- **Catalog & QA**: generate and mirror to `s3://$BUCKET/system/catalog/latest` and `system/qa`.
- **Secrets**: never commit keys; load Polygon key from SSM `/cgq/polygon_api_key`.

**Next**
1) Complete catalog script run and mirror.
2) Execute daily incremental (7d) for SPY, QQQ, IWM, TLT, GLD.
3) Re-run box verify; attach resulting JSON/TXT to run notes in next update.