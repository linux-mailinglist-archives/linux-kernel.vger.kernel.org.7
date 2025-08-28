Return-Path: <linux-kernel+bounces-789818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8DB39B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5100A1B27E47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5530DD32;
	Thu, 28 Aug 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI1k++QV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA31F4CAF;
	Thu, 28 Aug 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379451; cv=none; b=PXc9yqyNYOqEKFhNxkgUNh7LEgVN5yQCX1Cutcb8AxBs81gNoT4bpHaIkJASQ8YFoJXzDt4NbDHZo79zf+znW4Q+gJvgfJRg4WkBtSiWSHDv8SiE76YQFBwWys7ZvkAedkv71HS172wk9Vzf6G7wdqtbmxh0DOlYRhof/VmLdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379451; c=relaxed/simple;
	bh=EjWEYcDmhkhr5dB4FdWTNV+SQHvS/YaT2jO/86b0BEA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E1a/Ut60suAz3cTiVUuPVUWcQfR/91kEDuXoEsIBph3at9O6/Aedcjxv8HQ7DVMPijiapkMCCYp9TL1zJ6MatBYGxyFGKppuA8u4QcLYP2WfXugi7WFeGMrDx/v7TX5OqAyFNgdGspQYHJOIDxnzG89elZYS8sqXKeLvk4o0Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI1k++QV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756379451; x=1787915451;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EjWEYcDmhkhr5dB4FdWTNV+SQHvS/YaT2jO/86b0BEA=;
  b=iI1k++QVIPZt58CscTmF/sUySCP4LNmRng3I+aeBlAE8sTVfOOCqzn79
   94GaVN58Bq8Ne1fcsLfwEqe4arZvIFAWYQ2dA6mDLkSrxnWqWnTjpiudY
   9Gzg+i84+K2yzenKoQnsLSVtTf/HKzZW0XgTcnBpjXr0y4otpYcvmNwNP
   EwmZs44nXcOXOAdMotsRcRJWmhMREdhJb5aj5MvjUYMlHh/Dp8lzfMank
   eY2l7l1Rz9w9nj1hq44mjxCxfWhLasc3oOd24Ut0JxqtXA5R+c2BMni9M
   j74QEmzUbFYpo/QskbX9Xt6/GnK7BNMP37wB3HutohNxAHKYyCWQ21pK6
   A==;
X-CSE-ConnectionGUID: yrVxTsECS5ayzyuqrpIAhQ==
X-CSE-MsgGUID: z7wjSLEMRuGGArKj9YZg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68918111"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="68918111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:10:50 -0700
X-CSE-ConnectionGUID: F25B9ecoRIW9M4ekdUPLuA==
X-CSE-MsgGUID: h99Hnb9GSnW5WrUj3jUlPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175358538"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:10:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Aug 2025 14:10:44 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: matan@svgalib.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store
In-Reply-To: <MN2PR06MB55982D694628BC31FD980FD2DC3DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <2fdc2487-aaae-aa3c-9aa6-0c2bf2379e5a@linux.intel.com>
References: <MN2PR06MB55982D694628BC31FD980FD2DC3DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Aug 2025, Daniel wrote:

> On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
> /sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
> report a status of 0.
> 
> Disassembling the relevant ACPI tables reveals that in the call
> 
> 	lg_wmab(dev, WM_FAN_MODE, WM_SET, x)
> 
> the new mode is read from either the upper nibble or the lower nibble of x,
> depending on the value of some other EC register.  Crucially, when WMAB
> is called twice (once with the fan mode in the upper nibble, once with
> it in the lower nibble), the result of the second call can overwrite
> the first call.
> 
> Fix this by calling WMAB once, with the fan mode set in both nibbles.
> As a bonus, the driver now supports the "Performance" mode seen in
> the Windows LG Control Center app (less aggressive CPU throttling, but
> louder fan noise and shorter battery life).  I can confirm that with
> this patch writing/reading the fan mode works as expected on my laptop,
> although I haven't tested it on any other LG laptops.
> 
> Also, correct the documentation to reflect that a value of 0 corresponds
> to the default mode (what the LG app calls "Optimal") and a value of 1
> corresponds to the silent mode.
> 
> Tested-by: Daniel <dany97@live.ca>
> Signed-off-by: Daniel <dany97@live.ca>
> ---
>  .../admin-guide/laptops/lg-laptop.rst         |  4 ++--
>  drivers/platform/x86/lg-laptop.c              | 22 +++++--------------
>  2 files changed, 8 insertions(+), 18 deletions(-)
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
> index 4b57102c7..b8de6e568 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -274,29 +274,19 @@ static ssize_t fan_mode_store(struct device *dev,
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
> +	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (value << 4) | value);

Is it okay to remove preserving the other bits?

Please name these field with defined GENMASK() and then use FIELD_PREP() 
here for both fields.

>  	if (!r)
>  		return -EIO;
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
>  	kfree(r);
>  
>  	return count;
> @@ -317,7 +307,7 @@ static ssize_t fan_mode_show(struct device *dev,
>  		return -EIO;
>  	}
>  
> -	status = r->integer.value & 0x01;
> +	status = r->integer.value & 0x03;

This looks also like a field so should be named with a define?

>  	kfree(r);
>  
>  	return sysfs_emit(buffer, "%d\n", status);
> 

-- 
 i.


