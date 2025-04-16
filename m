Return-Path: <linux-kernel+bounces-602745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BBA87EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50AD176E47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCE2BF3E4;
	Mon, 14 Apr 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O6LZ5rRQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194302BE7D7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629153; cv=none; b=GpxZb1kQXdEQSZNvOJ0dcp25mbYJnczFutoTIKtufSAuXGFBA8OsElUUjDclbmSLKkk1alJwuPs2Xk8vld+A9ZeTEm5Eq+evXn1iCLutzRdZigXQo0YLY8lWlaI8Tycr+M6inr3++n7iuVjYeAE9tOJkYhUmai4qYcGgJ/UkIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629153; c=relaxed/simple;
	bh=7gT6INJdKQdfYGfAzCjzG+NZhY/z+fVKVIvW5xYYBGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMCbzDNOCcoW6cUMB9r526UL1TenuGIwXBg2I6JwO21YCYf1xc1VWOZDHXBrx4EdRgVMheJVKXwydDyyjKW3BS6XiBQcwW3TzNnVvdFHj5T7Y+ZMDLQkXb33WLzKfh2zv+xeCCJzjDWyM63y4f1qBd9gVFyJFuSgu8g9yHCcxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O6LZ5rRQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F385193E;
	Mon, 14 Apr 2025 13:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744629016;
	bh=7gT6INJdKQdfYGfAzCjzG+NZhY/z+fVKVIvW5xYYBGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O6LZ5rRQi8KuR/ykKwUoWVbmtT5NSv0ELrPbQ9/ZIs6qH6xXe+sBJxZRFhkOUclG6
	 nIlQsE2SM76uUFKnz7nsn5bIIUHmSoAJHBaQe1f8KjLq9cjm4SegsN6S1vGpFsdUQQ
	 z+Ihsz4tfpJ2qov+ifIe8aLrEvh9//nEoEFp2QM8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 14 Apr 2025 14:11:20 +0300
Subject: [PATCH v3 11/17] drm/bridge: cdns-dsi: Drop
 cdns_dsi_adjust_phy_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-cdns-dsi-impro-v3-11-4e52551d4f07@ideasonboard.com>
References: <20250414-cdns-dsi-impro-v3-0-4e52551d4f07@ideasonboard.com>
In-Reply-To: <20250414-cdns-dsi-impro-v3-0-4e52551d4f07@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=7gT6INJdKQdfYGfAzCjzG+NZhY/z+fVKVIvW5xYYBGk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn/O2AM93ZewkCW9E31nEP1pKgMpPqnUjfnMiuz
 qpLdeOKPk+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ/ztgAAKCRD6PaqMvJYe
 9YtcEACRXHyXTOfbAEy90s9aH2r3wItViyoFqOdTQP8mTiy1LNEUv3maXZQ0EpxNZ1qB8lj5CDQ
 avTnmzrUYCxDckYjW/FHcIpY5BHBY2+Lcbe2rvK7wagjrA+lOoFGbnzW8NCsTBKe6AMlp5LFim1
 cCF+cq7tAoJB7lMjYGKonxLV/TGF0yMFKZmpnPa4RY5rrK6bPjrGIm5SQ6a6YLa7TVWfi8ODdox
 twaI/kiuk9kw8TcLDlAKyPlB93HHLtQRCp2STDlax+EDgFBag7P48zMK/9tGtS3XB7UmJmR9ohe
 3ZOH58gkLRJnb3oG/aUm259Jr1xXnb9LS6N/VOwVY+5ykp9NOZLDcwGoJ8DzDsQIyubaZJ8pICV
 A1V9VuTMFPqp7axtYqh2le4+H/drrQJ27umnEotbEuecowGVdJdGAHUKQIEUvErtz8n+4rl1REK
 GTCv0FMUwJZe0yJtKb9Zkgc/07gsMuGrcc7uGgSqcT73W2e52tg9me4h89KyymdUz9ZtuXQRK6+
 P1ckki986b7VYGHa2I5MJkb/qQUQ0QakC834LdNPMORih5yp4ciNs0uO+Eli4EiDW8juYE12jIV
 OFBIy6xvf23o6LvR8sz/dQaMuN0CrKsPMPOVz+PKRJHncvvYJXgGf2HesyhWcxz46GicWy3clJ3
 ql49XAG5+ViW0yQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

cdns_dsi_adjust_phy_config() is called from cdns_dsi_check_conf(), which
is called from .atomic_check(). It checks the DSI htotal and adjusts it
to align on the DSI lane boundary by changing hfp and then recalculating
htotal and HS clock rate.

This has a few problems.

First is the fact that the whole thing is not needed: we do not need to
align on the lane boundary. The whole frame is sent in HS mode, and it
is fine if the line's last byte clock tick fills, say, only 2 of the 4
lanes. The next line will just continue from there. Assuming the
DSI timing values have been calculated to match the incoming DPI stream,
and the HS clock is compatible with the DPI pixel clock, the "uneven"
DSI lines will even out when multiple lines are being sent.

But we could do the align, aligning is not a problem as such. However,
adding more bytes to the hfp, as the function currently does, makes the
DSI line time longer, so the function then adjusts the HS clock rate.
This is where things fail: we don't know what rates we can get from the
HS clock, and at least in TI K3 SoC case the rates are quite coarsely
grained. Thus small adjustment to hfp will lead to a big change in HS
clock rate, and things break down.

We could do a loop here, adjusting hfp, adjusting clock, checking clock
rate, adjusting hfp again, etc., but considering that the whole
adjustment shouldn't be needed at all, it's easier to just remove the
function.

Something like this function should be added back later, when adding
burst mode support, but that's a bigger change and I don't think this
function would help that work in any way.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 45 --------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index fc034a9624a5..319a6a9a6fe7 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -508,47 +508,6 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	return 0;
 }
 
-static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
-			      struct cdns_dsi_cfg *dsi_cfg,
-			      struct phy_configure_opts_mipi_dphy *phy_cfg,
-			      const struct drm_display_mode *mode)
-{
-	struct cdns_dsi_output *output = &dsi->output;
-	unsigned long long dlane_bps;
-	unsigned long adj_dsi_htotal;
-	unsigned long dsi_htotal;
-	unsigned long dpi_hz;
-	unsigned int dsi_hfp_ext;
-	unsigned int lanes = output->dev->lanes;
-
-	dsi_htotal = dsi_cfg->htotal;
-
-	/*
-	 * Make sure DSI htotal is aligned on a lane boundary when calculating
-	 * the expected data rate. This is done by extending HFP in case of
-	 * misalignment.
-	 */
-	adj_dsi_htotal = dsi_htotal;
-	if (dsi_htotal % lanes)
-		adj_dsi_htotal += lanes - (dsi_htotal % lanes);
-
-	dpi_hz = mode->clock * 1000;
-	dlane_bps = (unsigned long long)dpi_hz * adj_dsi_htotal;
-
-	/* data rate in bytes/sec is not an integer, refuse the mode. */
-	if (do_div(dlane_bps, lanes * mode->htotal))
-		return -EINVAL;
-
-	/* data rate was in bytes/sec, convert to bits/sec. */
-	phy_cfg->hs_clk_rate = dlane_bps * 8;
-
-	dsi_hfp_ext = adj_dsi_htotal - dsi_htotal;
-	dsi_cfg->hfp += dsi_hfp_ext;
-	dsi_cfg->htotal = dsi_htotal + dsi_hfp_ext;
-
-	return 0;
-}
-
 static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 			       const struct drm_display_mode *mode,
 			       struct cdns_dsi_cfg *dsi_cfg)
@@ -568,10 +527,6 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	if (ret)
 		return ret;
 
-	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode);
-	if (ret)
-		return ret;
-
 	ret = phy_validate(dsi->dphy, PHY_MODE_MIPI_DPHY, 0, &output->phy_opts);
 	if (ret)
 		return ret;

-- 
2.43.0


