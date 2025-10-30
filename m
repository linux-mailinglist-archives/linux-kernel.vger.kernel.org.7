Return-Path: <linux-kernel+bounces-878697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E8C214A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9552D3BCFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF43683BA;
	Thu, 30 Oct 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7J9+pLN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D163678D0;
	Thu, 30 Oct 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842635; cv=none; b=jjJwApC1dvgbBRTx9k1cAdrY7qo8MQ6+3In+nGBHW436QVGGd2VFV6Nq1FQhWP75rnE7QzPpnt1YFC/PcUk0bKIVd5d7TWeDJie5xmSUj37+FdK7CgRLQlet4cZ32alu0JYrW/I3PpFyBM0gRxrTj2PS7CqcIN7T39/z+/Dzlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842635; c=relaxed/simple;
	bh=ujITBpWROV8ondxiVfL/J6xD1Tt12xz/U9auSnzcR8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxFkS/3bFc6mMh3CL+YbllV9ab5CZj+kMqEh4uzDTNz5yBjCAxHjJz12JU3waLZBrgTDZAL+lYhCdpVH7LlnGSLoMjhY4w90Ul2od35X2py2wfUmzevl2y+V1u0VZcETFWMmL3VdkhFd/+B9fttP+gjm89y292XHAbC1bHheruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7J9+pLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E606EC4CEF1;
	Thu, 30 Oct 2025 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842635;
	bh=ujITBpWROV8ondxiVfL/J6xD1Tt12xz/U9auSnzcR8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7J9+pLN4ro1WnlD5NBbTiIzH2s+io/jV/gv88R7hqwlbYeA4mPsYn7fBm30ClI/a
	 IpvJm0zIYzgW4YiDZzkOh8/xxxvj4MfQL43SGPpjASn/ocWWpN4ZLwAFBpRkjnYIlQ
	 NV5zkO9SkqzzkUk0EJ1kHNmUa5vPhF3nxTqJbZltUcFWGUJ+0UdYE6qhNe17po9eQ9
	 Q+OINY1l/BDDwLKFXB9btYbK9Nt8xceUyvRb7f2zbBo+TfrvuHVyf2qZs7T4qQhnOi
	 wOxm/7i5hUTLV2rgWn5feK172vyaRE1Cs3aLKLvhfn+hXfBT94G2eoJSWMNHJcGc2c
	 ib7bduylhBWgQ==
Date: Thu, 30 Oct 2025 11:43:53 -0500
From: Rob Herring <robh@kernel.org>
To: Zhengnan Chen <zhengnan.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
Message-ID: <20251030164353.GA4119862-robh@kernel.org>
References: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
 <20251027121443.16783-2-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027121443.16783-2-zhengnan.chen@mediatek.com>

On Mon, Oct 27, 2025 at 08:14:27PM +0800, Zhengnan Chen wrote:
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
> 
> Thanks.
> ---
> ---
>  .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++--
>  .../memory-controllers/mediatek,smi-larb.yaml |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 0762e0ff66ef..454d11a83973 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -25,6 +25,21 @@ description: |
>    SMI generation 1 to transform the smi clock into emi clock domain, but that is
>    not needed for SMI generation 2.
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
>  properties:
>    compatible:
>      oneOf:
> @@ -40,6 +55,8 @@ properties:
>            - mediatek,mt8186-smi-common
>            - mediatek,mt8188-smi-common-vdo
>            - mediatek,mt8188-smi-common-vpp
> +          - mediatek,mt8189-smi-common
> +          - mediatek,mt8189-smi-sub-common
>            - mediatek,mt8192-smi-common
>            - mediatek,mt8195-smi-common-vdo
>            - mediatek,mt8195-smi-common-vpp
> @@ -108,19 +125,23 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - mediatek,mt8189-smi-sub-common
>                - mediatek,mt8195-smi-sub-common
>      then:
>        required:
>          - mediatek,smi
>        properties:
>          clocks:
> -          minItems: 3
> +          minItems: 2

So now 2 clocks is valid for mt8195?

>            maxItems: 3
>          clock-names:
> +          minItems: 2
> +          maxItems: 3
>            items:
>              - const: apb
>              - const: smi
> -            - const: gals0
> +          additionalItems:
> +            const: gals0
>      else:
>        properties:
>          mediatek,smi: false
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

