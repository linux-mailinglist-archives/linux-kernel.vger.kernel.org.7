Return-Path: <linux-kernel+bounces-722264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC30AFD722
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB897ADBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48280212B28;
	Tue,  8 Jul 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAqQP9MY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC6E55B;
	Tue,  8 Jul 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003079; cv=none; b=pMzT8ZWGLMmmvA1r2ePnaP+hrAdNSo2RLndv1sWkexjC+qkL8i7lm8AttWexgf7CQ365lVhAkiLlMcXc3hsvlXh03SjR2ZHXSF4p9PR5nUYGRS+10iFAXxdVXJSGbn/NOYcQSb0MF7J+VDvHXgMJb/Cs4z6MsN6pGo0xHZIgWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003079; c=relaxed/simple;
	bh=4HIbXqO4X/zdFKMfYlEoWG4p7UkHS98SkaZFdbZdFKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMFdSM2t2mhQux7PEU7QpIyx4FLUA+gYQksYo+MtOJwqvHv+Pa7TBOfYP3Xg4aa9qdOznN6DrxUMz3Nytw6NayJOrjVTTTGGW49kQVLADgWNvrxdv1735o2/AkOzqqXjqWlwzZSjzYRERKqiSfrBuk68bacnQIuZNWRns4L4Ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAqQP9MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF178C4CEED;
	Tue,  8 Jul 2025 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003079;
	bh=4HIbXqO4X/zdFKMfYlEoWG4p7UkHS98SkaZFdbZdFKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAqQP9MY6hAOf2CQAO7iVpo9cciRLieNSlVrPS7uTOEYeRSsdmr2ElnpEehToll8Q
	 vHz9zzIQzp7ztQ8iQCbotghbpSBzrt4eHy9vraBL/Qmq1L51AXuMJY2Z9ReebWLQbE
	 4SDvAIGoYAC0YEJ7zQaACrXyZI4KlKv3ZafZCfpS3oV6wMpGGqgowg1fy8pZh9cxlf
	 2igN2LSWnHhUNBkOjqTvGxdsEOKJt6Fb6muVPKm/0tiQRveaLj/IBXksTKfqYC4tbf
	 aZHBYSCTsqApeAMwjhtueGFVuA/r8VUxHmrhJ4Z/BsixGKQ/aNRynj6qBHhFfhxqRm
	 DEBrYMxHLLBDg==
Date: Tue, 8 Jul 2025 14:31:18 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v2 7/8] dt-bindings: mfd: Add binding for MediaTek MT6363
 series SPMI PMIC
Message-ID: <20250708193118.GB797072-robh@kernel.org>
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com>
 <20250707134451.154346-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707134451.154346-8-angelogioacchino.delregno@collabora.com>

On Mon, Jul 07, 2025 at 03:44:50PM +0200, AngeloGioacchino Del Regno wrote:
> Add a binding for the MediaTek MT6363/6373 (and similar) multi
> function PMICs connected over SPMI.
> 
> These PMICs are found on board designs using newer MediaTek SoCs,
> such as the Dimensity 9400 Smartphone chip, or the Chromebook
> MT8196 chip.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Link: https://lore.kernel.org/r/20250623120038.108891-2-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6363.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> new file mode 100644
> index 000000000000..0d1078e92232
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> @@ -0,0 +1,115 @@
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
> +    const: 0

The only place 0 is valid is interrupt controllers for some ancient OF 
reasons.

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
> +  adc:
> +    type: object
> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> +    unevaluatedProperties: false
> +
> +  regulators:
> +    type: object
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6363-regulator

This is never true because the schema is only applied if the top-level 
compatibles matched.

Just do this and drop the if/then schemas:

regulators:
  properties:
    contains:
      enum:
        - mediatek,mt6363-regulator
        - mediatek,mt6373-regulator

Then the appropriate child schema will be applied. This doesn't enforce 
you didn't use mediatek,mt6363-regulator on mt6373 PMIC or vice-versa,
but I don't that really matters.

> +    then:
> +      properties:
> +        regulators:
> +          $ref: /schemas/regulator/mediatek,mt6363-regulator.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6373-regulator
> +    then:
> +      properties:
> +        regulators:
> +          $ref: /schemas/regulator/mediatek,mt6373-regulator.yaml#


