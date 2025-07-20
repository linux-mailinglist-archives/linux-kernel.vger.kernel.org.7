Return-Path: <linux-kernel+bounces-738498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BCEB0B932
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E2D1772B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358B22F765;
	Sun, 20 Jul 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqxzyVls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BA12CDA5;
	Sun, 20 Jul 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054048; cv=none; b=WKd8Ezdz2aX9fxXADwzwL1LCAnCZXfsMZQeXMN2VwhkArPjnMCEM7xfjko1p1scPDb92Uhlv96srmq7nzH68MtPE3np7tlpSZKTrS8btqg/0tkvsqHphRrXZTQdidHpLKo9GEfbe15s767u1fDA69h+dIKN9vyP5BdB+zRdZxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054048; c=relaxed/simple;
	bh=Kp8wb7K590ryA6q3+0fGUzS4UK4ZiBYQOTjHZtSIW6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcaBqbiiyLmgagGTSKC/0TBU/4HTFpZbkYDebhpK1oX2O6mpIQzzB9axdoQO38IjM1r2rSjuFNSQnfWqEWRioi5c6R34L9Aovc/0RShfD6rBRDdUm6LjLDTkKHnuhg4U2cQxaIJ0XNmLQqH8Epp/wg8at6KqbKHwOBLBZNjw1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqxzyVls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851D2C4CEE7;
	Sun, 20 Jul 2025 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753054047;
	bh=Kp8wb7K590ryA6q3+0fGUzS4UK4ZiBYQOTjHZtSIW6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqxzyVls72ujIUH0TfZiBBXI9npEj3OTs4/nKAEFWnp1JgrC1B42pKi/1ZoVTCr8a
	 3faW3aTsf2/RbbqBd/IQstTYFBWT8nrxTdfoYFsc0f3fY/Uu3BGXJtMk0Ig5EhExdb
	 TJhoMXiKQrkjdVg4IjL64T9bmZqJdGD1JtRVmtJOT+zzJuvWOAqC6OSURMt86Um5IK
	 aLv/wGwywC2qm02YXNt806xjgeAhlPk8GQqHeIJQxDNv+iJg9z5EZ2YsL0Dv90E909
	 0odZB/oWaQRRxOlG+eN81tSVgryN6cX1a9GXfM4yq3d4QCJNmObop6rmveWw6BNTJp
	 +vHouUaK09HvQ==
Date: Sun, 20 Jul 2025 18:27:26 -0500
From: Rob Herring <robh@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	gastmaier@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <20250720232726.GA3055763-robh@kernel.org>
References: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
 <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>

On Thu, Jul 17, 2025 at 09:09:20AM +0200, Jorge Marques wrote:
> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> core that implements the MIPI I3C Basic controller specification.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 67 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8f532386de2c05d3d514d41ff4d6a37ec840674c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/adi,i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices I3C Controller
> +
> +description: |
> +  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
> +  implementing a subset of the I3C-basic specification. The IP core is tested
> +  on arm, microblaze, and arm64 architectures.
> +
> +  https://analogdevicesinc.github.io/hdl/library/i3c_controller
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +properties:
> +  compatible:
> +    const: adi,i3c-master-v1

If you want to use version numbers, they need to correlate to something 
and you need to document what that is. I don't see anything in the above 
link about a version 1. Kind of feels like you just made it up.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: The AXI interconnect clock, drives the register map.
> +      - description: The I3C controller clock. AXI clock drives all logic if not provided.

Is that a description of how the h/w works? The controller clock input 
can literally be left disconnected? If 1 clock source drives both 
inputs, then the binding should reflect that.

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: axi
> +      - const: i3c
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i3c@44a00000 {
> +        compatible = "adi,i3c-master-v1";
> +        reg = <0x44a00000 0x1000>;
> +        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 15>, <&clkc 15>;
> +        clock-names = "axi", "i3c";
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +
> +        /* I3C and I2C devices */
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5a173e987c06d75848d112339e39966f2b71cea..1f212529276f4ab28f4b7d16b4105a8cf9ff5e2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11452,6 +11452,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
>  F:	drivers/i3c/master/ast2600-i3c-master.c
>  
> +I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> +
>  I3C DRIVER FOR CADENCE I3C MASTER IP
>  M:	Przemysław Gaj <pgaj@cadence.com>
>  S:	Maintained
> 
> -- 
> 2.49.0
> 

