Return-Path: <linux-kernel+bounces-803895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8EB466DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C55C0F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089E29E11D;
	Fri,  5 Sep 2025 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cClxvj29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC2524F;
	Fri,  5 Sep 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112721; cv=none; b=DZR8yyEB4ZPMrHxqVmIFwbayfUsLQjo1ZoL1gmiKyVKkuPz2lpuFq9/yvT9qwTam8xgwKMqIm7GdHmexWYzEoR+BO5L903Eay3rt28pzTN2ZdCXqqm6p85t60PEuxnLZCI3fxI4H5h4aZYVXnTvpW3aQGdJNKK3kMqBFX4y98i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112721; c=relaxed/simple;
	bh=l60dkoYMQd6R7LAx2baVP55rb2TCT2FRvS6OPwDjEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYol6l8COQNjrm/1/EVikkZXZvb7d93wxHsvt3IhDtl7fUgYcAN6eN64MQroFstWnu2Ki/f1U/5K9Z8T+VWNcqvxgz0JlngLCSEhLExqcOuYl3y6hFUXcNZ0+9eAQNn9Vh9e3s5maHbm0tKEMWBID1PpycPetgxBj894sNnGP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cClxvj29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45ADC4CEF1;
	Fri,  5 Sep 2025 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757112721;
	bh=l60dkoYMQd6R7LAx2baVP55rb2TCT2FRvS6OPwDjEa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cClxvj29M2e3KDkIgkmiYUfSDXzkuWy5oUvjb5kkZYK7M+gMzJfrS+K8ugUEG/Are
	 3bDD/BJtCbkpp1dm7GZ6CNvMR5U2Duvz0eauHAYO7fDOofXFT7WmKtFFCcAB+NhYTd
	 tbmrsKNllGTVtO4Eh7QYGJdtwZE/FHsAB0wc4FONERWLlShJz4UeLO9KHH9Zud3JJS
	 xQeiwoxfwPFDmhnoMB7LWQJgaOKwkd8ukuEjN/8KvGWk7tgN0/A8MQ/fNkp5bAGaNO
	 HnE8IbzwVitZTLFh7drome8VLwXrSDe5rMUaHfOJcP3G2MwvDjx+irD+T0JM5EzTGu
	 Ghrt/79VY4Oeg==
Date: Fri, 5 Sep 2025 17:52:00 -0500
From: Rob Herring <robh@kernel.org>
To: Cyril Chao <Cyril.Chao@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Darren Ye <darren.ye@mediatek.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 09/10] ASoC: dt-bindings: mediatek,mt8189-nau8825: add
 mt8189-nau8825 document
Message-ID: <20250905225200.GA1355628-robh@kernel.org>
References: <20250905071659.25805-1-Cyril.Chao@mediatek.com>
 <20250905071659.25805-10-Cyril.Chao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905071659.25805-10-Cyril.Chao@mediatek.com>

On Fri, Sep 05, 2025 at 03:15:54PM +0800, Cyril Chao wrote:
> Add document for mt8189 board with nau8825.
> 
> Signed-off-by: Cyril Chao <Cyril.Chao@mediatek.com>
> ---
>  .../sound/mediatek,mt8189-nau8825.yaml        | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
> new file mode 100644
> index 000000000000..db3a70c0b9d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt8189-nau8825.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8189 ASoC sound card
> +
> +maintainers:
> +  - Darren Ye <darren.ye@mediatek.com>
> +  - Cyril Chao <cyril.chao@mediatek.com>
> +
> +allOf:
> +  - $ref: sound-card-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8189-nau8825
> +      - mediatek,mt8189-rt5650
> +      - mediatek,mt8189-rt5682s
> +      - mediatek,mt8189-rt5682i
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8189 ASoC platform.
> +
> +patternProperties:
> +  "^dai-link-[0-9]+$":
> +    type: object
> +    description:
> +      Container for dai-link level properties and CODEC sub-nodes.
> +
> +    properties:
> +      link-name:
> +        description:
> +          This property corresponds to the name of the BE dai-link to which
> +          we are going to update parameters in this node.
> +        items:

Only 1 name? If so, drop 'items'.

> +          enum:
> +            - TDM_DPTX_BE
> +            - I2SOUT0_BE
> +            - I2SIN0_BE
> +            - I2SOUT1_BE
> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        additionalProperties: false

blank line

> +        properties:
> +          sound-dai:
> +            minItems: 1
> +            maxItems: 2
> +        required:
> +          - sound-dai
> +
> +      dai-format:
> +        description: audio format.
> +        items:

Drop items

> +          enum:
> +            - i2s
> +            - right_j
> +            - left_j
> +            - dsp_a
> +            - dsp_b
> +
> +      mediatek,clk-provider:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Indicates dai-link clock master.
> +        enum:
> +          - cpu
> +          - codec
> +
> +    additionalProperties: false
> +
> +    required:
> +      - link-name
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "mediatek,mt8189-nau8825";
> +        model = "mt8189_rt9123_8825";
> +        mediatek,platform = <&afe>;
> +        dai-link-0 {
> +            link-name = "I2SOUT1_BE";
> +            dai-format = "i2s";
> +            mediatek,clk-provider = "cpu";
> +            codec {
> +                sound-dai = <&nau8825>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.45.2
> 

