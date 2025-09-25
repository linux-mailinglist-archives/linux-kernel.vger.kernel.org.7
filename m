Return-Path: <linux-kernel+bounces-832082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4844B9E4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523813B71AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD922E8DED;
	Thu, 25 Sep 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwdpB008"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC827AC59;
	Thu, 25 Sep 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792234; cv=none; b=t+FQsbGWChqfke15pxVcIonk77A95wRqfS+HqWFg5x2Wh98rQaGzFwkfTSrO4JW50KY3ftP297pceEExbGgiQtUGCfByPWWtHR1P0/TK6KMIbUbZMjxYK7uIMSvvzANXyoeoKZfdrT23b61mqSFNls/I7qoApN/GZI5jFbSlee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792234; c=relaxed/simple;
	bh=9Vd9zg0JVBI7yLRIMM72AGWASsNCJnc82xMBZ35PrWk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BbazmzKUWsaf6Me2c2hImPPfu0WyOHqPMVeTD0lLE9ApPTBU6eI8lAXmkjkGL9ZwY0YZmLe7euQM6tLRB1Mr0fyGGRdjVAOCgd9P+HCFFjEa/QrFicy+EP06DlWleTVN2Sw5HS1jVgxRvU/WqBm1j1/M2bHZm7y3PEr7ULaBDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwdpB008; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758792232; x=1790328232;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9Vd9zg0JVBI7yLRIMM72AGWASsNCJnc82xMBZ35PrWk=;
  b=hwdpB0087w4YvFZuGoaHDqHGBs8WWpwol8B1WGbK3aeSbCv7PKG1SQXG
   iWeeEsJYPLqEaLI6KWwY4+mMj/Y/zkONcInK0+7YoM07fMTjvp4Gfh99r
   umP2LYPFftXzDo0t/pf2AMBjCHSiZBMG6E3AWcFL+jxwnaFsmDtTOL7u2
   Ip3Td/oCQu3E/+D90/e8tiTwIAqw0CjdDLHLGPpWGcjQQ16VKYegLMljO
   MxZIrCj9herzvkMg+AG0M/Cy7rhe34Nz+xRAR2++dDGvxAUIDuVmYCIEr
   6tI8yLXlJw6u5fmz9X/rW9JOVoKS7roKkAikOKrfaZhxOtNWVZRzgcIeh
   Q==;
X-CSE-ConnectionGUID: +mwF8UDYRhWcK0Kz7awJGQ==
X-CSE-MsgGUID: o/FffolfTbOQNi1ZBosKVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61018019"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61018019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:51 -0700
X-CSE-ConnectionGUID: MWZ7/qLHQuOhd28y8/DFPQ==
X-CSE-MsgGUID: zlRQloHVQY2u7IUYJkPpXA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Sep 2025 12:23:45 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: Matan Ziv-Av <matan@svgalib.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
In-Reply-To: <MN2PR06MB55989CB10E91C8DA00EE868DDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <6368d0dc-6e7c-ce4f-9f9b-df26a84f8120@linux.intel.com>
References: <MN2PR06MB55989CB10E91C8DA00EE868DDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Sep 2025, Daniel wrote:

> When WMAB is called to set the fan mode, the new mode is read from either
> bits 0-1 or bits 4-5 (depending on the value of some other EC register).
> Thus when WMAB is called with bits 4-5 zeroed and called again with
> bits 0-1 zeroed, the second call undoes the effect of the first call.
> This causes writes to /sys/devices/platform/lg-laptop/fan_mode to have
> no effect (and causes reads to always report a status of zero).
> 
> Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
> When the fan mode is returned from WMAB it always has this form, so
> there is no need to preserve the other bits.  As a bonus, the driver
> now supports the "Performance" fan mode seen in the LG-provided Windows
> control app, which provides less aggressive CPU throttling but louder
> fan noise and shorter battery life.
> 
> Also correct the documentation to reflect that 0 corresponds to the
> default mode (what the Windows app calls "Optimal") and 1 corresponds
> to the silent mode.
> 
> Signed-off-by: Daniel Lee <dany97@live.ca>
> Tested-by: Daniel Lee <dany97@live.ca>
> Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204913#c4
> ---
> V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
> V2 -> V3: Add parentheses next to function name in summary line
>           Use full name in signoff
> V3 -> V4: Add include for linux/bitfield.h
>           Remove "FIELD" from bitmask macro names
> V4 -> V5: Rename `status` to `mode` in fan_mode_show()
> V5 -> V6: Reword commit message body
> V6 -> V7: Add Link: to relevant bugzilla comment

Thanks. I've replaced the commit in the review-ilpo-fixes branch with this 
one.

>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 34 ++++++++-----------
>  2 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
> index 67fd6932c..c4dd534f9 100644
> --- a/Documentation/admin-guide/laptops/lg-laptop.rst
> +++ b/Documentation/admin-guide/laptops/lg-laptop.rst
> @@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
>  Fan mode
>  --------
>  
> -Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
> -the fan silent mode.
> +Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
> +Optimal/Silent/Performance respectively.
>  
>  
>  USB charge
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 4b57102c7..6af6cf477 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/dev_printk.h>
> @@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
>  #define WMBB_USB_CHARGE 0x10B
>  #define WMBB_BATT_LIMIT 0x10C
>  
> +#define FAN_MODE_LOWER GENMASK(1, 0)
> +#define FAN_MODE_UPPER GENMASK(5, 4)
> +
>  #define PLATFORM_NAME   "lg-laptop"
>  
>  MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
> @@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
>  			      struct device_attribute *attr,
>  			      const char *buffer, size_t count)
>  {
> -	bool value;
> +	unsigned long value;
>  	union acpi_object *r;
> -	u32 m;
>  	int ret;
>  
> -	ret = kstrtobool(buffer, &value);
> +	ret = kstrtoul(buffer, 10, &value);
>  	if (ret)
>  		return ret;
> +	if (value >= 3)
> +		return -EINVAL;
>  
> -	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
> -	if (!r)
> -		return -EIO;
> -
> -	if (r->type != ACPI_TYPE_INTEGER) {
> -		kfree(r);
> -		return -EIO;
> -	}
> -
> -	m = r->integer.value;
> -	kfree(r);
> -	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
> -	kfree(r);
> -	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
> +	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
> +		FIELD_PREP(FAN_MODE_LOWER, value) |
> +		FIELD_PREP(FAN_MODE_UPPER, value));
>  	kfree(r);
>  
>  	return count;
> @@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
>  static ssize_t fan_mode_show(struct device *dev,
>  			     struct device_attribute *attr, char *buffer)
>  {
> -	unsigned int status;
> +	unsigned int mode;
>  	union acpi_object *r;
>  
>  	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
> @@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
>  		return -EIO;
>  	}
>  
> -	status = r->integer.value & 0x01;
> +	mode = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
>  	kfree(r);
>  
> -	return sysfs_emit(buffer, "%d\n", status);
> +	return sysfs_emit(buffer, "%d\n", mode);
>  }
>  
>  static ssize_t usb_charge_store(struct device *dev,
> 

-- 
 i.


