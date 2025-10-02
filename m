Return-Path: <linux-kernel+bounces-840692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ACABB4FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E018424CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7228505A;
	Thu,  2 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyIW06Ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDF2367B5;
	Thu,  2 Oct 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433108; cv=none; b=sUWKtGB0lpfKuOAjTjHua/zFOmEfiypEcRK9Bni8xz3SbZg22fhSDKFwesL/IY+uOLGvPc8M0jij14hO6ymxSkQWaOSkUMfN3KkblbIfIrTScEcpyFypDWJp0pq01oL3SDXFdbCHsOYCiJ8h6u2nCsqGv42wcZDpzhR/pKkpadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433108; c=relaxed/simple;
	bh=nip5+pOwI51SpkdT3VI8Pei0Qu8xBZA8qy5/5279btk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngzz5XnOH+qiBPy+ZQjZJT2FqoE/Sc4036pxDImRTMK2+RJzLEXlsgUHotS//E4xrOvoEmQpx0hl4uAM4XI8CFyn4VW+fM0aW6DiT9cojf6PrpcVraAXVcSjBqvlfSlHe/Yv1bzwpNUk86WWFbUFC9/Nj2mtSdPzBTcrrns9z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyIW06Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195BC4CEF4;
	Thu,  2 Oct 2025 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759433107;
	bh=nip5+pOwI51SpkdT3VI8Pei0Qu8xBZA8qy5/5279btk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyIW06SsYzTvVCBSOdJfh8xJdGlFve2FJQHquD1zuZcRfEz/9sDRnJTZCIGkFjEoO
	 rjLfIlYBQcACPxCYeJ3ITZE31JSDX3dQbAEwcs+F7Ly/KiD0JkI2gVYxykfa/zmo9B
	 +l0nLRtNJxsJTJp31KXkFIYX+gjDWhmGos4XT3SEliP6xF1kGPPu2mq99NDRAxqaFs
	 fcIWj4yNLiNz3MVhJmoUwSNy+BktXaNtsS/zs1svks3uDTYMCMeni9/KuhPXbUs0+V
	 +4+z0KVkeqi9vO4TQkZ7F5UoBdUTy/aC9qQjGfhBcFIEKCtjRhdF1KOBcStZ6Lcb3I
	 axQNn2DywNC/g==
Date: Thu, 2 Oct 2025 14:25:06 -0500
From: Rob Herring <robh@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: Add RISC-V trace component bindings
Message-ID: <20251002192506.GA236729-robh@kernel.org>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002060732.100213-2-apatel@ventanamicro.com>

On Thu, Oct 02, 2025 at 11:37:22AM +0530, Anup Patel wrote:
> Add device tree bindings for the memory mapped RISC-V trace components
> which support both the RISC-V efficient trace (E-trace) protocol and
> the RISC-V Nexus-based trace (N-trace) protocol.
> 
> The RISC-V trace components are defined by the RISC-V trace control
> interface specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/riscv/riscv,trace-component.yaml | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml b/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
> new file mode 100644
> index 000000000000..78a70fe04dfe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/riscv,trace-component.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/riscv,trace-component.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Trace Component
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V trace control interface specification standard memory mapped
> +  components (or devices) which support both the RISC-V efficient trace
> +  (E-trace) protocol and the RISC-V Nexus-based trace (N-trace) protocol.
> +  The RISC-V trace components have implementation specific directed acyclic
> +  graph style interdependency where output of one component serves as input
> +  to another component and certain components (such as funnel) can take inputs
> +  from multiple components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qemu,trace-component
> +      - const: riscv,trace-component

Given the generic-ness of these names, I'm assuming the exact type of 
component is discoverable. I don't like to assume things in bindings, so 
spell that out.

Is the implementer discoverable? If so, you could omit the 1st 
compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  cpu:

'cpus' is the more standard property.

> +    description:
> +      phandle to the cpu to which the RISC-V trace component is bound.
> +    $ref: /schemas/types.yaml#/definitions/phandle

which already has a type. So just 'maxItems: 1' here.

> +
> +  in-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      '^port(@[0-7])?$':
> +        description: Input connections from RISC-V trace component
> +        $ref: /schemas/graph.yaml#/properties/port

If the N ports are N of the same data (like a mux), then fine. If each 
port is different, then you need to define what each port is.

> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      '^port(@[0-7])?$':
> +        description: Output connections from RISC-V trace component
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example 1 (Per-hart encoder and ramsink components):
> +
> +    encoder@c000000 {

Perhaps it is time to standardize the node names here. Perhaps 'trace'.

> +      compatible = "qemu,trace-component", "riscv,trace-component";
> +      reg = <0xc000000 0x1000>;
> +      cpu = <&CPU0>;
> +      out-ports {
> +        port {
> +          CPU0_ENCODER_OUTPUT: endpoint {
> +            remote-endpoint = <&CPU0_RAMSINK_INPUT>;
> +          };
> +        };
> +      };
> +    };
> +
> +    ramsink@c001000 {
> +      compatible = "qemu,trace-component", "riscv,trace-component";
> +      reg = <0xc001000 0x1000>;
> +      cpu = <&CPU0>;
> +      in-ports {
> +        port {
> +          CPU0_RAMSINK_INPUT: endpoint {
> +          };
> +        };
> +      };
> +    };
> +
> +    encoder@c002000 {
> +      compatible = "qemu,trace-component", "riscv,trace-component";
> +      reg = <0xc002000 0x1000>;
> +      cpu = <&CPU1>;
> +      out-ports {
> +        port {
> +          CPU1_ENCODER_OUTPUT: endpoint {
> +            remote-endpoint = <&CPU1_RAMSINK_INPUT>;
> +          };
> +        };
> +      };
> +    };
> +
> +    ramsink@c003000 {
> +      compatible = "qemu,trace-component", "riscv,trace-component";
> +      reg = <0xc003000 0x1000>;
> +      cpu = <&CPU1>;
> +      in-ports {
> +        port {
> +          CPU1_RAMSINK_INPUT: endpoint {
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.43.0
> 

