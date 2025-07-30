Return-Path: <linux-kernel+bounces-750418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14AB15B19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B014E7718
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A100298991;
	Wed, 30 Jul 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvmSNeQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F9298CDC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865866; cv=none; b=Q03iALAHpp0v7/tvWfAm8zZHEfkpF070atQdWTVY84qbNoA8B0WqXX32Dop6v+BWWRrXW70/oVTDsnl64VTYZZSshkpcxFbbhDDYNEtFck1GmsEPkNUWymDiE/VZLMPD60QefJWPCC348b0z0MreHj1+j/d3cKt+VPUvRY7HtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865866; c=relaxed/simple;
	bh=bRiJmUbTP2CEaFqChGX+gLzEeA4bppzlIogVCcpgRyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe2aPlfwElqAYHu4IsZAAHu12YNxx5yJFQBSitqTeVM6lNAFhfdh3y0m4h0f+xMqjUDD38f5yVPDxPoL7/UfS0Z5suOVdGTHxUcagDH3IdPvAkhhqHnqIg988SwoDXdreexRt4cCMILebuNlfzO3kOmdawOLp7y4lb0/oeqdU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvmSNeQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE88C4CEF5;
	Wed, 30 Jul 2025 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865866;
	bh=bRiJmUbTP2CEaFqChGX+gLzEeA4bppzlIogVCcpgRyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvmSNeQfr5sCOAv6uVdS7m8FgOdk5DWbIwygX7/SmSCchR/D2u4H0swCQZZOBRLkX
	 taDrhpypCNIbpdBoCjhto+a4+lsnyWFxxh8M2yBy+h5LhyFV7HBAjLO6InfrkM/hVB
	 DYGD0yP9907NJj/P3pK/KeSXcnaRoojbGR7GQcw/vKp2FtpL6JKqmpqqGo/8hUKG5h
	 uiRXq4kqJGN6SJDIPh/4W4wX0qYRCiJFPaXih0XXKFfXXIjAMY4ef97Okscd+AYyVV
	 YzJE+4ligGxsEbQ2L0LXnZJparAT6oONbrq4Nn+mDcg3pS4sOiCS8MNO7pNlobJF4f
	 VMFGpEFaqnHiw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:12 +0200
Subject: [PATCH 12/14] drm/tidss: dispc: Switch VP_REG_FLD_MOD to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-12-a71ae8dd2782@kernel.org>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
In-Reply-To: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5302; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bRiJmUbTP2CEaFqChGX+gLzEeA4bppzlIogVCcpgRyo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd91I4Ptk76H/SO7N1x9kbikuXtkTbnOl8nhFw6n6Rn
 2C9rv+mjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRqxcZazhUxC/stHVuNVn5
 89CBBIaZqvoy+yIeHdnWODFpXt+JfROe7Lt7Rst1htIFzRuaq84s9GGs4dd4MOP627UPrr746fV
 9Fd/yA6G2xt3+K8NnfroausN42XoZkSxR0e7579dlXJH4pZ15EQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The VP_REG_FLD_MOD function takes the start and end bits as parameter
and will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change VP_REG_FLD_MOD to take the mask as an argument instead, and
let the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 743ceca721691b3944d36bdd5e5fb929d19ab82c..ba843248749d98f08a2393bc54f92f26bba4223d 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -642,14 +642,14 @@ static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx, u32 mask)
 {
 	return FIELD_GET(mask, dispc_vp_read(dispc, vp, idx));
 }
 
 static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
-			   u32 start, u32 end)
+			   u32 mask)
 {
 	dispc_vp_write(dispc, vp, idx,
-		       FLD_MOD(dispc_vp_read(dispc, vp, idx), val, GENMASK(start, end)));
+		       FLD_MOD(dispc_vp_read(dispc, vp, idx), val, mask));
 }
 
 static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
@@ -1126,11 +1126,12 @@ static void dispc_set_num_datalines(struct dispc_device *dispc,
 	default:
 		WARN_ON(1);
 		v = 3;
 	}
 
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, v, 10, 8);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, v,
+		       GENMASK(10, 8));
 }
 
 static void dispc_enable_am65x_oldi(struct dispc_device *dispc, u32 hw_videoport,
 				    const struct dispc_bus_format *fmt)
 {
@@ -1254,16 +1255,18 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_SIZE_SCREEN,
 		       FIELD_PREP(GENMASK(11, 0), mode->hdisplay - 1) |
 		       FIELD_PREP(GENMASK(27, 16), mode->vdisplay - 1));
 
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
+		       GENMASK(0, 0));
 }
 
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 {
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0, 0, 0);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
+		       GENMASK(0, 0));
 }
 
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
 {
 	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
@@ -1280,11 +1283,12 @@ bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport)
 }
 
 void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
 {
 	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL, GENMASK(5, 5)));
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 5, 5);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
+		       GENMASK(5, 5));
 }
 
 enum c8_to_c12_mode { C8_TO_C12_REPLICATE, C8_TO_C12_MAX, C8_TO_C12_MIN };
 
 static u16 c8_to_c12(u8 c8, enum c8_to_c12_mode mode)
@@ -2454,11 +2458,11 @@ static void dispc_vp_init(struct dispc_device *dispc)
 
 	dev_dbg(dispc->dev, "%s()\n", __func__);
 
 	/* Enable the gamma Shadow bit-field for all VPs*/
 	for (i = 0; i < dispc->feat->num_vps; i++)
-		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1, 2, 2);
+		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1, GENMASK(2, 2));
 }
 
 static void dispc_initial_config(struct dispc_device *dispc)
 {
 	dispc_plane_init(dispc);
@@ -2687,12 +2691,12 @@ static void dispc_k2g_vp_set_ctm(struct dispc_device *dispc, u32 hw_videoport,
 		dispc_k2g_cpr_from_ctm(ctm, &cpr);
 		dispc_k2g_vp_write_csc(dispc, hw_videoport, &cpr);
 		cprenable = 1;
 	}
 
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONFIG,
-		       cprenable, 15, 15);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONFIG, cprenable,
+		       GENMASK(15, 15));
 }
 
 static s16 dispc_S31_32_to_s3_8(s64 coef)
 {
 	u64 sign_bit = 1ULL << 63;
@@ -2753,12 +2757,12 @@ static void dispc_k3_vp_set_ctm(struct dispc_device *dispc, u32 hw_videoport,
 		dispc_csc_from_ctm(ctm, &csc);
 		dispc_k3_vp_write_csc(dispc, hw_videoport, &csc);
 		colorconvenable = 1;
 	}
 
-	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONFIG,
-		       colorconvenable, 24, 24);
+	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONFIG, colorconvenable,
+		       GENMASK(24, 24));
 }
 
 static void dispc_vp_set_color_mgmt(struct dispc_device *dispc,
 				    u32 hw_videoport,
 				    const struct drm_crtc_state *state,
@@ -2905,11 +2909,12 @@ static void dispc_softreset_k2g(struct dispc_device *dispc)
 	dispc_set_irqenable(dispc, 0);
 	dispc_read_and_clear_irqstatus(dispc);
 	spin_unlock_irqrestore(&dispc->tidss->irq_lock, flags);
 
 	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
-		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
+		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0,
+			       GENMASK(0, 0));
 }
 
 static int dispc_softreset(struct dispc_device *dispc)
 {
 	u32 val;

-- 
2.50.1


