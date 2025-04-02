Return-Path: <linux-kernel+bounces-585125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45BA79002
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF2C3B663D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE3241682;
	Wed,  2 Apr 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b7o3idKS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C6241132
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600703; cv=none; b=YTOkBHeLf3Fvy6b+LXTTSlfroMwxnLH96MJP2LqZM63wDFYddu85x0W/h1L84sR4YLgIzdx2uMN5afl5TssNJirB02Ws4l9YJOHvdKw+TA6KqpQEh0tK1RZCHSyT0TZM+6smcVAlX2PqBj39g1qdvTTSoh+0qGDYo9Zyx3wkcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600703; c=relaxed/simple;
	bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Amn4wihRvY4kx3aS/FDHUJMFjL3ISPqFTl+uqDpxlZ77gcEjdsvKRnMBnK+xMCRFGPbi1+dqAfLrbAG+NagTB5xTSH4IiDx8po1Um27DCmNOf33Rjh9GESEjSLn8fVBaXcJeuHHzQHldlwt2tDqJaXG7MgsVzZispr+GostMULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=b7o3idKS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35CF12692;
	Wed,  2 Apr 2025 15:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1743600580;
	bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b7o3idKS0CIJQd12xZbk7pkr0of6nj4kKkfYGnSnpF9d1m1BgY6zY2CVKZTfzhna8
	 ym+7EhY/dbBmLXRWEtzYiWS6s06nZl2ME3w0WKnbWDo1RVhLRWM1r5kYgJ+DLsiGL2
	 oOQ76yaJqqkiw/TURKl0xC+3dnfSkPbUN5S6P9SA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 02 Apr 2025 16:30:57 +0300
Subject: [PATCH v2 15/18] drm/bridge: cdns-dsi: Tune adjusted_mode->clock
 according to dsi needs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-cdns-dsi-impro-v2-15-4a093eaa5e27@ideasonboard.com>
References: <20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com>
In-Reply-To: <20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn7Twgxd2MQmPHmB+c5V8EHmEtb/Ma4NoNeJFFH
 okaajIj6dWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+08IAAKCRD6PaqMvJYe
 9Xx6EACr8w3Wy7tZ/mGjzMi0iBuMtACBi7M6u7ZNYYoUtx/hNI41wyELcxkWPziEPXXLHZLI5o5
 OOKRhxBVbnEt9WFKmE9ZnxvQzawOOScnBxxud50n4zKDEu1aPKgIRjw7hGfQCcOTZ9quTJq39hw
 f6ZMrJrbFPJM6UwIzg5oO+BUHgNGKexWgaysxdgoI4sRzCfHmHiKHgqK1g38mfFtMsALClSyvEe
 x6DEcBiw3qt/cS9nbe/IuFjrWkZOZ+j0qokplEw4sRH07iVhhP81nBskOsn/tQCxc+IVCCRm2xf
 MnvlVBpy7M/QvkXTGIbERLTn9Bdo2QF9iJsp2EeJoSYtYqvCnuN99uHJhe0gOy3OILL2RykXdW3
 INUxLKoOK1z7nNf/pm4Go9S/bkU/lOJMR5UbYzalGsKfHErQQhQDkiCPttQ7y9O/F73A8jH+7jx
 w48VCs3dlBTRim+PocvtPz/zMtV6YZ4blKIcwmj0SxCQzR0m4x2EGLVmQL88reiAT69e62NDyDL
 zH/TruhsK3IHC0K4OzSTZegYYxmkXt9UIpntFfIvzXBbjCyJUEyTBpiclqjjkGdxZJvi8PITvWT
 1zgSwuf0ZduAO2cYHpqUu4hMq2q5PpV495OFhcS0juJXkeUk3LG0UYWGd47LSnYS87A0rgBPtUM
 in3ZgGDEtOn2rUA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver currently expects the pixel clock and the HS clock to be
compatible, but the DPHY PLL doesn't give very finely grained rates.
This often leads to the situation where the pipeline just fails, as the
resulting HS clock is just too off.

We could change the driver to do a better job on adjusting the DSI
blanking values, hopefully getting a working pipeline even if the pclk
and HS clocks are not exactly compatible. But that is a bigger work.

What we can do easily is to see in .atomic_check() what HS clock rate we
can get, based on the pixel clock rate, and then convert the HS clock
rate back to pixel clock rate and ask that rate from the crtc. If the
crtc has a good PLL (which is the case for TI K3 SoCs), this will fix
any issues wrt. the clock rates.

If the crtc cannot provide the requested clock, well, we're no worse off
with this patch than what we have at the moment.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 1a30e2f7d402..9f4f7b6c8330 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -966,6 +966,28 @@ static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static long cdns_dsi_round_pclk(struct cdns_dsi *dsi, unsigned long pclk)
+{
+	struct cdns_dsi_output *output = &dsi->output;
+	unsigned int nlanes = output->dev->lanes;
+	union phy_configure_opts phy_opts = { 0 };
+	u32 bitspp;
+	int ret;
+
+	bitspp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
+
+	ret = phy_mipi_dphy_get_default_config(pclk, bitspp, nlanes,
+					       &phy_opts.mipi_dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_validate(dsi->dphy, PHY_MODE_MIPI_DPHY, 0, &phy_opts);
+	if (ret)
+		return ret;
+
+	return div64_u64((u64)phy_opts.mipi_dphy.hs_clk_rate * nlanes, bitspp);
+}
+
 static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
@@ -978,12 +1000,27 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	struct cdns_dsi_cfg *dsi_cfg = &dsi_state->dsi_cfg;
 	struct drm_display_mode *adjusted_crtc_mode = &crtc_state->adjusted_mode;
 	struct videomode vm;
+	long pclk;
 
 	/* cdns-dsi requires negative syncs */
 	adjusted_crtc_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	adjusted_crtc_mode->flags |= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
 
-	drm_display_mode_to_videomode(mode, &vm);
+	/*
+	 * The DPHY PLL has quite a coarsely grained clock rate options. See
+	 * what hsclk rate we can achieve based on the pixel clock, convert it
+	 * back to pixel clock, set that to the adjusted_mode->clock. This is
+	 * all in hopes that the CRTC will be able to provide us the requested
+	 * clock, as otherwise the DPI and DSI clocks will be out of sync.
+	 */
+
+	pclk = cdns_dsi_round_pclk(dsi, mode->clock * 1000);
+	if (pclk < 0)
+		return (int)pclk;
+
+	adjusted_crtc_mode->clock = pclk / 1000;
+
+	drm_display_mode_to_videomode(adjusted_crtc_mode, &vm);
 
 	return cdns_dsi_check_conf(dsi, &vm, dsi_cfg);
 }

-- 
2.43.0


