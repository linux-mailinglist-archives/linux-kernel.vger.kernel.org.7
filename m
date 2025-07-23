Return-Path: <linux-kernel+bounces-742270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F8B0EF58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E661AA2EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4472BD5AD;
	Wed, 23 Jul 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aF8oG2GF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9429CB45
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265156; cv=none; b=FTJE3LL8aWSrZy9GMQ02C1XtH5E9Yn+ZK4xU+RW+yK7kA0mdocU0cPCAgQFpEgO6IG5shQJQLHMbsFFuHR7M0G5WAouDscnaUxqyZZn98Y/WlNrwUpoLvchcmQXhGkGVd2XZctkD2GygmKAeGpI4gcril6AP07c5JfQs2pDwVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265156; c=relaxed/simple;
	bh=Xc+qT2XQjEkYeWWEXGGWk/XOfjaEnBSg823/HrVp0v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/yyvB81B8ye0s+G8RBDOjS7mgjKFwS3nP03BL03S62PF+qejc1yrqes/lq6w6BQwOfCXGVet4XbugrhGCVVUObc+uD6hV2bYTuWOrCAHhjsdPqpV4pG0lUuMdLh9/27TW2mMbH7DMl/1exY4salYPMaGRoqGWdByJBdBhmpTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aF8oG2GF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A78C5F06;
	Wed, 23 Jul 2025 12:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265112;
	bh=Xc+qT2XQjEkYeWWEXGGWk/XOfjaEnBSg823/HrVp0v4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aF8oG2GF200u4HlLCmle9UZm93z+3lNEG/3gOBDfpS+leSKjEwnMdEyGr/Grqe2RS
	 WtJp4F7QAxiDTBoMAhwaypxAeLEmg3mspLt73tsSwaIgDqMjOJcD4j3gLaWuWljAqe
	 TJRBHGNSVQbJ4ofECPReQAdrCwEHbRIjMyKOtqcM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:17 +0300
Subject: [PATCH v5 11/15] drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-11-e61cc06074c2@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Xc+qT2XQjEkYeWWEXGGWk/XOfjaEnBSg823/HrVp0v4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPtNazPSbQ5KpE3M+6zEt/M6XZbg5m3Yefhq
 qf4Qd41bDCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz7QAKCRD6PaqMvJYe
 9U35EACXI0Z3p/DF0JFrEZbdyogW0eK8s1n4cQdf4cM9+c3Es3LV+L0muS/5NKMC5O3eLh2xxjk
 vameoiILDZGFDMRD5QILgdQs1dUzl6jIYptjTe22j9sDPXmz33WEBYi0n0z/2lHMnkJwPTe+Tpi
 tn34Rf4xcFGahLdpjwWQ5AxSHHkhnkMenuQY2VVSOts0Uhm5MZoQtupQXdPQxlBxjyqMzsc2sTR
 PYI6QmB0ba8BPa4Mv5otq0NG9CrpiWKU4CUvdE9HAQMDsPsQlL7u2upPhdmU7gU51w+vK36yBLe
 mQPrTxvormuvNeJl/uxubHLJ0l27DXTFWq/WySFIuKxE7WUBKe6xcUGeiLcxSZZd1Joj4IpPkOo
 6/lphWtI1xrkKFnNouFOSsce7OuDyd2Bq4O8zpixDfd8jowVG/lTXiFq0l8v3EswXBFuIlPGYV2
 dg+BY4yIAREtJT1JsRHo+soUey4i/038geEOgCEUH54PuISCfV09dCBYkGvrhItky9gTTWM9pgO
 clhPqLLINeXXBKFmHkDhXwrYQHHp3Dk7Fhto7AKtRsMJW2Mvd19H2AjTPs38NTm+5cyFlFSOMsp
 8lJC+XDg49oizu6q5ym+AkFzbqRzIznt8FJ8T2YDDP1Va+lwFywL4qIGASQ5h0oDLXxIRrZdJdG
 Rhy5bOCQUUW6x3Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver tries to calculate the value for REG_WAKEUP_TIME. However,
the calculation itself is not correct, and to add on it, the resulting
value is almost always larger than the field's size, so the actual
result is more or less random.

According to the docs, figuring out the value for REG_WAKEUP_TIME
requires HW characterization and there's no way to have a generic
algorithm to come up with the value. That doesn't help at all...

However, we know that the value must be smaller than the line time, and,
at least in my understanding, the proper value for it is quite small.
Testing shows that setting it to 1/10 of the line time seems to work
well. All video modes from my HDMI monitor work with this algorithm.

Hopefully we'll get more information on how to calculate the value, and
we can then update this.

Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index d49b4789a074..6bc0a0d00d69 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -793,7 +793,13 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	tx_byte_period = DIV_ROUND_DOWN_ULL((u64)NSEC_PER_SEC * 8,
 					    phy_cfg->hs_clk_rate);
-	reg_wakeup = (phy_cfg->hs_prepare + phy_cfg->hs_zero) / tx_byte_period;
+
+	/*
+	 * Estimated time [in clock cycles] to perform LP->HS on D-PHY.
+	 * It is not clear how to calculate this, so for now,
+	 * set it to 1/10 of the total number of clocks in a line.
+	 */
+	reg_wakeup = dsi_cfg.htotal / nlanes / 10;
 	writel(REG_WAKEUP_TIME(reg_wakeup) | REG_LINE_DURATION(tmp),
 	       dsi->regs + VID_DPHY_TIME);
 

-- 
2.43.0


