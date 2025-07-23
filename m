Return-Path: <linux-kernel+bounces-741951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BEB0EB22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FE1890DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86DF26C3B6;
	Wed, 23 Jul 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKhPyGyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8D214A94;
	Wed, 23 Jul 2025 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254032; cv=none; b=paP723Jadaq6PvhN8IuUexUvVuC/aOA0WXBuKR+UJ7rcIRF8pcwOCzlPxAODviIR/0s0Fa2qFEba+J13TQSBzHaRSXtB8dOxunlQ+tDEQ6eHGK2a1a8jNm9BkOxyNOs5GPEnqTiCEA++Knr/vu1QPrR6sWPcyqMj3uXWFbQOye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254032; c=relaxed/simple;
	bh=wW/NANZXtRsrRb6yTQzi4GEySri56dolua6xnk0Y0Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muFxf9IH/F0WyNAxLpThgRoQwWuoj3AZ6iW/f+HMKgZKBxZyqg37ZY1TK4STX4U6Pbp9E2xGZi9mdRkEP8rVoKJWmcc04Ibyn+RUttW9xPa8Ia18AKus7Yd7oxFtvbYBgVazLjnBxjLlKwf9zOul9l296aEZYFdJjvtOxoWQ58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKhPyGyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12281C4CEE7;
	Wed, 23 Jul 2025 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753254031;
	bh=wW/NANZXtRsrRb6yTQzi4GEySri56dolua6xnk0Y0Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKhPyGyQSJnI8SyBP+wJm/Q6gO9T1K5LC9SSO/8Pm/Jt8l3SSYgovovKoaIKd9nUV
	 WOOxfDat0LVYJbYJYPOSLTB8iI3MqH/eZLAX4HLJxYuqz3nvmoJaEjWQqV+6QPVSO3
	 PA13J/3VZGPMt3uoCNfpciMTlE1tL7K6tKLIqX2ROyusiSBbP6qaDS9veRk4cA+Pw3
	 2E9jzR8WgVw3OFPBQtHi1cAq3hwRYM7ykM2MO6GtEDzMn/rf9WhteNUc9scvkSav4I
	 7whsZutIYqfKWrEu1obi7UqMmXNK9qRHkbeujbeao3p7mbL/H+/+LK8XfD6F8nqjuf
	 vGQtPVz8DIAhQ==
Date: Wed, 23 Jul 2025 09:00:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] drm: sprd: add clock gating support
Message-ID: <20250723-resourceful-intrepid-beaver-cbeada@houat>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-10-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dfwdqze26gngqvjd"
Content-Disposition: inline
In-Reply-To: <20250722-ums9230-drm-v2-10-054276ec213d@abscue.de>


--dfwdqze26gngqvjd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 10/15] drm: sprd: add clock gating support
MIME-Version: 1.0

Hi,

On Tue, Jul 22, 2025 at 04:41:12PM +0200, Otto Pfl=FCger wrote:
> Enable the DPU and DSI clocks specified in the device tree.
> Disable the DSI clock when it is not needed.
>=20
> Signed-off-by: Otto Pfl=FCger <otto.pflueger@abscue.de>
> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 7 +++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h | 1 +
>  drivers/gpu/drm/sprd/sprd_dsi.c | 9 +++++++++
>  drivers/gpu/drm/sprd/sprd_dsi.h | 4 +++-
>  4 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_=
dpu.c
> index 0d9eb778794d92418b39f8535d94abde3566de43..9d274600e6a80bdfc435f6c6e=
ff77c9dd71cb38c 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2020 Unisoc Inc.
>   */
> =20
> +#include <linux/clk.h>
>  #include <linux/component.h>
>  #include <linux/delay.h>
>  #include <linux/dma-buf.h>
> @@ -794,6 +795,12 @@ static int sprd_dpu_context_init(struct sprd_dpu *dp=
u,
>  	if (ctx->irq < 0)
>  		return ctx->irq;
> =20
> +	ctx->clk =3D devm_clk_get_optional_enabled(dev, "core");
> +	if (IS_ERR(ctx->clk)) {
> +		dev_err(dev, "failed to get DPU core clock\n");
> +		return PTR_ERR(ctx->clk);
> +	}
> +
>  	/* disable and clear interrupts before register dpu IRQ. */
>  	writel(0x00, ctx->base + REG_DPU_INT_EN);
>  	writel(0xff, ctx->base + REG_DPU_INT_CLR);
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.h b/drivers/gpu/drm/sprd/sprd_=
dpu.h
> index 157a78f24dc18b071602552ea9d005af66525263..d48b922de580a8a4bf07c4610=
c431d3321f7b810 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.h
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.h
> @@ -44,6 +44,7 @@ enum {
>   */
>  struct dpu_context {
>  	void __iomem *base;
> +	struct clk *clk;
>  	int irq;
>  	u8 if_type;
>  	struct videomode vm;
> diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_=
dsi.c
> index e01d1d28fe579644ec2e0c83ec9170269932adfe..2af4273a6c73185084290c9d1=
4b8ac18914d514b 100644
> --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> @@ -828,6 +828,8 @@ static void sprd_dsi_bridge_pre_enable(struct drm_bri=
dge *bridge)
>  	struct sprd_dsi *dsi =3D bridge_to_dsi(bridge);
>  	struct dsi_context *ctx =3D &dsi->ctx;
> =20
> +	clk_prepare_enable(ctx->clk);
> +
>  	if (ctx->enabled) {
>  		drm_warn(dsi->drm, "dsi is initialized\n");
>  		return;
> @@ -875,6 +877,8 @@ static void sprd_dsi_bridge_post_disable(struct drm_b=
ridge *bridge)
>  	sprd_dphy_fini(ctx);
>  	sprd_dsi_fini(ctx);
> =20
> +	clk_disable_unprepare(ctx->clk);
> +
>  	ctx->enabled =3D false;
>  }

I'm a bit confused. Why do you need to enable / disable that clock in
pre_enable / post_disable, if you already enabled it at probe?

Maxime

--dfwdqze26gngqvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaICIjAAKCRAnX84Zoj2+
dsJ2AX9b3c/x8RZ5fufX1wsSTUznjcNjGoo+HDY35lpT24oIZmffvwK5PwyHIQjv
qImRz74BgMdZ0Vcavf4aO1xi8PxxtE1cu9jRYAi+6GyU08sEKErAKRbrKHs6SyrS
ft+L30QIDw==
=+kcQ
-----END PGP SIGNATURE-----

--dfwdqze26gngqvjd--

