Return-Path: <linux-kernel+bounces-764742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C8B226AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED24506358
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD502045AD;
	Tue, 12 Aug 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfCz83on"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896851F8725;
	Tue, 12 Aug 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001256; cv=none; b=AjR+Y++ut1HH0UnqUhS194RwZXM9cXj6Ey0NaL4NG9Q/J6OvfyKC5SU0IdOp4ru4nMYUJINdRWDll2pdEHdh3qhJnrzy0bgOEdaNhu+Xl8I10EhvkaEw55EtH/SebGVwro+gNc1h4vlRAkbrw/NRvfeuD1H7jzNjT9I+8Hc7UTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001256; c=relaxed/simple;
	bh=PG9jU4Dgj0SCULzHGkX9JL0XwEOVog+ojiWTjdiMFWI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VHJWxVaUMVwmlYLwuV+rvmhX1hNPZ7Ttt7z4f6TItyWjA1C2B2DvPXwMAI8USoE0fLQWzuYmPY1RtZATnSbbaQok0XFjWBGaWekkEC0iijyORgtiCUBZb1LxxcYlssEL+/9tKXTJV20YvGB41WhwgaKRmB9OOv7V89W8FkqfyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfCz83on; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755001254; x=1786537254;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PG9jU4Dgj0SCULzHGkX9JL0XwEOVog+ojiWTjdiMFWI=;
  b=GfCz83onAQYQ5+66tNgeOl8lhRFIMS55jJo9N9n5sJfc2xjAUC0aQV7Z
   KdzeBrvQP2F1hRNGauHHXyuFUIC3s96kwgt3fmLFiggMm5KqA6MYAjGsZ
   ehlu/St3rrzbgi+aezFOFmXZsnLXI1Ns91U1NfCiIQOfAbl1ooX0Pj6AB
   1N4n/c2rqCIbU2QJFR5tZX2k/VS2w8ZMqPYP6AP1DnHc2uW4O7Vpw/n9q
   wCNr+DJ39ZhvvJQjP+H3e56pGgJoM7prRS4gZVSh8Sqp9YE08sXCjntko
   cn7rQr1fipxWf6+IAoPNeOgm41RqJbi8Eoe1wZ5IaFjeC7IhxbbeyZ4lx
   w==;
X-CSE-ConnectionGUID: MVp9KzjyQsah02s4AHfksg==
X-CSE-MsgGUID: c78Ny+DyQg6FjhUVMn/Zdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74854817"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="74854817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:20:54 -0700
X-CSE-ConnectionGUID: xXoA/UnAQAiXrhbteDRdmA==
X-CSE-MsgGUID: 5PX2pxglSQKWF/8wNGVv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165816585"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:20:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Aug 2025 15:20:48 +0300 (EEST)
To: Edip Hazuri <edip@medip.dev>
cc: hansg@kernel.org, kuba@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: hp-wmi: Add support for Fn+P hotkey
In-Reply-To: <20250802213541.18791-2-edip@medip.dev>
Message-ID: <d567817f-f871-c84a-a56f-9b27fb4888f6@linux.intel.com>
References: <20250802212149.16707-2-edip@medip.dev> <20250802213541.18791-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 3 Aug 2025, edip@medip.dev wrote:

> From: Edip Hazuri <edip@medip.dev>
> 
> Newer Hp Victus (And probably newer omen) e.g. Victus 16-s1011nt that i
> own have a Fn+P shortcut intended to use with omen gaming hub for

Thanks for the patch.

It's irrelevant to record in the changelog that you own one. Just 
state what it has. :-)

> changing the performance profile. see [1]

Why isn't the key made to cycle platform profiles then?

> > hp_wmi: Unknown event_id - 27 - 0x7

Add empty line here.

> Based on the dmesg warning. I found that the key have 27 as event_id and
> 0x7 as event_data (keycode). I implemented it in the driver and now
> libinput can capture the event.

Please write changelogs in imperative tone. Don't write 'I did x' style 
sentences.

> Tested On Victus 16-s1011nt (9Z791EA) with MB 8C9C

Tested on

Missing .

> [1]: https://jpcdn.it/img/adadf6c927ffeb75afd8038f95db400a.png
> 
> Signed-off-by: Edip Hazuri <edip@medip.dev>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index db5fdee2109..6467ca27db7 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -122,6 +122,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>  	HPWMI_SANITIZATION_MODE		= 0x17,
>  	HPWMI_CAMERA_TOGGLE		= 0x1A,
> +	HPWMI_FN_P_HOTKEY		= 0x1B,
>  	HPWMI_OMEN_KEY			= 0x1D,
>  	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>  };
> @@ -280,6 +281,7 @@ struct bios_rfkill2_state {
>  static const struct key_entry hp_wmi_keymap[] = {
>  	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
>  	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY, 0x07,    { KEY_FN_P } },
>  	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
>  	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
>  	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
> @@ -981,6 +983,15 @@ static void hp_wmi_notify(union acpi_object *obj, void *context)
>  						key_code, 1, true))
>  			pr_info("Unknown key code - 0x%x\n", key_code);
>  		break;
> +	case HPWMI_FN_P_HOTKEY:
> +		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
> +		if (key_code < 0)
> +			break;
> +
> +		if (!sparse_keymap_report_event(hp_wmi_input_dev,
> +			key_code, 1, true))

This is misaligned.

> +			pr_info("Unknown key code - 0x%x\n", key_code);
> +		break;

The code looks 100% identical to that of in HPWMI_BEZEL_BUTTON. But please 
consider what I noted above about cycling platform profiles.

>  	case HPWMI_OMEN_KEY:
>  		if (event_data) /* Only should be true for HP Omen */
>  			key_code = event_data;
> 

-- 
 i.


