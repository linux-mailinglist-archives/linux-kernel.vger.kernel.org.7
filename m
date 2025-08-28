Return-Path: <linux-kernel+bounces-790294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF2B3A47B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C61C8436A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FE23BF8F;
	Thu, 28 Aug 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5PBWCHvR"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6923ABBD;
	Thu, 28 Aug 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395049; cv=none; b=clhBAE7tV6dDEoTmnvCoYDu1wpPBPrIXuj161LWO3zlEws1C9S7V65SkMDRTjQ1AakUeSncghyaGLUeQumKMCi9Q75u951joEM6PS95rrIFS4ASZlQigQlOdjgJkTDIOWnOv1xkMvSs/m4POFtDP/OhF3EjT6L8Hz3SbSx0zCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395049; c=relaxed/simple;
	bh=zcXQWGxBgys/9bCjZkggZ71XZareYPTP7nhInFsdrhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f0L4DOM0sJBihhuFObsun+oXqGBWtnABhbwX9QA7KCzm/Pa7w+m7qyE7EsywCb9UzT+8hjO0k/6FOG8mbBTD4vJbKcc7RYwJ8Jgvq/2/z0OIs2Ynws9MHm3qZUj9eLKy6Lx9hin+iO41VgS9XbCZrwdt7dqut7b+U7EP+3x/uKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5PBWCHvR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SExhLc008165;
	Thu, 28 Aug 2025 17:30:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zcXQWGxBgys/9bCjZkggZ71XZareYPTP7nhInFsdrhI=; b=5PBWCHvR6BAKt5q+
	lSmK889rAu3TIDu9s/WZRuzmFV+Gg4W9dRRNh+dFL48D7OL1yQ9uItfsuYCCJXry
	vrCcbsqiVzolyGi9uQi7s67eFaWbOOdKpJqkM7vgmUybN1UI7yDHhkhF8hBSqVw1
	ZgmYXjB5wAQvrOjAnMXARAz3Pk1TFOm5IrFB2zSdjWwaHG/15BXsiJwUtw4hLUbD
	67O0xdpCSrc5deU6c+j0cJRrSUYpmQH2/Z/EHQNN/ZYcDmVo9q3kUGx2ZMLZ+usy
	MFhMEbct9nuPWN4qe5QQ/dYEEtaJqj/LbB0qNKG+pNcbnPblkvAzwJq9lYwzk1er
	ZBozVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qrkmtyc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:30:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D4EB940048;
	Thu, 28 Aug 2025 17:29:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DB7976B31E;
	Thu, 28 Aug 2025 17:28:05 +0200 (CEST)
Received: from [10.252.2.182] (10.252.2.182) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 17:28:03 +0200
Message-ID: <ee447d45-a7af-4af4-ba6c-5341b8428db3@foss.st.com>
Date: Thu, 28 Aug 2025 17:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] dt-bindings: arm: stm32: add required
 #clock-cells property
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
 <20250822-drm-misc-next-v5-6-9c825e28f733@foss.st.com>
 <4201bb6b-3ad8-4b35-b152-0d725310245b@foss.st.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <4201bb6b-3ad8-4b35-b152-0d725310245b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/28/25 17:18, Christophe ROULLIER wrote:
> On 8/22/25 16:34, Raphael Gallais-Pou wrote:
>> On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
>> subsystem through a multiplexer.  Since it only provides a single clock,
>> the cell value is 0.
>>
>> Doing so allows the clock consumers to reach the peripheral and gate the
>> clock accordingly.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>   .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> index
>> ed97652c84922813e94b1818c07fe8714891c089..95d2319afe235fa86974d80f89c9deeae2275232
>> 100644
>> --- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> @@ -36,20 +36,31 @@ properties:
>>     clocks:
>>       maxItems: 1
>>   +  "#clock-cells":
>> +    const: 0
>> +
>>   required:
>>     - compatible
>>     - reg
>>   -if:
>> -  properties:
>> -    compatible:
>> -      contains:
>> -        enum:
>> -          - st,stm32mp157-syscfg
>> -          - st,stm32f4-gcan
>> -then:
>> -  required:
>> -    - clocks
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - st,stm32mp157-syscfg
>> +              - st,stm32f4-gcan
>> +    then:
>> +      required:
>> +        - clocks
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          const: st,stm32mp25-syscfg
>> +    then:
>> +      required:
>> +        - "#clock-cells"
>>     additionalProperties: false
>>  
> Acked-by: Christophe Roullier <christophe.roullier@foss.st.com>
>
> You can merge it on DRM MISC.

Thanks Christophe ! :)

Best regards,
Raphaël
>
> Best Regards,
>   Christophe
>


