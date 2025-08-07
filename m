Return-Path: <linux-kernel+bounces-759320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E119B1DC06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9CC626948
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04678271478;
	Thu,  7 Aug 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A6Z4M6hf"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA846186A;
	Thu,  7 Aug 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585739; cv=none; b=ZW9/AkQ4XW8nQB4DOZQ2DDboL82W26Jpy73Z4X8YT7vcL9Sh/chUlNeZGBHr+HKnIjJluYcP/iYX3yaC+tSMKmrb6vu3yqfTOq+C1A0ZbAXtnK7MSJrO+3IqGD+BdVIl0ClG0j5lC9doYZYqgF7lssFMdaWL01tDZJs6ozQXxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585739; c=relaxed/simple;
	bh=LHMSEcsoebGC9EJHozewBHkA4UA9nKXrl/+pyd3FhuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePI8xn1VEdhCgZddym7jodPzIGCjefdWvS46MpmqCmPWTHhTqZeEKAjcPqgPqujiRKcqaZ7pBo2qx3pGrTTl7oHAxYOf8NnY9RM000gnxfMh5isYI5eI1PosBV/aQJGTv0G+O7ZIp2ssdmMG5FmoTN9T5Xa8KJCEqH/yuwmdXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A6Z4M6hf; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577GtLoJ357219;
	Thu, 7 Aug 2025 11:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754585721;
	bh=fyNnhg4lijQ4v6QmS/629cAiN3798tTQNEz0d9moVMM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=A6Z4M6hfPXyzEe4lh33jMZO/WciwcaV+08K8yxl+sTcpX6ifTttw2h7sDsQ/6KnIx
	 85/RDY7/hU/aRLN/OQ0caPkKbVwQ7xygnWWwWRlpncmTwImKs4Dg6S6sS5YDAq2G0x
	 7H7lLHvQwYkktfLCKiA/7NZ+DdHf7FcckOB3gNFM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577GtLTB947670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 11:55:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 11:55:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 11:55:20 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577GtKo61672369;
	Thu, 7 Aug 2025 11:55:20 -0500
Message-ID: <fca8e682-9db6-4726-95e9-db437042e98e@ti.com>
Date: Thu, 7 Aug 2025 11:55:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: Convert ti,keystone to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250806212824.1635084-1-robh@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250806212824.1635084-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/6/25 4:28 PM, Rob Herring (Arm) wrote:
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   .../bindings/arm/keystone/keystone.txt        | 42 -------------------
>   .../bindings/arm/ti/ti,keystone.yaml          | 42 +++++++++++++++++++
>   2 files changed, 42 insertions(+), 42 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
> deleted file mode 100644
> index f310bad04483..000000000000
> --- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -TI Keystone Platforms Device Tree Bindings
> ------------------------------------------------
> -
> -Boards with Keystone2 based devices (TCI66xxK2H) SOC shall have the
> -following properties.
> -
> -Required properties:
> - - compatible: All TI specific devices present in Keystone SOC should be in
> -   the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
> -   type UART should use the specified compatible for those devices.
> -
> -SoC families:
> -
> -- Keystone 2 generic SoC:
> -   compatible = "ti,keystone"
> -
> -SoCs:
> -
> -- Keystone 2 Hawking/Kepler
> -   compatible = "ti,k2hk", "ti,keystone"
> -- Keystone 2 Lamarr
> -   compatible = "ti,k2l", "ti,keystone"
> -- Keystone 2 Edison
> -   compatible = "ti,k2e", "ti,keystone"
> -- K2G
> -   compatible = "ti,k2g", "ti,keystone"
> -
> -Boards:
> --  Keystone 2 Hawking/Kepler EVM
> -   compatible = "ti,k2hk-evm", "ti,k2hk", "ti,keystone"
> -
> --  Keystone 2 Lamarr EVM
> -   compatible = "ti,k2l-evm", "ti, k2l", "ti,keystone"
> -
> --  Keystone 2 Edison EVM
> -   compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone"
> -
> --  K2G EVM
> -   compatible = "ti,k2g-evm", "ti,k2g", "ti-keystone"
> -
> --  K2G Industrial Communication Engine EVM
> -   compatible = "ti,k2g-ice", "ti,k2g", "ti-keystone"
> diff --git a/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml b/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
> new file mode 100644
> index 000000000000..20d4084f4506
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ti/ti,keystone.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Keystone Platforms
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +  - Santosh Shilimkar <ssantosh@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: K2G
> +        items:
> +          - enum:
> +              - ti,k2g-evm
> +              - ti,k2g-ice
> +          - const: ti,k2g
> +          - const: ti,keystone
> +      - description: Keystone 2 Edison
> +        items:
> +          - enum:
> +              - ti,k2e-evm
> +          - const: ti,k2e
> +          - const: ti,keystone
> +      - description: Keystone 2 Lamarr
> +        items:
> +          - enum:
> +              - ti,k2l-evm
> +          - const: ti,k2l
> +          - const: ti,keystone
> +      - description: Keystone 2 Hawking/Kepler
> +        items:
> +          - enum:
> +              - ti,k2hk-evm
> +          - const: ti,k2hk
> +          - const: ti,keystone
> +
> +additionalProperties: true


