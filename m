Return-Path: <linux-kernel+bounces-750411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E216B15B12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A6218C080E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF72951CD;
	Wed, 30 Jul 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8Qy6r2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C8292B4D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865847; cv=none; b=pcY49T1Q2s3LTQ/p3cOvhrS3gSfYYHCVkEyDV2YBcb33GGz+vPn6JfLNaxLmmUUZyztDq0OUZ0pgzcpU4xTf5rGbi2J9b+rqPcsFm5ce+ihh9d830sRSFZ57YI0ToSYi12Dz/YP+6l3f/43j+eHqMT5FJ73YFWVqhJKs+HOvB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865847; c=relaxed/simple;
	bh=9K35uZwPjzxtwzKo6ZMyRr2kFSxlchGdQNRiwtz6A4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAUXH6r/KE41hmpg4tJV2Kxzf2LEAViVkuOFMbigjYsMm1QaQxxm1MiRAuWifs8Cifh/UZnCEYm1VuYURcbT3VaiVD6z5NrCqMy09+hY391daI3+RmTXp9ethAEOq2+gGCvn+uR1wgljccOSpVTeXHzh8qksWy/CRYUwz+S5hYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8Qy6r2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA761C4CEE7;
	Wed, 30 Jul 2025 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865847;
	bh=9K35uZwPjzxtwzKo6ZMyRr2kFSxlchGdQNRiwtz6A4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L8Qy6r2N2P4DyRaoxYb2FLtMV6r7CURqncUtCIFEnb91vrw7mMK4KWw1rbdXG7Ry8
	 F5zHdmA+l77uTJkNHkr18a4tK6Tn8z+jDAOWrwuwYxpE7uY1pf4mrY1g00KliWfXnt
	 3aUlJ6r7R1TqpsVQB3MaHDm9NY0p4YyhVYCS0zFpsR2HTSC7jTsevsgafwh248pV1U
	 K3nRCKHJLgb9nloRuA61nxoQP3DCyxkqbjFVyqemV7tAFs5rB5SazoAFi+zp1CldM/
	 gatwOif5qi3iZvSgPVPmhJajbZ28P5IueB5asmwWUph6znpXUP17bQFJ+IVGKZ0Qc1
	 uO3LiICyJsU9g==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:05 +0200
Subject: [PATCH 05/14] drm/tidss: dispc: Get rid of FLD_VAL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-5-a71ae8dd2782@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6831; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9K35uZwPjzxtwzKo6ZMyRr2kFSxlchGdQNRiwtz6A4A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9xLvnmThOWqneFgtjt+Wab7saovtW5dF1/BcOL/z/
 YVWtXktHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiV6MYGxp/xLJv2NI5xVnf
 rGr/scDdL/7wCCyyvbXw1ld+PXNOy98tNfa75ro1eRTd+f/z/gKuJ4wNSxf5ZjPEfHiYNEtH5Kv
 U5twpb+0n35ugP/fxQpfCI/3/VXY014rErNt8vLyH7blO4ScNAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_VAL function is an equivalent to what FIELD_PREP + GENMASK
provide, so let's drop it and switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 57 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 974387313632cc85fb6c4d559b4d35656b1119da..30f281221a5de6b69cc3edd2bf643cf0f8bea63b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,18 +607,14 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-static u32 FLD_VAL(u32 val, u32 start, u32 end)
-{
-	return FIELD_PREP(GENMASK(start, end), val);
-}
-
 static u32 FLD_MOD(u32 orig, u32 val, u32 start, u32 end)
 {
-	return (orig & ~GENMASK(start, end)) | FLD_VAL(val, start, end);
+	return (orig & ~GENMASK(start, end)) | FIELD_PREP(GENMASK(start, end),
+							  val);
 }
 
 static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 start, u32 end)
 {
 	return FIELD_GET(GENMASK(start, end), dispc_read(dispc, idx));
@@ -1221,18 +1217,18 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 	vfp = mode->vsync_start - mode->vdisplay;
 	vsw = mode->vsync_end - mode->vsync_start;
 	vbp = mode->vtotal - mode->vsync_end;
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_TIMING_H,
-		       FLD_VAL(hsw - 1, 7, 0) |
-		       FLD_VAL(hfp - 1, 19, 8) |
-		       FLD_VAL(hbp - 1, 31, 20));
+		       FIELD_PREP(GENMASK(7, 0), hsw - 1) |
+		       FIELD_PREP(GENMASK(19, 8), hfp - 1) |
+		       FIELD_PREP(GENMASK(31, 20), hbp - 1));
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_TIMING_V,
-		       FLD_VAL(vsw - 1, 7, 0) |
-		       FLD_VAL(vfp, 19, 8) |
-		       FLD_VAL(vbp, 31, 20));
+		       FIELD_PREP(GENMASK(7, 0), vsw - 1) |
+		       FIELD_PREP(GENMASK(19, 8), vfp) |
+		       FIELD_PREP(GENMASK(31, 20), vbp));
 
 	ivs = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
 
 	ihs = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
 
@@ -1251,21 +1247,21 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 	/* always use DE_HIGH for OLDI */
 	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X)
 		ieo = false;
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_POL_FREQ,
-		       FLD_VAL(align, 18, 18) |
-		       FLD_VAL(onoff, 17, 17) |
-		       FLD_VAL(rf, 16, 16) |
-		       FLD_VAL(ieo, 15, 15) |
-		       FLD_VAL(ipc, 14, 14) |
-		       FLD_VAL(ihs, 13, 13) |
-		       FLD_VAL(ivs, 12, 12));
+		       FIELD_PREP(GENMASK(18, 18), align) |
+		       FIELD_PREP(GENMASK(17, 17), onoff) |
+		       FIELD_PREP(GENMASK(16, 16), rf) |
+		       FIELD_PREP(GENMASK(15, 15), ieo) |
+		       FIELD_PREP(GENMASK(14, 14), ipc) |
+		       FIELD_PREP(GENMASK(13, 13), ihs) |
+		       FIELD_PREP(GENMASK(12, 12), ivs));
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_SIZE_SCREEN,
-		       FLD_VAL(mode->hdisplay - 1, 11, 0) |
-		       FLD_VAL(mode->vdisplay - 1, 27, 16));
+		       FIELD_PREP(GENMASK(11, 0), mode->hdisplay - 1) |
+		       FIELD_PREP(GENMASK(27, 16), mode->vdisplay - 1));
 
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
 }
 
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
@@ -1577,18 +1573,18 @@ struct dispc_csc_coef {
 #define DISPC_CSC_REGVAL_LEN 8
 
 static
 void dispc_csc_offset_regval(const struct dispc_csc_coef *csc, u32 *regval)
 {
-#define OVAL(x, y) (FLD_VAL(x, 15, 3) | FLD_VAL(y, 31, 19))
+#define OVAL(x, y) (FIELD_PREP(GENMASK(15, 3), x) | FIELD_PREP(GENMASK(31, 19), y))
 	regval[5] = OVAL(csc->preoffset[0], csc->preoffset[1]);
 	regval[6] = OVAL(csc->preoffset[2], csc->postoffset[0]);
 	regval[7] = OVAL(csc->postoffset[1], csc->postoffset[2]);
 #undef OVAL
 }
 
-#define CVAL(x, y) (FLD_VAL(x, 10, 0) | FLD_VAL(y, 26, 16))
+#define CVAL(x, y) (FIELD_PREP(GENMASK(10, 0), x) | FIELD_PREP(GENMASK(26, 16), y))
 static
 void dispc_csc_yuv2rgb_regval(const struct dispc_csc_coef *csc, u32 *regval)
 {
 	regval[0] = CVAL(csc->m[CSC_RY], csc->m[CSC_RCR]);
 	regval[1] = CVAL(csc->m[CSC_RCB], csc->m[CSC_GY]);
@@ -1823,11 +1819,12 @@ static void dispc_vid_write_fir_coefs(struct dispc_device *dispc,
 		s16 c1, c2;
 		u32 c12;
 
 		c1 = coefs->c1[phase];
 		c2 = coefs->c2[phase];
-		c12 = FLD_VAL(c1, 19, 10) | FLD_VAL(c2, 29, 20);
+		c12 = FIELD_PREP(GENMASK(19, 10), c1) | FIELD_PREP(GENMASK(29, 20),
+								   c2);
 
 		dispc_vid_write(dispc, hw_plane, reg, c12);
 	}
 }
 
@@ -2321,18 +2318,18 @@ static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 
 static void dispc_vid_set_mflag_threshold(struct dispc_device *dispc,
 					  u32 hw_plane, u32 low, u32 high)
 {
 	dispc_vid_write(dispc, hw_plane, DISPC_VID_MFLAG_THRESHOLD,
-			FLD_VAL(high, 31, 16) | FLD_VAL(low, 15, 0));
+			FIELD_PREP(GENMASK(31, 16), high) | FIELD_PREP(GENMASK(15, 0), low));
 }
 
 static void dispc_vid_set_buf_threshold(struct dispc_device *dispc,
 					u32 hw_plane, u32 low, u32 high)
 {
 	dispc_vid_write(dispc, hw_plane, DISPC_VID_BUF_THRESHOLD,
-			FLD_VAL(high, 31, 16) | FLD_VAL(low, 15, 0));
+			FIELD_PREP(GENMASK(31, 16), high) | FIELD_PREP(GENMASK(15, 0), low));
 }
 
 static void dispc_k2g_plane_init(struct dispc_device *dispc)
 {
 	unsigned int hw_plane;
@@ -2469,12 +2466,12 @@ static void dispc_initial_config(struct dispc_device *dispc)
 	dispc_vp_init(dispc);
 
 	/* Note: Hardcoded DPI routing on J721E for now */
 	if (dispc->feat->subrev == DISPC_J721E) {
 		dispc_write(dispc, DISPC_CONNECTIONS,
-			    FLD_VAL(2, 3, 0) |		/* VP1 to DPI0 */
-			    FLD_VAL(8, 7, 4)		/* VP3 to DPI1 */
+			    FIELD_PREP(GENMASK(3, 0), 2) |		/* VP1 to DPI0 */
+			    FIELD_PREP(GENMASK(7, 4), 8)		/* VP3 to DPI1 */
 			);
 	}
 }
 
 static void dispc_k2g_vp_write_gamma_table(struct dispc_device *dispc,
@@ -2648,12 +2645,12 @@ static void dispc_k2g_cpr_from_ctm(const struct drm_color_ctm *ctm,
 	cpr->m[CSC_BR] = dispc_S31_32_to_s2_8(ctm->matrix[6]);
 	cpr->m[CSC_BG] = dispc_S31_32_to_s2_8(ctm->matrix[7]);
 	cpr->m[CSC_BB] = dispc_S31_32_to_s2_8(ctm->matrix[8]);
 }
 
-#define CVAL(xR, xG, xB) (FLD_VAL(xR, 9, 0) | FLD_VAL(xG, 20, 11) |	\
-			  FLD_VAL(xB, 31, 22))
+#define CVAL(xR, xG, xB) (FIELD_PREP(GENMASK(9, 0), xR) | FIELD_PREP(GENMASK(20, 11), xG) |	\
+			  FIELD_PREP(GENMASK(31, 22), xB))
 
 static void dispc_k2g_vp_csc_cpr_regval(const struct dispc_csc_coef *csc,
 					u32 *regval)
 {
 	regval[0] = CVAL(csc->m[CSC_BB], csc->m[CSC_BG], csc->m[CSC_BR]);

-- 
2.50.1


