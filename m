Return-Path: <linux-kernel+bounces-777865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B70B2DEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5851C25794
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0E274B32;
	Wed, 20 Aug 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK895sny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE32749D6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698538; cv=none; b=giRhDHCfjk01tZG8fa7/wmvyRYM+mAtpT5Puj5BdHri24biyxVcUnfbRcxblYQd9v9HdLdVU/HpHderFswWp4zEg73uJN8ZP9CLV1BXp4LP9RZeCFFcQ3005kyY5SY/nLsaHSfUc8S0qttqNJMd3tvDGiyj5GsrFJjWHckNCaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698538; c=relaxed/simple;
	bh=EYMqfrY9ZLQjH+7eX0m9uico3jmwKgGSQ3eRF+qyzw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWHUYofa5w2lJKcjae5RUoyifO8ucyobx5z8Z/JFKuwVfwfOCe4knbmv2n9oObGl8W3jB8YQrNa/SeuKOflvCXncOwz497A0RYw11gT5cXvP38Oc+02dXgOa0fPmJEdvs1EqM8v8/lfgphz7pqpdKvU4mmOGhDUdwjQn6k4Yh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK895sny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50ADC4CEE7;
	Wed, 20 Aug 2025 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698538;
	bh=EYMqfrY9ZLQjH+7eX0m9uico3jmwKgGSQ3eRF+qyzw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WK895snyqq/N5zCQh83kCj09qAAG14QGtfQhyP/IgxwhqoEbZskKEKGlBS1A4Yk8I
	 GP5NQYxs63cfjlIf8qLVs7VpC6cj7pPEV3wM0oyIfjAR3wIeXhugNdTRo71SLDGQ9N
	 /ZwOdQBWt90qGXm8P3RkhKueU+IpJZyIxHCdfqKULsgWZCJ2mP8sahQNysl/WHuc5z
	 CFzI1U39Pu7aROdECmJ2es8RrSsYwnaiavPFMz7t3lzAjcFkvC5pUlRafuX85chZ2S
	 vjFrJGHmoSO9RoLgdgd4xwPloVXYj2ZJs5JMQ4+vM3jTG6+epxjOkeVRGulGq6440n
	 dGydj8SiEY9GA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:46 +0200
Subject: [PATCH v2 06/14] drm/tidss: dispc: Get rid of FLD_MOD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-6-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EYMqfrY9ZLQjH+7eX0m9uico3jmwKgGSQ3eRF+qyzw0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwaWBYb3rdowN/3+lIPTU3RXc7H9/eYZUvSC+Y3r7
 F5BfYYrHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiwtyM9TlfzTc2Tej3Sdm/
 2+HAguTzfu+clG5VPf4X27LVZkNSjvwz7gvhSge7WB5YMm98XbZqI2PDsvvHlxRt5X53dlqC0cW
 1FmuY+U13apc6T3qRWP4gsLnLfpPcSb4/qSausjeOm65sYtsIAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_MOD function is an equivalent to what FIELD_MODIFY + GENMASK
provide, so let's drop it and switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 50d5eda0670e6e090d05af6a2c05e5b88f28c322..fef56aed3f6edb6630d079f354821ada5fad327d 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,29 +607,21 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-#define FLD_MOD(orig, val, start, end)					\
-	({								\
-		int _start = (start), _end = (end);			\
-		u32 _masked_val = (orig) & ~GENMASK(_start, _end);	\
-		u32 _new_val = _masked_val | FIELD_PREP(GENMASK(_start, _end), (val)); \
-		_new_val;						\
-	})
-
 #define REG_GET(dispc, idx, start, end)					\
 	((u32)FIELD_GET(GENMASK((start), (end)),			\
 			dispc_read((dispc), (idx))))
 
 #define REG_FLD_MOD(dispc, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _idx = (idx);					\
-		u32 _curr = dispc_read(_dispc, _idx);			\
-		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
-		dispc_write(_dispc, _idx, _new);			\
+		u32 _reg = dispc_read(_dispc, _idx);			\
+		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		dispc_write(_dispc, _idx, _reg);			\
 	})
 
 #define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
 	((u32)FIELD_GET(GENMASK((start), (end)),			\
 			dispc_vid_read((dispc), (hw_plane), (idx))))
@@ -637,13 +629,13 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 #define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _hw_plane = (hw_plane);				\
 		u32 _idx = (idx);					\
-		u32 _curr = dispc_vid_read(_dispc, _hw_plane, _idx);	\
-		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
-		dispc_vid_write(_dispc, _hw_plane, _idx, _new);		\
+		u32 _reg = dispc_vid_read(_dispc, _hw_plane, _idx);	\
+		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		dispc_vid_write(_dispc, _hw_plane, _idx, _reg);		\
 	})
 
 #define VP_REG_GET(dispc, vp, idx, start, end)				\
 	((u32)FIELD_GET(GENMASK((start), (end)),			\
 			dispc_vp_read((dispc), (vp), (idx))))
@@ -651,23 +643,23 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 #define VP_REG_FLD_MOD(dispc, vp, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _vp = (vp);						\
 		u32 _idx = (idx);					\
-		u32 _curr = dispc_vp_read(_dispc, _vp, _idx);		\
-		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
-		dispc_vp_write(_dispc, _vp, _idx, _new);		\
+		u32 _reg = dispc_vp_read(_dispc, _vp, _idx);		\
+		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		dispc_vp_write(_dispc, _vp, _idx, _reg);		\
 	})
 
 #define OVR_REG_FLD_MOD(dispc, ovr, idx, val, start, end)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
-		u32 _ovr = (ovr);						\
+		u32 _ovr = (ovr);					\
 		u32 _idx = (idx);					\
-		u32 _curr = dispc_ovr_read(_dispc, _ovr, _idx);		\
-		u32 _new = FLD_MOD(_curr, (val), (start), (end));	\
-		dispc_ovr_write(_dispc, _ovr, _idx, _new);		\
+		u32 _reg = dispc_ovr_read(_dispc, _ovr, _idx);		\
+		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		dispc_ovr_write(_dispc, _ovr, _idx, _reg);		\
 	})
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
 	dispc_irq_t vp_stat = 0;
@@ -1160,11 +1152,11 @@ static void dispc_enable_am65x_oldi(struct dispc_device *dispc, u32 hw_videoport
 		dev_warn(dispc->dev, "%s: %d port width not supported\n",
 			 __func__, fmt->data_width);
 
 	oldi_cfg |= BIT(7); /* DEPOL */
 
-	oldi_cfg = FLD_MOD(oldi_cfg, fmt->am65x_oldi_mode_reg_val, 3, 1);
+	FIELD_MODIFY(GENMASK(3, 1), &oldi_cfg, fmt->am65x_oldi_mode_reg_val);
 
 	oldi_cfg |= BIT(12); /* SOFTRST */
 
 	oldi_cfg |= BIT(0); /* ENABLE */
 

-- 
2.50.1


