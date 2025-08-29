Return-Path: <linux-kernel+bounces-791125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669BB3B247
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EA37A455C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570535979;
	Fri, 29 Aug 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jtL8Bsix"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47830CDB5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756443839; cv=none; b=PM51lskha29qLj0BK803kZywDgj/w1B79Rm+PPWQM66ymnq10iGbI+ImX6KF6fHwq8eXcZR2XJ3LFAlTti2qO3cYJPc7Qod3vnbyNMfEXikyek6u5HHPDrLcQ8m1cXXD8N1Ulb84KM7zTo69KxZ8TvECokRr418UEk08EwoMaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756443839; c=relaxed/simple;
	bh=BosIP+rl730DbbU05vWiZZRA8UIq91ZjpWW0rL2C3SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EFtPPJ1gc6i2hkV1hmZzrFYsa1CUxeiuJj2MgUVM23mEfztDcqmTTHNUiaYX1Gj//sJo8zYmcwPljTvFb5EOgMWTjO36sZnLAevszvEZC0c871cL+NwVXrUTx6gket3wHvwr06hRWN4aniW3AHpeWK7dB+Gh8ZYuWpKhFmdsYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jtL8Bsix; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T3ofIZ1664304;
	Thu, 28 Aug 2025 22:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756439441;
	bh=JecZGomHjcXxStpYm5WYtGVkdYuLAxeKV3RO2Ks+c+U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jtL8BsixVyF4RsinTHN/9tKobmYZtx3dnsCIBMy6uHG+WA1jZNJ2ZeyEVOVsI1lqx
	 6SCz8w/0bOkLBtx79qUXemTENmBawU46h7ZR85CpIfN2d95mlEkrIKtZmUjfw9TpJL
	 Sn6oMw+gTqdTAtwoPmfioWWgD/8jUvR+ja48fYCI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T3oflo3938001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 22:50:41 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 22:50:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 22:50:41 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T3oaMH1709002;
	Thu, 28 Aug 2025 22:50:37 -0500
Message-ID: <a23b03a2-86d0-41ff-882f-40c152ff6fb0@ti.com>
Date: Fri, 29 Aug 2025 09:20:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/tidss: oldi: Add atomic_check hook for oldi
 bridge
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
References: <20250819192113.2420396-1-s-jain1@ti.com>
 <20250819192113.2420396-4-s-jain1@ti.com>
 <837a8381-02bd-4882-bfa4-6d5c34f44119@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <837a8381-02bd-4882-bfa4-6d5c34f44119@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

On 8/27/25 14:35, Tomi Valkeinen wrote:
> Hi,
> 
> On 19/08/2025 22:21, Swamil Jain wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> Since OLDI consumes DSS VP clock directly as serial clock, certain
>> checks cannot be performed in tidss driver which should be checked
> 
> I think this is a bit misleading. The OLDI input clock doesn't come from
> DSS, so I wouldn't call it "DSS VP clock". The point here is that the
> clock from the PLL is used by both OLDI and DSS, and in the current
> architecture the OLDI driver manages the clock, so the DSS driver can't
> really do checks, it just has to accept the clock rate. All checks need
> to be done in the OLDI driver.
> 
>> in OLDI driver. Add check for mode clock and set max_successful_rate
>> and max_attempted_rate field for tidss in case the VP is OLDI.
>>
>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> ---
>>   drivers/gpu/drm/tidss/tidss_oldi.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
>> index ef01ecc17a12..2ed2d0666ccb 100644
>> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
>> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
>> @@ -309,6 +309,30 @@ static u32 *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>   	return input_fmts;
>>   }
>>   
>> +static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
>> +				   struct drm_bridge_state *bridge_state,
>> +				   struct drm_crtc_state *crtc_state,
>> +				   struct drm_connector_state *conn_state)
>> +{
>> +	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
>> +	struct drm_display_mode *adjusted_mode;
>> +	unsigned long round_clock;
>> +
>> +	adjusted_mode = &crtc_state->adjusted_mode;
>> +
>> +	if (adjusted_mode->clock > oldi->tidss->max_successful_rate[oldi->parent_vp]) {
> 
> You can change the above check to <=, and return 0 here early.
> 
>> +		round_clock = clk_round_rate(oldi->serial, adjusted_mode->clock * 7 * 1000);
>> +
>> +		if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000, round_clock) > 5)
>> +			return -EINVAL;
>> +
>> +		oldi->tidss->max_successful_rate[oldi->parent_vp] = round_clock;
>> +		oldi->tidss->max_attempted_rate[oldi->parent_vp] = adjusted_mode->clock * 7 * 1000;
>> +	}
> 
> This is not very nice. We should have a function in tidss that we call
> here, instead of poking into these tidss's variables directly.
> 
> Actually... Do we even need to use the tidss->max_* fields? The above
> code is not checking the VP clock maximum, it's actually looking at the
> serial clock maximum. Currently those two clocks are linked, though, but
> would it make more sense to have the max_* fields here, in OLDI, for
> OLDI's serial clock?We don't require tidss->max_* fields here as we only have single mode 
for OLDI. This is added to make it consistent with check_pixel_clock() 
for validating modes.

You are right we shouldn't use tidss->* fields directly in OLDI driver.

As Maxime suggested we only have very few modes for OLDI, can we skip 
caching maximum pixel clock in case of OLDI? What would you suggest Tomi?

Regards,
Swamil
> 
>   Tomi
> 
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
>>   	.attach	= tidss_oldi_bridge_attach,
>>   	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
>> @@ -317,6 +341,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
>>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>   	.atomic_reset = drm_atomic_helper_bridge_reset,
>> +	.atomic_check = tidss_oldi_atomic_check,
>>   };
>>   
>>   static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
> 

