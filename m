Return-Path: <linux-kernel+bounces-875912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BEC1A1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7F8A357523
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63A3375C3;
	Wed, 29 Oct 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k5eTs6SB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB012EC08C;
	Wed, 29 Oct 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738367; cv=none; b=JTZP+M/BUpQe/vUmjXzfF3hB2mzx9dqITcFnIFTYG6qbm/7Oy8JerDKLM+Vnlk/3X0d6n7Y7atL9MN/N1te6zFFe9FKmFFrE8mkjWRYin4St+NmsGE80d4DPPpubfF7LsFzaArgiw4OhpjCY/MV8iF3xYF6kEcOSQTe9kjBuYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738367; c=relaxed/simple;
	bh=u/aqBEyYqByF3ozze0YJu0YuHgdtvDeMsN7BUsRpv4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxQOU/EuFk5SEZiHgNUCeqkp9EagD+Hxh4/+PopoSObsor3Irr7PPr/e4DtKgEuQDSpPvNupM8DFHAxSmf3D26VbokMJgv+6iBTaHjGBxpetCnvZnpZf33zBVOKA9NadwniLS529f3z993GeKIF6bwTZHW3VnJGNzjIoMvlUZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k5eTs6SB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761738358;
	bh=u/aqBEyYqByF3ozze0YJu0YuHgdtvDeMsN7BUsRpv4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5eTs6SB4dsbkVyUNcd9fYQehBXkTJfOxaoXGZvg2Z9A6HDT/zT2B+tOywLOi3HPv
	 crSXwSOgcszVNsAOGmdUjBtWpKhRFFtQWHTxU+zXG92on59XquPpceq2MRCYObAATQ
	 kXNxX9rXfa78NDNGgLNAZKlpNnPdJh3QpKSLgT2kXCZ/FENkPFHWeNvCSSo9Peo/lf
	 SHCbAdxQCF+mz9PbAZWIL0kbAzlQVT/8rMt9E4y/bYnajxn7vtbWQ1VPk/5wSQ+ox2
	 hHA8vcVleTiBPHJVwrbxxpasbf3tqim8SxZRL+VPqemrWJNPQGmE4MvJODRm2vujko
	 iaVO3l2E0yP1Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 76E9B17E013C;
	Wed, 29 Oct 2025 12:45:58 +0100 (CET)
Message-ID: <dcb66482-bd62-41d7-88d2-c1e271abe90c@collabora.com>
Date: Wed, 29 Oct 2025 12:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
 <20251027121443.16783-2-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251027121443.16783-2-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/10/25 13:14, Zhengnan Chen ha scritto:
> Add binding description for mt8189.
> 
> The clocks number of mt8189 smi-sub common has a bit difference.
> Its clock count is 2, while mt8195 has 3. Therefore, the minimum
> number of clocks is changed to 2, with the third one being optional.
> 
> About what smi-sub-common is, please check the below diagram,
> we add it in mediatek,smi-common.yaml file.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
> ---
> Hi Angelo,
> We add a diagram in the smi-common yaml, We are not sure if you agree
> with this. thus I remove your R-b.

I agree with that, and the diagram looks good.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Thanks.
> ---
> ---
>   .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++--
>   .../memory-controllers/mediatek,smi-larb.yaml |  3 +++
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 0762e0ff66ef..454d11a83973 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -25,6 +25,21 @@ description: |
>     SMI generation 1 to transform the smi clock into emi clock domain, but that is
>     not needed for SMI generation 2.
>   
> +  The smi-common connects with smi-larb and IOMMU. The maximum inputs number of
> +  a smi-common is 8. In SMI generation 2, the engines number may be over 8.
> +  In this case, we use a smi-sub-common to merge some larbs.
> +  The block diagram something is like:
> +
> +                          IOMMU
> +                           | |
> +                       smi-common
> +              ---------------------------
> +               |          |           ...
> +              larb0   sub-common      ...  <-max number is 8
> +                   ----------------
> +                    |     |    ...
> +                  larb1 larbX  ...  <-max number is 8
> +
>   properties:
>     compatible:
>       oneOf:
> @@ -40,6 +55,8 @@ properties:
>             - mediatek,mt8186-smi-common
>             - mediatek,mt8188-smi-common-vdo
>             - mediatek,mt8188-smi-common-vpp
> +          - mediatek,mt8189-smi-common
> +          - mediatek,mt8189-smi-sub-common
>             - mediatek,mt8192-smi-common
>             - mediatek,mt8195-smi-common-vdo
>             - mediatek,mt8195-smi-common-vpp
> @@ -108,19 +125,23 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - mediatek,mt8189-smi-sub-common
>                 - mediatek,mt8195-smi-sub-common
>       then:
>         required:
>           - mediatek,smi
>         properties:
>           clocks:
> -          minItems: 3
> +          minItems: 2
>             maxItems: 3
>           clock-names:
> +          minItems: 2
> +          maxItems: 3
>             items:
>               - const: apb
>               - const: smi
> -            - const: gals0
> +          additionalItems:
> +            const: gals0
>       else:
>         properties:
>           mediatek,smi: false
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 2e7fac4b5094..9a5dafd7c07e 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -27,6 +27,7 @@ properties:
>             - mediatek,mt8183-smi-larb
>             - mediatek,mt8186-smi-larb
>             - mediatek,mt8188-smi-larb
> +          - mediatek,mt8189-smi-larb
>             - mediatek,mt8192-smi-larb
>             - mediatek,mt8195-smi-larb
>   
> @@ -85,6 +86,7 @@ allOf:
>               - mediatek,mt8183-smi-larb
>               - mediatek,mt8186-smi-larb
>               - mediatek,mt8188-smi-larb
> +            - mediatek,mt8189-smi-larb
>               - mediatek,mt8195-smi-larb
>   
>       then:
> @@ -119,6 +121,7 @@ allOf:
>                 - mediatek,mt6779-smi-larb
>                 - mediatek,mt8186-smi-larb
>                 - mediatek,mt8188-smi-larb
> +              - mediatek,mt8189-smi-larb
>                 - mediatek,mt8192-smi-larb
>                 - mediatek,mt8195-smi-larb
>   


