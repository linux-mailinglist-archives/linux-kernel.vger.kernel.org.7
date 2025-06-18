Return-Path: <linux-kernel+bounces-691715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC89ADE7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB92165CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6532E974A;
	Wed, 18 Jun 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UJUKQoow"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399B2E8DFD
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240803; cv=none; b=muQiJSl18sx62WNU+4l0mb14ne4vzFBO07GDSzKx0GtAQSLy+VRNac36tu2bZLT/d7bYYBu4xmivrENU6gDNLsWRHOwXQVziNQ7GYZEjrp4Ga0bNdnkAwirQjcApmprP2ufE3ari7Oxp7LhBN6GtZA1FC96KRoRTZ04t4z/7yNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240803; c=relaxed/simple;
	bh=se1rnJ6wKLrMNnGX3FfmjWuml4KOIsD0TGEpWMd2Syo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE+z0B14D2aMBx1rzcRBTTDcMCIUfvNf3BR2w9OR70+DBr27MDkMFRd0UfWi/nONZgZG1+OINjOr+3NRvYrAjilpg6GJseLsNg6uAomlpBFD7FLBjwi6Ws+B+SuoC0PTWTTpfnpVSNPJkNJvM1Ijz2e6bT3C8B+rGjrX2Yijfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UJUKQoow; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEA76111D;
	Wed, 18 Jun 2025 11:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1750240778;
	bh=se1rnJ6wKLrMNnGX3FfmjWuml4KOIsD0TGEpWMd2Syo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UJUKQoow3Qtdo69ENk4VDS2DKcCxv6hKD3kZE5HrqtQdatCeHycv0CJDujK9BgyoE
	 bE1yL2o8/q6GNyj/WaKublKxtuz51Z7x7XxxjLpYXVvBrwT5u4+N179/pah1ZynM/K
	 3kBtzHlsJ4Hsj3/FSy0XKiRNtxPTST0LYY1u7XkY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 18 Jun 2025 12:59:18 +0300
Subject: [PATCH v4 15/17] drm/bridge: cdns-dsi: Fix event mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-cdns-dsi-impro-v4-15-862c841dbe02@ideasonboard.com>
References: <20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com>
In-Reply-To: <20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=se1rnJ6wKLrMNnGX3FfmjWuml4KOIsD0TGEpWMd2Syo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBoUo4BRnsm59Jy5RXhPykB+BrDRRsio6Wcv/7Tx
 CrE1P0hyxmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaFKOAQAKCRD6PaqMvJYe
 9QVED/9R75oSWccmLzd4WbvCQABL0qKinSwZz4SpCZcIXtTkCpULfEV3q9Rgiffh/QksM7hUrVJ
 gFE3kGAyrojmnjfQWL0BKAd60PyZlZFVXn1EH0B1iUYXHQHjqp50BQEdH+5MyC6xNeEkcG4+PS5
 bALoaGmDMesJc/ej/8dYZOMsBuMte9A+96OsnKAYcefVkF+z/pZ2K74A765AHjH75W50q714j3q
 wCg86MrQ04we+eBrxyjxOwle5cjiSApo33KtaKbvXwhf7G5beXUxXk27exI5AlqYCySMvOtzPwl
 VUpyz7ItWfLvHHtrF+0ZAVd7ia972j0SQZkW62pm9aRZ8x1NBe+Lco78Hxk4uKaezqdHkKQ5fsq
 7/3HMi4V/Ochtid/ONzpoBo9Y4q3oheb1MtRaQdn4v/N7v1lv/Tl5KGv9Lofb/MP55NRCrHgvWQ
 G72tWrA0591tFQvLMi1hKZFsAiUb5cxGP1wp5kpxof4VReTV6j6ZJ3ITRJpcLF7Qm1IqkxnUmS1
 1DI0+eC209unJ6FV/b21oorBE87cgzdXE9lvYFwwhMA94z6JTwBPomuzj9vjBvlE4lVyKyfHdrc
 KNCOFftSzrt2jrQNqVd1xjMszfXsXHdeQeL/+FR8Qsp40NYL3rlSLoaln9Z6izR5+VXCyL26DhZ
 C3/dwOWyK3T0Lrg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The timings calculation gets it wrong for DSI event mode, resulting in
too large hbp value. Fix the issue by taking into account the
pulse/event mode difference.

Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 07f8d5f5c2aa..3bc4d011b4c6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -418,7 +418,8 @@
 #define DSI_OUTPUT_PORT			0
 #define DSI_INPUT_PORT(inputid)		(1 + (inputid))
 
-#define DSI_HBP_FRAME_OVERHEAD		12
+#define DSI_HBP_FRAME_PULSE_OVERHEAD	12
+#define DSI_HBP_FRAME_EVENT_OVERHEAD	16
 #define DSI_HSA_FRAME_OVERHEAD		14
 #define DSI_HFP_FRAME_OVERHEAD		6
 #define DSI_HSS_VSS_VSE_FRAME_OVERHEAD	4
@@ -487,23 +488,31 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
 
-	dsi_cfg->hbp = dpi_to_dsi_timing(dpi_hbp + (sync_pulse ? 0 : dpi_hsa),
-					 bpp, DSI_HBP_FRAME_OVERHEAD);
+	if (sync_pulse) {
+		dsi_cfg->hbp = dpi_to_dsi_timing(dpi_hbp, bpp,
+						 DSI_HBP_FRAME_PULSE_OVERHEAD);
 
-	if (sync_pulse)
-		dsi_cfg->hsa =
-			dpi_to_dsi_timing(dpi_hsa, bpp, DSI_HSA_FRAME_OVERHEAD);
+		dsi_cfg->hsa = dpi_to_dsi_timing(dpi_hsa, bpp,
+						 DSI_HSA_FRAME_OVERHEAD);
+	} else {
+		dsi_cfg->hbp = dpi_to_dsi_timing(dpi_hbp + dpi_hsa, bpp,
+						 DSI_HBP_FRAME_EVENT_OVERHEAD);
+
+		dsi_cfg->hsa = 0;
+	}
 
 	dsi_cfg->hact = dpi_to_dsi_timing(dpi_hact, bpp, 0);
 
 	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
 
-	dsi_cfg->htotal = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
-		dsi_cfg->htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
+	dsi_cfg->htotal = dsi_cfg->hact + dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
 
-	dsi_cfg->htotal += dsi_cfg->hact;
-	dsi_cfg->htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+	if (sync_pulse) {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_PULSE_OVERHEAD;
+		dsi_cfg->htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
+	} else {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_EVENT_OVERHEAD;
+	}
 
 	return 0;
 }

-- 
2.43.0


