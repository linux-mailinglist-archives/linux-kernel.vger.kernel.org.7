Return-Path: <linux-kernel+bounces-740447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4B1B0D43B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7117BAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2328937F;
	Tue, 22 Jul 2025 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k1VuapnJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AD1CB31D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172166; cv=none; b=B4b1qUfvm3n56DNS1sA5L5C91SYwIkMAyEfJolmkjlYnBkn4ssF0pPBAdUYuJDP2oCBZQD1Ad1BqIH0vbtNMyVlwRZURJmMlh/TIOUhlm8DMHe91Af799AIf/G0hkCyCsRPd6Pna6TnGtSAm/aHjErt2x28P5HEoNHD1OB1Pl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172166; c=relaxed/simple;
	bh=UkCnmPho3pULlm+TI+Fx5qHx7xa44iEJ1ZUh0duF0WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0qHATWWbdNAgdO4KuSaXI/AyasDo58p1EHYY7r04MH3mHEN/Yi8Uj67tTViWsf4yfKB3RR//qOEd0vl+lifjOMaHIeyppdTho19UGYFoo1LTaKbFCHTUIoPRTyh9AY6gSa3JlSbUXYGthW+zVWHbuS804kD21fjfqy6OohCKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k1VuapnJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753172161;
	bh=UkCnmPho3pULlm+TI+Fx5qHx7xa44iEJ1ZUh0duF0WI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k1VuapnJr6IYB6PW1xKh+FvjUfiBa6DptAWcpTRKLD88/1nlzC3gSUsc0Y38WLEUA
	 YSQj0IPO/hxw8xgojj5TghKqZJaPGABLGRloMcCXPzZqEqx/6T83VreCIzVMyOpJx0
	 IdZ1Wj9hRLOTURxz//4x9nvIsQs0D7Ljjry+HWSMb2gKn1vVv+Hwhl4mMPqtY4nmyQ
	 uke7breOBQXaR7qs+MV0qOGRDuQQ0S855nSM6teTdrubCiEosBKgQhKIboNipdv+wA
	 38yHj5N7rHWmxnDoL0fwyRu22Ge0adrGwc4o/MJYyJTWDHCx7tmNVL+DWtKa21kIdJ
	 dM1r/7AzimK8g==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C89217E0FA8;
	Tue, 22 Jul 2025 10:16:00 +0200 (CEST)
Message-ID: <cf988216-fb46-4761-bbfd-7ac3a000e542@collabora.com>
Date: Tue, 22 Jul 2025 11:15:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/rockchip: vop2: Add high color depth support
To: Andy Yan <andyshrk@163.com>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
 <20250721-rk3588-10bpc-v1-1-e95a4abcf482@collabora.com>
 <3ceb2c70.2145.1982ff28b9c.Coremail.andyshrk@163.com>
 <c5624dad-93cb-4cc3-88ad-808dcc43274d@collabora.com>
 <4966b602.5395.19830ea1e2f.Coremail.andyshrk@163.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <4966b602.5395.19830ea1e2f.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 7/22/25 9:55 AM, Andy Yan wrote:
> 
> Hello Cristian,
> 
> 在 2025-07-22 14:16:26，"Cristian Ciocaltea" <cristian.ciocaltea@collabora.com> 写道：
>> Hi Andy,
>>
>> On 7/22/25 5:24 AM, Andy Yan wrote:
>>>
>>> Hello Cristian，
>>>
>>> At 2025-07-22 01:39:04, "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com> wrote:
>>>> Take the bits per color channel into consideration when computing DCLK
>>>> rate.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>> index 186f6452a7d359f079662bc580850929632ea8fe..a714bcbb02de16267e7febbaeb1eb270c70aaef2 100644
>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>>> @@ -1731,6 +1731,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>>>> 		clock *= 2;
>>>> 	}
>>>>
>>>> +	if (vcstate->output_bpc > 8)
>>>> +		clock = DIV_ROUND_CLOSEST(clock * vcstate->output_bpc, 8);
>>>
>>>
>>> This seems not right,  regardless of the value of bpc, the dclk of VOP must be
>>> consistent with mode->crtc_clock.
>>> If the dclk of VOP is increased in accordance with the BPC ratio here, then the refresh rate of VOP will also increase proportionally.
>>> This would be inconsistent with the timing described in the mode.
>>> For a hight color depth,  the frequency needs to be increased for the HDMI PHY's clock.
>>
>> The HDMI PHY's clock is actually computed at HDMI connector framework level
>> [1], taking into account the current bpc value, which is determined as part
>> of hdmi_compute_config() [2].
>>
>> That means conn_state->hdmi.tmds_char_rate in
>> dw_hdmi_qp_rockchip_encoder_atomic_check() does already include the bpc
>> related adjustment, and we pass that directly to the PHY via
>> phy_configure().  Note there's still the need to handle bpc separately via
>> phy_configure_opts in order to setup CMN_REG(0086) [3].
>>
>> Since VOP2 switches to PHY PLL as DCLK source for modes up to 4K@60Hz, it
>> needs to take color depth into account, to keep them in sync.  As a matter
>> of fact, the clock adjustment in VOP2 is mainly necessary for legacy
>> reasons, since HDPTX PHY allowed changing TMDS char rate via the Common
>> Clock Framework API.  We landed a proper solution for that via the HDMI PHY
>> API, hence the plan would be to make CCF API readonly after the switch to
>> PHY API is completed, which means VOP2 shouldn't deal anymore with clock
>> calculations when using the PHY PLL as DCLK source.
> 
> What I want to emphasize is that on the vop/crtc side, what we should be concerned about is mode -> clock, 
> not the HDMI PHY clock. The HDMI PHY clock is something that the HDMI bridge or the HDMI PHY driver needs to pay attention to.
> 
> This patch works just because currently, on RK3576 and RK3588, the HDMI PHY PLL can be used as the dclk source for the vop.
> After correctly setting CMN_REG0086, it can precisely adjust the HDMI HPY PLL clock adjusted according to the bpc further to
> the frequency of mode->clock, and then use it as the dclk for the vop.
> However, we also need to be aware of the following situations:
> 
> 1) When we are using HDMI, we can still choose the system PLL instead of the HDMI PHY PLL as
>     the clock source for dclk. In this case, this patch will cause incorrect mode->clock.
> 2)  When we are using HDMI above the 4K60 mode(4K120), we can only use the system PLL instead
>      of the HDMIPHY PLL as the clock source for the vop dclk,  this patch will cause incorrect mode->clock.
> 3) For RK3576 and RK3588,  interfaces such as DP, eDP, and DSI also support 10-bit mode. 
>     However, in most cases, they will choose the system PLL as the vop dclk clock source,this patch will cause incorrect mode->clock.
> 4) There are also other platforms, such as RK3568, even for HDMI , it still uses the system PLL as the dclk clock source for vop.
>      this patch will cause incorrect mode->clock.

Oh, I wrongly assumed high color depth is not currently supported/in use for vop2.

In that case my suggestion below is actually a mandatory thing to do, as it should 
correctly reduce the scope to RK3576 & RK3588 only.

>>
>> Regardless, I should probably move this clock adjustment to the conditional
>> block handling DCLK source switch.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/display/drm_hdmi_state_helper.c?h=v6.16-rc7#n525
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/display/drm_hdmi_state_helper.c?h=v6.16-rc7#n608
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c?h=v6.16-rc7#n1034


