Return-Path: <linux-kernel+bounces-839258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F3BB130D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310251940FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D32820D5;
	Wed,  1 Oct 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDnGZVRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317C3C1F;
	Wed,  1 Oct 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334186; cv=none; b=FA0VigOYJGGdyxoKKXpUySd+gvN1mx6mAHeIjDPF3RVJKGQTGumfaVn3k7joK9cWwxU0ZTfw+7/xGrl/v3JIxeH1n5C+Kd7iXPbuRW7NkVde9XTYNvDbStEY9+gz8PuSlXBplxCSGjhV9FuHnfiqLcLwbwphTedQfitOmB5dGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334186; c=relaxed/simple;
	bh=dpDxbJEa9xHDq32Iw4dhO02Kxs37V/TEEB8swDIuAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqjE2Wlyf3OvbLrZyqf4ms1PrEyUV6cIUYJnk9RxnPNNRHcwyC/M3SpsBfF0fRSwErICJMWI6IdSaJgXSmy3TJHgN3e0zxZhd6WShB/6TZzInOSlBP1rgNLckNBHdoUv9JPiDDlhIbmi+HA+Mxk/hdCnrVsj9XnEk8uQmKxaRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDnGZVRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F883C4CEF1;
	Wed,  1 Oct 2025 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759334186;
	bh=dpDxbJEa9xHDq32Iw4dhO02Kxs37V/TEEB8swDIuAXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDnGZVRSsuogS4Rz0rpmzlM5UBo6GlPks/QrPDVktYTRkHIlNBDcuEgF5G/HQaTFG
	 LJNoyXC0SKBmi9hhUjpPUhAKR6Z78s0oZIbynz+7PgGZG81tpqFFXRS70J5NS530vo
	 GDs7SZEicBivPJu/feQHSOFqIN+LYCgMq8O7FqvC2t5Fb5/BMdnDaxFTFcJeT5kt0k
	 WBWij5+tglL96vr3PohqhG6CjjW+iVAgZ45C3JJeBOrh+ZUIV2z0cQkMj8rYvsRMlZ
	 qo/TUbqtuHTg8OoyaKGOPJf/2I6hp+xtoWTG4H+xY5W9ADS220IgM0yYzviJ3cgz95
	 aZHMgHOmeV7Rw==
Date: Wed, 1 Oct 2025 10:56:25 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v6 8/9] dt-bindings: mfd: Add binding for MediaTek MT6363
 series SPMI PMIC
Message-ID: <20251001155625.GE1833526-robh@kernel.org>
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-9-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001111316.31828-9-angelogioacchino.delregno@collabora.com>

On Wed, Oct 01, 2025 at 01:13:15PM +0200, AngeloGioacchino Del Regno wrote:
> Add a binding for the MediaTek MT6363/6373 (and similar) multi
> function PMICs connected over SPMI.
> 
> These PMICs are found on board designs using newer MediaTek SoCs,
> such as the Dimensity 9400 Smartphone chip, or the Chromebook
> MT8196 chip.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Link: https://lore.kernel.org/r/20250715140224.206329-8-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6363.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> new file mode 100644
> index 000000000000..6f477186a9c6
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
> +    oneOf:
> +      - $ref: /schemas/regulator/mediatek,mt6363-regulator.yaml#
> +      - $ref: /schemas/regulator/mediatek,mt6373-regulator.yaml#
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'

#size-cells should be required too. With that fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

