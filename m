Return-Path: <linux-kernel+bounces-740402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B3B0D3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958903B87FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D12DEA8E;
	Tue, 22 Jul 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADyORdoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440512D97AC;
	Tue, 22 Jul 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170030; cv=none; b=gFCbpFv0Har8Te2dcpf2rz6CltyaaFNJQLFP0+r1wV8ThuRfmJyZ1kZlwO41OThjvplkvApeBIqZM9tNTY2TIaetgtdDwYzIVmwTbfF85MgSz0FefSczdwRYBRc5bsJr+rGDxvj33aE6lRSxgNvUUNV1fXP2pF67HaEvjbrFFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170030; c=relaxed/simple;
	bh=RBdPqk/qz5CqPfF78B5X1H4wCj9+h+BraRPQT4rRURQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViJwSqHMqUNGQYon6eZz3Svr6Q2ncY8YToUM3HbtTAlyOP3IDFQ/JNoioEssBBC052BKURhNVwLX5KtBLv8VZxS5EVx6gmBmE+ZzHcKSTavm1Lwv2Fk0XqrE86yF4E+EV1VO/85/sqA9f/j/bWFwCOsTAQWT/DSAZqPy84tgVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADyORdoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B8C4CEEB;
	Tue, 22 Jul 2025 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753170029;
	bh=RBdPqk/qz5CqPfF78B5X1H4wCj9+h+BraRPQT4rRURQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADyORdoD38oesIHc5HA1NY01c/c5SHYap0kQXg0CjAerwhbRX5kFhl9dkMiXZrUl+
	 tUeh99b7SLKU9DpEpSOBDciyGQA9ZfBvqN7hcNeBlE1i/xXMIQuN5ImHU2OknNeO66
	 yJ89uVqhi/l8hFp6mjRJcaGeECNsIcNFzI/60KU2wsoa9nHDlGVp5mw6xHjtu0TeCD
	 PPlhkKUsdCSu+X5JxSK84H/WyZlxpiLT8TKP35p7NZ4VWtNwj8XlUVmAGJAKLfuHwW
	 Nsb76tMie0N78oCgFsQB6PWW/6z9v+Lq/j0g2Rvo+h8rfl7Nis+sue4GJN9yEMwj1l
	 Mn6KNWkS21sYg==
Date: Tue, 22 Jul 2025 09:40:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, 
	michal.simek@xilinx.com, git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Add Xilinx INTC
 binding
Message-ID: <20250722-pragmatic-nebulous-bloodhound-6251bb@kuoka>
References: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>

On Tue, Jul 22, 2025 at 08:49:42AM +0200, Michal Simek wrote:
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      Specifies the number of cells needed to encode an interrupt source.
> +      The value shall be a minimum of 1. The Xilinx device trees typically
> +      use 2 but the 2nd value is not used.
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Specifies the interrupt of the parent controller from which it is chained.
> +
> +  xlnx,kind-of-intr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      A 32 bit value specifying the interrupt type for each possible interrupt
> +      (1 = edge, 0 = level). The interrupt type typically comes in thru
> +      the device tree node of the interrupt generating device, but in this case
> +      the interrupt type is determined by the interrupt controller based on how
> +      it was implemented.

enum: [ 0, 1 ]

> +
> +  xlnx,num-intr-inputs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the number of interrupts supported by the specific
> +      implementation of the controller (1-32).

minimum:
maximum:

> +
> +required:
> +  - reg
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +  - xlnx,kind-of-intr
> +  - xlnx,num-intr-inputs
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@41800000 {
> +      compatible = "xlnx,xps-intc-1.00.a";
> +      reg = <0x41800000 0x10000>;
> +      #interrupt-cells = <2>;
> +      interrupt-controller;
> +      xlnx,kind-of-intr = <0x1>;
> +      xlnx,num-intr-inputs = <0x1>;

This should be decimal, we (humans) count in decimal. xlnx,kind-of-intr
probably as well, for consistency and simplicity.

> +    };
> +
> +  - |
> +    /*
> +     * Chained Example - The interrupt is chained to hardware
> +     * interrupt 61 (29 + 32) of the GIC for Zynq.
> +     */
> +    interrupt-controller@41800000 {
> +      compatible = "xlnx,xps-intc-1.00.a";
> +      reg = <0x41800000 0x10000>;
> +      #interrupt-cells = <2>;
> +      interrupt-controller;
> +      interrupts = <0 29 4>;

Use defines for standard flags. Or drop the example, difference in one
property usually is not worth documenting.

Best regards,
Krzysztof


