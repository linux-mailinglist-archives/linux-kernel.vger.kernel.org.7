Return-Path: <linux-kernel+bounces-605460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02424A8A17C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C51899CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042782BAF8;
	Tue, 15 Apr 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nlBrnwjL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16772DFA56
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728403; cv=none; b=nCQGrmLRmrIlTzW5c+RYFlGiJ6Eg1ZHSdLRDeE2OeWt3cjPNPGj/f1/iX9HLh/xKyGAQ6VJHt4qsyDWRFoVyuYEQFLSJVz3o6eGqHdcW2hYmjmR0tHE5bi/1z+XvJMlmUNjy55xX96KGVSR/LGImvVZhJbfw1FYrEQ4qbDP8fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728403; c=relaxed/simple;
	bh=wuKlZj6Aoilb/BQZMcgIKBY0tDRSbY8JgYY0fnGBOSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv5pVgRUSV0uk3v3nBnkr3cnem5eUI9cKfIAO0KhssNh4kJL7QVrZbsPhQWWDKf4eZukJYQjYJtLORz+5sdahG54X7+Gx+Rm9UpAxCkjrmK6NcC53PR4zZ7DzCOm4LX5GR+vxkAaZ0G+YsiKkDYm517vjk9AxH38toGSretrkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nlBrnwjL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744728399;
	bh=wuKlZj6Aoilb/BQZMcgIKBY0tDRSbY8JgYY0fnGBOSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nlBrnwjLKqzxmN4C1Z7HmwFU/5GgsDxkAlTCNoFm50iWatYZx+V7+wZqDYS9bSPD8
	 5/Z9bP6jqtl+2cqxLYbNKRWsb8ZUVwv00HlY68ZfsKkWXOorq2aQ7IF4QYm0BCkcwx
	 4N/p8vF2i49AfZsSSrUt4iLI1R2DX6pvPBllkHfo/iEaihZAUCVHmMtT/h/q5rSlf9
	 wyj6+uHm6EL+NQev4v1Hajb9yE6DQqPpQ63phvfb+reEFbst9dx2xirEZG6IaRnJI4
	 LfEj0MW9j0e7OrsQE6jxFqpGFhzpzJ7bvT1uZPT2+eouQmfF2m6Tu9hxdeRoXglOLy
	 UyrexcyQtC3Qg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DC2617E1134;
	Tue, 15 Apr 2025 16:46:37 +0200 (CEST)
Message-ID: <d38921cc-a565-4a79-9ecb-bfba85c3ab25@collabora.com>
Date: Tue, 15 Apr 2025 16:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/panel: startek-kd070fhfid015: add another init
 step
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
 <20231023-display-support-v8-2-c2dd7b0fb2bd@baylibre.com>
 <d70b62f8-e24e-4a10-8c6b-18d2e19f1337@collabora.com>
 <fb72f1f5-dc94-4e33-a20c-d46a081091bc@baylibre.com>
 <1ed38e6b-8d43-4cbc-9c27-58ec3c0e4dbc@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1ed38e6b-8d43-4cbc-9c27-58ec3c0e4dbc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/04/25 16:13, Alexandre Mergnat ha scritto:
> Hi Angelo,
> 
> Gentle ping
> 
> Let me shortly summarize my problem: I see the panel driver sending commands to the 
> display before it is ready. My approach to prevent that is to delay sending 
> commands until bridge enable. Your concern was that during the panel's .prepare() 
> the panel driver should already be able to send commands through the bridge. Can 
> you please clarify what you think should be the approach to fix that?
> 

Please don't top post.

Anyway - sorry but I missed your reply, that wasn't intentional - thanks for the
ping (or I wouldn't have replied, duh!).

What is not ready? The Startek display or the MediaTek display controller?

The display controller shall be able to send commands when the *panel*'s .prepare()
callback gets executed - if not, there's something wrong at the display controller
side (driver).

You're probably getting confused by the bridge en/disable callbacks, btw... please
check include/drm/drm_panel.h, struct drm_panel_funcs.

In short, the panel's prepare() should be used for whatever setup is required by
the panel to become available to *receive the video transmission* from the display
controller: this implies that if the panel needs DSI commands for setup, this is
allowed and it's a perfectly fine case.

So, if you are unable to "turn the panel on and wait for it to become ready" in
the panel's .prepare() callback, there's something wrong either in your panel
driver, on in the display controller (the DSI driver) instead.

Since this wasn't happening before your mtk_dsi cleanup, this probably means that
the cleanup is done wrong - and that removing the .start/.stop custom callbacks
from that driver needs you to do something more than just that in order to avoid
regressions.

Unfortunately, I'm pretty busy these days, otherwise I would've gladly made some
research to try and give you some more hints.. but eh :-)

Cheers,
Angelo

> Regards,
> Alexandre
> 
> On 21/03/2025 10:19, Alexandre Mergnat wrote:
>> Hi Angelo,
>> Thanks for the fast feedback :)
>>
>> On 20/03/2025 13:37, AngeloGioacchino Del Regno wrote:
>>> Il 20/03/25 09:48, Alexandre Mergnat ha scritto:
>>>> Currently, the panel set power, set gpio and enable the display link
>>>> in stk_panel_prepare, pointed by drm_panel_funcs.prepare, called by
>>>> panel_bridge_atomic_pre_enable, pointed by
>>>> drm_bridge_funcs.atomic_pre_enable. According to the drm_bridge.h,
>>>> atomic_pre_enable must not enable the display link
>>>>
>>>> Since the DSI driver is properly inited by the DRM, the panel try to
>>>> communicate with the panel before DSI is powered on.
>>>>
>>>
>>> The panel driver shall still be able to send commands in the .prepare() callback
>>> and if this is not happening anymore... well, there's a problem!
>>
>> Sorry I don't think so, according to that def:
>>      /**
>>       * @pre_enable:
>>       *
>>       * This callback should enable the bridge. It is called right before
>>       * the preceding element in the display pipe is enabled. If the
>>       * preceding element is a bridge this means it's called before that
>>       * bridge's @pre_enable function. If the preceding element is a
>>       * &drm_encoder it's called right before the encoder's
>>       * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
>>       * &drm_encoder_helper_funcs.dpms hook.
>>       *
>>       * The display pipe (i.e. clocks and timing signals) feeding this bridge
>>       * will not yet be running when this callback is called. The bridge must
>>       * not enable the display link feeding the next bridge in the chain (if
>>       * there is one) when this callback is called.
>>       *
>>       * The @pre_enable callback is optional.
>>       *
>>       * NOTE:
>>       *
>>       * This is deprecated, do not use!
>>       * New drivers shall use &drm_bridge_funcs.atomic_pre_enable.
>>       */
>>      void (*pre_enable)(struct drm_bridge *bridge);
>>
>>      /**
>>       * @enable:
>>       *
>>       * This callback should enable the bridge. It is called right after
>>       * the preceding element in the display pipe is enabled. If the
>>       * preceding element is a bridge this means it's called after that
>>       * bridge's @enable function. If the preceding element is a
>>       * &drm_encoder it's called right after the encoder's
>>       * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
>>       * &drm_encoder_helper_funcs.dpms hook.
>>       *
>>       * The bridge can assume that the display pipe (i.e. clocks and timing
>>       * signals) feeding it is running when this callback is called. This
>>       * callback must enable the display link feeding the next bridge in the
>>       * chain if there is one.
>>       *
>>       * The @enable callback is optional.
>>       *
>>       * NOTE:
>>       *
>>       * This is deprecated, do not use!
>>       * New drivers shall use &drm_bridge_funcs.atomic_enable.
>>       */
>>      void (*enable)(struct drm_bridge *bridge);
>>
>> => "The bridge must not enable the display link feeding the next bridge in the
>> => chain (if there is one) when this callback is called."
>>
>> Additionally, you ask for something impossible because here is the init order
>> fixed by the framework:
>>
>> [   10.753139] panel_bridge_atomic_pre_enable
>> [   10.963505] mtk_dsi_bridge_atomic_pre_enable
>> [   10.963518] mtk_dsi_bridge_atomic_enable
>> [   10.963527] panel_bridge_atomic_enable
>> [   10.963532] drm_panel_enable
>>
>> If panel want to use the DSI link in panel_bridge_atomic_pre_enable, nothing
>> will happen and  you will get a timeout.
>>
>> So, IMHO, this patch make sense.
>>
>>>
>>>> To solve that, use stk_panel_enable to enable the display link because
>>>> it's called after the mtk_dsi_bridge_atomic_pre_enable which is power
>>>> on the DSI.
>>>>
>>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>>> ---
>>>>   .../gpu/drm/panel/panel-startek-kd070fhfid015.c    | 25 +++++++++++++---------
>>>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/ 
>>>> drm/panel/panel-startek-kd070fhfid015.c
>>>> index c0c95355b7435..bc3c4038bf4f5 100644
>>>> --- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
>>>> +++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
>>>> @@ -135,19 +135,9 @@ static int stk_panel_prepare(struct drm_panel *panel)
>>>>       gpiod_set_value(stk->enable_gpio, 1);
>>>>       mdelay(20);
>>>>       gpiod_set_value(stk->reset_gpio, 1);
>>>> -    mdelay(10);
>>>> -    ret = stk_panel_init(stk);
>>>> -    if (ret < 0)
>>>> -        goto poweroff;
>>>
>>> Also, you're moving both init and set_display_on to the enable callback...
>>> this is suboptimal.
>>>
>>> You should do the DrIC setup in .prepare() (can include SLEEP OUT), and then you
>>> should have a .enable() callback that calls DISP ON, a .disable() callback that
>>> calls DISP OFF, and .unprepare() that turns everything off.
>>
>> This is not what I understand from the pre_enable's definition above, and also
>> the function call order by the framework. :)
>>
>>>
>>> Cheers,
>>> Angelo
>>>
>>>> -
>>>> -    ret = stk_panel_on(stk);
>>>> -    if (ret < 0)
>>>> -        goto poweroff;
>>>>       return 0;
>>>> -poweroff:
>>>> -    regulator_disable(stk->supplies[POWER].consumer);
>>>>   iovccoff:
>>>>       regulator_disable(stk->supplies[IOVCC].consumer);
>>>>       gpiod_set_value(stk->reset_gpio, 0);
>>>> @@ -156,6 +146,20 @@ static int stk_panel_prepare(struct drm_panel *panel)
>>>>       return ret;
>>>>   }
>>>> +static int stk_panel_enable(struct drm_panel *panel)
>>>> +{
>>>> +    struct stk_panel *stk = to_stk_panel(panel);
>>>> +    int ret;
>>>> +
>>>> +    ret = stk_panel_init(stk);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    ret = stk_panel_on(stk);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   static const struct drm_display_mode default_mode = {
>>>>           .clock = 163204,
>>>>           .hdisplay = 1200,
>>>> @@ -239,6 +243,7 @@ drm_panel_create_dsi_backlight(struct mipi_dsi_device *dsi)
>>>>   }
>>>>   static const struct drm_panel_funcs stk_panel_funcs = {
>>>> +    .enable = stk_panel_enable,
>>>>       .unprepare = stk_panel_unprepare,
>>>>       .prepare = stk_panel_prepare,
>>>>       .get_modes = stk_panel_get_modes,
>>>>
>>>
>>>
>>>
>>
> 


