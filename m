Return-Path: <linux-kernel+bounces-794143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D2B3DD7E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FA91A80234
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACC2FFDCB;
	Mon,  1 Sep 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ewhl9unN"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F22FF65F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717196; cv=none; b=GePtA2oKFbIbGB7hTc/bbMPUrJpw7ymUhLWo2YQjtBomLKF7cXgENBDsVuY77SoIBUGcOdyDj5eCZ7Zw293mDmiG68Y4eoQ0C3OBPhVRuVVUjvVEoEy2UJJ/t7EUJTjSdR/kir1f63eJ39fQrxnIYA4aFmvXyOdoTbSUE7y6jeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717196; c=relaxed/simple;
	bh=XpJXofa8Hm3eaUUocpHURpb5fH9SvnPwM+eiZV1UJPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HWE8DNHJjOSzUx+yjv2PQC6cbOJ30YGHOG17Ufmmnd8kIC38gpMaS3qsX+ENrLbQwvXpv48wyJitzNMrDdC/EbMNCkZFXJnguKBxY84Y9TtsuVN9tUsFOaIcBNdpcmUSbKp3BlicUW9N/fXpUH+yxsZbqsS7znEH3MwyX9zEonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ewhl9unN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5818xSlH2739412;
	Mon, 1 Sep 2025 03:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756717168;
	bh=BxSo+3XJP4cV+Z8z0wpsWsIoQkxyNNRAdE0TKlbeLjI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Ewhl9unNDhsRQQ6+gwAwkxJ+mc1Zrm2dVXXOj+Vx2DDmX4+wTM92eBmq8Cx89Ay2a
	 g/NdX5VDPlcqYDori57uQDf8rRTF6cevHa6czGWcHcTyh6AIPzTs771TKqjTGfVUUI
	 siSCTYYMoBWHCWgP/htz+ITEF5zh3mC17bWe2YKw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5818xS3W1991602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 03:59:28 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 03:59:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 03:59:27 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5818xNPk2214454;
	Mon, 1 Sep 2025 03:59:23 -0500
Message-ID: <7f646e70-73fa-43ea-9fab-c9a0cb64dff6@ti.com>
Date: Mon, 1 Sep 2025 14:29:22 +0530
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
 <a23b03a2-86d0-41ff-882f-40c152ff6fb0@ti.com>
 <327d2ef2-d670-4677-ba1f-b19c2f0b4f3f@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <327d2ef2-d670-4677-ba1f-b19c2f0b4f3f@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

On 9/1/25 14:22, Tomi Valkeinen wrote:
> Hi,
> 
> On 29/08/2025 06:50, Swamil Jain wrote:
>> Hi Tomi,
>>
>> On 8/27/25 14:35, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 19/08/2025 22:21, Swamil Jain wrote:
>>>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>>>
>>>> Since OLDI consumes DSS VP clock directly as serial clock, certain
>>>> checks cannot be performed in tidss driver which should be checked
>>>
>>> I think this is a bit misleading. The OLDI input clock doesn't come from
>>> DSS, so I wouldn't call it "DSS VP clock". The point here is that the
>>> clock from the PLL is used by both OLDI and DSS, and in the current
>>> architecture the OLDI driver manages the clock, so the DSS driver can't
>>> really do checks, it just has to accept the clock rate. All checks need
>>> to be done in the OLDI driver.
>>>
>>>> in OLDI driver. Add check for mode clock and set max_successful_rate
>>>> and max_attempted_rate field for tidss in case the VP is OLDI.
>>>>
>>>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
>>>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>>> ---
>>>>    drivers/gpu/drm/tidss/tidss_oldi.c | 25 +++++++++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/
>>>> tidss/tidss_oldi.c
>>>> index ef01ecc17a12..2ed2d0666ccb 100644
>>>> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
>>>> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
>>>> @@ -309,6 +309,30 @@ static u32
>>>> *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>>>        return input_fmts;
>>>>    }
>>>>    +static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
>>>> +                   struct drm_bridge_state *bridge_state,
>>>> +                   struct drm_crtc_state *crtc_state,
>>>> +                   struct drm_connector_state *conn_state)
>>>> +{
>>>> +    struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
>>>> +    struct drm_display_mode *adjusted_mode;
>>>> +    unsigned long round_clock;
>>>> +
>>>> +    adjusted_mode = &crtc_state->adjusted_mode;
>>>> +
>>>> +    if (adjusted_mode->clock > oldi->tidss-
>>>>> max_successful_rate[oldi->parent_vp]) {
>>>
>>> You can change the above check to <=, and return 0 here early.
>>>
>>>> +        round_clock = clk_round_rate(oldi->serial, adjusted_mode-
>>>>> clock * 7 * 1000);
>>>> +
>>>> +        if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000,
>>>> round_clock) > 5)
>>>> +            return -EINVAL;
>>>> +
>>>> +        oldi->tidss->max_successful_rate[oldi->parent_vp] =
>>>> round_clock;
>>>> +        oldi->tidss->max_attempted_rate[oldi->parent_vp] =
>>>> adjusted_mode->clock * 7 * 1000;
>>>> +    }
>>>
>>> This is not very nice. We should have a function in tidss that we call
>>> here, instead of poking into these tidss's variables directly.
>>>
>>> Actually... Do we even need to use the tidss->max_* fields? The above
>>> code is not checking the VP clock maximum, it's actually looking at the
>>> serial clock maximum. Currently those two clocks are linked, though, but
>>> would it make more sense to have the max_* fields here, in OLDI, for
>>> OLDI's serial clock?We don't require tidss->max_* fields here as we
>>> only have single mode
>> for OLDI. This is added to make it consistent with check_pixel_clock()
>> for validating modes.
>>
>> You are right we shouldn't use tidss->* fields directly in OLDI driver.
>>
>> As Maxime suggested we only have very few modes for OLDI, can we skip
>> caching maximum pixel clock in case of OLDI? What would you suggest Tomi?
> 
> I think it's best to at least try the trivial option discussed in this
> thread: just use clk_round_rate, without any code to cache or seek out
> the max.

Then for OLDI, we will drop caching the max_pclk.

Regards,
Swamil
> 
>   Tomi
> 

