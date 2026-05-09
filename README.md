# g2ray — نسخه بهینه‌شده

پروکسی self-hosted مبتنی بر Xray که روی GitHub Codespaces اجرا می‌شود.

## تغییرات نسبت به نسخه اصلی

| مشکل | نسخه قدیم | نسخه جدید |
|------|-----------|-----------|
| UUID | ثابت و عمومی در کد | تولید خودکار هنگام build |
| لینک اتصال | IP ثابت هاردکد | hostname پویا از CODESPACE_NAME |
| routing | ندارد | بلاک IP خصوصی، تورنت، تبلیغات |
| DNS | ندارد | DoH با 1.1.1.1 |
| policy/timeout | ندارد | timeout و buffer بهینه |
| fallback | ندارد | اتصال ناشناس → HTTP |
| لاگ | warning بدون فایل | error log در /tmp |

## نصب

1. این ریپازیتوری را fork کنید
2. روی **Code → Codespaces → New codespace** کلیک کنید
3. چند دقیقه صبر کنید تا build تمام شود
4. لینک اتصال در ترمینال نمایش داده می‌شود

## محدودیت GitHub Codespaces (رایگان)

- **۱۲۰ core-hour در ماه** — چون ۲ هسته استفاده می‌کند، **۶۰ ساعت** در ماه
- بعد از استفاده، Codespace را **متوقف** کنید: `gh codespace stop`

## نکات امنیتی

- UUID هر بار که Dockerfile بیلد می‌شود، خودکار تولید می‌شود
- بلاک BitTorrent فعال است (جلوگیری از abuse و بن شدن اکانت)
- IP های خصوصی و loopback بلاک هستند
- در صورت اتصال غیر-VLESS، fallback به HTTP فعال است

## کلاینت‌های سازگار

- v2rayNG (اندروید)
- Nekobox (اندروید / ویندوز)
- v2rayN (ویندوز)
- Streisand (iOS)
- FoXray (iOS)
