Return-Path: <linux-kernel+bounces-777611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EF8B2DBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CCB5C03FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD882E5D39;
	Wed, 20 Aug 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZgPlLyC"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F202DAFA6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690680; cv=none; b=omg1KQ/FpFoxFhSmJcqk7yvWsspiI60qxQ/krtrtmScZyzXsXQQhnYH85jpRAtREt7qDFs7XPKyNRRcMnQpWxazVofDFNP1UBeWMQ3Nbuc0tPg9usQ3Dyd0YZrvKVZAqemjvAC1nEmeLTEkEcVAionru+/VTavZLcQtwPvjKMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690680; c=relaxed/simple;
	bh=GkRRgy9PjHfoh+Q0+YrLwiAPxuPpcGqjLCT5hHVfmIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OajLHkszOAyR4dW0iCEr+Iql8ABnq48ZxKYJLB1Ks09VcYtHjQudUgGS2ZYpX7C/UB7g0hxWdCf6lG0/VQdacoxJkdUYLXbxEya8dcUzoM4K6X5ehjwfuzyzKWKJNTUdhl/O4IdmrYHOvoYkRaOPoVbmNI/QIAeLiUkVOgFRSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZgPlLyC; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e93498d41a1so3272383276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690677; x=1756295477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOsgMtR2/WTXb6MvEREQsGNGK5lblKBRRgtakM80Wd8=;
        b=sZgPlLyCdtLC9EKLQorMMr155TAtQpbq7zMgKLgITRaOCT6mRAdUYBBimU5Mt5CFU4
         KuDRvn/d6feIJN1Mmlh4WNCEpVYbXDUU2AF4Cz2QBzmYMj99gBhF7EgiyMoeSKAO/IFA
         Yuk0uwe6x/WCVTlLAIAccr/WNyOOVfzbW+cnu8E8KSbVQ4+iNpl+HpPgVoBghFnNgsQc
         KnhfjTdrdP284tqm87j/QNiubTLLWfDgCTvR0wePGChItNNpEKtD0pw0QVMrMnoo43FJ
         C2BEN4hPEBAGPFai7ZKVVRM+uEs+s1iSisBzt91cCK3ttgsBJJW1/a3VsvuJz84NAKAg
         Euyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690677; x=1756295477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOsgMtR2/WTXb6MvEREQsGNGK5lblKBRRgtakM80Wd8=;
        b=faedNCkJ0LEJnb2AsuDpaujTIMHXIpJHLflFkL63YXOfuLKYR49L4NBzYjsbAvCZ4h
         H+jKUMwqAMP1z3Wy1SdFnkroTeMPCuzCF38yljSG0MYGalItLMqxN4pRndh+YEiTiSH8
         9rJHVyEeRTm2xnp6wL4BE13S0nfjYLMGSNO+mDGCe1vlap6WcN+SHiTR5ukCEYcIFESw
         le7sJp4uJqj90MVhbgDCXo/GBU8IDITA1V8dvHozbSCVscmq3z1Ra7piDWxfyWAUxCK2
         8vk8tas2PrLeBIMOoTwIfQsbTkNpDFtcGyAV03CKCIUHcSMzMqScI7YCkQ/EkcJmF+8v
         WKOw==
X-Forwarded-Encrypted: i=1; AJvYcCUWC7CKOB6aDqQ0GlgOa12ulcydPWMBG3H2KADtZNRCmU0scdOVoFiWMR863b/tA1sEvx3imy9y+Y9H+eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVBGVIBOBp7scJneJSCVQk3aLz61B9DWwIlmjF/YbB73G6x8C
	bZDEEW0kvaf4zPRTmvHYGL+wbQIQ3b9oFXJ3XFf/CXNK61tJH8dl9k6TXU28uJwB0uM5GHdgPEI
	QVQ6N4kW4dgeqP8wm2/0F1Mz50/Vost0YQaLop5meGieNP8I6Fg9rUEw=
X-Gm-Gg: ASbGncsvYJQhh23OtGFGsMqyM3QUOQo8d7ySyXgIdqHF3vXXwpvcsbowM1F8cgEqo0Q
	8NccBr4c0XLes4ZVBJF0JmI20w+x8/vD/ZPGtWGi2h8oXDXC2SDOQrcF4/x8cpJqKblzdeb/4bB
	EIaWwGPN53s54FSdygZGACZsz3N07XJJpPzL45zAeJiRjXcLaivubauzME4jvfCOY1r+P3lRwPK
	/g3pc8A
X-Google-Smtp-Source: AGHT+IFGfpVZuf3qC5EwO7N/indwc+AUht5SzBeVXUI0oDlfLcte6yMTGB1r05G/DM/oXcm+DnSY1lfzmVJ5h4x9n4k=
X-Received: by 2002:a05:690c:34ca:b0:71e:80d8:19a6 with SMTP id
 00721157ae682-71fb322e461mr30240107b3.39.1755690677411; Wed, 20 Aug 2025
 04:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814130705.326073-1-o.rempel@pengutronix.de> <20250814130705.326073-2-o.rempel@pengutronix.de>
In-Reply-To: <20250814130705.326073-2-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 13:50:40 +0200
X-Gm-Features: Ac12FXxQ9EMTp1sCAGjq-qr2qTOkgH5lah9fdjpdw1ORTdJZWly8BaMXPgEYQP4
Message-ID: <CAPDyKFrGcux7US6SQmHSbREqqSyHbzYuxRMgvm=256214Gf=NQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mmc: core: Add infrastructure for undervoltage handling
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f14671ea5716..5f0ec23aeff5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -564,6 +564,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
>         timer_setup(&host->retune_timer, mmc_retune_timer, 0);
>
> +       INIT_WORK(&host->supply.uv_work, mmc_undervoltage_workfn);
> +
>         /*
>          * By default, hosts do not support SGIO or large requests.
>          * They have to set these according to their abilities.
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..7dc0a9339c5e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2370,6 +2370,7 @@ int mmc_attach_mmc(struct mmc_host *host)
>                 goto remove_card;
>
>         mmc_claim_host(host);
> +

White space. Please drop it.

>         return 0;
>
>  remove_card:

[...]

> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..0d2685365c6b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
>  #include <linux/debugfs.h>
> +#include <linux/workqueue.h>

We should not include header-files from header-files, unless it's
actually needed. In this case, we can do a forward declaration
instead.

struct notifier_block;
struct work_struct;

>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/card.h>
> @@ -342,6 +343,9 @@ struct mmc_supply {
>         struct regulator *vmmc;         /* Card power supply */
>         struct regulator *vqmmc;        /* Optional Vccq supply */
>         struct regulator *vqmmc2;       /* Optional supply for phy */
> +
> +       struct notifier_block vmmc_nb;  /* Notifier for vmmc */
> +       struct work_struct uv_work;     /* Undervoltage work */
>  };
>
>  struct mmc_ctx {
> @@ -494,6 +498,13 @@ struct mmc_host {
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
>
> +       /*
> +        * Indicates if an undervoltage event has already been handled.
> +        * This prevents repeated regulator notifiers from triggering
> +        * multiple REGULATOR_EVENT_UNDER_VOLTAGE events.
> +        */
> +       unsigned int            undervoltage:1;  /* Undervoltage state */
> +
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
>
> @@ -659,6 +670,9 @@ static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>  int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
>  void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
> +void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
> +void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
> +void mmc_undervoltage_workfn(struct work_struct *work);

We don't need these to be available outside the mmc core, hence please
move these three to drivers/mmc/core/core.h instead.

>
>  static inline int mmc_card_is_removable(struct mmc_host *host)
>  {
> --
> 2.39.5
>

Kind regards
Uffe

