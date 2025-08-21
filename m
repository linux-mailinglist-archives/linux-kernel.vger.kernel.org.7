Return-Path: <linux-kernel+bounces-779938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33259B2FB74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF23B7CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA39343D95;
	Thu, 21 Aug 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YglzjWry"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6ED343206
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783824; cv=none; b=p+HrhVj/EcYYXZkE7ULSJKgJZ0DRpxp9z6vNTMXeKeq95oOgTGd5krTgZQJBhFBx7zaEey9yP6Ch3k0pZzSX6aSQofjXsmF+HkNKE/NZogFwx5K/btT+eqAKRSR7e/MeNNodnjcNYhz9GmBYW43PZNeDBRucP/9uvsRpzcue7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783824; c=relaxed/simple;
	bh=30cVhYBqXd0eVwyt1FtKIuGdL92EgZf4AECAHBNRQxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X0ktC67AV5BI9L2wE/yrmf/I4DC4kA5GZbjv0/5JF59/RbgV+Sm/SYED5StEExqJ4C4qfYXJGV/OBid/RJiC2jVjZPluDQSSEHuf1Du8Iug8O4YI+RTUry1MJ7+Ex1RFGO7QcZ5zFN1LmIdvul1SJFhcnHSiY9+jmgMzlDvOWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YglzjWry; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LDhdfT495897;
	Thu, 21 Aug 2025 08:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755783819;
	bh=A0t7ea2MaiVbtpbHvHc/Darxtf6sqBo1OfAkySCgOJI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=YglzjWryNmgiH1ERO7aMTgqelpo0ecTOPulWIuVuiaqtwVGbCSJZLs/Y2TVXv6zqN
	 LjROG4kaS8mg2C02apcEMJ/7XB32ak4xTBRGx1hoL2iXoHjS9+4IYoeP6UQIldZDG4
	 92kv8txrqD2xfC3SHW1ggqvMTdmTI4tWw5qUI6yA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LDhd1m2167080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 08:43:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 08:43:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 08:43:39 -0500
Received: from [172.24.235.200] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LDhbZJ2239935;
	Thu, 21 Aug 2025 08:43:38 -0500
Message-ID: <37e7589a-15c3-465e-8ba9-195dc205a2bd@ti.com>
Date: Thu, 21 Aug 2025 19:13:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-ti-dm : Capture functionality for
 OMAP DM timer
To: Gokul Praveen <g-praveen@ti.com>, <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20250812105346.203541-1-g-praveen@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250812105346.203541-1-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Gokul

On 12/08/25 16:23, Gokul Praveen wrote:
> Add PWM capture function in DM timer driver.
> 
> OMAP DM timer hardware supports capture feature.It can be used to
> timestamp events (falling/rising edges) detected on input signal.
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
> v2<==> v1
> ===========
> * Optimized the code and fixed some comment spacing and newline issues
> 
> Precondition : Before calling driver API,it is assumed that the
>                capture signal is active else both duty cycle
>                and period returned by driver will not be valid.
> ---
>  drivers/clocksource/timer-ti-dm.c          | 119 ++++++++++++++++++++-
>  include/linux/platform_data/dmtimer-omap.h |   4 +
>  2 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> index e9e32df6b566..793e7cdcb1b1 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -31,6 +31,7 @@
>  #include <linux/platform_data/dmtimer-omap.h>
>  
>  #include <clocksource/timer-ti-dm.h>
> +#include <linux/delay.h>
>  
>  /*
>   * timer errata flags
> @@ -836,6 +837,48 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
>  	return 0;
>  }
>  
> +static int omap_dm_timer_set_cap(struct omap_dm_timer *cookie,
> +					int autoreload, bool config_period)
> +{
> +	struct dmtimer *timer;
> +	struct device *dev;
> +	int rc;
> +	u32 l;
> +
> +	timer = to_dmtimer(cookie);
> +	if (unlikely(!timer))
> +		return -EINVAL;
> +
> +	dev = &timer->pdev->dev;
> +	rc = pm_runtime_resume_and_get(dev);
> +	if (rc)
> +		return rc;
> +	/*
> +	 *  1. Select autoreload mode. TIMER_TCLR[1] AR bit.
> +	 *  2. TIMER_TCLR[14]: Sets the functionality of the TIMER IO pin.
> +	 *  3. TIMER_TCLR[13] : Capture mode select bit.
> +	 *  3. TIMER_TCLR[9-8] : Select transition capture mode.
> +	 */
> +
> +	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
> +
> +	if (autoreload)
> +		l |= OMAP_TIMER_CTRL_AR;
> +
> +	l |= OMAP_TIMER_CTRL_CAPTMODE | OMAP_TIMER_CTRL_GPOCFG;
> +
> +	if (config_period == true)
> +		l |= OMAP_TIMER_CTRL_TCM_LOWTOHIGH; /* Time Period config */
> +	else
> +		l |= OMAP_TIMER_CTRL_TCM_BOTHEDGES; /* Duty Cycle config */
> +
> +	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
>  static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
>  				 int toggle, int trigger, int autoreload)
>  {
> @@ -1023,23 +1066,92 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *cookie)
>  	return __omap_dm_timer_read_counter(timer);
>  }
>  
> +static inline unsigned int __omap_dm_timer_cap(struct dmtimer *timer, int idx)
> +{
> +	return idx == 0 ? dmtimer_read(timer, OMAP_TIMER_CAPTURE_REG) :
> +			  dmtimer_read(timer, OMAP_TIMER_CAPTURE2_REG);
> +}
> +
>  static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, unsigned int value)
>  {
>  	struct dmtimer *timer;
> +	struct device *dev;
>  
>  	timer = to_dmtimer(cookie);
> -	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
> -		pr_err("%s: timer not available or enabled.\n", __func__);
> +	if (unlikely(!timer)) {
> +		pr_err("%s: timer not available.\n", __func__);
>  		return -EINVAL;
>  	}
>  
> +	dev = &timer->pdev->dev;
> +
> +	pm_runtime_resume_and_get(dev);
>  	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
> +	pm_runtime_put_sync(dev);
>  
>  	/* Save the context */
>  	timer->context.tcrr = value;
>  	return 0;
>  }
>  
> +/**
> + * omap_dm_timer_cap_counter() - Calculate the high count or period count depending on the
> + * configuration.
> + * @cookie:Pointer to OMAP DM timer
> + * @is_period:Whether to configure timer in period or duty cycle mode
> + *
> + * Return high count or period count if timer is enabled else appropriate error.
> + */
> +static unsigned int omap_dm_timer_cap_counter(struct omap_dm_timer *cookie,	bool is_period)
> +{
> +	struct dmtimer *timer;
> +	unsigned int cap1 = 0;
> +	unsigned int cap2 = 0;
> +	u32 l, ret;
> +
> +	timer = to_dmtimer(cookie);
> +	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
> +		pr_err("%s:timer is not available or enabled.%p\n", __func__, (void *)timer);
> +		return -EINVAL;
> +	}
> +
> +	/* Stop the timer */
> +	omap_dm_timer_stop(cookie);
> +
> +	/* Clear the timer counter value to 0 */
> +	ret = omap_dm_timer_write_counter(cookie, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Sets the timer capture configuration for period/duty cycle calculation */
> +	ret = omap_dm_timer_set_cap(cookie, true, is_period);
> +	if (ret) {
> +		pr_err("%s: Failed to set timer capture configuration.\n", __func__);
> +		return ret;
> +	}
> +	/* Start the timer */
> +	omap_dm_timer_start(cookie);
> +
> +	/*
> +	 * 1 sec delay is given so as to provide
> +	 * enough time to capture low frequency signals.
> +	 */
> +	msleep(1000);
> +
> +	cap1 = __omap_dm_timer_cap(timer, 0);
> +	cap2 = __omap_dm_timer_cap(timer, 1);
> +
> +	/*
> +	 *  Clears the TCLR configuration.
> +	 *  The start bit must be set to 1 as the timer is already in start mode.
> +	 */
> +	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
> +	l &= ~(0xffff) | 0x1;
> +	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
> +
> +	return (cap2-cap1);
> +}
> +
>  static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
>  {
>  	struct dmtimer *timer = dev_get_drvdata(dev);
> @@ -1246,6 +1358,9 @@ static const struct omap_dm_timer_ops dmtimer_ops = {
>  	.write_counter = omap_dm_timer_write_counter,
>  	.read_status = omap_dm_timer_read_status,
>  	.write_status = omap_dm_timer_write_status,
> +	.set_cap = omap_dm_timer_set_cap,
> +	.get_cap_status = omap_dm_timer_get_pwm_status,
> +	.read_cap = omap_dm_timer_cap_counter,
>  };
>  
>  static const struct dmtimer_platform_data omap3plus_pdata = {
> diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
> index 95d852aef130..726d89143842 100644
> --- a/include/linux/platform_data/dmtimer-omap.h
> +++ b/include/linux/platform_data/dmtimer-omap.h
> @@ -36,9 +36,13 @@ struct omap_dm_timer_ops {
>  	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
>  			   int toggle, int trigger, int autoreload);
>  	int	(*get_pwm_status)(struct omap_dm_timer *timer);
> +	int	(*set_cap)(struct omap_dm_timer *timer,
> +			   int autoreload, bool config_period);
> +	int	(*get_cap_status)(struct omap_dm_timer *timer);
>  	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
>  
>  	unsigned int (*read_counter)(struct omap_dm_timer *timer);
> +	unsigned int (*read_cap)(struct omap_dm_timer *timer, bool is_period);
>  	int	(*write_counter)(struct omap_dm_timer *timer,
>  				 unsigned int value);
>  	unsigned int (*read_status)(struct omap_dm_timer *timer);

LGTM

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

