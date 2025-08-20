Return-Path: <linux-kernel+bounces-777869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F25B2DEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3B23BA7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6B26738B;
	Wed, 20 Aug 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2XvW7LP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73A2E11B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698546; cv=none; b=SVVfnkNqhbPusuUcFQWnIGOI/80mOIHVMEOvcASl6psaIfHMH6JRodwRxv/hWI66cQUSU1AgisDN8gonES3L8TeQDrJ9PnigaxXFQtGTiZJEd8eRDmRx+gTz10U1CiahIhHQK2rgkUsdtquOuabyDBKCKVPrQ3tiuKwOO5cUyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698546; c=relaxed/simple;
	bh=K3NEYHCQpJ1kDmGIWdG9eDLnXkdpgxdjpAhoq0rNdq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kq2mYC58CCbwuw11dqG7cUPPLgX7obcz7rwv3YvQwZizDsA0OcIufkkDKEdbWt/7QQQ+nE21jLBk3yh5n3Yp3q7JoPJYliYjrB/XaMNTxohY9KXwsw2cVdU/8c+ngJ+Cx9bpBXuUYms7yZvH7vkWm5KkjLGlbUPqMgWDssVjdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2XvW7LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82ADC4CEE7;
	Wed, 20 Aug 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698546;
	bh=K3NEYHCQpJ1kDmGIWdG9eDLnXkdpgxdjpAhoq0rNdq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2XvW7LP3E46eF/beH/ZdNih0mOHhbb7/pwUHrv5sN4bb3NaLFefCNQTDnRyr7/ah
	 Mpjr0BCUxkvfCZ1ZQv41BJJ/IqGTQqnv4ZvQyiMA92s6UwwYghQvUpRF6QlU67yZY7
	 5VLY1f9dF5vL5aFdAaJea/7WYr6sVU0xqQ7M9WlZIMxauVRWZkg1CNv5afg/pidRqI
	 K4/41SzVuvxUqSy3x9ZUXQEyf2n9omgvXao5sE3BaF1KffSTZG/GHN3xqQtcSr7T9G
	 WY5ZErRBt1Z5WjUC7oEnFFVO71Hc8OZMXcXyCh5bc/IUFjyPOrrnGwCWojcLbrkDSE
	 gSjLN1N/y2cwg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:49 +0200
Subject: [PATCH v2 09/14] drm/tidss: dispc: Switch VID_REG_GET to using a
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-9-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=mripard@kernel.org;
 h=from:subject:message-id; bh=K3NEYHCQpJ1kDmGIWdG9eDLnXkdpgxdjpAhoq0rNdq4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwZp8FjueuJ54uPav+u7Vi73DpD9ESZmXcoUw/7SI
 Ghhwce1HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiNkKMDTtydMUPx//LdrE1
 0vqpmfukOG5dr5LNpfJNu52fu1z9v9fta2Pfro4Vph0Rkos2VXT/Y2y49OnU74+pL8tKNyi4230
 UkvAyWsbYzRgzrznvqYuRpMcUZseys+7x/Q9z4qbKvlRmfQ4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The VID_REG_GET function takes the start and end bits as parameter and
will generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change VID_REG_GET to take the mask as an argument instead, and
let the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 1b2791e8c04c463552ad370f48dce8eae5b94702..b4928cfbb6f7ca9a03371c5e599e2029baae333f 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -619,13 +619,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 		u32 _reg = dispc_read(_dispc, _idx);			\
 		FIELD_MODIFY((mask), &_reg, (val));			\
 		dispc_write(_dispc, _idx, _reg);			\
 	})
 
-#define VID_REG_GET(dispc, hw_plane, idx, start, end)			\
-	((u32)FIELD_GET(GENMASK((start), (end)),			\
-			dispc_vid_read((dispc), (hw_plane), (idx))))
+#define VID_REG_GET(dispc, hw_plane, idx, mask)				\
+	((u32)FIELD_GET((mask), dispc_vid_read((dispc), (hw_plane), (idx))))
 
 #define VID_REG_FLD_MOD(dispc, hw_plane, idx, val, start, end)		\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _hw_plane = (hw_plane);				\
@@ -2307,11 +2306,12 @@ void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable)
 	VID_REG_FLD_MOD(dispc, hw_plane, DISPC_VID_ATTRIBUTES, !!enable, 0, 0);
 }
 
 static u32 dispc_vid_get_fifo_size(struct dispc_device *dispc, u32 hw_plane)
 {
-	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS, 15, 0);
+	return VID_REG_GET(dispc, hw_plane, DISPC_VID_BUF_SIZE_STATUS,
+			   GENMASK(15, 0));
 }
 
 static void dispc_vid_set_mflag_threshold(struct dispc_device *dispc,
 					  u32 hw_plane, u32 low, u32 high)
 {

-- 
2.50.1


