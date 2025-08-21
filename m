Return-Path: <linux-kernel+bounces-779384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C7B2F360
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40327B60390
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809562D47F5;
	Thu, 21 Aug 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCurtE+I"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AF2D3ED2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767420; cv=none; b=qoo8orurGwmZvJr5F9AWc8xU5LVpRqzLavdhqMHePiH2F49L32D1EJOa/df6nOp5a8SSpvPbHtZOExvvOayL071Wtc8igFYeoGI8XdUTe8vrYrZXKb7o2ItABDKIOYkKlJ1H2B5b+UnmxEWYiP5Wy8XqICDjZ0qwxUnQqssF0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767420; c=relaxed/simple;
	bh=D82VoRC7SRWylLufDqwtIwGR8ekpdUz9FEgCnO2WFbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxgPbFwygBhIshVI953n9eRm6gQTou8+VSrCYbgJV3aA+w1v/Pby4phIUhxyoe5riIbRyeW1eosyhpgO7jLsnUzQA1KuyiAwPxdp+jZ7nJ0HQEVI6ievk1Eimh5vOfmIcNAxpbEvAZgk23dGSITpV+hddRjtmYUSNjQj/+cgwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCurtE+I; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d608e34b4so6475817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755767417; x=1756372217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1lvOZzEeeYujPTiqMkU/SfYwhQqH+4WeDtoyp2UpLg=;
        b=CCurtE+IKk3lcEafwRYm4YRP382FLnrshMZnWAtk5oCwjKnLjcVG2KaDeAjiKSZPnA
         /P3G/vXxakZk0yIqxHW/T1G4UZlHaj3Hx5xus/3znvoxlFsFLZlbqg7qy3bIwrkHCMnu
         OdOCYQHcoVPFvqWuBDp6jiYM7yV8yAnBAXmSZ3lFeHFXeIpiZfCrP6kMaHagmomw//vK
         FpL79rJ2Rh3O9MC0yUx3MRmUBqcC7n5fGTudZxzlyy6uhuR8g/bCWogiWYE8YcPC7ze1
         a+MkE+m5VroGgXhcXT3Gi3hZ7na1nG+XVZIjDkNOtoQRloQa/2gyS23X7M/4SOXbTDKq
         dDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767417; x=1756372217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1lvOZzEeeYujPTiqMkU/SfYwhQqH+4WeDtoyp2UpLg=;
        b=SZACYMTkAO6e0s165m8ZJyW/nnIAnUzD/ElhjGp2JV7siDQ5HiB025f7LF3NhL271a
         K8nX5aN7MofN6KKjL/2jHDEHFjnmrChrP0CFIYlKxseqJ32DFcqx6Uciv5+1PvD9oSWq
         n8MSlq/hdhrnHByICddWEt7BDbXvvTR4YqHvVUR7midgnYrHCDfeE6wb/NIxunaNJQNM
         fKk5UK9emRBwEkuDx1XSs2ptYUqbnLs+O6+rBq1e2bXbvdMHuLBSDbJ/G3UvXYL/yljP
         qssgmO5e0kGXMLBBvbSF/6AsSDOEQL8sWDaWObI0qw/CXOxdJh/T7tqFcRTinRPfkFnc
         Xayw==
X-Forwarded-Encrypted: i=1; AJvYcCUJafJOSjaB3YlegfgqUot0YJ9l1c4Z+tjtP5CqkPvXKHWTXt1T9S97w4KmTRskXIagtSWlVCQN4aMQ5ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrzPq019Y5dUhShQldua+Mqw6/DEUP4PlR8ptItA+uJfw5f+3
	zhmaWzjvUcJ+ne1RO75/OggIj8zAZwE3mFec3JwzrtzIsPvZG9WpaxZDi/tdsagiMd1y2QEYV9D
	gAaTaYSlq2ocAEO5VPg0vBphX0rEJIo+8kHehWhHwiA==
X-Gm-Gg: ASbGncuA1BkD2fEx9jYCi1I/v0U9lkamYt6+dm5WcZRGGgDox74BH12McrKqKNs2n0X
	/gTUZ6j69K35C3+geP/xBQtIzq5thHgYPX/FRdB20gwNrMNe+f4BQWzT0nmSooHn7QDdC4M+1oY
	37NhJEhzHMOelpDaqTrI/JKBd9wgqNk+fAlasPE4zcUsdFBHIYlfyVSy6ZESowuf6I/5fNOrsH6
	Jj069Rq
X-Google-Smtp-Source: AGHT+IE3XPrdY1rmSoGIfTQNp7AUzGanhZ4zCUcabEi/3a6ztGvU4JGCxFLz/vEHwGrmJU6OeC1mGQpm8phPeetSBnQ=
X-Received: by 2002:a05:690c:4b90:b0:71d:5782:9d4c with SMTP id
 00721157ae682-71fc898b54emr19133007b3.28.1755767416917; Thu, 21 Aug 2025
 02:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820193047.4064142-1-jm@ti.com>
In-Reply-To: <20250820193047.4064142-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 21 Aug 2025 11:09:40 +0200
X-Gm-Features: Ac12FXz4cH776JgD7usSy98yaTqfXnx9d_ZVcbURZjgYhcQZQ3WKM_XhUMd5FsQ
Message-ID: <CAPDyKFqvf6CJfm52F0_wJj8xxCKDv18b1T+i8zm2rsdBiAqUJg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 21:30, Judith Mendez <jm@ti.com> wrote:
>
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Fixes: 37f28165518f ("arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Judith Mendez <jm@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
> This patch was separated from [1] since it will be merged to
> different trees anyways.
>
> Links:
> v4: https://lore.kernel.org/linux-mmc/20250819152854.3117844-1-jm@ti.com/
> v3: https://lore.kernel.org/linux-mmc/20250818203310.3066985-1-jm@ti.com/
> v2: [1] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
>
> Changes since v4:
> - Add fixes tag and cc stable as per Ulf's review comment in v4
> ---
>  drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8a099508b939..ffc45930c240 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>  #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>  };
>
>  struct window {
> @@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +       struct device *dev = mmc_dev(host->mmc);
>         u32 ctl_cfg_2 = 0;
>         u32 mask;
>         u32 val;
> @@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>         if (ret)
>                 goto err_cleanup_host;
>
> +       if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
> +           host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
> +               dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
> +               host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +       }
> +
>         ret = __sdhci_add_host(host);
>         if (ret)
>                 goto err_cleanup_host;
> @@ -882,6 +890,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         return 0;
>  }
>
> +static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
> +       { .family = "AM62PX", .revision = "SR1.0" },
> +       { .family = "AM62PX", .revision = "SR1.1" },
> +       { /* sentinel */ }
> +};
> +
>  static const struct of_device_id sdhci_am654_of_match[] = {
>         {
>                 .compatible = "ti,am654-sdhci-5.1",
> @@ -969,6 +983,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(dev, ret, "parsing dt failed\n");
>
> +       soc = soc_device_match(sdhci_am654_descope_hs400);
> +       if (soc)
> +               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
> +
>         host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
> --
> 2.49.0
>

