Return-Path: <linux-kernel+bounces-839253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B007CBB12E6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21563194690C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7F280CFC;
	Wed,  1 Oct 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3+mU6nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB931459FA;
	Wed,  1 Oct 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333984; cv=none; b=bORrBe5RqxbjPal2gW1dJeY/M+yO/bkapPiLAJ77KdumcRBTi0yWvWHTz12m+ZlB2BHU2TzX7t1uo6XMPRweOQNZqPOUgCbxWGxxYWysM06ByTa6mymySxg8rgycsoHuWXGijlrYi3iaqkb69kGe3DuVL0h6Zk1poYW9bQFGf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333984; c=relaxed/simple;
	bh=DjuGPx4lmyMkVyS6r4VoNhtpl4NSxnxakDdhPxw6lGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYSuzBWsHj3OAwCAQ2fzbnur8UIhofyhZHBpUmglVKCeYqmefuryeD6PP2bePgK4abT3bx4KRGAr4JKdPN1G0+YctzqDMk7RVymUp7/JEip5Fx8rp46MRppjDDOFaKYtfHf49u4zuU2ZBCDKtXwelMvGEwYdCV/q7qG+4TU8zJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3+mU6nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B159C4CEF1;
	Wed,  1 Oct 2025 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333983;
	bh=DjuGPx4lmyMkVyS6r4VoNhtpl4NSxnxakDdhPxw6lGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3+mU6nvpdldLN08Oog06QiM2auN7sYsh7ZeCc9J2taw9fN3997XrpmTLYMQdONpW
	 FcCxYFe3FAxGYbin94CIlDWBkzyARwf+JB+x0BUbEHaMNj8Ny1xWA0hBJDgmp0nEjz
	 f4/O+pR7TAjoIezCCadm/A+OoRk06EsAwNDTcv9Jb11PPxC8uY/FdlJ0gUUCpCmGtA
	 RWlWQ5BNGLd2Hr3EhBvGSXmYXwl5m9AEN3fr0FRoRFGYXbAnPrN9gE2pZXnIevi/es
	 GzheLjsB8KCT65YK+fz0cqagDWVcjpv9j00HXpqb0fgdz+81uJM68xq7OFAkVttcRK
	 f77/9TrGSWu0Q==
Date: Wed, 1 Oct 2025 10:53:00 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v6 5/9] dt-bindings: regulator: Document MediaTek MT6373
 PMIC Regulators
Message-ID: <20251001155300.GC1833526-robh@kernel.org>
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001111316.31828-6-angelogioacchino.delregno@collabora.com>

On Wed, Oct 01, 2025 at 01:13:12PM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6363 PMICs.
> 
> Link: https://lore.kernel.org/r/20250715140224.206329-6-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6373-regulator.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
> new file mode 100644
> index 000000000000..cb721d81b77c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6373-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6373 PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MT6373 SPMI PMIC provides 10 BUCK and 23 LDO (Low DropOut) regulators
> +  and can optionally provide overcurrent warnings with one ocp interrupt
> +  for each voltage regulator.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6373-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +  vsys-vbuck0-supply:
> +    description: Input supply for vbuck0
> +
> +  vsys-vbuck1-supply:
> +    description: Input supply for vbuck1
> +
> +  vsys-vbuck2-supply:
> +    description: Input supply for vbuck2
> +
> +  vsys-vbuck3-supply:
> +    description: Input supply for vbuck3
> +
> +  vsys-vbuck4-supply:
> +    description: Input supply for vbuck4
> +
> +  vsys-vbuck5-supply:
> +    description: Input supply for vbuck5
> +
> +  vsys-vbuck6-supply:
> +    description: Input supply for vbuck6
> +
> +  vsys-vbuck7-supply:
> +    description: Input supply for vbuck7
> +
> +  vsys-vbuck8-supply:
> +    description: Input supply for vbuck8
> +
> +  vsys-vbuck9-supply:
> +    description: Input supply for vbuck9
> +
> +  vs1-ldo1-supply:
> +    description: Input supply for vant18, vaud18, vcn18io
> +
> +  vs2-ldo1-supply:
> +    description: Input supply for vrf12-aif, vrf13-aif
> +
> +  vs3-ldo1-supply:
> +    description: Input supply for vrf09-aif, vsram-digrf-aif
> +
> +  vsys-ldo1-supply:
> +    description: Input supply for vcn33-1, vcn33-2, vmc
> +
> +  vsys-ldo2-supply:
> +    description:
> +      Input supply for vaux18, vcn33-3, vefuse, vfp, vibr, vio28, vtp, vusb
> +
> +  vsys-ldo3-supply:
> +    description: Input supply for vmch, vmch-eint-high/low
> +
> +patternProperties:
> +  "^v(ant|aud|aux)18$":
> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
> +
> +  "^vbuck([0-9])$":

Don't need ().

> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        description: |
> +          Allowed Buck regulator operating modes allowed. Valid values below.
> +            0 - Normal mode with automatic power saving, reducing the switching
> +                frequency when light load conditions are detected
> +            1 - Forced Continuous Conduction mode (FCCM) for improved voltage
> +                regulation accuracy with constant switching frequency but lower
> +                regulator efficiency
> +            2 - Forced Low Power mode for improved regulator efficiency, used
> +                when no heavy load is expected, does not limit the maximum out
> +                current but unless only a light load is applied, there will be
> +                regulation accuracy and efficiency losses.
> +            3 - Forced Ultra Low Power mode for ultra low load, this greatly
> +                reduces the maximum output power, makes the regulator to be
> +                efficient only for ultra light load, and greatly reduces the
> +                quiescent current (Iq) of the buck.
> +        maxItems: 3
> +        items:
> +          enum: [ 0, 1, 2, 3 ]
> +    unevaluatedProperties: false
> +
> +  "^v(cn18io|cn33-[123]|efuse|fp|tp|ibr|io28|sram-digrf-aif|usb)":

Missing '$' anchor.

> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
> +
> +  "^vmc(h)?$":

Don't need ().

> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
> +
> +  "^vmch-eint-(low|high)?$":

vmch-eint- is a valid name?

> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
> +
> +  "^vrf(09|12|13|18|io18)-aif$":
> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
> +
> +$defs:
> +  mediatek-mt6373-ldo-common:

The name is local to the schema, so 'ldo-common' would be sufficient.

> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      regulator-allowed-modes:
> +        description: |
> +          Allowed LDO regulator operating modes allowed. Valid values below.
> +            0 - Normal mode with automatic power saving, reducing the switching
> +                frequency when light load conditions are detected
> +            2 - Forced Low Power mode for improved regulator efficiency, used
> +                when no heavy load is expected, does not limit the maximum out
> +                current but unless only a light load is applied, there will be
> +                regulation accuracy and efficiency losses.
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> -- 
> 2.51.0
> 

