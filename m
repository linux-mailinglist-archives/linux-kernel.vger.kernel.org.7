Return-Path: <linux-kernel+bounces-847375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92EBCAAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE744220A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA5254876;
	Thu,  9 Oct 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ42X+3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2C221FBB;
	Thu,  9 Oct 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037535; cv=none; b=dDeyOdbqW9nZIRbpm3g7ctYVCt5Lp3KNi3NkHBtqro8k/ktNJz8vS1XAhiqp2+9DLG1q8BIwFn0Ej2brvUuh3Cx9vSnRrr1pyOQuz+MZf5WNh8mjMReoQ7mK7S9L7Y5u0ikOfmtfpA6j013X+pnV8rWXKWniSwJi9OTETrBaSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037535; c=relaxed/simple;
	bh=5S9bfphoMzasXEdo67ITA1E1OFoYoV5XGiFc7X8hHRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLNqvc9qy9w+jAP8SaqR+dz6d038tbC+XZ1VsiZ3WCNn4PcPSg7M0tIvZekvdNKB95/aXXBwmm4kUoUriadD5iutexOfs8fLGOxb4rPmLx57Kes9pvdRBwOjWSfqgGaZqJ2cDGrInEax29G4boDWjwE5Up8i/TlAoe5hqTg7CWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ42X+3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AFAC4CEE7;
	Thu,  9 Oct 2025 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037534;
	bh=5S9bfphoMzasXEdo67ITA1E1OFoYoV5XGiFc7X8hHRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZ42X+3CMN5xZgb0bDD5sfwrOZeVa8UyF2X74qLIO838v6Og6q2vK7y5NXz3Lmut1
	 y2RC21Ev//5o+8rU5eI1iN13QysE+6ZMywpO9GgBIepEcz2vT+kttcAPvvoMANFOYU
	 b1NO+l67TZkgJG+LYDnO9VhJvf7ib8AZYlGKNq31IfBwAjcSvacU3UB7oXno8kiLkC
	 WRQX2V5fFPxLUlCzGZKicibhlbiHGzzryREn/UCxsWRWf+PgLctcx/TgmD44S4VMo5
	 1CAt/V1z//wvdGfxAc1p4SvWZ6+z5UwE9Y7o+KxNH1r0SMxKHbZmEGor1ystI4kTOF
	 zDPhIo0XRPN2A==
Date: Thu, 9 Oct 2025 14:18:52 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v8 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251009191852.GA2947598-robh@kernel.org>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003091158.26748-2-angelogioacchino.delregno@collabora.com>

On Fri, Oct 03, 2025 at 11:11:50AM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
> 
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6316b-regulator.yaml | 80 +++++++++++++++++++
>  .../regulator/mediatek,mt6316c-regulator.yaml | 80 +++++++++++++++++++
>  .../regulator/mediatek,mt6316d-regulator.yaml | 79 ++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
> new file mode 100644
> index 000000000000..53d2c9913e55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6316 BP/VP SPMI PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MediaTek MT6316BP/VP PMICs are fully controlled by SPMI interface, both
> +  feature four step-down DC/DC (buck) converters, and provides 2+2 Phases,
> +  joining Buck 1+2 for the first phase, and Buck 3+4 for the second phase.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6316b-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 0

You don't have any child nodes with addresses. Drop.

> +
> +patternProperties:
> +  "^vbuck(12|34)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
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
> +                when no heavy load is expected, will shut down unnecessary IP
> +                blocks and secondary phases to reduce quiescent current.
> +                This mode does not limit the maximum output current but unless
> +                only a light load is applied, there will be regulation accuracy
> +                and efficiency losses.
> +        maxItems: 3

If you can only specify all the modes, why do you need it? Perhaps you 
want 'minItems: 1' as well?

> +        items:
> +          enum: [ 0, 1, 2 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    spmi {
> +      #address-cells = <2>;
> +      #size-cells = <0>;
> +
> +      pmic@8 {
> +        compatible = "mediatek,mt6316b-regulator";
> +        reg = <0x8 SPMI_USID>;
> +        #address-cells = <0>;
> +
> +        vbuck12 {
> +          regulator-name = "dvdd_core";
> +          regulator-min-microvolt = <450000>;
> +          regulator-max-microvolt = <965000>;
> +          regulator-allowed-modes = <0 1 2>;
> +          regulator-enable-ramp-delay = <256>;
> +        };
> +      };
> +    };
> +...

