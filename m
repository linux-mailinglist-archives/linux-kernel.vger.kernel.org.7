Return-Path: <linux-kernel+bounces-847382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB97BCAAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FC724E965A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36729258EE2;
	Thu,  9 Oct 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3gSE+wC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA425785A;
	Thu,  9 Oct 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037877; cv=none; b=o1kZtz3kniQwdofEHmf9yMEUHqfhgKD+CqCmiQJFyx0ElVZjdc+s5FeB3ecjIqMjzz9Q3D3fL/VS7zDoJE1lz2ciwiMXyyoEWXpW2ZCau9qQLdSIeGQJFoO4unmV+Etwny5Uf05BVt5xEf3QBa1qNjGDlVF9taYSa7J3LwM+OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037877; c=relaxed/simple;
	bh=U/k071RZERcM5Px1aM2dRrdqdukKiKlQVt6cFVVyxFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RikKJxtPbP8ji5Lhw17mTfncwSN37dYpSO2LKJXKpyWoYEDApfomXHfymGy7XOxHxyL2lAoS8eq7qCGK+uE4uj95Ns5emGMzy/fqaf+2aGj6QEXgWLllCob4lzvP9CBiQY+b4UFRv22mZkxENjNBFfmFUClsW77/Zs53B9Z5oyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3gSE+wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE64C4CEE7;
	Thu,  9 Oct 2025 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037877;
	bh=U/k071RZERcM5Px1aM2dRrdqdukKiKlQVt6cFVVyxFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3gSE+wC7q/UPX+C26S+saeRy+b/cA7oBBo8gJbHrlCqWc/8zKCSPNAnHfwUY+jx8
	 HaFWEyCIvW/YHi/ZWlCzWs0b6sGbCL0bsHF4zcCeeEmtZuUMh5iy+OzE7YwljW2nwX
	 4LDWhdhzQr14IUvJ64H0mr3By9JA9mRyM5wmpKut/vjqgJbiYF+ks8G2b7FfmXzJbX
	 jnPPq0OuqpNr/eMvCwbqJC8cNFNpPuhnw0IW7Y+1tCWiZFB8hJH4HrR41iBsxP824d
	 RWtbjGTm1sssRS8J3HfZzW2oS5IoeFpY/RhdaWC5Jyj5WPFyV2416ytWJbxsMILVkK
	 vTfrBe6IS6FWw==
Date: Thu, 9 Oct 2025 14:24:35 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v8 8/9] dt-bindings: mfd: Add binding for MediaTek MT6363
 series SPMI PMIC
Message-ID: <20251009192435.GA3128253-robh@kernel.org>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-9-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003091158.26748-9-angelogioacchino.delregno@collabora.com>

On Fri, Oct 03, 2025 at 11:11:57AM +0200, AngeloGioacchino Del Regno wrote:
> Add a binding for the MediaTek MT6363/6373 (and similar) multi
> function PMICs connected over SPMI.
> 
> These PMICs are found on board designs using newer MediaTek SoCs,
> such as the Dimensity 9400 Smartphone chip, or the Chromebook
> MT8196 chip.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6363.yaml         | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> new file mode 100644
> index 000000000000..8cfb2e9a9389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6363 series SPMI PMICs multi-function device
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description: |
> +  Some MediaTek Power Management ICs (PMICs) found in board designs with
> +  the Helio, Dimensity and/or Kompanio series of SoCs are interfaced to
> +  the chip via the System Power Management Interface (SPMI) bus.
> +
> +  These PMICs are multi-function devices with various sub modules.
> +  For example, those may include one, or more of the following:
> +  - Auxiliary ADC Controller
> +  - Clock Controller
> +  - eFuses
> +  - GPIO Controller
> +  - Interrupt Controller
> +  - Keys
> +  - LEDs Controller
> +  - Regulators
> +  - RTC
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6363
> +      - mediatek,mt6373
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 3
> +
> +patternProperties:
> +  "^adc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> +
> +  "^regulators@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +            - mediatek,mt6363-regulator
> +            - mediatek,mt6373-regulator

You can drop properties here. 'compatible' will be covered by the 
referenced schemas.

> +    oneOf:
> +      - $ref: /schemas/regulator/mediatek,mt6363-regulator.yaml#
> +      - $ref: /schemas/regulator/mediatek,mt6373-regulator.yaml#
> +    additionalProperties: true

And this can be dropped.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    spmi {
> +      #address-cells = <2>;
> +      #size-cells = <0>;
> +
> +      pmic@4 {
> +        compatible = "mediatek,mt6363";
> +        reg = <0x4 SPMI_USID>;
> +        interrupts = <4 64 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #address-cells = <1>;
> +        #interrupt-cells = <3>;
> +        #size-cells = <0>;
> +
> +        regulators@30 {
> +          compatible = "mediatek,mt6363-regulator";
> +          reg = <0x30>;
> +
> +          vio18 {
> +            regulator-name = "pp1800-vio18-s3";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-allowed-modes = <0 2>;
> +            regulator-allow-set-load;
> +            regulator-over-current-protection;
> +          };
> +        };
> +
> +        adc@1000 {
> +          compatible = "mediatek,mt6363-auxadc";
> +          reg = <0x1000>;
> +          #io-channel-cells = <1>;
> +        };
> +      };
> +    };
> -- 
> 2.51.0
> 

