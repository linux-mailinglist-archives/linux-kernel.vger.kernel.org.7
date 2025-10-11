Return-Path: <linux-kernel+bounces-849177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86BBCF590
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F5A407314
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5B27A12C;
	Sat, 11 Oct 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U85xZFnL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAC226CF1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760188157; cv=none; b=EJOU+Baj2GZucn71CnCaYmjxAKc/kWVHH2XTms4+H6QuU2CalC0ON9xXZFbkH7+RMbcTw+4P2PE56zi7+xxc/AZ5VWqa87SdoeKJrn8FqbR527/p/q93jPbIeuX474UFBiA5SHkiEZvIZ8evzCqv+AcsN+234dkM0d1xmiVsxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760188157; c=relaxed/simple;
	bh=tlkJwfNU1cVCPDhRsrqFR+Vps9eI4PoV/Fx5dERZ4Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5IwMOd96WuQXr5JMqmZVz2HxYr6CDzT927hiPfg87yTZsNwzBQ9ydrax6XmVElV+kzWsQ3D6uxZ4ZIrs0wtigg3HFkISLdfBwzdv033VLq0y6//sGqjmGSXT8yO+lUV5Umdla0Sc1OaVldkx6NXrHWKlGZr0WUmNNth44t1Xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U85xZFnL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2992997e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760188149; x=1760792949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFqG+W0h7HPgIYyh4oB9VLKX2QzoB0wmqumVtSZ2KnI=;
        b=U85xZFnL/s6LyNi08VC2ZWFtDhecXGC1aL+t9r7B2Q80j5EslV56CuZ0OpnAFYOfR0
         3hZqWXVh6NaixA++Q+mnu039jKqlgvlphyl6eH0eNxNct3kGGfr8hQJf9jATsoFMn+PJ
         USSJ3+juxDZNAO/4qvA8qIcIogcEFIwWpNtVTOSHgYsD+s3W5oqzqXHc738H6e5wKTB6
         SMMBa9KycRuaZUedtMI+mDZ/oRRIOBmAC76wwVwn1Nj1uSTjOaeevHLf/Fh7Bm51CMp5
         kQ7GSaXZycPp/CrTTkXcgrf5pMbynuFEv2R9dLSzh7NhuucdWXQzRD6+OHsREK/O+HdI
         dOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760188149; x=1760792949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFqG+W0h7HPgIYyh4oB9VLKX2QzoB0wmqumVtSZ2KnI=;
        b=T7AMI3A6r3VIt0zhKY6LMXbcbb1JbSAi6Gq0sjDXgzNfz2tzuvud0a6xbY4V1lTVrR
         76iVlrMpHLQr16b6piiGGpyQ2gf+eI0jJv1esOj26AY5226BDpFeyXX8qwqdLoRrqyxG
         YVCFMYbuOGLU3l95Mck4WMsxcNjKxzxwD0AnbmxxeajCYpjML0sgjFAdrsg9F998SoGg
         2XPrDCJR434CWXNyxjlENur5W/VjQtgRR4h7C56u5Wkt/mVDa/5DN6W+yMox/pmoyxgY
         vQA9eobscl3O1/G/ryjtR5ympm/tNymvmTYB9qA3nYWQWksx812elehvD8MvJY+x1k7s
         jX6g==
X-Forwarded-Encrypted: i=1; AJvYcCV5g4Z5Rl/4iP7JQIo4u50jCjY20BAQbcrlP/TQJlH3UVyk85x7ARJpTomaaosuqFDWAlsozf6avr5KxwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9G6Yx+JpMmn4CFcSvWQz9PaZqQdj5FMiQaS9LTvn8ZPNdbWt
	C6O9Z20LZp1r13CSnzqfX9/0+QPKblI72qCKoxmdVZw9IqgaoVLjzlRp
X-Gm-Gg: ASbGncv+GwGvSCRMXsX17knMZVBqvz2adBtMxeLfSwBqJ5khWmrXiPMcmlmcE2hQQyq
	tq3g67H7fEBKgKdkdq7WdHfj88GVghLg5mTHRGzGir2IRDi42TuhrhE0zNUPj9XPpF5Hn2ANcmE
	1PrNpYA7qp+DiixDofeCfaWdU/HuxfNXF5ONalGMS60cSV0GLjjUvWb/Ja2A/lr7A+2MRgG9nKs
	NtxEfhrn9qrNHYE/80uVZZL6wgA0/r/GazsH8ZoCFGdgIdhVm7sGQZU4qaGK4CVDSpIJLXdQx4l
	8cwmTSmfXbnOhwBBcMZy28T+rX5HuFaDg7I369n0TbLkCsiDJPycdU9Iyu9wbhUzOSFiBqTiRcz
	0qa0pyIKNxJoGRSa/05qOL5dpVMiWeNKNU4CoO6Cf6WiOQyHQBqEo80xOSWZByCk8
X-Google-Smtp-Source: AGHT+IEsd2dh3b7ZCBcS7C11Y+DmJop0Y5QgiZQ50QcK97YSeU7ZYKZ8b42eMZzoz9RF9b0Cs+MNcw==
X-Received: by 2002:a05:6512:1246:b0:55f:4ac2:a597 with SMTP id 2adb3069b0e04-5906d87babamr4379026e87.7.1760188148525;
        Sat, 11 Oct 2025 06:09:08 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e5790sm1919616e87.19.2025.10.11.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 06:09:07 -0700 (PDT)
Message-ID: <5d8ec4c3-1b36-470b-a1c7-629060a154ce@gmail.com>
Date: Sat, 11 Oct 2025 15:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] leds: add support for TI LP5860 LED driver chip
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Steffen Trumtrar <kernel@pengutronix.de>,
 Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
 <20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>
 <20250916153412.GA3837873@google.com> <875xd0jslv.fsf@pengutronix.de>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <875xd0jslv.fsf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steffen

On 9/30/25 09:40, Steffen Trumtrar wrote:
> 
> Hi,
> 
> On 2025-09-16 at 16:34 +01, Lee Jones <lee@kernel.org> wrote:
> 
>> > +#include <linux/gpio.h>
>> > +#include <linux/led-class-multicolor.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of_gpio.h>
>> > +#include <linux/of_platform.h>
>> > +#include <linux/regmap.h>
>> > +
>> > +#include <linux/platform_data/leds-lp5860.h>
>> > +
>> > +static struct lp5860_led *mcled_cdev_to_led(struct led_classdev_mc 
>> *mc_cdev)
>> > +{
>> > +    return container_of(mc_cdev, struct lp5860_led, mc_cdev);
>> > +}
>> > +
>> > +LP5860_SHOW_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, 
>> LP5860_CC_GROUP_MASK, 0)
>> > +LP5860_STORE_MODE(r_global_brightness_set, 
>> LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
>> > +DEVICE_ATTR_RW(r_global_brightness_set);
>>
>> How is this different to /sys/class/leds/<led>/multi_intensity?
>>
>> # echo 43 226 138 > /sys/class/leds/multicolor:status/multi_intensity
>> red -
>>     intensity = 138
>>     max_brightness = 255
>> green -
>>     intensity = 43
>>     max_brightness = 255
>> blue -
>>     intensity = 226
>>     max_brightness = 255
>>
> 
> the LP5860 has a register for setting the maximal brightness that holds 
> for all LEDs in the matrix. multi_intensity and max_brightness is only 
> for that one multicolor LED, right? And I can only manipulate the 
> max_brightness of that one multicolor LED instance.
> If I'm wrong, I'd be happy to not have to add the sysfs files.

It seems that this device is similar in the aspect of LED grouping
to LP50xx family. There is already a driver for that one [0] with
related bindings. Grouping solution could be addressed similarly to the
banking mechanism in that driver.

That of course means that this patch needs a significant rework.

First thing that strikes me after analyzing datasheet is that
LEDs are not assigned to any group since LP5860_REG_GRP_SEL_START
address is not referenced anywhere, and this is base address for
Dot_grp_selN registers that enable affiliation of the LED to given
group. No need for global brightness setting then.

Anyway, I'd add proper support for this device with DT knobs
to enable both grouping and individual approach to controlling the LEDs.

Driver [0] should serve as good guidance for that.

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-lp50xx.c

-- 
Best regards,
Jacek Anaszewski

