Return-Path: <linux-kernel+bounces-747284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0593B131D1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA55317341E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C1238C06;
	Sun, 27 Jul 2025 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGB7oZ2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71D10FD;
	Sun, 27 Jul 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648553; cv=none; b=UnVTRPJdwhp/t5rJSUkFN+127RTz0B9ULP/7GWeUX9I+kjLvKGTlnqtxRqySnved5FNj/kr/WtOm6o/6qcGk0jl1g0w9FgQzybVspFcXnVJO2L7+2rHUObQ0I/Kb0bFcg/xzmbd6XmXWIxQJYSXEzO0JDN3Hm8QL2r/+2WtQMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648553; c=relaxed/simple;
	bh=aToYMpoxnweoMVQRODB1CfY6b8LZU7AvPLEabYZkP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry4n2l74hU/dzVRiIYF4LQGwR5GCTdNOJGU7fsj+ks2RF4N8/7qLaalxGFj67xoUXKB3TmoGRbaC0PLZc11IweaUIxz3bw2LkLT+lo6YQwpBmC0ecz+hZSTU2pi8lR2kbPOwuJUg3v08NrjyjE+nrLpluKYKKhqkRz510hs1C7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGB7oZ2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB62C4CEEB;
	Sun, 27 Jul 2025 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648553;
	bh=aToYMpoxnweoMVQRODB1CfY6b8LZU7AvPLEabYZkP0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGB7oZ2GguJv1ih1YwbsnR0rL0qWzypXINzoRKF3X/RHcmAvsd2h7MqRyHEpfcJ4S
	 AVw3vtOJU6gM6CTSxyQrOo5l2k/Qk8rPGvZ9yJ4i7gMp/tLjFrHY/xtU/1J9ir/S4I
	 tCSfHLPRtATZPvRrsRlQWfKnzNNte6ZLABbhbJ+G5BCUoGfFEVjTlHNI/rXI6FVCd0
	 flh+PSNFRwsNlLuCVgt8NVaPvdVngVtlsx3gyfjdwWc1b61Kb4ELAc3Ht6PDXzAQ4q
	 Sm7SHBMCOymbSD3JFHiXC+tv/FrOj8u/i5PQi9iYLvIfgeKupSxcw+Y3w3FCmPuqII
	 UAV0bUVg0AMAQ==
Date: Sun, 27 Jul 2025 15:35:52 -0500
From: Rob Herring <robh@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
	Yongqiang Niu <yongqiang.niu@mediatek.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/7] dt-bindings: display: mediatek: ccorr: Add
 support for MT8196
Message-ID: <20250727203552.GA12324-robh@kernel.org>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
 <20250727071609.26037-6-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727071609.26037-6-jay.liu@mediatek.com>

On Sun, Jul 27, 2025 at 03:15:55PM +0800, Jay Liu wrote:
> Add a compatible string for the CCORR IP found in the MT8196 SoC.
> Each CCORR IP of this SoC is fully compatible with the ones found
> in MT8192.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>

????

> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index fca8e7bb0cbc..581003aa9b9c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -32,6 +32,7 @@ properties:
>                - mediatek,mt8186-disp-ccorr
>                - mediatek,mt8188-disp-ccorr
>                - mediatek,mt8195-disp-ccorr
> +              - mediatek,mt8196-disp-ccorr
>            - const: mediatek,mt8192-disp-ccorr
>  
>    reg:
> -- 
> 2.46.0
> 

