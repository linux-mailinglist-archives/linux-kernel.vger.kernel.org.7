Return-Path: <linux-kernel+bounces-758193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119FBB1CC42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACFD3BB636
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0E28DEE1;
	Wed,  6 Aug 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="hqhFUANA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCpGNyfs"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B803FE7;
	Wed,  6 Aug 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506970; cv=none; b=S9RdzgFsghRYBTLUfNpWZ22omCbza+7YMBMuaXijQUqQd8CHqSxrVpw9CuK0/IJ46ZD6I1HwJc9uHaYEeM8k3M+wurseFl6o4iIt65fgmlwIK+SpdIIWF8SenhqxMWh03+lKdtG3ZwnpQQShfKaXel0U8/5G/0qni9mT0Urvm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506970; c=relaxed/simple;
	bh=tXFLtgw/WIrtmxowOosI5IDtAvPuOqYtwJlPOZvgwSk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K9A2QaxtuPGrYShDH5nGCWjXUY7A6RZ1tjXHHp2n+qFMBTj2sp97BwJwW0GHOBfaby03MX1LSG9vNXFS+O1cc1c8Ls4z5Azdzk4G7MxJ3Y5jafcCCPpZj0vJjU6cxvE+e15DgMih7vYNm1pgW3f8gK3GWao2SnPXh2aXEl6cFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=hqhFUANA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCpGNyfs; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96B821400073;
	Wed,  6 Aug 2025 15:02:46 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Wed, 06 Aug 2025 15:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754506966;
	 x=1754593366; bh=He2AOiU5K/SLmDfh9naFQfRlDHY1TiV6PJ1MxNToYGs=; b=
	hqhFUANAQ+TGiXHvhQ6yfmyZE7SV+ASnQF2d70pwfDe+pVg1akmOpgbZFzL8HOcI
	3ztO2xZ+onHQM+olhZQCBnH75tjmpM4AZ8muAqyt2vssCuuNOF8gnwU+Qzxp+MqE
	QDbehM41qOvsf3xLCFdal5u+pKG/IDQSY911Q1CN/xdR7gQWromOrs0f1mJUxwUc
	ioxVTOyaP2paFTFSRNcp/dqlKh9oXIR0HC9JLGl03YNs2SWVKpxq9MIy9bQ+b1/8
	6nF6waYPNlNAwaCPachv5zW2IxCx9Te6HuRixukMY3gbCc/CduLcN9LFJTox80Nf
	HKls1+Fd9wzqaFI+MjCrbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754506966; x=
	1754593366; bh=He2AOiU5K/SLmDfh9naFQfRlDHY1TiV6PJ1MxNToYGs=; b=U
	CpGNyfsw/Eu/78tBnVRQTw6VHPqaFAmq8LeNyD3Ijm6Mk3rtlKh3hFNyxTv5594o
	S1pWd7xHWQnndYpyQXWKy/YgYNDGlR3sPLO9beHJfK9+Yhz3SIu2uZvBALu3ugT5
	Kmo9+9MHP8vP4KaCNRp+nxWYlM6PGpjJEu/mOZjxLzIxKBtIO/6KLP83/D6obuSW
	nUWyvR/z+nTfU9ZbdkHAFae+qAF7dPJmhAmUqIMG3591IFkeYUmpm4sBSKkF3NRX
	NnYqCcC/Gg+e3qJT0BbvJGrGkRfIKu8FL17eBEAmK3gcdmYr2XhvLHhDrIsKuna9
	0162Uf8dcm4YIh2sBiidw==
X-ME-Sender: <xms:1aaTaPAslru4XgnpXXer9DXkuXL5sBUSnVE0gsoBIwk_6xGvNRxNgg>
    <xme:1aaTaFjehqCInlNJr-JDNL9-UQjSKfTjM70xtb-TdcWSejnx45e_3OaV8vJZK3OAz
    sjTgbenRPmBR139Vrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvg
    hkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhkvghprghn
    hhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehisehrohhnghdrmhhovgdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhf
    ohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1aaTaHkq0PZ-cyNhtbKMZhD20BrRHr6ih-oT1FwDQSQmv3TzJ1Jy0g>
    <xmx:1aaTaHyJ48VwEcoq1l5co53BslfUZYpXyAKqkkFvIv-Tz5BusUOZzw>
    <xmx:1aaTaJQPoGqtymVjcB0bQ9rx_bm6pNPoU57MGhVbaSW3eL6D3X5drQ>
    <xmx:1aaTaH8o1BCPmkEu9IccKtHqVq8niduvczAg_FKYQFrqLZS7L7Xpow>
    <xmx:1qaTaBj0ZKE4tvfgVTl1-mWV2Yi0PxezA-XdBVxgexlVQxhqVez0DWUm>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA35E2CE0071; Wed,  6 Aug 2025 15:02:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T64782356407e243d
Date: Wed, 06 Aug 2025 15:02:25 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rong Zhang" <i@rong.moe>, "Ike Panhc" <ikepanhc@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hansg@kernel.org>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <08580ec5-1d7b-4612-8a3f-75bc2f40aad2@app.fastmail.com>
In-Reply-To: <20250805140131.284122-3-i@rong.moe>
References: <20250805140131.284122-1-i@rong.moe>
 <20250805140131.284122-3-i@rong.moe>
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: Fully support auto kbd backlight
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Rong,

On Tue, Aug 5, 2025, at 10:01 AM, Rong Zhang wrote:
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
> diff --git a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop 
> b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
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
> +Contact:	platform-driver-x86@vger.kernel.org
> +Description:
> +		This file allows to control the automatic keyboard
> +		illumination mode on some systems that have an ambient
> +		light sensor. Write 1 to this file to enable the auto
> +		mode, 0 to disable it. In this mode, the actual
> +		brightness level is not available and reading the
> +		"brightness" file always returns 0.
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c 
> b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 5014c1d0b633..49f2fc68add4 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -1712,6 +1712,57 @@ static void ideapad_kbd_bl_notify(struct 
> ideapad_private *priv)
>  	ideapad_kbd_bl_notify_known(priv, brightness);
>  }
> 
> +static ssize_t als_enabled_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct ideapad_private *priv = container_of(led_cdev, struct 
> ideapad_private, kbd_bl.led);
> +	int hw_brightness;
> +
> +	hw_brightness = ideapad_kbd_bl_hw_brightness_get(priv);
> +	if (hw_brightness < 0)
> +		return hw_brightness;
> +
> +	return sysfs_emit(buf, "%d\n", hw_brightness == 
> KBD_BL_AUTO_MODE_HW_BRIGHTNESS);
> +}
> +
> +static ssize_t als_enabled_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct ideapad_private *priv = container_of(led_cdev, struct 
> ideapad_private, kbd_bl.led);
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
> +	err = ideapad_kbd_bl_hw_brightness_set(priv, state ? 
> KBD_BL_AUTO_MODE_HW_BRIGHTNESS : 0);
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
> @@ -1722,10 +1773,20 @@ static int ideapad_kbd_bl_init(struct 
> ideapad_private *priv)
>  	if (WARN_ON(priv->kbd_bl.initialized))
>  		return -EEXIST;
> 
> -	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
> +	switch (priv->kbd_bl.type) {
> +	case KBD_BL_TRISTATE_AUTO:
> +		/* The sysfs node will be 
> /sys/class/leds/platform::kbd_backlight/als_enabled */
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
> -- 
> 2.50.1

We're looking to implement this feature on the Thinkpads, so this change is timely :)

I did wonder if we should be making changes at the LED class level? Something similar to LED_BRIGHT_HW_CHANGED maybe as a way to advertise that auto mode is supported and some hooks to support that in sysfs?
I know it would be more work, but I'm guessing this is going to be a common feature across multiple vendors it might need doing at a common layer.

As a note - on the Thinkpads we've had to look at getting the correct Intel ISH firmware loaded (and we're working on getting that upstream to linux-firmware). Is that needed on the Ideapads for the feature to work well or not?

Mark

