Return-Path: <linux-kernel+bounces-742263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E65B0EF51
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B679F7B907D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5428D821;
	Wed, 23 Jul 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JWM0eh3N"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761F28C2B9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265144; cv=none; b=QgwGS+dNjhMTASxyB3GT93D0RQSfvFlttphCZBiUIpsb0EWGtBI72io05EcjW9UoOCZlkJVP5QISXAB/nsfq93z5G6pci6yGSno209V9ZmAFjz2CQJ6OtCvaSKIU+92P/HuBT4bISlTPoNEKj0pXivOc65C6HLqwnLuI4EwO2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265144; c=relaxed/simple;
	bh=pz8KMcVokg1V/yZunn70svTAycPp1MDVpEfNBHPXfM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HW39bgWsAkcMIhXnFezG2mXCDSF8HOt4yiQJnscfOcZ2m3a+1VsDtwwhbAwS/7/uOpK3jsoMk2mnPEZTevuAFtWWq2lYrncTV5/E7qUUR8j+tKq5Ncx9Cykis3hgcdd6wKimq1KhoJSWfB2Z39IgcsaMmXabfXmZsqMJGjggw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JWM0eh3N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0251FFDB;
	Wed, 23 Jul 2025 12:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265102;
	bh=pz8KMcVokg1V/yZunn70svTAycPp1MDVpEfNBHPXfM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JWM0eh3Nuh6JnA+wFpzCf47akbIroygQVzkodZYpv5tObbJ7/iFndFPovXN6biu0b
	 deLnSqVOmoEfV2fjP0K6C7YbP0B9bRaCRWkaMk9JiIV5bIEqfXo0GkQrdBCRDLrthn
	 DRPTqzGWEo0pisGC3gBDdBSh+IbTzKT5HfYsnCNA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:09 +0300
Subject: [PATCH v5 03/15] drm/tidss: Use the crtc_* timings when
 programming the HW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-3-e61cc06074c2@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=pz8KMcVokg1V/yZunn70svTAycPp1MDVpEfNBHPXfM0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPqBoO3LIHdqMhItrSVBIh76mCEib7Abm794
 Q7bl8D/2i2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6gAKCRD6PaqMvJYe
 9eTgEACK3SB0N7uNV6zPqbTfZNpJ4srFLkSMq/S8qN9V7bj3lacUueHUcKKH1sU/8DJdKqTaS2l
 AOmQ4W9QN4q45F3Dnzy1PC6Umjmln3hI228EZpEKa8NPT4FOyQ1n1+FnEIGBFxpU1VruQvVKhRX
 YV8ue1oBdk6XYYkYb2i/meNC3bSNyX8j2XIq/mYRvpyBUUGcrhVIF7YcjyLEle2djVQ+oPsdsTg
 5GG4cIci2CyH21JBuBaa12p+zn+1jw9RAlORWRdVHBc2fy5VehpA/GMBYvRfW32x8R05iGqrYoX
 5GIKXOKeHeARSE30Cfs+kgCuyM/+LS2P3cGAMERIKMqxEGHbbzu/9mDzVvSw+TUxElLmDeSd6gV
 LRMDP9e8+kj3i0lWs7/bHA2fqRQZBz3iuWQL2967eV4P+qBDBSi9zirjiqViBkL+uBD1YLe77mb
 BJEM4+irKg7OI4reuoXQs2NWM4WneHdzfJJCSeWnniekLqUGLbuFEBDVJmTG2/YH2IBIXK/frzs
 ZitCnnPFZ1Yeaz5U0RMu6BfA4hKNnjibe85Wn8G4Mo52OQM96If/0bVKHORcYLvlF+Db2iLMXXD
 l/tfLxCZo3EdMZ1w+mdmX4qGG4sQYMS2oCNFESttz7e9alz5dasjkJhfbe9ElzCsTAWuIr6g8vo
 xKY71SsMQVoqtJw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use the crtc_* fields from drm_display_mode, instead of the "logical"
fields. This shouldn't change anything in practice, but afaiu the crtc_*
fields are the correct ones to use here.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  |  2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index a2f40a5c7703..17efd77ce7f2 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -225,7 +225,7 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
 	tidss_runtime_get(tidss);
 
 	r = dispc_vp_set_clk_rate(tidss->dispc, tcrtc->hw_videoport,
-				  mode->clock * 1000);
+				  mode->crtc_clock * 1000);
 	if (r != 0)
 		return;
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c0277fa36425..3f6cff2ab1b2 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1215,13 +1215,13 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 
 	dispc_set_num_datalines(dispc, hw_videoport, fmt->data_width);
 
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	hbp = mode->htotal - mode->hsync_end;
+	hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	hsw = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	hbp = mode->crtc_htotal - mode->crtc_hsync_end;
 
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
+	vfp = mode->crtc_vsync_start - mode->crtc_vdisplay;
+	vsw = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	vbp = mode->crtc_vtotal - mode->crtc_vsync_end;
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_TIMING_H,
 		       FLD_VAL(hsw - 1, 7, 0) |
@@ -1263,8 +1263,8 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 		       FLD_VAL(ivs, 12, 12));
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_SIZE_SCREEN,
-		       FLD_VAL(mode->hdisplay - 1, 11, 0) |
-		       FLD_VAL(mode->vdisplay - 1, 27, 16));
+		       FLD_VAL(mode->crtc_hdisplay - 1, 11, 0) |
+		       FLD_VAL(mode->crtc_vdisplay - 1, 27, 16));
 
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
 }

-- 
2.43.0


