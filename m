Return-Path: <linux-kernel+bounces-819593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB50B5A381
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51C81BC3B63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB5285069;
	Tue, 16 Sep 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Njz6mWDc"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEF31BC89;
	Tue, 16 Sep 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056258; cv=none; b=AH2mWy37nV73aEJD7nvVfqiVwZVK+OBu+hX+GKfKSvMUSUwRB1RDPG7P+bOGRHlgBMn672HsSSgEJopF40x6WAg7jkYVlzNT31rYpFjLW5bOG0CNgTOccOEeMCVSdSpnRU94872nAaoCSdfAi++RF53TcSm/Ez7A9cXfhskuE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056258; c=relaxed/simple;
	bh=GNntTJeDbkB1LJQxeNsIY9NZ3Bms5eH7F2iMfEDMsbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E/cmRtTJMswLAlKOiULFt5ZBK+G49GJQfi7+P7QDFo/djZuCc3jGB6pg6aa95XyR5302JudS1LAQcAmaAvk28BC9wA9FhYfBa95tcxq0BA2gECKiBGxCJOjdoB8RUspDA/Ija5Ni2jz7MTysnSbVFVwK6WjFrqp+wDOrZxAwiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Njz6mWDc; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GKvVB31356259;
	Tue, 16 Sep 2025 15:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758056251;
	bh=JOKZIPu742YrIyVjpGt0KD1fljibV+3sCbTDvXdQGkM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Njz6mWDcYe/sTNK1WlTFwR2LifObNgsCY4F2iqk5jINXfF/das5n51DgGBeOg37Cb
	 sNkerl52NUabLt+k3ncwPnNc23FEMW4j5dq2WLnt+Hl2WMMAF+Y3Ik/bcvmhwwu3uT
	 kmmjP2Rtmfd6GNq880k2EnrQEkbXpS4Q9jKSBWRE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GKvVoZ1803070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 15:57:31 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 15:57:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 15:57:31 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GKvVKc1903904;
	Tue, 16 Sep 2025 15:57:31 -0500
Message-ID: <7aafd8bd-4710-45e8-ad54-4d8b44de2b25@ti.com>
Date: Tue, 16 Sep 2025 15:57:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: nvmem: Introduce nvmem efuse binding for
 TI K3 SoCs
To: Andrew Davis <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan
 Brattlof <bb@ti.com>
References: <20250916154809.545283-1-jm@ti.com>
 <5b793fa1-e075-4a14-a28d-7aaf0d5b1619@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5b793fa1-e075-4a14-a28d-7aaf0d5b1619@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 9/16/25 11:31 AM, Andrew Davis wrote:
> On 9/16/25 10:48 AM, Judith Mendez wrote:
>> On K3 SoCs there are efuse registers scattered across the memory
>> map. In order to reference these efuse registers like gp-sw which
>> may store SW REV information or other general purpose information
>> for drivers to consume, treat them appropriately as efuse devices
>> with nvmem framework.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> This patch is not complete and is sent as an RFC to get some initial
>> thoughts on this implementation to solve [0].
>>
>> [0] https://lore.kernel.org/linux- 
>> mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org
>> ---
>>   .../devicetree/bindings/nvmem/ti,efuses.yaml  | 36 +++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/ 
>> ti,efuses.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml b/ 
>> Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
>> new file mode 100644
>> index 0000000000000..fffca65cdbfe0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/ti,efuses.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI SoC eFuse-based NVMEM
>> +
>> +maintainers:
>> +  - Judith Mendez <jm@ti.com>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
>> +  - $ref: nvmem-deprecated-cells.yaml#
> 
> As the name suggests, this old fix-layout is deprecated, you
> should look at using the newer NVMEM layouts style for this node.

Fair point, this can be fixed.

> 
>> +
>> +properties:
>> +  compatible:
>> +    - const: ti,am62p-efuse
> 
> You mention in the commit message, there are a couple efuse regions
> in the AM62P SoC, so does this apply generally to all of them, or
> should you have this be specific to the "gp-sw" efuse region you
> are describing here?

I think it is better if this can be more generic, so not only should
it apply to gp-sw, gp-sw is only one example register we could treat
as efuse register.

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    efuse@43000230 {
>> +        compatible = "ti,am62p-efuse";
>> +        reg = <0x43000230 0x4>;
> 
> The efuse region at 0x43000230 is 96bits, so this should be 0xc not 0x4 
> size.

oop, this will be fixed, thanks.

~ Judith


