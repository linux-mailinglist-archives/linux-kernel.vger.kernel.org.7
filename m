Return-Path: <linux-kernel+bounces-773172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B2B29C54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF001881B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03C275B03;
	Mon, 18 Aug 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pNWqbi9h"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FB19F11F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506072; cv=none; b=k/jQqhj07Er0kxkeA3quNmhUSFscyIIRC568ljhoCigQMfrqXKeek/ChGWtDXh3CRLlge82H6ZF7sXStUBOQxLzVu8qTizaB+sO0Hshr2vO5Iefn536+mLS1G52CxDHv71jspq0+ptnp4lwY1sfgh4Xa7+0mcsFYB8UJMLKf9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506072; c=relaxed/simple;
	bh=+uOz4NcMUj4DgMcB5calNycuKxf3I7WIu/7rLtSibn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zy2hFm1LxusZGMc//nNHURi/PowNNZiLaXe8ai5It+Qi57OvGHBra7QW09pAb6fTfXrrNgcDhl0MZ5rF/xMzDgv9f/nTq9EkrruQsFUyzu8JTN5eCSh0XB5KdAIgGqsEl9FpzcCnYSnGlyGN4++N4sr5FvRPn1lCxSeFBGcGKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pNWqbi9h; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 25fb1dd67c0e11f08729452bf625a8b4-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zTc9ILZszspIergQBlX6+NhSE6Fs5a72JurzfDZwPEA=;
	b=pNWqbi9hwE3wtSc3SdRJp8XlkOHa7gQwFsUKMaMK24pq+FeFGh/MNc8MWkGa0P5Hl3/wo5gGEagm+T+9yqe6t/OIeU2xw6nv5Xs4uIlvY7Qy4STv+09/QchmSLMzFctvMr7w0opM2qAxkBn9+608aKe0aa+gxLYdz6ghiHvL7o8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:f00a5176-b8a2-472c-97b6-40f1fc725fb8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:900b0bf4-66cd-4ff9-9728-6a6f64661009,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 25fb1dd67c0e11f08729452bf625a8b4-20250818
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <payne.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 969138246; Mon, 18 Aug 2025 16:34:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 16:34:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 16:34:24 +0800
From: payne.lin <payne.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno --cc=dri-devel @ lists . freedesktop . org"
	<angelogioacchino.delregno@collabora.com>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Bincai Liu <bincai.liu@mediatek.com>,
	Payne Lin <payne.lin@mediatek.com>
Subject: [PATCH] gpu: drm: mediatek: correct clk setting AUX_RX_UI_CNT_THR_AUX_FOR_26M
Date: Mon, 18 Aug 2025 16:34:03 +0800
Message-ID: <20250818083415.1041187-1-payne.lin@mediatek.com>
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

From: Bincai Liu <bincai.liu@mediatek.com>

Updated the definition of AUX_RX_UI_CNT_THR_AUX_FOR_26M from 13 to 14.
No other code or logic changes were made; only the macro value was modified.
This change affects the timing configuration for AUX RX at 26MHz.
The formula is xtal_clk / 2 + 1.

Signed-off-by: Bincai Liu <bincai.liu@mediatek.com>
Signed-off-by: Payne Lin <payne.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 8ad7a9cc259e..f8c7b3c0935f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -301,7 +301,7 @@
 #define AUX_TIMEOUT_THR_AUX_TX_P0_VAL			0x1595
 #define MTK_DP_AUX_P0_3614			0x3614
 #define AUX_RX_UI_CNT_THR_AUX_TX_P0_MASK		GENMASK(6, 0)
-#define AUX_RX_UI_CNT_THR_AUX_FOR_26M			13
+#define AUX_RX_UI_CNT_THR_AUX_FOR_26M			14
 #define MTK_DP_AUX_P0_3618			0x3618
 #define AUX_RX_FIFO_FULL_AUX_TX_P0_MASK			BIT(9)
 #define AUX_RX_FIFO_WRITE_POINTER_AUX_TX_P0_MASK	GENMASK(3, 0)
-- 
2.45.2


