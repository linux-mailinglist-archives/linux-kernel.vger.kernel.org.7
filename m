Return-Path: <linux-kernel+bounces-744082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F597B107CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32EF7B510D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2523D29F;
	Thu, 24 Jul 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MWaSIdnG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28A19343B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353147; cv=none; b=dHmtjpkrsn8jpLx4H3euj1V5DCTAZC3xBMFbTLBhIWEC8Wsfw0/ZMuit9j8RrSuEMw2LOUFd0ARcAZg2Nz0/p8oiphwip1jQekhN/06RxCDKiPuRHPcpZqSWJKC2OQ4XPGtKfGoDpmj2d6hN7fnNOPV1hRmD6IyKtr6gr2blSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353147; c=relaxed/simple;
	bh=itHtoJ3M+ZeANRW0vAxkLr2MjBaEu5vwDE7ZADcfbA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfJDX2KvNOzSHEDiWEnQrEfr7meamns4otAchQz4ND/Pdl1m25FCnC5LKrhD+E3AexaP9ABf3eDU6X3XlLGNeshXYxQXUgvH3gWjmf/vyQfkkWHplkRQeYhwXgRX2y2HN0ZbSjeBmtiptZ/Q8hkd4njOh5+bpfef8V4ybQqhEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MWaSIdnG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753353143;
	bh=itHtoJ3M+ZeANRW0vAxkLr2MjBaEu5vwDE7ZADcfbA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MWaSIdnGoBwiZtZtbKK6XVz7WtAtEYZN8QFphI/pokVgkCFCXOweirTeO9wMLhAjM
	 hbcWaqG8twtORyImZ8qfVHe53KxT9YFsorWXjGY8duDUGYl8leyK1aRWNxuXroMZ8w
	 ANW2H5sexn0CouRfNFEuT08ZNoRGHBOfuSSAefkQ7SwtjeprR1WgVzjxm4OnBZaA4U
	 sle4dpBTPm6ZSXrCz1/8BC9vpk20D73T9kawJm7J0U3AVKKVtISIvaqpc5d54YrZBn
	 PHqJ8xT0SHcXoHWgls97p7ROY28YaFiIYWYiTyNj0f31CCRubYCYtv+GRnvhwm2Fh4
	 uXeOf3YlnXj/Q==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4894F17E046D;
	Thu, 24 Jul 2025 12:32:22 +0200 (CEST)
Message-ID: <230f25cb-52cb-4ae0-81a1-85e8de873891@collabora.com>
Date: Thu, 24 Jul 2025 13:32:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/rockchip: vop2: Add high color depth support
To: Andy Yan <andyshrk@163.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Algea Cao <algea.cao@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
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
 <12451b41.7627.1983ba589ec.Coremail.andyshrk@163.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <12451b41.7627.1983ba589ec.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 7/24/25 11:56 AM, Andy Yan wrote:
> 
> 
> 
> Hello Cristian，
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
> 
> 
> There might be a misunderstanding here. The values of hdmi.tmds_char_rate and vop dclk are not always equal in all cases.
> For vop dclk always match mode->clock,  hdmi.tmds_char_rate will adjust with bpc.
> For example,  for a 4KP30 YUV444 8 bit,   vop->dclk = hdmi.tmds_char_rate = 297MHZ,
> for 4KP30 YUV444 10 bit,  hdmi.tmds_char_rate = 1.25 * vop->dclk.
> 
> In fact, for the HDMI PHY, there are two clocks. One is a clock with the same frequency as the HDMI PLL, namely.tmds_char_rate,
>  and the other is a clock obtained by further frequency division of the HDMI PLL, which can be supplied to the vop dclk.
> 
>                       ----------------------- >tmds_char_rate 
>                       |
> PHY PLL------|
> 
>                       |
>                       ------DIV(REG0086[3-1])-->vop dclk.

Oh, I missed the fact there's a divider between PLL and DCLK.
All this makes sense now, thanks for clarifying!

Regards,
Cristian

> So in this case, my suggestion is still to follow the implementation of our BSP kernel:
> On the crtc side, it shoud set dclk as the mode->clock.
> At the PHY side(rk_hdptx_phy_clk_set_rate) when set the vop dclk, it should adjust the PLL clock according to the bpc:
> if (bpc > 8)
>                 bit_rate = clock * 10 / 8;
> 
> 
> 
>> reasons, since HDPTX PHY allowed changing TMDS char rate via the Common
>> Clock Framework API.  We landed a proper solution for that via the HDMI PHY
>> API, hence the plan would be to make CCF API readonly after the switch to
>> PHY API is completed, which means VOP2 shouldn't deal anymore with clock
>> calculations when using the PHY PLL as DCLK source.
>>
>> Regardless, I should probably move this clock adjustment to the conditional
>> block handling DCLK source switch.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/display/drm_hdmi_state_helper.c?h=v6.16-rc7#n525
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/display/drm_hdmi_state_helper.c?h=v6.16-rc7#n608
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c?h=v6.16-rc7#n1034


