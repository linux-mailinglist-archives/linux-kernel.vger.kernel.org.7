Return-Path: <linux-kernel+bounces-862389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36FBF5258
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD994662A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC32EA75D;
	Tue, 21 Oct 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QROdFjdg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA71D61B7;
	Tue, 21 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033838; cv=none; b=OfKxMVu09ECzKKWg3Z98tg8L7YYpd1+VlvhV3ef66MtVa4lsByhoCuiZXtL9jkIotBar30hxjr9p2ucEN5H+9l2jR8qMAQNkG/kAOi1qZAyxC8t+OfEHY/f+t99pRG2J3PKH1XJH7z3uq8AkQPSuB38LXsPutmmCo/4PbFZF9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033838; c=relaxed/simple;
	bh=uRJHPyETDsTCj2+OQ1mRFlr8Bbks2lxPY6twkMXsU2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey8CnO3tGWa3BvORnMmCcFC9AmFBj/V1Gdbx/Cl1l/2/pTeguvvCA1OG0mbPFbr/r9p23+yO4faW+hTPyvpxhJ4IX4jSMxIuhH0RYX5Q542+uH6z1xCPMvFdxlqMT9LeNlE3pCIGZ7BRfYF0huUZUde0g9wscQgG/9Os4POsiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QROdFjdg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761033833;
	bh=uRJHPyETDsTCj2+OQ1mRFlr8Bbks2lxPY6twkMXsU2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QROdFjdgod/ROylJgy2Guz/ooeoHdSBvVBAh5Je/NIPZVw8Id9oRiFxWXCVHFjshj
	 rsRD6xnfsiXOoIPMpzKWa6gwzqBRxnJMMUIlnqUbKP4ybKE7I6R4GhedPFsJ3ZE0cn
	 Fyat/tvas5N+DYhHCkOokWzRItq5v/Zd0JQSmtES+G9vqj1rpn4RTI4NNADxdS9hrh
	 LXFtS0yZsdBIuIYbxVdQSQpkvqS3ytSXDQfTh0SgTgTNByE7O342gjxdPj5kPaOuN7
	 H4/zTP9IVJTZUkHvAUNgPFqiZR4fy2QKTfr5H1t2/iaoHCAlUctjMHye0LLH0p2Rjt
	 4/RNQDNBGf7PA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 08DC317E081A;
	Tue, 21 Oct 2025 10:03:52 +0200 (CEST)
Message-ID: <0e5ca992-730d-42c5-b5b8-5ad04116b8d4@collabora.com>
Date: Tue, 21 Oct 2025 10:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add Mali GPU support for Mediatek MT8365 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/10/25 09:30, Louis-Alexis Eyraud ha scritto:
> This patchset adds the support of the ARM Mali G52 MC1 GPU (Bifrost),
> integrated to the Mediatek MT8365 SoC, and its enablement to the
> Mediatek Genio 350-EVK board.
> 
> I've tested this patchset on a Mediatek Genio 350-EVK board,
> with a kernel based on linux-next (tag: next-20251021).
> 

Thanks for this one! This series is ready to be merged.

However, in order to take the DT patches I need someone to pick the binding first.

Cheers,
Angelo

> The panfrost driver probed with the following messages:
> ```
> panfrost 13040000.gpu: clock rate = 450000031
> panfrost 13040000.gpu: mali-g52 id 0x7402 major 0x1 minor 0x0 status
>    0x0
> panfrost 13040000.gpu: features: 00000000,00000df7, issues: 00000000,
>    00000400
> panfrost 13040000.gpu: Features: L2:0x07110206 Shader:0x00000003
>   Tiler:0x00000209 Mem:0x1 MMU:0x00002823 AS:0xff JS:0x7
> panfrost 13040000.gpu: shader_present=0x1 l2_present=0x1
> [drm] Initialized panfrost 1.5.0 for 13040000.gpu on minor 0
> ```
> 
> Running glmark2-es2-drm with MESA 25.2 is also OK:
> ```
> =======================================================
>      glmark2 2023.01
> =======================================================
>      OpenGL Information
>      GL_VENDOR:      Mesa
>      GL_RENDERER:    Mali-G52 r1 (Panfrost)
>      GL_VERSION:     OpenGL ES 3.1 Mesa 25.2.5-1
>      Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
>      Surface Size:   1200x1920 fullscreen
> =======================================================
> [build] use-vbo=false: FPS: 513 FrameTime: 1.952 ms
> [build] use-vbo=true: FPS: 514 FrameTime: 1.947 ms
> [texture] texture-filter=nearest: FPS: 489 FrameTime: 2.046 ms
> [texture] texture-filter=linear: FPS: 486 FrameTime: 2.061 ms
> [texture] texture-filter=mipmap: FPS: 476 FrameTime: 2.101 ms
> [shading] shading=gouraud: FPS: 436 FrameTime: 2.296 ms
> [shading] shading=blinn-phong-inf: FPS: 387 FrameTime: 2.585 ms
> [shading] shading=phong: FPS: 253 FrameTime: 3.955 ms
> [shading] shading=cel: FPS: 232 FrameTime: 4.328 ms
> [bump] bump-render=high-poly: FPS: 266 FrameTime: 3.765 ms
> [bump] bump-render=normals: FPS: 421 FrameTime: 2.376 ms
> [bump] bump-render=height: FPS: 343 FrameTime: 2.922 ms
> [effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 133 FrameTime: 7.521 ms
> [effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 46 FrameTime:
>    21.990 ms
> [pulsar] light=false:quads=5:texture=false: FPS: 379 FrameTime: 2.645 ms
> [desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4:
>    FPS: 57 FrameTime: 17.735 ms
> [desktop] effect=shadow:windows=4: FPS: 249 FrameTime: 4.018 ms
> [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction
>    =0.5:update-method=map: FPS: 81 FrameTime: 12.447 ms
> [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction
>    =0.5:update-method=subdata: FPS: 81 FrameTime: 12.388 ms
> [buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction
>    =0.5:update-method=map: FPS: 99 FrameTime: 10.127 ms
> [ideas] speed=duration: FPS: 287 FrameTime: 3.492 ms
> [jellyfish] <default>: FPS: 114 FrameTime: 8.842 ms
> [terrain] <default>: FPS: 14 FrameTime: 76.911 ms
> [shadow] <default>: FPS: 156 FrameTime: 6.432 ms
> [refract] <default>: FPS: 29 FrameTime: 34.791 ms
> [conditionals] fragment-steps=0:vertex-steps=0: FPS: 529 FrameTime: 1.890 ms
> [conditionals] fragment-steps=5:vertex-steps=0: FPS: 326 FrameTime: 3.076 ms
> [conditionals] fragment-steps=0:vertex-steps=5: FPS: 532 FrameTime: 1.880 ms
> [function] fragment-complexity=low:fragment-steps=5: FPS: 475 FrameTime:
>    2.106 ms
> [function] fragment-complexity=medium:fragment-steps=5: FPS: 227
>    FrameTime: 4.417 ms
> [loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 475
>    FrameTime: 2.108 ms
> [loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 474
>    FrameTime: 2.110 ms
> [loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 226
>    FrameTime: 4.428 ms
> =======================================================
>                                    glmark2 Score: 296
> =======================================================
> ```
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
> Changes in v2:
> - Rebased on next-20251021 tag
> - Fixed missing blank lines in 'arm64: dts: mediatek: mt8365: Add GPU
>    support' patch
> - Added reviewed-by and acked-by trailers
> - Updated cover letter
> - Link to v1: https://lore.kernel.org/r/20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com
> 
> ---
> Louis-Alexis Eyraud (3):
>        dt-bindings: gpu: mali-bifrost: Add compatible for MT8365 SoC
>        arm64: dts: mediatek: mt8365: Add GPU support
>        arm64: dts: mediatek: mt8365-evk: Enable GPU support
> 
>   .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |  9 +++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 43 +++++++++++++++++++++-
>   3 files changed, 52 insertions(+), 1 deletion(-)
> ---
> base-commit: 853c202e4aec8006c2c1367b052c9f8949db019a
> change-id: 20250812-mt8365-enable-gpu-a39835dca7fc
> 
> Best regards,



