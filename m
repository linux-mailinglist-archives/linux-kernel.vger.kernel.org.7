Return-Path: <linux-kernel+bounces-823216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7CB85D23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E33217C2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACBC30FC1C;
	Thu, 18 Sep 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="htEDTDbY"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C94155A25;
	Thu, 18 Sep 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210709; cv=none; b=kK053bKnufmmfhnFeGgWfb31gUag9sDrXsW4Kn9J9ocBFCTkki+lhwzexgMlamVR0apb/nWf1nZ1ztNrqHjSn735v8YnDAjMIpIVwKuHxshnopzpbUolHptLpxNFl/dTxAz/nhtK0WBv/bxnLd87jydWUff0X/4StyIpe7SGj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210709; c=relaxed/simple;
	bh=G83wKThPq3CeUhKXfOkXQ5E51eysUy6f1Li89e+KT7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UP53e1UPShM178JoFF1XH4JbZMrq7C/u5napGtTynq3kDle63VlRlJ7S+ZFddwQ9SwjAbiKlxbJqOuIknNDyacR8SWYDppYRr6Ey55ncvesHOupO4TYfHdsD4N7wgaTpHx7t6IQZeOSLuCxI4QTsfSikXA2r1mGzRfHr8UxabeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=htEDTDbY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58IFpViB520570;
	Thu, 18 Sep 2025 10:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758210691;
	bh=DaW2y8M1Hp4LhE2yjH46X5/LPaGnP2rYdbOHU8P9gRE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=htEDTDbYv06gEr46TsdcjIUDl5I399zAiz5sY0EPcbbp2+ihXzh7Mm0WucU+MR9wM
	 eLmRAtDgW7gr6iVgR1A41j0J2y2YkRJWW8JicsUvsxa5Ytm1Q3XPkOMQySi+7wugnf
	 8G5AABzIcN/vbU1RpFStonNeN8Mk/Mjk0g425x9k=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58IFpVUd2219323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 18 Sep 2025 10:51:31 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 10:51:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 10:51:31 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58IFpVdM1115868;
	Thu, 18 Sep 2025 10:51:31 -0500
Message-ID: <a521de5c-4811-4ea0-bc78-3b69467591d9@ti.com>
Date: Thu, 18 Sep 2025 10:51:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: nvmem: Introduce nvmem efuse binding for
 TI K3 SoCs
To: Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan
 Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
        Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20250916154809.545283-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250916154809.545283-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 9/16/25 10:48 AM, Judith Mendez wrote:
> On K3 SoCs there are efuse registers scattered across the memory
> map. In order to reference these efuse registers like gp-sw which
> may store SW REV information or other general purpose information
> for drivers to consume, treat them appropriately as efuse devices
> with nvmem framework.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> This patch is not complete and is sent as an RFC to get some initial
> thoughts on this implementation to solve [0].
> 
> [0] https://lore.kernel.org/linux-mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org
> ---
>   .../devicetree/bindings/nvmem/ti,efuses.yaml  | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
> new file mode 100644
> index 0000000000000..fffca65cdbfe0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/ti,efuses.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI SoC eFuse-based NVMEM
> +
> +maintainers:
> +  - Judith Mendez <jm@ti.com>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +  - $ref: nvmem-deprecated-cells.yaml#
> +
> +properties:
> +  compatible:
> +    - const: ti,am62p-efuse
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse@43000230 {
> +        compatible = "ti,am62p-efuse";
> +        reg = <0x43000230 0x4>;
> +    };
> +
> +...

Ignoring the errors for now, do you think this could be a good solution
to solve [0]?

[0] 
https://lore.kernel.org/linux-mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org


regards,

~ Judith



