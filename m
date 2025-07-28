Return-Path: <linux-kernel+bounces-747850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A5B13919
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DAE174F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1069255F25;
	Mon, 28 Jul 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3duh5Aot"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE3253B64;
	Mon, 28 Jul 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699157; cv=none; b=gXtoNj2/ormw9mg/iQhODTLy+S26AJ27o0FUfsjESnsUULXu+LPMvaGE+4DCLFO48LZxNn+k9ORPHTASuhA/0ybobBBDgbt1x8oRJsS+FkEpRvFhb90wEe1SDVmiwdTMWCRyCzShN+5MFA4zyX3q3GAPX61Jyi/0ZBNVhcydIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699157; c=relaxed/simple;
	bh=1yh6pdK6bVBK4wrJs6adzYsvooYlrU9tcjyQQSp2Fd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dtMylWAbkG8rXrQxsFAE1Kw1u8d9tPM2+GmXgJmypu/9idVRgOK/pE6p18aC+RqRsIIaM8jWgM/DxAvG9Z+lTwEBaFs3v+1NwAem42MZGuCmNSGQii04+thB6QZi6pg9TSDHBrV9Fz6SkL5X0daypIfUJaYE+QWzk2R0B5Fg7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3duh5Aot; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAK6Pk031811;
	Mon, 28 Jul 2025 12:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2TRBNRU0aazEaz412aN0yClz+07/RSAtN1hf3sqcbTY=; b=3duh5Aotax1L6S6u
	3Wfer4PGVcgXjO92s+e7kzK5anxAOga19rCv/l6vuBIvnnaHiWdWQR8La38yiVqY
	oX2PooxgymVguBVZ3ZTrg9+bPNmJNeVn6frG+gj3Uo1QBLNOG1mM7ZYZ0tTuc+Ba
	1Vp8TxeYiWzwSR5eNJIi7XnIp74HBDzr9bgBLmgQdCz7N0WVXrS5QZF4r4HUj7oB
	9l9oCHDf0v0E6onuymUAmSy06IKGdqvwcbdoZSmTbZmRibUmGIhENqidnl5Gkc6i
	OmEHzWNlh+Vg8iAYv04BiCvCvm1m+voNydrK4q8gqmY2uRo4WqzMfJjjPH0fyxKf
	3vaWNA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc27rr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 12:38:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B67FC4002D;
	Mon, 28 Jul 2025 12:37:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CFD6769726;
	Mon, 28 Jul 2025 12:36:04 +0200 (CEST)
Received: from [10.252.20.157] (10.252.20.157) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 12:36:03 +0200
Message-ID: <58bcd0dc-9df0-461c-8e11-5e892bee2f34@foss.st.com>
Date: Mon, 28 Jul 2025 12:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: display: st: add new compatible to
 LTDC device
To: Rob Herring <robh@kernel.org>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-1-a59848e62cf9@foss.st.com>
 <20250725194936.GA1731993-robh@kernel.org>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250725194936.GA1731993-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01



On 7/25/25 21:49, Rob Herring wrote:
> On Fri, Jul 25, 2025 at 12:03:53PM +0200, Raphael Gallais-Pou wrote:
>> The new STMicroelectronics SoC features a display controller similar to
>> the one used in previous SoCs.  Because there is additional registers,
>> it is incompatible with existing IPs.
>>
>> Add the new name to the list of compatible string.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 37 +++++++++++++++++++---
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>> index d6ea4d62a2cfae26353c9f20a326a4329fed3a2f..546f57cb7a402b82e868aa05f874c65b8da19444 100644
>> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>> @@ -12,7 +12,9 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: st,stm32-ltdc
>> +    enum:
>> +      - st,stm32-ltdc
>> +      - st,stm32mp25-ltdc
>>  
>>    reg:
>>      maxItems: 1
>> @@ -24,11 +26,12 @@ properties:
>>      minItems: 1
>>  
>>    clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 4
>>  
>>    clock-names:
>> -    items:
>> -      - const: lcd
>> +    minItems: 1
>> +    maxItems: 4
>>  
>>    resets:
>>      maxItems: 1
>> @@ -51,6 +54,32 @@ required:
>>    - resets
>>    - port
>>  
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - st,stm32-ltdc
>> +then:
>> +  properties:
>> +    clocks:
>> +      maxItems: 1
>> +    clock-names:
>> +      maxItems: 1
>> +      items:
>> +        - const: lcd
>> +else:
>> +  properties:
>> +    clocks:
>> +      maxItems: 4
>> +    clock-names:
>> +      maxItems: 4
>> +      items:
>> +      - const: bus
>> +      - const: lcd
> Why can't 'lcd' be 1st so you aren't changing positions? Keep the items 
> list at the top level and just use minItems/maxItems in the if/then 
> schemas.
Hi Rob,

I've set the name order to match the stm32mp255.dtsi device-tree, so that it
does not confuse anybody regarding which clock goes with.

Your comment is taken into account for the upcoming version.

Thanks,
Raphaël
>
>> +      - const: ref
>> +      - const: lvds
>> +
>>  additionalProperties: false
>>  
>>  examples:
>>
>> -- 
>> 2.25.1
>>


