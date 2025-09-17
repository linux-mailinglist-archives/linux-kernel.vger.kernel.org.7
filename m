Return-Path: <linux-kernel+bounces-820835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795DB7F72A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1BC4A4115
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1633F30AACA;
	Wed, 17 Sep 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OB6i/5+Q"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C612C3261
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116017; cv=none; b=VvmvIgj+BxheExhsAqrO/V3i0sN1o4U+j8HlMCowXPcB2sl6DIA78MLEIHAtbsUoGbq0c2TVXdnpBb6qhYM6oO4aOUNw9rPptn0LWKe1YNlLezJ0ms1DEKwMSFI+DA39jzIrS6+KOTcKPIEunP35VlHrQP6YmZmCrKdZKyKLgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116017; c=relaxed/simple;
	bh=3UHVt4CiPgFuJtgjiBpOMYFsvBsBppQz7CtHmjuVYYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rop58ONlDnmlwuwjqkHvOqmczf7+MEWjSixCcd6/PJjyaHzmtRCCnJLLJZZfpCA87pktCCjonNPa08dFpi4wbVP05Mhd3hpE99lgDLfolxv+ELpU7l5kDSyi3NRO1n//4aN0OHG5V3xAdbUYVecN5b3gfM17Baoo/1qtN3SzwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OB6i/5+Q; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HDX5O5257011;
	Wed, 17 Sep 2025 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758115985;
	bh=4ugsa4/0/nBs7/nCN/iRlWhAr+2bZP9S4rlwvOe5Q2A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OB6i/5+QsDKnmnj3ap9ZCMLNpSVKaL7RSlQgmutQ3CYFjSWZ/z9Mzsmd9/5gimdUw
	 svfSGkss6wnpDN6eVbi9yRGXsH6UiCZ71odkSPINc5ws6UB70inTbHjx0SsaJfWKwi
	 UhWQzfyJTsWIrrKcnS7/PN/zWiHZU46/K1n8Vvb4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HDX4QS1573544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 08:33:04 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 08:33:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 08:33:04 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HDWxAn3413902;
	Wed, 17 Sep 2025 08:32:59 -0500
Message-ID: <a0df1c72-2571-4791-ac66-07f9b3431ff6@ti.com>
Date: Wed, 17 Sep 2025 19:02:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] drm/tidss: oldi: Add property to identify OLDI
 supported VP
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
References: <20250911110715.2873596-1-s-jain1@ti.com>
 <20250911110715.2873596-2-s-jain1@ti.com>
 <a306a386-bbd9-408c-b76d-0ecebc1f32ae@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <a306a386-bbd9-408c-b76d-0ecebc1f32ae@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

On 9/16/25 17:10, Tomi Valkeinen wrote:
> Hi,
> 
> On 11/09/2025 14:07, Swamil Jain wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> TIDSS should know which VP has OLDI output to avoid calling clock
>> functions for that VP as those are controlled by oldi driver. Add a
>> property "is_ext_vp_clk" to "tidss_device" structure for that. Mark it
>> 'true' in tidss_oldi_init() and 'false' in tidss_oldi_deinit().
>>
>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> 
> What bug does this fix? It's just adding a new field which it sets to
> true/false...

Please take a look: 
https://lore.kernel.org/all/a0489fea-8c06-4c89-a530-8be691f4705d@ti.com/

Should we remove the tag?
Or, else, please suggest a better way to describe the issue mentioned in 
above link.

Regards,
Swamil
> 
>   Tomi
> 
>> Tested-by: Michael Walle <mwalle@kernel.org>
>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> ---
>>   drivers/gpu/drm/tidss/tidss_drv.h  | 2 ++
>>   drivers/gpu/drm/tidss/tidss_oldi.c | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
>> index 84454a4855d1..e1c1f41d8b4b 100644
>> --- a/drivers/gpu/drm/tidss/tidss_drv.h
>> +++ b/drivers/gpu/drm/tidss/tidss_drv.h
>> @@ -24,6 +24,8 @@ struct tidss_device {
>>   
>>   	const struct dispc_features *feat;
>>   	struct dispc_device *dispc;
>> +	bool is_ext_vp_clk[TIDSS_MAX_PORTS];
>> +
>>   
>>   	unsigned int num_crtcs;
>>   	struct drm_crtc *crtcs[TIDSS_MAX_PORTS];
>> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
>> index 7688251beba2..7ecbb2c3d0a2 100644
>> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
>> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
>> @@ -430,6 +430,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
>>   	for (int i = 0; i < tidss->num_oldis; i++) {
>>   		if (tidss->oldis[i]) {
>>   			drm_bridge_remove(&tidss->oldis[i]->bridge);
>> +			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
>>   			tidss->oldis[i] = NULL;
>>   		}
>>   	}
>> @@ -580,6 +581,7 @@ int tidss_oldi_init(struct tidss_device *tidss)
>>   		oldi->bridge.timings = &default_tidss_oldi_timings;
>>   
>>   		tidss->oldis[tidss->num_oldis++] = oldi;
>> +		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
>>   		oldi->tidss = tidss;
>>   
>>   		drm_bridge_add(&oldi->bridge);
> 


