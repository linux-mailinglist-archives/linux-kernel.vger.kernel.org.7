Return-Path: <linux-kernel+bounces-757663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FEB1C4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D53B189A989
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E042275867;
	Wed,  6 Aug 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meP8tYEj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757B2A1BF;
	Wed,  6 Aug 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480172; cv=none; b=tWXAL9P5T/67rF0x4fwcZDcF1XIG5RMo5fOvMJ2b/VxH3IHYyGufKDXra9zcfhaGh1P7b7veFneqnLRwP2bD27CrgynnXA6Zi2BqW3ToIDgNamtqiaHGU/D8Pq+sUhARl/GAZ8sxJX6PutrLUtLiPGV+lemnhV+c2TftaqZUN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480172; c=relaxed/simple;
	bh=/c1JkBuOtHBojzROFpxkTsgPYzfasN63MXct1wNxB+o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VyrW7RzR2fGhpV3BQWFDCAotQELLUOrEmYRwzOj34ede4trGmEaFslBlx7iyhBarxT6XEHSDA3/JIi1QJVT6k1WNfX5q995pBTJ06Ev4AzkRKIzmU+UOPS9PM8qKGQ7DE7w8n9BL1fv3jCOK9xDETY5CKnEV8MrJIZmbtG6TxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meP8tYEj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754480172; x=1786016172;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/c1JkBuOtHBojzROFpxkTsgPYzfasN63MXct1wNxB+o=;
  b=meP8tYEjLwJRWiHmj6ZfukL/rtNTOhp+FJeQOgV07Ap7rHz9Q04x4cPU
   pSd0eb+Yiqtpqau4AqLT7rYMnptFAg7b6QdvhHHsiXPhfho6zCDgDDDz1
   6/V8fWx6xSWwy2LM3tQThuUgPOnc6lEpqHiZgiCOpWwqQSX7U8i1L8JP9
   agdirvbuWI2EdsMyxFfgk9vH+DLcRNJt5R3BQPsr/641/Cg85SSZFgE07
   ObLKxILilPKmWL4DLBbchxxiE3iRUElad88XT6QKoJCcvz/nze65HPlK3
   P46MgVTQzIr1x4i439b52VyxKeOGCjpJMsJbUTLNL+8SBmVEl7GXLHawE
   A==;
X-CSE-ConnectionGUID: RrA854ZWQ7eQ6qE4Uiph4A==
X-CSE-MsgGUID: DG/8RZPCSOSgCU/0l1qGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74252799"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74252799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:36:11 -0700
X-CSE-ConnectionGUID: Za+yqn57RX2aa3DtHcSe+Q==
X-CSE-MsgGUID: /4MHrO2WSrO74i95X9L+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195719009"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:36:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Aug 2025 14:35:56 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1] platform/x86: asus-wmi: Fix ROG button mapping, tablet
 mode on ASUS ROG Z13
In-Reply-To: <20250803155713.9301-1-lkml@antheas.dev>
Message-ID: <2c7476d5-2a1b-5f1a-9c75-76f74752d0da@linux.intel.com>
References: <20250803155713.9301-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 3 Aug 2025, Antheas Kapenekakis wrote:

> On commit 9286dfd5735b ("platform/x86: asus-wmi: Fix spurious rfkill on
> UX8406MA"), Mathieu adds a quirk for the Zenbook Duo to ignore the code
> 0x5f (WLAN button disable). On that laptop, this code is triggered when
> the device keyboard is attached.
> 
> On the ASUS ROG Z13 2025, this code is triggered when pressing the side
> button of the device, which is used to open Armoury Crate in Windows.
> 
> As this is becoming a pattern, where newer Asus laptops use this keycode
> for emitting events, let's convert the wlan ignore quirk to instead
> allow emitting codes, so that userspace programs can listen to it and
> so that it does not interfere with the rfkill state.
> 
> With this patch, the Z13 wil emit KEY_PROG3 and the Duo will remain
> unchanged and emit no event.

> This patch also removes the override for
> codes 0x5d and 0x5e, as those were added for completeness in the
> previous patch.

This sounds like it warrants own patch.

> While at it, add a quirk for the Z13 to switch into tablet mode when
> removing the keyboard.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 25 +++++++++++++++++++------
>  drivers/platform/x86/asus-wmi.h    |  3 ++-
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index f84c3d03c1de..6928bb6ae0f3 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -147,7 +147,12 @@ static struct quirk_entry quirk_asus_ignore_fan = {
>  };
>  
>  static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
> -	.ignore_key_wlan = true,
> +	.key_wlan_event = ASUS_WMI_KEY_IGNORE,
> +};
> +
> +static struct quirk_entry quirk_asus_z13 = {
> +	.key_wlan_event = ASUS_WMI_KEY_ARMOURY,
> +	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
>  };
>  
>  static int dmi_matched(const struct dmi_system_id *dmi)
> @@ -539,6 +544,15 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_zenbook_duo_kbd,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Z13",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow Z13"),
> +		},
> +		.driver_data = &quirk_asus_z13,
> +	},
>  	{},
>  };
>  
> @@ -636,6 +650,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_IGNORE, 0xCF, },	/* AC mode */
>  	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
>  	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
> +	{ KE_KEY, ASUS_WMI_KEY_ARMOURY, { KEY_PROG3 } },
>  	{ KE_END, 0},
>  };
>  
> @@ -655,11 +670,9 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
>  		if (atkbd_reports_vol_keys)
>  			*code = ASUS_WMI_KEY_IGNORE;
>  		break;
> -	case 0x5D: /* Wireless console Toggle */
> -	case 0x5E: /* Wireless console Enable */
> -	case 0x5F: /* Wireless console Disable */
> -		if (quirks->ignore_key_wlan)
> -			*code = ASUS_WMI_KEY_IGNORE;
> +	case 0x5F: /* Wireless console Disable / Special Key */
> +		if (quirks->key_wlan_event)
> +			*code = quirks->key_wlan_event;
>  		break;
>  	}
>  }
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index 018dfde4025e..5cd4392b964e 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -18,6 +18,7 @@
>  #include <linux/i8042.h>
>  
>  #define ASUS_WMI_KEY_IGNORE (-1)
> +#define ASUS_WMI_KEY_ARMOURY	0xffff01
>  #define ASUS_WMI_BRN_DOWN	0x2e
>  #define ASUS_WMI_BRN_UP		0x2f
>  
> @@ -40,7 +41,7 @@ struct quirk_entry {
>  	bool wmi_force_als_set;
>  	bool wmi_ignore_fan;
>  	bool filter_i8042_e1_extended_codes;
> -	bool ignore_key_wlan;
> +	int key_wlan_event;
>  	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>  	int wapf;
>  	/*
> 
> base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
> 

-- 
 i.


