Return-Path: <linux-kernel+bounces-757653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F230EB1C4D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A408018C0D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C826A0D5;
	Wed,  6 Aug 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7DgaPdr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75576433C8;
	Wed,  6 Aug 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479639; cv=none; b=LGuAxS+3ORbJB/EMXHmBV3NQR/SCeRndVYYWVe/RE7/a7aOd2XBAtxC2WuD0BIx6G5lrZCWdVMcCejRQ9I9d3ZM7YrCYs2FQqETqHVCw/nKKgDs+i/FlP0P7hi4/tSaELwA+CGSLltdRUADEhQEsE2SxS3vTEaustGmUTrCpxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479639; c=relaxed/simple;
	bh=SUL12yiALrrYQVurDqvFUFZvMfjm0vQJNdkY7p2+v7o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KXfwa++IGA/EOsc/fIBEmConsfbAQfsZVpLi4xJfOvkJSYsv5hzePmVhuPCo3r3ShjmsSGIRhxLvxQ512Bm5hQ4XwZlLtYPhuTMVA62AYQ0di7A+MCAFzYw1LLmHnbQfuIOC4JZtJLrzZqj3PqYZKwvGr3guj96McVNTPgti2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7DgaPdr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754479638; x=1786015638;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SUL12yiALrrYQVurDqvFUFZvMfjm0vQJNdkY7p2+v7o=;
  b=i7DgaPdr+DK4FnX5VtFG++MUbEF/wDe8va3T7bbMm5FsUjRQyxbaJT8z
   zexSa9wCwFxI6JrQU07SP5X4W0TxSg/pFhN6+KBiTyZa05Eo/DvXqCPFD
   dEpXU4RHL6h7fDgqhIao8+bMVsjRl7WOmoIZQblrP0aFFmHfWJro5AYm1
   uVBTGcv2ySI2c5dL+xEUqZ3uybc4//qL0vOiUpKBCxnn/gU2jAkQRcsen
   VMiJV7ncoVagjr1ZuHbNBhwG03Ti4Lh2SQu8NWphCQY7PwkkSvrspcDqp
   qZ5sMzFTMYoQuFC2/k2d9qzqKEAvRYIwe1XRBFy5ihFT0NmVOXSQUdiBg
   Q==;
X-CSE-ConnectionGUID: HRMKU2S+RxyESxB1W7y1gg==
X-CSE-MsgGUID: sKN+sS4IQ4uvwOMUMgwDLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56506899"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56506899"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:27:17 -0700
X-CSE-ConnectionGUID: xvThYN9ASSS/aYE6CCy/8w==
X-CSE-MsgGUID: ZX25GWJHTCa3/JTKFsaICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165121799"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:27:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Aug 2025 14:26:59 +0300 (EEST)
To: Rong Zhang <i@rong.moe>
cc: Ike Panhc <ikepanhc@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: Fully support auto
 kbd backlight
In-Reply-To: <20250805140131.284122-3-i@rong.moe>
Message-ID: <9a2fad3c-66d5-c877-698b-a9b5a589f081@linux.intel.com>
References: <20250805140131.284122-1-i@rong.moe> <20250805140131.284122-3-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 Aug 2025, Rong Zhang wrote:

> Currently, the auto brightness mode of keyboard backlight maps to
> brightness=0 in LED classdev. The only method to switch to such a mode
> is by pressing the manufacturer-defined shortcut (Fn+Space). However, 0
> is a multiplexed brightness value; writing 0 simply results in the
> backlight being turned off.
> 
> With brightness processing code decoupled from LED classdev, we can now
> fully support the auto brightness mode. In this mode, the keyboard
> backlight is controlled by the EC according to the ambient light sensor
> (ALS).
> 
> To utilize this, a sysfs node is exposed to the userspace:
> /sys/class/leds/platform::kbd_backlight/als_enabled. The name is chosen
> to align with dell-laptop, which provides a similar feature.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  .../ABI/testing/sysfs-platform-ideapad-laptop | 12 ++++
>  drivers/platform/x86/lenovo/ideapad-laptop.c  | 65 ++++++++++++++++++-
>  2 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> index 5ec0dee9e707..a2b78aa60aaa 100644
> --- a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> +++ b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> @@ -50,3 +50,15 @@ Description:
>  		Controls whether the "always on USB charging" feature is
>  		enabled or not. This feature enables charging USB devices
>  		even if the computer is not turned on.
> +
> +What:		/sys/class/leds/platform::kbd_backlight/als_enabled
> +Date:		July 2025
> +KernelVersion:	6.17

This ship has sailed.

> +Contact:	platform-driver-x86@vger.kernel.org
> +Description:
> +		This file allows to control the automatic keyboard

Please avoid using "This file" entirely in the description.

Start with "Controls ..."

> +		illumination mode on some systems that have an ambient
> +		light sensor. Write 1 to this file to enable the auto
> +		mode, 0 to disable it. In this mode, the actual

What is "this mode" ? Did you mean, e.g., "When the auto mode is enabled,"
?

> +		brightness level is not available and reading the
> +		"brightness" file always returns 0.
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 5014c1d0b633..49f2fc68add4 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -1712,6 +1712,57 @@ static void ideapad_kbd_bl_notify(struct ideapad_private *priv)
>  	ideapad_kbd_bl_notify_known(priv, brightness);
>  }
>  
> +static ssize_t als_enabled_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
> +	int hw_brightness;
> +
> +	hw_brightness = ideapad_kbd_bl_hw_brightness_get(priv);
> +	if (hw_brightness < 0)
> +		return hw_brightness;
> +
> +	return sysfs_emit(buf, "%d\n", hw_brightness == KBD_BL_AUTO_MODE_HW_BRIGHTNESS);
> +}
> +
> +static ssize_t als_enabled_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct ideapad_private *priv = container_of(led_cdev, struct ideapad_private, kbd_bl.led);
> +	bool state;
> +	int err;
> +
> +	err = kstrtobool(buf, &state);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Auto (ALS) mode uses a predefined HW brightness value. It is
> +	 * impossible to disable it without setting another brightness value.
> +	 * Set the brightness to 0 when disabling is requested.
> +	 */
> +	err = ideapad_kbd_bl_hw_brightness_set(priv, state ? KBD_BL_AUTO_MODE_HW_BRIGHTNESS : 0);
> +	if (err)
> +		return err;
> +
> +	/* Both HW brightness values map to 0 in the LED classdev. */
> +	ideapad_kbd_bl_notify_known(priv, 0);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(als_enabled);
> +
> +static struct attribute *ideapad_kbd_bl_als_attrs[] = {
> +	&dev_attr_als_enabled.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(ideapad_kbd_bl_als);
> +
>  static int ideapad_kbd_bl_init(struct ideapad_private *priv)
>  {
>  	int brightness, err;
> @@ -1722,10 +1773,20 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
>  	if (WARN_ON(priv->kbd_bl.initialized))
>  		return -EEXIST;
>  
> -	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
> +	switch (priv->kbd_bl.type) {
> +	case KBD_BL_TRISTATE_AUTO:
> +		/* The sysfs node will be /sys/class/leds/platform::kbd_backlight/als_enabled */
> +		priv->kbd_bl.led.groups = ideapad_kbd_bl_als_groups;
> +		fallthrough;
> +	case KBD_BL_TRISTATE:
>  		priv->kbd_bl.led.max_brightness = 2;
> -	} else {
> +		break;
> +	case KBD_BL_STANDARD:
>  		priv->kbd_bl.led.max_brightness = 1;
> +		break;
> +	default:
> +		/* This has already been validated by ideapad_check_features(). */
> +		unreachable();
>  	}
>  
>  	brightness = ideapad_kbd_bl_brightness_get(priv);
> 

-- 
 i.


