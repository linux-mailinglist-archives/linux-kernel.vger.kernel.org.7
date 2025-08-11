Return-Path: <linux-kernel+bounces-763584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDFB21710
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7299C3B21A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44A2E2DE6;
	Mon, 11 Aug 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx0mg4vV"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF03213E90
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946546; cv=none; b=AxS+GeWWbNeuAPdPzHPDhUrbEyOrDbLHS0ySjsPujMn/rY62Z3LDsJqo0Y6bUqIHwuLp4WlXfVzvY1klHxCFByQIu6urpOSiFC3WjmNZtqgvuWENZarXAkRY3qjn/YdtSaFWs+1s384agm4srKvTbGnoHxvynxwPOgI7h5c5d8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946546; c=relaxed/simple;
	bh=n+ZhhoCBC6eyE1bQZjjK69BqEzozaua1A1aA53EyRbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdSDSICrvWdn9cyP0gi+WnsLutt33WTSI4ILVPRqXKL21roymSH5Kl+7QDmI/Cn3URYTsgbk8weoNaLmkDOCrVatQnpclDqwSvf7pjg5HfdSKi3hAyxZlzuXEz/yVBOw208y7nt/j0B1Ss3dG/+iXS+tvwzq/+KFA3BsyNcbr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx0mg4vV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so44473305e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946543; x=1755551343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nd6uUzXaSR6qkFSyGw/hvNkLx6tLkM/B6UqTDLBsI0=;
        b=Yx0mg4vVCtBMAMuuQvIRuA95UW9kKbtzAGU8mXTBvqEiSnSs39PMm5sksWeCMbG4CW
         gnQgNsk7TnTTc8qsIQyGJYG1KShQWo2qsAVCpkL2FEhTTvZ6HWCDIcDOqXM2VuxtJBIT
         sTN/4NKhdSDyvPAT8CSTDqh9/P6NOfqCFtd9nwg4uIh51eaLhNNp3tArp+t8ynL2dS6A
         5s0cRHUQ9wdK6nkaQve/NOFwSqOKgX/dgmUqHD2hqO5EfC08HaL3khlzDArmWOYhIPJA
         MR/QhYIQFgYmzzwiS+/gj2uRDY1ZT0KDsAodYSBh8RcJ4EFZQeuWXb6oUh+nT/FscYRg
         ROCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946543; x=1755551343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nd6uUzXaSR6qkFSyGw/hvNkLx6tLkM/B6UqTDLBsI0=;
        b=azPbsj3tTq7MMTMpT206rZdu6960MXjwBF8+97zNEM04BZ59+5fDSb02ug6XXfHhCl
         Fd294X3JNBERbTFb9xS4oqf22WVDHn2HcTKLubcCdwhnVHdR5eHw//Lx1IoGvPJYD0dB
         t3mrCMUUeJkiAhSlyKI4+iUIpVGc8lOGMKB/2Ix8ubDw6fg25zWIXVTyXg3PeH5De75N
         /mh2AJrwvW1v1FXDq+ZB4pS1noUh6bMyFGFeAsaXdxFgcaHXGs0Nqx8OUjvhkxMvel82
         cH7+dLz6451kNdol0HK0kBPCOQqnKEZqbd28+bj1gZAV4qSN9zgQFAUcymaMaLGt57GH
         fgrA==
X-Forwarded-Encrypted: i=1; AJvYcCW70sesh7SfNSVOVQ4WLw9yrI3cCrLi3//ZZzE2YDal3TAVp200pMfeldXobjUU/I/FsXf+vzXpszOIzYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2KaV27Fsqc28PXiasqbvG7Rn7A7LpDfmLCgM/7h65Ns/+yiK
	twnHZSlc5Nop3xXRYpPwkvSThWLE4xh1CaFzpE0Hq7cRf+4SlRTrShB9
X-Gm-Gg: ASbGncs1sTmN/iIdE5Abv4PQWAkcRS1NeBJHbd1JTImTC6o8/6Mf14WOyOHaHLZIYFH
	6JdjDawOFniQ9jH6upJhuEhxTGYTOvkPR8WPHFlqUl0tboA9w6cihMUAJ4y4PKu6PJjfZzcL2yY
	FeapyNjRb2Fr0kr5MAcb+/9NssCCb/yhwnmlis2kvaqrLmVgxB1uNpKLgKh7BQVJvET3UwBuXXB
	2uSOCHOjc3+2k8vYOee3j5+xnpZo/s/q7FCg8JELW9BUDdGjuxdq0nIrxVqLL8+/Com5gP3RsmB
	/2p21edYJmx9rfDCeY985OI9wtvEIux57uXKOkz1F5caoIl0iC3AY6Odb+v1e4jRMlyqTUADGuv
	WgbkhgTFF1Tj2eQEIeJAF9qOV8Kd8+iXgsISMC1aTAdc=
X-Google-Smtp-Source: AGHT+IErQtpmXh1g8vSy5qbvpdmc6lj7oC4wS4Sz70CDtHckb2+a4JBWdmZXp8VmbH4r/uUE6PKmGw==
X-Received: by 2002:a05:600c:a03:b0:458:bc2c:b2ed with SMTP id 5b1f17b1804b1-459f4e9e7dfmr125883185e9.7.1754946542542;
        Mon, 11 Aug 2025 14:09:02 -0700 (PDT)
Received: from [192.168.1.3] ([41.40.216.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm19679242f8f.69.2025.08.11.14.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 14:09:02 -0700 (PDT)
Message-ID: <1df2b47e-74d1-4232-957a-21d7a6f5da1d@gmail.com>
Date: Tue, 12 Aug 2025 00:08:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: atmel-hlcdc: replace dev_* print funtions with
 drm_* variants
To: Manikandan.M@microchip.com
Cc: skhan@linuxfoundation.com, Dharma.B@microchip.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250807190857.92431-1-eslam.medhat1993@gmail.com>
 <d26192c9-bba0-4fb8-aff8-fc4164a89a73@microchip.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <d26192c9-bba0-4fb8-aff8-fc4164a89a73@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/11/25 11:54, Manikandan.M@microchip.com wrote:
> Hi Eslam Khafagy,
Hi Manikandan,
>
> The patch appears to have been sent with spaces in place of
> tabs in the diff, which breaks kernel coding style [1] and makes it fail
> to apply.
> Please ensure your editor is configured to use tabs for indentation and
> use `git send-email` or b4 directly, not via an email client that may
> alter whitespace.

Thank you for the feedback.

But i have rechecked the patch. I don't seem to have altered any tabs 
with spaces.

>
> Could you please run checkpatch.sh and fix any reported errors or
> warnings before submitting the patch?

checkpatch.sh only reports two warnings:

WARNING: 'funtions' may be misspelled - perhaps 'functions'?
#78:
Subject: [PATCH v3] drm: atmel-hlcdc: replace dev_* print funtions with drm_* variants
                                                           ^^^^^^^^

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#95:
https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

but no errors regarding tabs or spaces.
I'll fix the first one in v4. can you confirm indeed i have not altered tabs with spaces first?

>
> [1] Documentation/process/coding-style.rst
>
> On 08/08/25 12:33 am, Eslam Khafagy wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Update the Atmel HLCDC code to use DRM print macros drm_*() instead of
>> dev_warn() and dev_err(). This change ensures consistency with DRM
>> subsystem logging conventions [1].
>>
>> [1]
>> https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
>>
>> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>> ---
>> v3:
>> * include header file to fix compilation. Thanks Manikandan.
>>
>> v2:
>> * replace dev_dbg with drm_dbg  in atmel_hlcdc_plane.c
>> * https://lore.kernel.org/all/20250806183049.52112-2-eslam.medhat1993@gmail.com/
>>
>> v1:
>> * replace dev_* print funtions with drm_* variants
>> *https://lore.kernel.org/all/20250806000141.239753-2-eslam.medhat1993@gmail.com/
>>
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 21 ++++++++++---------
>>    drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  3 ++-
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  6 +++---
>>    4 files changed, 23 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index 0f7ffb3ced20..e0efc7309b1b 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -20,6 +20,7 @@
>>    #include <drm/drm_atomic_helper.h>
>>    #include <drm/drm_crtc.h>
>>    #include <drm/drm_modeset_helper_vtables.h>
>> +#include <drm/drm_print.h>
>>    #include <drm/drm_probe_helper.h>
>>    #include <drm/drm_vblank.h>
>>
>> @@ -215,32 +216,32 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
>>                   if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                                !(status & ATMEL_XLCDC_CM),
>>                                                10, 1000))
>> -                       dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
>> +                       drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
>>
>>                   regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
>>                   if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                                status & ATMEL_XLCDC_SD,
>>                                                10, 1000))
>> -                       dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
>> +                       drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
>>           }
>>
>>           regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        !(status & ATMEL_HLCDC_DISP),
>>                                       10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
>>
>>           regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        !(status & ATMEL_HLCDC_SYNC),
>>                                       10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
>>
>>           regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        !(status & ATMEL_HLCDC_PIXEL_CLK),
>>                                       10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
>>
>>           clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
>>           pinctrl_pm_select_sleep_state(dev->dev);
>> @@ -269,32 +270,32 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        status & ATMEL_HLCDC_PIXEL_CLK,
>>                                        10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
>>
>>           regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        status & ATMEL_HLCDC_SYNC,
>>                                        10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
>>
>>           regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
>>           if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                        status & ATMEL_HLCDC_DISP,
>>                                        10, 1000))
>> -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
>> +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
>>
>>           if (crtc->dc->desc->is_xlcdc) {
>>                   regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
>>                   if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                                status & ATMEL_XLCDC_CM,
>>                                                10, 1000))
>> -                       dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
>> +                       drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
>>
>>                   regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
>>                   if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                                !(status & ATMEL_XLCDC_SD),
>>                                                10, 1000))
>> -                       dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
>> +                       drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
>>           }
>>
>>           pm_runtime_put_sync(dev->dev);
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index fa8ad94e431a..acb017a2486b 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -724,19 +724,19 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>>
>>           ret = atmel_hlcdc_create_outputs(dev);
>>           if (ret) {
>> -               dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
>> +               drm_err(dev, "failed to create HLCDC outputs: %d\n", ret);
>>                   return ret;
>>           }
>>
>>           ret = atmel_hlcdc_create_planes(dev);
>>           if (ret) {
>> -               dev_err(dev->dev, "failed to create planes: %d\n", ret);
>> +               drm_err(dev, "failed to create planes: %d\n", ret);
>>                   return ret;
>>           }
>>
>>           ret = atmel_hlcdc_crtc_create(dev);
>>           if (ret) {
>> -               dev_err(dev->dev, "failed to create crtc\n");
>> +               drm_err(dev, "failed to create crtc\n");
>>                   return ret;
>>           }
>>
>> @@ -778,7 +778,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>
>>           ret = clk_prepare_enable(dc->hlcdc->periph_clk);
>>           if (ret) {
>> -               dev_err(dev->dev, "failed to enable periph_clk\n");
>> +               drm_err(dev, "failed to enable periph_clk\n");
>>                   return ret;
>>           }
>>
>> @@ -786,13 +786,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>
>>           ret = drm_vblank_init(dev, 1);
>>           if (ret < 0) {
>> -               dev_err(dev->dev, "failed to initialize vblank\n");
>> +               drm_err(dev, "failed to initialize vblank\n");
>>                   goto err_periph_clk_disable;
>>           }
>>
>>           ret = atmel_hlcdc_dc_modeset_init(dev);
>>           if (ret < 0) {
>> -               dev_err(dev->dev, "failed to initialize mode setting\n");
>> +               drm_err(dev, "failed to initialize mode setting\n");
>>                   goto err_periph_clk_disable;
>>           }
>>
>> @@ -802,7 +802,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>           ret = atmel_hlcdc_dc_irq_install(dev, dc->hlcdc->irq);
>>           pm_runtime_put_sync(dev->dev);
>>           if (ret < 0) {
>> -               dev_err(dev->dev, "failed to install IRQ handler\n");
>> +               drm_err(dev, "failed to install IRQ handler\n");
>>                   goto err_periph_clk_disable;
>>           }
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> index 50fee6a93964..0b8a86afb096 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> @@ -15,6 +15,7 @@
>>    #include <drm/drm_bridge.h>
>>    #include <drm/drm_encoder.h>
>>    #include <drm/drm_of.h>
>> +#include <drm/drm_print.h>
>>    #include <drm/drm_simple_kms_helper.h>
>>
>>    #include "atmel_hlcdc_dc.h"
>> @@ -92,7 +93,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>           output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
>>           of_node_put(ep);
>>           if (output->bus_fmt < 0) {
>> -               dev_err(dev->dev, "endpoint %d: invalid bus width\n", endpoint);
>> +               drm_err(dev, "endpoint %d: invalid bus width\n", endpoint);
>>                   return -EINVAL;
>>           }
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> index 4a7ba0918eca..817284509b57 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> @@ -1034,7 +1034,7 @@ static void atmel_hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>           if (isr &
>>               (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
>>                ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
>> -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
>> +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
>>                           desc->name);
>>    }
>>
>> @@ -1051,7 +1051,7 @@ static void atmel_xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>           if (isr &
>>               (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
>>                ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
>> -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
>> +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
>>                           desc->name);
>>    }
>>
>> @@ -1140,7 +1140,7 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>>           if (state) {
>>                   if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
>>                           kfree(state);
>> -                       dev_err(p->dev->dev,
>> +                       drm_err(p->dev,
>>                                   "Failed to allocate initial plane state\n");
>>                           return;
>>                   }
>> --
>> 2.43.0
>>

