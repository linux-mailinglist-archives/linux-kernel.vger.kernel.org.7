Return-Path: <linux-kernel+bounces-768826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FDB265F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EE5A0845F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F12EAB9D;
	Thu, 14 Aug 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Dlju0yNn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474124293B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176063; cv=none; b=vFJA5LjDzgbSzsnbxIPbHxI2B/YLpz67vMeFnIk1G0HhLG9Qy9ZSCCXqFjUbVej202XwfvmOiXXKCjymgo+guQghajbniL+bU8r+dsnrnrE2iBIE2G9waznTvqT1gDs4PD9YbJYnsfKP77Llf1KQU15jmJTeqXNTh9/RtqKRMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176063; c=relaxed/simple;
	bh=hW1W8s3mI9SHLEaWa4X+JzWNPumP0o6N8CAOs7cOMZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nS2KdljYf5tPrzKJgZCtruXEcsENSsp65YkjEVkcWQiGyXhKVmzqVl7yzRcvP4BlSWgmg4PMsKTqzIGQVeZvZeO6PSgj0fnjCrexV7EilUsHsUSPMhYZozH9XxitRhJ3G7TDnia7Q9ka4vYvUHvqIlCkxYegJXdZDVXelyDUSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Dlju0yNn; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c7f07cde790d11f08729452bf625a8b4-20250814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=n7PWWA8laLeGGJfV8SSa7UTK6MZ1GNTwaD9bGrWGqKI=;
	b=Dlju0yNnOBJSX4yy6PhQqBwyUioRWTigz4rY++jVqtGiy5l83jCt1bZ3tkqEoEABJ757zh/hkuRL7GG/VrbbVZhpAU6aHF6Avn2D98qENP/9lRc8/PCt1smBCjbeqOgN1xXAVl/CmEUOI2SVcTwQnLuLJYKUC0hNwsdUqSOZg4U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2926b3f2-5224-4cd7-aee3-3b4d388ebcca,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:2992237a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7f07cde790d11f08729452bf625a8b4-20250814
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <payne.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1017753956; Thu, 14 Aug 2025 20:54:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 14 Aug 2025 20:54:12 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 14 Aug 2025 20:54:12 +0800
From: payne.lin <payne.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, Bincai Liu <bincai.liu@mediatek.com>, Payne Lin
	<payne.lin@mediatek.com>
Subject: [PATCH] phy: mediatek: Modify mipi clk upper bound to 2.5Gbps
Date: Thu, 14 Aug 2025 20:54:02 +0800
Message-ID: <20250814125406.4161220-1-payne.lin@mediatek.com>
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

Mipi dphy can support up to 4k30 without dsc.

Signed-off-by: Bincai Liu <bincai.liu@mediatek.com>
Signed-off-by: Payne Lin <payne.lin@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 553725e1269c..b8233c496070 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -100,7 +100,7 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *prate)
 {
-	return clamp_val(rate, 125000000, 1600000000);
+	return clamp_val(rate, 125000000, 2500000000);
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
-- 
2.45.2


