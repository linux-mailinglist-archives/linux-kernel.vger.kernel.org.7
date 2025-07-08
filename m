Return-Path: <linux-kernel+bounces-722258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B2AFD70C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7376A3ACD02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777142E54B5;
	Tue,  8 Jul 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMaeHI47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0C1DE2A7;
	Tue,  8 Jul 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002580; cv=none; b=eDLRjHO6yzE+MCYymFZsGI0V+vJQ2NzUKsOCSrEXwBLE0MR9mxmwy6IdMWTkLoZsuQHtko6hZ899LtzyU93HjWb9xHzrlnYtwVVv/U0wuqF54alwDGHeGY8cDN98A5PtDlBrhIHyTRI6lzjER75Vj2vZgfEfnUjyrNa0DCFZTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002580; c=relaxed/simple;
	bh=dOvW17x+dbsJQLzVMph+iJfeu3y0qwjWlfWvz5ioVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0bKf4bOJes7Ul0n8S8xgYUTjZu/VKFUySCpZzCkW2eYxNRWoQvU0zQqZH8Lf5wToUMdDTBZI2iqX/KyUnpcEhTWEgFVk8U4vs1vUDYMqwmE7y4ttey4AHOoLTv5K6SOr8IwzQ89zuag5V5YbS8SsrJqNKZllDVy5GFnUhMZqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMaeHI47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245F0C4CEED;
	Tue,  8 Jul 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002580;
	bh=dOvW17x+dbsJQLzVMph+iJfeu3y0qwjWlfWvz5ioVxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMaeHI47SnTWqGnpKHGmbNN6znyP6Ax23KY3vl/Qu1DBOx8SV8IU1i8NTMGUw5vaA
	 Oebj2IzjRfYKbJAZQ2H86HLCOBfrELJlu4Br04w4LpBYFKXJh/4yMkBmZhZmnnpHOP
	 IEnVLAc+/MecRNYxWXeZa8zFq2L8DD/bVaPTakdYpB0eFLqxH3OkjxfQk/+Ja6vFfv
	 lkA+hlxxYV12N4q0Q6APjc6SnWVpMPB+BW4pOcaqrMTBlWIL/HYyNKV+WfghB7iSQo
	 Fe/JJzX+YL4dKW29fKD38ahN+21b5EFlsedZkLpejpzU4AwYnKCt06TdFf5jBrZKrE
	 emQ3+UnADOKvg==
Date: Tue, 8 Jul 2025 14:22:59 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 1/8] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20250708192259.GA797072-robh@kernel.org>
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com>
 <20250707134451.154346-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707134451.154346-2-angelogioacchino.delregno@collabora.com>

On Mon, Jul 07, 2025 at 03:44:44PM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
> 
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
> 
> Link: https://lore.kernel.org/r/20250624073548.29732-2-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6316b-regulator.yaml | 46 +++++++++++++++++++
>  .../regulator/mediatek,mt6316c-regulator.yaml | 46 +++++++++++++++++++
>  .../regulator/mediatek,mt6316d-regulator.yaml | 41 +++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
> new file mode 100644
> index 000000000000..e7a6b70cdab2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
> @@ -0,0 +1,46 @@
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
> +  vbuck12:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  vbuck34:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {

Can we have exactly 1 complete example of the PMIC rather than this 
piecemeal example.

> +      regulators {
> +        compatible = "mediatek,mt6316b-regulator";
> +
> +        vbuck12 {
> +          regulator-min-microvolt = <450000>;
> +          regulator-max-microvolt = <965000>;
> +          regulator-always-on;
> +        };
> +      };
> +    };
> +...

