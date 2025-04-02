Return-Path: <linux-kernel+bounces-585126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F03A79003
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7EA3B6A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0624169A;
	Wed,  2 Apr 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KReOvD8U"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2224166F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600705; cv=none; b=cTJn6XjQDnO+74eeIxt6TAmn+TrVUvgU1Zal0NciMY3+HhFYxqFsZLDVFSHjm3D6hdC3zcrNEu5RjE7QaauPHkMJQh78pwa2VJp6BxzFAH3FCrjyWsKlVkkLuPtfi26K9jGpBRLlmvtvZz1qmMbyr1+wBvhk09/NwTM593ZzwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600705; c=relaxed/simple;
	bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czTmC/PHg2qx4RosdGAsPo7A+5WaMGFq5CFqQLVSr71CkbjmjcOXQmdxNkGUvH6SG/dnQk9rr2E42ooXXPPejNAiyePKJL/PxaYAt/rRq1KI6ahtx4xriJWvOtFqbxWSa1ZCSfNYXsJaZVamrW2NdLyB5mByoracCgukpjoSVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KReOvD8U; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62F422698;
	Wed,  2 Apr 2025 15:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1743600581;
	bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KReOvD8UBUeNb4TVNPZi3w7epXAWXa8CQ6tymla2A8scpJyDrNnhKWSkCkZC+NvIg
	 r6Hcz7EBf+kDdtzGoJCob+ix9NOGyywADfVduYXShIZZOkNatRGwquGna/HdFrXIE8
	 3MjrU5A4+TqyyhjAJHMKI31TW7S3Jt9pbyVnLpf8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 02 Apr 2025 16:30:58 +0300
Subject: [PATCH v2 16/18] drm/bridge: cdns-dsi: Update htotal in
 cdns_dsi_mode2cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-cdns-dsi-impro-v2-16-4a093eaa5e27@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=+KTrHkkHrlimkcuE/FGh2M7ak/aUnyOtjsNsvIRCm1s=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn7TwhN5j4jZl/ZKghFpGwQA9aKuBkv7UUMeIZg
 //p2OMD6FCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+08IQAKCRD6PaqMvJYe
 9RYvD/46o6fQlsJtr+9aj4Q6Ts7/IJrOxvcT6mMmD6lUQVvXa7Ynf2b/o4JNz6tQjI+gEbzKHCI
 cx9UNePzH0FvE7KWgSJM5BwQXpfGGWLCZ4DNA1D4iAXqT5waV4h4GdUy8W/a4QiSfTbNUb9TiVH
 29MklhHz5J4Ym137sEWvNJThBN7apXJ2BkclO1pRJn1ifoqpFOlFgFUblcVMUDTa+vsq41chC+/
 FwMlJQ76WeOo4Q0tnwKngb/OR4cQXLq87PcV1rvUZrGaZgY2a2kMRD2j3Zmx+ZCZDphtzKwzASq
 zn24x7kaACDShjTLWBrLggZ2ZfcbnvgetyjNv2GhbCnDsQljZQ9Qax2rjKLsFLHO9zWN8Qlbdji
 EEWcbH7/VjnriplhR53pqQryqF+IkRPEvEskekIrHwsPIdUCLrZeMrVASyfzpuUm8Km0NgJhDTc
 kioMznHDpPj+BXsjObYAhQI8MUlLGCTmWfiavevta36k8rVAyhf6UcpvgZH+OwAkIxYZ1QyS8H5
 qfxBDSRut3xctntzs9y90FB37SJBx31Y8vP97MO1lW8IehMZG+JizYNosZ5qPKFv1vgMRfKgt+9
 RikYljNybLo6UTOzxCGFVN3UOL+7qFBHhHM9IS83VDl8Kyr9mHs4bZ4KBAtc23vFlCn8b+Q2uQN
 Tiy/aDfaxJVFWzg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

cdns_dsi_mode2cfg() calculates the dsi timings, but for some reason
doesn't set the htotal based on those timings. It is set only later, in
cdns_dsi_adjust_phy_config().

As cdns_dsi_mode2cfg() is the logical place to calculate it, let's move
it there. Especially as the following patch will remove
cdns_dsi_adjust_phy_config().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 9f4f7b6c8330..2a272fd8ea3e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -505,6 +505,15 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 
 	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
 
+	dsi_cfg->htotal = dsi_cfg->hact + dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+
+	if (sync_pulse) {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_PULSE_OVERHEAD;
+		dsi_cfg->htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
+	} else {
+		dsi_cfg->htotal += dsi_cfg->hbp + DSI_HBP_FRAME_EVENT_OVERHEAD;
+	}
+
 	return 0;
 }
 
@@ -522,15 +531,7 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 	unsigned int dsi_hfp_ext;
 	unsigned int lanes = output->dev->lanes;
 
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
-		dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_PULSE_OVERHEAD;
-		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
-	} else {
-		dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_EVENT_OVERHEAD;
-	}
-
-	dsi_htotal += dsi_cfg->hact;
-	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
+	dsi_htotal = dsi_cfg->htotal;
 
 	/*
 	 * Make sure DSI htotal is aligned on a lane boundary when calculating

-- 
2.43.0


