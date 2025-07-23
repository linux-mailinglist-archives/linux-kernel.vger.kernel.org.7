Return-Path: <linux-kernel+bounces-742268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F516B0EF55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D2189B3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8329A307;
	Wed, 23 Jul 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MOG+AzPl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEF291C01
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265152; cv=none; b=A5DB+aTFS1C3BE0xy/2OKZZwzEzmFcHl7VIvyw6l2XWpTB8HOO7McsGPM4w93PF665lXjCP3V8OcM6ixekO0bFvuUW4EL98eDhB+dJV/3MEl1lHImRbsCGa1PyVta8Bcv1DGis0oxtUJpZGQ7HhC0ur/zwt56zC2J48hZfZCZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265152; c=relaxed/simple;
	bh=QyaPaFJI2DYR4QuA0uaZuxOPaRXXWCd5AxT5A2x7Q5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsY1kM2iqF2zm5jhOPYkG6vx4M8dFw3jEXYo2c4BZqvh2FuFfX2mxyO2b1833EPAL6xGYnHiX8l3N91XjYNr/4ZTh5uaGkW6ih2y48hmjjN6v6gdchULjXdLM4ELAhfN/BTTdfu91DjxXOZcIVTEPR9pGlAPaLKo/A/zVBpL6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MOG+AzPl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C035613DE;
	Wed, 23 Jul 2025 12:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265108;
	bh=QyaPaFJI2DYR4QuA0uaZuxOPaRXXWCd5AxT5A2x7Q5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOG+AzPleuh5lSupxh62rGvfes5Bh6imqb7eelTThU4TW64th+P7c+9WgHBFoS5CP
	 H5m6Ky29GyrT1H3hctKNoeYp+Qa2Ucinpqs3hRup3/wOIvWwoqYSiTpAU8f9v8Ap8m
	 sxkUfwHDNtZZKGKww3aW5oRkMZCVyTZ35fWTt9eM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:14 +0300
Subject: [PATCH v5 08/15] drm/bridge: cdns-dsi: Update htotal in
 cdns_dsi_mode2cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-8-e61cc06074c2@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=QyaPaFJI2DYR4QuA0uaZuxOPaRXXWCd5AxT5A2x7Q5Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPrCZQ6oe7tq8A5aa498P11jZiSpfN+6u8DC
 mzv4PXR5z2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6wAKCRD6PaqMvJYe
 9bhoD/4wPoQFICkJrFipn04ZO0H6i46CbPboDYduDCUTbLV/9kqK8qlwiWJEprNfozqTQC9hPQ3
 itzBDNKrLvMRlthSdXFqlkAHzo63ylNcRXSNCw3d+Fhevt1OB7CGz07TLU26NANuRphDTt65qSM
 97p6d3oqBIkvCzjFTQoSUXbH2IbDZGhEvZpSVnxrbju7iupYFFZdmPVGaqVH2SU2YpBZ7eTXTyc
 ZsDKYdI2zBky/kXW4XjWfYN8ueHGR1Zxui1htqBd0Lya9bdGNr25Ow/cgnQ/sd3gFAQSgnrBHBu
 0ZdWAYt5+ygSKpJ45b1YJvcBILwjQhBbgjFWhuz5Z/fkiARfU9L6X9VLYEmpCGe0H2AZgUYYnDN
 KqXZPo0w4kwFs75cGSv0dEEdeUG8g9gkZtjEg+GGOYxxlbQRx1tGZ2vfFiLNzeajJ18vpeTNbda
 xT2P8nwV6OIYh7hMrXSScpJXmwIglPfwH3QE0tUGuvfhE8k1t98z5rIid5iD/yJ0IzM9N4qaXSl
 kCAwc0vUrkQLidU8HCaN0dThDd9gSnfZ4goRxbjMVWQl8XkAjakCSnct6hj9MAUhEX39S6tjqBe
 hEodCCitmUYopTKr7cCCimliqaVJzwaI7WGgK3D9OIXbsMdlkZ1QPaQPs8luJdT3tgypDcFqDWh
 skMNu1Y4f3pm7nQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

cdns_dsi_mode2cfg() calculates the dsi timings, but for some reason
doesn't set the htotal based on those timings. It is set only later, in
cdns_dsi_adjust_phy_config().

As cdns_dsi_mode2cfg() is the logical place to calculate it, let's move
it there. Especially as the following patch will remove
cdns_dsi_adjust_phy_config().

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b2b6529b1c70..7103878df1e7 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -498,6 +498,13 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	dsi_cfg->hfp = dpi_to_dsi_timing(mode->hsync_start - mode->hdisplay,
 					 bpp, DSI_HFP_FRAME_OVERHEAD);
 
+	dsi_cfg->htotal = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
+	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		dsi_cfg->htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
+
+	dsi_cfg->htotal += dsi_cfg->hact;
+	dsi_cfg->htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+
 	return 0;
 }
 
@@ -514,12 +521,7 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 	unsigned int dsi_hfp_ext;
 	unsigned int lanes = output->dev->lanes;
 
-	dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
-		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
-
-	dsi_htotal += dsi_cfg->hact;
-	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+	dsi_htotal = dsi_cfg->htotal;
 
 	/*
 	 * Make sure DSI htotal is aligned on a lane boundary when calculating

-- 
2.43.0


