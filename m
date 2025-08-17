Return-Path: <linux-kernel+bounces-772606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A51B294C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0757A4657
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3C2FF664;
	Sun, 17 Aug 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5MV2LqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1428399;
	Sun, 17 Aug 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455995; cv=none; b=qm9JVJ6tzIUKOMLJ8OD9xuIKQxJToVdfQinBXu8K9ZqegEZ52xo6kZwHxoBX47el30JYnYV9Ge2IG5QdCuL3qz1f/hCqd+BbLrHYS31eZHGdaStDiPcLhbsj5UFvPk+KEd6CJWE62n0QRrBVglWdAfevDjhInPq3XK4WQHSTOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455995; c=relaxed/simple;
	bh=m3PNNERXxwpCzkdnS/g84M24HexPmr502VnjyAPJFJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3ThFv+mP1+AvNgGTHw61XRIsPRG5NXYjn9S0Zo1PvAYf0Q3uxdVN2drGtlRIgNLUYZ8qjMWKM+431rw+aSHluUPK1/QpD9Z5fT1rS/DrWpSngB1vQo5WNqSObs9JAXP/ejoKht/JBVS34pdrQvzQZ4fvMhHLYUjx0wdtnGyQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5MV2LqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB7BC4CEF4;
	Sun, 17 Aug 2025 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755455994;
	bh=m3PNNERXxwpCzkdnS/g84M24HexPmr502VnjyAPJFJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5MV2LqV5LaNSHO32gXSptkeeQvdwAMfWW7X7n7y7rTWYI09NaoJG3Z9C3hepxBhr
	 dPGoUfZBzXnlxVUldR0sBdlw+z9HusCvmtzP9tIt/tG8YvzxKRZ2BYh8mkwxcB2vNE
	 WFXso5bMN0O9faE67bNcjStO7OtzvS8Ep3hAz2v7vNt7+Qvo9GpRheMJkvYVb/K/OA
	 iwgfeyTh7JYatQAJzzLJS9Qq+bboyEn8C6LCx9kadkPhgrNPXydEMvyKDF5nCzoEgU
	 CtU28F8rTR/etylIJzaHpDW5v2v+psolCfE8tzrpzkVBQbkXz7+7j5G9GNW8Dj9e5E
	 IOsSimuN2k63A==
Date: Sun, 17 Aug 2025 11:39:52 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
Message-ID: <aKIh+MLEO2aM/vO7@x1>
References: <20250814164048.2336043-1-uwu@icenowy.me>
 <20250814164048.2336043-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814164048.2336043-4-uwu@icenowy.me>

On Fri, Aug 15, 2025 at 12:40:43AM +0800, Icenowy Zheng wrote:
> This is a from-scratch driver targeting Verisilicon DC-series display
> controllers, which feature self-identification functionality like their
> GC-series GPUs.
> 
> Only DC8200 is being supported now, and only the main framebuffer is set
> up (as the DRM primary plane). Support for more DC models and more
> features is my further targets.
> 
> As the display controller is delivered to SoC vendors as a whole part,
> this driver does not use component framework and extra bridges inside a
> SoC is expected to be implemented as dedicated bridges (this driver
> properly supports bridge chaining).
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Thanks for working on this!

[snip]
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> new file mode 100644
> index 0000000000000..25d6e01cc8b71
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
[snip]
> +static void vs_primary_plane_atomic_update(struct drm_plane *plane,
> +					   struct drm_atomic_state *atomic_state)
> +{
> +	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
> +								       plane);
> +	struct drm_framebuffer *fb = state->fb;
> +	struct drm_crtc *crtc = state->crtc;
> +	struct drm_gem_dma_object *gem;
> +	struct vs_dc *dc;
> +	struct vs_crtc *vcrtc;
> +	struct vs_format fmt;
> +	unsigned int output, bpp;
> +	dma_addr_t dma_addr;
> +
> +	if (!crtc)
> +		return;
> +
> +	DRM_DEBUG_DRIVER("Updating output %d primary plane\n", output);

clang flagged this when building. I think this needs to be after the
line below that assigns vcrtc->id to output.

> +
> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	output = vcrtc->id;

Thanks,
Drew

