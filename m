Return-Path: <linux-kernel+bounces-809689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABBDB510E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77A4463B16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823730FF06;
	Wed, 10 Sep 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CX1/coYv"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1962989B0;
	Wed, 10 Sep 2025 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491729; cv=none; b=nK3nVgAMdmmb3JAvOw6KNrJS+a16e31uyBbxu7DlY1HmXo0rg0yB1fy3w6m3xao6yeYb3mGSFsvgCOFvfMf1TkPANzup7UuKN0oXS/c1vzFn1BrmKY2wp5dfcSmcTaP6rDSmcgAQejPbmJs+jEzwFK7hjXg8jNevwjmtNOnKrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491729; c=relaxed/simple;
	bh=hKmT9I0iFjACYnLmxYQLMOutlSipq6SF9dblKH9+7sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WrPAWO/c1L0Jwlae3n3jdi1ECpooNyPgzUyFkdch5whJO6baao5LjMTM2fHibcxPy5DWO/mweXMcGMkQ3UUbCrtW2hYNLYlmmUf2jjta5GZKeur8HxxWQ1Ex9cJ+nkWvTlfBkbTZP3hU/NPC6ilbf9XbOpCiVTnzTGELeUpCMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CX1/coYv; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A88LvL095414;
	Wed, 10 Sep 2025 03:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757491702;
	bh=ISe2QleZokgkYclvuW677FsPG22emPPyU0CtFKxyG/I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CX1/coYvASgXaFrtPzzVUj3SLn/KBnUykHzIEw3PLeChZhoKMSyHvAU3N4cu25SC3
	 xZPpFLo3ZQ5V6/Z3qH/aRMN1r5RgLNY0aZbUQKcrJ5pTrEpAUujSLPhMTTLjr3fjvX
	 eqWo6DJlVh4babVK9Sd8Aw0Zcsea9Qa8HCFaPCLE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A88Lsa3773653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 03:08:21 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 03:08:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 03:08:20 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A88DcL171472;
	Wed, 10 Sep 2025 03:08:14 -0500
Message-ID: <a04ded27-a3b2-4290-9084-70d302f77381@ti.com>
Date: Wed, 10 Sep 2025 13:38:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: drm/bridge: MHDP8546 bridge binding
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
References: <20250909054622.1439487-1-h-shenoy@ti.com>
 <20250910023608.GA3662482-robh@kernel.org>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <20250910023608.GA3662482-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/10/25 08:06, Rob Herring wrote:
> On Tue, Sep 09, 2025 at 11:16:22AM +0530, Harikrishna Shenoy wrote:
>> From: Swapnil Jakhade <sjakhade@cadence.com>
>>
>> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
>> DPI/DP bridge.
>>
>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> ---
>> Changelog v3 -> v4:
>> -Remove maxItems as item list is mentioned for reg-names, resolves
>> dt_bindings_check warning.
>> Log link- <https://gist.github.com/h-shenoy/5391ea514bb58a6cba3f39248d20916b>
>> Link to v3- https://lore.kernel.org/all/20250908054609.1113360-1-h-shenoy@ti.com/
>>
>>   .../bindings/display/bridge/cdns,mhdp8546.yaml | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> index c2b369456e4e..b40630de6d89 100644
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
>> +      - const: dsc
>>   
>>     clocks:
>>       maxItems: 1
>> @@ -100,18 +103,25 @@ allOf:
>>         properties:
>>           reg:
>>             minItems: 2
>> -          maxItems: 3
>> +          maxItems: 4
>>           reg-names:
>>             minItems: 2
>> -          maxItems: 3
>> +          items:
>> +            - const: mhdptx
>> +            - const: j721e-intg
>> +            - const: mhdptx-sapb
>> +            - const: dsc
>>       else:
>>         properties:
>>           reg:
>>             minItems: 1
>> -          maxItems: 2
>> +          maxItems: 3
>>           reg-names:
>>             minItems: 1
>> -          maxItems: 2
>> +          items:
>> +            - const: mhdptx
>> +            - const: mhdptx-sapb
>> +            - const: dsc
> Still obviously not tested with a DT having this. Because this
> contradicts the top-level schema. Both cannot be true.
>
> Rob
Will update and test with the other compatible on some dummy dt and 
share logs

