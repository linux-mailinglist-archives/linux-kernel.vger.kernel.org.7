Return-Path: <linux-kernel+bounces-750262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED6B15943
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14C94E81DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C11F63CD;
	Wed, 30 Jul 2025 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH2PE5j7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BAE55B;
	Wed, 30 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859160; cv=none; b=K7jg5dr8szSRn+tDEiCiLtc84enDeKM7ient+sKip7GP4liX2AXvGhdABwI4FMt/F1bAKu1vj/5CETOct/BpMv8094632trvIiiJtEA/iWowrgu2Vuf1RNp83L0p5+Voln+71Si0bK43alY8UF29RxXQuDv/wd+NwAypSY/QWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859160; c=relaxed/simple;
	bh=A2mlfbNrB71eIpXbDCYMDyraLJzE4wkjolpqa+Ojhr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbAj3U5YAqPH6ZmEpV6v2ufHIm7NR6U6S9c738BFVjUsMT5L/lpNkUzVttwyAy2qxnwiw0AYbzr0FMT1wufpAlBG5ZVQ7G7Qvs4n5leqhrdlp+SZOekVDDAk3osnHjctH5k6r0cV9aZFB+lr3A/7ZMggwKQkDRmPYRlMGT7TAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH2PE5j7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C0C4CEE7;
	Wed, 30 Jul 2025 07:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753859159;
	bh=A2mlfbNrB71eIpXbDCYMDyraLJzE4wkjolpqa+Ojhr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH2PE5j7oPam6lUWMZD2p/UexAxTItW39O5xw/PTELUxZzWtcDpdn5DfnfOXStS0q
	 xR3KKmfX2O5CiqhowuuYzEu2DogwTf5BkQHPb0Ry4887tB3iKxDTyvLRSi5r2ke4Qm
	 wsw15GaaHa8iB71ZvI4Gkc4sswhrmvBQrgIH75TnhA6mdCNC/+37L2C+laQIueAEDn
	 Rzhnd0vF5eudyKCpaLPPTbWr2yfLhFiWEJu618LyvTSk1lJGYfwl5JRShiw1lKCxSg
	 rSU2jZ8MTY9epOH4z9d/sw5pxxMJ584Cu5iTV4iuY6cS8+BRS3nkZKoEVNo+MDYbip
	 vaNjRcV9neWeg==
Date: Wed, 30 Jul 2025 09:05:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xukai Wang <kingxukai@zohomail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
Message-ID: <20250730-cobalt-salmon-of-charisma-aea028@kuoka>
References: <20250730-b4-k230-clk-v7-0-c57d3bb593d3@zohomail.com>
 <20250730-b4-k230-clk-v7-1-c57d3bb593d3@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730-b4-k230-clk-v7-1-c57d3bb593d3@zohomail.com>

On Wed, Jul 30, 2025 at 02:43:51AM +0800, Xukai Wang wrote:
> This patch adds the Device Tree binding for the clock controller
> on Canaan k230. The binding defines the clocks and the required
> properties to configure them correctly.
> 
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  .../devicetree/bindings/clock/canaan,k230-clk.yaml |  61 ++++++
>  include/dt-bindings/clock/canaan,k230-clk.h        | 223 +++++++++++++++++++++
>  2 files changed, 284 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f2aa509b12bce1a69679f6d7e2853273233266d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Canaan Kendryte K230 Clock
> +
> +maintainers:
> +  - Xukai Wang <kingxukai@zohomail.com>
> +
> +description:
> +  The Canaan K230 clock controller generates various clocks for SoC
> +  peripherals. See include/dt-bindings/clock/canaan,k230-clk.h for
> +  valid clock IDs.
> +
> +properties:
> +  compatible:
> +    const: canaan,k230-clk
> +
> +  reg:
> +    items:
> +      - description: PLL control registers
> +      - description: Sysclk control registers
> +
> +  clocks:
> +    minItems: 1

No, drop. Hardware is not flexible.

> +    items:
> +      - description: Main external reference clock
> +      - description:
> +          External clock which used as the pulse input
> +          for the timer to provide timing signals.

So what is the difference that you removed my Rb? Only this? I do not
see any differences (and don't tell me, you claim some random indice
numbers as change DT maintainer would need to re-review...)

> +
> +  clock-names:
> +    minItems: 1

No, drop. Hardware is not flexible.

> +    items:
> +      - const: osc24m
> +      - const: timer-pulse-in
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@91102000 {
> +        compatible = "canaan,k230-clk";
> +        reg = <0x91102000 0x40>,
> +              <0x91100000 0x108>;
> +        clocks = <&osc24m>;
> +        clock-names = "osc24m";

Incomplete. Post complete hardware.

> +        #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/canaan,k230-clk.h b/include/dt-bindings/clock/canaan,k230-clk.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..9eee9440a4f14583eac845b649e5685d623132e1
> --- /dev/null
> +++ b/include/dt-bindings/clock/canaan,k230-clk.h
> @@ -0,0 +1,223 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Kendryte Canaan K230 Clock Drivers
> + *
> + * Author: Xukai Wang <kingxukai@zohomail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_CANAAN_K230_CLOCK_H__
> +#define __DT_BINDINGS_CANAAN_K230_CLOCK_H__
> +
> +/* Kendryte K230 SoC clock identifiers (arbitrary values) */

Drop comment, redundant and obvious.

Best regards,
Krzysztof


