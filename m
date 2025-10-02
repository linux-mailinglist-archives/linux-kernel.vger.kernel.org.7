Return-Path: <linux-kernel+bounces-839661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB9BB21AA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC4D1922273
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C6290F;
	Thu,  2 Oct 2025 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwJ9JpAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA9163;
	Thu,  2 Oct 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363619; cv=none; b=JeGF97RlMNK3RwWl4I/aOrmi6BCBaXvYyxh/U1lQdOLkycOR5flBbpI6B15o26NrrROwn9M5p+UoQ3IG/B+kPgWbDMQTIVAZUilBvbnmCoRc9YK6Gk1FgK42XCM4hKHtasSmCdO/V5T6CTeP09y93ExrA66cMZYwzncV6HeP75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363619; c=relaxed/simple;
	bh=1FuJjw6+SnNP6zCgHm/VGK3WK8/MBmCfRNNHkgalick=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nka3Ah2cKDQfCDG56BFWCeBN7BOeXIyprXbmpO7bdfsiPBGefeTXurzd7SmDiuNDswE3nsgPJeeA3jokLyDdCcNiLuMZMA9yxaFJC0x4glxU8J1Ihohq6L76grqkgh2hYTV4OH+fy2KTPFz0RM0NU70TcWvT5aedwsDCkWn8F6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwJ9JpAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B5C4CEF1;
	Thu,  2 Oct 2025 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759363619;
	bh=1FuJjw6+SnNP6zCgHm/VGK3WK8/MBmCfRNNHkgalick=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwJ9JpAzn6OY1Wsvrgw1d/8yf5zvRa4lzjxPTkXcRMxEJN/ZEB5O0GkN0C7GKiqrV
	 mkP8CqvKb3XwpUh6N77a9vY89TbVGvB4stcuAWdf4bO8FysKnBOaOCgJuqa1q41RJ9
	 lMLYmnZZ4uyQYJzXQuCj+tAdrIJUZfErGGLgNYaAM4uHR4pmdNHbpvYy2Sd3Z2OzLo
	 1DnRdYBfJ6Hl9iD6QH0UcicrlNPWz/8awjayr+PERqvxab6MNiwZGeHt8CXPfQtY5V
	 ugEl0kobslmbKzjGSQImNNYS9if0+NomZEGd1OeAn73N1X4JlkVa2nGBeWja8DO6mm
	 GfJFV+N6LSiow==
Date: Wed, 1 Oct 2025 19:06:57 -0500
From: Rob Herring <robh@kernel.org>
To: Zhengnan Chen <zhengnan.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
Message-ID: <20251002000657.GA2511095-robh@kernel.org>
References: <20250919081014.14100-1-zhengnan.chen@mediatek.com>
 <20250919081014.14100-2-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919081014.14100-2-zhengnan.chen@mediatek.com>

On Fri, Sep 19, 2025 at 04:09:55PM +0800, Zhengnan Chen wrote:
> From: "zhengnan.chen" <zhengnan.chen@mediatek.com>

Please fix your name here so the S-o-b matches.

> 
> Add binding description for mt8189.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml       | 2 ++
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml         | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 0762e0ff66ef..aac8368b210c 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -40,6 +40,8 @@ properties:
>            - mediatek,mt8186-smi-common
>            - mediatek,mt8188-smi-common-vdo
>            - mediatek,mt8188-smi-common-vpp
> +          - mediatek,mt8189-smi-common
> +          - mediatek,mt8189-smi-sub-common

Perhaps some explanation what 'sub-common' is compared to just 'common'.

>            - mediatek,mt8192-smi-common
>            - mediatek,mt8195-smi-common-vdo
>            - mediatek,mt8195-smi-common-vpp
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 2e7fac4b5094..9a5dafd7c07e 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -27,6 +27,7 @@ properties:
>            - mediatek,mt8183-smi-larb
>            - mediatek,mt8186-smi-larb
>            - mediatek,mt8188-smi-larb
> +          - mediatek,mt8189-smi-larb
>            - mediatek,mt8192-smi-larb
>            - mediatek,mt8195-smi-larb
>  
> @@ -85,6 +86,7 @@ allOf:
>              - mediatek,mt8183-smi-larb
>              - mediatek,mt8186-smi-larb
>              - mediatek,mt8188-smi-larb
> +            - mediatek,mt8189-smi-larb
>              - mediatek,mt8195-smi-larb
>  
>      then:
> @@ -119,6 +121,7 @@ allOf:
>                - mediatek,mt6779-smi-larb
>                - mediatek,mt8186-smi-larb
>                - mediatek,mt8188-smi-larb
> +              - mediatek,mt8189-smi-larb
>                - mediatek,mt8192-smi-larb
>                - mediatek,mt8195-smi-larb
>  
> -- 
> 2.46.0
> 

