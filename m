Return-Path: <linux-kernel+bounces-774805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F505B2B7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409A8189EC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5132E2294;
	Tue, 19 Aug 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OvJgfNkU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CA2D7813;
	Tue, 19 Aug 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574693; cv=none; b=p504QKH2bP/GL3CLA4rF8KiIYaXboXuZFtPwAQojShEobf/+0w6nLenjPaAYcOmvBVrgEpKnhbmAoHxjHgA2IPXXzHR4wcaRxUbn3AMVICMIHQaILAy7NwYzUJkowxf6sJYiao2C5nliPGyRLBz+4WxfJOCQNwiyXff9p6MArXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574693; c=relaxed/simple;
	bh=T3oq3JeIZ3amy/rStJjvBu712DnjHsNWc0nb2akS8tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fob4YInzUhMN+phC3Sd7hSM4+k2y8G6J5Kdy0oaq2GV2fH0dfSvQVS92r/qqSMWvu5SY9R4Z4WvJwCfkKEik7L3R2mLYpn1a69esZVQ0nu59QkDYnjBPK7DORbU7uz6A/s4C6bREmNUIR0sYnAaR0jMmCTmhEVJPifJ0PhYMZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OvJgfNkU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ebd3fdbc7cad11f08729452bf625a8b4-20250819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vIWuG+WVJjNc2hcfx1hLo1CL1sEhZVXu1kn1PQUdOog=;
	b=OvJgfNkUw21g49uXU11j9E2EyeYsOpR6J6kpiQYfPstcisqXEe0QbL1dtWkWFh8eo+ZbQzLHzubYyDG2yWOOTZVOPRMHAqCTvcKll6I4AMmwpPbktYXwxIiMXYwzk70tavtIcdRcC+659oVsw5SYNFtmqfrdzcFUjS3N/zpDk0g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:638dcbbc-7136-4502-80ee-829be593f7c2,IP:0,UR
	L:0,TC:0,Content:58,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:58
X-CID-META: VersionHash:f1326cf,CLOUDID:8f6212f4-66cd-4ff9-9728-6a6f64661009,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|801,TC:-5,Content:3|15|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ebd3fdbc7cad11f08729452bf625a8b4-20250819
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 406041947; Tue, 19 Aug 2025 11:38:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 19 Aug 2025 11:38:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 19 Aug 2025 11:38:04 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v3 3/4] mailbox: mtk-cmdq: Add cmdq driver for mt8189
Date: Tue, 19 Aug 2025 11:36:10 +0800
Message-ID: <20250819033746.16405-4-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250819033746.16405-1-xiandong.wang@mediatek.com>
References: <20250819033746.16405-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add GCE platform data for MediaTek MT8189 to cmdq driver,
enabling support for MT8189 SoC by register MT8189 platform
data in gce_plat and device table.

These changes ensure correct GCE operation for MT8189.

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


