Return-Path: <linux-kernel+bounces-792224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD70B3C19C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701F17AB557
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973E221D9E;
	Fri, 29 Aug 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twPkUgMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A37201033;
	Fri, 29 Aug 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487786; cv=none; b=MKd48sNbZEjMyIuS9RwP/uTE6oL+OLwaVJlHkjMm4SMISR/qxVBD13CHstGO5rpxJwThS/QCAtYkP414CdwP2zoWjM1eoIEGhDLDw4Bs6Gw5afBKC0PpZddjTWP2Q5hrDGG769rUQgTxXgN51CjQ5JKU3FSnn3CkGRBu3KsY7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487786; c=relaxed/simple;
	bh=NkhK1p1B1g1OXGW0TTzXh6oyW/wktWgGjhNbONvL0ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtV85PcXD841ZOAkIAUB/FWThzMIOcGCCysRiyvde1nbEDa/rJzdau17xPfZmW3yMmViBnXN4ITe5KEGS28+TGRCoHOJ5/01d0BIvdS6vj4b9baAvGa+60N5LXZ4ZUHnluqjtW1KO3CZqKluZq2reI8Rda4gBplPyzAUbNuCb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twPkUgMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A922CC4CEF0;
	Fri, 29 Aug 2025 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756487785;
	bh=NkhK1p1B1g1OXGW0TTzXh6oyW/wktWgGjhNbONvL0ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twPkUgMzYYFnifeH0CQK/tHCLW6lk1U1XRUws/fir+jyChH6lqXpyktSXxOv9sxn8
	 CjYB6J6MZH3EsmaYoFoVW9htpqd19gu+ASZf5z50X5ijZmZRSTAdRhIVlx7RIp8tmN
	 o1ne/W8BHqaIt0iRW/N2SjxWN4cZWxG551XhcMEovc9Tq5uuSt4ffW1/Q2GJUutbdy
	 kmY/lSfnboTVWwYEPKKaW6mPhjEfdDcGSjpaqAGAubhdREneQAd7QE089bLIDEsT58
	 nQoA3lQrla9HclE+k2HS91G3KgnVnsNzB4IE6aMxuQUVKkk/YXJ+t5f9D2GT4iV0wB
	 zueFmj8PqFRNg==
Date: Fri, 29 Aug 2025 12:16:24 -0500
From: Rob Herring <robh@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Message-ID: <20250829171624.GA1027608-robh@kernel.org>
References: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
 <20250828-k1-i2s-v2-1-09e7b40f002c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-k1-i2s-v2-1-09e7b40f002c@linux.spacemit.com>

On Thu, Aug 28, 2025 at 11:37:32AM +0800, Troy Mitchell wrote:
> Add dt-binding for the i2s driver of SpacemiT's K1 SoC.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..042001c38ed8d434889183831e44289ea9c5aef2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/spacemit,k1-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: K1 I2S controller
> +
> +description:
> +  The I2S bus (Inter-IC sound bus) is a serial link for digital
> +  audio data transfer between devices in the system.
> +
> +maintainers:
> +  - Troy Mitchell <troy.mitchell@linux.spacemit.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for I2S sysclk
> +      - description: clock for I2S bclk
> +      - description: clock for I2S bus
> +      - description: clock for I2S controller
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: bclk
> +      - const: bus
> +      - const: func
> +
> +  dmas:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-names:
> +    oneOf:
> +      - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx

If tx is optional, wouldn't this be simpler:

minItems: 1
items:
  - const: rx
  - const: tx


> +
> +  resets:
> +    maxItems: 1
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - resets
> +  - "#sound-dai-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    i2s@d4026000 {
> +      compatible = "spacemit,k1-i2s";
> +      reg = <0xd4026000 0x30>;
> +      clocks = <&syscon_mpmu CLK_I2S_SYSCLK>,
> +               <&syscon_mpmu CLK_I2S_BCLK>,
> +               <&syscon_apbc CLK_SSPA0_BUS>,
> +               <&syscon_apbc CLK_SSPA0>;
> +      clock-names = "sysclk", "bclk", "bus", "func";
> +      dmas = <&pdma0 21>, <&pdma0 22>;
> +      dma-names = "tx", "rx";
> +      resets = <&syscon_apbc RESET_SSPA0>;
> +      #sound-dai-cells = <0>;
> +    };
> 
> -- 
> 2.50.1
> 

