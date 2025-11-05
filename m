Return-Path: <linux-kernel+bounces-886072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9470FC34A73
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FC23B4930
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C602EDD50;
	Wed,  5 Nov 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTqpbmI9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9922ED87F;
	Wed,  5 Nov 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333152; cv=none; b=GbpPQli4s5uhVFznqmc1q54jh0CI8yHpekbbSbNPoe5foUczU8roOvWr+ovC7aLAymQPn/QgAioWMeHYp53EWBp7UtQSMLVAROJ7KyjkuTsyHHPfeMQhY7VGKNh+yYcsGdAoUvxU4JVibXmb4UNiAHD2/9JbBHoX8luPeH+h7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333152; c=relaxed/simple;
	bh=BlzFLQmpEqDuYR1gwH2rICRuzj+79Eg0r5tvJ5quCPs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ngnjROuCPuaBqIrmI24Us09L4pjn6UjJkNkVZ0phHWt2Tw/GPGVHWF/GVkiCNdmb9UCf0JPmpzPCmHJa5CziYCrTfZ7W1qVarFca6rbpzBeCiIC1LafMBbyd5Hr+WEvivTqwrQAEzM9OLZ3+DXj4M6Vn/rJGkcUvUqmxnP3ACmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTqpbmI9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762333151; x=1793869151;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BlzFLQmpEqDuYR1gwH2rICRuzj+79Eg0r5tvJ5quCPs=;
  b=kTqpbmI9Yo1vA24RR2KJhjk/iK8rt8ladgRb/pR/ntB99XqoD6BEAlMu
   ffpqrgOsrPz+ntM+wv5yw2uiwXU82R9N/yvgv8TqLKQtvAgs9jm7ArpP3
   iYppbr24UI6Zgy34udwipJORltuKr6O3WO65HD9UuA8px4krKCbnoeCPh
   jS6AhOCQ37ySTEs+dEBz2371I/83+4ZDJAQv1mSw3eEymKiG5TC9tXF1N
   9+33bk/0GIY0Luj4aCvlUGpsNWgZa/aPa1OFPYHuXgVdTGHIihMcMdaFZ
   stJSxXPVo0FvIeamA6OArUY/1tERQsKou7bfNAV3k9sU4kOACLGX6XnCN
   g==;
X-CSE-ConnectionGUID: bJFx9x24QNulKfQB5+A+qg==
X-CSE-MsgGUID: n2T0rdiNR46bxk9DFJv8oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68279517"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68279517"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:59:10 -0800
X-CSE-ConnectionGUID: Q9sGarmDTV6ZXf9wOjCpaQ==
X-CSE-MsgGUID: 2zOkKx1ETBC0SF0T9Ucg1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186687662"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:59:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 10:59:03 +0200 (EET)
To: Rong Zhang <i@rong.moe>
cc: Jelle van der Waa <jelle@vdwaa.nl>, Ike Panhc <ikepanhc@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Add charge_types:Fast
 (Rapid Charge)
In-Reply-To: <5d1ae6eb34378570ed1f9b62d945c95bda8a5b86.camel@rong.moe>
Message-ID: <f2885370-f466-6bf2-70d1-e7f3177111db@linux.intel.com>
References: <20251020192443.33088-1-i@rong.moe>  <dfa70284-04ce-482d-8d79-cc0ee8b4bf6d@vdwaa.nl> <5d1ae6eb34378570ed1f9b62d945c95bda8a5b86.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Nov 2025, Rong Zhang wrote:

> Hi Jelle,
> 
> On Sun, 2025-11-02 at 17:09 +0100, Jelle van der Waa wrote:
> > On 10/20/25 21:24, Rong Zhang wrote:
> > > The GBMD/SBMC interface on IdeaPad/ThinkBook supports Rapid Charge mode
> > > (charge_types: Fast) in addition to Conservation Mode (charge_types:
> > > Long_Life).
> > > 
> > > This patchset exposes these two modes while carefully maintaining their
> > > mutually exclusive state, which aligns with the behavior of manufacturer
> > > utilities on Windows.
> > > 
> > > Tested on ThinkBook 14 G7+ ASP.
> > 
> > Tested this patch on my Lenovo Ideapad U330p, it now advertises that 
> > `Fast` is a supported charge_type although my laptop does not seem to 
> > support it:
> > 
> > [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
> > Fast [Standard] Long_Life
> > [root@archlinux jelle]# echo 'Fast' > 
> > /sys/class/power_supply/BAT1/charge_types
> > [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
> > Fast [Standard] Long_Life
>
> Ahh, then we need an approach to determine if it is supported on a
> specific device.
> 
> Glancing at the disassembled DSDT.dsl of my device, I found:
> 
>    Method (GBMD, 0, NotSerialized)
>    {
>    	[...]
>    	If ((One == QCGS))
>    	{
>    		Local0 |= 0x00020000
>    	}
>    	[...]
>    }
> 
> BIT(17) of GBMD is 1 on my device. Maybe QCGS means "Quick CharGe
> Supported?"
> 
> With this assumption, I did some random Internet digging. The same bit
> on other devices is called QKSP ("QuicK charge SuPported?"), SQCG
> ("Support Quick CharGe?"), or QCBX (see below).
> 
>    Method (GBMD, 0, NotSerialized)
>    {
>    	[...]
>    	If ((One == QCBX))
>    	{
>    		If ((One == QCHO))
>    		{
>    			Local0 |= 0x04
>    		}
>    	}
>    	[...]
>    	If ((One == QCBX))
>    	{
>    		Local0 |= 0x00020000
>    	}
>    	[...]
>    }
> 
> https://badland.io/static/acpidump.txt
> 
> 0x04 is BIT(2)/GBMD_RAPID_CHARGE_STATE_BIT. With all these pieces of
> information, I presume BIT(17) of GBMD is what we are searching for.
> 
> > I'm wondering if the battery extension API allows to not advertise a 
> > property if it isn't supported or if it should at least return -EINVAL.
> 
> We can achieve this by defining multiple struct power_supply_ext. See
> drivers/power/supply/cros_charge-control.c.
> 
> Could you test the patch below (based on "review-ilpo-next")?
> 
> @Ilpo:
> 
> This patch series has been merge into your "review-ilpo-next" branch.
> 
> Should I reorganize the series and send a [PATCH v2]? Or should I just
> send the patch below (after adding a commit message, ofc)?

Hi Rong,

I've dropped those two v1 patches from the review-ilpo-next branch.

(They are still in for-next but will be gone from there as well on the 
next review-ilpo-next -> for-next propagation.)

So please send the full series with this fixed as v2. You can include the 
str_on_off() change also within the v2 series.

-- 
 i.

> > Greetings,
> > 
> > Jelle van der Waa
> 
> Thanks,
> Rong
> 
> ---
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 931a72a2a487..b9927493cb93 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -75,6 +75,7 @@ enum {
>  enum {
>  	GBMD_RAPID_CHARGE_STATE_BIT = 2,
>  	GBMD_CONSERVATION_STATE_BIT = 5,
> +	GBMD_RAPID_CHARGE_SUPPORTED_BIT = 17,
>  };
>  
>  enum {
> @@ -180,6 +181,7 @@ struct ideapad_private {
>  	struct ideapad_dytc_priv *dytc;
>  	struct dentry *debug;
>  	struct acpi_battery_hook battery_hook;
> +	const struct power_supply_ext *battery_ext;
>  	unsigned long cfg;
>  	unsigned long r_touchpad_val;
>  	struct {
> @@ -2119,30 +2121,42 @@ static const enum power_supply_property ideapad_power_supply_props[] = {
>  	POWER_SUPPLY_PROP_CHARGE_TYPES,
>  };
>  
> -static const struct power_supply_ext ideapad_battery_ext = {
> -	.name			= "ideapad_laptop",
> -	.properties		= ideapad_power_supply_props,
> -	.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),
> -	.charge_types		= (BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
> -				   BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
> -				   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)),
> -	.get_property		= ideapad_psy_ext_get_prop,
> -	.set_property		= ideapad_psy_ext_set_prop,
> -	.property_is_writeable	= ideapad_psy_prop_is_writeable,
> -};
> +#define DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(_name, _charge_types)			\
> +	static const struct power_supply_ext _name = {					\
> +		.name			= "ideapad_laptop",				\
> +		.properties		= ideapad_power_supply_props,			\
> +		.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),	\
> +		.charge_types		= _charge_types,				\
> +		.get_property		= ideapad_psy_ext_get_prop,			\
> +		.set_property		= ideapad_psy_ext_set_prop,			\
> +		.property_is_writeable	= ideapad_psy_prop_is_writeable,		\
> +	}
> +
> +DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v1,
> +	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
> +	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
> +);
> +
> +DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v2,
> +	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
> +	 BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
> +	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
> +);
>  
>  static int ideapad_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
>  {
>  	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
>  
> -	return power_supply_register_extension(battery, &ideapad_battery_ext,
> +	return power_supply_register_extension(battery, priv->battery_ext,
>  					       &priv->platform_device->dev, priv);
>  }
>  
>  static int ideapad_battery_remove(struct power_supply *battery,
>  				  struct acpi_battery_hook *hook)
>  {
> -	power_supply_unregister_extension(battery, &ideapad_battery_ext);
> +	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
> +
> +	power_supply_unregister_extension(battery, priv->battery_ext);
>  
>  	return 0;
>  }
> @@ -2167,14 +2181,22 @@ static int ideapad_check_features(struct ideapad_private *priv)
>  		priv->features.fan_mode = true;
>  
>  	if (acpi_has_method(handle, "GBMD") && acpi_has_method(handle, "SBMC")) {
> -		priv->features.conservation_mode = true;
> -		priv->battery_hook.add_battery = ideapad_battery_add;
> -		priv->battery_hook.remove_battery = ideapad_battery_remove;
> -		priv->battery_hook.name = "Ideapad Battery Extension";
> -
> -		err = devm_battery_hook_register(&priv->platform_device->dev, &priv->battery_hook);
> -		if (err)
> -			return err;
> +		/* Not acquiring gbmd_sbmc_mutex as race condition is impossible on init */
> +		if (!eval_gbmd(handle, &val)) {
> +			priv->features.conservation_mode = true;
> +			priv->battery_ext = test_bit(GBMD_RAPID_CHARGE_SUPPORTED_BIT, &val)
> +					  ? &ideapad_battery_ext_v2
> +					  : &ideapad_battery_ext_v1;
> +
> +			priv->battery_hook.add_battery = ideapad_battery_add;
> +			priv->battery_hook.remove_battery = ideapad_battery_remove;
> +			priv->battery_hook.name = "Ideapad Battery Extension";
> +
> +			err = devm_battery_hook_register(&priv->platform_device->dev,
> +							 &priv->battery_hook);
> +			if (err)
> +				return err;
> +		}
>  	}
>  
>  	if (acpi_has_method(handle, "DYTC"))
> 

