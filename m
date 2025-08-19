Return-Path: <linux-kernel+bounces-775841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36FB2C5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372A2246BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD162459FB;
	Tue, 19 Aug 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+j8zTCx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1F2EB840;
	Tue, 19 Aug 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609846; cv=none; b=gvmJ/1lz4jLoaERU5McEORHnDzsM+YAyzucwZSE01pLo5h3pzVHJh1bX6MS/F9EUAjTiMaupoYHCTxpHg3JyzDQJW2ebvvkCz2dg+WLQWIKm6mO7SXA7VcRHSN9lL0Mss6TLtpNcsuk/gwTtekS1MV/58T4HPmOs/Bvxk2OW18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609846; c=relaxed/simple;
	bh=oMo/cdh38YCbOBw4iwATq7ozwW1TpUbE0yXhbYlUgU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmdfQYXsKiMKCnESm7QEVQ/MfUG6gC0OhsxqL3dEERSn+YHDmnOdImYrVbltEedQLemKJD/pOi5oC+powfQ7FQZr1YX1qEfIGsQz+38thLfd3zzLEGpO5zS1/c1hFAzkvtHPbshAAIeFZJSDIvBHdP5ny+EMbVJFQe2WLyP+wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+j8zTCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7FEC4CEF1;
	Tue, 19 Aug 2025 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755609846;
	bh=oMo/cdh38YCbOBw4iwATq7ozwW1TpUbE0yXhbYlUgU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+j8zTCxQdkcMEhMaej6GiAgIOaXfofvg7es9Jp2PGsrXvywOcYTBRmEuFNsYF/G8
	 qIviixcV27EuzpLCP/Nry898wPulNLltPxo16ILqFJjYM1R5Du+rz8J7TWL0oQ73Lx
	 Whwuwctm1JUeUeLNkuYPDOxjtAwdXZOaMTUS1hGTWXYn597TaUkbprtT5KuRs0qqzT
	 +fBOqlgcskasEvnBNDu8U3MYiGCiDf+G1RHobrmRS2I7i2xvaFcNOsSsfmgjjZs+Xl
	 iM7QRM7IS/3barZzPVPJn10e8de0FtZU4lWfYLD2JnIikAi9RjwVlfyjyHiHYwfnmm
	 Uf6IF5fk5eAjg==
Date: Tue, 19 Aug 2025 08:24:04 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [RESEND v2 1/1] dt-bindings: soc: add vf610 reboot syscon
 controller
Message-ID: <20250819132404.GA84481-robh@kernel.org>
References: <20250818183427.3601986-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818183427.3601986-1-Frank.Li@nxp.com>

On Mon, Aug 18, 2025 at 02:34:26PM -0400, Frank Li wrote:
> Add vf610 reboot controller, which used to reboot whole system. Fix below
> CHECK_DTB warnings:
> 
> arch/arm/boot/dts/nxp/vf/vf610-bk4.dtb: /soc/bus@40000000/src@4006e000:
>     failed to match any schema with compatible: ['fsl,vf610-src', 'syscon']
> 
> IC reference manual call it as system reset controller(SRC), but it is not
> module as linux reset controller, which used to reset individual device.
> SRC work as reboot controller, which reboot whole system. It provides a
> syscon interface to syscon-reboot.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v2
> - change description to avoid confuse about reset controller.
> - it is legacy device, more than 10 year. So try keep existed dts as it.
> ---
>  .../bindings/soc/fsl/fsl,vf610-src.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
> new file mode 100644
> index 0000000000000..cb8aa510a21f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas//soc/fsl/fsl,vf610-src.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale vf610 System Reset Controller (SRC)
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |

Don't need '|'

> +  IC reference manual call it as SRC, but it is not module as linux reset

calls

Linux details aren't really relevant.

> +  controller, which used to reset individual device. SRC work as reboot

works

> +  controller, which reboot whole system. It provide a syscon interface to

reboots

> +  syscon-reboot.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,vf610-src
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    syscon@4006e000 {
> +        compatible = "fsl,vf610-src", "syscon";
> +        reg = <0x4006e000 0x1000>;
> +        interrupts = <96 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> -- 
> 2.34.1
> 

