Return-Path: <linux-kernel+bounces-786377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A91B3590C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3D894E3F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D99318130;
	Tue, 26 Aug 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vsHOjsuo"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67131355A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200914; cv=none; b=S7X2lXFAoWrn2mdPAEcik95ubn1lwJ74atsWGIS7t21WpjjvAg5P2Wlx1C9xWxn1dOSYqnv5ynilslh/2oRn+a/W0Z1Ojcc3bnraFdn4gBYcMmtjRPov92J5LDn5uI4pV4I6l/0srmutLvg7xa18XBFM+fpfppf7HAkftA1ioU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200914; c=relaxed/simple;
	bh=fdZgM3WflRcC+hu/bczGlPHZ0Hxw4lmrZyKRZj80RRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q0X9j2R9zbC+pbeyF9levdkaTz7HdC29ZHIAP8v8H+8yo/SYL65oTUbowPlws538U8l8UruzRiZLSb6jcNDq4x4vCx7QlzbI58ZUg0r471IDMxbi/64imsIL3I9dFAzisGCMqTNexuSBzFgy4I485U2XolinVSz1OX7m6zmloCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vsHOjsuo; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q9OMZc003268;
	Tue, 26 Aug 2025 11:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	UOJpXuRKyIDPDo9RP10Qp7ElMiMthL8KDIbk8MrSYgQ=; b=vsHOjsuo4ruMy85Y
	sDbFFsusydzOyJwrK+zpRDFBlrEN51Ad8+JuilsQXc10qWi59xWXsXS4SxKiO4gG
	QcEFiCoImaOuVdkCsUmJ3mtP7WlKojT03qx0Iti2DSp08PAWPq3DSA7krmiW/CM3
	OvaWMBamX2oj/XlR8NLfdXTa5LVnPc396xDblHbLojNe8PAo+m05eeDsOm5GrnHa
	eGkSCnQ5srVTe/CM0UAjYn54sMFCEklKhMg0zNb81ezlgTrE+H/PO5YxfHJHAR3S
	Fwfn0pRSDWg/njlCQWaXUAGRwdtn7IHNBnzdlKs2fJFUD1m2ZPYzhqHGB3ry/O/K
	iUUYrQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5tstmtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 11:34:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C2E6440046;
	Tue, 26 Aug 2025 11:34:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57DE75E449C;
	Tue, 26 Aug 2025 11:33:30 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 11:33:29 +0200
Message-ID: <000f67ea-8d1a-4b04-a5e6-60bcce4390af@foss.st.com>
Date: Tue, 26 Aug 2025 11:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/arm_global_timer: Add
 auto-detection for initial prescaler values
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Mendez, Judith" <jm@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20250819-topic-am43-arm-global-timer-v6-16-v2-1-6d082e2a5161@baylibre.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250819-topic-am43-arm-global-timer-v6-16-v2-1-6d082e2a5161@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01



On 8/19/25 09:52, Markus Schneider-Pargmann wrote:
> am43xx has a clock tree where the global timer clock is an indirect child
> of the CPU clock used for frequency scaling:
> 
>   dpll_mpu_ck -- CPU/cpufreq
>         |
>         v
>   dpll_mpu_m2_ck -- divider
>         |
>         v
>   mpu_periphclk -- fixed divider by 2 used for global timer
> 
> When CPU frequency changes, the global timer's clock notifier rejects
> the change because the hardcoded prescaler (1 or 2) cannot accommodate
> the frequency range across all CPU OPPs (300, 600, 720, 800, 1000 MHz).
> 
> Add platform-specific prescaler auto-detection to solve this issue:
> 
> - am43xx: prescaler = 50 (calculated as initial_freq/GCD of all OPP
>   freqs) This allows the timer to work across all CPU frequencies after
>   the fixed divider by 2. Tested on am4372-idk-evm.
> 
> - zynq-7000: prescaler = 2 (preserves previous Kconfig default)
> 
> - Other platforms: prescaler = 1 (previous default)
> 
> The Kconfig option now defaults to 0 (auto-detection) but can still
> override the auto-detected value when set to a non-zero value,
> preserving existing customization workflows.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Changes in v2:
> - Rebased to v6.17-rc1
> - Link to v1: https://lore.kernel.org/r/20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com
> ---
>  drivers/clocksource/Kconfig            |  4 ++--
>  drivers/clocksource/arm_global_timer.c | 44 ++++++++++++++++++++++++++++++----
>  2 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 645f517a1ac26d0c12d4b2b46591321ddf6e20b3..92df191b25b1af339dffc791f81ff541b09a87a8 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -395,8 +395,7 @@ config ARM_GLOBAL_TIMER
>  
>  config ARM_GT_INITIAL_PRESCALER_VAL
>  	int "ARM global timer initial prescaler value"
> -	default 2 if ARCH_ZYNQ
> -	default 1
> +	default 0
>  	depends on ARM_GLOBAL_TIMER
>  	help
>  	  When the ARM global timer initializes, its current rate is declared
> @@ -406,6 +405,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
>  	  bounds about how much the parent clock is allowed to decrease or
>  	  increase wrt the initial clock value.
>  	  This affects CPU_FREQ max delta from the initial frequency.
> +	  Use 0 to use auto-detection in the driver.
>  
>  config ARM_TIMER_SP804
>  	bool "Support for Dual Timer SP804 module"
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 2d86bbc2764a04944e453038013142b2495d26b9..5e3d6bb7e437badeba45d8bf2c1df14eb3427448 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -263,14 +263,13 @@ static void __init gt_delay_timer_init(void)
>  	register_current_timer_delay(&gt_delay_timer);
>  }
>  
> -static int __init gt_clocksource_init(void)
> +static int __init gt_clocksource_init(unsigned int psv)
>  {
>  	writel(0, gt_base + GT_CONTROL);
>  	writel(0, gt_base + GT_COUNTER0);
>  	writel(0, gt_base + GT_COUNTER1);
>  	/* set prescaler and enable timer on all the cores */
> -	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
> -			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
> +	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv - 1) |
>  	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>  
>  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> @@ -338,11 +337,45 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +struct gt_prescaler_config {
> +	const char *compatible;
> +	unsigned long prescaler;
> +};
> +
> +static const struct gt_prescaler_config gt_prescaler_configs[] = {
> +	/*
> +	 * On am43 the global timer clock is a child of the clock used for CPU
> +	 * OPPs, so the initial prescaler has to be compatible with all OPPs
> +	 * which are 300, 600, 720, 800 and 1000 with a fixed divider of 2, this
> +	 * gives us a GCD of 10. Initial frequency is 1000, so the prescaler is
> +	 * 50.
> +	 */
> +	{ .compatible = "ti,am43", .prescaler = 50 },
> +	{ .compatible = "xlnx,zynq-7000", .prescaler = 2 },
> +	{ .compatible = NULL }
> +};
> +
> +static unsigned long gt_get_initial_prescaler_value(struct device_node *np)
> +{
> +	const struct gt_prescaler_config *config;
> +
> +	if (CONFIG_ARM_GT_INITIAL_PRESCALER_VAL != 0)
> +		return CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
> +
> +	for (config = gt_prescaler_configs; config->compatible; config++) {
> +		if (of_machine_is_compatible(config->compatible))
> +			return config->prescaler;
> +	}
> +
> +	return 1;
> +}
> +
>  static int __init global_timer_of_register(struct device_node *np)
>  {
>  	struct clk *gt_clk;
>  	static unsigned long gt_clk_rate;
>  	int err;
> +	unsigned long psv;
>  
>  	/*
>  	 * In A9 r2p0 the comparators for each processor with the global timer
> @@ -378,8 +411,9 @@ static int __init global_timer_of_register(struct device_node *np)
>  		goto out_unmap;
>  	}
>  
> +	psv = gt_get_initial_prescaler_value(np);
>  	gt_clk_rate = clk_get_rate(gt_clk);
> -	gt_target_rate = gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
> +	gt_target_rate = gt_clk_rate / psv;
>  	gt_clk_rate_change_nb.notifier_call =
>  		gt_clk_rate_change_cb;
>  	err = clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
> @@ -404,7 +438,7 @@ static int __init global_timer_of_register(struct device_node *np)
>  	}
>  
>  	/* Register and immediately configure the timer on the boot CPU */
> -	err = gt_clocksource_init();
> +	err = gt_clocksource_init(psv);
>  	if (err)
>  		goto out_irq;
>  
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250808-topic-am43-arm-global-timer-v6-16-66fc0c6981ab
> 
> Best regards,

Tested on STMicroelectronics STiH410-B2260 board

Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice


