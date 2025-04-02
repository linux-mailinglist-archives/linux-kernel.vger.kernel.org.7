Return-Path: <linux-kernel+bounces-585111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76994A78FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 15:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC8D3A3BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879423BD0F;
	Wed,  2 Apr 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Hy0ZYv7+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9023A9BF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600683; cv=none; b=D1fbipc108xoUo3MXyv4GF1QDXqS9qUSMwoLjw+5he7nH53hDUBYU3jekPvrm92Ah5YwAwRnzJXeQ+cVCxoU5GIkIcIuj8obm1o1i8pwXT1Kbkk2aoRCzN7Mkr1WaQ8XoeumWnW2sHnm/DpdQrAju8v2D9JS9T7H0n/2QvaOo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600683; c=relaxed/simple;
	bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEaAwsy+s0Kb7BdNEzsojpv8CbashEYh/mARAZKHACFxbPtNnEZ3sHN8RqXoGx86eGxcs2I6RAIVwHbknScIFucRPDLuOLk/B4QFj/FG/F+KPuAr45b0PT11bh1271lN69iy8B9F5sN4pKim83xf5taX8WsrrBnMB3ah1qNw0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Hy0ZYv7+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18666109A;
	Wed,  2 Apr 2025 15:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1743600565;
	bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hy0ZYv7+3NqqgAW6ebTLNj5eH6r2ENeyc/blyhhqBpSlqnBwwUqwXlwD49+yrFSLs
	 IMPf0B6XfIpmyQpLcXQ/vhpXR9lqE4Ww/Q1ShnLm0L1sO7kt9RqcZqZJC+Cgv1sPGV
	 fi2pmDfwqoHy9ZO6DIjEz1eB3HGiy/Rqpeq60okE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 02 Apr 2025 16:30:44 +0300
Subject: [PATCH v2 02/18] drm/tidss: Use the crtc_* timings when
 programming the HW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-cdns-dsi-impro-v2-2-4a093eaa5e27@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn7TwbvLVB3NSmEEZTKu2mPkd4cA53AxHiHX+cu
 5bfLMU8TS6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+08GwAKCRD6PaqMvJYe
 9YhAEACdn7Oov1vXfnvsqQzBPL5vwo3aQ+a4r7+ThgX72vDWUZGEOsnceOUSZQ/kOBrq/jD+6E6
 YMTaSawx/zRswAAP7WZE1bFd+6z1cXCmNPG2n32uuK5ZCmqObJsOeFBjwfjFvaj/MF+EsGpUyUq
 e7LY81lqAZ3D1GDP6xBRytSabDoObPpXq/flP7O5Fp21I414UcJ0KOHpY5W6l5T5nEgmbDuw8+O
 oobEl38xV/8siHif2loJz2WG9Lcjt3uwtd6GpX1HlWOJ4sM8xeWcQWQcuDA82qt+iyM9SrXUT8/
 bOBc15mxhN8Xccl4UwTQ2bArkFjt4pr5+efjgUK3Pf9lpEuJufM8msXpAtfIAhTHRrKX1Z9VsxA
 rOLBWEAMtg5Df5q+4/T6x9pJI6z4luCbY490q3vDxJEfARQNso96i0EgwDylPGnJ26FyAfuML0O
 822FOJzLMxiEhd1In7hO3gDL/U5OuEixME7uxHVP5piFfNNM1jBLULEU4dBSbDPOXmIg1cC+x/T
 AztfKErMNF60ODMLK12eSIKYKZJkFeFHX+Zy/visWKf1kA6rqhnsbqf8itA/ZDPv6kuvG/23B4M
 NU6JU8R90kccucxKjhv8ERWCeIPRWEDVKUPpjHR+H6P+sZHoX+ftCTkpIQGau+0WrCqLkIH/sCw
 Xvv81vKlzLHxMdA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use the crtc_* fields from drm_display_mode, instead of the "logical"
fields. This shouldn't change anything in practice, but afaiu the crtc_*
fields are the correct ones to use here.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  |  2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 94f8e3178df5..1604eca265ef 100644
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
index cacb5f3d8085..a5107f2732b1 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1084,13 +1084,13 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 
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
@@ -1132,8 +1132,8 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
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


