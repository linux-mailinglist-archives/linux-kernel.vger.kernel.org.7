Return-Path: <linux-kernel+bounces-728316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F089B0267E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6EA1703AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF621A7AF7;
	Fri, 11 Jul 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecg1nzsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D81EFF8D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270196; cv=none; b=g4S3jKpHhlzo7DHGkow2y5lBGbWGw2UFA8ToZnd39pjCOI5lY3KYRxPA1RPenaohde0Bo9tU+GqjVYIo55X2dvk3ibak7PtIuI8a8Hn8F54QhW//EcoxfZ/eLy8w74ET1Un/m1LgSDLw4jTGQC7Hc6KiXhX9eZeVikWkWjBxh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270196; c=relaxed/simple;
	bh=2iGSv1shlQW/GDV5PkKrsfbLlImUxc27gjcBAIAsHRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuottwugnqY8AJpQc1BTw05GoPgZL/ZaP/YFwmdHj/B6/LNX/IMoP72EF21ZKC+B8gaVvF6w6Za3QP/QH3WEOAW1dP4eOMtOBAZ+rqVOvNn1t5wTTTureBqqGooDd9p+X2pZekVAjQfCUra1059fkBEVLf+V+MkRRQz6bJkD6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecg1nzsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF348C4CEED;
	Fri, 11 Jul 2025 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752270196;
	bh=2iGSv1shlQW/GDV5PkKrsfbLlImUxc27gjcBAIAsHRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ecg1nzsGNnELmIWOaKkmu8EL9wQQWtIlR5h0t8I7cOHOYRPgolkANBSwZY/ArX8fb
	 zbBsNer8f3cqIGY5GVf5l+tvpaAowo0kvwOTHS1KDQ2EMZaZ3c7700HAVeEYB0/+z/
	 PcojdDftByIlyx1bCSBKKIPOlSpBl60M+HB7ukmyRETE+Q0/u8Rg9CNLIopGxDu/m5
	 kT6qWquYUru3Gtk5IqRNlyjQJMmTWYBx71ItOagNVdiPDRpkptDAvVhcNfkqDQZ28l
	 o3LILzbLCGbUlDg8Tsoi0QNRxq4V2f3ia0br66XBKRCj3wtfGBHdb6sX7HChQCR/i1
	 Ns6cjTh4iNCig==
Date: Fri, 11 Jul 2025 16:43:14 -0500
From: Rob Herring <robh@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com, bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [RFC PATCH 11/36] dt-bindings: arm: Add MPAM MSC binding
Message-ID: <20250711214314.GA1376683-robh@kernel.org>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-12-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183648.30766-12-james.morse@arm.com>

On Fri, Jul 11, 2025 at 06:36:23PM +0000, James Morse wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The binding is designed around the assumption that an MSC will be a
> sub-block of something else such as a memory controller, cache controller,
> or IOMMU. However, it's certainly possible a design does not have that
> association or has a mixture of both, so the binding illustrates how we can
> support that with RIS child nodes.
> 
> A key part of MPAM is we need to know about all of the MSCs in the system
> before it can be enabled. This drives the need for the genericish
> 'arm,mpam-msc' compatible. Though we can't assume an MSC is accessible
> until a h/w specific driver potentially enables the h/w.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  .../devicetree/bindings/arm/arm,mpam-msc.yaml | 227 ++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml

Is there any DT based h/w using this? I'm not aware of any. I would 
prefer not merging this until there is. I have little insight whether 
these genericish compatibles will be sufficient, but I have lots of 
experience to say they won't be. I would also suspect that if anyone has 
started using this, they've just extended/modified it however they 
wanted and no feedback got to me.


> diff --git a/Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml b/Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml
> new file mode 100644
> index 000000000000..9d542ecb1a7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml
> @@ -0,0 +1,227 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,mpam-msc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm Memory System Resource Partitioning and Monitoring (MPAM)
> +
> +description: |
> +  The Arm MPAM specification can be found here:
> +
> +  https://developer.arm.com/documentation/ddi0598/latest
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: arm,mpam-msc                   # Further details are discoverable
> +      - const: arm,mpam-memory-controller-msc
> +
> +  reg:
> +    maxItems: 1
> +    description: A memory region containing registers as defined in the MPAM
> +      specification.
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: error (optional)
> +      - description: overflow (optional, only for monitoring)
> +
> +  interrupt-names:
> +    oneOf:
> +      - items:
> +          - enum: [ error, overflow ]
> +      - items:
> +          - const: error
> +          - const: overflow
> +
> +  arm,not-ready-us:
> +    description: The maximum time in microseconds for monitoring data to be
> +      accurate after a settings change. For more information, see the
> +      Not-Ready (NRDY) bit description in the MPAM specification.
> +
> +  numa-node-id: true # see NUMA binding
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^ris@[0-9a-f]$':
> +    type: object
> +    additionalProperties: false
> +    description: |

'|' can be dropped.

> +      RIS nodes for each RIS in an MSC. These nodes are required for each RIS
> +      implementing known MPAM controls
> +
> +    properties:
> +      compatible:
> +        enum:
> +            # Bulk storage for cache
> +          - arm,mpam-cache
> +            # Memory bandwidth
> +          - arm,mpam-memory
> +
> +      reg:
> +        minimum: 0
> +        maximum: 0xf
> +
> +      cpus:
> +        $ref: '/schemas/types.yaml#/definitions/phandle-array'

Don't need the type. It's in the core schemas now.

> +        description:
> +          Phandle(s) to the CPU node(s) this RIS belongs to. By default, the parent
> +          device's affinity is used.
> +
> +      arm,mpam-device:
> +        $ref: '/schemas/types.yaml#/definitions/phandle'

Don't need quotes. This should be a warning, but no testing happened 
because the DT list and maintainers weren't CCed.

> +        description:
> +          By default, the MPAM enabled device associated with a RIS is the MSC's
> +          parent node. It is possible for each RIS to be associated with different
> +          devices in which case 'arm,mpam-device' should be used.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +
> +dependencies:
> +  interrupts: [ interrupt-names ]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /*
> +    cpus {
> +        cpu@0 {
> +            next-level-cache = <&L2_0>;
> +        };
> +        cpu@100 {
> +            next-level-cache = <&L2_1>;
> +        };
> +    };
> +    */
> +    L2_0: cache-controller-0 {
> +        compatible = "cache";
> +        cache-level = <2>;
> +        cache-unified;
> +        next-level-cache = <&L3>;
> +
> +    };
> +
> +    L2_1: cache-controller-1 {
> +        compatible = "cache";
> +        cache-level = <2>;
> +        cache-unified;
> +        next-level-cache = <&L3>;
> +
> +    };

All the above should be dropped. Not part of this binding.

> +
> +    L3: cache-controller@30000000 {
> +        compatible = "arm,dsu-l3-cache", "cache";

Pretty sure this is a warning because that compatible doesn't exist.

> +        cache-level = <3>;
> +        cache-unified;
> +
> +        ranges = <0x0 0x30000000 0x800000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        msc@10000 {
> +            compatible = "arm,mpam-msc";
> +
> +            /* CPU affinity implied by parent cache node's  */
> +            reg = <0x10000 0x2000>;
> +            interrupts = <1>, <2>;
> +            interrupt-names = "error", "overflow";
> +            arm,not-ready-us = <1>;
> +        };
> +    };
> +
> +    mem: memory-controller@20000 {
> +        compatible = "foo,a-memory-controller";
> +        reg = <0x20000 0x1000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        msc@21000 {
> +            compatible = "arm,mpam-memory-controller-msc", "arm,mpam-msc";
> +            reg = <0x21000 0x1000>;
> +            interrupts = <3>;
> +            interrupt-names = "error";
> +            arm,not-ready-us = <1>;
> +            numa-node-id = <1>;
> +        };
> +    };
> +
> +    iommu@40000 {
> +        reg = <0x40000 0x1000>;
> +
> +        ranges;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        msc@41000 {
> +            compatible = "arm,mpam-msc";
> +            reg = <0 0x1000>;
> +            interrupts = <5>, <6>;
> +            interrupt-names = "error", "overflow";
> +            arm,not-ready-us = <1>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ris@2 {
> +                compatible = "arm,mpam-cache";
> +                reg = <0>;
> +                // TODO: How to map to device(s)?
> +            };
> +        };
> +    };
> +
> +    msc@80000 {
> +        compatible = "foo,a-standalone-msc";
> +        reg = <0x80000 0x1000>;
> +
> +        clocks = <&clks 123>;
> +
> +        ranges;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        msc@10000 {
> +            compatible = "arm,mpam-msc";
> +
> +            reg = <0x10000 0x2000>;
> +            interrupts = <7>;
> +            interrupt-names = "overflow";
> +            arm,not-ready-us = <1>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ris@0 {
> +                compatible = "arm,mpam-cache";
> +                reg = <0>;
> +                arm,mpam-device = <&L2_0>;
> +            };
> +
> +            ris@1 {
> +                compatible = "arm,mpam-memory";
> +                reg = <1>;
> +                arm,mpam-device = <&mem>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.39.5
> 

