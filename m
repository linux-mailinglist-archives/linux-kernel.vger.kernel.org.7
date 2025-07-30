Return-Path: <linux-kernel+bounces-750414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8EB15B15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC418C0BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBB2951D9;
	Wed, 30 Jul 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toeAzCqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D735293462
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865856; cv=none; b=Us70YgoVi1tbWiURcS7F3sHIuijOwqZbZM4oNDwyobZQSmWVcnLmzZu1CL+HpKqQv07GDhHMr+kk5WHSd4I0e7JDJLnEM/WJHEKWcdSiklKrVJb0S+GSp/liswungTtNae7y6Qtq2bJQTEGUtb4xJ2Oyc+8UVVSL6VG+gjqupy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865856; c=relaxed/simple;
	bh=ckCwm94y3ouF4hgWKkHBVkDuFkJwr4qX5s2Tfa6qQQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KybrDxC5TwR0K2UdQiQI1DvigHVA+QldU5fNO8+bwQ15An8cAphnm14Trael/O3S2lJXkKSNc+4yNeq7E/bVLcxlxuC9wuSqppw9rpEoHHdYwn7r19zG6eb6gjNfs8RwB87gyEvmoM+FYHYdqV6gWpb0lHxaAcqTVLaUdIXqOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toeAzCqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD493C4CEF5;
	Wed, 30 Jul 2025 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865855;
	bh=ckCwm94y3ouF4hgWKkHBVkDuFkJwr4qX5s2Tfa6qQQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=toeAzCqukiNeh8TyTn4Rv9ItK4BjOD723XP5Y1jnm9JP30X29Uhld7DOXJXLrY5l4
	 mMGvCHYrzhAuNcQi29uh2Vfb9El0L6XfHnQTaNhM3nFGceKnX4P5/DRcYsZGfrc65B
	 4gJZhtFABafln5Wkp0p+GmtZDdLOYDdLkBPkgAhr8j/1Q5h5U2IRFiUAxuoAhODvcZ
	 yoAvAb4wvgNGx2YXDRjKUxI0UO771atLC3EDv0+0E34FgPrCahss6z7iL/d/pXX0YK
	 sk1zzG2tbUWhlPwskk6jp5Snyenpq8gesDuyCaIWQ5gRqmmuqWfxRsV3NqSfimaMbr
	 ihkqVPHCFkt+Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:08 +0200
Subject: [PATCH 08/14] drm/tidss: dispc: Switch REG_FLD_MOD to using a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-8-a71ae8dd2782@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ckCwm94y3ouF4hgWKkHBVkDuFkJwr4qX5s2Tfa6qQQk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd95JbpC/G7EndwyyYu/KS4tRQBsOWz9tm9RR/yfgjn
 JuVczK/YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkpABjfdwZj7kxZrcjIhcJ
 v19+/0CW46wq7ugd+zfPZ2CR42Gfby4/cYcDb8Fe1e19EmfWzpj3ibHh++fHvdx5DhVtWjYfUyc
 HKa0QZHTIZGHgvx3DGalSvM/jd+GLwC7llZ48Xl0Xc/qdnQE=
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
 drivers/gpu/drm/tidss/tidss_dispc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index cfd6c4cf716904cf78699baf2eb4c3a0f57a1abe..2d9bd95ded873232d22a1ecd8127cb0edc95c24c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -617,15 +617,14 @@ static u32 FLD_MOD(u32 orig, u32 val, u32 mask)
 static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 mask)
 {
 	return FIELD_GET(mask, dispc_read(dispc, idx));
 }
 
-static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val,
-			u32 start, u32 end)
+static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val, u32 mask)
 {
 	dispc_write(dispc, idx,
-		    FLD_MOD(dispc_read(dispc, idx), val, GENMASK(start, end)));
+		    FLD_MOD(dispc_read(dispc, idx), val, mask));
 }
 
 static u32 VID_REG_GET(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 		       u32 start, u32 end)
 {
@@ -2333,13 +2332,13 @@ static void dispc_k2g_plane_init(struct dispc_device *dispc)
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
@@ -2384,17 +2383,17 @@ static void dispc_k3_plane_init(struct dispc_device *dispc)
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
@@ -2918,11 +2917,11 @@ static int dispc_softreset(struct dispc_device *dispc)
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


