Return-Path: <linux-kernel+bounces-867164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE357C01B81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D891AA1939
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7C32D0CA;
	Thu, 23 Oct 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJpXw72l"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5832C949
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229174; cv=none; b=jwbvqcO/hTYNlxyGpye2ujxanxRvGGzJdK9veQ1IPS7KgOnSxAYFAj4ERW/maQPoPhhJqywb/M4FDYEYhZViThS8v5WSbm6x779C9vRjLY0j9PRvCB4FGUg09a6cGAFG1hCuoVBIfM780un6oxHSMtYVwD3JHqyDSpBwUe5pi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229174; c=relaxed/simple;
	bh=DD/LjVJ4r3VwFMI0i4ip+4b/PzWcEoqUe71F9KO39q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MyvH76QxOCfqjSY/NB7PLR0uXpuMoFKysjujtGrAsmEt5qEo4Jz1A9wH5YWPSyVed/BTz44YLYOrgeipP86khHus2cuxepTX7nHz2E41y2B35TOwOVvdE4GYi/SB1/Yo4JWN4bbeyVfZnGasc3EdBIh6jJy2HVD3WD4hJ3FwLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJpXw72l; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NEJ0L0546095;
	Thu, 23 Oct 2025 09:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761229140;
	bh=e2yWPLePi+7T2QA9Hkta9aE8H47CbLmVkxnudVa+s5g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AJpXw72l3oDREStkT2ZjXSbX9litVmNi2n4afyeKq3BWlZQVDbzp4q1xj+Ks2SuZY
	 pi5uJTUdvJF69nVAK173PCNAmfjrrTvMIGTxdPvxYOCBV7sYWZjkSh5l45Fx7xT2jR
	 m5iWSvh/8S4t8is4TYYmKDt+xbXCGlgALpHElcfI=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NEIwVq2869668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 09:18:58 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 09:18:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 09:18:58 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NEIqLK2983421;
	Thu, 23 Oct 2025 09:18:53 -0500
Message-ID: <e00495db-4cb0-4a24-ad58-39d22c6a36cc@ti.com>
Date: Thu, 23 Oct 2025 19:48:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: sii902x: Fix HDMI detection with
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <airlied@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <jani.nikula@intel.com>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <s-wang12@ti.com>, <r-donadkar@ti.com>,
        <h-shenoy@ti.com>
References: <20251007112309.1103811-1-devarsht@ti.com>
 <3f026b8c-d917-4197-b7f8-51ef3355aca7@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <3f026b8c-d917-4197-b7f8-51ef3355aca7@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi,

On 22/10/25 12:19, Tomi Valkeinen wrote:
> Hi,
> 

Thanks for the review.

> On 07/10/2025 14:23, Devarsh Thakkar wrote:
>> The SII902x HDMI bridge driver wasn't working properly with drivers that
>> use the newer bridge connector architecture with the
>> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, like TIDSS.  This caused HDMI audio to
>> fail since the driver wasn't properly setting the sink_is_hdmi flag when
>> the bridge was attached without a connector since .get_modes() is never
>> called in this case. Fix it by setting sink_is_hdmi flag when reading
>> the EDID block itself.
>>
>> Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V3: Use drm_edid_connector_update without edid NULL check
>> V2: Use drm_edid_connector_update to detect HDMI
>>
>> Link to V2:
>> https://lore.kernel.org/all/20251006150714.3144368-1-devarsht@ti.com/
>> Link to V1:
>> https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/
>>
>>   drivers/gpu/drm/bridge/sii902x.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index d537b1d036fb..bb613d4c281f 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -296,6 +296,8 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
>>   	mutex_lock(&sii902x->mutex);
>>   
>>   	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
>> +	drm_edid_connector_update(connector, drm_edid);
>> +	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
>>   
>>   	mutex_unlock(&sii902x->mutex);
> 
> I'm not sure if this is right. If I'm not mistaken, the
> drm_bridge_connector.c calls sii902x_edid_read, and then does a
> drm_edid_connector_update(). So drm_edid_connector_update() will be
> called twice, and also, I don't think the bridge should be updating
> connector's data when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 

Thanks for catching this!. I missed out to catch this while addressing 
previous review comment.

> Maybe either drop sink_is_hdmi, and just look at
> connector->display_info.is_hdmi, or if that doesn't work for some
> reason, just get the "is-hdmi" flag from the edid data directly.
> 

Yes I plan to drop sink_is_hdmi flag altogether and directly use 
connector->display_info.is_hdmi in v4.

I think we should be able to use 
drm_atomic_get_new_connector_for_encoder in .atomic_enable to get the 
connector->display_info.is_hdmi and this should work for both the legacy 
and DISPLAY_BRIDGE_ATTACH_NO_CONNECTOR scenarios and set the output mode 
accordingly. I will try out with this approach.

Kindly let me know if any concerns with above approach.

Regards
Devarsh

>   Tomi
> 
>> @@ -309,14 +311,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
>>   	int num = 0;
>>   
>>   	drm_edid = sii902x_edid_read(sii902x, connector);
>> -	drm_edid_connector_update(connector, drm_edid);
>>   	if (drm_edid) {
>>   		num = drm_edid_connector_add_modes(connector);
>>   		drm_edid_free(drm_edid);
>>   	}
>>   
>> -	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
>> -
>>   	return num;
>>   }
>>   
> 


