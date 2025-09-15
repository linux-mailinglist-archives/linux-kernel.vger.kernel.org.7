Return-Path: <linux-kernel+bounces-816257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F831B5719A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA7518946EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602E2D661C;
	Mon, 15 Sep 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUEysU5Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F132877E7;
	Mon, 15 Sep 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921701; cv=none; b=dhscLj6rW4c9cXG6ABmQ5AG5cCNhSJRA25cKDXtlQ+9bUHlWvjh4kBD13++o3bjj5Q8txQHrFZ9rdtFC8ASdjBwJGJdRn5aLAX7aXwWNxLdSO9tgDxPEZf1Y/ya+tEjNPpQJyKOfPHGCX5EX641Vn154KraysRDSb0x0mTihRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921701; c=relaxed/simple;
	bh=yz87stKD1z8lNZekflqVA6tGhoyOFH6K4fheBUkwWBQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ERftT4jUBt+cuKSlFHaj95+FxdnDhaJ/HC5QDtw38A38TV1Cs0IM7ADf0KyPoriFOFINxQ0ryOdOh1P65jvQfcICyU3q776em+KgaaVRqi/Q8YkcCweyuOYYnDKFCtLsU/r0Amh7qURCeKYETPoR5trAxkbIqoUKIG1P8/7Mq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUEysU5Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757921700; x=1789457700;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yz87stKD1z8lNZekflqVA6tGhoyOFH6K4fheBUkwWBQ=;
  b=AUEysU5Q2XUmMJyDig03jE063HSoJoGBdwXv7UQThJvovx8ofqaZnKlv
   rpNn0VcPoN4/wFIc3cKPoUeOEvsBoEu1Q1Awn+mVLOKi8ntYDZJNbEjbW
   6YEP3jds4klb6MEOczqByPYlFkIPCYZSa1GBiWYkPryBn6eXCISfQaoRj
   0njalNM+IiGW4XC8a2vLCEmW0RVf9R9Q18OsV0Bvu3knaW4YmOYHd/xbd
   Pd3XI+RdJY1RZJ1Qd0rogeF3l/2jIwf+55hDftwemOQxo9+htZjulj1Lh
   lCoGMOh/tRjmi676/7k2liFnagvTAIuPyT9bt+faqvjNERgIJkX+iPVkC
   A==;
X-CSE-ConnectionGUID: NCxdNmFvSRiEbkjPKXJgQA==
X-CSE-MsgGUID: Pf6bi0HlQ8aAHZyLZaaudQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60311120"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="60311120"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 00:35:00 -0700
X-CSE-ConnectionGUID: JnW2jI7ASBGCNco3wY6svA==
X-CSE-MsgGUID: loMQ9YVRRP2R2jVXXaPUFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178857232"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 00:34:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Sep 2025 10:34:53 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    Matan Ziv-Av <matan@svgalib.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
In-Reply-To: <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
References: <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com> <37610abe-e6ea-4694-be63-1a7147c52b73@web.de> <MN2PR06MB55988311E10C20DD6EF0CB97DC0BA@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Sep 2025, Daniel wrote:

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
>  .../admin-guide/laptops/lg-laptop.rst         |  4 +--
>  drivers/platform/x86/lg-laptop.c              | 29 +++++++------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
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
> index 4b57102c7..335afdc75 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -75,6 +75,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
>  #define WMBB_USB_CHARGE 0x10B
>  #define WMBB_BATT_LIMIT 0x10C
>  
> +#define FAN_MODE_FIELD_LOWER GENMASK(1, 0)
> +#define FAN_MODE_FIELD_UPPER GENMASK(5, 4)
> +
>  #define PLATFORM_NAME   "lg-laptop"
>  
>  MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
> @@ -274,29 +277,19 @@ static ssize_t fan_mode_store(struct device *dev,
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
> +		FIELD_PREP(FAN_MODE_FIELD_LOWER, value) |
> +		FIELD_PREP(FAN_MODE_FIELD_UPPER, value));

"FIELD" seems just unnecessary characters.

Please also add include for <linux/bitfield.h>.

>  	kfree(r);
>  
>  	return count;
> @@ -317,7 +310,7 @@ static ssize_t fan_mode_show(struct device *dev,
>  		return -EIO;
>  	}
>  
> -	status = r->integer.value & 0x01;
> +	status = FIELD_GET(FAN_MODE_FIELD_LOWER, r->integer.value);

Is it good to reuse the input side define here for response side or should 
you have another with more specific name? (This is put to status named 
variable so my natural expectation is that the field's name is somehow 
related to that.)

>  	kfree(r);
>  
>  	return sysfs_emit(buffer, "%d\n", status);
> 

-- 
 i.


