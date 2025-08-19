Return-Path: <linux-kernel+bounces-774734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60CB2B68D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B1E7AF75C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50A1DF246;
	Tue, 19 Aug 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="spkpvnUH"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FE286425;
	Tue, 19 Aug 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568805; cv=none; b=Vb4Sl6f/bAG7WOOT2MmiVcKIErZ5wfA3NzDWauNMtcgtj2nzqZAZxVF9cdPcu51CCe+TLXaGgVLjef5dKSX2WlGkGZkr7n5rMBTkoMn+8UjyU7m1lID99CxNuSk0De6ZGgNGMDjP4X42CbAE4xzqlyWCS8P/LYuRgd5QMOHgh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568805; c=relaxed/simple;
	bh=qLTsS6h523MV2vSgevAyl19O6WTg6ljBE+jNPQcDEJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpeNySBSXerdhuQoT4+sRLlJMJDtVT/3ab31JUQ1BHe/er8aZ32TT8Ow+j+hWhSWAfGATGVQH6E9tpDF5nwMdAEyEkItamAYEl4UXiipyGPklwsSqyb0b76i2uw9On1An00KfMioAci3pYr5t9pCZD0jb7OTaTvwD/UM9yhQDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=spkpvnUH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36374d727ca011f0b33aeb1e7f16c2b6-20250819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rt7a9tFP3NJpqQ87VNq7BzaEeeFPAru3oeg14qBjfDA=;
	b=spkpvnUHaOGPNbTYb0/pxI/5KmUQxZTYN3QJl7V8NqBznXKJ4lNlkewwqs2uSQuDgXoTImNgOWueEEpjutKa/Q9Ew2+qdpJcgeo0uRS2tLjpbQUT+URKZfGRem8uds8dQQPfrnGwjTNVLIHRKwWqzkBH+BG93xFBBdrvftsMd14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:94bdd0a6-47c8-4b08-8e83-40a168e443ac,IP:0,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:100
X-CID-META: VersionHash:f1326cf,CLOUDID:c96f5b6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|801,TC:-5,Content:3|15|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36374d727ca011f0b33aeb1e7f16c2b6-20250819
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 242803445; Tue, 19 Aug 2025 09:59:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 19 Aug 2025 09:59:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 19 Aug 2025 09:59:56 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Houlong Wei
	<houlong.wei@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v2 2/4] mailbox: mtk-cmdq: Add cmdq driver for mt8189
Date: Tue, 19 Aug 2025 09:59:39 +0800
Message-ID: <20250819015948.15450-3-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250819015948.15450-1-xiandong.wang@mediatek.com>
References: <20250819015948.15450-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

add cmdq driver support for mt8189

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 177de5ab0ab2..543cd86b5bb0 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -799,12 +799,22 @@ static const struct gce_plat gce_plat_mt8195 = {
 	.gce_num = 2
 };
 
+static const struct gce_plat gce_plat_mt8189 = {
+	.thread_nr = 32,
+	.shift = 3,
+	.mminfra_offset = 0x40000000, /* 1GB */
+	.control_by_sw = false,
+	.sw_ddr_en = true,
+	.gce_num = 2
+};
+
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_mt6779},
 	{.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_mt8173},
 	{.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_mt8183},
 	{.compatible = "mediatek,mt8186-gce", .data = (void *)&gce_plat_mt8186},
 	{.compatible = "mediatek,mt8188-gce", .data = (void *)&gce_plat_mt8188},
+	{.compatible = "mediatek,mt8189-gce", .data = (void *)&gce_plat_mt8189},
 	{.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_mt8192},
 	{.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_mt8195},
 	{}
-- 
2.46.0


