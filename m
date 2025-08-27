Return-Path: <linux-kernel+bounces-788535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA571B385FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73241B65746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705F27E7F9;
	Wed, 27 Aug 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNTsOlgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3D27D786
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307585; cv=none; b=i6kGQG8snKTCOPliPFxVEl4AYPtKzGOjuj5FHw5767j1eUMS9nedgUp+8VnYnx41e/41OHMMLxRq1KRRfzWjNNhO/o58zddxBJHcBZd4bLzP4nuRqjCCQv57Eto79SiOQe79K+gi90zsy7YxABG+utk8d8X7KKFO9bq0FYvtXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307585; c=relaxed/simple;
	bh=k6TwiI8He8GNSiGlGO+CMw9G5rhFmltlagnJGvSCcUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtqAmiuXzKSmf/5o04kDMyrIgElLpMLOuARfjxXPQmcmBotA6w1mxVA3mZRV/UQ7IyZBWx/RTut1bJQFHiHI7ZiVbhcOkhpdj23LPxOY3AVWFk552hZ2RexnhP9uaE9aKUltz44XUCHEj50DSJZHi3dP/HHqntMghEPgdeRyTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNTsOlgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84BFC4CEF0;
	Wed, 27 Aug 2025 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307585;
	bh=k6TwiI8He8GNSiGlGO+CMw9G5rhFmltlagnJGvSCcUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gNTsOlglXMeUUV2UbTVaB1a6wDp6C6CaEHdsOCguHmKF8UUQfNfMrD0aAGuoyfHvR
	 MFBCtujgsPC3K1NIhpP+yrBAVPB5gQ+fzIbEfME//eg2ypaVh9Lqa4J8Q36M7HC6pF
	 i12ub26z7b6bZ3lnDKyctcSDnwQwbWAaNwVVWHeh1Dvw4Z8SYpg4SpARYPS+fgMwm1
	 CeKYjpbTiudQtKYcR2FNwkRE7o6HL6iBRipg4ZNtkpAX42JoFODmdVi94/RZC9qWIG
	 yWFyw03Z4IC/zQ5i1gIosgBEc6wwRsDaL141gwjDNmjly35EaEIkRkzLOxSllocanG
	 TGGwmO1qwTtJg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:39 +0200
Subject: [PATCH v3 08/14] drm/tidss: dispc: Switch REG_FLD_MOD to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-8-7689b664cc63@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3642; i=mripard@kernel.org;
 h=from:subject:message-id; bh=k6TwiI8He8GNSiGlGO+CMw9G5rhFmltlagnJGvSCcUw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFdL+Hg13kVz5NLBM7kBwc2/WwgnCVXeu6yerSxQ5i
 uWyJ0V3TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIk8C2KslXC6WBDLoFWiGhpc
 xmdltnR6iXyWs76KklnRw7nLqwru7+dquvWiLdjN/H9IdPPpjRGMDaeZNGMnLnk3RbY8IueGU9Z
 RG27fgFucpXJXvjwpsdx76c2Xx4V3+p/e+ZvjmjjDdZ7THQA=
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
index 48985f0bbbacacf76293f24414470664c74c40ec..82b038285acc245f86573a6a854da37248c92407 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -595,16 +595,16 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
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
@@ -2316,13 +2316,13 @@ static void dispc_k2g_plane_init(struct dispc_device *dispc)
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
@@ -2367,17 +2367,17 @@ static void dispc_k3_plane_init(struct dispc_device *dispc)
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
@@ -2901,11 +2901,11 @@ static int dispc_softreset(struct dispc_device *dispc)
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


