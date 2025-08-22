Return-Path: <linux-kernel+bounces-782677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91504B32385
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763C11CC36EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EE92D6E4B;
	Fri, 22 Aug 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzO9EgdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32832877CA;
	Fri, 22 Aug 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894018; cv=none; b=aXErY0OPag3ncOXbzA9adXI0PXJ8u4vLWdK14K6lyzUw2E+vgBtzPfohNXbEECucka+wPWAqe+1ods/gFAvhuHEV9/ZwxmNlP6lvDbgMLTn1Ul0LYsmpsDpJjWTdjrsB2vJFeCA5R3OlGkRJm78XBZg26U2u7QSXSEqWvCBdkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894018; c=relaxed/simple;
	bh=tdtNSs8Kpu/sExAf4TXBpIT5C7B1P4VkLkgrDCZvGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXv5THMj+L50p2ZuUFyljeCNDUrRH/D/o8aYvbUmEy5rED4NLwtEq37bZDUMMQacBqgon9XFoMu9PQPJT0PA1Jj1cOKzPHWZew59yTb/TCFtdj64MxfGreCktgcgxdg9+ze48PP7lDGOOI40DyRigqyk8bS2JgkUQHJu/KFv7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzO9EgdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465F5C4CEED;
	Fri, 22 Aug 2025 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755894017;
	bh=tdtNSs8Kpu/sExAf4TXBpIT5C7B1P4VkLkgrDCZvGXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzO9EgdR7yAAuw4MAy6NAMcNJzNOxchSLb3UDks+Vx5t7khko1bBwoZ/Hmcha3ssz
	 k79MgQNMwMESniJJjNMVsXab1fagt/Zhnujwgfprcjsbz9vFPTX5GQRCKq2IpNRXap
	 qw5mPkeerbyapNE6B1EGb+o/IOJQJYILe4/RYgB15qVc9u72TV/X5C4xf6dZ1b6ZL3
	 3it0/Qlz2keHGvwb8gfbXrsHyuAkZViFeamL0PN9tAZqAqk9C383YnnfwhfeI992KG
	 sBg8dhwAUePwlIhTc1eid85HyubEsiiz7yNyDZKt6Ur/KW5Fayyr7DcaP8NluVVLld
	 tNg2tK94rkk5g==
Date: Fri, 22 Aug 2025 15:20:16 -0500
From: Rob Herring <robh@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	shenghao-ding@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com
Subject: Re: [PATCH v2 2/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825
 support
Message-ID: <20250822202016.GA297320-robh@kernel.org>
References: <20250822051410.1732-1-baojun.xu@ti.com>
 <20250822051410.1732-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822051410.1732-2-baojun.xu@ti.com>

On Fri, Aug 22, 2025 at 01:14:09PM +0800, Baojun Xu wrote:
> Update ti,tas2781.yaml for added tas2118, tas2x20, tas5825.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v2:
>  - Update the mail list for maintainers of yaml file
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 73 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> index 5ea1cdc593b5..fb57b63a00a2 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +# Copyright (C) 2022 - 2025 Texas Instruments Incorporated
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
> @@ -11,30 +11,62 @@ maintainers:
>    - Shenghao Ding <shenghao-ding@ti.com>
>  
>  description: |
> +  The TAS2118/TAS2X20 is mono, digital input Class-D audio amplifier
> +  optimized for efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
>    The TAS2563/TAS2781 is a mono, digital input Class-D audio
>    amplifier optimized for efficiently driving high peak power into
>    small loudspeakers. An integrated on-chip DSP supports Texas
>    Instruments Smart Amp speaker protection algorithm. The
>    integrated speaker voltage and current sense provides for real time
>    monitoring of loudspeaker behavior.
> +  The TAS5825 is a stereo, digital input Class-D audio
> +  amplifier optimized for efficiently driving high peak power into
> +  small loudspeakers. An integrated on-chip DSP supports Texas
> +  Instruments Smart Amp speaker protection algorithm. The
> +  integrated speaker voltage and current sense provides for real time
> +  monitoring of loudspeaker behavior.
>  
>    Specifications about the audio amplifier can be found at:
> +    https://www.ti.com/lit/gpn/tas2120
> +    https://www.ti.com/lit/gpn/tas2320
>      https://www.ti.com/lit/gpn/tas2563
>      https://www.ti.com/lit/gpn/tas2781
> +    https://www.ti.com/lit/gpn/tas5825m
>  
>  properties:
>    compatible:
>      description: |
> +      ti,tas2020: 3.2-W Mono Digital Input Class-D Speaker Amp with 5.5V PVDD
> +      Support.
> +
> +      ti,tas2118: 5-W Mono Digital Input Class-D Speaker Amp with Integrated
> +      8.4-V Class-H Boost.
> +
> +      ti,tas2120: 8.2-W Mono Digital Input Class-D Speaker Amp with
> +      Integrated 14.75V Class-H Boost.
> +
> +      ti,tas2320: 15-W Mono Digital Input Class-D Speaker Amp with 15V Support.
> +
>        ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
>        DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
>  
>        ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
>        Protection and Audio Processing, 16/20/24/32bit stereo I2S or
>        multichannel TDM.
> +
> +      ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
> +      to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
>      oneOf:
>        - items:
>            - enum:
> +              - ti,tas2020
> +              - ti,tas2118
> +              - ti,tas2120
> +              - ti,tas2320
>                - ti,tas2563
> +              - ti,tas5825
>            - const: ti,tas2781
>        - enum:
>            - ti,tas2781
> @@ -61,6 +93,27 @@ required:
>  
>  allOf:
>    - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas2020
> +              - ti,tas2118
> +              - ti,tas2120
> +              - ti,tas2320
> +    then:
> +      properties:
> +        reg:
> +          description:
> +            I2C address, in multiple-AMP case, all the i2c address
> +            aggregate as one Audio Device to support multiple audio slots.
> +          maxItems: 4
> +          minItems: 1

1 is already the min items, so drop.

> +          items:
> +            minimum: 0x48
> +            maximum: 0x4b
> +
>    - if:
>        properties:
>          compatible:
> @@ -97,6 +150,24 @@ allOf:
>              minimum: 0x38
>              maximum: 0x3f
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas5825
> +    then:
> +      properties:
> +        reg:
> +          description:
> +            I2C address, in multiple-AMP case, all the i2c address
> +            aggregate as one Audio Device to support multiple audio slots.

You've duplicated this. Does it belong at the top level 'reg'?

> +          maxItems: 4
> +          minItems: 1

Same here.

> +          items:
> +            minimum: 0x4c
> +            maximum: 0x4f
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.43.0
> 

