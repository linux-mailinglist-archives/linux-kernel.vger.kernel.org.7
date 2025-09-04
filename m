Return-Path: <linux-kernel+bounces-800280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D0B435C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6011171830
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D42C1584;
	Thu,  4 Sep 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v/WVw/iO"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DA2BE65B;
	Thu,  4 Sep 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974557; cv=none; b=CU+GyFjfSSVUNHwJ6tE4JaaPcXdOxnmBJv6u7eT3D+/FkpWP9iVYwesSVNpbFCdTVAagW8P4Zt8wMPddBkILEcFbQIUsOGl0MBoFB2gK14aQun0vG1g5/RcRUCIcqfUbvDLaHVnB2sYmhPB6VvNbMzDMX8Qj+J83e5PlW63J9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974557; c=relaxed/simple;
	bh=K/C/FMXuK3BEXBApw3jmqeD6Ss+41hjKkQl4z5Hq6t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cM3rgn+Mo/W2s5lOIyhz4s7he5O+qIjGWkQqPkys25zbLu+e0YAo745a0mAI/1l3SQxs893e1gXs7C7dM+Azh1QvmA54kxHl9xRMl9FJzyEMZGLcBWATb1UPOegkFvFOsO4cBN0BqzEAIRIZtkVoCXhdolu1W1r2FCvNP1PvC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v/WVw/iO; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5848Svw03428666;
	Thu, 4 Sep 2025 03:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756974537;
	bh=gy2Gy45lLeX0odcLNygy1AOk1VBFVVsVlHH30uMOI0s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=v/WVw/iOLP2UqlOHgpfiCa7l/vlFONunik/NLl5tjpdQ1vgR8axlREGW2c6OtxJyr
	 Iwy6bZ8zYOmZlD+Hfn4eVzTHHhDz1gbryBSfpeRuHdDb4wjy1fZkroE3toAkAFtHII
	 OJ1cO6ZvSPc8TiWz6p0nMybEJtATNKMaypdWJL9U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5848Svsc039314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 03:28:57 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 03:28:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 03:28:56 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5848SoWi2680491;
	Thu, 4 Sep 2025 03:28:50 -0500
Message-ID: <ee992556-6c90-4ad0-b3a1-1ddd9a232923@ti.com>
Date: Thu, 4 Sep 2025 13:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
To: Rob Herring <robh@kernel.org>, Harikrishna Shenoy <h-shenoy@ti.com>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <s-jain1@ti.com>
References: <20250903111357.2605199-1-h-shenoy@ti.com>
 <20250903220312.GA2903503-robh@kernel.org>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250903220312.GA2903503-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hari,

On 04/09/25 03:33, Rob Herring wrote:
> On Wed, Sep 03, 2025 at 04:43:57PM +0530, Harikrishna Shenoy wrote:
>> From: Swapnil Jakhade <sjakhade@cadence.com>
>>
>> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
>> DPI/DP bridge.
>>
>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> ---
>>   .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> index c2b369456e4e..6e749c002669 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> @@ -27,6 +27,8 @@ properties:
>>             Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
>>         - description:
>>             Register block of mhdptx sapb registers.
>> +      - description:
>> +          Register block for mhdptx DSC encoder registers.
>>   
>>     reg-names:
>>       minItems: 1
>> @@ -34,6 +36,7 @@ properties:
>>         - const: mhdptx
>>         - const: j721e-intg
>>         - const: mhdptx-sapb
>> +      - const: mhdptx-dsc
> 
> 'mhdptx' is redundant. Don't continue that pattern. Just 'dsc'.
> 
>>   
>>     clocks:
>>       maxItems: 1
>> @@ -100,18 +103,18 @@ allOf:
>>         properties:
>>           reg:
>>             minItems: 2
>> -          maxItems: 3
>> +          maxItems: 4
>>           reg-names:
>>             minItems: 2
>> -          maxItems: 3
>> +          maxItems: 4
>>       else:
>>         properties:
>>           reg:
>>             minItems: 1
>> -          maxItems: 2
>> +          maxItems: 3
>>           reg-names:
>>             minItems: 1
>> -          maxItems: 2
>> +          maxItems: 3
> 
> Have you tested this works? While it might work for TI with the
> j721e-intg registers in the middle, it won't work for platforms without
> them. You're going to have to have 2 lists of reg-names.
> 

Yes, as discussed offline you probably need an if else for reg blocks 
too here i.e. one for generic cadence compatible which would have 
cadence specific blocks common for all SoCs and other for j721e specific 
compatible which would have j721e specific reg blocks.

Regards
Devarsh

> Rob
> 


