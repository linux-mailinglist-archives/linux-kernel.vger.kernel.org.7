Return-Path: <linux-kernel+bounces-833787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C0BA3126
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B489625B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2362773F4;
	Fri, 26 Sep 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mMqryNHm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06C13FEE;
	Fri, 26 Sep 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877613; cv=none; b=Gb0k7CpkeQZGkNuSqf6kmxute0ksA2EsX07j7M61ydNLCNlbKNfyx1Kq5NrXRNLz+g/D/jFfEiVv91DjeDoIeZyLmQa6orXFI0o8k3ZiuFRtYJkRBGkpecKfIxZrpRtmbhbqTnu3QiSW6tE3bMldDK58tj9ck3PWUI4o00UISg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877613; c=relaxed/simple;
	bh=vb9/KMQMK9vPRNYSOUWnAzv5NYl3+m6W/pwDMMnurDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QxkA9uGiH5nNEfhCmPGaXDFt8rIePDChq6+OYmgL926f1eQj8dxFHuUs4vppdN/D0MXwBM5PpzUaI84Qqdu8mhEJnLskeaZnRZYo4Gc2r1TzDxRcYAsek59fWDvC3kU6SoPah/nuUHyD/lQ8IekW4oFIpr7R/kXhl6a6h18PW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mMqryNHm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58Q96fuv2084388;
	Fri, 26 Sep 2025 04:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758877601;
	bh=6cxJXuy5YAwCi5okbverUIXNVXJCYm87JyZOCueDzZ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mMqryNHmKZSJR0q8EZjoCzMfc5R8znB83BnE7XY0CiRn++N8yErNPcISeQrQu4EII
	 nT7AiyoDB1WS0mVrl3aO1DOfrH1RANJ3NOS7yQaasPOs1zAviEea9OZOuvb9XHivSu
	 2YaVLDq9FHl940g7ylIP7GSsWbUzlHekp7SLFkDs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58Q96fAq3873698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 26 Sep 2025 04:06:41 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 26
 Sep 2025 04:06:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Sep 2025 04:06:41 -0500
Received: from [172.24.233.150] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58Q96bOT777945;
	Fri, 26 Sep 2025 04:06:38 -0500
Message-ID: <9653740a-44fe-46bb-92c8-f7fc26cbe5ee@ti.com>
Date: Fri, 26 Sep 2025 14:36:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: counter: Add new ti,omap-dmtimer-cap
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <wbg@kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <20250909080042.36127-1-g-praveen@ti.com>
 <20250909080042.36127-2-g-praveen@ti.com>
 <6faff5b1-65b1-41ee-aba8-8c06a2bc6f58@kernel.org>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <6faff5b1-65b1-41ee-aba8-8c06a2bc6f58@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

Really sorry and apologies for the delay.

On 10/09/25 12:38, Krzysztof Kozlowski wrote:
> On 09/09/2025 10:00, Gokul Praveen wrote:
>> This commit adds a YAML binding for OMAP DM timer used in
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> 
> Don't use "YAML binding" - there is no such thing.
> 
> Instead just describe the hardware.
> 

Sure Krzysztof.

>> capture operating mode.
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>>   .../bindings/counter/ti,omap-dmtimer-cap.yaml | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml b/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
>> new file mode 100644
>> index 000000000000..8de9cf58aee5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/counter/ti,omap-dmtimer-cap.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/counter/ti,omap-dmtimer-cap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI dual mode timer Capture Module
>> +
>> +maintainers:
>> +  - Gokul Praveen <g-praveen@ti.com>
>> +
>> +description:
>> +  TI dual mode timer instances have an IO pin for Capture capability.
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,omap-dmtimer-cap
> 
> Missing SoC specific part. OMAP is family, no?
> 
>> +
>> +  ti,timers:
>> +    description: Timer instance phandle for the Capture
> 
> So the only resource is phandle? That's completely fake device then. NAK.
> 


The OMAP Timer IP can operate in 3 modes: Timer, PWM mode or capture
(mutually exclusive).
The timer/ti,timer-dm.yaml file describes the timer mode of operation.
It encapsulates base IP block and reg property is also part the same
binding.

This node represents the capture mode with phandle reference to the
timer DT node. This is modeled all the same lines as how PWM
functionality is implemented in pwm/ti,omap-dmtimer-pwm.yaml

Now, if this needs to change, please suggest alternate.

One solution is perhaps to add a new property to ti,timer-dm.yaml itself
to indicate the mode of IP?


>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +required:
>> +  - compatible
>> +  - ti,timers
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    main_cap10: dmtimer-main-cap-10 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
> 

Sure, I will update that Krzysztof.

Regards
Gokul

> Best regards,
> Krzysztof


