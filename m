Return-Path: <linux-kernel+bounces-847982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A0BBCC34F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4974D3AB9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB6238171;
	Fri, 10 Oct 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huZb1Q+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E8128819;
	Fri, 10 Oct 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085971; cv=none; b=C4syBYh/5dqoeWkyEH7DClELMz9hwcW00nw/MiN5/s1Lg254p9+lzn7MNAB2RmnO4SSl630HWDT8TLT7u8fK9rbINYP3KTgxp+AgHX4vFOr+oCq+ZuqoSg/xd7+smPaxqZ3FdHYHE+Iw4Fow6zDnCz+t0jaOc7ZgeeJLXgAM3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085971; c=relaxed/simple;
	bh=M6eSdjEFBD7VluyYnVI3HMD1mINHGIc5jnBWHxpNf38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjZ7Lq+YxvE9lJMCOb1ubJ6E+pwzusxiWVvGRmQ6lPjOoynDWFk+LaSZnAGaQ3b0xrE5m+5fKyj8eJh7S5m0P/Gq/KOZuNf8IBQ5mXML7QchcceXJzcTJlYZfUc27akmXJXm1IX1oyojYg9DCxMvTVcx9sqviCpmClCPFI2Oic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huZb1Q+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD3BC4CEF1;
	Fri, 10 Oct 2025 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760085969;
	bh=M6eSdjEFBD7VluyYnVI3HMD1mINHGIc5jnBWHxpNf38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=huZb1Q+QKFYwKId9WLFNcv69iOBMyGPI2Rb1Grc2RAyLfY1PMc423ojCXsNvOpaqB
	 V11c/cm/eLWDViEmNs0faO1c95UqAzX2OLIF/RRCc53czD/TU9YmAORpdaPCJ2pQKc
	 Z+aPbl37U3wHge5NzCCjCFchbsNePDoXnjjR+41OVZOxFi4VjVVY+P8Swonkv6+OIu
	 IBCoZ//hO8PlUkmu0S3jDB77VqltIbtFkwSHe38+vqcwCtIdchS5xm2QTmx81OkzAU
	 BeBQwaYCrIAF7SmlSVvniS38n889S/2c4xqqV8IwBSkIrNjAVNty0B23TCVkrqyG8x
	 W+N82lIttBOvA==
Message-ID: <414c16db-cdd1-433d-b0ae-915e11d964f0@kernel.org>
Date: Fri, 10 Oct 2025 10:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: mtd: sunxi: Add new compatible
To: Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-3-richard.genoud@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251010084042.341224-3-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2025 10:40, Richard Genoud wrote:
> The H616 NAND controller is quite different from the A10 and A23 ones,
> some registers offset changed, and some new one are introduced.
> Also, the DMA handling is different (it uses chained descriptors)
> 


Subject: not new compatible, but "H616" or whatever device is called.
Otherwise every commit would be called like that making git log
--oneline useless.

> So, introduce a new compatible to represent this version of the IP.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../mtd/allwinner,sun4i-a10-nand.yaml         | 56 ++++++++++++++-----
>  1 file changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> index 054b6b8bf9b9..cc63091fe936 100644
> --- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> @@ -6,34 +6,64 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Allwinner A10 NAND Controller
>  
> -allOf:
> -  - $ref: nand-controller.yaml
> -
>  maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Maxime Ripard <mripard@kernel.org>
>  
> +allOf:
> +  - $ref: nand-controller.yaml


If moving it, can you place it like in example-schema, so at the bottom,
above unevaluatedProps?

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun4i-a10-nand
> +              - allwinner,sun8i-a23-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock
> +            - description: Module Clock
> +        clock-names:
> +          items:
> +            - const: ahb
> +            - const: mod
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun50i-h616-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus Clock
> +            - description: Module Clock
> +            - description: ECC Clock
> +            - description: MBus Clock
> +        clock-names:
> +          items:
> +            - const: ahb
> +            - const: mod
> +            - const: ecc
> +            - const: mbus
> +
>  properties:
>    compatible:
>      enum:
>        - allwinner,sun4i-a10-nand
>        - allwinner,sun8i-a23-nand-controller
> +      - allwinner,sun50i-h616-nand-controller
>    reg:
>      maxItems: 1
>  
>    interrupts:
>      maxItems: 1
>  
> -  clocks:
> -    items:
> -      - description: Bus Clock
> -      - description: Module Clock
> -
> -  clock-names:
> -    items:
> -      - const: ahb
> -      - const: mod


You cannot remove it. Broadest constraints, see writing schema.

or my standard reference example:
https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127


Best regards,
Krzysztof

