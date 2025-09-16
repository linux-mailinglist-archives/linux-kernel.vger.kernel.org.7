Return-Path: <linux-kernel+bounces-819267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBAEB59DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FFB7B7426
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B352F260F;
	Tue, 16 Sep 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RQjQ1r9p"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FF2F25F8;
	Tue, 16 Sep 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040317; cv=none; b=CU1Jg+vhSx/H8oi7TYdJg2w5qFjbuZ+EugDuIZZHMsHQKOnHM2DuJH3qDnRh2H/Gc5J+HXpUHSAk609/9RgV2Veed++7pNwxFsnr5RlhTpMiSIfdiIepOO7nvBDxHl3w5rcoj17n+TclAFzdWtgD01pl7QIEgNjP8npIOV5bW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040317; c=relaxed/simple;
	bh=UkgDQw75WYXJjxzsWkhyF4zMxd/CFHN8RU/ii/r9QIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nmEXF5NPBGN1K0C8SzyeFdtbIeuOZ4exNH+GiSXB3z2ao0lR4q3CkBEfDuaZNijCYzt0IPN6Rtm6qaanD1sxBHfrYYnzrzLe8dQH/U1AyhNBgzt64SRhxkoic/Fd6JBf9q1wBhobIOJA4t8EgcMab1+sRZJZMDbZ/5EvjAwa4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RQjQ1r9p; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GGVdia054473;
	Tue, 16 Sep 2025 11:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758040300;
	bh=itxuQcHMsO2sCC/s11nHQCOTF7hajHe73/POeriiI4w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RQjQ1r9p8EcA1WSa7oi4/rwWPRasiLs1yiDk5u+TvYz8WYSxvfAbR/6MP0g5CNtaJ
	 cEJOvcA6HiG2Zz1++i9b3fma+Nx+kII8HTaiogfZsXIH1kkcvmJV61A+QfNY7uHphE
	 /RayxG1w7DFNk0PHtJmbKLIkmuK28mN6fp6rK9yY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GGVdwQ1664678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 11:31:39 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 11:31:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 11:31:39 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GGVc3F1900098;
	Tue, 16 Sep 2025 11:31:39 -0500
Message-ID: <5b793fa1-e075-4a14-a28d-7aaf0d5b1619@ti.com>
Date: Tue, 16 Sep 2025 11:31:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: nvmem: Introduce nvmem efuse binding for
 TI K3 SoCs
To: Judith Mendez <jm@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan
 Brattlof <bb@ti.com>
References: <20250916154809.545283-1-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250916154809.545283-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

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

As the name suggests, this old fix-layout is deprecated, you
should look at using the newer NVMEM layouts style for this node.

> +
> +properties:
> +  compatible:
> +    - const: ti,am62p-efuse

You mention in the commit message, there are a couple efuse regions
in the AM62P SoC, so does this apply generally to all of them, or
should you have this be specific to the "gp-sw" efuse region you
are describing here?

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

The efuse region at 0x43000230 is 96bits, so this should be 0xc not 0x4 size.

Andrew

> +    };
> +
> +...


