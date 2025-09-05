Return-Path: <linux-kernel+bounces-802564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A266B453DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76E5167B47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A3298CA4;
	Fri,  5 Sep 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GHcdqo+a"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A71D555;
	Fri,  5 Sep 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066275; cv=none; b=FJNjvdlRIoIDVYPfZHRd6zHS83/fhXqQTjY21oL+yRi01y3mpx/8bj/GNq5Ed/J8suOnPr19qBvjwOQFAVNLqvtuadrnF8cN3C1V4uw2CiUpmhAnd/9QZIKFtURsmt1/fhx5+D7vZ3UVFscqh0RHVgzl7AeoNO7CzvL6F46+zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066275; c=relaxed/simple;
	bh=4OHfgJRA6RlmsK9Y0nz8f7YVUkh+070Xnwmg5iVfQJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bbSnxV3aTbpk0XRegrsH2mSz+qHX2hRmNrApBcwhfqyfg2pxcUzv+F/xlJtiQLL985CMDmQ0UpMYOiSwUQ2e3loze62Oyymq/6fTyCZcVziU54MXLUANvVj/W/ytvrhIBzImgpD6XJcQVpepLOFnNZpiUHFonIFNG6Oec5OE3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GHcdqo+a; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5859vPdr3728318;
	Fri, 5 Sep 2025 04:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757066245;
	bh=jS0ZrR2l17DwC+yF7KoEi0rpPViblg/G7ns3YIthCs4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GHcdqo+aI6AmHcCDE+3BC8k1m0/2+elixBSCC1+tq3zF+MaaswShQg8PEcNJZ1d9q
	 yjQIulENuskEDDbCjPbAg0V8Mqh6ZS9Xta40vi09r5nfaX0QdeVAvWqWIjGwWpQQUB
	 uZt6ID8qKXSGB9PJTVSy35L93VubzYwzrMAwh0wc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5859vOad1561954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 04:57:24 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 04:57:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 04:57:23 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5859vHwl265232;
	Fri, 5 Sep 2025 04:57:18 -0500
Message-ID: <4bbaefae-1d10-461a-a7a2-61a052241028@ti.com>
Date: Fri, 5 Sep 2025 15:27:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
To: Rob Herring <robh@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>
References: <20250903111357.2605199-1-h-shenoy@ti.com>
 <20250903220312.GA2903503-robh@kernel.org>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <20250903220312.GA2903503-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/4/25 03:33, Rob Herring wrote:
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
> 'mhdptx' is redundant. Don't continue that pattern. Just 'dsc'.

so sequence should be mhdptx, j721e-intg, mhdptx-sapb, dsc?


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
> Have you tested this works? While it might work for TI with the
> j721e-intg registers in the middle, it won't work for platforms without
> them. You're going to have to have 2 lists of reg-names.
>
> Rob
>
I will add two lists one with and one without j721e-integ in the 'if' 
condtional

