Return-Path: <linux-kernel+bounces-758153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D90B1CBAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B0918C55C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2141FFC6D;
	Wed,  6 Aug 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+1CabpB"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525C1FF5E3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503669; cv=none; b=Tbd1WHU73SYts1YxOIbFGBdqgM56EOLmAsHBfZcBbWD+LMaVhgymqmbyvlk5QLQMnsFAcIymULjpcTiRW25EFZbNooHBzJpTeFV5N44UKxH8WzxUK75Ge906PC9twq/q7fCcRqMFO0XK580dBzossmzGYtw+IBu6XSpcyzMiZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503669; c=relaxed/simple;
	bh=FPHT+FUeEvjLidkz/VK3FcZAuwEOLlrxDGWwCHYkxr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmQ85rSqxr7J82yZcBpdP1hktQpcnUoh4bl1v5FddoSvZTGx8zEH558zV/kKTugZCfF3r0vLbHQbvB0XNT1TCsVK+haatrOdp0+NsqJ4Ht0JGg3p8mTKntIdThdCVJ2Kz1F73p9bTpoIZMoPKW7O0zWnt1dkM+55HRakJ9rrntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+1CabpB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71bce78e14fso1272867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754503667; x=1755108467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e64dYOpRvHmbbrtWNTSj9g3tc82tVKc7j0umGWHc75Q=;
        b=j+1CabpB+rPf+G1WA231R5dyYsna0JYFVaB/8y4mwy1P+Ewp9AnSmATiCFqo+5JQzw
         rTzd29PRUtK9egG4Fxa8NLX8PztWfqWTjvMCgC7xMvR9FhYVyrAh0zrmRhf1llpSd/lJ
         8qT06U1SledlpUqUFfiqP+MX1hRBfup/vBCWvVpJXMV2jYbrvr1nJguFcXt7NQu/B+XV
         LgJBZKNbUZEaKiPiHAbTlEiQ79FPcJ55AKJ2rwEy04aBP2tS9YBX8tNJlnd5kXQIqSV4
         ig/9i6CsU889moNIc8wnWrR3rkpO5yoKHBXwyyWgFfMnJ4AC7IElzBuYFUFFzU0VU4X0
         IvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754503667; x=1755108467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e64dYOpRvHmbbrtWNTSj9g3tc82tVKc7j0umGWHc75Q=;
        b=aDueY7t82NWcfLAFHQ3fJGwCFijZStHH/LDZKAM7BkyGpvhZnmpaO+bfnVjNz+zDCz
         vP/06tiAyjcHRjZO5kqZ9DUGFvvxdO3KgfpLC3xKAHnlghWRYP2uWvqSJ9PlkR680SNw
         dm5/X4D1Qznx2vgWzwkzww2bfvi4NEHMuNAFfmhYqbhfOO6jNgQhbo1dq52uIh55KmEA
         eb5dR+Qv6fxXCNwOPoARmaWkSnCq/ZMWp4ZB7S0A28b1bd2Q9UvdDZ3JLFhGdfkPoiXW
         YYUCiE3UfFDSruk2keIuW85RIRWRTn+AmsWIQNsa/Pe4gPL8hmwQS3ut8I0xv4KluE1/
         +MYw==
X-Forwarded-Encrypted: i=1; AJvYcCX27/JewYLnvcUcbDlvGTM3ae5nyABjzrqqxZ5S2JE+pVLABVgHZ2pzus7H+M/iXihh0pblUwTlotptKyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIIwLIaTK+xIgA/5CrFqx7Mzz2S5KHUfgJjtUsArhwOR1Aj94
	NTgqUbFeoPoWIlzxHirPWSXLCgGHYtXYUcr5q4C47rpS8CereYpoVWcmFGiBf7hEppjv9HzKPMC
	8onr60IEgmtvfOKR/WAUzhkUdUUgJGt3z2Z1MOBWv1w==
X-Gm-Gg: ASbGncsWoRPcAVy0JJW1HBlThdqZoCjGSkJEhz17fhPid0T0jE5M4x3yRf7xThCa4Fa
	eYcDx5FNu2z9drVt5JQQxzZj0YfuPHWDkNYBPg1IwiiADupxWh7TK51zkZgDt03+6rBt0jNMFYD
	RG6tbjWfz+krhgB3Qn21PwYAp6YFmLtIp3xKDeVF1FIX1gG4UkPI4wcAuXTVRow3/iFAnsfAmUB
	XWqF55QDHfNFcGL
X-Google-Smtp-Source: AGHT+IGzVNInSABQDNnUNPgx22fnkoQK29xlj80Xhm92+720xF5zbG7euyqOftdTJkmT4Ecukdgi7FOxbvVqX2U7ToY=
X-Received: by 2002:a05:690c:317:b0:71a:26cd:6d18 with SMTP id
 00721157ae682-71bcc920fc0mr43203327b3.40.1754503666653; Wed, 06 Aug 2025
 11:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250806070030epcas2p4f9b779bd9fde57b4bfea958efdf62cf4@epcas2p4.samsung.com>
 <20250806065514.3688485-1-sw617.shin@samsung.com> <20250806065514.3688485-6-sw617.shin@samsung.com>
In-Reply-To: <20250806065514.3688485-6-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Aug 2025 13:07:35 -0500
X-Gm-Features: Ac12FXz1wG21J0FHFOEmb1_vYpGiG5VXTvwnDLd5jOWOoXjCI9NbzNvCVoOhnfQ
Message-ID: <CAPLW+4m42-8QEEcQgqm93=Ar44-Gmwu5fiLy66SXEMes6J=zUA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] watchdog: s3c2410_wdt: exynosautov9: Enable
 supported features
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
> Enable supported features for ExynosAutov9 SoC.
> - QUIRK_HAS_DBGACK_BIT
> - QUIRK_HAS_32BIT_CNT
>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/s3c2410_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 541870b4d01a..f25563585983 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -306,7 +306,8 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov9_cl0 =3D {
>         .cnt_en_reg =3D EXYNOS850_CLUSTER0_NONCPU_OUT,
>         .cnt_en_bit =3D 7,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> -                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
> +                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_CNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_exynosautov9_cl1 =3D {
> @@ -318,7 +319,8 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov9_cl1 =3D {
>         .cnt_en_reg =3D EXYNOSAUTOV9_CLUSTER1_NONCPU_OUT,
>         .cnt_en_bit =3D 7,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
> -                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN,
> +                 QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_CNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_gs101_cl0 =3D {
> --
> 2.25.1
>

