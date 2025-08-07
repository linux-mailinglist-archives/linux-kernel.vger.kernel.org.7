Return-Path: <linux-kernel+bounces-759405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B44B1DD25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95345850EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD320D51C;
	Thu,  7 Aug 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4G8zIHa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D023DE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591637; cv=none; b=sZysQEUd01h5y0Ks/2sf090iQhDdyoCSFi7MoN2wR5hp11qo3i1QHv6HsPZiT1d+FeBS+2LsldhNndyefb2rHFIHuc+PL+nTcrFwn1HP4BNoeBEEwmy2oCvcLoZb/rLYM4ftv8VQpO3EWlrwh5xs8N3wBG9Igv+BVYCb/8dPB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591637; c=relaxed/simple;
	bh=imKQgfEx8JySi6l6Udt9scPS//CZ83djUA67qD27AyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAxIvhIUt4Q8KqaTKCJblidwtbkjKmkNXpOoiuRbhF+1Sh7KdaSj11uWH1xqkHv2+LhVpX3rc766aMudnboESA47c+7FlbRsX86XZy6aYyREZ5E1DPbPg23h3SdC4S6PdmQ5vS1uCl8plYI6Fde89hA4/3qez32tbOOd37YeB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4G8zIHa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so11189885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754591634; x=1755196434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+wSeTgD+KyHlh1LNjtbFb9cuhDfBkha0K0sJfYhWTQ=;
        b=f4G8zIHaQV+xPKM/Et1XII9PhXWTjmDOoZWhoZ04fAGAO7l24GYU9tsDoTGBBPbw1o
         PAkZKUVInO/0D0owmL+tTlNoKGeO6n4yYKiJWD2mOm+Ht9Mcgofuln2F1z3hj4ti6LK3
         I3PCwUkvDsf15vEFmzS5OXMmJsvj45SlLk2aMCC1Vx36KyFGWoDcF9ROjVLSJOx5fwvp
         jVQF6w+M+2ojSeJp9AP86ySO1NREVZ9jPG4iWGhnfdcri2XAvYlZG9e/tgqm3OT+To5w
         IlLhdfuuRpUBASE0nAj0NwXRRLfk9J9A9bQmtPDbu+NwnipCrjUlhRx3qWWRLXTCcubX
         j1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754591634; x=1755196434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+wSeTgD+KyHlh1LNjtbFb9cuhDfBkha0K0sJfYhWTQ=;
        b=C6UrLtecHjfdOmgiWCyK5nFW5CpxAS5e33NzE4N9q7guFnJ0VxpLb2USwnfvHPNiIW
         wNdL9JK+WvV7X6QeVbCbqQ8gBvTHKDmoGen77z08l8QbxuzOz8vSGA1GUjWeFliYkN79
         +GIOOOFLQ3SatZccmurVFGCRmWaY8EI0NSgmwVNRaJrOhAQK5X0QrhvlGFImlDDX8gfg
         4sjOOEc7utbxW05tHIzvhOwbHt9pV7chB4JFdI13DHOxuw/REhubX2zHyVR1KGs1xoNt
         u8KmFg9RayxmfvfcGxXTQuc9fu2Yu+BJ9OnbxCCHRY1/MFshBCRKQxWyHlhcI4gBJ6vu
         8EEw==
X-Forwarded-Encrypted: i=1; AJvYcCWqVJjcV838RsA+882cU/6aPgCkjf8RcEeSXftj2Y0CvNzRHQXMAUW9BOxLy2Wf2ih9TA7SBquMjONxEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMXblLGFaID7c9QxRTr2yCbQZJ5Rmh8XurKDrm7m3rM/H5K0j
	J7Uc9+CNb7JriycpeICkDkSsW11bSUOxVZ+XiNkJAvJ/as72IjIFRhLZ
X-Gm-Gg: ASbGncuQnXUVIyqr32Wn+fCEEhRbt6ILfHeZG2DRh6tBaSB0A3x79w77si0dSZCx+tc
	7+S1i1LqmwVE889XKv8rTliJ53fJPAwrE/kWe53i3fpPteC4cKSozVp3tsix/fe7yqiMI1UrV2d
	U0P/2dTjAgSYLfzH+IPX/QaYulM0FSc8LpBy4wNYv/160CjmSfnbjYgk3x6dKSOBiY7oYJ3dIHT
	HggnMnPM9cMGbla2VOSPV5oSbHwTdqfFR2x1jVmPzZwLCKtBcYeIo3C+ly96vek4rzjrSTAF44a
	cDPkunmMbpzkRbjAo4cr5V6aLMsGq5fXNh8PP3abP90WgI2G4Nd9tPzP7NJQIqQeuBR+GYn4Kvm
	/ljb/VPOfOCbxLrWKkeFjdH9Tm4Hl4ZAeQAo=
X-Google-Smtp-Source: AGHT+IFb4+WXBcmMoW0cDyf2/cXHSKSUU3eLFCEXiDD/KNdBemcmwemt2zGCACE2Ixg6JsmlwXBZMg==
X-Received: by 2002:a05:600c:a03:b0:459:d9a2:e952 with SMTP id 5b1f17b1804b1-459f4e9e738mr321815e9.1.1754591633873;
        Thu, 07 Aug 2025 11:33:53 -0700 (PDT)
Received: from [192.168.1.3] ([156.204.172.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e577d0f5sm104736335e9.0.2025.08.07.11.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 11:33:53 -0700 (PDT)
Message-ID: <0856a87c-9f7f-41c8-a35b-49d90094e5b1@gmail.com>
Date: Thu, 7 Aug 2025 21:33:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm: atmel-hlcdc: replace dev_* print funtions
 with drm_* variants
To: Manikandan.M@microchip.com
Cc: skhan@linuxfoundation.com, Dharma.B@microchip.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250806183049.52112-1-eslam.medhat1993@gmail.com>
 <20250806183049.52112-2-eslam.medhat1993@gmail.com>
 <09cc3c77-d5e8-47d2-9bbe-f82b5a8a8447@microchip.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <09cc3c77-d5e8-47d2-9bbe-f82b5a8a8447@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/7/25 10:05, Manikandan.M@microchip.com wrote:
> Hi Eslam Khafagy,
>
> On 07/08/25 12:00 am, Eslam Khafagy wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> According to documentation[1] drm_* variants are preferred over dev_*
>> print functions.
>>
>> [1] https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter
>>
>> v1->v2
>> replace dev_dbg with drm_dbg  in atmel_hlcdc_plane.c
> The change logs should be placed after Signed-off-by and below a
> separate 3 dash lines.
ok
> IMO
> The commit message can be -
> 'Update the Atmel HLCDC code to use DRM print macros drm_*() instead of
> dev_warn() and dev_err(). This change ensures consistency with DRM
> subsystem logging conventions [1].
>
> [1]
> https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter'
yes it's better . thanks.
>> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>> ---
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 20 +++++++++----------
>>    drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  2 +-
>>    .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  6 +++---
>>    4 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index 0f7ffb3ced20..da94ab0540bb 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -215,32 +215,32 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
>>                   if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
>>                                                !(status & ATMEL_XLCDC_CM),
>>                                                10, 1000))
>> -                       dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
>> +                       drm_warn(dev, "Atmel LCDC status register CMSTS timeout\n");
> The files atmel_hlcdc_crtc.c and atmel_hlcdc_output.c failes to compile
> due to missing headers for drm_(warn/err) macros.
yes. thanks for pointing this out. i was already planning for a fix 
today in v3.
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
>> @@ -269,32 +269,32 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
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
>> index 50fee6a93964..945a475c33ac 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> @@ -92,7 +92,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
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

