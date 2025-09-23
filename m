Return-Path: <linux-kernel+bounces-828805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33930B95861
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD63B4A33AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E932142D;
	Tue, 23 Sep 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHnfAyvU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116061E480;
	Tue, 23 Sep 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624907; cv=none; b=YhjB3z5FARvN6RbZmF3+T2bM4vEOkJaO0fiL0JKmL4laELoOSthW6GWcU8BE/5pB1qC1GrNjBtwgwwUqE1NgI7I6l63+kGa5zcDogNTs4uRygoPrG9k7fdYdGdundth+nYdeq8Ew1rpwlVblL1I4TgxqYiFjA8QiaogJtGBIrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624907; c=relaxed/simple;
	bh=dY5Rwh2Bs45b5H34L497f8DN6MS1f5fLA1XYV31QE30=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U2NehB0hyK51ZTsU2uPMio/JkV3XmyExjvN1Q/1ogU7WZ2PPj6OIJeYIwMM8xEoUopG/AENyKy8c0E33Y+giieNGnq61V2dFxmMLHMGVBFr5dqZEKq0DEwmY5BqdiGxsRhemfu1zi8MlKMndfhLMeri8S47jmn9tIBWWvPAD0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHnfAyvU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758624905; x=1790160905;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dY5Rwh2Bs45b5H34L497f8DN6MS1f5fLA1XYV31QE30=;
  b=cHnfAyvUSo+YDxii3xIfhGzKc2LKJcQL1wyHg0nhBCIOECEFNH3QmzEC
   JXZy1Q68dc0ccWTYUewC1xzZEtKh+tj/C5Al/ikSnbIKDF50NX/B0kC/n
   cEsrmVRcOlR+lasYqSDnOt/yQ3smTqvGmggMNevbsXcbiS+VOdb2c+zfm
   dEekuBuk30mRgnlEGKXePj/1p5wY78RSX8WgRZlSJJFzp4q7tYxOwTrTG
   +HzqWvJqrxAFrNpO4ybRWt4c+nPvzifKuAXLQGE0o3mPnaDK1p06kSo9N
   pG+JMf/tlG7ieis+jW+fmhF7VCCRpwRSow5SX+zrRzX2SD3/KTLskdxTy
   g==;
X-CSE-ConnectionGUID: giKm6m2vRIu+txj79dD2XQ==
X-CSE-MsgGUID: agKWdt+MQq+VBRY5ApJeFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61069889"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="61069889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 03:55:04 -0700
X-CSE-ConnectionGUID: SYmwqISISO2W6g760lAhmA==
X-CSE-MsgGUID: Y8a2p1Z/QX6U6uTVIrbakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="177519668"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 03:55:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Sep 2025 13:54:57 +0300 (EEST)
To: Ciju Rajan K <crajank@nvidia.com>
cc: hdegoede@redhat.com, tglx@linutronix.de, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, christophe.jaillet@wanadoo.fr, 
    platform-driver-x86@vger.kernel.org, vadimp@nvidia.com
Subject: Re: [PATCH platform-next v2 2/2] [PATCH platform-next 2/2]
 platform/mellanox: mlxreg-hotplug: Add support for handling interrupt
 storm
In-Reply-To: <20250923104452.2407460-3-crajank@nvidia.com>
Message-ID: <066ef64c-c6e4-f070-9851-ba9358b0970e@linux.intel.com>
References: <20250923104452.2407460-1-crajank@nvidia.com> <20250923104452.2407460-3-crajank@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Sep 2025, Ciju Rajan K wrote:

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
> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index d246772aafd6..ae0115ea1fd1 100644
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
> +#define MLXREG_HOTPLUG_WM_COUNTER	100
> +/* Time window in milliseconds */
> +#define MLXREG_HOTPLUG_WM_WINDOW_MS	3000
> +
>  /**
>   * struct mlxreg_hotplug_priv_data - platform private data:
>   * @irq: platform device interrupt number;
> @@ -366,11 +372,33 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
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
>  
>  		data = item->data + pos;
> +
> +		/* Interrupt storm handling logic. */
> +		if (data->wmark_cntr == 0)
> +			data->wmark_window = jiffies +
> +				msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW_MS);

Please use braces for multi-line if blocks.

> +
> +		if (data->wmark_cntr >= MLXREG_HOTPLUG_WM_COUNTER - 1) {
> +			if (time_after(data->wmark_window, jiffies)) {
> +				dev_err(priv->dev,
> +					"Storming bit %d (label: %s) - interrupt masked permanently. Replace broken HW.",
> +					bit, data->label);
> +				/* Mark bit as storming. */
> +				item->storming_bits |= BIT(bit);
> +				continue;
> +			}
> +			data->wmark_cntr = 0;
> +		}
> +		data->wmark_cntr++;

I think this should be in else block to allow recalculation of the time 
window when the counter wraps.

>  		if (regval & BIT(bit)) {
>  			if (item->inversed)
>  				mlxreg_hotplug_device_destroy(priv, data, item->kind);
> @@ -390,9 +418,9 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
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


