Return-Path: <linux-kernel+bounces-753957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8DB18AB4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 06:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21093AF176
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDF1DC198;
	Sat,  2 Aug 2025 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kU3NYI04"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7A182D0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754109418; cv=none; b=e0u6q9NlsartJv0/QySkGd7NWfHneTnwF9XCVI0jGYhjKunvfOpZTzfcuW+e6EgeD9UzslEbC0EGtcm/W7vSrPexhT1bA44COE67yvNN2YSr9M7vigufHlHzdI8d4D26aaOZrmlFUbvef0R4Lbd9Xp5B0YiLVZwACmWmNtX1uNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754109418; c=relaxed/simple;
	bh=elSBq3vYF2Q/YQxQOz0WjVMGlFbN3xmoIcx97Tm2TwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYEUnaUwei6eEza3K8N7R9TQ8m1t4sEn3YEYzvP5hwIMsmaqtv/Zu/Mc+Svxj2sp0WxxhrweZ8e3l9XBg6tnHBo+C7XNNSY760gyQdC6gTgyzbKysk4K5ePXFIhE38Bvcvc4RpnijuU5dGa9ESFuaCQxXqd4tgGjv/S3ce+7Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kU3NYI04; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71a39f93879so39697397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754109415; x=1754714215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpxdVaZT3ggTcwknhmogVGgx1QkratO9Z6FQeGJw1EM=;
        b=kU3NYI04ZD8g04FP1iCRAiM/A6mPL4tMCeSlwC4aVJGBSa/g6pXoBo6SqPmXfFz/CM
         lo9g6v4kp4lDzd5R5wEGX6DPpt4ArMhPgKUVdlYm0KMcJcHjpsx13UkiemxeEzQKz64n
         pZP19K6/bueoTlgdILqZmex3+rMlb170le1xmn9aQ+tDd84n6WQJ3eSAFrJMoKmMuZCm
         /pq6pW9X8VBhcZfqhiGR06+fbzf+5mXo5Bn8/wsssHYDpTbWe71IN8gc6Xz6a9xKy35G
         jS2WfcFl7qJKkXZ7fH3pj/9HZkYTNyV+aHFjTA3szv2bJs/q4r1fZjpVaOl9YbSmtYbp
         n+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754109415; x=1754714215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpxdVaZT3ggTcwknhmogVGgx1QkratO9Z6FQeGJw1EM=;
        b=FZJ+9MlliV9Rh2R8GaOgmpr5r9LcSP1bZCESDsMq5aFOry5GlW4WxszCHI9dy+EsGV
         U+r160MLpoqNj8a1h+mBnAM1RPOuVwpIGrOtIzuXMsNki/IJEYqYQdVTRLzaAYjaXlLu
         ddPIpMDOviT9MZsZ+bAySsVFzHDp2rh1Hr8vWT4yS5ZFN7ym74a5MhieHNIqSaFqH/ib
         BKgza156P+RK1Ol1n4rk79uKnkroRIRQuTrblwtkJ+1N47+pw/a/Rwx3+4WqW4Bt+vPd
         7DbzhxO+oBv4wZ1STHvQry6DXECHxlncvXHH0T+4i1A1BzTqD7CEXPefcMcIWJlDRfIq
         xUsw==
X-Forwarded-Encrypted: i=1; AJvYcCWRX/bKv40D55H8p0CPk6py4CPTz4aRfEs4VNaPnXxD7f3bjcbjsN7FOQwGlE2bv1UGwk24wjvicb8enBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlAeOAapEaRppBt/H+bkXQrcXEaNcmK0YOwVKh3uNbcSTFhGr
	UWG5C6ZqviMK529v91axtBDc5z8Dm7tt5CmLiMQIhBflmjWZyL8aR/JCP+boU0T9yVBzlWLRlky
	kC9E1gqi+DMUnO+kPz0U/FJPvVjre2mNbUdDndch8lQ==
X-Gm-Gg: ASbGncvBa/sLbl3rf+FZj4kLPKlRxOvntfKJ/Wl2/Am7QsIuKCBlOA5JkFNGdLH0KZo
	RoJVgbZkIXvMiKNKyXUBCrMmyKeUE5l100m5DhvW/ML+VApO07IdfxOIQs8PagGm8jG1+fM3nHK
	/ruuCnAtbaH0pRGunp8yBIvolfkNnMY57bwI1CyTAy2mAlnGMu6uuK1RG/ly1lQd5scyB8u0KIT
	dsxoA==
X-Google-Smtp-Source: AGHT+IGvyU2/m5mcNXoIxo2H4bSkhxZ4X2l1B3N+OEYonJy6sNo7cQul9ylw34vrCJlg2gEXDNbyOXxChcvqz/OtoKE=
X-Received: by 2002:a05:690c:a088:10b0:70e:404f:6714 with SMTP id
 00721157ae682-71b5a8d640fmr80202237b3.19.1754109415216; Fri, 01 Aug 2025
 21:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250724081337epcas2p31f594b6e9ab87e24c94f11dea4070956@epcas2p3.samsung.com>
 <20250724080854.3866566-1-sw617.shin@samsung.com> <20250724080854.3866566-4-sw617.shin@samsung.com>
In-Reply-To: <20250724080854.3866566-4-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Aug 2025 23:36:44 -0500
X-Gm-Features: Ac12FXypoGhwaCr-zezDkh9lDEjeLpymS8fUEtxXp0UPR8OQmiwsykO4dBxTXtU
Message-ID: <CAPLW+4mo-Fw5+KmwHdZGAM4uNpOWL6QakTgP-wMSxR=+dMGqsQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] watchdog: s3c2410_wdt: Increase max timeout value
 of watchdog
To: Sangwook Shin <sw617.shin@samsung.com>
Cc: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, khwan.seo@samsung.com, dongil01.park@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:13=E2=80=AFAM Sangwook Shin <sw617.shin@samsung.c=
om> wrote:
>
> Increase max_timeout value from 55s to 3664647s (1017h 57min 27s) with
> 38400000 frequency system if the system has 32-bit WTCNT register.
>
> cat /sys/devices/platform/10060000.watchdog_cl0/watchdog/watchdog0/max_ti=
meout
> 3664647
>
> [    0.302473] s3c2410-wdt 10060000.watchdog_cl0: Heartbeat: count=3D1099=
394100000, timeout=3D3664647, freq=3D300000
> [    0.302479] s3c2410-wdt 10060000.watchdog_cl0: Heartbeat: timeout=3D36=
64647, divisor=3D256, count=3D1099394100000 (fff8feac)
> [    0.302510] s3c2410-wdt 10060000.watchdog_cl0: starting watchdog timer
> [    0.302722] s3c2410-wdt 10060000.watchdog_cl0: watchdog active, reset =
enabled, irq disabled
>
> If system has 32-bit WTCNT, add QUIRK_HAS_32BIT_MAXCNT to its quirk flags=
, then
> it will operation with 32-bit counter. If not, with 16-bit counter like p=
revious.
>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---

Not a strong point, but I'd break this patch into two:
  1. Add 32-bit counter feature (without enabling it in exynosautov920
implementation)
  2. Enable 32-bit counter feature in exynosautov920

>  drivers/watchdog/s3c2410_wdt.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 31f7e1ec779e..184b1ad46ca6 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -34,6 +34,7 @@
>  #define S3C2410_WTCLRINT       0x0c
>
>  #define S3C2410_WTCNT_MAXCNT   0xffff

Suggest renaming this to S3C2410_WTCNT_MAXCNT_16, to emphasize the
fact this value is for 16-bit counters. And for consistency with the
below one.

> +#define S3C2410_WTCNT_MAXCNT_32        0xffffffff
>
>  #define S3C2410_WTCON_RSTEN            BIT(0)
>  #define S3C2410_WTCON_INTEN            BIT(2)
> @@ -123,6 +124,10 @@
>   * %QUIRK_HAS_DBGACK_BIT: WTCON register has DBGACK_MASK bit. Setting th=
e
>   * DBGACK_MASK bit disables the watchdog outputs when the SoC is in debu=
g mode.
>   * Debug mode is determined by the DBGACK CPU signal.
> + *
> + * %QUIRK_HAS_32BIT_MAXCNT: WTDAT and WTCNT are 32-bit registers. With t=
hese

Why not name it like QUIRK_HAS_32BIT_CNT or QUIRK_HAS_32BIT_COUNTER?
As I understand, the quirk means that the chip has 32-bit counter, so
MAX bit is not really needed?

> + * 32-bit registers, larger values to be set, which means that larger ti=
meouts

Spelling: "to be set" -> "will be set" (or "have to be set").

> + * value can be set.
>   */
>  #define QUIRK_HAS_WTCLRINT_REG                 BIT(0)
>  #define QUIRK_HAS_PMU_MASK_RESET               BIT(1)
> @@ -130,6 +135,7 @@
>  #define QUIRK_HAS_PMU_AUTO_DISABLE             BIT(3)
>  #define QUIRK_HAS_PMU_CNT_EN                   BIT(4)
>  #define QUIRK_HAS_DBGACK_BIT                   BIT(5)
> +#define QUIRK_HAS_32BIT_MAXCNT                 BIT(6)
>
>  /* These quirks require that we have a PMU register map */
>  #define QUIRKS_HAVE_PMUREG \
> @@ -198,6 +204,7 @@ struct s3c2410_wdt {
>         struct notifier_block   freq_transition;
>         const struct s3c2410_wdt_variant *drv_data;
>         struct regmap *pmureg;
> +       unsigned int            max_cnt;

Maybe make it u32? It definitely refers to a 32-bit register value, so
will be more explicit that way. Not a strong opinion though.

>  };
>
>  static const struct s3c2410_wdt_variant drv_data_s3c2410 =3D {
> @@ -349,7 +356,7 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov920_cl0 =3D {
>         .cnt_en_bit =3D 8,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
>                   QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> -                 QUIRK_HAS_DBGACK_BIT,
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_MAXCNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_exynosautov920_cl1 =3D =
{
> @@ -362,7 +369,7 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov920_cl1 =3D {
>         .cnt_en_bit =3D 8,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
>                   QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> -                 QUIRK_HAS_DBGACK_BIT,
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_MAXCNT,

Yeah, I think it would be easier to review and handle further if this
exynosautov920 enablement is extracted into a separate patch.

>  };
>
>  static const struct of_device_id s3c2410_wdt_match[] =3D {
> @@ -411,7 +418,7 @@ static inline unsigned int s3c2410wdt_max_timeout(str=
uct s3c2410_wdt *wdt)
>  {
>         const unsigned long freq =3D s3c2410wdt_get_freq(wdt);
>
> -       return S3C2410_WTCNT_MAXCNT / DIV_ROUND_UP(freq,
> +       return wdt->max_cnt / DIV_ROUND_UP(freq,
>                 (S3C2410_WTCON_PRESCALE_MAX + 1) * S3C2410_WTCON_MAXDIV);
>  }
>
> @@ -566,7 +573,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_d=
evice *wdd,
>  {
>         struct s3c2410_wdt *wdt =3D watchdog_get_drvdata(wdd);
>         unsigned long freq =3D s3c2410wdt_get_freq(wdt);
> -       unsigned int count;
> +       unsigned long count;
>         unsigned int divisor =3D 1;
>         unsigned long wtcon;
>
> @@ -576,7 +583,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_d=
evice *wdd,
>         freq =3D DIV_ROUND_UP(freq, 128);
>         count =3D timeout * freq;
>
> -       dev_dbg(wdt->dev, "Heartbeat: count=3D%d, timeout=3D%d, freq=3D%l=
u\n",
> +       dev_dbg(wdt->dev, "Heartbeat: count=3D%lu, timeout=3D%d, freq=3D%=
lu\n",
>                 count, timeout, freq);
>
>         /* if the count is bigger than the watchdog register,
> @@ -584,8 +591,8 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_d=
evice *wdd,
>            actually make this value
>         */
>
> -       if (count >=3D 0x10000) {
> -               divisor =3D DIV_ROUND_UP(count, 0xffff);
> +       if (count > wdt->max_cnt) {

wdt->max_cnt + 1?

> +               divisor =3D DIV_ROUND_UP(count, wdt->max_cnt);
>
>                 if (divisor > S3C2410_WTCON_PRESCALE_MAX + 1) {
>                         dev_err(wdt->dev, "timeout %d too big\n", timeout=
);
> @@ -593,7 +600,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_d=
evice *wdd,
>                 }
>         }
>
> -       dev_dbg(wdt->dev, "Heartbeat: timeout=3D%d, divisor=3D%d, count=
=3D%d (%08x)\n",
> +       dev_dbg(wdt->dev, "Heartbeat: timeout=3D%d, divisor=3D%d, count=
=3D%lu (%08lx)\n",
>                 timeout, divisor, count, DIV_ROUND_UP(count, divisor));
>
>         count =3D DIV_ROUND_UP(count, divisor);
> @@ -801,6 +808,10 @@ static int s3c2410wdt_probe(struct platform_device *=
pdev)
>         if (IS_ERR(wdt->src_clk))
>                 return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed =
to get source clock\n");
>
> +       wdt->max_cnt =3D S3C2410_WTCNT_MAXCNT;
> +       if ((wdt->drv_data->quirks & QUIRK_HAS_32BIT_MAXCNT))

Double braces don't seem to be needed.

> +               wdt->max_cnt =3D S3C2410_WTCNT_MAXCNT_32;
> +

Style (minor nitpick): this block can be more explicit, i.e.:

       if ((wdt->drv_data->quirks & QUIRK_HAS_32BIT_MAXCNT))
               wdt->max_cnt =3D S3C2410_WTCNT_MAXCNT_32;
       else
               wdt->max_cnt =3D S3C2410_WTCNT_MAXCNT;

>         wdt->wdt_device.min_timeout =3D 1;
>         wdt->wdt_device.max_timeout =3D s3c2410wdt_max_timeout(wdt);
>
> --
> 2.25.1
>

