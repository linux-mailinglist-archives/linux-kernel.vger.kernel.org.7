Return-Path: <linux-kernel+bounces-731925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAEDB05CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B284E188AA84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF312E54CB;
	Tue, 15 Jul 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kRcBlPPv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864832EAB63;
	Tue, 15 Jul 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586138; cv=none; b=cCe6Mta3sOTvjp0T1BH+XVfybnOCYE72YOJnh431WH/qcN4Zd52VSTNY+xrTjpjpwqMQGLtFibFI73P5md9H4rH9Ij/Wj7EwX64XlbPxuJsQ0UFEYGStiynyNYJgNy0qY7RwHWicw3elIRCNik6xYkschgA+yjzKR/HFGlbN8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586138; c=relaxed/simple;
	bh=NZtHYSOuQbNspfyKqTqQMOVejME6k8PRvnKr3a2/2D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ//WoOFWCCPt+XcJ/Eclk6VpjAwcTMZZ6x/XqIe44nTlXfgZ8f4DmobRlw+sgJC054clTiyOiVdyZ9iu0VL2LLgtd4uIq4V4S+hnA+09aiQoNR3+wNgijEEsFEEZVu49UI/KWyZtGxY3QOluAhGLOpsSzNN8NY5mzyqMFImcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kRcBlPPv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752586134;
	bh=NZtHYSOuQbNspfyKqTqQMOVejME6k8PRvnKr3a2/2D4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kRcBlPPvRe+bzW3i/349S6j/Q0Rd1pBOiZHegxlcV54u6jnCdI+WmwWxjRsBnqbKK
	 Au2xhiZsjApGtuJuHrWtOYpaqh21zUnqY8YdL8P4zsa+8PXLxYA6j9HwHHJB/inQfL
	 43PVMiO+tuTGwHkJD61oUmSWKNQUtjJEx3YjViwqRGQCLZCfN1hazHIy7IHjdNVqYn
	 SORvTVefSQNSiWbYSmLfFOVhyiSbdoCDMlFMPG0t9GsYZYJVLiROZQsyKwrpNHUMxS
	 dR3BGWoXJlJJqf3CS0cM7yfcAx/6LndJV1j9GbRe6RCRyKQavMar0okFkpeAv4kiLM
	 cViUNU5zai9SA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F30D517E05F0;
	Tue, 15 Jul 2025 15:28:53 +0200 (CEST)
Message-ID: <bf5638c9-e49a-4482-9796-ddd3a010d162@collabora.com>
Date: Tue, 15 Jul 2025 15:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org
References: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
 <20250715115718.176495-2-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250715115718.176495-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/07/25 13:57, AngeloGioacchino Del Regno ha scritto:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
> 
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
> 
> Link: https://lore.kernel.org/r/20250624073548.29732-2-angelogioacchino.delregno@collabora.com
> Link: https://lore.kernel.org/r/20250707134451.154346-2-angelogioacchino.delregno@collabora.com

Btw, sorry about those Link: tags, those were completely unwanted... they
slipped through while using b4 and I forgot to remove them.

I'll wait for any feedback or tags and will resend the series with those
tags removed.

Thanks,
Angelo

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../regulator/mediatek,mt6316b-regulator.yaml | 46 +++++++++++++++++++
>   .../regulator/mediatek,mt6316c-regulator.yaml | 46 +++++++++++++++++++
>   .../regulator/mediatek,mt6316d-regulator.yaml | 41 +++++++++++++++++
>   3 files changed, 133 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
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
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
> new file mode 100644
> index 000000000000..0b9239a595ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316c-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6316 CP/HP/KP SPMI PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MediaTek MT6316CP/HP/KP PMICs are fully controlled by SPMI interface,
> +  features four step-down DC/DC (buck) converters, and provides 3+1 Phases,
> +  joining Buck 1+2+4 for the first phase, and uses Buck 3 for the second.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6316c-regulator
> +
> +  vbuck124:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  vbuck3:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      regulators {
> +        compatible = "mediatek,mt6316c-regulator";
> +
> +        vbuck124 {
> +          regulator-min-microvolt = <450000>;
> +          regulator-max-microvolt = <1277500>;
> +          regulator-always-on;
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
> new file mode 100644
> index 000000000000..460c02bf69de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316d-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6316 DP/TP SPMI PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MediaTek MT6316DP/TP PMICs are fully controlled by SPMI interface, both
> +  feature four step-down DC/DC (buck) converters, and provides a single Phase,
> +  joining Buck 1+2+3+4.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6316d-regulator
> +
> +  vbuck1234:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      regulators {
> +        compatible = "mediatek,mt6316d-regulator";
> +
> +        vbuck1234 {
> +          regulator-min-microvolt = <400000>;
> +          regulator-max-microvolt = <1277500>;
> +          regulator-always-on;
> +        };
> +      };
> +    };
> +...


