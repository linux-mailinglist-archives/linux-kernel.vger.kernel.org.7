Return-Path: <linux-kernel+bounces-882583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C66C2AD05
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD2AE4F1EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FDA2F066B;
	Mon,  3 Nov 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWxrWply"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B62EFDA5;
	Mon,  3 Nov 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162772; cv=none; b=iMII1LkGnB3Tj/KAieVeApag01Vx9uppGRy6P6gjnXVuAHeMhiSeRN13gN5FWt7Np28x/i5GIM8MT99oKfEBPYdADkoYum3LadM5YKBvRzSv0abPDd+/fHYlw/6UZIqf9gYS9p34yekGKb6dHpn7UhyoaJXk8Q4KnRx6O2G+TyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162772; c=relaxed/simple;
	bh=74xTa1alepkXuLAJggdVWdu19FLOXxI8tg4rxRqpq10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh4Z6S0PqZ/zz7rsOEUFHsFmQ4yrpwnAtRN6iF1fP1qplJpOt4bADSZmXYklCyVxRP3oHva7Fy16prngUmCwvGBfiX+blcf+zN2kyp18hLIzC/3YsviWIG4iFAJrs3qCwgxMg/jYwVSkRon1GZoBZ3cNixwfwKvoNETC3AuU9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWxrWply; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3542C4CEFD;
	Mon,  3 Nov 2025 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762162772;
	bh=74xTa1alepkXuLAJggdVWdu19FLOXxI8tg4rxRqpq10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWxrWply1t/qhJLrulY0PUa6pjoYucGLbqzRzXOYHGA7T2aNuhDZgBWJyTPk+KgbF
	 YL5RaPIgr3MwZHw+7/KFDKWYNaJlnECOhrwvH5xoVIqkcXafleWxGaDAPT/E5YFUNZ
	 DYBI4IukWOwTI+ATD91xP1V3n5IS+Vi0/K/GAjN860CoLntKpLd71X4E5Fi4G/Nqa0
	 46wtYNsfddKPkHt8f4LCSFrucRsmOQPYgPOs0i898jRRyUIUu38ziU5v30xaVcvLyL
	 TW8bWqQOXx78nB1+A8crUEmN2ciaXtN7MbpLzFHh43oeOlkdjb3+vRWRwqqSPGzpIi
	 VORLel3UFeyhQ==
Date: Mon, 3 Nov 2025 10:39:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cyril Chao <Cyril.Chao@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 09/10] ASoC: dt-bindings: mediatek,mt8189-nau8825: add
 mt8189-nau8825 document
Message-ID: <20251103-handsome-fractal-stoat-8b82ca@kuoka>
References: <20251031073216.8662-1-Cyril.Chao@mediatek.com>
 <20251031073216.8662-10-Cyril.Chao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031073216.8662-10-Cyril.Chao@mediatek.com>

On Fri, Oct 31, 2025 at 03:32:03PM +0800, Cyril Chao wrote:
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8189 ASoC platform.
> +
> +patternProperties:
> +  "^dai-link-[0-9]+$":
> +    type: object
> +    description:
> +      Container for dai-link level properties and CODEC sub-nodes.

<placeholder (see further)>

> +
> +    properties:
> +      link-name:
> +        description:
> +          This property corresponds to the name of the BE dai-link to which
> +          we are going to update parameters in this node.
> +        enum:
> +          - TDM_DPTX_BE
> +          - I2SOUT0_BE
> +          - I2SIN0_BE
> +          - I2SOUT1_BE
> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          sound-dai:
> +            minItems: 1
> +            maxItems: 2
> +        required:
> +          - sound-dai
> +
> +      dai-format:
> +        description: audio format.
> +        enum:
> +          - i2s
> +          - right_j
> +          - left_j
> +          - dsp_a
> +          - dsp_b
> +
> +      mediatek,clk-provider:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Indicates dai-link clock master.
> +        enum:
> +          - cpu
> +          - codec
> +
> +    additionalProperties: false

If there is going to be a new version please move this one above to
earlier place - after "description:", to the placeholder place (but of
course keep indentation level, just ordering).

Also
A nit, subject: drop second/last, redundant "document". The
"dt-bindings" prefix is already stating that this is documentation.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

No need to resend just for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


