Return-Path: <linux-kernel+bounces-789488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF26B3964A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B99E1BA8302
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781E2DC323;
	Thu, 28 Aug 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AFzNDAA8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2727A916;
	Thu, 28 Aug 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368555; cv=none; b=ZQMFmn8YG79XrNiLMea3EzHWNCoU1I/K5YCo/LQ5CLoe0LOm6pF8dMhu1gfam6r0Asv2D8f6hbToYbO5QL1wISlm6V39eE4t4G19YmiNpLTgrNhINn6KXmocsEP2zmzJ6q5BHBUFENz4UkpajXvTfupy7zevzSjwR6Mzd538new=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368555; c=relaxed/simple;
	bh=r93jJ4Nk+GcP6BPSqhSB2EqE0JyFMTDCGyyY8CerG1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THGVCP55+CPef4+eyIETtLy2Y2nmkYlaobOjRvA4mdQDAbYPxP3REOBVTG67eLb3MHn5bUCPz0dN1n4gowV7NXLTZwB+Z+OGVRnVLdOvesfc3WwQDuOUEd5rQ0cXqT5E7V2fR1ERK7qBdw7/nlHGXgkBAwsP/7zvcz+maDhYQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AFzNDAA8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43f456a683e611f0b33aeb1e7f16c2b6-20250828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iBmqpY6tE/5ikFaZx5+coINmSyxtZJXaiouD5K2cw+s=;
	b=AFzNDAA8wnIggMn7Z0yb6gEwKSj8AjD5B1L6BxP2pwzJSxLmnHbJLBCa0OUfpJX0lwJLrnVph+zXXHrG2ninDI4t94zt7NdUVIXorklvJn9ND8QUSianeuh5bWw9kZxg2Q+YbTGOmakHImZKF100pESimme0rTtqCGwJRK1uOcE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2902f031-5cb0-4a5e-abbb-c20015c71009,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:1e1bf544-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 43f456a683e611f0b33aeb1e7f16c2b6-20250828
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 649653423; Thu, 28 Aug 2025 16:09:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 28 Aug 2025 16:09:04 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 28 Aug 2025 16:09:04 +0800
From: Paul Chen <paul-pl.chen@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chunkuang.hu@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC: <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
	<jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
	<singo.chang@mediatek.com>, <xiandong.wang@mediatek.com>,
	<sirius.wang@mediatek.com>, <paul-pl.chen@mediatek.com>,
	<sunny.shen@mediatek.com>, <fshao@chromium.org>, <treapking@chromium.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 08/19] soc: mediatek: mutex: Reused the switch case for SOF ID
Date: Thu, 28 Aug 2025 16:07:03 +0800
Message-ID: <20250828080855.3502514-9-paul-pl.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul-pl Chen <paul-pl.chen@mediatek.com>

Reused the switch case for SOF IDs.

Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 115 ++++++++++++++++---------------
 1 file changed, 60 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 38179e8cd98f..1e5df5aa0bd5 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -887,53 +887,61 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_unprepare);
 
-void mtk_mutex_add_comp(struct mtk_mutex *mutex,
-			enum mtk_ddp_comp_id id)
+static int mtk_mutex_get_output_comp_sof(enum mtk_ddp_comp_id id)
 {
-	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
-						 mutex[mutex->id]);
-	unsigned int reg;
-	unsigned int sof_id, mod_id;
-	unsigned int offset;
-
-	WARN_ON(&mtx->mutex[mutex->id] != mutex);
-
 	switch (id) {
 	case DDP_COMPONENT_DSI0:
-		sof_id = MUTEX_SOF_DSI0;
-		break;
+		return MUTEX_SOF_DSI0;
 	case DDP_COMPONENT_DSI1:
-		sof_id = MUTEX_SOF_DSI0;
-		break;
+		return MUTEX_SOF_DSI1;
 	case DDP_COMPONENT_DSI2:
-		sof_id = MUTEX_SOF_DSI2;
-		break;
+		return MUTEX_SOF_DSI2;
 	case DDP_COMPONENT_DSI3:
-		sof_id = MUTEX_SOF_DSI3;
-		break;
+		return MUTEX_SOF_DSI3;
 	case DDP_COMPONENT_DPI0:
-		sof_id = MUTEX_SOF_DPI0;
-		break;
+		return MUTEX_SOF_DPI0;
 	case DDP_COMPONENT_DPI1:
-		sof_id = MUTEX_SOF_DPI1;
-		break;
+		return MUTEX_SOF_DPI1;
 	case DDP_COMPONENT_DP_INTF0:
-		sof_id = MUTEX_SOF_DP_INTF0;
-		break;
+		return MUTEX_SOF_DP_INTF0;
 	case DDP_COMPONENT_DP_INTF1:
-		sof_id = MUTEX_SOF_DP_INTF1;
-		break;
+		return MUTEX_SOF_DP_INTF1;
 	default:
-		offset = DISP_REG_MUTEX_MOD(mtx, mtx->data->mutex_mod[id], mutex->id);
-		mod_id = mtx->data->mutex_mod[id] % 32;
-		reg = readl_relaxed(mtx->regs + offset);
-		reg |= BIT(mod_id);
-		writel_relaxed(reg, mtx->regs + offset);
+		break;
+	}
+
+	return -EINVAL;
+}
+
+void mtk_mutex_add_comp(struct mtk_mutex *mutex,
+			enum mtk_ddp_comp_id id)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int reg;
+	unsigned int sof_id, mod_id;
+	unsigned int offset;
+	int sof_id = mtk_mutex_get_output_comp_sof(id);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (sof_id < 0) {
+		if (mtx->data->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
+						    mutex->id);
+			reg = readl_relaxed(mtx->regs + offset);
+			reg |= 1 << mtx->data->mutex_mod[id];
+			writel_relaxed(reg, mtx->regs + offset);
+		} else {
+			offset = DISP_REG_MUTEX_MOD2(mutex->id);
+			reg = readl_relaxed(mtx->regs + offset);
+			reg |= 1 << (mtx->data->mutex_mod[id] - 32);
+			writel_relaxed(reg, mtx->regs + offset);
+		}
 		return;
 	}
 
-	writel_relaxed(mtx->data->mutex_sof[sof_id],
-		       mtx->regs +
+	writel_relaxed(mtx->data->mutex_sof[sof_id], mtx->regs +
 		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id));
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
@@ -946,31 +954,28 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 	unsigned int reg;
 	unsigned int mod_id;
 	unsigned int offset;
-
+	int sof_id = mtk_mutex_get_output_comp_sof(id);
 	WARN_ON(&mtx->mutex[mutex->id] != mutex);
 
-	switch (id) {
-	case DDP_COMPONENT_DSI0:
-	case DDP_COMPONENT_DSI1:
-	case DDP_COMPONENT_DSI2:
-	case DDP_COMPONENT_DSI3:
-	case DDP_COMPONENT_DPI0:
-	case DDP_COMPONENT_DPI1:
-	case DDP_COMPONENT_DP_INTF0:
-	case DDP_COMPONENT_DP_INTF1:
-		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
-			       mtx->regs +
-			       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg,
-						  mutex->id));
-		break;
-	default:
-		offset = DISP_REG_MUTEX_MOD(mtx, mtx->data->mutex_mod[id], mutex->id);
-		mod_id = mtx->data->mutex_mod[id] % 32;
-		reg = readl_relaxed(mtx->regs + offset);
-		reg &= ~BIT(mod_id);
-		writel_relaxed(reg, mtx->regs + offset);
-		break;
+	if (sof_id < 0) {
+		if (mtx->data->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
+						    mutex->id);
+			reg = readl_relaxed(mtx->regs + offset);
+			reg &= ~(1 << mtx->data->mutex_mod[id]);
+			writel_relaxed(reg, mtx->regs + offset);
+		} else {
+			offset = DISP_REG_MUTEX_MOD2(mutex->id);
+			reg = readl_relaxed(mtx->regs + offset);
+			reg &= ~(1 << (mtx->data->mutex_mod[id] - 32));
+			writel_relaxed(reg, mtx->regs + offset);
+		}
+		return;
 	}
+
+	writel_relaxed(MUTEX_SOF_SINGLE_MODE,
+		       mtx->regs + DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg,
+		       mutex->id));
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
 
-- 
2.45.2


