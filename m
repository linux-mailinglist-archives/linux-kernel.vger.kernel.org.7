Return-Path: <linux-kernel+bounces-758074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D2B1CA8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B25E565E27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86829CB3E;
	Wed,  6 Aug 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snZU1FjK"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F429C337
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500680; cv=none; b=hXrX9SU5cZ4mTOaCgop15pi+LVHsOs+Www3gUdtzLDH4dKmbeF4piSNWurmVy0GrRJEv2iVXyhO5J4wy1ks4GcjglR2NcHuxwSPewpo9jChUOyK2xyTrUz67nGEyy99nNaxOlQ1CDT4BmNfVjp7gRdV2USaM0ehVAialeDE9pNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500680; c=relaxed/simple;
	bh=Y0fD4MpRo3g7NK5y3s9VeqYtv1/oJ4ikGjJ95epd7uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRxlg72mHBZr0i56dNpwLa52Gkmv9RWB0RPoCUOUzZp6eOXbgS9HBQ3ob3+jM2YcKIV+61ls9qiYuRp12xh/xbC5nueKXZzs5bumMdq2SjVW5faIkWCtJ2X+9O7WFf3nz8uaAR2XFAa+/dHv5bGEBgqc75hmCM2heGY9ughD+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snZU1FjK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71b4fc462ddso522537b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754500677; x=1755105477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCJFY1Ry1l45cujmFWN8iUaZroZ2v+N4zhO/u5g0qWo=;
        b=snZU1FjKYXt9Xjr3LWONV8Z5qsaR+qsU3ZZ8DUO2IxnBmbXN+ci4hKywQpjvIOdZgz
         Jx8P9J0wteBg9JhbPUpxI/fh5Q9PVnqh0XtKgr/2S5YZE3jhEHhiIzG++vXXdccWt03e
         OmLMAgxzIeo5p7C3/joiOxauQ0LYPI1YFAcE2jlF0l5F+1diqR6W0LWnIUxG7ArcFp4D
         +upo7BrtWilipH/UOlIrOAwAOcwDDP+oB7CdWWTnZmov+4c5rpGEJnymnE7u71M2aXpY
         2TjKCBySiYDFIg2h3QqqqE5g03nGcVTLuF/7ysX6rUdV13sUGHQV4bfOY9dcE4wLpS4s
         jRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754500677; x=1755105477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCJFY1Ry1l45cujmFWN8iUaZroZ2v+N4zhO/u5g0qWo=;
        b=UMViMy9YWIBI4KfYiV1ekDfyV4jcisdPHGJ14UkcgvKviAy6jvA9WgLQsFA6/pn1lZ
         tGB5/RIFM5hQPLvMU6r3Fr6t1nODueHe70ghe0F7ljb+K+eog/tlrm6XUNtUVHiCs04m
         tY8vYJQmGSTk9kAZKBqpo1XqdCJGuiPRF2Fajoxpwug5NYqED/7iKK8E476IpR7R5I4k
         eM4jjGrkNJ26Hmn1D5l4CFcbqcPyQ2PZ/B4XEapCcDrXzzRBZfo/YsHZBpJhSgGHuj/J
         bsnuIVqUqM6aSTZl9ia25GBLzaNkMohjDCY7PiQpvcf4EF9R9v/3vHwr2NdHpv8kQ+ay
         qo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiM7WqzsXzpatcF1hbM+AtvLTmgzqzZPp9HLpzdjMh958WczezjzXp80T0dNFPFa+FfQOqMcmYd2y/c/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2ppRGq2n+Rzli+TNGsz/Y8xjhrmEPGg6dFtHC8W5YztKf+qu
	+innIqpB7aalGEH0BhEkmpcHb82rNecIEzXxsGxlZZgrLqYZJDsGDV/djb4fdU0XslEWhHgHMls
	xqWUmtjRPOteVEQf72VprQetqhOgr7CJyIl6DZ+zqnA==
X-Gm-Gg: ASbGncs/6WqPoHbCNTUQprZ1bf/rFd+WrZRBYu0tLj7688zUcQBdfoljMesBV88cYcC
	J4IUsNe2qjYfttkSy0Aj/+4SiuzrfFABJ0hBpQC6pLN0688NnYH8GeL+XG4tqkZGd5Cw54UqTWw
	agPtKp3NfgV4aGQOHZTC43ogEAQQeTeeaVpv6Nj0EF0mgMsBLvY+oP78dfVtijCRJpjJrgvv41Z
	kobzefFSmA26hvMrlsPVVoQohY=
X-Google-Smtp-Source: AGHT+IF/PATUAgO1kyiILLwJ2Hz+mfCVgzAsnenKM/M4eB9tFIphDugm0X2Ki4Larr5HlLbqkJkCKKOb501IL1PCi98=
X-Received: by 2002:a05:690c:f03:b0:71a:3484:abe8 with SMTP id
 00721157ae682-71bc98866fbmr51496647b3.34.1754500677372; Wed, 06 Aug 2025
 10:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250806070029epcas2p1f764301b115b766f88b422b0dbdd68f1@epcas2p1.samsung.com>
 <20250806065514.3688485-1-sw617.shin@samsung.com> <20250806065514.3688485-3-sw617.shin@samsung.com>
In-Reply-To: <20250806065514.3688485-3-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Aug 2025 12:17:46 -0500
X-Gm-Features: Ac12FXyGsSXeAvPSWY26uUPOsx4RabuRz1OCuoO1ZxYtOJ0aBX2ZDz4rGIPWY70
Message-ID: <CAPLW+4=Lf5rs3p3+D17HDGYd1FHk-PDghOq4fygRzZi7VZXcHQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] watchdog: s3c2410_wdt: Fix max_timeout being
 calculated larger
To: Sangwook Shin <sw617.shin@samsung.com>
Cc: krzk@kernel.org, alim.akhtar@samsung.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, dongil01.park@samsung.com, khwan.seo@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:00=E2=80=AFAM Sangwook Shin <sw617.shin@samsung.co=
m> wrote:
>
> Fix the issue of max_timeout being calculated larger than actual value.
> The calculation result of freq / (S3C2410_WTCON_PRESCALE_MAX + 1) /
> S3C2410_WTCON_MAXDIV is smaller than the actual value because the remaind=
er
> is discarded during the calculation process. This leads to a larger
> calculated value for max_timeout compared to the actual settable value.
> To resolve this issue, the order of calculations in the computation proce=
ss
> has been adjusted.
>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 95f7207e390a..0a4c0ab2a3d6 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -27,6 +27,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> +#include <linux/math64.h>
>
>  #define S3C2410_WTCON          0x00
>  #define S3C2410_WTDAT          0x04
> @@ -410,9 +411,13 @@ static inline unsigned long s3c2410wdt_get_freq(stru=
ct s3c2410_wdt *wdt)
>  static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wd=
t)
>  {
>         const unsigned long freq =3D s3c2410wdt_get_freq(wdt);
> +       //(S3C2410_WTCON_PRESCALE_MAX + 1) * S3C2410_WTCON_MAXDIV =3D 0x8=
000

This single-line comment style (//) is usually not used in the kernel
code. Prefer multi-line comment style instead (/* */). More
importantly, this comment is not needed: using the raw 0x8000 value
below is still hard-coding it, and this comment is not the best way to
fix that. So declare either a proper constant or a define, and use it
further. I'd go with this:

    const u64 cnt_max =3D (S3C2410_WTCON_PRESCALE_MAX + 1) *
                        S3C2410_WTCON_MAXDIV * S3C2410_WTCNT_MAXCNT;

and then:

    u64 t_max =3D div64_ul(cnt_max, freq);

Sorry I didn't catch your related comment earlier in v4!

With that addressed, feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +       u64 t_max =3D div64_ul((u64)S3C2410_WTCNT_MAXCNT * 0x8000, freq);
>
> -       return S3C2410_WTCNT_MAXCNT / (freq / (S3C2410_WTCON_PRESCALE_MAX=
 + 1)
> -                                      / S3C2410_WTCON_MAXDIV);
> +       if (t_max > UINT_MAX)
> +               t_max =3D UINT_MAX;
> +
> +       return t_max;
>  }
>
>  static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool ma=
sk)
> --
> 2.25.1
>

