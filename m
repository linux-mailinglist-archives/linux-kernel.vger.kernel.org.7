Return-Path: <linux-kernel+bounces-777867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68CB2DEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9D626302
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C2276024;
	Wed, 20 Aug 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyDTCNW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E0275AE6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698541; cv=none; b=MmUoUIvTOt9BqfPsfGWEDGLLpp2G8p3AuXXRaSnQM3L3PPwqsIYaLzrmN/jw5B+yNH6FuEuOQOoMAvILXy1F1pYaHmLxFkcMckcsMCvxgCOcpQvOKqeWTaJl+M4yyENxvlomtVX5IfCXqIT9QjU3dwB7U3PLoUJwbIoXHrZ8U4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698541; c=relaxed/simple;
	bh=NPKE0HzA70wlsc3DhdEGt6RObPp32ugchgS24Nhjfqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNGCJh4/cWKw3ftkiGhVOZ5AoUg51WJmF49Eb+evOuTtBOw7Vpu3RuJ7cAwGCCWzWYwAd/gBSAF3A2spnpd6JnJA6imhafS1IYRM9U6YOE2Pvdg1jg55CNzDHpmDE/hHfqUNt6tQb1qitnxV1ejBeK42NAEh7YBJJBhOzIAvAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyDTCNW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6F7C4CEE7;
	Wed, 20 Aug 2025 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698540;
	bh=NPKE0HzA70wlsc3DhdEGt6RObPp32ugchgS24Nhjfqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eyDTCNW1qws1n3jaCS7qXvN4ke3vb7HK6sJyxhs7xW2YIDg4upsMipqf4chm0zGC8
	 fjy59+HFTOhk9mfbrdLqDa6NMOsIspgScpx+oDlxvpP8AT1nSkuUuSUyj7ZGKDAxHQ
	 LFCcGyyDQkGJR2pV1pSTxG37TTxj0nw4Vtyl5wZfL667ol1iyaZ20Ahg3SIQHabEdo
	 JGdH6MtpTmEHxIhGnSM7Hehvq2qHWD97X7WG7LlLBactyQtXMqPXBGrBc9fufzVSzV
	 i84x/KhrtxHq6qrEGy97W2Caikh8sYmobzFyeMAd+eC+JfNvY5ESiOEyjW07QT60na
	 Zf2Q09vCb86yQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:47 +0200
Subject: [PATCH v2 07/14] drm/tidss: dispc: Switch REG_GET to using a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-7-43cab671c648@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NPKE0HzA70wlsc3DhdEGt6RObPp32ugchgS24Nhjfqc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLrwZ9C2JYHPY2SiZeuyJx3fGWg8H1ui8zHY5ceX9NR
 mVRfK9vx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIbC/Geu8PJ7331OYxNyq8
 eZnO+W6qy67Ln0ssyhh09S+civGcW6O/KthwQtqzw1ZMewQDi2UfMDYc3HX07xUBgfWuXW+6pmn
 cckpnMGz9fGb9t+2zp8U/3qtfta9gcenu3m670kpJR+WCBVcB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The REG_GET function takes the start and end bits as parameter and will
generate a mask out of them.

This makes it difficult to share the masks between callers, since we now
need two arguments and to keep them consistent.

Let's change REG_GET to take the mask as an argument instead, and let
the caller create the mask. Eventually, this mask will be moved to a
define.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index fef56aed3f6edb6630d079f354821ada5fad327d..807ab0e0afc7f95efe55764dcb08da695fb85963 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,13 +607,12 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-#define REG_GET(dispc, idx, start, end)					\
-	((u32)FIELD_GET(GENMASK((start), (end)),			\
-			dispc_read((dispc), (idx))))
+#define REG_GET(dispc, idx, mask)					\
+	((u32)FIELD_GET((mask), dispc_read((dispc), (idx))))
 
 #define REG_FLD_MOD(dispc, idx, val, start, end)			\
 	({								\
 		struct dispc_device *_dispc = (dispc);			\
 		u32 _idx = (idx);					\
@@ -2807,30 +2806,30 @@ int dispc_runtime_resume(struct dispc_device *dispc)
 {
 	dev_dbg(dispc->dev, "resume\n");
 
 	clk_prepare_enable(dispc->fclk);
 
-	if (REG_GET(dispc, DSS_SYSSTATUS, 0, 0) == 0)
+	if (REG_GET(dispc, DSS_SYSSTATUS, GENMASK(0, 0)) == 0)
 		dev_warn(dispc->dev, "DSS FUNC RESET not done!\n");
 
 	dev_dbg(dispc->dev, "OMAP DSS7 rev 0x%x\n",
 		dispc_read(dispc, DSS_REVISION));
 
 	dev_dbg(dispc->dev, "VP RESETDONE %d,%d,%d\n",
-		REG_GET(dispc, DSS_SYSSTATUS, 1, 1),
-		REG_GET(dispc, DSS_SYSSTATUS, 2, 2),
-		REG_GET(dispc, DSS_SYSSTATUS, 3, 3));
+		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(1, 1)),
+		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(2, 2)),
+		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(3, 3)));
 
 	if (dispc->feat->subrev == DISPC_AM625 ||
 	    dispc->feat->subrev == DISPC_AM65X)
 		dev_dbg(dispc->dev, "OLDI RESETDONE %d,%d,%d\n",
-			REG_GET(dispc, DSS_SYSSTATUS, 5, 5),
-			REG_GET(dispc, DSS_SYSSTATUS, 6, 6),
-			REG_GET(dispc, DSS_SYSSTATUS, 7, 7));
+			REG_GET(dispc, DSS_SYSSTATUS, GENMASK(5, 5)),
+			REG_GET(dispc, DSS_SYSSTATUS, GENMASK(6, 6)),
+			REG_GET(dispc, DSS_SYSSTATUS, GENMASK(7, 7)));
 
 	dev_dbg(dispc->dev, "DISPC IDLE %d\n",
-		REG_GET(dispc, DSS_SYSSTATUS, 9, 9));
+		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(9, 9)));
 
 	dispc_initial_config(dispc);
 
 	dispc->is_enabled = true;
 

-- 
2.50.1


