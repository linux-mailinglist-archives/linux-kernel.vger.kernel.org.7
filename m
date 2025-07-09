Return-Path: <linux-kernel+bounces-723136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A4AFE35C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8723AA348
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B896280CEA;
	Wed,  9 Jul 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2lTwBGJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448727A90A;
	Wed,  9 Jul 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051513; cv=none; b=WCXJvPCR/Rf3GM2FScWJPye/6nQuPiHZYgvBG7CnMDCRjmZL/hcl1h4M02hjRgnMZfZzdhV/xa03aifjC3OF5dOd3tFovD3Sk2fB2H5RrXi4Fyk8Sv+1fCgioJpj2QvjTWmz1Olsybj29K6/kCCgogqkhF4W6g7BcPdGF5whrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051513; c=relaxed/simple;
	bh=Nv/Nl8b0seZtopXBoNjco8cc0bW8jMDZef7vlC8WXDk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mDLrEHHoNE7A0TOZkbj+WDz5lzHzzY96BNSwXQjGYkkD0rOyMGo/EKyDAaxNzbo/t1gfeioWJ3xqm1I7w47zZ38bth3BrLd2serBZ1Lv67OULui6UXmlz625rG+9muoXHfK59sUEi25weXx4cUM1RIl1oTd1rNCtHobhNH6UbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2lTwBGJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051512; x=1783587512;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nv/Nl8b0seZtopXBoNjco8cc0bW8jMDZef7vlC8WXDk=;
  b=b2lTwBGJeoEwdOl+Nev8Phdb/h2i6taGTqC+kLku90LeYDtD/SRh2QcA
   L5y0emGr09TvHz/GW5ayYazwBkFqpBqbvdC0PRKenTLgxNiFXVYfqkQx/
   GIET1ibPP4g2asfdefPVZCXIajUiVrUUEg7ioY9IfFfhz5yWvX9sDdXEK
   jNPGxG47lcqf6QDUaAGKLJ/jL6F4kPpxFohka/QlXSFlBMSb2OE84qcIu
   QB0kpnuu8mNJV1LgZzfU/Wx/iK+lmhascQkalxI/qvtWLp+8ZwZGczJjV
   Zeo6tmKBXCJgJDort9akpofHQw2Hc8Q7d8EsMNVtq3GSouu1i+TrYwaGM
   Q==;
X-CSE-ConnectionGUID: qDN0TkkQTvenne3RI6Q6wQ==
X-CSE-MsgGUID: aaySw6I9SsaYYkyYlQ9t6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54188245"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54188245"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:58:31 -0700
X-CSE-ConnectionGUID: 4uVEJ6gFSkOwAI8f0qezxw==
X-CSE-MsgGUID: j17kUzaoRH+1qBJwHDxInQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156300494"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:58:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Jul 2025 11:58:26 +0300 (EEST)
To: Jackie Dong <xy-jackie@139.com>
cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dongeg1@lenovo.com
Subject: Re: [PATCH v4] lenovo-wmi-hotkey: Fixed a kernel bug failed with
 error -5
In-Reply-To: <20250709035716.36267-1-xy-jackie@139.com>
Message-ID: <3c6f550d-6db4-66d4-f19c-59759450d454@linux.intel.com>
References: <20250709035716.36267-1-xy-jackie@139.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Jul 2025, Jackie Dong wrote:

> Not all of Lenovo non-ThinkPad devices support both mic mute LED (on F4)
> and audio mute LED (on F1). Some of them only support one mute LED, some
> of them don't have any mute LED. Add a decision to judge this device
> support mute LED or not. Without this decision, not support both of mic
> mute LED and audio mute LED Lenovo non-ThinkPad brand devices (including
> Ideapad/Yoga/Xiaoxin/Gaming/ThinkBook, etc.) will report a failed message
> with error -5.
> 
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Hans de Goede <hansg@kernel.org>

Thanks. I applied this to the review-ilpo-fixes branch after doing major 
rephrasing to the changelog.

-- 
 i.

> ---
> Changes in v4:
>  - Simplify the logic code as (!obj || obj->type != ACPI_TYPE_INTEGER).
>  - Drop "now" of the warning messages.
> 
> Changes in v3:
>  - Reverse orignal logic  (obj && obj->type == ACPI_TYPE_INTEGER)
>    and add new decision for (led_version == 0).
>  - Optimize the descriptions based on reviewer comments.
> 
> Changes in v2:
>  - Add warning message and then return 0 if the device support mute LED
>    abnormaly, based on Hans suggestion and Armin previous patch.
> 
> ---
>  .../x86/lenovo-wmi-hotkey-utilities.c         | 30 +++++++++++++------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> index 89153afd7015..7b9bad1978ff 100644
> --- a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -122,26 +122,35 @@ static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type, struct
>  		return -EIO;
>  
>  	union acpi_object *obj __free(kfree) = output.pointer;
> -	if (obj && obj->type == ACPI_TYPE_INTEGER)
> -		led_version = obj->integer.value;
> -	else
> +	if (!obj || obj->type != ACPI_TYPE_INTEGER)
>  		return -EIO;
>  
> -	wpriv->cdev[led_type].max_brightness = LED_ON;
> -	wpriv->cdev[led_type].flags = LED_CORE_SUSPENDRESUME;
> +	led_version = obj->integer.value;
> +
> +	/*
> +	 * Output parameters define: 0 means mute LED is not supported, Non-zero means
> +	 * mute LED can be supported.
> +	 */
> +	if (led_version == 0)
> +		return 0;
> +
>  
>  	switch (led_type) {
>  	case MIC_MUTE:
> -		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> -			return -EIO;
> +		if (led_version != WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
> +			pr_warn("The MIC_MUTE LED of this device isn't supported.\n");
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
> +			pr_warn("The AUDIO_MUTE LED of this device isn't supported.\n");
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

