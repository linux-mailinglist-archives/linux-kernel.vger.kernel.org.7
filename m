Return-Path: <linux-kernel+bounces-781267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B685FB3102D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003ECA27B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93172E7BA5;
	Fri, 22 Aug 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKSx4pVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9382E7649;
	Fri, 22 Aug 2025 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847280; cv=none; b=sUjlKjKtxvmU8NJIyyJuEvvEKJmN9ChxH2Yhr19b3Tc8p1S4IrLk3/nl/3jkar/KrigBDfzLgPmXqZMlOkAFq/IncdC2VohN/qXtAUJZS8QcLqweGRJBe4+fOVpLSGAZifxb/CkUMYxMKKdoFDxrTuS5ObJikDFfC9GtfDz4iKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847280; c=relaxed/simple;
	bh=9uaMJs6sg/YarZAM7SbzOk00s8OELm7sn0JnahGeyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIFAo//0d1tx4hkcvo1K7FZcUKFm4rcP2z21KKytf4CWdmaqDjlmdHVSRSYYXUoUz9n6hWBr5Rgrc2+p02FMvdxLxOwfiA03zyBLSCYYCsibdBHxw6hgT1rLVOWJeAHYdapSBPVCBNDHaH41TcR2rGLLeX1SLewCvl3gsbnI7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKSx4pVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0DC4CEF1;
	Fri, 22 Aug 2025 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755847279;
	bh=9uaMJs6sg/YarZAM7SbzOk00s8OELm7sn0JnahGeyUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKSx4pVIx6xZZqBhmOstRCpGtRVCHmcH6y4oQEE1tlUq1GKuQjeIwSI3g2VD50GwU
	 OhcCA55hdqG76aVhl/YmbNp7ax6ABMiNvhZm/HfhVgaIjuBjuxmU81K1bYQ2wAtWw9
	 4Q+3y4M8e8Q6EsBmDesj6VEn1npXQ07mGUW/m0LKtyQKqVS00fhlvN/YJLRDGz15Nn
	 LXatWZDU5GSE2zWBQxIUq7zno2Jo4PJSV8alJb6TOPRSqZCps7oYO2r8KfTcV6tdeW
	 X8aMdADpc5o4tr4RBHUVfJitdrTJ+GHLY8Qe9cFMrqPJhxUaOPclBaz9ZfZChr1LyP
	 2GqP5VUK3UneA==
Date: Fri, 22 Aug 2025 09:21:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add ARM SSE(Subsystems for
 Embedded) timer
Message-ID: <20250822-busy-dragonfly-of-science-d769bb@kuoka>
References: <20250821152429.26995-1-jszhang@kernel.org>
 <20250821152429.26995-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821152429.26995-2-jszhang@kernel.org>

On Thu, Aug 21, 2025 at 11:24:28PM +0800, Jisheng Zhang wrote:
> Add binding doc for the ARM SSE(Subsystems for Embedded) timer. Here
> is the document URL:
> https://developer.arm.com/documentation/107610/0000/System-timer-components?lang=en
> 
> Although the IP is mostly seen on MCU SoC platforms, but nothing
> prevent it from being integrated into linux capable SoC platforms.

But is there such integration?

> 
> The IP core may have a system counter to generate timestamp value,
> a system timer to raise an interrupt when a period has elapsed, and
> a System Watchdog to detect errant system behaviour then reset the
> system if a period elapses without ping.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/timer/arm,sse_timer.yaml         | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml b/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
> new file mode 100644
> index 000000000000..37a79f9052d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/arm,sse_timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SSE(Subsystems for Embedded) system timer
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description: |+

Drop |+

> +  ARM SSE(Subsystems for Embedded) system timer core may have a system counter
> +  to generate timestamp value, a system timer to raise an interrupt when a
> +  period has elapsed, and a System Watchdog to detect errant system behaviour
> +  then reset the system if a period elapses without ping.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:

Drop these two, just const.

> +          - arm,sse-timer
> +
> +  reg:
> +    maxItems: 1
> +    description: The system counter control frame base
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    enum: [1, 2]
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  '^frame@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +    description: A timer node has some frame sub-nodes, each frame can be timer frame or watchdog frame. Each frame has the following properties.

Please follow Linux coding style.

> +    properties:
> +      interrupts:
> +        minItems: 1
Drop

> +        items:
> +          - description: timer irq

Drop, instead maxItems: 1

> +
> +      reg:

Keep order as in every other binding (and DTS coding style).

> +        minItems: 1
> +        items:
> +          - description: 1st view base address
> +          - description: 2nd optional view base address if this is a watchdog frame
> +
> +    required:
> +      - interrupts
> +      - reg

Keep DTS coding style order.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@f7f3e000 {
> +      compatible = "arm,sse-timer";
> +      #address-cells = <1>;

Keep order as in DTS coding style.

> +      #size-cells = <1>;
> +      ranges;
> +      reg = <0xf7f3e000 0x2000>;
> +      clocks = <&core_clk>;
> +
> +      frame@f7f20000 {
> +        reg = <0xf7f20000 0x1000>;
> +        interrupts = <0 26 0x8>;

Use proper defines

> +      };
> +
> +      frame@f7f30000 {
> +        interrupts = <0 15 0x8>;
> +        reg = <0xf7f32000 0x1000>,
> +              <0xf7f33000 0x1000>;
> +      };

Best regards,
Krzysztof


