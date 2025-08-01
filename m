Return-Path: <linux-kernel+bounces-753013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F6B17DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB341C25312
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8D1F5619;
	Fri,  1 Aug 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R5E3/LB4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EB2A8C1;
	Fri,  1 Aug 2025 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034113; cv=none; b=avwEnneacmsxmq7qtz4qM/5oFSrCt4excsHaxzmFXylla7c/vBZE66M9adXKUdhIzdIqv2+dsx1/qZyGPGP5K7PJu4hw5Zyj5S/B61OdZmRtlaxljgCMFr1/hBNTrLJz9YDWWCsyLlw6o/NL8OYvNYRDft9Y8eBZI+CUD0YuRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034113; c=relaxed/simple;
	bh=8GO2QlwNB/o3RC81iMx20QIWHNAykTNaGMaMqbeyk1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj6cri+A8AoCxeQuqKEwRvxue28xDfaXf4Y8c26gcUEIue1gezCdoXe/0z5vllny7F/0iArmPk/iT44hydgrsJPXUNmuFjzji+NSEzmYFVf+oSpM0LCyJ29O8jvJIKGfEmjYcobjGpSQ2cWeMbpswHUTbwfL6evl9mSj/472ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R5E3/LB4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754034109;
	bh=8GO2QlwNB/o3RC81iMx20QIWHNAykTNaGMaMqbeyk1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R5E3/LB4VV7xmygCgusprQR3KREteK8ri1mfpXvKRyrORPH4Di2Jh0yYFoWrbNi9g
	 g9xnSL7V2ohJ5ij/Oxzxzo9dOmF+Yw41HC1cqBU17ZP596T+tPj/5TiJXySQVjJfVj
	 VAFB1kQKRmAzDPlcRY336dJ0b8Et60sobK3RqV8fvnVs9pOk4C6iaeHWDpv9K4o34F
	 t3uE1aT+n4HN7nEaPC8DhXmt5TV8ytLpj1/Ber1Dtt98FTfVC6ZOGw1N3bNDiLUszH
	 OdlD50AAzDMtJqmfQoYTnwuOTZb5ZxNXzn2NWcd7GWwaWSZwANDzzM6vdJI31HbP0J
	 XAu7E0dMFA9Hg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 047EF17E0202;
	Fri,  1 Aug 2025 09:41:48 +0200 (CEST)
Message-ID: <e2e2141e-1e58-492e-b151-951eff13dc93@collabora.com>
Date: Fri, 1 Aug 2025 09:41:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mediatek : add binding for pwrap,spmi
To: "niklaus.liu" <niklaus.liu@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250801070913.3109-1-niklaus.liu@mediatek.com>
 <20250801070913.3109-2-niklaus.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250801070913.3109-2-niklaus.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/08/25 08:39, niklaus.liu ha scritto:
> Add pwrap,spmi compatible for mt8189  to the binding.

The changes look good, but you have to split the commit in two; one for adding the
compatible to mediatek,pwrap.yaml and one for adding it to the other.

Besides, please check the git log for both yaml files and:
  1. Use the same prefixes that you find in there for your new commit titles;
  2. Add a commit description that describes your change, e.g.:
     "Add a new compatible string for MT8189; this SoC's {spmi, pwrap} IP is fully
      compatible with the one found in the MT8195 SoC."

Regards,
Angelo

> 
> Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
> ---
>   .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
>   Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index 4737e5f45d54..c93cea9f203c 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -52,6 +52,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8188-pwrap
> +              - mediatek,mt8189-pwrap
>             - const: mediatek,mt8195-pwrap
>             - const: syscon
>   
> diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> index 7f0be0ac644a..dc61d88008a9 100644
> --- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> +++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> @@ -26,6 +26,7 @@ properties:
>             - enum:
>                 - mediatek,mt8186-spmi
>                 - mediatek,mt8188-spmi
> +              - mediatek,mt8189-spmi
>             - const: mediatek,mt8195-spmi
>   
>     reg:




