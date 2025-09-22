Return-Path: <linux-kernel+bounces-827231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4629B9136A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BF47A1009
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E630ACEA;
	Mon, 22 Sep 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/PYCgsM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067B30AACF;
	Mon, 22 Sep 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545391; cv=none; b=vGQQGxvUmSo578duhJnsZKd/jgdxtIfL/ejjYqFjuQfeId03H66AcOGqTI0NT8i+lI3JUGCE8aeU8g1sdLEM7zVUzZQaswswxzcbB6MRqKGsdVhMeUipRBHzyMafEEE34YQ7EEN/X6SqYk5s6SKXb/Jf4Kl70V5tXBFp2QXnXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545391; c=relaxed/simple;
	bh=QISE8A7Cqsmeaq4jeNbGx6Y05LMPWcc33Y8e8eIZIOU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FEUEv74uAjK5/eHiVdg08ylko1ELtowN6OzqzDlmSd/X7uRFmMfq5HWZ73wV5pgZtxIXscy+I2iPAeDTsxG0LvurQu3nnyQX0Arz36CbJpF+YeokzBAI+OfSwaJpk+NaLZHdY8ihadk12V07qNqSH9TJH3qwiYOLsu1eQ44GnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/PYCgsM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758545389; x=1790081389;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QISE8A7Cqsmeaq4jeNbGx6Y05LMPWcc33Y8e8eIZIOU=;
  b=S/PYCgsMTTHYKFkqtCuIfUf+eW7ZRham0wkTYYtOF+1B0oar4ezrCp0l
   +jipNUpLIS3V0uSAh5FuP/R6ikqknoFZih0Jc3LdyTmz6HoLlGUt27cxE
   Va9dczj9ixbEnS3YsoHx8T5SZOboKBPgX27lhciM3jfjYXNAqZ5oC3Qqe
   PrSsydVbXImd/oY/j/fPStdu8fDYKaMdLn6pxypCCjSU0G65VAzQpYU1P
   ZZiU+X44MrVAh3VZDkaaAtQwM7CPkRB3GP8pK48/QHssCBRDNluJWpdQa
   C2cRPikzcp7OdEAGg5VwAZyJgshkBCdceo+O9PDkokqsb0g21DqpIgpmK
   A==;
X-CSE-ConnectionGUID: 7qzmV4TgRkafhY3KEtzggg==
X-CSE-MsgGUID: zXXbzF2mQTq5wPVkWhjNbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60744801"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60744801"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:49:48 -0700
X-CSE-ConnectionGUID: kHkw89mPSoS2aqGw6BOOLA==
X-CSE-MsgGUID: xTjQBUUxQ2it7GtE+Tbzig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207421434"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:49:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Sep 2025 15:49:42 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: Markus.Elfring@web.de, hansg@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
In-Reply-To: <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com> <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Sep 2025, Daniel wrote:

> > Is it good to reuse the input side define here for response side or
> > should you have another with a more specific name? (This is put to
> > status named variable so my natural expectation is that the field's
> > name is somehow related to that.)
> 
> The fan mode really is sent back to us in *_LOWER and *_UPPER form,
> exactly like how we send the fan mode.  (Only, the lower and upper
> portions are guaranteed to be identical, so we just read the lower.)
> Hence why I did not add a new define for the response side.
> 
> Should I add another define FAN_MODE_RESPONSE?

Ah okay so the variable name is misleading then as it's really "mode" 
that is returned, not really "status"? I think this is fine then although 
I'd prefer to have also another patch on top of this which would rename 
that variable to mode.

> -- >8 --
> Subject: [PATCH v4] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()
> 
> On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
> /sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
> report a status of 0.
> 
> Disassembling the relevant ACPI tables reveals that in the WMAB call to
> set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
> (depending on the value of some other EC register).  Thus when we call
> WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
> call undoes the effect of the first call.
> 
> Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
> When the fan mode is returned from WMAB it always has this form, so
> there is no need to preserve the other bits.  As a bonus, the driver
> now supports the "Performance" fan mode seen in the LG-provided Windows
> control app, which provides less aggressive CPU throttling but louder
> fan noise and shorter battery life.
> 
> I can confirm with this patch reading/writing the fan mode now works
> as expected on my laptop, although I have not tested it on any other
> LG laptop.
> 
> Also, correct the documentation to reflect that 0 corresponds to the
> default mode (what the Windows app calls "Optimal") and 1 corresponds
> to the silent mode.
> 
> Signed-off-by: Daniel Lee <dany97@live.ca>
> Tested-by: Daniel Lee <dany97@live.ca>
> Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
> ---
> V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
> V2 -> V3: Add parentheses next to function name in summary line
>           Use full name in signoff
> V3 -> V4: Add include for linux/bitfield.h
>           Remove "FIELD" from bitmask macro names
> 
>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 30 ++++++++-----------
>  2 files changed, 14 insertions(+), 20 deletions(-)
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
> index 4b57102c7..0ef179f7a 100644
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
> @@ -317,7 +311,7 @@ static ssize_t fan_mode_show(struct device *dev,
>  		return -EIO;
>  	}
>  
> -	status = r->integer.value & 0x01;
> +	status = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
>  	kfree(r);
>  
>  	return sysfs_emit(buffer, "%d\n", status);
> 

-- 
 i.


