Return-Path: <linux-kernel+bounces-747376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7654B13324
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E372A16BC41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5A1DE4E1;
	Mon, 28 Jul 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PP9rw5aa"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BC26ADD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670851; cv=none; b=pE+Cg+AQYszaOCsHCh1b8niBUEbpghhcboa0zONmkVVuKoNDy8+5igXpJysoiWaxqCUAgh5pgZurpx6GgZLg8HSnZuhmsbvfmSvQwXA0z4vAlzeop0ZDqm6+tJEPBdT5c06ubzlVk04u7b4kgfs6AZq3zqDCeoQi3sVCS7fGLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670851; c=relaxed/simple;
	bh=VqJgTliZmxAdYHO61Cxw60oSaBJN4tNWdscbz/+RuIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMBpp3gjwWlp94BcSHJ6oT8zhvAK1MemdR637jYU1r0n1/bAIJBLzhm9D+hEzjMR32bo2Wu9zdbUrZ2+ZMZaImBVdUdEcWaeNlsCGbhQ3812LGRAwY7r0v68bovxzGiEgEP4U52Y22PZ5cQ5IyYwCQvR0br04a97ex72p+B9lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PP9rw5aa; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2e93ebd86b5d11f0b33aeb1e7f16c2b6-20250728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=J+8jVmLQDoJcDfMjoTHzdrr2Z4GqC6Y4IqQQVKnjdyg=;
	b=PP9rw5aaKbKhLeAGNtiC3kA6iHAdDIgQ5J5luRTiHUyJmZ4cvlTNF0dwux8TIJl01OUp/icQwYjB7S/QJ9fZssZ2ZKT+hPwlcXbbdsPaJ1FJL/DFHpUdkOpdka6h8rLfKRPrmoMZaY+FvTwn0mx424WarrT2zqEe8seI9P2RkAk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:b4ad41a6-f843-42aa-ba96-bcfe84069108,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:4c8ad708-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e93ebd86b5d11f0b33aeb1e7f16c2b6-20250728
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1700403282; Mon, 28 Jul 2025 10:47:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Jul 2025 10:47:17 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Jul 2025 10:47:17 +0800
From: Jason-JH Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, David Airlie <airlied@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>, Jason-JH Lin
	<jason-jh.lin@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Paul-PL Chen <paul-pl.chen@mediatek.com>,
	Yongqiang Niu <yongqiang.niu@mediatek.com>, Zhenxing Qin
	<zhenxing.qin@mediatek.com>, Xiandong Wang <xiandong.wang@mediatek.com>,
	Sirius Wang <sirius.wang@mediatek.com>, Xavier Chang
	<xavier.chang@mediatek.com>, Jarried Lin <jarried.lin@mediatek.com>, Fei Shao
	<fshao@chromium.org>, Chen-yu Tsai <wenst@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH] drm/mediatek: Add error handling for old state CRTC in atomic_disable
Date: Mon, 28 Jul 2025 10:47:02 +0800
Message-ID: <20250728024718.24725-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Introduce error handling to address an issue where, after a hotplug
event, the cursor continues to update. This situation can lead to a
kernel panic due to accessing the NULL `old_state->crtc`.

E,g.
Unable to handle kernel NULL pointer dereference at virtual address
Call trace:
 mtk_crtc_plane_disable+0x24/0x140
 mtk_plane_atomic_update+0x8c/0xa8
 drm_atomic_helper_commit_planes+0x114/0x2c8
 drm_atomic_helper_commit_tail_rpm+0x4c/0x158
 commit_tail+0xa0/0x168
 drm_atomic_helper_commit+0x110/0x120
 drm_atomic_commit+0x8c/0xe0
 drm_atomic_helper_update_plane+0xd4/0x128
 __setplane_atomic+0xcc/0x110
 drm_mode_cursor_common+0x250/0x440
 drm_mode_cursor_ioctl+0x44/0x70
 drm_ioctl+0x264/0x5d8
 __arm64_sys_ioctl+0xd8/0x510
 invoke_syscall+0x6c/0xe0
 do_el0_svc+0x68/0xe8
 el0_svc+0x34/0x60
 el0t_64_sync_handler+0x1c/0xf8
 el0t_64_sync+0x180/0x188

Adding NULL pointer checks to ensure stability by preventing operations
on an invalid CRTC state.

Fixes: d208261e9f7c ("drm/mediatek: Add wait_event_timeout when disabling plane")
Signed-off-by: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index cbc4f37da8ba..02349bd44001 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -292,7 +292,8 @@ static void mtk_plane_atomic_disable(struct drm_plane *plane,
 	wmb(); /* Make sure the above parameter is set before update */
 	mtk_plane_state->pending.dirty = true;
 
-	mtk_crtc_plane_disable(old_state->crtc, plane);
+	if (old_state && old_state->crtc)
+		mtk_crtc_plane_disable(old_state->crtc, plane);
 }
 
 static void mtk_plane_atomic_update(struct drm_plane *plane,
-- 
2.43.0


