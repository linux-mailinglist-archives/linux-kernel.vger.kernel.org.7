Return-Path: <linux-kernel+bounces-735531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2AB0909A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567877B2D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC522F6FBD;
	Thu, 17 Jul 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+vpCkoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3A1DE3C3;
	Thu, 17 Jul 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766189; cv=none; b=MAPF4ud2Exw7ASQ9QZNxtHLL/I70WNQtzhepf8OcHrO+Hr0tOJAENB3fKL51ZwaQTSYAw1sYeCnNsz+Rl8tNBfM6kZO3L69XV+KlSyryEfOqt3dsGPNdT1rVz/t12HeKpjKnHGZzaYwzithqcB5j4oqEzGh6vcClzAfZHmS4mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766189; c=relaxed/simple;
	bh=zra0mOPsZoxJH/aMEjjq48Y9Yq8G2HsxK8xmBukRV7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8DoZ419Ll/4IlaZFnF0E0A6dnIxRJNOVA6q2tvl5Jc6c0eCZYGr7Zmk3nSl4j1KlUbihDUnUf6QlfryY+hX5lQA4uVG7OnLZYEzZYgJmMSmR8fqacqHfDXuMmOuGQGkQ0mPfq7BJ1XCUVAxHYSpdY0KW2Hs4eAh7dtW5tVlDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+vpCkoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58CC4CEE3;
	Thu, 17 Jul 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752766188;
	bh=zra0mOPsZoxJH/aMEjjq48Y9Yq8G2HsxK8xmBukRV7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+vpCkoJt8fqn63OMfp5hFCSoYtWsyejVyxEVKshkUtNxvZVhVWs8xsRMSJlC3r+N
	 eN3QRHhja0DYIjjcM1XLP1iZwqfZhdiZZ/GZCe2uSl/SITUL9L6xmSJpRqfZ2cMRML
	 RCsONJGlK4FBNl/2idXjX8kq4ImPXqF/Vyr6OEWegvH5H9rktaokTJkxPp86nFgRlz
	 ofoo3pJeT5gkjfRJmaqc19pElU3nqmvpcPkgl+VfQs/qroQV0iIdy/xAryjcWhZizi
	 1hunkUiKgU44RH/puTSRtP+7sqvbPyiAquKXwcys3NwSn/mwitUDTs6zFelQfSo845
	 0SV7/3j6Oh/Aw==
Date: Thu, 17 Jul 2025 10:29:47 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v5 3/8] dt-bindings: regulator: Document MediaTek MT6363
 PMIC Regulators
Message-ID: <20250717152947.GA3411864-robh@kernel.org>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
 <20250715140224.206329-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715140224.206329-4-angelogioacchino.delregno@collabora.com>

On Tue, Jul 15, 2025 at 04:02:19PM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6373 PMICs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6363-regulator.yaml  | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
> new file mode 100644
> index 000000000000..ea1f6c92cffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
> @@ -0,0 +1,193 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6363-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6363 PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MT6363 SPMI PMIC provides 10 BUCK and 25 LDO (Low DropOut) regulators
> +  and can optionally provide overcurrent warnings with one ocp interrupt
> +  for each voltage regulator.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6363-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +  vsys-vbuck1-supply:
> +    description: Input supply for vbuck1

blank line

> +  vsys-vbuck2-supply:
> +    description: Input supply for vbuck2

blank line, and so on...

> +  vsys-vbuck3-supply:
> +    description: Input supply for vbuck3
> +  vsys-vbuck4-supply:
> +    description: Input supply for vbuck4
> +  vsys-vbuck5-supply:
> +    description: Input supply for vbuck5
> +  vsys-vbuck6-supply:
> +    description: Input supply for vbuck6
> +  vsys-vbuck7-supply:
> +    description: Input supply for vbuck7
> +  vsys-vs1-supply:
> +    description: Input supply for vs1
> +  vsys-vs2-supply:
> +    description: Input supply for vs2
> +  vsys-vs3-supply:
> +    description: Input supply for vs3
> +  vs1-ldo1-supply:
> +    description: Input supply for va15, vio0p75, vm18, vrf18, vrf-io18
> +  vs1-ldo2-supply:
> +    description: Input supply for vcn15, vio18, vufs18
> +  vs2-ldo1-supply:
> +    description: Input supply for vsram-cpub, vsram-cpum, vrf12, vrf13, vufs12
> +  vs2-ldo2-supply:
> +    description: Input supply for va12-1, va12-2, vcn13, vsram-cpul
> +  vs3-ldo1-supply:
> +    description: Input supply for vsram-apu, vsram-digrf, vsram-mdfe
> +  vs3-ldo2-supply:
> +    description: Input supply for vsram-modem, vrf0p9
> +  vsys-ldo1-supply:
> +    description: Input supply for vaux18, vemc, vtref18
> +
> +patternProperties:
> +  "^v(buck[1-7]|s[1-3])$":
> +    description: Buck regulators
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

Move this after $ref.

> +
> +  "^va(12-1|12-2|15)$":
> +    type: object
> +    $ref: regulator.yaml#
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
> +    unevaluatedProperties: false
> +
> +  "^v(aux|m|rf-io|tref)18$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false
> +
> +  "^v(cn13|cn15|emc)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false
> +
> +  "^vio(0p75|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false
> +
> +  "^vrf(0p9|12|13|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false
> +
> +  "^vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false
> +
> +  "^vufs(12|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        maxItems: 2
> +        items:
> +          enum: [ 0, 2 ]
> +    unevaluatedProperties: false

A lot of duplication here. Either combine the regex's to 1 entry or add 
a $defs entry and make all of these a 1 line $ref.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>

I thought I said this already, but drop the example here. 1 complete 
example in the mfd schema only.

> +
> +    pmic {
> +      interrupt-controller;
> +      #address-cells = <1>;
> +      #interrupt-cells = <3>;
> +
> +      regulators@30 {
> +        compatible = "mediatek,mt6363-regulator";
> +        reg = <0x
> +
> +        vio18 {
> +          regulator-name = "pp1800-vio18-s3";
> +          regulator-min-microvolt = <1800000>;
> +          regulator-max-microvolt = <1800000>;
> +          regulator-allowed-modes = <0 2>;
> +          regulator-allow-set-load;
> +          regulator-over-current-protection;
> +        };
> +      };
> +    };
> +...
> -- 
> 2.50.1
> 

