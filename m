Return-Path: <linux-kernel+bounces-819567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D658AB5A327
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2519C5217F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D931BCB9;
	Tue, 16 Sep 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7zODfbH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CE31BC9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054352; cv=none; b=NZ9ZtsIJPBJ0tk6eGFhpNflWe1Bmiq9sYu6JlagJkFuO2SfuvOe6Ypd6X9QP5eyg58lY7iDng4R7htZDo8Rt86Ifvixuw09YtqUkYZIfsNufOVUld1Ysa7J5lpl62wKeb2l1hh70bMlp7ErTBW+o2kzpzCuBzQg+wUwrG3KJEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054352; c=relaxed/simple;
	bh=gabqx8Nzj7e0sCAAjQQ7GWEpHD4EzAMwoID0JRlQPP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k6t4YKCZ/qZmAgq1mmMpZ0tWyBUq7zlofiCwUBnn+XIFaXZdSm32G6giRnWvu49E2QcSxxfHq+DCk/D/F/Ouk/7vintQAaLWT8biZIsMIyEpbFXItyCS/KtR/Hwavxdi+Iw7nFB2tdcTdpKnaAXM70qIEZlxMQVJ6a+Rvr9RFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7zODfbH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so2462393f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758054349; x=1758659149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Z7GnmkTaAdXN+TwZ1qp0XZ2z7Z2RdV2bNh+iEGCPco=;
        b=D7zODfbH3TgZmGwYx/1LUqBsKUW8jn8hQR2AQ8yyg8UAfw2KeygLMXoGP1U2KRYdgK
         1zzFI165ZYZJIqN30LLIRA8cs5Cl6aDo41qDOmMCH81Y4DTCQGP2/gmk5lgIUg716tc1
         e3BIZlOKsHXC7VNrE9fS1bftcwWM70+5Sloq8PwHMXNfPbMz10KZP9D5zqrXGguKp6ZT
         AQaKlDj97PRAgU9Z4MCTUyWMJS3hG2CduefV6pVQlWrC7WrYKRq7sCgrt+vETGVDx2DN
         BI1DfTfw7E01jDobolmXQFejPWdYAGIpBWBWGDoue/4KU9XYXnpME2ZETHKK2Ak/n14C
         k6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054349; x=1758659149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z7GnmkTaAdXN+TwZ1qp0XZ2z7Z2RdV2bNh+iEGCPco=;
        b=ZVsiYpnYL8LiI/nxR29jzMQE977c2mgkn1Eidr2asr4CXogiZUzHWyfGpqq1RsTtqd
         d+ybhNdly2TkClUe4TRhbwyWMbbxwP63LtYmh6hTpDiOdpQpyuEH5L6hJjN75Z7NKdq+
         IprHf0+i26/2MYbNfCFDZT7JKnlAsZPZD0bkpLVoopdtp5oS4zDS0yEBc0Y5qpCks89y
         8UFyNFve515zpphogfLmPyafDH/ZX24A36kOgzvPcFckOM2JMM/dpZhwvAP24xphc4n4
         lvugHzVXCxm7W14EpInWffagFO5G5ARTTWMUfr4qqzXr5JT/jsAhvABeON6uDm+hH1Xr
         +q9w==
X-Forwarded-Encrypted: i=1; AJvYcCVtsSRBwATyi6jLmxpUR7Ci8piBaXxr+9i4LbKo4n0Wcn1PIIY6UW5pergJ40CFj4iNog5P0NWnovFILU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG+fKbeECQxxoMVU2NDz4cuusx1A+pqbjSI+a0aaZkhzCrRQI
	RnFIZhJ9xKPo3gcH4/q9am0Hdu3BU0pW8OVP7oTKZMPPxEK5d2QURHSQ
X-Gm-Gg: ASbGncvffxFf9WDfHq2ly/bG9XbaV26OvpGkdvPyEL5IShvZTWCq2GBdEu5+J++Kre+
	AXU1O+NFlSjkwVMaaKnXEIi85NZ6wWEk2oiZp9AOzsSRajXDGfxq4nMQLBxMFSITr07sS1WnFRc
	49KkBV3wdAtlXJQ9gmNLOPwHXe7Hs9KXqHG7gpEi3akksISQNY1t8ALs9Wtpt2rnN6fG+RBqkDA
	KYA1VQkeQ/yC34ahRYyLWl5TNF+ktWlt2lwfv6Cj2TotE4VuqdOUioSIPTQEg81tzN3edqKO24M
	pbO/XD0Di7tSIe/IevAqIGcrLRMC8BwRFpyV0xciwWqQpQj78o+o33t58Jnv4VdnP1ntL3vlj8H
	yuboqcWjsuvZ6suUYAOYN4dSzPTyQi0rsB+Q=
X-Google-Smtp-Source: AGHT+IFYef1W20KdCqlCjiXb8p7T+iogcnhGNGzTT397wbKbR5kPv4DEsNQAhBPJAhFNJZRRTTSYYQ==
X-Received: by 2002:a05:6000:2209:b0:3cd:ac2b:7f0 with SMTP id ffacd0b85a97d-3e7659f3bccmr14918748f8f.49.1758054348300;
        Tue, 16 Sep 2025 13:25:48 -0700 (PDT)
Received: from [192.168.1.12] ([156.204.69.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613869528bsm7470655e9.14.2025.09.16.13.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:25:47 -0700 (PDT)
Message-ID: <2d3fd438-06db-4ba2-82f9-22a5c9267952@gmail.com>
Date: Tue, 16 Sep 2025 23:25:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm: atmel-hlcdc: replace dev_* print functions with
 drm_* variants
To: Manikandan.M@microchip.com, Dharma.B@microchip.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813224000.130292-1-eslam.medhat1993@gmail.com>
 <2e4334ac-ebd2-4686-8d5c-6d7a637a6d57@microchip.com>
 <CAFRctSHGG-7tx0o5-hi2pZbsw-9jGV1FZrFquOOnFAB=i+O8Gw@mail.gmail.com>
 <4e7faa33-6e39-4b9c-b5df-bccaa9cbb1cc@microchip.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <4e7faa33-6e39-4b9c-b5df-bccaa9cbb1cc@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Manikandan,

Understood. thank you for the follow-up.

On 9/16/25 09:50, Manikandan.M@microchip.com wrote:
> Hi Eslam Khafagy,
>
> I am still awaiting approval for my commit access request to the
> drm-misc repository. I will be able to apply your changes as soon as the
> access is granted.Thank you for your patience.
>
> On 14/09/25 3:49 am, Eslam Khafagy wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hello Manikandan,
>> This patch has been reviewed for a while now. but i didn't get an
>> update if it's been pulled yet or not .
>>
>> kindly can you kindly update if it's been pulled or not ?
>> thanks in advance.
>>
>>
>> On Mon, Aug 18, 2025 at 12:16 PM <Manikandan.M@microchip.com> wrote:
>>> On 14/08/25 4:09 am, Eslam Khafagy wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> Update the Atmel HLCDC code to use DRM print macros drm_*() instead of
>>>> dev_warn() and dev_err(). This change ensures consistency with DRM
>>>> subsystem logging conventions [1].
>>>>
>>>> [1]
>>>> Link: https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
>>>>
>>>> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>>> Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>>
>>>> ---
>>>>     .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 21 ++++++++++---------
>>>>     drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
>>>>     .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  3 ++-
>>>>     .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  6 +++---
>>>>     4 files changed, 23 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>>>> index 0f7ffb3ced20..e0efc7309b1b 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>>>> @@ -20,6 +20,7 @@
>>>>     #include <drm/drm_atomic_helper.h>
>>>>     #include <drm/drm_crtc.h>
>>>>     #include <drm/drm_modeset_helper_vtables.h>
>>>> +#include <drm/drm_print.h>
>>>>     #include <drm/drm_probe_helper.h>
>>>>     #include <drm/drm_vblank.h>
>>>>
>>>> @@ -215,32 +216,32 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
>>>>                    if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                                 !(status & ATMEL_XLCDC_CM),
>>>>                                                 10, 1000))
>>>> -                       dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
>>>> +                       drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
>>>>
>>>>                    regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
>>>>                    if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                                 status & ATMEL_XLCDC_SD,
>>>>                                                 10, 1000))
>>>> -                       dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
>>>> +                       drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
>>>>            }
>>>>
>>>>            regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         !(status & ATMEL_HLCDC_DISP),
>>>>                                        10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
>>>>
>>>>            regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         !(status & ATMEL_HLCDC_SYNC),
>>>>                                        10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
>>>>
>>>>            regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         !(status & ATMEL_HLCDC_PIXEL_CLK),
>>>>                                        10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
>>>>
>>>>            clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
>>>>            pinctrl_pm_select_sleep_state(dev->dev);
>>>> @@ -269,32 +270,32 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         status & ATMEL_HLCDC_PIXEL_CLK,
>>>>                                         10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
>>>>
>>>>            regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         status & ATMEL_HLCDC_SYNC,
>>>>                                         10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeout\n");
>>>>
>>>>            regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
>>>>            if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                         status & ATMEL_HLCDC_DISP,
>>>>                                         10, 1000))
>>>> -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
>>>> +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeout\n");
>>>>
>>>>            if (crtc->dc->desc->is_xlcdc) {
>>>>                    regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
>>>>                    if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                                 status & ATMEL_XLCDC_CM,
>>>>                                                 10, 1000))
>>>> -                       dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
>>>> +                       drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
>>>>
>>>>                    regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
>>>>                    if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>>>                                                 !(status & ATMEL_XLCDC_SD),
>>>>                                                 10, 1000))
>>>> -                       dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
>>>> +                       drm_warn(dev, "Atmel LCDC status register SDSTS timeout\n");
>>>>            }
>>>>
>>>>            pm_runtime_put_sync(dev->dev);
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>>>> index fa8ad94e431a..acb017a2486b 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>>>> @@ -724,19 +724,19 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>>>>
>>>>            ret = atmel_hlcdc_create_outputs(dev);
>>>>            if (ret) {
>>>> -               dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
>>>> +               drm_err(dev, "failed to create HLCDC outputs: %d\n", ret);
>>>>                    return ret;
>>>>            }
>>>>
>>>>            ret = atmel_hlcdc_create_planes(dev);
>>>>            if (ret) {
>>>> -               dev_err(dev->dev, "failed to create planes: %d\n", ret);
>>>> +               drm_err(dev, "failed to create planes: %d\n", ret);
>>>>                    return ret;
>>>>            }
>>>>
>>>>            ret = atmel_hlcdc_crtc_create(dev);
>>>>            if (ret) {
>>>> -               dev_err(dev->dev, "failed to create crtc\n");
>>>> +               drm_err(dev, "failed to create crtc\n");
>>>>                    return ret;
>>>>            }
>>>>
>>>> @@ -778,7 +778,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>>>
>>>>            ret = clk_prepare_enable(dc->hlcdc->periph_clk);
>>>>            if (ret) {
>>>> -               dev_err(dev->dev, "failed to enable periph_clk\n");
>>>> +               drm_err(dev, "failed to enable periph_clk\n");
>>>>                    return ret;
>>>>            }
>>>>
>>>> @@ -786,13 +786,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>>>
>>>>            ret = drm_vblank_init(dev, 1);
>>>>            if (ret < 0) {
>>>> -               dev_err(dev->dev, "failed to initialize vblank\n");
>>>> +               drm_err(dev, "failed to initialize vblank\n");
>>>>                    goto err_periph_clk_disable;
>>>>            }
>>>>
>>>>            ret = atmel_hlcdc_dc_modeset_init(dev);
>>>>            if (ret < 0) {
>>>> -               dev_err(dev->dev, "failed to initialize mode setting\n");
>>>> +               drm_err(dev, "failed to initialize mode setting\n");
>>>>                    goto err_periph_clk_disable;
>>>>            }
>>>>
>>>> @@ -802,7 +802,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>>>            ret = atmel_hlcdc_dc_irq_install(dev, dc->hlcdc->irq);
>>>>            pm_runtime_put_sync(dev->dev);
>>>>            if (ret < 0) {
>>>> -               dev_err(dev->dev, "failed to install IRQ handler\n");
>>>> +               drm_err(dev, "failed to install IRQ handler\n");
>>>>                    goto err_periph_clk_disable;
>>>>            }
>>>>
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> index 50fee6a93964..0b8a86afb096 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> @@ -15,6 +15,7 @@
>>>>     #include <drm/drm_bridge.h>
>>>>     #include <drm/drm_encoder.h>
>>>>     #include <drm/drm_of.h>
>>>> +#include <drm/drm_print.h>
>>>>     #include <drm/drm_simple_kms_helper.h>
>>>>
>>>>     #include "atmel_hlcdc_dc.h"
>>>> @@ -92,7 +93,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>>            output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
>>>>            of_node_put(ep);
>>>>            if (output->bus_fmt < 0) {
>>>> -               dev_err(dev->dev, "endpoint %d: invalid bus width\n", endpoint);
>>>> +               drm_err(dev, "endpoint %d: invalid bus width\n", endpoint);
>>>>                    return -EINVAL;
>>>>            }
>>>>
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>>> index 4a7ba0918eca..817284509b57 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>>>> @@ -1034,7 +1034,7 @@ static void atmel_hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>>>            if (isr &
>>>>                (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
>>>>                 ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
>>>> -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
>>>> +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
>>>>                            desc->name);
>>>>     }
>>>>
>>>> @@ -1051,7 +1051,7 @@ static void atmel_xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>>>            if (isr &
>>>>                (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
>>>>                 ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
>>>> -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
>>>> +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
>>>>                            desc->name);
>>>>     }
>>>>
>>>> @@ -1140,7 +1140,7 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>>>>            if (state) {
>>>>                    if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
>>>>                            kfree(state);
>>>> -                       dev_err(p->dev->dev,
>>>> +                       drm_err(p->dev,
>>>>                                    "Failed to allocate initial plane state\n");
>>>>                            return;
>>>>                    }
>>>> --
>>>> 2.43.0
>>>>
>>> --
>>> Thanks and Regards,
>>> Manikandan M.
>>>
>>
>> --
>>
>> Eslam Medhat Khafagy
>>
>> https://www.linkedin.com/in/eslam-khafagy-a8a68159/

