Return-Path: <linux-kernel+bounces-866860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035EC00DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BE23B237D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4230E0DF;
	Thu, 23 Oct 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heIMM9NU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B930DEA6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219666; cv=none; b=fnbINhN9QPrEPZFb8/vjgHI66qv57jJ69kAcAkI9FtVo9MDrI3/CzqkAW4HYBEfQTyZZ2PssZRJdRZdW8Snh7fYseZuFvQaax0MuE/TGWYG8d6v4+zf7kUvPbkeu5OZoMbtiN2DTiUWyOuOv144ADC3OgqOH6IB9aOQWXnjXL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219666; c=relaxed/simple;
	bh=JfGhgHwpLMY8ZN7NE0j1mONCcInEbkiYXtkGIpf9Hnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lz6SIZFPkOv6D/jZhc84XuvXCAKkOgcG1vaRQl/ZdDSbfbBhNQZ+y6NF9NiNk5ZyJDW6DHyYhGk9Ic0BQs5V/iQYX2aS4mdFheINzW6oaAkEcjr1yAaEiKvJnKYk3KtWdGijWgfu0S5T/zlRtJyU3vxybB/GOrT8BSsNlT2u5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heIMM9NU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761219663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JTfoGAYLgYIX6GNAITLHC8PU3VE7pVSsb7UI9EQm0+E=;
	b=heIMM9NUhKGV+HSw0hxBs7ePTTLuxvaP0TL7YiC3VdMbzbNsIWlgmVImTe8l9nozKwliKF
	TW0q8nU5WLjo69l228qNsOC2l35tdHIgDRlyHaoQQqHjDmZ3Z8WPYy4PE0k0HWIIa/eOJO
	/tXat0R3R/8VNGGgQau95xlhyhaC3fA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-wV3gMAmSOf2BZiHRqfnFog-1; Thu, 23 Oct 2025 07:41:01 -0400
X-MC-Unique: wV3gMAmSOf2BZiHRqfnFog-1
X-Mimecast-MFC-AGG-ID: wV3gMAmSOf2BZiHRqfnFog_1761219661
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4283bf5b764so336143f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219660; x=1761824460;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTfoGAYLgYIX6GNAITLHC8PU3VE7pVSsb7UI9EQm0+E=;
        b=vCV5+Z9Q0Xy8jaZ8atSqQjw96+86Hg8IGWWoC9MpNGks7fGiK1fc0Y5l0NuhfC87bG
         d/PDQNnLwGmVun5/OxgWVL6L2UKM9yZ3zJRUYetyKPeUhwK6wV/sRZb8kf4Q8VPfoS0V
         +M5g+Pp/jxY0GfLe+JW/bW6a6PPbn9MrBqMFBkk+fDJD2EH5cBNm21IEXNzt16jNWPPa
         rfUDz5EdC+i9KblfnpheBvMO7GPXq2ouNkb70rghD3ht8JnHv9isvMltMkas8PmNrKa1
         OwrxVRI53Xk84zOzqagYzjU4/Ff4Re+rOeY1Whtsrz40yNHSRK7T52DNwRGUwhPUwQam
         gteg==
X-Forwarded-Encrypted: i=1; AJvYcCUJu5v1Zru748ScRUB7gi7TKeE+EZGx0fNwesOkhNWKcQaLvcxJndrFt8GPZIysDMEjHLh75QjgWQTmcB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFplzE3QSNZ+sLzjrVwedB2ygQdcV9LwpBSwDFDSQ+1fdPbFDd
	gJdEcrr02WTrA9diP12X7a6F24YzUkwjLGYjfF/pSHlBb9zAg8ac/ssFO7a+3mBJEN087AUn/K7
	rjR/T1OfrwBDoxNG5DHjp9icAN1P4ljKKG0Ym+kYhaOMI6lW1R6w8vBzsRxRWh/Vl2Q==
X-Gm-Gg: ASbGnctoO4lY8KmPTxP3Qk6hoZn04P9qjRjfOYJXx8u5bASidpSRe16iMbYjKLARaXQ
	UNa67ggw2WXu+g5NX8Mm1F+winiw2n34Z/y/n2k0qpC6W4IvbFfZHLSLP3ntkJ0oqYMOzmY3Cvz
	gvHEKh38GB3iN+Neg5qN0Yad35N0sx4DyZTRwaJ99enuImyFhMuyCqd20d2yNge8nbrhkSbOEE1
	qWhej893hN1DXnUQ0jiyPZvYMgLENZYorOXfcdPPKxRW3bYPu1SmXUA7nUHpPAvVvGEJ4a8mxyS
	CggowLHfjbA3htMa7AhcQfEtOLnLwHH4Lkgc0HEk/WcM0UMuleLu8umvqE8xmxKS9FlmObH3Fvt
	t+byu2Gs5bO2gueFkK8HKSbml5eTBTPOPtX+28pNz4bMSu2Kfv7NHzaWdzw==
X-Received: by 2002:a05:6000:290d:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-42709d787bemr16501617f8f.47.1761219660470;
        Thu, 23 Oct 2025 04:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGga/dbFzBh/7CGunH02MO0/qgRvCo8R5WOxXoe6UrfNz3I55XAJXxS7UJN68rIPt2eReX/zA==
X-Received: by 2002:a05:6000:290d:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-42709d787bemr16501585f8f.47.1761219659993;
        Thu, 23 Oct 2025 04:40:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acd69sm3562102f8f.24.2025.10.23.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Mark Brown
 <broonie@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Herve Codina
 <herve.codina@bootlin.com>, David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nikita Shubin
 <nikita.shubin@maquefel.me>, Axel Lin <axel.lin@ingics.com>, Brian Austin
 <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
In-Reply-To: <d42ab1a0665f55731aabd1e9fcb31b8401b7913f.camel@gmail.com>
References: <e7873e6ce07cd92f4b5ce8880aa81b12c2a08ed3.camel@gmail.com>
 <d38779a7-a1af-49e4-b429-5ebd791e2168@sirena.org.uk>
 <d42ab1a0665f55731aabd1e9fcb31b8401b7913f.camel@gmail.com>
Date: Thu, 23 Oct 2025 13:40:58 +0200
Message-ID: <873479ong5.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Sverdlin <alexander.sverdlin@gmail.com> writes:

Hello Alexander,

> Hi Mark,
>
> On Wed, 2025-10-22 at 15:56 +0100, Mark Brown wrote:
>> > > I'm very reluctant to touch this stuff for SPI without some very careful
>> > > analysis that it's not going to cause things to explode on people, right
>> > > now things seem to be working well enough so I'm not clear we'd be
>> > > solving an actual problem.
>> 
>> > The actual problem is that i2c-core is producing "of:" prefixed uevents
>> > instead of "i2c:" prefixed uevents starting from v4.18.
>> 
>> > Most of the dual-bus ASoC CODECs are affected.
>> 
>> That's a description of what change but not of a concrete problem that
>> users are experiencing.
>
> the concrete problem Herve has experienced is that cs4271-i2c will not be
> loaded automatically starting with Linux v4.18 (commit af503716ac14
> "i2c: core: report OF style module alias for devices registered via OF").
>
>> > Now declaring "of:" to be the new I2C bus prefix for uevents starting from
>> > Linux v4.18 sounds strange.
>>

I don't find that strange at all. My opinion is that is the correct
thing to do for the following reasons:

* The struct of_device_id table (and not the struct i2c_device_id table)
  is used to match registered devices through DT / OF with I2C drivers.

* All other bus types but SPI report an MODALIAS=of: for devices that
  are registered through OF.

* I2C (and even SPI) devices registered by ACPI report a MODALIAS=acpi:
  and not a MODALIAS=i2c: or MODALIAS=spi:.

So I would claim that I2C reporting MODALIAS=of: when devices are 
registered through OF are consistent with other buses, using the same
data to both load modules and match drivers and also more consistent
on how the I2C subsystem handles registration through ACPI, OF and pdata.

Unfortunately the DT support in SPI was not complete at the time, and I
don't think it can't be changed at this time without breaking something
as Mark correctly said.

I fixed a lot of I2C drivers and DTS when doing the I2C converstion and
even with that some regressions were introduced like the one you report.

>> I think a robust solution would involve having the OF aliases namespaced
>> by bus, or just not using the OF aliases but potentially having
>> collisions if two vendors pick the same device name.
>
> But this sounds like the situation before the above mentioned commit
> af503716ac14, when both i2c and spi were symmetrically namespaced with
> i2c: and spi: respectively and contained the "compatible" stripped of the
> vendor prefix.
>

Is not the same for the reasons I mentioned above. What Mark suggests is
to encode the bus type information in the OF compatible string, while still
being consistent about the table used to report modaliases and match devices.

Maybe we could have something like the following (not much tested) patch ?

From b00f5914606fb72a5f7bdb38e63d109264261dee Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 23 Oct 2025 13:32:04 +0200
Subject: [PATCH RFC] of: Report the bus type in module alias type sub-field

The modaliases for devices registered through Device Trees don't have any
information about the bus of the device. For example, an I2C device has:

$ cat /sys/devices/platform/soc/fe804000.i2c/i2c-1/1-003c/uevent
DRIVER=ssd130x-i2c
OF_NAME=oled
OF_FULLNAME=/soc/i2c at 7e804000/oled at 3c
OF_COMPATIBLE_0=solomon,ssd1306fb-i2c
OF_COMPATIBLE_N=1
MODALIAS=of:NoledT(null)Csolomon,ssd1306fb-i2c

$ modinfo ssd130x-i2c | grep alias
alias:          of:N*T*Csolomon,ssd1309fb-i2cC*
alias:          of:N*T*Csolomon,ssd1309fb-i2c
alias:          of:N*T*Csolomon,ssd1307fb-i2cC*
alias:          of:N*T*Csolomon,ssd1307fb-i2c
alias:          of:N*T*Csolomon,ssd1306fb-i2cC*
alias:          of:N*T*Csolomon,ssd1306fb-i2c
alias:          of:N*T*Csolomon,ssd1305fb-i2cC*
alias:          of:N*T*Csolomon,ssd1305fb-i2c
alias:          of:N*T*Csinowealth,sh1106-i2cC*
alias:          of:N*T*Csinowealth,sh1106-i2c

The module aliases and compatible string have the bus (-i2c) as suffix to
denote that is a driver for a device that can be accessed through I2C.

This is done to prevent disambiguate in the case that the same device can
be accessed through another bus (i.e: SPI) and have a different driver.

To prevent this and allow to use the same compatible string for the same
device regardless of the bus type used, let's add information about the
bus type in the devide type module aliases sub-field that are reported to
user-space. The same device then will report something like following:

$ cat /sys/devices/platform/soc/fe804000.i2c/i2c-1/1-003c/uevent
DRIVER=ssd130x-i2c
OF_NAME=oled
OF_FULLNAME=/soc/i2c at 7e804000/oled at 3c
OF_COMPATIBLE_0=solomon,ssd1306fb-i2c
OF_COMPATIBLE_N=1
OF_TYPE=i2c
MODALIAS=of:NoledTi2cCsolomon,ssd1306fb-i2c

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/of/device.c | 6 ++++--
 drivers/of/module.c | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index f7e75e527667..4187decc2873 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -225,8 +225,10 @@ void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	add_uevent_var(env, "OF_NAME=%pOFn", dev->of_node);
 	add_uevent_var(env, "OF_FULLNAME=%pOF", dev->of_node);
 	type = of_node_get_device_type(dev->of_node);
-	if (type)
-		add_uevent_var(env, "OF_TYPE=%s", type);
+	if (!type)
+		type = dev_bus_name(dev);
+
+	add_uevent_var(env, "OF_TYPE=%s", type);
 
 	/* Since the compatible field can contain pretty much anything
 	 * it's not really legal to split it out with commas. We split it
diff --git a/drivers/of/module.c b/drivers/of/module.c
index 1e735fc130ad..f22ddc83ef40 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -11,6 +11,7 @@
 ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 {
 	const char *compat;
+	const char *type;
 	char *c;
 	struct property *p;
 	ssize_t csize;
@@ -24,10 +25,13 @@ ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 	if ((len > 0 && !str) || len < 0)
 		return -EINVAL;
 
+	type = of_node_get_device_type(dev->of_node);
+	if (!type)
+		type = dev_bus_name(dev);
+
 	/* Name & Type */
 	/* %p eats all alphanum characters, so %c must be used here */
-	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
-			 of_node_get_device_type(np));
+	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T', type);
 	tsize = csize;
 	if (csize >= len)
 		csize = len > 0 ? len - 1 : 0;

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


