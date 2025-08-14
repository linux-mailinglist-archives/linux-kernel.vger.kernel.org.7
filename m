Return-Path: <linux-kernel+bounces-768213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95534B25E47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B433189770F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E42275108;
	Thu, 14 Aug 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0QPM3oC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469282E613C;
	Thu, 14 Aug 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158636; cv=none; b=pLl2V/CSBbqGKwg07qVCNH2pXyKLC4QczvoRqGZkgU4rky91ZsKWFkhL1hVnrj+jQVm5CjZwUczO9bJUc/aFKifemZ0owVPRjNvra7me/CEsCXA7Z3svc32QEhZHJ3vI+il9Voi7/NIr1+vADlqKoHXNc++8+rc2F2baipUabsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158636; c=relaxed/simple;
	bh=X3Zkv1GgYGEV/PFrhjV6JjLBSwA81+ffdc9QPdchXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suJ6p7tQDtmEG0HUdmvdhMMkhGTLvcQ9KBU2eBY1EOUJRasPCIOJj2bFhHgWNXSigW2ZNiZhJUWpjr710k919m1N/pO9fKq0J7LkU23o6bz0j6zoE0Xju443vQqdr7IRe8bTczeIhmEiHmE1rDvwOgAUGY5Q0Wh/Me71EeTGsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0QPM3oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F5C4CEEF;
	Thu, 14 Aug 2025 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158635;
	bh=X3Zkv1GgYGEV/PFrhjV6JjLBSwA81+ffdc9QPdchXLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0QPM3oCyMK9LWNRNmg59i3pAgrctvv8lnJBbGzCuDxjDcLS7utfL0DmwKI0yFcs3
	 KL+xoza2Ywl9NslWcJ9zrBL25photeR9qQI+4PtMKU0RrWpuWjwSmj+ujtvvkyKqWi
	 xcC9OH2qzbJOqjV6OHFgnYBbEiwPKUllpthQbNaTQqhk+piDNONSb2KXV6HuC3O3nx
	 zRw2GLuDnxvEYkz0oYB8TnHK690hqLWxX884VsND1y8fe7d+sxk37Pcxs9k8HHS9RP
	 OAFT8UjwaXQ02146plSOQyVNK4hhbUb3WIrFLwX7wWywlsx4m8yZFvSbWRt4UvVQPN
	 EW6hIEZvRnGEQ==
Date: Thu, 14 Aug 2025 10:03:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent compatibles and refine documentation
Message-ID: <20250814-auspicious-thundering-jaybird-b76f4f@kuoka>
References: <20250812100830.145578-1-ryan_chen@aspeedtech.com>
 <20250812100830.145578-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812100830.145578-2-ryan_chen@aspeedtech.com>

On Tue, Aug 12, 2025 at 06:08:29PM +0800, Ryan Chen wrote:
> AST2700 contains two independent top-level interrupt controllers (INTC0,
> INTC1). Each occupies its own register space and handles different sets of
> peripherals. Above them, the PSP (CA35) GIC is the root interrupt
> aggregator. In hardware, INTC1 outputs are routed into INTC0, and INTC0
> outputs are routed into the GIC.
> 
> Introduce distinct compatibles for these parent blocks so the DT can model
> the hierarchy and register space layout accurately:
> 
>   - aspeed,ast2700-intc0  (parent node at 0x12100000)
>   - aspeed,ast2700-intc1  (parent node at 0x14c18000)
> 
> The existing child compatible:
> 
>   - aspeed,ast2700-intc-ic
> 
> continues to describe the interrupt-controller instances within each INTC
> block (e.g. INTC0_0..INTC0_11 and INTC1_0..INTC1_5).
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
>  1 file changed, 115 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> index 55636d06a674..81304b53c112 100644
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

Same problem as last time. This tells me intc0 has not children...

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

...This tells that inc1 has no children (only intc0_11, which you said
is aspeed,ast2700-intc-ic !!!)....
(keep scrolling)

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

... but this tells me that intc0 and intc1 has children.

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
> +        description:
> +          The first cell is the IRQ number, the second cell is the trigger
> +          type.
> +
> +      interrupts:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          The interrupts provided by this interrupt controller.
> +
> +      interrupts-extended:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          This property is required when defining a cascaded interrupt controller
> +          that is connected under another interrupt controller. It specifies the
> +          parent interrupt(s) in the upstream controller to which this controller
> +          is connected.

No, you do not define two. Only interrupts.

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
> +        compatible = "aspeed,ast2700-intc0";
> +        reg = <0 0x12100000 0 0x4000>;
> +        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        intc0_11: interrupt-controller@1b00 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0 0x12101b00 0 0x10>;


... and that's quite wrong unit address. Also no resources in the
parent, so this entire split seems superficial and incorrect.

This binding is not improving. You are not responding to REAL problems
described to you. What's more, you send it in a way making our life
difficult, look:

b4 diff '20250812100830.145578-2-ryan_chen@aspeedtech.com'
Using cached copy of the lookup
---
Analyzing 3 messages in the thread
Could not find lower series to compare against.

Best regards,
Krzysztof


