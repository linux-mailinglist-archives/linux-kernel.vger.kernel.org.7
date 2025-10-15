Return-Path: <linux-kernel+bounces-854135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D1BDDA06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62D9F4ECC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705C30BBA1;
	Wed, 15 Oct 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDMzLVri"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442E298991;
	Wed, 15 Oct 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519513; cv=none; b=FNINY5UxMy1PI5hLxcXLO+8ahMk/HZ+5JiwivulVTGBmIUG/RDxnGS0zCdbdvNnZy+Ule9KQMgnXvM8t3rhm76W8YRQwXuJa54kl5PQ/JAFq+lmZhaBbrtb25zmQcwpxMzfAD/+G17X5oeSdzpognnI9cUX1m/5YYUroczmwx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519513; c=relaxed/simple;
	bh=yIc3Hrk4tw3lboKyQb1HiKcmGJHpBDQKrDnQimq9iUg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CheerICRvsNk54bu+t5qR87h16r3X7q9fZsdsbl0InHh1TSTyzsuvJM34jPk0hNYOpX7JB9PkUe1+X9yr+fstpKS0m8hqZ4WI6L3RHq91vGcR/EuCvpQrxbUHnF67ecyHS0UnX5Oe77V98n8yp8OGGGafa2xjJRZEHqvhdx08Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDMzLVri; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519511; x=1792055511;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yIc3Hrk4tw3lboKyQb1HiKcmGJHpBDQKrDnQimq9iUg=;
  b=mDMzLVrivTRJIwPppNEg+tzIoI/d0BqHWWjvtSAUMoaSpSHHAAbgkIg5
   R6FzOkiZLQLyRyPYKx03o4EdFZLcMUhu7i1XyBemPNBnN2lAyK3meg8KQ
   teoNiUzsgI3izwhCkSZBvpoGHrPx+cvrkN7oqbwXs9if/uXK6guwYU25v
   QIHAPxGrI9DloIaUfnrhQ4tUhKQC3znwZszd7mvAZB3KdOd7oIUGjHO6B
   SDL3rbLoItHllCEKdcrmaJ27eJ1EVPCcuBn//GPNLBgg/SIzacMe58tbs
   H/IOB/rG+VbhW9XrSCNFo5rIpO0QsL8gmDLq2ZSDS8ZDBlLvBIrGcEssB
   w==;
X-CSE-ConnectionGUID: gUJ8H7VuQ7yGiS4Wy4m3WA==
X-CSE-MsgGUID: RijQ+T+bSZ2YFfV0qvtgqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61897115"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61897115"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:11:50 -0700
X-CSE-ConnectionGUID: LZuTajTxSqiieHBzMkzxpA==
X-CSE-MsgGUID: aY6EUY27R4SW6Hh0AQI+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181683914"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:11:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:11:40 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
In-Reply-To: <20251015084414.1391595-7-lkml@antheas.dev>
Message-ID: <de1f9cd3-183e-7b01-72aa-23fa4d30334e@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-7-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:

> The Ayaneo EC resets after hibernation, losing the charge control state.
> Add a small PM hook to restore this state on hibernation resume.
> 
> The fan speed is also lost during hibernation, but since hibernation
> failures are common with this class of devices, setting a low fan speed
> when the userspace program controlling the fan will potentially not
> take over could cause the device to overheat, so it is not restored.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> index 73e9dd39c703..8529f6f8dc69 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -37,6 +37,8 @@
>  #define AYANEO_MODULE_LEFT	BIT(0)
>  #define AYANEO_MODULE_RIGHT	BIT(1)
>  
> +#define AYANEO_CACHE_LEN	1
> +
>  struct ayaneo_ec_quirk {
>  	bool has_fan_control;
>  	bool has_charge_control;
> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>  	struct platform_device *pdev;
>  	struct ayaneo_ec_quirk *quirks;
>  	struct acpi_battery_hook battery_hook;
> +
> +	u8 cache[AYANEO_CACHE_LEN];
>  };
>  
>  static const struct ayaneo_ec_quirk quirk_fan = {
> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int ayaneo_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> +	int ret, i = 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;

What is this for?

> +	}
> +
> +	return 0;
> +}
> +
> +static int ayaneo_thaw(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> +	int ret, i = 0;
> +
> +	if (data->quirks->has_charge_control) {
> +		ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
> +		if (ret)
> +			return ret;
> +		i++;

Same question here.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ayaneo_pm_ops = {
> +	.freeze = ayaneo_freeze,
> +	.thaw = ayaneo_thaw,
> +};
> +
>  static struct platform_driver ayaneo_platform_driver = {
>  	.driver = {
>  		.name = "ayaneo-ec",
>  		.dev_groups = ayaneo_ec_groups,
> +		.pm = &ayaneo_pm_ops,
>  	},
>  	.probe = ayaneo_ec_probe,
>  };
> 

-- 
 i.


