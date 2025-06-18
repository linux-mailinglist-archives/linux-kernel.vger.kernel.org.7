Return-Path: <linux-kernel+bounces-691736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD8ADE833
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEDE40348A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811A2C08D5;
	Wed, 18 Jun 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XUmWALNl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB126C1E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241144; cv=none; b=I2DYHvhtcYQK/ymlSh5WGv1+9zjT3TGNjyLbEUgfu//4V02z9V/xMqL1r3e6Y0sZRs9U3wl9rDkzUcR5/H8NbhzLEKIktgLv8jPTlXsMnOho8q8+XEMTt7shZK8qhRfl1zPbYeiw7T0cH+ANbxH+XouEEevZ8Vw/4HDtpvbTNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241144; c=relaxed/simple;
	bh=7lEyNd9xMrZh0TKqLkR27JbjLcGIiTLH3RfkijHETvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP+KHucSlAm7UypXBHtPt1+rPyXvXukCX2AnV68DiZjUWmCRn16W4Q8XANoUjsMQd2R9U/6F37WjPVGdM036HdOm/nvv/Tg2scJ+5plSBkxYcY075OzgxRiWNIr/E5zo1BGdXN0uAZkkvN2Pf9WH4qMqpY+zZsv+WJyNEXi27x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XUmWALNl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AA2E752;
	Wed, 18 Jun 2025 12:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1750241126;
	bh=7lEyNd9xMrZh0TKqLkR27JbjLcGIiTLH3RfkijHETvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XUmWALNlWm9GbOz9gEfwRGyCCs3tny7AQZvy4VaPg5iN4I09fbswyLPVteeh4wUrU
	 Lu9ggWN6XStTAqSI7sVaSKJtbN8wJmEsH9jdRDUP1FHqMvG1tDW4ksUkUCSgeoNoqs
	 d0QMkObTxrmzfaLKs8gbdXlXwOHbh48Cym1VVwHw=
Message-ID: <357d8e74-eb6c-48d0-b9cc-eab4ed26904d@ideasonboard.com>
Date: Wed, 18 Jun 2025 13:05:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/4] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 DRI Development List <dri-devel@lists.freedesktop.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20250605171524.27222-1-aradhya.bhatia@linux.dev>
 <20250605171524.27222-4-aradhya.bhatia@linux.dev>
 <CGME20250611104512eucas1p22450fccf3bb7521760bd2d9a2a56ba19@eucas1p2.samsung.com>
 <2c51cf39-13cb-413f-8dd5-53bc1c11467a@samsung.com>
 <306f142f-f9c9-44ab-a5b9-c71db76b2b80@ideasonboard.com>
 <b4d8c5b2-3ad7-4327-9985-d097d095ccb5@samsung.com>
 <3adb1d12-7cd5-4beb-9978-c3cae702f338@ideasonboard.com>
 <d005ad5c-aded-4dea-b6eb-a9ce78c04728@samsung.com>
 <20250618-silent-oriole-of-fertility-3cbbd6@houat>
 <3c5d43a2-fdbe-4cbe-bf45-09bfcb18dcb3@samsung.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <3c5d43a2-fdbe-4cbe-bf45-09bfcb18dcb3@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 18/06/2025 13:01, Marek Szyprowski wrote:
> On 18.06.2025 10:27, Maxime Ripard wrote:
>> On Wed, Jun 18, 2025 at 08:30:39AM +0200, Marek Szyprowski wrote:
>>> On 16.06.2025 17:40, Tomi Valkeinen wrote:
>>>> On 12/06/2025 09:31, Marek Szyprowski wrote:
>>>>> On 12.06.2025 07:49, Tomi Valkeinen wrote:
>>>>>> On 11/06/2025 13:45, Marek Szyprowski wrote:
>>>>>>> On 05.06.2025 19:15, Aradhya Bhatia wrote:
>>>>>>>> From: Aradhya Bhatia <a-bhatia1@ti.com>
>>>>>>>>
>>>>>>>> Move the bridge pre_enable call before crtc enable, and the bridge
>>>>>>>> post_disable call after the crtc disable.
>>>>>>>>
>>>>>>>> The sequence of enable after this patch will look like:
>>>>>>>>
>>>>>>>> 	bridge[n]_pre_enable
>>>>>>>> 	...
>>>>>>>> 	bridge[1]_pre_enable
>>>>>>>>
>>>>>>>> 	crtc_enable
>>>>>>>> 	encoder_enable
>>>>>>>>
>>>>>>>> 	bridge[1]_enable
>>>>>>>> 	...
>>>>>>>> 	bridge[n]_enable
>>>>>>>>
>>>>>>>> And, the disable sequence for the display pipeline will look like:
>>>>>>>>
>>>>>>>> 	bridge[n]_disable
>>>>>>>> 	...
>>>>>>>> 	bridge[1]_disable
>>>>>>>>
>>>>>>>> 	encoder_disable
>>>>>>>> 	crtc_disable
>>>>>>>>
>>>>>>>> 	bridge[1]_post_disable
>>>>>>>> 	...
>>>>>>>> 	bridge[n]_post_disable
>>>>>>>>
>>>>>>>> The definition of bridge pre_enable hook says that,
>>>>>>>> "The display pipe (i.e. clocks and timing signals) feeding this bridge
>>>>>>>> will not yet be running when this callback is called".
>>>>>>>>
>>>>>>>> Since CRTC is also a source feeding the bridge, it should not be enabled
>>>>>>>> before the bridges in the pipeline are pre_enabled. Fix that by
>>>>>>>> re-ordering the sequence of bridge pre_enable and bridge post_disable.
>>>>>>>>
>>>>>>>> While at it, update the drm bridge API documentation as well.
>>>>>>>>
>>>>>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>>>> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>>>> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>>>>>>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>>>>>>> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
>>>>>>> This patch landed in today's linux-next as commit c9b1150a68d9
>>>>>>> ("drm/atomic-helper: Re-order bridge chain pre-enable and
>>>>>>> post-disable"). In my tests I found that it breaks booting of Samsung
>>>>>>> Exynos 5420/5800 based Chromebooks (Peach-Pit and Peach-Pi). Both of
>>>>>>> them use Exynos DRM with Exynos_DP sub-driver (Analogix DP) and EDP
>>>>>>> panel. Booting stops at '[drm] Initialized exynos 1.1.0 for exynos-drm
>>>>>>> on minor 0' message. On the other hand, the Samsung Exynos5250 based
>>>>>>> Snow Chromebook boots fine, but it uses dp-lvds nxp,ptn3460 bridge and
>>>>>>> lvds panel instead of edp panels. This looks like some sort of deadlock,
>>>>>>> because if I disable FBDEV emulation, those boards boots fine and I'm
>>>>>>> able to run modetest and enable the display. Also the DRM kernel logger
>>>>>>> seems to be working fine, although I didn't check the screen output yet,
>>>>>>> as I only have a remote access to those boards. I will investigate it
>>>>>>> further and let You know.
>>>>>> Thanks for the report. I was trying to understand the pipeline, but I'm
>>>>>> a bit confused. Above you say Peach-Pit uses DP and EDP panel, but if I
>>>>>> look at arch/arm/boot/dts/samsung/exynos5420-peach-pit.dts, it connects
>>>>>> a dp->lvds bridge (parade,ps8625). Peach-Pi seems to connect to an eDP
>>>>>> panel.
>>>>>>
>>>>>> Is the above correct? Do both Peach-Pi and Peach-Pit fail?
>>>>> Yes, sorry, my fault. I much have checked the same (peach-pi) dts 2
>>>>> times. Both Peach-Pi and Peach-Pit fails, while Snow works fine. All
>>>>> three use the same Exynos DP (based on analogix dp) driver. I will try
>>>>> to play a bit more with those boards in the afternoon, hopefully getting
>>>>> some more hints where the issue is.
>>>> Did you get a chance to test this more? Any hints what happens will help =)
>>> I've spent some time debugging this issue, but so far I only got
>>> something I don't really understand. This issue is somehow related with
>>> the DP clock enabling and disabling, what is being done from
>>> exynos_dp_poweron() and exynos_dp_poweroff() functions, which are called
>>> from analogix_dp_resume() and analogix_dp_suspend(). The lockup happens
>>> somewhere while registering the fbdev console, with console lock held,
>>> what makes debugging much harder.
>> You can skip the locking part with the fb.lockless_register_fb=1 kernel
>> parameter. It's of course not meant for anything but debugging, but it's
>> useful :)
> 
> I've finally found where is the problem! It turned out that the issue is 
> in the exynos_drm_fimd driver, in the code for enabling the display port 
> clock (fimd_dp_clock_enable()
>   function). It touches FIMD regs, but it was not guarded with FIMD's 
> runtime pm calls and after the $subject change it happened that 
> exynos_dp/analogix_dp code called the clock enable/disable when FIMD 
> driver (which implements the CRTC object) was not runtime resumed. 
> Previously all dp clock handling was done when CRTC was enabled, thus 
> the FIMD device was in the resumed runtime pm state.
> 
> I will send a patch fixing this soon.

Alright, sounds like we don't need to revert the re-ordering patch after
all =). Thanks for debugging this.

 Tomi


