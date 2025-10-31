Return-Path: <linux-kernel+bounces-880328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB28C257DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189E0567BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB234C805;
	Fri, 31 Oct 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="biKwyLaO"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAD2376E4;
	Fri, 31 Oct 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919709; cv=none; b=h+tmyUpD7LSeZ007V4gNqhx82yotvE4bY49t9LHuDbQHXO3MYUYZAQ3NuljRZolAMzff9lYiN87vUHoVj0seJexO1dq2hYKhnMKcqiNcbXvYx+tfvIsbbDkAYMga7sGPn8ZoE+LMXX90GDI9SsBodm+f0zGB56QkpjjkbA/nIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919709; c=relaxed/simple;
	bh=5x0SpARr82oCUIj68hOmYBrrZLzxCT+c/NeLlsZAfIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqITBScBZFHA33Km5VtUnQKHe4IK7To3l9jApAGOxPuN60Cguy31A7jMWPdk1tRDuyZyis0sQAO7bYo2x3DJ+sFIJg+Mcaons5SVjnt/IEVkhyzK10sBkn0wh9HRVMpR6eAhPmz9LmWaIyjz2v80yM39iXWl5RxM3mI2oCEHfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=biKwyLaO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7E80B1A17AE;
	Fri, 31 Oct 2025 14:08:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5065760704;
	Fri, 31 Oct 2025 14:08:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 140231181802A;
	Fri, 31 Oct 2025 15:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761919704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ci64dNp7Ibis2i/eDGgvFReh/1JPhPjaLxNW8VyjZF0=;
	b=biKwyLaOy+8ejM1UWURmHDSmDM8HdkPsW131Pt/PGYI1Hfi4kfTWAOCQovXlUJoCngrX/O
	1oNYtcd051IgNp4hpTTmvU1MTzbdXLhdcm1vsRux1bJlpviOVRn54bO12rc/MfzwWLJKTO
	VJ77Q+mthIKNaBHF4UA0wrSrc+ZyapS3rfrgaCOunMjZRNydQiA7RDoEuALJAVpzKFqq6W
	37AsJZvBQda4XPRkXmXh5KJKcFkcAHUedS98DqVn5xTBeIAu2jClb7CXA/NimUlbbbX1hc
	g//47WU8SC/CMsSuU1uccZ9FyclpKHhRE508PXU3kWjMJIzzF/DtPaGJm9RFEg==
Date: Fri, 31 Oct 2025 15:08:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/6] rtc: renesas-rtca3: Use OF data for configuration
Message-ID: <20251031140818ebce1763@mail.local>
References: <20251021080705.18116-1-ovidiu.panait.rb@renesas.com>
 <20251021080705.18116-4-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021080705.18116-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Since the RTC will never be used for PIE (we are using hrtimer), I guess
this patch is not necessary, instead, you could simply stop setting
max_user_freq.

On 21/10/2025 08:07:02+0000, Ovidiu Panait wrote:
> Prepare for adding support for the Renesas RZ/V2H SoC RTC IP by making the
> driver configuration selectable via OF match data.
> 
> For RZ/V2H RTC, the maximum periodic interrupt frequency is 128Hz instead
> of 256Hz, so add this info to a SoC-specific struct and retrieve it
> during probe.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
> v2 changes: none
> 
>  drivers/rtc/rtc-renesas-rtca3.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
> index ab816bdf0d77..90dda04fad33 100644
> --- a/drivers/rtc/rtc-renesas-rtca3.c
> +++ b/drivers/rtc/rtc-renesas-rtca3.c
> @@ -101,6 +101,15 @@ enum rtca3_alrm_set_step {
>  	RTCA3_ALRM_SSTEP_INIT = 3,
>  };
>  
> +/**
> + * struct rtca3_of_data - OF data for RTCA3
> + *
> + * @max_periodic_irq_freq: maximum periodic interrupt frequency
> + */
> +struct rtca3_of_data {
> +	int max_periodic_irq_freq;
> +};
> +
>  /**
>   * struct rtca3_ppb_per_cycle - PPB per cycle
>   * @ten_sec: PPB per cycle in 10 seconds adjutment mode
> @@ -709,6 +718,7 @@ static void rtca3_action(void *data)
>  
>  static int rtca3_probe(struct platform_device *pdev)
>  {
> +	const struct rtca3_of_data *of_data;
>  	struct device *dev = &pdev->dev;
>  	struct rtca3_priv *priv;
>  	struct clk *clk;
> @@ -718,6 +728,8 @@ static int rtca3_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	of_data = of_device_get_match_data(dev);
> +
>  	priv->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> @@ -772,7 +784,7 @@ static int rtca3_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->rtc_dev);
>  
>  	priv->rtc_dev->ops = &rtca3_ops;
> -	priv->rtc_dev->max_user_freq = 256;
> +	priv->rtc_dev->max_user_freq = of_data->max_periodic_irq_freq;
>  	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
>  	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
>  
> @@ -875,8 +887,12 @@ static int rtca3_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(rtca3_pm_ops, rtca3_suspend, rtca3_resume);
>  
> +static const struct rtca3_of_data rtca3_of_data = {
> +	.max_periodic_irq_freq = 256,
> +};
> +
>  static const struct of_device_id rtca3_of_match[] = {
> -	{ .compatible = "renesas,rz-rtca3", },
> +	{ .compatible = "renesas,rz-rtca3", .data = &rtca3_of_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rtca3_of_match);
> -- 
> 2.51.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

