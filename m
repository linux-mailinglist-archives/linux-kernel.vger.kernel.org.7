Return-Path: <linux-kernel+bounces-735376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAAB08E72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75784561067
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92B2E6D10;
	Thu, 17 Jul 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RgiTEf8B"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5843596E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759752; cv=none; b=kEhNzR9u4+NZ4ZFjcXyvsoTeFxS/8Mp1e3gAM4jYt9sWhWlxyzPKqFkfTjeWoOFC2E733jVjqr8NdCuRihhLJpsqhYXo0CxdvZjc1u9NLPUcyZe4bq0+6P/6vYfEd8G4CowmA63y7mw6Eyad0xPEIzZlej8TjbqPZXs1gzQkDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759752; c=relaxed/simple;
	bh=T0wdW4suPoMDI0/Mtq/k/3GhQ4A6euglMqQdtZREA7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S6IVJfAEL/IUS/B/Vrd3m5+EEhnyg0VJbrAHNfoAxi9TnvzH8U+p+ERI9bFkeMW4kg0J0pM6ZZwbPCcuRthutYx1FcipSJKMaGH0OWAxcx1IzwAZ0sxby7zOjR+Hp0UnmpWX6MNic3IlCewx1lYH53vcXrJZKTMvvCMr4gDolEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RgiTEf8B; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HDfXeE484011;
	Thu, 17 Jul 2025 08:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752759694;
	bh=xSAR2EjXWOeZuEtb1fBm3vkaOZIvPb6WES8+6wq2SV0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RgiTEf8BO80EhPHbWcsjJEEtBOgj4rOtbgCHk1eGCaZCEJkzp7GZUlQXTwfRJL0F6
	 f99okFjp35qURiKPo2WAwmHmd53+GLHXKbGVBRfBFJwkXGixzfeRYxkfIJqxr7bmEW
	 uHfU/73/7kh3m7hhwuWPr2zE4suCWpRpFbN1QOM0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HDfWit2224308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 17 Jul 2025 08:41:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 08:41:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 08:41:32 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HDfPkV2253146;
	Thu, 17 Jul 2025 08:41:26 -0500
Message-ID: <187d6072-55b1-4402-a2b5-82afb45a3345@ti.com>
Date: Thu, 17 Jul 2025 19:11:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/17] drm/bridge: cdns-dsi: Don't fail on
 MIPI_DSI_MODE_VIDEO_BURST
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Aradhya Bhatia <aradhya.bhatia@linux.dev>,
        Parth Pancholi
	<parth.pancholi@toradex.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul
	<vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com>
 <20250618-cdns-dsi-impro-v4-17-862c841dbe02@ideasonboard.com>
 <8728de80-f154-46fa-a8a6-da40cb5fdc65@ti.com>
 <5377d377-2822-4d35-981e-45e7352ade17@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <5377d377-2822-4d35-981e-45e7352ade17@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

On 17/07/25 15:59, Tomi Valkeinen wrote:
> Hi,
> 
> On 17/07/2025 12:36, Devarsh Thakkar wrote:
>> Hi Tomi
>>
>> Thanks for the patch.
>>
>> On 18/06/25 15:29, Tomi Valkeinen wrote:
>>> While the cdns-dsi does not support DSI burst mode, the burst mode is
>>> essentially DSI event mode with more versatile clocking and timings.
>> I don't fully agree with this statement, DSI burst mode and DSI event
>> mode are two different things having separate requirements. DSI burst
>> mode maps to MIPI_DSI_MODE_VIDEO_BURST. I don't see a separate flag for
>> event mode but I guess,
> 
> Well, what does DSI burst mode mean? Signal-wise it's the same as DSI
> event mode. "burst" just means that the DSI TX is allowed to send the
> data much faster than the pixel clock. But there's no strict requirement
> that it _must_ be faster.
> 
> So, DSI burst mode is basically DSI event mode with more freedom on the
> timings. Thus, afaics, DSI TX in DSI event mode should always work if
> the DSI RX expects DSI burst mode.
> 

Yes this is true, although there are subtle differences between event 
mode and burst mode and I guess that's why DSI specification 8.11.1 
Transmission Packet Sequences mentions for video mode lists DSI event 
mode sequence as differently then burst mode w.r.t packet sequence viz 
listing 3 different sequences i.e. non-burst with sync pulse, non-burst 
with sync event and burst mode. But seems like we do not have 3 separate 
flags for each of those.

And I see most drivers using MIPI_DSI_MODE_VIDEO both in context of 
selecting video mode as opposed to command mode and also subtly 
inferring it as event mode in case MIPI_DSI_MODE_VIDEO_BURST and 
MIPI_DSI_MODE_VIDEO_PULSE are not set. So there is no accurate way to 
differentiate between the three or for the bridge driver to enforce 
burst mode over event mode and I guess decision is left to host driver.

So, I think this patch looks fine considering these aspects.


>>> Thus cdns-dsi doesn't need to fail if the DSI peripheral driver requests
>>> MIPI_DSI_MODE_VIDEO_BURST.
>>
>> MIPI_DSI_MODE_VIDEO_BURST is currently not supported by the cadence DSI
>> host driver, so only if DSI peripheral driver is saying that burst mode
>> is the only one it supports in that case only we should fail.
>>
>>>
>>> In my particular use case, this allows the use of ti-sn65dsi83 driver.
>>>
>>> Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
>>> Tested-by: Jayesh Choudhary <j-choudhary@ti.com> >>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

>>> ---
>>>    drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/
>>> gpu/drm/bridge/cadence/cdns-dsi-core.c
>>> index 114d883c65dc..09b289f0fcbf 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>>> @@ -1052,10 +1052,6 @@ static int cdns_dsi_attach(struct mipi_dsi_host
>>> *host,
>>>        if (output->dev)
>>>            return -EBUSY;
>>>    -    /* We do not support burst mode yet. */
>>> -    if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
>>> -        return -ENOTSUPP;
>>> -
>>
>> Removing this check also gives a false impression that burst mode is
>> supported by the driver and can also lead to failures too in case device
>> is only supporting burst mode.
>>
>> I think it makes sense to fail only if burst mode is the only one being
>> supported by the device, something like below should work I believe,
>>
>> if (dev->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ==
>> MIPI_DSI_MODE_VIDEO_BURST)
>>          return -ENOTSUPP;
>>
>> Regards
>> Devarsh
>>
>>>        /*
>>>         * The host <-> device link might be described using an OF-graph
>>>         * representation, in this case we extract the device of_node from
>>>
> 

