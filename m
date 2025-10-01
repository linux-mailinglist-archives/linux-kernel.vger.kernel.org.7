Return-Path: <linux-kernel+bounces-839247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB99BB1298
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF016B77D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36127D780;
	Wed,  1 Oct 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hio8FR4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C573219A89;
	Wed,  1 Oct 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333539; cv=none; b=lPyrSFCWDNt+4TYHYIV9w/W5M5Bhr2HgBheyySfmwyFChv0mRNzMHUXRvuFmTx0kfR/Emoy+jel6f8iEnQwbdkv1ZLOnVQNzolXVZJJF5R+61H9xk6C6+fC0uo882BsB5Lga18I8/3lmss2SEfbpiN0Bnuh8sJ6DFEXszzGTufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333539; c=relaxed/simple;
	bh=C+zDEytAGVJtHdXPlshDYcbrYHV+WvMLrd6CmfU3n5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCo8Ggs+HJURnll9Hrz0WyWynFuVnt0/GvPoqylNLynQzJBXHkBTAm3zUBu32D9iG8aif2KoZjWS5LQZr4fYecqfFgfM+AOkczP9ucG3qBc9lMA1IYEPu2M6ehFYsl/DFdAzgLs7KPQzWt+3SXNYTq2vlW2Bm5g39tZ1Xu6owN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hio8FR4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A8C4CEF5;
	Wed,  1 Oct 2025 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333539;
	bh=C+zDEytAGVJtHdXPlshDYcbrYHV+WvMLrd6CmfU3n5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hio8FR4kA5VN0FqaJFABg54URHc3ZtZuM2f5hhr38F2OCEbCbmhoEZ6QG5FCD4ocJ
	 EvC9bBZRwtO/2jBalZ4176+ioSAAq4L3+b8rU0F3rGlWX5WwXvPDCXj4cCn/dnmvX3
	 gwlwrjZHhF0+T72rQjf5/J+2NH420hRW8/BWwkEFl7QwN+7XYrzi0qU3Tfnkkx1Z9k
	 PAZWAItoLXvAFQqByBxlBDJ+ubch8hb/WqWoADG2gBt7UEgIi5k58QY3p9Jm/1xtQ3
	 k0fokyljbqM1s/G534QTz0i0aILhAFGQnQveVCZRIcuOqTLbm3as6orHe27mmqUpZB
	 SyPdfb8kw2yTg==
Date: Wed, 1 Oct 2025 10:45:37 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v6 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251001154537.GA1833526-robh@kernel.org>
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001111316.31828-2-angelogioacchino.delregno@collabora.com>

On Wed, Oct 01, 2025 at 01:13:08PM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
> 
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Link: https://lore.kernel.org/r/20250715140224.206329-2-angelogioacchino.delregno@collabora.com

Why do we want a link to v5 here in the git history forever? You've seen 
Linus' recent comments on Link usage?

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

One complete example for the pmic please rather than incomplete child 
node examples.

Rob

