Return-Path: <linux-kernel+bounces-895821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2ECC4F05B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C099F3AFF76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70EC36CDF6;
	Tue, 11 Nov 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC07iDMz"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60936C5A0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878194; cv=none; b=nPJi3teX56YwFty/0dcZUzRhWbHgoU/fN4s947s1u9/m/oPkthtlv/x+PRx3Mlio1NLAdtSbub06xAaHmkaj/OaQzr/8tVMBaKOCgyYCXIjpmZuGfrCr6v79uMf3VCdmHI+foXhWdxmbIZCdjW6ArGp9epcZ00sdZwb4jfa7xSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878194; c=relaxed/simple;
	bh=XLpA0EYpR5zzkaJHl/CV48qTdO1WTdqSNFnTs6ePeII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv+FU2oyLdeVdr4AOE558cbSo10Vw7GswvEAtzPwEKry7UqFQUYns5Eoz2BhFx1qp/nKJCY++00svykJ/J5zRxi5FkxyV2KjRbc+RXiHmfuyDOf+0fLXdQG+ag9+z5ooURrAuOGRdPcCKm2Edrj5aq/dADy5Sd4Td2MgQVoLpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cC07iDMz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-787eb2d86bfso26075287b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762878191; x=1763482991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aKHoe4ZUftCieGZc+VBEpPhpv2xgJIE+8PlicL/y9wM=;
        b=cC07iDMzDDWQfQiinfTnNlNdkZgVgmFUMTk/7L8Vs0Q5ChHorZRuYgayt6JPlKX4F8
         G8OwrTAkkeG+SYNMBZUORV1v01u2Yir2h+Um0q8ss/vr/fjlQx9iDZjoXMVhNoL0eNWo
         VHijvgnef61AllVJmCBaACmiwXz7538ZMuHAgCuqWXEhEVQyFAdoljqAzlELYDdjs2gN
         x5HuPF4BG7GARxwvfhGoU0qlAXRvbAhlY9IrQBjbFHVZLXwQbPdSe4sxUH0I+SfHnz4T
         /OwlitxwecDsSA8XHC/I/rouREtCl+XVqtoDqrZU2lPX5LuKVPYSEyc5qrdmpdfb2K6w
         287Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878191; x=1763482991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKHoe4ZUftCieGZc+VBEpPhpv2xgJIE+8PlicL/y9wM=;
        b=b+EFRnycz83vXpeiBLaTwK+HLToX5HMRHf0selKu6ZkCQgveFE1pTxhnlsJvrQfCQr
         9FMLzE+ZEXObynZuqkKkd+vnU1d3p3QS5DfMiAwmVubClIpxcUqNJTSNVftaq+67qbgd
         eVrQ+inQaWnsBDMveFuGsSpPLtlBTZsYSTK+RB3C8RsMAHNuICv5hn0Xdgm60IiPk95n
         CZiXceNnA4IDIADi5KO00AczT3kURVTOj71E26kH1q6HKiE6CZj6Ah8bSgurg1MQ9SdC
         GSjVFK2RDRv94aczSwlCZF0MAqgzLPyZKROd8d5NRQ6w9H823BAiyG53iyqMgAiBIh0J
         d6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXT1S67/w9T/iRFCWSWf6d26Evgu5KqpiSxQUYDY6JdpTcX+m5PNStOuKsOE3IXxeAlIA6O1oBEE4WusBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaht5FJNKsCvZ6yAgH4/IzO1VWun1+Eh4S0cfc1xV3p5l/gnF
	vKXUPNXjjU0Dq4b7u0sqjngUfys8MaOX+2k3QXG1zAwAGsUfaZI7BuYMFMYXFjF1n3gHDCxcbkw
	IpxPv+OI19oVV1MFgSygwe2YdQdGz9v6n6HtbBwOVIw==
X-Gm-Gg: ASbGncv+Hp/nxvXOjRNAKyvDFGCPenEiRnIjpoVpOZfbEtTwXHjJoYtq04oMYXDfKEs
	fIdCJo7utcXxohoa344ZNLB+qKOWnMH2J5EwOKld65ffO3UgUQVQUH+wrDi/Nwlpm7hfTi0yq+Z
	g/496tB7p8C2WpkIzlqCYWfSKvVaF5SvMz7hIgOq1rU3TiaFA1UZWU2VnsnB9FbgnXlMQolgue8
	htodsQ+4DMe78V8yGzmMJI9XnEYdjfm6OayTnTJEzgeq68EKd5bN4Py06FsL5edCZSaL0IR
X-Google-Smtp-Source: AGHT+IHoQJuVlfR9zMeIjwFbdHyeRQTWRolkki2DvpnTUSRyJF5SQPQubSTTdGS99udcI0gt7LdJrt7VWnXSm3e14Rk=
X-Received: by 2002:a05:690c:360e:b0:787:e3c1:99 with SMTP id
 00721157ae682-787e3c1484bmr93601677b3.57.1762878190703; Tue, 11 Nov 2025
 08:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 17:22:34 +0100
X-Gm-Features: AWmQ_bkUAFq5YOr6A8R1RiBxjuQKLYXMePQi6OIcghsKKf0GW8rB8B1X1sNOzgk
Message-ID: <CAPDyKFpFYeD9tLA+w4NARKq-Wj-7O2Caa3y8i2Z9NX6J4XLahA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 06:25, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
> and require __maybe_unused protection against unused function warnings.

I don't see them marked deprecated, is that really the case?

> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
> the compiler to see the functions, thus suppressing the warning. Thus
> drop the __maybe_unused markings.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Other than the above, this looks fine to me!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
>  drivers/mmc/host/tmio_mmc.h                   |  2 --
>  drivers/mmc/host/tmio_mmc_core.c              |  2 --
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 9e3ed0bcddd6..7ceb7b977a0b 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  }
>
>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> -                          tmio_mmc_host_runtime_resume,
> -                          NULL)
> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> +                      tmio_mmc_host_runtime_resume,
> +                      NULL)
>  };
>
>  static struct platform_driver renesas_internal_dmac_sdhi_driver = {
>         .driver         = {
>                 .name   = "renesas_sdhi_internal_dmac",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .pm     = &renesas_sdhi_internal_dmac_dev_pm_ops,
> +               .pm     = pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
>                 .of_match_table = renesas_sdhi_internal_dmac_of_match,
>         },
>         .probe          = renesas_sdhi_internal_dmac_probe,
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index c8cdb1c0722e..b9de03325c58 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  irqreturn_t tmio_mmc_irq(int irq, void *devid);
>
> -#ifdef CONFIG_PM
>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>  int tmio_mmc_host_runtime_resume(struct device *dev);
> -#endif
>
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 775e0d9353d5..8be642f737c7 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>
> -#ifdef CONFIG_PM
>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>  {
>         if (!host->clk_enable)
> @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
> -#endif
>
>  MODULE_DESCRIPTION("TMIO MMC core driver");
>  MODULE_LICENSE("GPL v2");
> --
> 2.43.0
>

