Return-Path: <linux-kernel+bounces-869571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89290C08303
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316E91C2039C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B41309DCF;
	Fri, 24 Oct 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBQW66xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D475809;
	Fri, 24 Oct 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341469; cv=none; b=W1ZyvDnsTOfqmmTMQ5z60I4FSmsCjKwFpw0Y0452CxcgDXmGf6MCf4EZLQNScL+R5cAo7E1VnfyIsmWdbig52omklpYPKLM5z/2Pj2XT29MkCiL+U7PykNH5LF/X/ewj63MY95ts7y9Q3yYVxpkEXRJkRhF1bSIkHLfvil6cAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341469; c=relaxed/simple;
	bh=iQDu9KC5sD+ItNRHrzjtO65uP6xTrysOY0tRBMoc5s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIlxtt8Nio1LMVoUqSIRxxNPVWPZRf1zCLfOQSmwdkI9FypvMxYUL47g80zXJ33Cni9cl4MoJlYf5GykSIrC1DpCrpFH15x5Ke6Y559GwMhY8rxa7dlAARWawXL9esKHCDEYEnLCxwHSEL6GkkTs4cdwm2qcDVyOntQe8Iw0B8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBQW66xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB3C4CEF1;
	Fri, 24 Oct 2025 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761341469;
	bh=iQDu9KC5sD+ItNRHrzjtO65uP6xTrysOY0tRBMoc5s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBQW66xdqKosVkU7SxiZ/0PMK9kQ1KfHPoux3oR0xLniv5aHATn7er+ChFSESMRpf
	 a+UjF561m9EJ4I2ham1n8ym+q6h7hH8wUaWE7vNbrtntjsZyVzjtalCtASGhG3YzUG
	 /7kwCEL9EAu6+J+AdCsulpZOJXEBfrd79jAkyG9Wkyl70g7t1TLDuY5rOorsRk60oe
	 GU8DcBuI0tR1o622yUvoO9B+XKjIS4RzxCyhtdSk7BBGD90cN/yRyLRfn8Q5iEcCy7
	 UkbKIESPHEI1yVPM1S7FexBpvJHHMgXA7kumrOibBwyp62ejofMaXFJj5SAHT7AiPg
	 oIMFloq7wfaKw==
Date: Fri, 24 Oct 2025 16:31:07 -0500
From: Rob Herring <robh@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] dt_bindings: sound: ti,pcm186x: convert to dtschema
Message-ID: <20251024213107.GA2841379-robh@kernel.org>
References: <20251021-dtbs-v1-1-493c1aa253bc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021-dtbs-v1-1-493c1aa253bc@gmail.com>

On Tue, Oct 21, 2025 at 08:33:40PM +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings to DT schema.

Your patch fails to apply with "b4 am" due to the following:

WARNING: Message contains suspicious unicode control characters!                                         
         Subject: [PATCH] dt_bindings: sound: ti,pcm186x: convert to dtschema
            Line: +﻿# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause          
            -------^                                                                                       
            Char: ZERO WIDTH NO-BREAK SPACE (0xfeff)                                                       
         If you are sure about this, rerun with the right flag to allow.

Please fix and resend. Some comments below.

> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
> ---
>  .../devicetree/bindings/sound/pcm186x.txt          | 42 --------------
>  .../devicetree/bindings/sound/ti,pcm186x.yaml      | 67 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
> deleted file mode 100644
> index 1087f4855980..000000000000
> --- a/Documentation/devicetree/bindings/sound/pcm186x.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Texas Instruments PCM186x Universal Audio ADC
> -
> -These devices support both I2C and SPI (configured with pin strapping
> -on the board).
> -
> -Required properties:
> -
> - - compatible : "ti,pcm1862",
> -                "ti,pcm1863",
> -                "ti,pcm1864",
> -                "ti,pcm1865"
> -
> - - reg : The I2C address of the device for I2C, the chip select
> -         number for SPI.
> -
> - - avdd-supply: Analog core power supply (3.3v)
> - - dvdd-supply: Digital core power supply
> - - iovdd-supply: Digital IO power supply
> -        See regulator/regulator.txt for more information
> -
> -CODEC input pins:
> - * VINL1
> - * VINR1
> - * VINL2
> - * VINR2
> - * VINL3
> - * VINR3
> - * VINL4
> - * VINR4
> -
> -The pins can be used in referring sound node's audio-routing property.
> -
> -Example:
> -
> -	pcm186x: audio-codec@4a {
> -		compatible = "ti,pcm1865";
> -		reg = <0x4a>;
> -
> -		avdd-supply = <&reg_3v3_analog>;
> -		dvdd-supply = <&reg_3v3>;
> -		iovdd-supply = <&reg_1v8>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
> new file mode 100644
> index 000000000000..f1ade490f688
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
> @@ -0,0 +1,67 @@
> +﻿# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments PCM186x Universal Audio ADC
> +
> +maintainers:
> +  - Ranganath V N <vnranganath.20@gmail.com>
> +
> +description: |

Don't need '|' unless there is formatting.

> +  The Texas Instruments PCM186x family are multi-channel audio ADCs
> +  that support both I2C and SPI control interfaces, selected by
> +  pin strapping. These devices include on-chip programmable gain
> +  amplifiers and support differential or single-ended analog inputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,pcm1862
> +      - ti,pcm1863
> +      - ti,pcm1864
> +      - ti,pcm1865
> +    description:
> +      Must be one of the supported PCM186x models.

Drop the description.

> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      For I2C, this is the 7-bit slave address of the device.
> +      For SPI, this is the chip-select number.

That's true for every I2C or SPI device. Drop.

> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  iovdd-supply: true
> +
> +  '#sound-dai-cells':
> +    const: 0
> +    description: Number of cells used to identify a DAI endpoint (fixed to 0).

That's true for every DAI and stated by the constraints already. Drop.

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +  - iovdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pcm186x: audio-codec@4a {

Drop unused labels.

> +            compatible = "ti,pcm1865";
> +            reg = <0x4a>;
> +
> +            avdd-supply = <&reg_3v3_analog>;
> +            dvdd-supply = <&reg_3v3>;
> +            iovdd-supply = <&reg_1v8>;
> +        };
> +    };
> 
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-dtbs-3a31f699c461
> 
> Best regards,
> -- 
> Ranganath V N <vnranganath.20@gmail.com>
> 

