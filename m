Return-Path: <linux-kernel+bounces-788540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C411B38606
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38683B5715
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71A28EA72;
	Wed, 27 Aug 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBY4YzI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6128BABB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307599; cv=none; b=m+iu4aS+UxU3lXwh9bt2GugxvU5ncWsYSSzxjtx+1njOF2bT8vAlFK+sAJ/uWPI87GShudsW7VrSoblmZpXotDBJ2coojS0JacIVxi8kF42La5Rlr6N+WnmaTE7trzEOUThFvBO6WJ5zsYy5Vh5FyhkHJScSINFlsHCvMB0ta4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307599; c=relaxed/simple;
	bh=YJRlhFRqu1x2YPL2NtIVXHirsUuDmkG2DmqfkWYi4Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbz9AIJmCViGt3GzhyMtlpK/NrhdOWGRb6FxaKlevF6f/Bfydk6l2Xd3Lp/FpnQPohPyfW2JCft3foYaHeVYGLskqJAFbMOgXq3cflpfbYdHe4UM+kvIxlGzP61CO54OqrI0VoJtU1IRlwWEeCiZigTJ+RDjl+1YTIRTN9hVEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBY4YzI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5706C4CEEB;
	Wed, 27 Aug 2025 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307599;
	bh=YJRlhFRqu1x2YPL2NtIVXHirsUuDmkG2DmqfkWYi4Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NBY4YzI87uTE6W8uppAYTMaIWCjAoBLQZVyYXnkg0K7oHjUlwNw+zKDDg+ySfpbA6
	 8QymGYlaoQmI8YeRZzZEfx53ME4MTqlR5k4dVCiLNmvm0LB4SW2eoL4rBh5/rfyU+Z
	 61a4QAJk7Ek+CU2Ujk08C2E5tRnzkcsaBRRHyYYyEQMiD4SQfEaBt2rMUQPQYrwpLk
	 Br2+NCdCB97gP/YXogBsWE54sHhTmj4d+IyUozn7ZJAaoToy/bxwzVEGhu9/fZhXvN
	 4pGME9OnYUcgZnUrZ7K4+Xjt5XwGuOWL9v7loH8gXogH+j1GmWENNo++0LdBvzKnGK
	 G7id0a27s7tMA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:44 +0200
Subject: [PATCH v3 13/14] drm/tidss: dispc: Switch OVR_REG_FLD_MOD to using
 a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-13-7689b664cc63@kernel.org>
References: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
In-Reply-To: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YJRlhFRqu1x2YPL2NtIVXHirsUuDmkG2DmqfkWYi4Dg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFTKsJ/7+xnw+/17GCqausDrRHR/YZdRc7ywxOSPXN
 TONS9isYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExkahVjnQmD+N7ruzLPVbwt
 36rR81rRPMJGXdFv7dPTJ56d7Fu5rlsx5MNf919/bnGteL79+oGkQsZa6dS9F8x2eAQlbnwxq2H
 LPyXmrcyzEw4z/pOq9ZuZ9ODIZiuG9Yv+m7geCz3GKH2HfcMdAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The OVR_REG_FLD_MOD function takes the start and end bits as parameter
and will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change OVR_REG_FLD_MOD to take the mask as an argument instead,
and let the caller create the mask. Eventually, this mask will be moved
to a define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 0255f7156f46008c8fee2b37f1431957f1c71cad..9ecbea60d37cf981c8ce00f075f19f925cce44be 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -630,17 +630,17 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _reg = dispc_vp_read(_dispc, _vp, _idx);		\
 		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_vp_write(_dispc, _vp, _idx, _reg);		\
 	})
 
-#define OVR_REG_FLD_MOD(dispc, ovr, idx, val, start, end)		\
+#define OVR_REG_FLD_MOD(dispc, ovr, idx, val, mask)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _ovr = (ovr);					\
 		u32 _idx = (idx);					\
 		u32 _reg = dispc_ovr_read(_dispc, _ovr, _idx);		\
-		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_ovr_write(_dispc, _ovr, _idx, _reg);		\
 	})
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
@@ -1468,29 +1468,29 @@ static void dispc_am65x_ovr_set_plane(struct dispc_device *dispc,
 				      u32 x, u32 y, u32 layer)
 {
 	u32 hw_id = dispc->feat->vid_info[hw_plane].hw_id;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			hw_id, 4, 1);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			x, 17, 6);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			y, 30, 19);
+			hw_id, GENMASK(4, 1));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer), x,
+			GENMASK(17, 6));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer), y,
+			GENMASK(30, 19));
 }
 
 static void dispc_j721e_ovr_set_plane(struct dispc_device *dispc,
 				      u32 hw_plane, u32 hw_videoport,
 				      u32 x, u32 y, u32 layer)
 {
 	u32 hw_id = dispc->feat->vid_info[hw_plane].hw_id;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			hw_id, 4, 1);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer),
-			x, 13, 0);
-	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer),
-			y, 29, 16);
+			hw_id, GENMASK(4, 1));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer), x,
+			GENMASK(13, 0));
+	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES2(layer), y,
+			GENMASK(29, 16));
 }
 
 void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 			 u32 hw_videoport, u32 x, u32 y, u32 layer)
 {
@@ -1521,11 +1521,11 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 {
 	if (dispc->feat->subrev == DISPC_K2G)
 		return;
 
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
-			!!enable, 0, 0);
+			!!enable, GENMASK(0, 0));
 }
 
 /* CSC */
 enum csc_ctm {
 	CSC_RR, CSC_RG, CSC_RB,

-- 
2.50.1


