Return-Path: <linux-kernel+bounces-721130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18544AFC516
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1417A3421
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6B10A1F;
	Tue,  8 Jul 2025 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH9b9zyS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3B25771;
	Tue,  8 Jul 2025 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962132; cv=none; b=U7Akr0wFj1PLfJDjGk4TTvZm9fZyIhDJtCJp7lE2Bu6mKlNQ8JeIGv0rs88+b71nOr2r8cYaF60pf5dPpyaz2FUngnQThCCz5bSIWuatUigmJ8HP8MVUyyolYsiHaA2mpHOCfrmVKoXSbcJmQ+jK/fIVIK93J+nIi3syFpNiIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962132; c=relaxed/simple;
	bh=CxGaPumrMjC0oxYrMzbOrzWMuM5aNk0eA0CKtbvHsR0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UHQUz6CITbyd72oqi8tcUlNSRIsuJqmQZHDry03qM5MGniaorLtKEk1WC2SiZTBVGXX0Prt4ZUliHWG6aMBTGBYHqiv1T1fCGEacDmguPXLFlegN6z8JTeJefqRF2ojSh3GyiOTbuFaJ8c2XtXTHnBAU3KvWlPBW7aS26WilCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH9b9zyS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751962131; x=1783498131;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CxGaPumrMjC0oxYrMzbOrzWMuM5aNk0eA0CKtbvHsR0=;
  b=HH9b9zySsyo97zbDqr4jsNRm9EGXF3G6d5jJIjpuz0k6CDBg9LD+/Tva
   64w0oM56hmXV7/4IvQZiUISb6dNfCW7ceZQEMiaR+wPYxTcsyxp1kL3m5
   NcTW/sBujOd8ntCitoJe44F0TvVsIkFsq6CkTQEmpzn+F0Je5TUJD0H6O
   LxVhP9sF5x3uXJVaeUqrE8ZNnSBsrmse90oNdVDAuV7s43tj39exgwuMO
   /aW/MimqhiknakQPucxh2uo+qqas/L4QM5wPvMreRZmnEXXSXh0C6yOOV
   x9ztI9cGngbicSVkBrv4SWx1HQiHoQxRB9mUTPUn2bnPYfflGE0NkKhkJ
   w==;
X-CSE-ConnectionGUID: GmfaoKFkTCuYzCt8fmDJjA==
X-CSE-MsgGUID: /jmBWe8LT6GhwhDPQjGXLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54120051"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54120051"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:08:49 -0700
X-CSE-ConnectionGUID: 10ZksXfBSMC0VrpGeFtokA==
X-CSE-MsgGUID: /xYcWmRXSF6ZZfXblFSdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="159703122"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.247])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:08:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Jul 2025 11:07:31 +0300 (EEST)
To: Jackie Dong <xy-jackie@139.com>
cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
Subject: Re: [PATCH v2] lenovo-wmi-hotkey: Fixed a kernel error report for
In-Reply-To: <20250708071138.15602-1-xy-jackie@139.com>
Message-ID: <78394a09-6ca2-afc4-3b35-de4ea8e998cd@linux.intel.com>
References: <20250708071138.15602-1-xy-jackie@139.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Jul 2025, Jackie Dong wrote:

Hi,

Shortlog in Subject seems incomplete

> Not all of Lenovo non-ThinkPad devices support both mic mute LED(on F4)
> and audio mute LED(on F1). Some of them only support one mute LED, some

Add spaces after (

> of them don't have any mute LED. Add a decision to judge this device
> support mute LED or not. Without this decision, not support both of mic
> mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
> Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
> with error -5.
> 
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Hans de Goede <hansg@kernel.org>
> 
> ---
> Changes in v2:
>  - Add warning message and then return 0 if the device support mute LED 
>    abnormaly, based on Hans suggestion and Armin previous patch. 
> 
>  .../x86/lenovo-wmi-hotkey-utilities.c         | 30 +++++++++++++------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> index 89153afd7015..334c12f2896d 100644
> --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -122,26 +122,35 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>  		return -EIO;
>  
>  	union acpi_object *obj __free(kfree) = output.pointer;
> -	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {

Could you please reverse this logic and handle errors first.

>  		led_version = obj->integer.value;
> -	else
> -		return -EIO;
>  
> -	wpriv->cdev[led_type].max_brightness = LED_ON;
> -	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
> +		/*
> +		 * Output parameters define: 0 means mute LED is not supported, Non-zero means
> +		 * mute LED can be supported.
> +		 */
> +		if (led_version == 0)
> +			return 0;
> +	} else {
> +		return -EIO;
> +	}
>  
>  	switch (led_type) {
>  	case MIC_MUTE:
> -		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> -			return -EIO;
> +		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
> +			pr_warn("This device MIC_MUTE LED doesn't support now.\n");
> +			return 0;
> +		}
>  
>  		wpriv->cdev[led_type].name = "platform::micmute";
>  		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_micmute_led_set;
>  		wpriv->cdev[led_type].default_trigger = "audio-micmute";
>  		break;
>  	case AUDIO_MUTE:
> -		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> -			return -EIO;
> +		if (led_version != WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
> +			pr_warn("This device AUDIO_MUTE LED doesn't support now.\n");

Both of these warnings have the same grammar flaws and need to be 
rephrased.

> +			return 0;
> +		}
>  
>  		wpriv->cdev[led_type].name = "platform::mute";
>  		wpriv->cdev[led_type].brightness_set_blocking = &lsh_wmi_audiomute_led_set;
> @@ -152,6 +161,9 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>  		return -EINVAL;
>  	}
>  
> +	wpriv->cdev[led_type].max_brightness = LED_ON;
> +	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
> +
>  	err = devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>  	if (err < 0) {
>  		dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
> 

-- 
 i.


