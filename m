Return-Path: <linux-kernel+bounces-758474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C35B1CFA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF1E3AD484
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F04B4C6E;
	Thu,  7 Aug 2025 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW6Y1ix6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796B38B;
	Thu,  7 Aug 2025 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525037; cv=none; b=KI15ta3UKEM/Tiby/QHvJ9EE60QNXgNJ5hEHsRUa25MNrSxKVFJOBB1T1mvZ+Tfa1TJZL+J6+ldY/9Ayk/nxs4TugHFt1yikif8tJbjTb+sNf0Fo6JyESXNfZlTmUhHkFptNXahsmBNa/5atf95UQcoAUXzuI1IdGs/+u3/sApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525037; c=relaxed/simple;
	bh=Mo5zZx6+Ls09o6HSEjQ6aurVFAO/GmKzPOOACnlaro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=femVmVyVPChfMf3Dv2ioJqMa8XbErCIg47KtPoZUucLR56lCLQUhK7hAi8MKT8Kbu6h5EAqXKlspPlvf4xKtniVnjEAY753piU1F6kwE9KYvHuODzALRcmFMsU9bJoF+VVjXq/BKzWoUxrNcCs+mTBB5Uh7zb1LMM14H7EST87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW6Y1ix6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B110C4CEE7;
	Thu,  7 Aug 2025 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754525037;
	bh=Mo5zZx6+Ls09o6HSEjQ6aurVFAO/GmKzPOOACnlaro4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XW6Y1ix6oPV0ctapSPBEJFFdUM6EWr6QHnqe10meQ90DcEhnSKyu4lM0rSDMLJwrA
	 AxJXWiVvHEHxxoRho/xDcchl12cFK/y3kSEvrfROiC2uVgMbzdnBwivClPcX+HtJJx
	 WYK47ohKJv4IUvoFy4UJmaxsWsRG3cnYxT5v5DzRyBPxXYDdPkDnKF8dWBw+wzefJT
	 p81ZMy0MlVZqkq5aPbWL6E9ADfUEAiRW9qt8ad1X99W8tm9upYqSwWPa91KqSfFV4i
	 WAhdSdBppef0yuPr+jj3jMIE/N9ujTk0dTN2oN8fEZwj4/Lpsw1QCcq3u5p4vROp8+
	 xPptFRmbnVOpw==
Date: Wed, 6 Aug 2025 19:03:56 -0500
From: Rob Herring <robh@kernel.org>
To: Mahdi Khosravi <mmk1776@gmail.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: realtek,alc5623: convert to DT
 schema
Message-ID: <20250807000356.GA2072715-robh@kernel.org>
References: <20250806131818.38278-1-mmk1776@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806131818.38278-1-mmk1776@gmail.com>

On Wed, Aug 06, 2025 at 04:18:18PM +0300, Mahdi Khosravi wrote:
> I converted the alc5623 audio codec binding from text to DT schema.

Convert the alc5623...

> This is my first try and I used make dt_binding_check & make dtbs_check to verify
> without getting any errors.

Drop this. Passing is assumed. Actually, 'make dtbs_check' warnings are 
fine if you think the .dts has a mistake.

> 
> Signed-off-by: Mahdi Khosravi <mmk1776@gmail.com>
> ---
> Changes in v3:
> - Drop allOf, just use $ref for uint32
> - Remove stray '>' in descriptions
> - Fix subject to "to DT schema"
> 
> Changes in v2:
> - Add dai-common ref
> - Switch add-ctrl/jack-det-ctrl to allOf uint32
> - Use unevaluatedProperties
> - Fix example compatible
> ---
>  .../devicetree/bindings/sound/alc5623.txt     | 25 ---------
>  .../bindings/sound/realtek,alc5623.yaml       | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
> deleted file mode 100644
> index 26c86c98d671..000000000000
> --- a/Documentation/devicetree/bindings/sound/alc5623.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -ALC5621/ALC5622/ALC5623 audio Codec
> -
> -Required properties:
> -
> - - compatible:	"realtek,alc5623"
> - - reg:		the I2C address of the device.
> -
> -Optional properties:
> -
> - - add-ctrl:	  Default register value for Reg-40h, Additional Control
> -		  Register. If absent or has the value of 0, the
> -		  register is untouched.
> -
> - - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
> -		  Control Register. If absent or has value 0, the
> -		  register is untouched.
> -
> -Example:
> -
> -	alc5621: alc5621@1a {
> -		compatible = "alc5621";
> -		reg = <0x1a>;
> -		add-ctrl = <0x3700>;
> -		jack-det-ctrl = <0x4810>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
> new file mode 100644
> index 000000000000..2a389ca95b0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ALC5621/ALC5622/ALC5623 Audio Codec
> +
> +maintainers:
> +  - Mahdi Khosravi <mmk1776@gmail.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: realtek,alc5623

What about alc5621/22? At least 21 is in use:

arch/arm/boot/dts/marvell/kirkwood-t5325.dts:                           compatible = "realtek,alc5621";

> +
> +  reg:
> +    maxItems: 1
> +
> +  add-ctrl:
> +    description:
> +      Default register value for Reg-40h, Additional Control Register.
> +      If absent or zero, the register is left untouched.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  jack-det-ctrl:
> +    description:
> +      Default register value for Reg-5Ah, Jack Detect Control Register.
> +      If absent or zero, the register is left untouched.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        codec@1a {
> +            compatible = "realtek,alc5623";
> +            reg = <0x1a>;
> +            add-ctrl = <0x3700>;
> +            jack-det-ctrl = <0x4810>;
> +        };
> +    };
> -- 
> 2.50.1
> 

