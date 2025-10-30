Return-Path: <linux-kernel+bounces-878687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48EC213DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6011C34F95E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72B2E1C6B;
	Thu, 30 Oct 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2zPdWJl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46827F00A;
	Thu, 30 Oct 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842422; cv=none; b=ApgEZc44OfDy6sdEUkrdhwHPfG8SE6MR4YN78NBZyQABOxDv+DDXfy58KR7chYv1vdYY5PkO5RZsUpw1p/VS41tC64GABDL/1Sy9JzR3PZZ4r9lfoKcWvj+wUnyfjzSqun2VQlAfJX4UOGtBYkqEHIBkBmaifqfbSklkQsthNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842422; c=relaxed/simple;
	bh=6zaf1AkfMTrzijapQzcYoe3olI0nI3PJPsNC0HZeLeQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ss+/BPuneYjYBWaHsfRGRtmgFsiDjzGXrVdoINoQYFjpWvw3VJ1x/LrUtWpXswdh4n6nOedKJA4W5rxPA0xns0uKcW3fLufQ4fTZJPzN2wKRP9odx5GL7nBaxQqzIF1mVhptrP+WWCatWOv/9iorUbnpasuZTmZkjaLJNCFyxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2zPdWJl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761842420; x=1793378420;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6zaf1AkfMTrzijapQzcYoe3olI0nI3PJPsNC0HZeLeQ=;
  b=m2zPdWJlgf0jwjZmW7xhSfMZVRqRhag2vOBmX6t1OJ/zhDIjVHSZKfDw
   xv+AgBMKLW6j2B8O+Py9cRcJ9u+z8A7QKL+Y3iyvGpwm0q0VjQM+wDfB8
   PfwXqdTYSd7kqvrZeTDlFpAWcjHfY6Tl+pQEM1CX5Pj80d7Sz34XrDIpk
   I0NRMZDyeVAS7beC23Rx9lU90repKgyRKrZw38esKsWri10hnYNJJMQpe
   /nBV/bq9KC0tj/DHH0TeCQsy+ZhGQEHMCVTtYwAY9ycmevqlrzkklukKN
   6ClkbIHUcuvGjQqkGMf1VQqBVo6Nuy3EXLRdY1pQ2jnIgI4bKxZoPIkAA
   g==;
X-CSE-ConnectionGUID: OjoD/LwmTZ+TKNFw+F73eA==
X-CSE-MsgGUID: g3NRcw94RBq46y+e5drwnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64141396"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64141396"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:40:19 -0700
X-CSE-ConnectionGUID: RxNI84BRTSmlMbJHaVxfgQ==
X-CSE-MsgGUID: cIvDThhhTNOXKfwwyxQrxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="216659690"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:40:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Oct 2025 18:40:12 +0200 (EET)
To: Rong Zhang <i@rong.moe>
cc: Ike Panhc <ikepanhc@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: ideapad-laptop: Protect GBMD/SBMC
 calls with mutex
In-Reply-To: <20251020192443.33088-2-i@rong.moe>
Message-ID: <2bae2ea7-2ef9-0cfa-0c2c-39a7043b2aa5@linux.intel.com>
References: <20251020192443.33088-1-i@rong.moe> <20251020192443.33088-2-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Oct 2025, Rong Zhang wrote:

> The upcoming changes for Rapid Charge support require two consecutive
> SBMC calls to switch charge_types. Hence, a mutex is required.
> 
> The reason for not using rw_semaphore for this purpose is that allowing
> simultaneous GBMD calls is not really useful and doesn't deserve the
> overhead.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 91 ++++++++++++--------
>  1 file changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index fcebfbaf04605..9f956f51ec8db 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -158,6 +158,7 @@ struct ideapad_rfk_priv {
>  struct ideapad_private {
>  	struct acpi_device *adev;
>  	struct mutex vpc_mutex; /* protects the VPC calls */
> +	struct mutex gbmd_sbmc_mutex; /* protects GBMD/SBMC calls */
>  	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
>  	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
>  	struct platform_device *platform_device;
> @@ -455,37 +456,40 @@ static int debugfs_status_show(struct seq_file *s, void *data)
>  	struct ideapad_private *priv = s->private;
>  	unsigned long value;
>  
> -	guard(mutex)(&priv->vpc_mutex);
> -
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
> -		seq_printf(s, "Backlight max:  %lu\n", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
> -		seq_printf(s, "Backlight now:  %lu\n", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
> -		seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);
> -
> -	seq_puts(s, "=====================\n");
> -
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
> -		seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
> -		seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
> -		seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
> -		seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
> +	scoped_guard(mutex, &priv->vpc_mutex) {
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
> +			seq_printf(s, "Backlight max:  %lu\n", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
> +			seq_printf(s, "Backlight now:  %lu\n", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
> +			seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);

Thanks for the patches. I've taken them into the review-ilpo-next branch.

Unrelated to this series itself, these ? "on" : "off" constructs could be 
changed to use str_on_off().

--
 i.

> +
> +		seq_puts(s, "=====================\n");
> +
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
> +			seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
> +			seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
> +			seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
> +			seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
> +
> +		seq_puts(s, "=====================\n");
> +
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
> +			seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
> +		if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
> +			seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
> +	}
>  
>  	seq_puts(s, "=====================\n");
>  
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
> -		seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
> -	if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
> -		seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
> -
> -	seq_puts(s, "=====================\n");
> +	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
> +		if (!eval_gbmd(priv->adev->handle, &value))
> +			seq_printf(s, "GBMD: %#010lx\n", value);
> +	}
>  
> -	if (!eval_gbmd(priv->adev->handle, &value))
> -		seq_printf(s, "GBMD: %#010lx\n", value);
>  	if (!eval_hals(priv->adev->handle, &value))
>  		seq_printf(s, "HALS: %#010lx\n", value);
>  
> @@ -622,9 +626,11 @@ static ssize_t conservation_mode_show(struct device *dev,
>  
>  	show_conservation_mode_deprecation_warning(dev);
>  
> -	err = eval_gbmd(priv->adev->handle, &result);
> -	if (err)
> -		return err;
> +	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
> +		err = eval_gbmd(priv->adev->handle, &result);
> +		if (err)
> +			return err;
> +	}
>  
>  	return sysfs_emit(buf, "%d\n", !!test_bit(GBMD_CONSERVATION_STATE_BIT, &result));
>  }
> @@ -643,6 +649,8 @@ static ssize_t conservation_mode_store(struct device *dev,
>  	if (err)
>  		return err;
>  
> +	guard(mutex)(&priv->gbmd_sbmc_mutex);
> +
>  	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : SBMC_CONSERVATION_OFF);
>  	if (err)
>  		return err;
> @@ -2007,15 +2015,22 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
>  				    const union power_supply_propval *val)
>  {
>  	struct ideapad_private *priv = ext_data;
> +	unsigned long op;
>  
>  	switch (val->intval) {
>  	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
> -		return exec_sbmc(priv->adev->handle, SBMC_CONSERVATION_ON);
> +		op = SBMC_CONSERVATION_ON;
> +		break;
>  	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
> -		return exec_sbmc(priv->adev->handle, SBMC_CONSERVATION_OFF);
> +		op = SBMC_CONSERVATION_OFF;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	guard(mutex)(&priv->gbmd_sbmc_mutex);
> +
> +	return exec_sbmc(priv->adev->handle, op);
>  }
>  
>  static int ideapad_psy_ext_get_prop(struct power_supply *psy,
> @@ -2028,9 +2043,11 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
>  	unsigned long result;
>  	int err;
>  
> -	err = eval_gbmd(priv->adev->handle, &result);
> -	if (err)
> -		return err;
> +	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
> +		err = eval_gbmd(priv->adev->handle, &result);
> +		if (err)
> +			return err;
> +	}
>  
>  	if (test_bit(GBMD_CONSERVATION_STATE_BIT, &result))
>  		val->intval = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
> @@ -2292,6 +2309,10 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	err = devm_mutex_init(&pdev->dev, &priv->gbmd_sbmc_mutex);
> +	if (err)
> +		return err;
> +
>  	err = ideapad_check_features(priv);
>  	if (err)
>  		return err;
> 

