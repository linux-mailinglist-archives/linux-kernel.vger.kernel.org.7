Return-Path: <linux-kernel+bounces-741860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6EDB0E9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57B77AF46B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366824888C;
	Wed, 23 Jul 2025 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuhHmj/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2C248195;
	Wed, 23 Jul 2025 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246883; cv=none; b=Yf/2bfLwxbCWmmRNr+VNHc0MxCBEZ6DWjVfDXDv5v2aYajmFr5OPOxJAD0k5PeW3QJiQcovn7I84Nv7HWg+7ZuF3xm21fJkWWxTRU2jGUEL3egDBXpHL8fh1M0aDjjoiOtZPR0lGMfP09gVqvjorKvbn6bQVSnsKWshgbIylSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246883; c=relaxed/simple;
	bh=nr7OfTTQrE+gjAhHnV5WWfzbsPjiUAEdRwGAk43q3eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqY5nBC1wwumaNtBK0GhyXfYAjxSE28mmhYcshQn0FoYZzI/R6jwH+UFKPBOcZpYCo5hF9ENAiPRyeCP6D11wt/emy/EchQj2hLhK+d5X4fTTJTFg1vSIfRcorMQwDV5r5uyXGNBg7ypPml++HQBBskHIvM/nRcLe61Zr+zJDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuhHmj/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F254C4AF0D;
	Wed, 23 Jul 2025 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753246881;
	bh=nr7OfTTQrE+gjAhHnV5WWfzbsPjiUAEdRwGAk43q3eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuhHmj/h/2uh5LXRhhsVjfjHHrUKXBRdr1z0kVTGl5x5086/1ix8pOobaIalqgpJ1
	 QurkgEcQj7LUZm0AxLoRw41hSmyTi8lFTTzTFDd9YIXxmzJVI15dAb8bNQoxhmQYgq
	 lJultjtbR/SxGDiif4Tqif7W/JkFpDibILCFduZdUyJDdnvzYjvikEbz7Z1ru1pjMT
	 0PmppaUR2/N7waKD5LLo0J/+tTlb4J9Fg5QH7QM8HL3bELgdtqUosctWrDb/ydLR4p
	 bAyr0qJBwVBEHJEw8AjUctRr0K3vnl9vZzdiDAecVQWBJ7p3CrDoHvEOCkdtxnMGrt
	 9Ttx035BFu5lQ==
Date: Wed, 23 Jul 2025 00:01:20 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Message-ID: <20250723050120.GA1231854-robh@kernel.org>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722095156.1672873-2-ryan_chen@aspeedtech.com>

On Tue, Jul 22, 2025 at 05:51:55PM +0800, Ryan Chen wrote:
> The AST2700 SoC contains two independent top-level interrupt controllers
> (INTC0 and INTC1), each responsible for handling different peripheral
> groups and occupying separate register spaces. Above them, PSP(CA35) GIC
> controller acts as the root interrupt aggregator. Accurately describing
> this hierarchical hardware structure in the device tree requires distinct
> compatible strings for the parent nodes of INTC0 and INTC1.
> 
> - Adds 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
>  strings for parent interrupt controller nodes. (in addition to the
>  existing 'aspeed,ast2700-intc-ic' for child nodes)
> - Clarifies the relationship and function of INTC0 parent
>  (intc0_0~x: child), INTC1 parent (intc1_0~x: child), and the GIC
>  in the documentation.
> - Updates block diagrams and device tree examples to illustrate
>  the hierarchy and compatible usage.
> - Refines documentation and example formatting.
> 
> This change allows the device tree and driver to distinguish between
> parent (top-level) and child (group) interrupt controller nodes,
> enabling more precise driver matching SOC register space allocation.

That's nice, but is an ABI break.

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
>  1 file changed, 115 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> index 55636d06a674..bdc4d8835843 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> @@ -10,6 +10,33 @@ description:
>    This interrupt controller hardware is second level interrupt controller that
>    is hooked to a parent interrupt controller. It's useful to combine multiple
>    interrupt sources into 1 interrupt to parent interrupt controller.
> +  Depend to which INTC0 or INTC1 used.
> +  INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
> +  status registers for use.
> +  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> +  INTC1 is used to assert INTC0 if interrupt of modules asserted.
> +  +-----+   +---------+
> +  | GIC |---|  INTC0  |
> +  +-----+   +---------+
> +            +---------+
> +            |         |---module0
> +            | INTC0_0 |---module1
> +            |         |---...
> +            +---------+---module31
> +            |---....  |
> +            +---------+
> +            |         |     +---------+
> +            | INTC0_11| +---| INTC1   |
> +            |         |     +---------+
> +            +---------+     +---------+---module0
> +                            | INTC1_0 |---module1
> +                            |         |---...
> +                            +---------+---module31
> +                            ...
> +                            +---------+---module0
> +                            | INTC1_5 |---module1
> +                            |         |---...
> +                            +---------+---module31
>  
>  maintainers:
>    - Kevin Chen <kevin_chen@aspeedtech.com>
> @@ -17,49 +44,70 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> -      - aspeed,ast2700-intc-ic
> +      - aspeed,ast2700-intc0
> +      - aspeed,ast2700-intc1
>  
>    reg:
>      maxItems: 1
>  
> -  interrupt-controller: true
> +  '#address-cells':
> +    const: 2
>  
> -  '#interrupt-cells':
> +  '#size-cells':
>      const: 2
> -    description:
> -      The first cell is the IRQ number, the second cell is the trigger
> -      type as defined in interrupt.txt in this directory.
> -
> -  interrupts:
> -    maxItems: 6
> -    description: |
> -      Depend to which INTC0 or INTC1 used.
> -      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
> -      status registers for use.
> -      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> -      INTC1 is used to assert INTC0 if interrupt of modules asserted.
> -      +-----+   +-------+     +---------+---module0
> -      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
> -      |     |   |       |  |  |         |---...
> -      +-----+   +-------+  |  +---------+---module31
> -                           |
> -                           |   +---------+---module0
> -                           +---| INTC1_1 |---module2
> -                           |   |         |---...
> -                           |   +---------+---module31
> -                          ...
> -                           |   +---------+---module0
> -                           +---| INTC1_5 |---module2
> -                               |         |---...
> -                               +---------+---module31
>  
> +  ranges: true
> +
> +patternProperties:
> +  "^interrupt-controller@":
> +    type: object
> +    description: Interrupt group child nodes
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - aspeed,ast2700-intc-ic
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 2
> +        description: |

Don't need '|'.

> +          The first cell is the IRQ number, the second cell is the trigger
> +          type as defined in interrupt.txt in this directory.

Don't add links to legacy documents.

> +
> +      interrupts:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          The interrupts provided by this interrupt controller.
> +
> +      interrupts-extended:

Why do you have both interrupts and interrupts-extended? They are 
mutually exclusive and both are auto-magically supported. The schemas 
only have to document 'interrupts'.

> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          This property is required when defining a cascaded interrupt controller
> +          that is connected under another interrupt controller. It specifies the
> +          parent interrupt(s) in the upstream controller to which this controller
> +          is connected.
> +
> +    oneOf:
> +      - required: [interrupts]
> +      - required: [interrupts-extended]
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupt-controller
> +      - '#interrupt-cells'
>  
>  required:
>    - compatible
>    - reg
> -  - interrupt-controller
> -  - '#interrupt-cells'
> -  - interrupts
>  
>  additionalProperties: false
>  
> @@ -68,19 +116,43 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      intc0: interrupt-controller@12100000 {

This node isn't an interrupt-controller.

> +        compatible = "aspeed,ast2700-intc0";
> +        reg = <0 0x12100000 0 0x4000>;
> +        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        intc0_11: interrupt-controller@1b00 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0 0x12101b00 0 0x10>;
> +          #interrupt-cells = <2>;
> +          interrupt-controller;
> +          interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +        };
> +      };
> +
> +      intc1: interrupt-controller@14c18000 {
> +        compatible = "aspeed,ast2700-intc1";
> +        reg = <0 0x14c18000 0 0x400>;
> +        ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
>          #address-cells = <2>;
>          #size-cells = <2>;
>  
> -        interrupt-controller@12101b00 {
> -            compatible = "aspeed,ast2700-intc-ic";
> -            reg = <0 0x12101b00 0 0x10>;
> -            #interrupt-cells = <2>;
> -            interrupt-controller;
> -            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +        intc1_0: interrupt-controller@100 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0x0 0x100 0x0 0x10>;
> +          #interrupt-cells = <2>;
> +          interrupt-controller;
> +          interrupts-extended = <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>          };
> +      };
>      };
> -- 
> 2.34.1
> 

