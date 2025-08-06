Return-Path: <linux-kernel+bounces-758154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F3FB1CBB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5E73B9689
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E471FF5EC;
	Wed,  6 Aug 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDSyCmDu"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB91FF1B5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503702; cv=none; b=DZIuPkB0AGf/GDdEXzs4ll1w8SZv4VrZvOeZZAaqXkuSEFs0CVge8dja+SZO3rUoz28Jv//TNJmARm5k4UfPWksixr56FkF0XZkd/O3idarF6P0XDVN0UHQYfquCQQW+RTTBBuWA+U6f99w4MHSGhaiiW41e/pKHk/BJJsabJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503702; c=relaxed/simple;
	bh=kc9keBH0hvOHfAXjDx3bZTlAEhj8hxPUYfFUTHJ+WOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBqbxQYmpfcBGE0dOvdT/lVZCQ49oh6VSjp3B3puL3MkvWN6giAnOIYVZqCoNr2xGpeVWFZzdQruaRnhJuckw0taqEZn5aR0CHd4UrKcbpMarTNPBYXCk8XbPfI4GpFY3iMUbZyfMkHHaz7LMqGvXfYLJA66y0hFvVQZLAh3CGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDSyCmDu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8ffb1c5f3cso163797276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754503700; x=1755108500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeiw/igg3VRkIFQpTb1DWvr2tgsyqZV4hPeCuzYTAzA=;
        b=nDSyCmDujpVKfvvXxzQ2fa+N9sXdlrTXqtYX8hVwMR26kYaTYEYuxLWVVVjQMZXCXc
         qRFDfGmQ0YDFRy5CXjU5Y0LCxke8k368+L3sQK7u2cJJ6MiZ4yrj4vud3HLt16mIfkVQ
         +nr+BmdhlxFZbuSm2r6MrwPGUAP7EQ95km3Of2TU5THSuGyN2YaR2Ye4Sx1GC7IexSCR
         1Lx9FnBBgwZ8sJ2Vk5ZiR6xoTb/k09spwpK2AkPJ+0XxaOqmeXQnMBJZI20IN9y7ykLe
         asqM8XioOla0/7J7AT9uRMCQdltmVAJttI+WkbPohG2YEnWh0R4iDNl0Bw/Wjid14gnn
         iFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754503700; x=1755108500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeiw/igg3VRkIFQpTb1DWvr2tgsyqZV4hPeCuzYTAzA=;
        b=JOBYvAlvjLWMDJzOKUurbu4Fd/ltftyTXlo9jVIDWYosm06QZlcVvctUWZv3YnfGb9
         p0XSycmgA1yVdrG7qLMUbRGi2J0EciMrUvu23KBLn25kZ9Uag8wT8vy95o8xqSo49ePk
         ofSmWQ5KQoZWq9GQYtgRaBytuWe3prNqMdcJV7HbjH3StYl57gaN4mdnT7/ZTp/fbU9N
         v+Lyuo81k7MRa/m4kLQ8IzgHjDmlbgygNxfUyJUaqzakOC7MBVKdRjEUsPERFGPJl7wJ
         KKR1/sv5uTyVHxPeZYkVxSw2fDPGh4WOOoxzDMc1f+JTvUwBkqKgZtmk+P0hbW7xP9u2
         CM1w==
X-Forwarded-Encrypted: i=1; AJvYcCXPXDcbXLgkLCNYVIS10Xni/k05GuwTCbQwES1zh2Z+RgdqLqZo2BelN9EYYNa/n+uG/tv9D9XwmaCxxgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIbUE0SaSQw4UcSZBp+VjPG9EMotnI8p6l/nHLIK+ZdNsfPjT
	+vlfPEbIull4QTOaq6T1ALBBajvdzU7WurW3FkZ/BuKksXix23ZWFSwdzP15JWwuHlNIELHTxq5
	s+ySAiIxIJmBuqIEZoScPUvIMhd5JXYE1cxAFeUeB3Q==
X-Gm-Gg: ASbGnct64Q4jIfHgNaM+HV2CRjSB3FSLIQvpWXHzPD2ZkFr3UYst8h+MukW6PBfCS1m
	LKc0zDD2aT3Rnr8exrHi4YMSC4RIan6zmYQtUml4vZwzTMO6A0upVT7zzSpTY1wSIqCZfWQFTWI
	yEFG7sFFUWrGEVX9AgALY258enNGgy2GFb4y/GCDmasMoU2tYy+nOFEICNs1LFXRmTZTQ4Tw0XI
	P320Q==
X-Google-Smtp-Source: AGHT+IFljVcbKKiD4Y8odlIXjBBnYAePfAKr/sOc5LqjcBRdGaAhcUOQ5sCog6SPAwBGoi0fdvXwkpzJhgdnQl3q8ms=
X-Received: by 2002:a05:6902:4310:b0:e85:ea52:8b with SMTP id
 3f1490d57ef6-e902abde969mr3799149276.22.1754503699782; Wed, 06 Aug 2025
 11:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250806070030epcas2p3f2b0c36b6c492629e50e76be469b2db3@epcas2p3.samsung.com>
 <20250806065514.3688485-1-sw617.shin@samsung.com> <20250806065514.3688485-5-sw617.shin@samsung.com>
In-Reply-To: <20250806065514.3688485-5-sw617.shin@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Aug 2025 13:08:08 -0500
X-Gm-Features: Ac12FXwS1WG6f5yuQagZd9mQDHAbqfGJ1tb9fpDSgy50MD5AWOvIXyjEOgbaPAg
Message-ID: <CAPLW+4m2S5jAJ4xas_r69AUHFENOrr=4-ZYUgtrqQ5aJgetDng@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] watchdog: s3c2410_wdt: exynosautov920: Enable QUIRK_HAS_32BIT_CNT
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
> Enable QUIRK_HAS_32BIT_CNT to ExynosAutov920 SoC which has 32-bit WTCNT.
>
> Signed-off-by: Sangwook Shin <sw617.shin@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/watchdog/s3c2410_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index 673ab6768688..541870b4d01a 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -357,7 +357,7 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov920_cl0 =3D {
>         .cnt_en_bit =3D 8,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
>                   QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> -                 QUIRK_HAS_DBGACK_BIT,
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_CNT,
>  };
>
>  static const struct s3c2410_wdt_variant drv_data_exynosautov920_cl1 =3D =
{
> @@ -370,7 +370,7 @@ static const struct s3c2410_wdt_variant drv_data_exyn=
osautov920_cl1 =3D {
>         .cnt_en_bit =3D 8,
>         .quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET |
>                   QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_CNT_EN |
> -                 QUIRK_HAS_DBGACK_BIT,
> +                 QUIRK_HAS_DBGACK_BIT | QUIRK_HAS_32BIT_CNT,
>  };
>
>  static const struct of_device_id s3c2410_wdt_match[] =3D {
> --
> 2.25.1
>

