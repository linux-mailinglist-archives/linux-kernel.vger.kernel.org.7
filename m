Return-Path: <linux-kernel+bounces-818521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F54B592DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D66A3BDB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC72BE656;
	Tue, 16 Sep 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltBWmCDG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71592DC790;
	Tue, 16 Sep 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016852; cv=none; b=nml1mK3venldWcFxuKUsCzpShzErqiKbaKj04qzIMSy8AhLYWba6rQIoNiW8X/tyOn59VxyaVDo25lYiSxlOT3cz0yFL8tJBs/dIAhXSvGno/kf88sewhS0B1eWpsS8ZE3NEm+6Q5H48Sq2SvOmIzWG4200SICn+ijVileToXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016852; c=relaxed/simple;
	bh=nnWkI+m8+0vYJKqfeJTqSu3Ryof79mvbjAFUpnfISi0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OCRVkUTp+EpZSPtB3shvisLHEaRDa2qmZCnUtMiGYoyQiYIlXFs+sjoKYi9Y8+1d1HwM7wsFA0Agdf50QvrRWel7EzVRMNePwEKCRQCg6FrgCKsMB+C5xM34SiDx62xeRhKMK/oTA3R38CguC7JdUyIPckc7SvJ1YgM/bNVl84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltBWmCDG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758016851; x=1789552851;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nnWkI+m8+0vYJKqfeJTqSu3Ryof79mvbjAFUpnfISi0=;
  b=ltBWmCDGR4betB+nrYLxAErjzZV7cssee8KJIVFslaVQK+dsfFVRO5CO
   Z3I/npG18Z036eAoxGEwfnso5Ihm+q5EuwomonEtC2AXsS6pBMdtgnULw
   YQLLppZprntCrI5PXYNGkq/umWjwSdT9qoRfu4FPNvnvdlBUIdFaqBMXR
   64xiiXO0Rug8bMl5ofmEI/ojQatO2yx+zUpGiVlUteEFkyZK/l2iiJZdE
   bDiDQFc6QFFbbuoZE0jpjUrOOGqdcuGTmSpxtZTXjanVFY4ngXlTtVAoC
   qtymRf8yZvC/CcrXfHKri4VKcl/pu6bqKDx7edP86nGAjIgttEYXl/rEm
   g==;
X-CSE-ConnectionGUID: L/J7B8hbQ4CulhbRfe3z3g==
X-CSE-MsgGUID: 6UOP2e5OSCi4scNQ65LIAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="47864320"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="47864320"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 03:00:50 -0700
X-CSE-ConnectionGUID: 9GZO1RTbQ3ym2PTWmdN9zQ==
X-CSE-MsgGUID: 6mcQDqfQStmbofMssFefnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175328592"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 03:00:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Sep 2025 13:00:43 +0300 (EEST)
To: Ciju Rajan K <crajank@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: christophe.jaillet@wanadoo.fr, platform-driver-x86@vger.kernel.org, 
    vadimp@nvidia.com
Subject: Re: [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug:
 Add support for handling interrupt storm
In-Reply-To: <20250916054731.1412031-3-crajank@nvidia.com>
Message-ID: <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com>
References: <20250916054731.1412031-1-crajank@nvidia.com> <20250916054731.1412031-3-crajank@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

+ Thomas, lkml

On Tue, 16 Sep 2025, Ciju Rajan K wrote:

> In case of broken hardware, it is possible that broken device will
> flood interrupt handler with false events. For example, if fan or
> power supply has damaged presence pin, it will cause permanent
> generation of plugged in / plugged out events. As a result, interrupt
> handler will consume a lot of CPU resources and will keep raising
> "UDEV" events to the user space.
> 
> This patch provides a mechanism to detect device causing interrupt
> flooding and mask interrupt for this specific device, to isolate
> from interrupt handling flow. Use the following criteria: if the
> specific interrupt was generated 'N' times during 'T' seconds,
> such device is to be considered as broken and will be closed for
> getting interrupts. User will be notified through the log error
> and will be instructed to replace broken device.
> 
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Signed-off-by: Ciju Rajan K <crajank@nvidia.com>

I've a general question on this approach, probably more directed towards 
Hans, Thomas, or others who might have some insight.

Are drivers expected to build their own workarounds for interrupt storms 
due to broken HW such as this? It sounds something that should be at least 
in part handled by something generic, while the lower-most level masking 
and detection might still need to be done by the driver to handle the HW 
specific aspects, there seems to be a generic aspect in all this.

Is there something generic for this already? If not, should there be 
instead of adding this in full into an end-of-the-food-chain driver?


> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c | 35 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index d246772aafd6..97b84c584d5e 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -11,6 +11,7 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/jiffies.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/mlxreg.h>
>  #include <linux/platform_device.h>
> @@ -30,6 +31,11 @@
>  #define MLXREG_HOTPLUG_ATTRS_MAX	128
>  #define MLXREG_HOTPLUG_NOT_ASSERT	3
>  
> +/* Interrupt storm definitions */
> +#define MLXREG_HOTPLUG_WM_COUNTER 100
> +/* Time window in milliseconds */
> +#define MLXREG_HOTPLUG_WM_WINDOW 3000

Define's name should indicate the unit so please postfix it with _MS.

> +
>  /**
>   * struct mlxreg_hotplug_priv_data - platform private data:
>   * @irq: platform device interrupt number;
> @@ -344,7 +350,7 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
>  			   struct mlxreg_core_item *item)
>  {
>  	struct mlxreg_core_data *data;
> -	unsigned long asserted;
> +	unsigned long asserted, wmark_low_ts_window;
>  	u32 regval, bit;
>  	int ret;
>  
> @@ -366,11 +372,34 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
>  	for_each_set_bit(bit, &asserted, 8) {
>  		int pos;
>  
> +		/* Skip already marked storming bit. */
> +		if (item->storming_bits & BIT(bit))
> +			continue;
> +
>  		pos = mlxreg_hotplug_item_label_index_get(item->mask, bit);
>  		if (pos < 0)
>  			goto out;
>  		data = item->data + pos;
> +
> +		/* Interrupt storm handling logic. */
> +		if (data->wmark_low_cntr == 0)
> +			data->wmark_low_ts = jiffies;
> +
> +		if (data->wmark_low_cntr == MLXREG_HOTPLUG_WM_COUNTER - 1) {
> +			data->wmark_high_ts = jiffies;

Why does this timestamp have to be saved?

> +			wmark_low_ts_window = data->wmark_low_ts +
> +					      msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW);

Why not just calculate the ending of the window right at the beginning?
I'd call the member e.g. ->wmark_window (or ->wmark_window_end).

> +			if (time_after(data->wmark_high_ts, wmark_low_ts_window)) {
> +				dev_err(priv->dev, "Storming bit %d (label: %s) - interrupt masked permanently. Replace broken HW.",
> +					bit, data->label);
> +				/* Mark bit as storming. */
> +				item->storming_bits |= BIT(bit);

Why not using continue here for consistency with the other skip above?

If you add the continue, you can remove the else and deindent the zero 
assignment by one level:

> +			} else {
> +				data->wmark_low_cntr = 0;
> +			}
> +		}
> +		data->wmark_low_cntr++;
>  		if (regval & BIT(bit)) {
>  			if (item->inversed)
>  				mlxreg_hotplug_device_destroy(priv, data, item->kind);
> @@ -390,9 +419,9 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
>  	if (ret)
>  		goto out;
>  
> -	/* Unmask event. */
> +	/* Unmask event, exclude storming bits. */
>  	ret = regmap_write(priv->regmap, item->reg + MLXREG_HOTPLUG_MASK_OFF,
> -			   item->mask);
> +			   item->mask & ~item->storming_bits);
>  
>   out:
>  	if (ret)
> 


-- 
 i.


