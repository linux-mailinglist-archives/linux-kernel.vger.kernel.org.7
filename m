Return-Path: <linux-kernel+bounces-895822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E967C4F06A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD8C64E8649
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25036CDF6;
	Tue, 11 Nov 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELaVCBH0"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2336A033
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878297; cv=none; b=lpmqleymCATrcSjFDoAflwDVbuddAj8zxvdZMku6sBgzpatZ5FHhiJiriBPqcV5zyXoJuP6/WHq8CxzvDP06lbZwpoii+W9sX71LMJgkRZmDINz4sYQWfDEun9PGSz0vW+OndsXco3mIXIe6hqFkVNi448QdjRQhPZkvHANK1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878297; c=relaxed/simple;
	bh=D6r061tkwctTmLha1quZkKuh9UNyTVD9blrVtdPxe5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k05BnL8zSyrmPJ323rfpnAcHLIwh8Bx2AbH4sy0NZLZ2eHEJveGO5UWsQrd7hsdCJx7vAnxQuc71vGERVWJPqIjtfos6SXLfkarfNN91+rl+YHsXp/KAZLLers15tSWuJJ8lNeZUgTxSqBMloyfCWGGELGSL22C8o3PH6pLoy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELaVCBH0; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-640daf41b19so1429637d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762878294; x=1763483094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OObdX9pib6NpwlrND45MftVr5ZcTJI6juiOxyVxxj4s=;
        b=ELaVCBH0QXiSDc5egHC+hfc69NACMMIgLQ864xF/YF6g/k1RuKWMh/I5l4o4bS1Nth
         8E2FPD+FrrEYqZ/pY8AE3HVlTwtjVDU0Jto4uuolQ5xoYog1J+nJVmiZ0aAmaN/W/WzP
         6MlKTLEYGAYnbUgHAkrbWXpDJ8+fovOM+2XGZhQc+sQQ2UPAQ85bsPlRu2tNaMYKiyKP
         10ruqC1FuvzJt5wiFcNDAJCmWDua0WkcixK3wJIsICUOVwpsjgs+ZXupEli6JdGTJrJA
         p94lx/rnhS4lgVv1SKZcVqpN+moGz/TdXGta1P421hSkcABHMKUrpNPOfSql7x8R3+sy
         n6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878294; x=1763483094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OObdX9pib6NpwlrND45MftVr5ZcTJI6juiOxyVxxj4s=;
        b=hmHqV8vlf2Ii5HS1DgF+O04NPL4JKs1ea4KXRyJDW0aqiJjp8Hmh72c3/nJuWCecIz
         Xlajz9jcbssoq3b54wpwZ7UZ44hhyS4Us1buc2bHG4Cm/9P4U71kVYXp9JVbTXpUBQSE
         G4tg4/tN0RzwIjSaurf4N4vBs7jpirM0ALneXDb/SDUpZsaa/5PTuhZVT6wq6hb0urHz
         IOeFPkUDjcoJ5uJTGwMFMil4wJQzhW/NaCyCfHFa/fQkJVso0+HPGelVHdRpjsxZSSXC
         T80y7m4n2bDofw2R/qYCwNoaF9b0YCBfDpfpNJvs9c6nbVKm5yYrTSmLTpe4R3FHCON8
         UNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQnOX5KU4pchogZfzs1Ry+b+aok/0xxSwS7RTozMaYjyDVPMhOafJSX2Kp0hNCBMsfDCzJ5hc/cYmbUu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoD4q8sLKRMMlUc9iifN3aZoZRASpu7R3mnUHmVy8LgDtvyosU
	En8XjPfmAgtm5cS1apWa0kPVZw25fLMIq8P3WJRyxHX+L5BlpWM9hFPJiMRciXz3pniXyEw3UAf
	Q6Zfe7V2zb4qCSGex3wBT/ORpocAP5rlrlPw9nfFTGGMd/ZHY2hcd
X-Gm-Gg: ASbGncvIX1RED3ua9uXmMl8/KjBHdIIUurwqwlBHS+2mNZBcvOMnEIQw82tGFylth/L
	BEpm+gjPr6GFbZDwex7aVbigs8zf2N5w5RLEYejUAg55VHUbD8/bV+R+poFVQzYjdDEDB9vJXvJ
	TjXyYNcWv50UGfrJiO6Fz8fBQpa2eXw6U+s48DG8AKYX7U8lyKNrNv6JYm+jgNmYBnmfHjJv3nY
	GjQgZf+G9b0yNfkfVAp5xSO0564xKBKbllzJ49zOI3e0BUfJSC83UoLX/IuOw==
X-Google-Smtp-Source: AGHT+IHJmpd62CCALMSU8bf7zusT4BdJ9p+vVG2/WVor+YHRNNBx1h9njaTb9nUoDXRzsAjTTTODvx4t5ElIgqBFg5w=
X-Received: by 2002:a05:690e:1189:b0:63f:aa88:5f6b with SMTP id
 956f58d0204a3-640f733832fmr2668238d50.6.1762878293596; Tue, 11 Nov 2025
 08:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-4-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 17:24:17 +0100
X-Gm-Features: AWmQ_bmTf-MnTFtNtf3XeAoBv6oLP-Y3wG9fKzMxT4w-pivAEB1XqW0hQQcxyJo
Message-ID: <CAPDyKFpTyY+OhiGsMX35fnLT5Am5-rJnnvOfArXAhXCuSQDiLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: renesas_sdhi: Add suspend/resume hooks
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
> Add suspend/resume hooks which assert/deassert the reset signals, along
> with forcing runtime suspend/resume. This allows using the driver in
> scenarios where the resume is done with the help of bootloader and the
> bootloader disables the SDHI clocks, resets, IRQs before passing execution
> to Linux.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

FYI, this looks good to me.

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi.h               |  3 ++
>  drivers/mmc/host/renesas_sdhi_core.c          | 37 +++++++++++++++++++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
>  3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 084964cecf9d..afc36a407c2c 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -9,6 +9,7 @@
>  #ifndef RENESAS_SDHI_H
>  #define RENESAS_SDHI_H
>
> +#include <linux/device.h>
>  #include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
>  #include <linux/workqueue.h>
> @@ -107,4 +108,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                        const struct renesas_sdhi_of_data *of_data,
>                        const struct renesas_sdhi_quirks *quirks);
>  void renesas_sdhi_remove(struct platform_device *pdev);
> +int renesas_sdhi_suspend(struct device *dev);
> +int renesas_sdhi_resume(struct device *dev);
>  #endif
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index c4aaf534868c..2a310a145785 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -31,6 +31,7 @@
>  #include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/of_regulator.h>
> @@ -1317,5 +1318,41 @@ void renesas_sdhi_remove(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
>
> +int renesas_sdhi_suspend(struct device *dev)
> +{
> +       struct tmio_mmc_host *host = dev_get_drvdata(dev);
> +       struct renesas_sdhi *priv = host_to_priv(host);
> +       int ret;
> +
> +       ret = pm_runtime_force_suspend(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = reset_control_assert(priv->rstc);
> +       if (ret)
> +               pm_runtime_force_resume(dev);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(renesas_sdhi_suspend);
> +
> +int renesas_sdhi_resume(struct device *dev)
> +{
> +       struct tmio_mmc_host *host = dev_get_drvdata(dev);
> +       struct renesas_sdhi *priv = host_to_priv(host);
> +       int ret;
> +
> +       ret = reset_control_deassert(priv->rstc);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               reset_control_assert(priv->rstc);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
> +
>  MODULE_DESCRIPTION("Renesas SDHI core driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 7ceb7b977a0b..9347017d47c4 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -18,7 +18,6 @@
>  #include <linux/pagemap.h>
>  #include <linux/platform_data/tmio.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sys_soc.h>
>
> @@ -599,7 +598,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  }
>
>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
> -       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
>         RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
>                        tmio_mmc_host_runtime_resume,
>                        NULL)
> --
> 2.43.0
>

