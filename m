Return-Path: <linux-kernel+bounces-777870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE650B2DEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE48E680FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0A25A2C7;
	Wed, 20 Aug 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq2C+kqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9982E5B2F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698549; cv=none; b=ajQPhRuT7GfvVRY9p87/GdjdofjBw42Olih41a54zBobDaWXOmm00vLNkh/jC2AlCEOXZNoNnMROZFaMnK9vWXmFoB6K+9O5OJ4Vwp15+uaS9Fe+GIsWWdtzVvvgJlwv9+nETjFqtLgvcBfWEVpfvSpI6PsT0D8NxI4+FPXotCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698549; c=relaxed/simple;
	bh=fDlH7Dl44z2D5Cx4UK14nab6ys1a6BsEEAuxo4ovtjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJlWqV6ycaqqKui8C+uPArWocJqztGjQ1RmBMSnNPVWAH6ys+KhEglIn6Esfhh1aUJ2Ko0F6uN/aDBK2b5JO6xT/i4LIaS3V1bVQ0by0zmob8maOemMEAxZYJqAwQkQm48i2upxgR5y1cjdwBJVJ/07SFBr9UswCwZIm3bOSGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq2C+kqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DD2C116B1;
	Wed, 20 Aug 2025 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698548;
	bh=fDlH7Dl44z2D5Cx4UK14nab6ys1a6BsEEAuxo4ovtjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vq2C+kqc7lmG84N+RXhvDjohnx58pl6gc5A8npjjEk6sLc1z4C8TWpcuYvJVAcym/
	 +cJs/EnWmZ9xPAAFhLD+VD5V+I2iSEYsjIGtc9vKEXGW/WooWlUQ8mwAKgZmZk7E4B
	 /vQSc8wdYfGQvRhyuxlviqzZ4iwGs16O6GYW48QD/gISpIrSeqsY21RFJsIBSynfzU
	 aGjT/l2UPt7vjdB6P2+J5BwvmuB87Ccby1bDf5da58PvuYIINN/E1EnEdvyNPLE2zl
	 gdcESqIA94Lucrux7LXA3HFYVJmCo36zowWRWLjkLBrAT4GLFUtBdCQ09wPZLAnyeC
	 nKTcoZcPA+BeQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:50 +0200
Subject: [PATCH v2 10/14] drm/tidss: dispc: Switch VID_REG_FLD_MOD to using
 a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-10-43cab671c648@kernel.org>
References: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
In-Reply-To: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fDlH7Dl44z2D5Cx4UK14nab6ys1a6BsEEAuxo4ovtjo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwbfsjnd/iBsIsf3p9fmXUkMi558/crGGR5ri29y7
 CtwYpOV7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATyZ7AWKeVYSl8Om2dJF/P
 r/32fq6n/K9k3il8s6+uZHHCj+yS0rn/9mx5drU/bZ5+8Cqemu9T5jPWafRIa2w45a2Y7xsYqsL
 L8sR8pbDqff1Ns1oeHV2Rt+Ygk0PzA9lTuq0qlVrbX1hLyMgDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The VID_REG_FLD_MOD function takes the start and end bits as parameter
and will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change VID_REG_FLD_MOD to take the mask as an argument instead,
and let the caller create the mask. Eventually, this mask will be moved
to a define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index b4928cfbb6f7ca9a03371c5e599e2029baae333f..8c0949203ace147e403ea43ab468c3a56d170156 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -622,17 +622,17 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 	})
 
 #define VID_REG_GET(dispc, hw_plane, idx, mask)				\
 	((u32)FIELD_GET((mask), dispc_vid_read((dispc), (hw_plane), (idx))))
 
-#define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
+#define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, mask)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _hw_plane = (hw_plane);				\
 		u32 _idx = (idx);					\
 		u32 _reg = dispc_vid_read(_dispc, _hw_plane, _idx);	\
-		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_vid_write(_dispc, _hw_plane, _idx, _reg);		\
 	})
 
 #define VP_REG_GET(dispc, vp, idx, start, end)				\
 	((u32)FIELD_GET(GENMASK((start), (end)),			\
@@ -1755,11 +1755,12 @@ static void dispc_vid_csc_setup(struct dispc_device *dispc, u32 hw_plane,
 }
 
 static void dispc_vid_csc_enable(struct dispc_device *dispc, u32 hw_plane,
 				 bool enable)
 {
-	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable, 9, 9);
+	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable,
+			GENMASK(9, 9));
 }
 
 /* SCALER */
 
 static u32 dispc_calc_fir_inc(u32 in, u32 out)
@@ -2012,24 +2013,24 @@ static void dispc_vid_set_scaling(struct dispc_device *dispc,
 				  u32 hw_plane,
 				  struct dispc_scaling_params *sp,
 				  u32 fourcc)
 {
 	/* HORIZONTAL RESIZE ENABLE */
-	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES,
-			sp->scale_x, 7, 7);
+	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, sp->scale_x,
+			GENMASK(7, 7));
 
 	/* VERTICAL RESIZE ENABLE */
-	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES,
-			sp->scale_y, 8, 8);
+	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, sp->scale_y,
+			GENMASK(8, 8));
 
 	/* Skip the rest if no scaling is used */
 	if (!sp->scale_x && !sp->scale_y)
 		return;
 
 	/* VERTICAL 5-TAPS  */
-	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES,
-			sp->five_taps, 21, 21);
+	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, sp->five_taps,
+			GENMASK(21, 21));
 
 	if (dispc_fourcc_is_yuv(fourcc)) {
 		if (sp->scale_x) {
 			dispc_vid_write(dispc, hw_plane, DISPC_VID_FIRH2,
 					sp->fir_xinc_uv);
@@ -2115,11 +2116,11 @@ static void dispc_plane_set_pixel_format(struct dispc_device *dispc,
 
 	for (i = 0; i < ARRAY_SIZE(dispc_color_formats); ++i) {
 		if (dispc_color_formats[i].fourcc == fourcc) {
 			VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES,
 					dispc_color_formats[i].dss_code,
-					6, 1);
+					GENMASK(6, 1));
 			return;
 		}
 	}
 
 	WARN_ON(1);
@@ -2293,19 +2294,20 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 	dispc_vid_write(dispc, hw_plane, DISPC_VID_GLOBAL_ALPHA,
 			0xFF & (state->alpha >> 8));
 
 	if (state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 		VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, 1,
-				28, 28);
+				GENMASK(28, 28));
 	else
 		VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, 0,
-				28, 28);
+				GENMASK(28, 28));
 }
 
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable)
 {
-	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable, 0, 0);
+	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable,
+			GENMASK(0, 0));
 }
 
 static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 {
 	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS,
@@ -2370,11 +2372,11 @@ static void dispc_k2g_plane_init(struct dispc_device *dispc)
 		 * Prefetch up to fifo high-threshold value to minimize the
 		 * possibility of underflows. Note that this means the PRELOAD
 		 * register is ignored.
 		 */
 		VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, 1,
-				19, 19);
+				GENMASK(19, 19));
 	}
 }
 
 static void dispc_k3_plane_init(struct dispc_device *dispc)
 {
@@ -2421,11 +2423,11 @@ static void dispc_k3_plane_init(struct dispc_device *dispc)
 
 		dispc_vid_write(dispc, hw_plane, DISPC_VID_PRELOAD, preload);
 
 		/* Prefech up to PRELOAD value */
 		VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, 0,
-				19, 19);
+				GENMASK(19, 19));
 	}
 }
 
 static void dispc_plane_init(struct dispc_device *dispc)
 {

-- 
2.50.1


