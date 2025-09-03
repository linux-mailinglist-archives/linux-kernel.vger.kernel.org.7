Return-Path: <linux-kernel+bounces-798043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23094B418BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7551662BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C122EBDDE;
	Wed,  3 Sep 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M9wfYP60"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF750276
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888766; cv=none; b=gYVDfrznCwDg9YZYXjv4MZUy0rAeFOBY5MjDejz+fU5uPW5Bd6Lsi8tGjjnzJnMTju3nq5a7kVZvtq6M9RTHZ8JvEXAeRijSZZRNu8s2nrzG+iZ/PjE7piW0jwnFKjm+SegKlHsz//Ytu5QzDFkU76v4gRvCR8xpGAf7zzpvisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888766; c=relaxed/simple;
	bh=gqlTR0Jbggpr2VMyuAmxgvGdPd56tVKYAdXuyt4RnRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odUrwPlZA2hVDgjDK6JL+XmYkxEWKy2WOkThAZ5nwSxdrScX2A645IDo8SE5NoWB7u80nfPsUYBovBjtqfFnQhDsbeucKB96JiUXEwRqmwLFQNS2Tfiwz5IxCm5G+Cf3sO5cUN6Aqwo0FXH2TpOKC3q3AadGPUmQKlaee8b2mRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M9wfYP60; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5838cYeo2729064;
	Wed, 3 Sep 2025 03:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756888714;
	bh=p+bnk9hnPHDAuBT4RAdQsrSi6iWpP1oNsf+uCxFqVUE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=M9wfYP60WERItcBHBKevPw5sJiIV2wJnO8AqU8jhT1zQ2TRywB1LENEXxscFSMggz
	 NXpF7Xbzg8TnKlKZNaBesw0FzATGwzpOS5YVBdfPw9vmbv8tig8uaHy7145fcR6JlI
	 AvIvBZ72E3B+qhEu9tX3lc6dNT/EZ2OOzchhcFQ4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5838cYgJ3390640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 03:38:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 03:38:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 03:38:33 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5838cTXt1002551;
	Wed, 3 Sep 2025 03:38:30 -0500
Message-ID: <c7f6958f-2c05-4887-88fa-a36bba3c73b6@ti.com>
Date: Wed, 3 Sep 2025 14:08:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/tidss: Remove max_pclk_khz from tidss display
 features
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxime Ripard
	<mripard@kernel.org>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <simona@ffwll.ch>, <aradhya.bhatia@linux.dev>
References: <20250819192113.2420396-1-s-jain1@ti.com>
 <20250819192113.2420396-3-s-jain1@ti.com>
 <b95b60c3-5988-4238-a8d4-73bd8bbf8779@ideasonboard.com>
 <20250827-illegal-splendid-coyote-aff8cc@houat>
 <c3488e85-5cf0-4c97-85c3-64f4c2f5c9c5@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <c3488e85-5cf0-4c97-85c3-64f4c2f5c9c5@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi, Maxime,

On 8/27/25 15:19, Tomi Valkeinen wrote:
> Hi,
> 
> On 27/08/2025 12:27, Maxime Ripard wrote:
>> On Wed, Aug 27, 2025 at 11:49:22AM +0300, Tomi Valkeinen wrote:
>>> On 19/08/2025 22:21, Swamil Jain wrote:
>>>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>>>
>>>> TIDSS hardware by itself does not have variable max_pclk for each VP.
>>>> The maximum pixel clock is determined by the limiting factor between
>>>> the functional clock and the PLL (parent to the VP/pixel clock).
>>>
>>> Hmm, this is actually not in the driver, is it? We're not limiting the
>>> pclk based on the fclk.
>>>
>>>> The limitation that has been modeled till now comes from the clock
>>>> (PLL can only be programmed to a particular max value). Instead of
>>>> putting it as a constant field in dispc_features, we can query the
>>>> DM to see if requested clock can be set or not and use it in
>>>> mode_valid().
>>>>
>>>> Replace constant "max_pclk_khz" in dispc_features with
>>>> max_successful_rate and max_attempted_rate, both of these in
>>>> tidss_device structure would be modified in runtime. In mode_valid()
>>>> call, check if a best frequency match for mode clock can be found or
>>>> not using "clk_round_rate()". Based on that, propagate
>>>> max_successful_rate and max_attempted_rate and query DM again only if
>>>> the requested mode clock is greater than max_attempted_rate. (As the
>>>> preferred display mode is usually the max resolution, driver ends up
>>>> checking the highest clock the first time itself which is used in
>>>> subsequent checks).
>>>>
>>>> Since TIDSS display controller provides clock tolerance of 5%, we use
>>>> this while checking the max_successful_rate. Also, move up
>>>> "dispc_pclk_diff()" before it is called.
>>>>
>>>> This will make the existing compatibles reusable if DSS features are
>>>> same across two SoCs with the only difference being the pixel clock.
>>>>
>>>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
>>>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>>> ---
>>>>   drivers/gpu/drm/tidss/tidss_dispc.c | 85 +++++++++++++----------------
>>>>   drivers/gpu/drm/tidss/tidss_dispc.h |  1 -
>>>>   drivers/gpu/drm/tidss/tidss_drv.h   | 11 +++-
>>>>   3 files changed, 47 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
>>>> index c0277fa36425..c2c0fe0d4a0f 100644
>>>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>>>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>>>> @@ -58,10 +58,6 @@ static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>>>>   const struct dispc_features dispc_k2g_feats = {
>>>>   	.min_pclk_khz = 4375,
>>>>   
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_DPI] = 150000,
>>>> -	},
>>>> -
>>>>   	/*
>>>>   	 * XXX According TRM the RGB input buffer width up to 2560 should
>>>>   	 *     work on 3 taps, but in practice it only works up to 1280.
>>>> @@ -144,11 +140,6 @@ static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>>>>   };
>>>>   
>>>>   const struct dispc_features dispc_am65x_feats = {
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_DPI] = 165000,
>>>> -		[DISPC_VP_OLDI_AM65X] = 165000,
>>>> -	},
>>>> -
>>>>   	.scaling = {
>>>>   		.in_width_max_5tap_rgb = 1280,
>>>>   		.in_width_max_3tap_rgb = 2560,
>>>> @@ -244,11 +235,6 @@ static const u16 tidss_j721e_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>>>>   };
>>>>   
>>>>   const struct dispc_features dispc_j721e_feats = {
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_DPI] = 170000,
>>>> -		[DISPC_VP_INTERNAL] = 600000,
>>>> -	},
>>>> -
>>>>   	.scaling = {
>>>>   		.in_width_max_5tap_rgb = 2048,
>>>>   		.in_width_max_3tap_rgb = 4096,
>>>> @@ -315,11 +301,6 @@ const struct dispc_features dispc_j721e_feats = {
>>>>   };
>>>>   
>>>>   const struct dispc_features dispc_am625_feats = {
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_DPI] = 165000,
>>>> -		[DISPC_VP_INTERNAL] = 170000,
>>>> -	},
>>>> -
>>>>   	.scaling = {
>>>>   		.in_width_max_5tap_rgb = 1280,
>>>>   		.in_width_max_3tap_rgb = 2560,
>>>> @@ -376,15 +357,6 @@ const struct dispc_features dispc_am625_feats = {
>>>>   };
>>>>   
>>>>   const struct dispc_features dispc_am62a7_feats = {
>>>> -	/*
>>>> -	 * if the code reaches dispc_mode_valid with VP1,
>>>> -	 * it should return MODE_BAD.
>>>> -	 */
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_TIED_OFF] = 0,
>>>> -		[DISPC_VP_DPI] = 165000,
>>>> -	},
>>>> -
>>>>   	.scaling = {
>>>>   		.in_width_max_5tap_rgb = 1280,
>>>>   		.in_width_max_3tap_rgb = 2560,
>>>> @@ -441,10 +413,6 @@ const struct dispc_features dispc_am62a7_feats = {
>>>>   };
>>>>   
>>>>   const struct dispc_features dispc_am62l_feats = {
>>>> -	.max_pclk_khz = {
>>>> -		[DISPC_VP_DPI] = 165000,
>>>> -	},
>>>> -
>>>>   	.subrev = DISPC_AM62L,
>>>>   
>>>>   	.common = "common",
>>>> @@ -1347,25 +1315,57 @@ static void dispc_vp_set_default_color(struct dispc_device *dispc,
>>>>   			DISPC_OVR_DEFAULT_COLOR2, (v >> 32) & 0xffff);
>>>>   }
>>>>   
>>>> +/*
>>>> + * Calculate the percentage difference between the requested pixel clock rate
>>>> + * and the effective rate resulting from calculating the clock divider value.
>>>> + */
>>>> +unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate)
>>>> +{
>>>> +	int r = rate / 100, rr = real_rate / 100;
>>>> +
>>>> +	return (unsigned int)(abs(((rr - r) * 100) / r));
>>>> +}
>>>> +
>>>> +static int check_pixel_clock(struct dispc_device *dispc,
>>>> +			     u32 hw_videoport, unsigned long clock)
>>>> +{
>>>> +	unsigned long round_clock;
>>>> +
>>>> +	if (dispc->tidss->is_ext_vp_clk[hw_videoport])
>>>> +		return 0;
>>>> +
>>>> +	if (clock <= dispc->tidss->max_successful_rate[hw_videoport])
>>>> +		return 0;
>>>> +
>>>> +	if (clock < dispc->tidss->max_attempted_rate[hw_videoport])
>>>> +		return -EINVAL;
>>>> +
>>>> +	round_clock = clk_round_rate(dispc->vp_clk[hw_videoport], clock);
>>>> +
>>>> +	if (dispc_pclk_diff(clock, round_clock) > 5)
>>>> +		return -EINVAL;
>>>> +
>>>> +	dispc->tidss->max_successful_rate[hw_videoport] = round_clock;
>>>> +	dispc->tidss->max_attempted_rate[hw_videoport] = clock;
>>>
>>> I still don't think this logic is sound. This is trying to find the
>>> maximum clock rate, and optimize by avoiding the calls to
>>> clk_round_rate() if possible. That makes sense.
>>>
>>> But checking for the 5% tolerance breaks it, in my opinion. If we find
>>> out that the PLL can do, say, 100M, but we need pclk of 90M, the current
>>> maximum is still the 100M, isn't it?
>>
>> 5% is pretty large indeed. We've been using .5% in multiple drivers and
>> it proved to be pretty ok. I would advise you tu use it too.
> 
> The 5% comes from OMAP DSS, where we had to do pixel clock with a few
> dividers and multipliers. The rates were quite coarse, and we ended up
> having quite a large tolerance.
> 
> I think with tidss, we always have a PLL we control, so we should always
> have very exact clocks. So I'm fine with dropping it to .5%. However,
> this patch and series is about removing the a-bit-too-hardcoded VP clk
> max rate code in the driver, so I would leave everything else to another
> series.
> 
>> It's not clear to me why avoiding a clk_round_rate() call is something
>> worth doing though?
> 
> Hard to say if it's worth doing, someone should make some perf tests.
> However, afaik, the calls do go to the firmware, so it involves
> inter-processor calls. On OMAP DSS checking the clock rates was slow, as
> it involved lots of iterating with dividers and multipliers. Perhaps
> it's much faster here.
> 
>> Even caching the maximum rate you have been able to reach before is
>> pretty fragile: if the PLL changes its rate, or if a sibling clock has
>> set some limits on what the PLL can do, your maximum isn't relevant
>> anymore.
> 
> You're right, although afaik it should not happen with TI's SoCs. We
> would be in trouble anyway if that were the case (e.g. someone starts
> the camera, and suddenly we can't support 1080p anymore).
> 
>> in other words, what's wrong with simply calling clk_round_rate() and
>> checking if it's within a .5% deviation?
> 
> This started with discussions how to replace the hardcoded max VP clock
> rate (used to quickly weed out impossible rates), which in reality was
> actually PLL max clock rate. We don't know the PLL max rate, and can't
> query it, so this approach was taken.
> 
>> At the very least, this should be explained in comments or the commit
>> message.
> 
> I agree.
> 
> Swamil, can you do some perf tests with clk_round_rate()? If it's fast
> (enough), it will simplify the driver.

Average execution time is around 112 us.
Trace file including the execution time for clk_round_rate(): 
https://gist.github.com/swamiljain/2abe86982cdeba1d69223d2d525e0cb6
It is better to reduce calls to clk_round_rate().

Need your suggestions for a better approach.

Regards,
Swamil
> 
>   Tomi
> 

