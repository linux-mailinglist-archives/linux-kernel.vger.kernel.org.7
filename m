Return-Path: <linux-kernel+bounces-757646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4BB1C4BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AFA1886428
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2623BF83;
	Wed,  6 Aug 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krnQTm+f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0133AC1C;
	Wed,  6 Aug 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479170; cv=none; b=WH6+ypt6crfutaP/mtINd2X7bwBf69YdS/52ReSqibyxoh1Nb/AtDSd0ry1oogczwbP9lTB8jtQ5Lde69SM+SunB2ZQDrBat/TO8SDzjAMjKeK+K6T1AtSSxNPBm5HPd39ssdGjams3yiyGDp7qjwsqc7VIptDYifFBTKK6feWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479170; c=relaxed/simple;
	bh=YKoDj2cMvbHQnSU2/3MKtBhO0T8+FZcgtMQAWa50V70=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U0TKKz2HE9jMVIAReVogwabCJHzEF/khGi1nwPCNr6Of5v8IvjcQcwduBTZNYw0j2CoScKhyxkyLJgAEaAXVnXKPHQokTXCmwFyE0nZC6GwY5gozckinYiYxlJKoCFPA2f3WXyUz9o0bCwQfNMOcceYALEvBFQZqX003Nwz/3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krnQTm+f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754479169; x=1786015169;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YKoDj2cMvbHQnSU2/3MKtBhO0T8+FZcgtMQAWa50V70=;
  b=krnQTm+fE1TwONIQ7yhS3GaXlpTaGHF4FjHCcQqgo8t33KBCXzAlSb8s
   qYzKhvRYXkV6AEkaryrVfrJCqRf93GY6FYOTUapI/HQ73aYmbDSGmftL9
   pWDtm3YYqKy/DXy9vz3LRot/Q36eQgRXbr8neErAiyXB6+7Ln5Ox3lqhh
   3Z2KNt3tdSrPXRp202rJxzZTXW0doKgOAS31w8U5/kdOJp3AOoKWub+iU
   c/THUyJy9YIEoy/7ob8uIHDChHGBodRVQNxSO5BrgG/m6cMwWFkGrHI9S
   3r5eCSNHdAr8j03aa82AEpmSHLl4nAC7rFw+U1N8mAsz1W0wzmHnGDCgW
   A==;
X-CSE-ConnectionGUID: rjr/yVIlQ3y3iKPgBfEMLA==
X-CSE-MsgGUID: vnM7IYb9Q9GJGxscaOyyog==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56686510"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56686510"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:19:27 -0700
X-CSE-ConnectionGUID: mN6qaBDNQXyXAPjqjHWSdA==
X-CSE-MsgGUID: cF8FolniTyid5kqV2YTzmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170015774"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:19:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Aug 2025 14:19:21 +0300 (EEST)
To: Rong Zhang <i@rong.moe>
cc: Ike Panhc <ikepanhc@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: ideapad-laptop: Decouple HW & cdev
 brightness for kbd backlight
In-Reply-To: <20250805140131.284122-2-i@rong.moe>
Message-ID: <21b856ae-eec2-ac32-fd2f-12a505e8e539@linux.intel.com>
References: <20250805140131.284122-1-i@rong.moe> <20250805140131.284122-2-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 Aug 2025, Rong Zhang wrote:

> Some recent models come with an ambient light sensor (ALS). On these
> models, their EC will automatically set the keyboard backlight to an
> appropriate brightness when the effective "HW brightness" is 3. The term
> "HW brightness" means that it cannot be perfectly mapped to an LED
> classdev brightness, but the EC does use this predefined brightness
> value to represent such a mode.
> 
> Currently, the code processing keyboard backlight is coupled with LED
> classdev, making it hard to expose the auto brightness (ALS) mode to the
> userspace.
> 
> As the first step toward the goal, decouple HW brightness from LED
> classdev brightness, and update comments about corresponding backlight
> modes.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 125 +++++++++++++------
>  1 file changed, 90 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index fcebfbaf0460..5014c1d0b633 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -119,17 +119,40 @@ enum {
>  };
>  
>  /*
> - * These correspond to the number of supported states - 1
> - * Future keyboard types may need a new system, if there's a collision
> - * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
> - * so it effectively has 3 states, but needs to handle 4
> + * The enumeration has two purposes:
> + *   - as an internal identifier for all known types of keyboard backlight
> + *   - as a mandatory parameter of the KBLC command
> + *
> + * For each type, the HW brightness values are defined as follows:
> + * +--------------------------+----------+-----+------+------+
> + * |            HW brightness |        0 |   1 |    2 |    3 |
> + * | Type                     |          |     |      |      |
> + * +--------------------------+----------+-----+------+------+
> + * | KBD_BL_STANDARD          |      off |  on |  N/A |  N/A |
> + * +--------------------------+----------+-----+------+------+
> + * | KBD_BL_TRISTATE          |      off | low | high |  N/A |
> + * +--------------------------+----------+-----+------+------+
> + * | KBD_BL_TRISTATE_AUTO     |      off | low | high | auto |
> + * +--------------------------+----------+-----+------+------+
> + *
> + * We map LED classdev brightness for KBD_BL_TRISTATE_AUTO as follows:
> + * +--------------------------+----------+-----+------+
> + * |  LED classdev brightness |        0 |   1 |    2 |
> + * | Operation                |          |     |      |
> + * +--------------------------+----------+-----+------+
> + * | Read                     | off/auto | low | high |
> + * +--------------------------+----------+-----+------+
> + * | Write                    |      off | low | high |
> + * +--------------------------+----------+-----+------+
>   */
>  enum {
> -	KBD_BL_STANDARD      = 1,
> -	KBD_BL_TRISTATE      = 2,
> -	KBD_BL_TRISTATE_AUTO = 3,
> +	KBD_BL_STANDARD		=	1,
> +	KBD_BL_TRISTATE		=	2,
> +	KBD_BL_TRISTATE_AUTO	=	3,

Pure space change for no reason. Please leave as is.

>  };
>  
> +#define KBD_BL_AUTO_MODE_HW_BRIGHTNESS	3
> +
>  #define KBD_BL_QUERY_TYPE		0x1
>  #define KBD_BL_TRISTATE_TYPE		0x5
>  #define KBD_BL_TRISTATE_AUTO_TYPE	0x7
> @@ -1559,7 +1582,25 @@ static int ideapad_kbd_bl_check_tristate(int type)
>  	return (type == KBD_BL_TRISTATE) || (type == KBD_BL_TRISTATE_AUTO);
>  }
>  
> -static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
> +static int ideapad_kbd_bl_brightness_parse(struct ideapad_private *priv,
> +					   unsigned int hw_brightness)
> +{
> +	/* Off, low or high */
> +	if (hw_brightness <= priv->kbd_bl.led.max_brightness)
> +		return hw_brightness;
> +
> +	/* Auto (controlled by EC according to ALS), report as off */
> +	if (priv->kbd_bl.type == KBD_BL_TRISTATE_AUTO &&
> +	    hw_brightness == KBD_BL_AUTO_MODE_HW_BRIGHTNESS)
> +		return 0;

There seems to be code move/function refactoring (split to get+parse) 
and changes mixed up in here as this doesn't match to what was there 
beforehand AFAICT.

Could you please try to separate the pure function refactoring from the 
changes to make the real changes easier to understand/see.

> +	/* Unknown value */
> +	dev_warn(&priv->platform_device->dev,
> +		 "Unknown keyboard backlight value: %u", hw_brightness);
> +	return -EINVAL;
> +}
> +
> +static int ideapad_kbd_bl_hw_brightness_get(struct ideapad_private *priv)
>  {
>  	unsigned long value;
>  	int err;
> @@ -1573,21 +1614,7 @@ static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
>  		if (err)
>  			return err;
>  
> -		/* Convert returned value to brightness level */
> -		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
> -
> -		/* Off, low or high */
> -		if (value <= priv->kbd_bl.led.max_brightness)
> -			return value;
> -
> -		/* Auto, report as off */
> -		if (value == priv->kbd_bl.led.max_brightness + 1)
> -			return 0;
> -
> -		/* Unknown value */
> -		dev_warn(&priv->platform_device->dev,
> -			 "Unknown keyboard backlight value: %lu", value);
> -		return -EINVAL;
> +		return FIELD_GET(KBD_BL_GET_BRIGHTNESS, value);
>  	}
>  
>  	err = eval_hals(priv->adev->handle, &value);
> @@ -1597,6 +1624,16 @@ static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
>  	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
>  }
>  
> +static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
> +{
> +	int hw_brightness = ideapad_kbd_bl_hw_brightness_get(priv);
> +
> +	if (hw_brightness < 0)
> +		return hw_brightness;
> +
> +	return ideapad_kbd_bl_brightness_parse(priv, hw_brightness);
> +}
> +
>  static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
>  {
>  	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
> @@ -1604,24 +1641,37 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
>  	return ideapad_kbd_bl_brightness_get(priv);
>  }
>  
> -static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
> +static int ideapad_kbd_bl_hw_brightness_set(struct ideapad_private *priv,
> +					    unsigned int hw_brightness)
>  {
>  	int err;
>  	unsigned long value;
>  	int type = priv->kbd_bl.type;
>  
>  	if (ideapad_kbd_bl_check_tristate(type)) {
> -		if (brightness > priv->kbd_bl.led.max_brightness)
> -			return -EINVAL;
> -
> -		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, brightness) |
> +		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS, hw_brightness) |
>  			FIELD_PREP(KBD_BL_COMMAND_TYPE, type) |
>  			KBD_BL_COMMAND_SET;
>  		err = exec_kblc(priv->adev->handle, value);
>  	} else {
> -		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
> +		err = exec_sals(priv->adev->handle,
> +				hw_brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
>  	}
>  
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
> +{
> +	int err;
> +
> +	if (brightness > priv->kbd_bl.led.max_brightness)
> +		return -EINVAL;
> +
> +	err = ideapad_kbd_bl_hw_brightness_set(priv, brightness);
>  	if (err)
>  		return err;
>  
> @@ -1638,6 +1688,16 @@ static int ideapad_kbd_bl_led_cdev_brightness_set(struct led_classdev *led_cdev,
>  	return ideapad_kbd_bl_brightness_set(priv, brightness);
>  }
>  
> +static void ideapad_kbd_bl_notify_known(struct ideapad_private *priv, unsigned int brightness)
> +{
> +	if (brightness == priv->kbd_bl.last_brightness)
> +		return;
> +
> +	priv->kbd_bl.last_brightness = brightness;
> +
> +	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightness);
> +}
> +
>  static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
>  {
>  	int brightness;
> @@ -1649,12 +1709,7 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
>  	if (brightness < 0)
>  		return;
>  
> -	if (brightness == priv->kbd_bl.last_brightness)
> -		return;
> -
> -	priv->kbd_bl.last_brightness = brightness;
> -
> -	led_classdev_notify_brightness_hw_changed(&priv->kbd_bl.led, brightness);
> +	ideapad_kbd_bl_notify_known(priv, brightness);
>  }
>  
>  static int ideapad_kbd_bl_init(struct ideapad_private *priv)
> 

-- 
 i.


