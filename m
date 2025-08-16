Return-Path: <linux-kernel+bounces-771896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C7B28CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434BFAE7922
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF228C851;
	Sat, 16 Aug 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="flAjoqaL"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646C28CF77;
	Sat, 16 Aug 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338712; cv=none; b=kSQSJvUjTNWbhmMBxOvYfuWG0MzVDXIipqw5BXOGggPcJIcqSpZSYXj10v1bpuqFB2y96+QQhjhfEgp5PUhKD6l3DBZqhr4N2+9LskrlzEKMdiIbPwY49WPN87IVa73sfip5jDu57qk9oIGz09rydxAMXhrw88bJ+UIGURSNsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338712; c=relaxed/simple;
	bh=5L967NphMLPRWeIE/xd6L5BN1UltYPBYco7lnin4VcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6AwOpuaxSLsCGix0a1vi0QHfLrCt1Sv+sXECAwCmjukqg7ixK7/x4a+OlAhg8Za6uSd0g+8+QlkCSLhLSRxjEJbjU0zAIT6oo+q6Q+ztaSxpjyV8BtGNAY3d6jf5raXwNF/D49dx7Sh42yVpAtkygkrnrvI/cVTl5yrwVWbskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=flAjoqaL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 841E120C9D;
	Sat, 16 Aug 2025 12:05:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdLs0zKOoopx; Sat, 16 Aug 2025 12:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755338705; bh=5L967NphMLPRWeIE/xd6L5BN1UltYPBYco7lnin4VcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=flAjoqaL8RO8TGVRX220W+zP2hvvX1L9wnB3dMr8PqHaGJE1wGTaLj3yguHdxRNEt
	 7MW06a6ESHeIj73NC9h93LSaNhdCqZai/jZgWJvgeV6k78+fBY28Gpai3ZGVvan2nl
	 pikW+gHRv1JNY3/WT8olzS83GI5pQrk4k/6kPyHETfdNvnsrJzEAMzRR5JY5an3LeL
	 /MDVtr0fVsiyWU4j9qT2tHC0FFd/S9o4emezTAWtGd/6hYy3Nj0IslwOWKH79frZkQ
	 s3RCBguY8AQbHEyH5KYWyBHx/8A4NLLsI5r/4wVqtYly/pKt7z5iPopM0yNCyd4oll
	 fiCkRgsRisA+w==
Date: Sat, 16 Aug 2025 10:04:33 +0000
From: Yao Zi <ziyao@disroot.org>
To: Icenowy Zheng <uwu@icenowy.me>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
Message-ID: <aKBXscthC1U6x5b4@pie>
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

Thank you for the great work!

> ---
>  drivers/gpu/drm/Kconfig                       |   2 +
>  drivers/gpu/drm/Makefile                      |   1 +
>  drivers/gpu/drm/verisilicon/Kconfig           |  15 +
>  drivers/gpu/drm/verisilicon/Makefile          |   5 +
>  drivers/gpu/drm/verisilicon/vs_bridge.c       | 330 ++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_bridge.h       |  40 +++
>  drivers/gpu/drm/verisilicon/vs_bridge_regs.h  |  47 +++
>  drivers/gpu/drm/verisilicon/vs_crtc.c         | 217 ++++++++++++
>  drivers/gpu/drm/verisilicon/vs_crtc.h         |  29 ++
>  drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |  60 ++++
>  drivers/gpu/drm/verisilicon/vs_dc.c           | 233 +++++++++++++
>  drivers/gpu/drm/verisilicon/vs_dc.h           |  39 +++
>  drivers/gpu/drm/verisilicon/vs_dc_top_regs.h  |  27 ++
>  drivers/gpu/drm/verisilicon/vs_drm.c          | 177 ++++++++++
>  drivers/gpu/drm/verisilicon/vs_drm.h          |  29 ++
>  drivers/gpu/drm/verisilicon/vs_hwdb.c         | 150 ++++++++
>  drivers/gpu/drm/verisilicon/vs_hwdb.h         |  29 ++
>  drivers/gpu/drm/verisilicon/vs_plane.c        | 102 ++++++
>  drivers/gpu/drm/verisilicon/vs_plane.h        |  68 ++++
>  .../gpu/drm/verisilicon/vs_primary_plane.c    | 166 +++++++++
>  .../drm/verisilicon/vs_primary_plane_regs.h   |  53 +++
>  21 files changed, 1819 insertions(+)
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_top_regs.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> 

...

> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
> new file mode 100644
> index 0000000000000..c8caf31fac7d6
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c

...

> +static bool vs_bridge_out_dp_fmt_supported(u32 out_fmt)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsdc_dp_supported_fmts); i++)
> +		if (vsdc_dp_supported_fmts[i].linux_fmt == out_fmt)
> +			break;
> +
> +	return !(i == ARRAY_SIZE(vsdc_dp_supported_fmts));

You could simplify the return statement by returning early in the loop
if out_fmt matches.

> +}

> +static int vs_bridge_detect_output_interface(struct device_node *of_node,
> +					     unsigned int output)
> +{
> +	int ret;
> +	struct device_node *remote;
> +
> +	remote = of_graph_get_remote_node(of_node, output,
> +					  VSDC_OUTPUT_INTERFACE_DPI);
> +	if (remote) {
> +		ret = VSDC_OUTPUT_INTERFACE_DPI;
> +	} else {
> +		remote = of_graph_get_remote_node(of_node, output,
> +						  VSDC_OUTPUT_INTERFACE_DP);
> +		if (remote)
> +			ret = VSDC_OUTPUT_INTERFACE_DP;
> +		else
> +			ret = -ENODEV;
> +	}

remote is leaked here, it should be released with of_node_put IMHO.

> +	return ret;
> +}
> +
> +struct vs_bridge *vs_bridge_init(struct drm_device *drm_dev,
> +				 struct vs_crtc *crtc)
> +{
> +	unsigned int output = crtc->id;
> +	struct vs_bridge *bridge;
> +	struct drm_bridge *next;
> +	enum vs_bridge_output_interface intf;
> +	int ret;

...

> +	bridge = devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge)
> +		return ERR_PTR(-ENOMEM);

...

> +err_cleanup_encoder:
> +	drm_encoder_cleanup(&bridge->enc);
> +err_free_bridge:
> +	devm_kfree(drm_dev->dev, bridge);

Though is technically correct, this devm_kfree() is unnecessary.
Resources registered with devres are automatically released when probing
fails[1][2].

> +	return ERR_PTR(ret);
> +}

...

> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> new file mode 100644
> index 0000000000000..46c4191b82f49
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -0,0 +1,217 @@

...

> +static enum drm_mode_status
> +vs_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
> +{
> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	struct vs_dc *dc = vcrtc->dc;
> +	unsigned int output = vcrtc->id;
> +	long rate;
> +
> +	if (mode->htotal > 0x7FFF)
> +		return MODE_BAD_HVALUE;
> +	if (mode->vtotal > 0x7FFF)
> +		return MODE_BAD_VVALUE;
> +
> +	rate = clk_round_rate(dc->pix_clk[output], mode->clock * 1000);
> +	if (rate <= 0)
> +		return MODE_CLOCK_RANGE;

Some round_rate implementations may not return zero or error on an
unsupported clock rate, instead they simply return a value differing a
lot from the requested rate. Thus I think you should also check whether
the resulted rate is acceptable as well, which applies for
vs_crtc_mode_fixup() as well.

> +	return MODE_OK;
> +}
> +
> +static bool vs_crtc_mode_fixup(struct drm_crtc *crtc,
> +			       const struct drm_display_mode *m,
> +			       struct drm_display_mode *adjusted_mode)
> +{
> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	struct vs_dc *dc = vcrtc->dc;
> +	unsigned int output = vcrtc->id;
> +	long clk_rate;
> +
> +	drm_mode_set_crtcinfo(adjusted_mode, 0);
> +
> +	/* Feedback the pixel clock to crtc_clock */
> +	clk_rate = adjusted_mode->crtc_clock * 1000;
> +	clk_rate = clk_round_rate(dc->pix_clk[output], clk_rate);
> +	if (clk_rate <= 0)
> +		return false;
> +
> +	adjusted_mode->crtc_clock = clk_rate / 1000;
> +
> +	return true;
> +}

...

> +struct vs_crtc *vs_crtc_init(struct drm_device *drm_dev, struct vs_dc *dc,
> +			     unsigned int output)
> +{
> +	struct vs_crtc *vcrtc;
> +	struct drm_plane *primary;
> +	int ret;
> +
> +	vcrtc = devm_kzalloc(drm_dev->dev, sizeof(*vcrtc), GFP_KERNEL);
> +	if (!vcrtc)
> +		return ERR_PTR(-ENOMEM);
> +	vcrtc->dc = dc;
> +	vcrtc->id = output;
> +
> +	/* Create our primary plane */
> +	primary = vs_primary_plane_init(drm_dev, dc);
> +	if (IS_ERR(primary)) {
> +		dev_err(drm_dev->dev, "Couldn't create the primary plane\n");
> +		return ERR_PTR(PTR_ERR(primary));
> +	}

Suggest dev_err_probe which handles deferred probing as well.

> +
> +	ret = drm_crtc_init_with_planes(drm_dev, &vcrtc->base,
> +					primary,
> +					NULL,
> +					&vs_crtc_funcs,
> +					NULL);
> +	if (ret) {
> +		dev_err(drm_dev->dev, "Couldn't initialize CRTC\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	drm_crtc_helper_add(&vcrtc->base, &vs_crtc_helper_funcs);
> +
> +	return vcrtc;
> +}

...

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
> new file mode 100644
> index 0000000000000..98384559568c4
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +
> +#include "vs_crtc.h"
> +#include "vs_dc.h"
> +#include "vs_dc_top_regs.h"
> +#include "vs_drm.h"
> +#include "vs_hwdb.h"
> +
> +static const struct regmap_config vs_dc_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	/* VSDC_OVL_CONFIG_EX(1) */
> +	.max_register = 0x2544,
> +	.cache_type = REGCACHE_NONE,

I think cache_type = REGCACHE_NONE is the default, thus it should be
okay to omitted it?

> +};

...

> +static int vs_dc_probe(struct platform_device *pdev)
> +{

...

> +	dc->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(dc->core_clk)) {
> +		dev_err(dev, "can't get core clock\n");
> +		return PTR_ERR(dc->core_clk);
> +	}
> +
> +	dc->axi_clk = devm_clk_get(dev, "axi");
> +	if (IS_ERR(dc->axi_clk)) {
> +		dev_err(dev, "can't get axi clock\n");
> +		return PTR_ERR(dc->axi_clk);
> +	}
> +
> +	dc->ahb_clk = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(dc->ahb_clk)) {
> +		dev_err(dev, "can't get ahb clock\n");
> +		return PTR_ERR(dc->ahb_clk);
> +	}

I think devm_clk_get_enabled() will help here.

> +	for (i = 0; i < outputs; i++) {
> +		snprintf(pixclk_name, sizeof(pixclk_name), "pix%u", i);
> +		dc->pix_clk[i] = devm_clk_get(dev, pixclk_name);
> +		if (IS_ERR(dc->pix_clk[i])) {
> +			dev_err(dev, "can't get pixel clk %u\n", i);
> +			return PTR_ERR(dc->pix_clk[i]);
> +		}
> +	}

...

> +err_ahb_clk_disable:
> +	clk_disable_unprepare(dc->ahb_clk);
> +err_axi_clk_disable:
> +	clk_disable_unprepare(dc->axi_clk);
> +err_core_clk_disable:
> +	clk_disable_unprepare(dc->core_clk);

And you could get avoid these clk_disable_unprepare(). Also the ones in
the remove callback.

> +err_rst_assert:
> +	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +	return ret;
> +}
> +
> +static void vs_dc_remove(struct platform_device *pdev)
> +{
> +	struct vs_dc *dc = dev_get_drvdata(&pdev->dev);
> +
> +	vs_drm_finalize(dc);
> +
> +	dev_set_drvdata(&pdev->dev, NULL);
> +
> +	clk_disable_unprepare(dc->ahb_clk);
> +	clk_disable_unprepare(dc->axi_clk);
> +	clk_disable_unprepare(dc->core_clk);
> +	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +}

...

> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> new file mode 100644
> index 0000000000000..25d6e01cc8b71
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> + */
> +
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_fb_dma_helper.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_print.h>
> +
> +#include "vs_crtc.h"
> +#include "vs_plane.h"
> +#include "vs_dc.h"
> +#include "vs_primary_plane_regs.h"
> +
> +static int vs_primary_plane_atomic_check(struct drm_plane *plane,
> +					 struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
> +										 plane);
> +	struct drm_crtc *crtc = new_plane_state->crtc;
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_existing_crtc_state(state,
> +							crtc);

I think these arguments could be merged into a single line.

> +	if (WARN_ON(!crtc_state))
> +		return -EINVAL;
> +
> +	return drm_atomic_helper_check_plane_state(new_plane_state,
> +						   crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, true);
> +}

...

> +struct drm_plane *vs_primary_plane_init(struct drm_device *drm_dev, struct vs_dc *dc)
> +{
> +	struct drm_plane *plane;
> +	int ret;
> +
> +	plane = devm_kzalloc(drm_dev->dev, sizeof(*plane), GFP_KERNEL);
> +	if (!plane)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = drm_universal_plane_init(drm_dev, plane, 0,
> +				       &vs_primary_plane_funcs,
> +				       dc->identity.formats->array,
> +				       dc->identity.formats->num,
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY,
> +				       NULL);
> +
> +	if (ret) {
> +		devm_kfree(drm_dev->dev, plane);

Similar to vs_bridge_init's case, this devm_kfree() isn't unnecessary,
either.

> +		return ERR_PTR(ret);
> +	}
> +
> +	drm_plane_helper_add(plane, &vs_primary_plane_helper_funcs);
> +
> +	return plane;
> +}

Best regards,
Yao Zi

[1]: https://elixir.bootlin.com/linux/v6.16/source/drivers/base/dd.c#L723
[2]: https://elixir.bootlin.com/linux/v6.16/source/drivers/base/dd.c#L549

