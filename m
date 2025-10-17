Return-Path: <linux-kernel+bounces-858280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A7BE9FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899EB743BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C92F12B8;
	Fri, 17 Oct 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I43apsoR"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5A33711F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713978; cv=none; b=G0VlOjMA2AvJjPVSykNezt6Ot+HJXGFC3QcRPvJRuHBfUSFEhvWRhlNbkAZHwVosOcsk5EeOu+8JXqEJ86SwzCe7qedkr7UGbwssNhhLIiYvUplo4NjGtvZV120vT8aElG11wiPBecLhT2XcvxHfG5rEsUD3Q6a4XlyiffxHTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713978; c=relaxed/simple;
	bh=kS6cUOowy6TvtNHP7qSPgXxm+GgvFrNd4xS5GQD73g0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=RJs9KQ/d4qYeeU/2kPDV4Ov794TGLFZJLa7T/jwGfhjt/EtNuiY4PvmGvjqFx4chIcthYJglw5M2ttVSWuWqaEcsLSaBYl+bapMkiZaQ1cWhkaDKZahM54nE+UIIJgzp8wBkfvU6q4w28YV5kPENGHtKbCQxAXiakJicuPPWx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I43apsoR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HFCRjG300205;
	Fri, 17 Oct 2025 10:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760713947;
	bh=I4HHftsHcus/pLTwKN5o+pQQ1yABcjefFhyFSSLqw1U=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=I43apsoRMiPVDDCoQNarODxToTG//4w1J4qN5dOHeNwM2x/9Pjw9tvmSHe8N4WDQj
	 YnwBAkGJAc2s8JKrclSMICljNxYLQK0EZPF6euoPKDhmmCtqhohbXsUCDBFqUJtE/C
	 H8ZJHggaGgE7NPqBfM1NMASAPnXigFA/3T6zM0bs=
Received: from DLEE205.ent.ti.com (dlee205.ent.ti.com [157.170.170.85])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HFCRXs2883337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 10:12:27 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 10:12:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 10:12:26 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HFCKpt1481443;
	Fri, 17 Oct 2025 10:12:21 -0500
Message-ID: <a43ead15-b01b-4ddc-ad16-1bf4cd3cb222@ti.com>
Date: Fri, 17 Oct 2025 20:42:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: sii902x: Fix HDMI detection with
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
From: Devarsh Thakkar <devarsht@ti.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <jani.nikula@intel.com>,
        <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>,
        <s-wang12@ti.com>, <r-donadkar@ti.com>, <h-shenoy@ti.com>
References: <20251007112309.1103811-1-devarsht@ti.com>
 <4rbyxn2jr4nsogt4wfdin3jpzumjqj4mcplq7on6yyqvq4wu34@qng22gczlfyn>
 <734c8b32-a9a7-4fe5-a6d7-748770e502aa@ti.com>
Content-Language: en-US
In-Reply-To: <734c8b32-a9a7-4fe5-a6d7-748770e502aa@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dmitry,

On 09/10/25 20:39, Devarsh Thakkar wrote:
> Hi Dmitry,
> 
> Thanks for the quick reviews.
> 
> On 09/10/25 01:48, Dmitry Baryshkov wrote:
>> On Tue, Oct 07, 2025 at 04:53:09PM +0530, Devarsh Thakkar wrote:
>>> The SII902x HDMI bridge driver wasn't working properly with drivers that
>>> use the newer bridge connector architecture with the
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, like TIDSS.  This caused HDMI 
>>> audio to
>>> fail since the driver wasn't properly setting the sink_is_hdmi flag when
>>> the bridge was attached without a connector since .get_modes() is never
>>> called in this case. Fix it by setting sink_is_hdmi flag when reading
>>> the EDID block itself.
>>>
>>> Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>> V3: Use drm_edid_connector_update without edid NULL check
>>> V2: Use drm_edid_connector_update to detect HDMI
>>>
>>> Link to V2:
>>> https://lore.kernel.org/all/20251006150714.3144368-1-devarsht@ti.com/
>>> Link to V1:
>>> https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/
>>>
>>>   drivers/gpu/drm/bridge/sii902x.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/ 
>>> bridge/sii902x.c
>>> index d537b1d036fb..bb613d4c281f 100644
>>> --- a/drivers/gpu/drm/bridge/sii902x.c
>>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>>> @@ -296,6 +296,8 @@ static const struct drm_edid 
>>> *sii902x_edid_read(struct sii902x *sii902x,
>>>       mutex_lock(&sii902x->mutex);
>>>       drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux- 
>>> >adapter[0]);
>>> +    drm_edid_connector_update(connector, drm_edid);
>>> +    sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
>>>       mutex_unlock(&sii902x->mutex);
>>> @@ -309,14 +311,11 @@ static int sii902x_get_modes(struct 
>>> drm_connector *connector)
>>>       int num = 0;
>>>       drm_edid = sii902x_edid_read(sii902x, connector);
>>> -    drm_edid_connector_update(connector, drm_edid);
>>>       if (drm_edid) {
>>>           num = drm_edid_connector_add_modes(connector);
>>>           drm_edid_free(drm_edid);
>>>       }
>>
>> The EDID read / free can also be dropped, they don't serve any purpose
>> now.
>>
> 
> Sorry I did not understand this clearly.
> I have already removed drm_edid_connector_update from sii902x_get_modes 
> since now it is taken care inside sii902x_edid_read itself which is also 
> called by .get_modes (sii902x_get_modes).
> 
> We still need to read edid inside sii902x_get_modes as for the legacy 
> driver scenario which don't use DRM_BRIDGE_ATTACH_NO_CONNECTOR as in 
> those cases .get_modes will get called but bridge function .edid_read 
> won't be called. Also as the caller is supposed to free the edid 
> allocated so I have preserved drm_edid_free call in .get_modes as 
> drm_edid_connector_add_modes is allocating a new drm_edid pointer already.
> 
> Kindly let me know if there is a misunderstanding here.
> 

Just thought to check if we are good w.r.t above.
To summarize, as mentioned above, I think both sii902x_get_modes and 
sii902x_bridge_edid_read need to read edid. The former is called only 
for legacy driver scenario (and not for drivers using 
DRM_BRIDGE_ATTACH_NO_CONNECTOR) and the latter is called for the display 
drivers using DRM_BRIDGE_ATTACH_NO_CONNECTOR.

Regards
Devarsh

> Regards
> Devarsh
> 
>>> -    sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
>>> -
>>>       return num;
>>>   }
>>> -- 
>>> 2.39.1
>>>
>>
> 


