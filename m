Return-Path: <linux-kernel+bounces-816602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797FB57613
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED293442DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9E2FABE8;
	Mon, 15 Sep 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jiR8W1I8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3F22DF9E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931478; cv=none; b=gohS8M1dJZgPplKSYfUTkS4NirSVA1vYRbW9hP+e7Oyw3B5hFRe3KAH12I/C78oNezn1wgTfQJXxELDQnEklFzJh4/juPFNhmiq55g4bWOdzGiZWqQ1kaKQHGJuIZzNuDbndyJlJY4/N4xI1A/9tdSFbsYNMhowF8yfAjTe1yc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931478; c=relaxed/simple;
	bh=CkiX+SfKyNNzh/CR0iQ6mQNKdawIAKfXA08rWVJaslk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3S0Vl1Uaf+zDP0JqM4RgVJkGUdDCAdBEOM6LAC4mGncSAbBBL4j1zzqcxkAQihyEm42d8y3HOWsUI7eK0E9WznO6vM6YnWAwdK5kDqHMmawMW76hJzzjRb7Rmul3InRhObI2X4oEKUuIlz8HNPpCMa0YGs6aD56AHwEs+FPkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jiR8W1I8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 129291744;
	Mon, 15 Sep 2025 12:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757931397;
	bh=CkiX+SfKyNNzh/CR0iQ6mQNKdawIAKfXA08rWVJaslk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jiR8W1I8s3wsT9NIvLDvLoiMR/cm4NB1lZ7jWZxngS31BhXK/K+rwDUGm3E0gd10k
	 jiFLdi4RJEMQL90KwHbGxHlvKgXzcG6gynUpx3zFFFJ1J7pkDVk5UIWN/dz9d5ve/U
	 qkCoA0+DPZcv5tBn5X0bvWsX00KUAGjge1CbDJmY=
Message-ID: <b6be187a-6005-4de7-8844-66fb957e394e@ideasonboard.com>
Date: Mon, 15 Sep 2025 13:17:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] drm/tidss: oldi: Add atomic_check hook for oldi
 bridge
To: Swamil Jain <s-jain1@ti.com>, Maxime Ripard <mripard@kernel.org>
Cc: jyri.sarha@iki.fi, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 aradhya.bhatia@linux.dev, h-shenoy@ti.com, devarsht@ti.com, vigneshr@ti.com,
 praneeth@ti.com, u-kumar1@ti.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250911110715.2873596-1-s-jain1@ti.com>
 <20250911110715.2873596-4-s-jain1@ti.com>
 <20250915-benevolent-military-penguin-d64871@penduick>
 <4f0a00d9-4edc-4114-aca6-70d6bb654767@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <4f0a00d9-4edc-4114-aca6-70d6bb654767@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 15/09/2025 11:55, Swamil Jain wrote:
> Hi,
> 
> On 9/15/25 13:27, Maxime Ripard wrote:
>> On Thu, Sep 11, 2025 at 04:37:15PM +0530, Swamil Jain wrote:
>>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>>
>>> Since OLDI consumes DSS VP clock directly as serial clock, mode_valid()
>>> check cannot be performed in tidss driver which should be checked
>>> in OLDI driver.
>>>
>>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
>>> Tested-by: Michael Walle <mwalle@kernel.org>
>>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>> ---
>>>   drivers/gpu/drm/tidss/tidss_oldi.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/
>>> tidss/tidss_oldi.c
>>> index 7ecbb2c3d0a2..ada691839ef3 100644
>>> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
>>> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
>>> @@ -309,6 +309,26 @@ static u32
>>> *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>>       return input_fmts;
>>>   }
>>>   +static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
>>> +                   struct drm_bridge_state *bridge_state,
>>> +                   struct drm_crtc_state *crtc_state,
>>> +                   struct drm_connector_state *conn_state)
>>> +{
>>> +    struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
>>> +    struct drm_display_mode *adjusted_mode;
>>> +    unsigned long round_clock;
>>> +
>>> +    adjusted_mode = &crtc_state->adjusted_mode;
>>> +    round_clock = clk_round_rate(oldi->serial, adjusted_mode->clock
>>> * 7 * 1000);
>>> +    /*
>>> +     * To keep the check consistent with dispc_vp_set_clk_rate(),
>>> +     * we use the same 5% check here.
>>> +     */
>>> +    if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000,
>>> round_clock) > 5)
>>> +        return -EINVAL;
>>> +    return 0;
>>> +}
>>> +
>>
>> If you're introducing that check to tidss, please use .5% like everyone
>> else. I understand that you don't want to change tilcdc to avoid any
>> regression, but that's not the case here
>>
> This is just to make the tolerance check consistent for mode validation
> and setting clock rate. This patch isn't introducing anything new, we
> are following this as dispc_vp_set_clk_rate() and
> tidss_oldi_set_serial_clk() are already checking for 5% tolerance while
> setting clock. To remove/modify, this needs extensive testing with other
> K3 and K2G SoCs and can be handled as a separate patch.

I'd like to switch to 0.5%, but as Swamil said, I think it's better to
do it on top.

 Tomi


