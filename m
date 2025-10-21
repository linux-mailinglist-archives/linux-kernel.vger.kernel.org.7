Return-Path: <linux-kernel+bounces-862929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FFBF68D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916873BDBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28D333740;
	Tue, 21 Oct 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CIUe4zA6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631132B99A;
	Tue, 21 Oct 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051086; cv=pass; b=GQDLeb/2hRWXL4s5Jwbu+JbGyzG51Q6WW0y8auzHR12dvfimO7XmWGQdWVHhMtPghjVCUoVjSFKJHJvW40TiWpcHIULFNWk6y/wGSzw6w6TMtDGEGXxmQx9apPpFlhwd0S8EgT8YdxtJcwblSKJ+/omCyZgLwWkUWd9i0NDwCFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051086; c=relaxed/simple;
	bh=niOXTcBT3QO9AQGZdhg/L3FZ6iIn95kzYMmJAxUtWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK3Z2oOTDR8K9+fhTwBK3QsXWybqFqQljOKfyQtdhl8tk3+jVZs/wn+mvZgXB7xYJTd5Rb32uFqvoBK7rN8DimcvFWQseW61Mg9GW/wgmbQXDIUiZaq1q+BAAt1tvWnpZ9p5H9vtbLAgoyH8xcWeZWk9fiRNcYEWvCemu5foNuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CIUe4zA6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761051051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lzHgoYFKgS6RXH252NfGtH5MKLPjYZwcdKP6Hm4hhKvhh636hEasRNBCz0mEkhfymDtl1ejemeWqMlWmODTub2iEZZp3GRJGhyli0ze1rLtq9YjFUZSu3TKDs+b/9alKnoppTOSErgWicKM2N9ogMy2pkqQuvCyO50Iorv/EEPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761051051; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sVBs5E3IrDShRMqJSob7W9r3Q2rnou+h3QXZROh8of0=; 
	b=cL/tOcRYcCRSBuBtSMMvi1aTFLCeP5/8SZ0nHgqqq+TJeY9N+wOHSS9cqiBayakZwbwnrSYt5LKpvdSRU+MPagz0GamYHbEruDK33UBSqbNeyJmsQVzIWJpCAG6RQbuCLaTCZFzh4KmPHQnZ36HQM4Xdq3VNqPk5AoD0rImhvXc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761051051;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sVBs5E3IrDShRMqJSob7W9r3Q2rnou+h3QXZROh8of0=;
	b=CIUe4zA6cMdyn5fizicruc74iBFytep1RKW60SFwRu2m09eg64yshzB4DdS8YG+V
	hjFD0Lc2hHrB5/XfgXLwcAM0BhvMtkbixfllwJmnfyTwJHWNTHC9a52Qk8Cvj6L+O//
	OyDVd2WN0Gqqa9N/nDFvdGZI4KkHU8dwhnJs5ZCQ=
Received: by mx.zohomail.com with SMTPS id 1761051048276913.6194416974873;
	Tue, 21 Oct 2025 05:50:48 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id D227918374D; Tue, 21 Oct 2025 14:50:39 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:50:39 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/3] Add Mali GPU support for Mediatek MT8365 SoC
Message-ID: <e3hyej2bjtyjlwcpzupomvjzyqkwyclhvoyesgzq3byk3slom4@7bs5zsaxjq6t>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
 <0e5ca992-730d-42c5-b5b8-5ad04116b8d4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5ca992-730d-42c5-b5b8-5ad04116b8d4@collabora.com>
X-ZohoMailClient: External

[+cc Boris, Steven]

Hi,

On Tue, Oct 21, 2025 at 10:03:52AM +0200, AngeloGioacchino Del Regno wrote:
> Il 21/10/25 09:30, Louis-Alexis Eyraud ha scritto:
> > This patchset adds the support of the ARM Mali G52 MC1 GPU (Bifrost),
> > integrated to the Mediatek MT8365 SoC, and its enablement to the
> > Mediatek Genio 350-EVK board.
> > 
> > I've tested this patchset on a Mediatek Genio 350-EVK board,
> > with a kernel based on linux-next (tag: next-20251021).
> > 
> 
> Thanks for this one! This series is ready to be merged.
> 
> However, in order to take the DT patches I need someone to pick
> the binding first.

The binding patch submission is missing most of the maintainers
potentially doing that in To/Cc ;)

Somebody should update the MAINTAINERS entry for "ARM MALI PANFROST
DRM DRIVER" to include the binding file, just like it is handled for
the PANTHOR driver in the next section.

Greetings,

-- Sebastian


> 
> Cheers,
> Angelo
> 
> > The panfrost driver probed with the following messages:
> > ```
> > panfrost 13040000.gpu: clock rate = 450000031
> > panfrost 13040000.gpu: mali-g52 id 0x7402 major 0x1 minor 0x0 status
> >    0x0
> > panfrost 13040000.gpu: features: 00000000,00000df7, issues: 00000000,
> >    00000400
> > panfrost 13040000.gpu: Features: L2:0x07110206 Shader:0x00000003
> >   Tiler:0x00000209 Mem:0x1 MMU:0x00002823 AS:0xff JS:0x7
> > panfrost 13040000.gpu: shader_present=0x1 l2_present=0x1
> > [drm] Initialized panfrost 1.5.0 for 13040000.gpu on minor 0
> > ```
> > 
> > Running glmark2-es2-drm with MESA 25.2 is also OK:
> > ```
> > =======================================================
> >      glmark2 2023.01
> > =======================================================
> >      OpenGL Information
> >      GL_VENDOR:      Mesa
> >      GL_RENDERER:    Mali-G52 r1 (Panfrost)
> >      GL_VERSION:     OpenGL ES 3.1 Mesa 25.2.5-1
> >      Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
> >      Surface Size:   1200x1920 fullscreen
> > =======================================================
> > [build] use-vbo=false: FPS: 513 FrameTime: 1.952 ms
> > [build] use-vbo=true: FPS: 514 FrameTime: 1.947 ms
> > [texture] texture-filter=nearest: FPS: 489 FrameTime: 2.046 ms
> > [texture] texture-filter=linear: FPS: 486 FrameTime: 2.061 ms
> > [texture] texture-filter=mipmap: FPS: 476 FrameTime: 2.101 ms
> > [shading] shading=gouraud: FPS: 436 FrameTime: 2.296 ms
> > [shading] shading=blinn-phong-inf: FPS: 387 FrameTime: 2.585 ms
> > [shading] shading=phong: FPS: 253 FrameTime: 3.955 ms
> > [shading] shading=cel: FPS: 232 FrameTime: 4.328 ms
> > [bump] bump-render=high-poly: FPS: 266 FrameTime: 3.765 ms
> > [bump] bump-render=normals: FPS: 421 FrameTime: 2.376 ms
> > [bump] bump-render=height: FPS: 343 FrameTime: 2.922 ms
> > [effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 133 FrameTime: 7.521 ms
> > [effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 46 FrameTime:
> >    21.990 ms
> > [pulsar] light=false:quads=5:texture=false: FPS: 379 FrameTime: 2.645 ms
> > [desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4:
> >    FPS: 57 FrameTime: 17.735 ms
> > [desktop] effect=shadow:windows=4: FPS: 249 FrameTime: 4.018 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction
> >    =0.5:update-method=map: FPS: 81 FrameTime: 12.447 ms
> > [buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction
> >    =0.5:update-method=subdata: FPS: 81 FrameTime: 12.388 ms
> > [buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction
> >    =0.5:update-method=map: FPS: 99 FrameTime: 10.127 ms
> > [ideas] speed=duration: FPS: 287 FrameTime: 3.492 ms
> > [jellyfish] <default>: FPS: 114 FrameTime: 8.842 ms
> > [terrain] <default>: FPS: 14 FrameTime: 76.911 ms
> > [shadow] <default>: FPS: 156 FrameTime: 6.432 ms
> > [refract] <default>: FPS: 29 FrameTime: 34.791 ms
> > [conditionals] fragment-steps=0:vertex-steps=0: FPS: 529 FrameTime: 1.890 ms
> > [conditionals] fragment-steps=5:vertex-steps=0: FPS: 326 FrameTime: 3.076 ms
> > [conditionals] fragment-steps=0:vertex-steps=5: FPS: 532 FrameTime: 1.880 ms
> > [function] fragment-complexity=low:fragment-steps=5: FPS: 475 FrameTime:
> >    2.106 ms
> > [function] fragment-complexity=medium:fragment-steps=5: FPS: 227
> >    FrameTime: 4.417 ms
> > [loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 475
> >    FrameTime: 2.108 ms
> > [loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 474
> >    FrameTime: 2.110 ms
> > [loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 226
> >    FrameTime: 4.428 ms
> > =======================================================
> >                                    glmark2 Score: 296
> > =======================================================
> > ```
> > 
> > Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> > ---
> > Changes in v2:
> > - Rebased on next-20251021 tag
> > - Fixed missing blank lines in 'arm64: dts: mediatek: mt8365: Add GPU
> >    support' patch
> > - Added reviewed-by and acked-by trailers
> > - Updated cover letter
> > - Link to v1: https://lore.kernel.org/r/20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com
> > 
> > ---
> > Louis-Alexis Eyraud (3):
> >        dt-bindings: gpu: mali-bifrost: Add compatible for MT8365 SoC
> >        arm64: dts: mediatek: mt8365: Add GPU support
> >        arm64: dts: mediatek: mt8365-evk: Enable GPU support
> > 
> >   .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  1 +
> >   arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |  9 +++++
> >   arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 43 +++++++++++++++++++++-
> >   3 files changed, 52 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 853c202e4aec8006c2c1367b052c9f8949db019a
> > change-id: 20250812-mt8365-enable-gpu-a39835dca7fc
> > 
> > Best regards,
> 
> 

