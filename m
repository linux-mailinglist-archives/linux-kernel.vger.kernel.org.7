Return-Path: <linux-kernel+bounces-777868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A0B2DEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3FE1BA7759
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839B2DA76F;
	Wed, 20 Aug 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6V6YnOd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11972D94AF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698543; cv=none; b=qrqXHrH/2B/xfe3P22HJzOSwOQdxlHQZbliDojJ3swzPlO7ZdGDReQJQZwBNy4I6aTBA4ZsLPG4V1v9E5THOddaotH0qJuRxLs9RYI3emZODSYALlXSHJ6DybdHxpIUuPIfkVUF2bvp0HSIr/VvmZifE0qJKMAv0Qxv7EV39/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698543; c=relaxed/simple;
	bh=tyf4QDY+Y4oRSzMu6QcNi4jQbxuRHQzh39N7pPTYBIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeeZo5r2r19S4GPGrE7nb35mz5Df/Dgdv4I34TphCUWuGXcN5+Tq4BBdWWj1I/3AZ8dC6Ocy/mIAszucXSFuyq55tF9r+10k/hMraVXPwrgYhdVpN2oLvVehLwO1C2jO86VidPZkjXUJyfsH1LH554+f1dW4dDSOKVwoQerFzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6V6YnOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42638C4CEEB;
	Wed, 20 Aug 2025 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698543;
	bh=tyf4QDY+Y4oRSzMu6QcNi4jQbxuRHQzh39N7pPTYBIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6V6YnOdlR5+JjRMoQ1GMMzPzsrMgp3wILKvNTK9eE18JA6G7mrm0/EkPdV638M9r
	 usqzjuaI/wX/HAI1Djrxrrta6awmnOWEjUenoou5tZ+CTFUkSKC4G/9rjxa5I0F3ni
	 HNmSCoFcdMYcsUvECR8G5ETa57jbV3N1fVS+SgNdKcINEkasjwgY4N7/Wu+ewDSz7c
	 /sO6q8S5CWj6D11CvXlSwybJpiswcQV5kK5kijw0vuLx5faewcR4LyO06Qy23tEcO0
	 +XQ0/OQjGIZPeJfsccWIk+nXDh/w7ougsYkrU1LYI1rJERDxnu3SndGw0qy8bEFgj9
	 gW0z6hXg+P+Gg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:48 +0200
Subject: [PATCH v2 08/14] drm/tidss: dispc: Switch REG_FLD_MOD to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-8-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3642; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tyf4QDY+Y4oRSzMu6QcNi4jQbxuRHQzh39N7pPTYBIs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwatcfYK4IyYWbxZV+etq3W23tbP0x/dun/rbCiLz
 XbuY+Z5HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAir94xNtyurVg6mbMjsFvu
 0IkPe/WK/Tv+61tmNkXWnfz4ZOumi1paXM08J7xXWL8rLw6YL/eNhbFO74PiI5c75wJzpA5kCUq
 s42fe+lH2+ewgmzd6M94aSEk8tJE8y7m/wYRxDufebC6rHYoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The REG_FLD_MOD function takes the start and end bits as parameter and
will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change REG_FLD_MOD to take the mask as an argument instead, and
let the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 807ab0e0afc7f95efe55764dcb08da695fb85963..1b2791e8c04c463552ad370f48dce8eae5b94702 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -610,16 +610,16 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
  */
 
 #define REG_GET(dispc, idx, mask)					\
 	((u32)FIELD_GET((mask), dispc_read((dispc), (idx))))
 
-#define REG_FLD_MOD(dispc, idx, val, start, end)			\
+#define REG_FLD_MOD(dispc, idx, val, mask)				\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _idx = (idx);					\
 		u32 _reg = dispc_read(_dispc, _idx);			\
-		FIELD_MODIFY(GENMASK((start), (end)), &_reg, (val));	\
+		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_write(_dispc, _idx, _reg);			\
 	})
 
 #define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
 	((u32)FIELD_GET(GENMASK((start), (end)),			\
@@ -2331,13 +2331,13 @@ static void dispc_k2g_plane_init(struct dispc_device *dispc)
 	unsigned int hw_plane;
 
 	dev_dbg(dispc->dev, "%s()\n", __func__);
 
 	/* MFLAG_CTRL = ENABLED */
-	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 2, 1, 0);
+	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 2, GENMASK(1, 0));
 	/* MFLAG_START = MFLAGNORMALSTARTMODE */
-	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 0, 6, 6);
+	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 0, GENMASK(6, 6));
 
 	for (hw_plane = 0; hw_plane < dispc->feat->num_vids; hw_plane++) {
 		u32 size = dispc_vid_get_fifo_size(dispc, hw_plane);
 		u32 thr_low, thr_high;
 		u32 mflag_low, mflag_high;
@@ -2382,17 +2382,17 @@ static void dispc_k3_plane_init(struct dispc_device *dispc)
 	u32 cba_lo_pri = 1;
 	u32 cba_hi_pri = 0;
 
 	dev_dbg(dispc->dev, "%s()\n", __func__);
 
-	REG_FLD_MOD(dispc, DSS_CBA_CFG, cba_lo_pri, 2, 0);
-	REG_FLD_MOD(dispc, DSS_CBA_CFG, cba_hi_pri, 5, 3);
+	REG_FLD_MOD(dispc, DSS_CBA_CFG, cba_lo_pri, GENMASK(2, 0));
+	REG_FLD_MOD(dispc, DSS_CBA_CFG, cba_hi_pri, GENMASK(5, 3));
 
 	/* MFLAG_CTRL = ENABLED */
-	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 2, 1, 0);
+	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 2, GENMASK(1, 0));
 	/* MFLAG_START = MFLAGNORMALSTARTMODE */
-	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 0, 6, 6);
+	REG_FLD_MOD(dispc, DISPC_GLOBAL_MFLAG_ATTRIBUTE, 0, GENMASK(6, 6));
 
 	for (hw_plane = 0; hw_plane < dispc->feat->num_vids; hw_plane++) {
 		u32 size = dispc_vid_get_fifo_size(dispc, hw_plane);
 		u32 thr_low, thr_high;
 		u32 mflag_low, mflag_high;
@@ -2916,11 +2916,11 @@ static int dispc_softreset(struct dispc_device *dispc)
 		dispc_softreset_k2g(dispc);
 		return 0;
 	}
 
 	/* Soft reset */
-	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);
+	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, GENMASK(1, 1));
 	/* Wait for reset to complete */
 	ret = readl_poll_timeout(dispc->base_common + DSS_SYSSTATUS,
 				 val, val & 1, 100, 5000);
 	if (ret) {
 		dev_err(dispc->dev, "failed to reset dispc\n");

-- 
2.50.1


