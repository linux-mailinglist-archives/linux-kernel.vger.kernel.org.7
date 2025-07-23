Return-Path: <linux-kernel+bounces-742266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB1B0EF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B43516B96B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F328FA9E;
	Wed, 23 Jul 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RX1xMwKK"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1D28C2B9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265149; cv=none; b=K9raLN8LKsjfwxYLVTrIa8ETS7jYMFnJ6N5IORo+Zej6KQ38v+e37ZmVRUyhA6gjqDt8j/pkmDj7weh0VFn4f+HH2RkslStkTUQnx94AU13ipRg99wYL+53fbRZkHoGXkREiPFINbth/0lRY1VPZb0uooMgoZC8nBK/Ch7NThLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265149; c=relaxed/simple;
	bh=+PxAbR0AgAh+6ttH91klZ+Aji+1hZOcFtaS/g/i1Q0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG4QxVoK09ODCEHtZngAdTSH+Y1hC7I3PgxUC8Cgxw5KxTJK4fwuH+3lGr+KGRrsifekF7SMMPadxHNhd8JXNUWnL3VkRh4JGqAJm4Cs9H1BYBF5PDgjUPBGSjR9f+S0cJpcTM4GbVvXAhWuOK3gvOggHyZT93Pe7UWxHeqUvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RX1xMwKK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B9DC1129;
	Wed, 23 Jul 2025 12:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265106;
	bh=+PxAbR0AgAh+6ttH91klZ+Aji+1hZOcFtaS/g/i1Q0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RX1xMwKKPpK5WRz44L6QlrkdK2tshCe6rta1BfyesxjjiAK0rd9qw1n2zx9AchHFD
	 LHhbk6hlcYg7cvduzEblm0OUQbdlCr0AihRY2/Ht95rNkjLRONyW8AU0hkuLE8KWj8
	 0D5Wk6GAGxQ4QZQ2cDeGVfnEfdAIRN8jIMLqsmPo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:12 +0300
Subject: [PATCH v5 06/15] drm/bridge: cdns-dsi: Remove broken fifo emptying
 check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-6-e61cc06074c2@ideasonboard.com>
References: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
In-Reply-To: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+PxAbR0AgAh+6ttH91klZ+Aji+1hZOcFtaS/g/i1Q0s=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPrTWKpTI7qlDcFlmzpTrNDGKKo18w9aaIO6
 KxFKD5lOS2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6wAKCRD6PaqMvJYe
 9RRAEACdS40ggRn6TNhjMQt8B5FDvfYJ1X91p5qVBMm853Zy5ZJ1LS1L1M5deJpBeBU2XjGHmvg
 LGNeNqz/gVeVlGh9Ab8GClyFgcziAl3nWfBRdGXG70Um/OWZjdn8bJRFodJJIGxkjmmWWwwKbtL
 tTFlVefMDKvHDwCvgVAHG1Rxdtp8bn1L1irWH2x9SmQbmHbLnLkEyL638VGcT+1Aj2jjboVDqE9
 ETLyfK5Pe6gRACRz0y7HWsCPIsMDSRxRCZmkDgiBjmCXktMVxul1Dad+V5CmPKZZ4tP4HowXBRV
 DbZmE1/OrGc4TagxxfrSEPoGh2EFdOMZTaut7xebklIf77rDmJoVSd6l14vLPimsrCy/4QuntH+
 iurDqd5h4jAYLJxaW45Bfj2OZvgXGz3vZkbTRxKA+5j0nPnTLGL6XkTnWD/JraXau+K2hcTpkie
 qoohrmuXfF81+pPSnekpHeL5AmwGIntKlZaqdiphdTFwC26MAxG+NJm94vNOjEbNhJ4rwXUDZqU
 p2DOiocvo2yADK8cHXVYm0g5zIX5PdnkK3lSbcgr2Lvz5JgQ3xsZZxmlclCg5RRaWpxTVQA/Pwm
 LF5pYJ7NUvy/ZhLLKhqp/d5M9fXRonuX84oBWrZ77TD6b5rGa9Icr57aKutAqZwsFbwTvZQ47D7
 eA5Izv94iKfXodw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver checks if "DPI(HFP) > DSI(HSS+HSA+HSE+HBP)", and rejects the
mode if not.

However, testing shows that this doesn't hold at all. I can set the hfp
to very small values, with no errors. The feedback from the HW team also
was that the check is not right, although it's not clear if there's a
way to validate the FIFO emptying.

The check rejects quite a lot of modes, apparently for no good reason,
so drop the check.

Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index eae9469ef431..000c5a2367fe 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -553,7 +553,6 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 {
 	struct cdns_dsi_output *output = &dsi->output;
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
-	unsigned long dsi_hss_hsa_hse_hbp;
 	unsigned int nlanes = output->dev->lanes;
 	int ret;
 
@@ -575,20 +574,6 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	if (ret)
 		return ret;
 
-	dsi_hss_hsa_hse_hbp = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
-		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
-
-	/*
-	 * Make sure DPI(HFP) > DSI(HSS+HSA+HSE+HBP) to guarantee that the FIFO
-	 * is empty before we start a receiving a new line on the DPI
-	 * interface.
-	 */
-	if ((u64)phy_cfg->hs_clk_rate *
-	    (mode->hsync_start - mode->hdisplay) * nlanes <
-	    (u64)dsi_hss_hsa_hse_hbp * mode->clock  * 1000)
-		return -EINVAL;
-
 	return 0;
 }
 

-- 
2.43.0


