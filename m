Return-Path: <linux-kernel+bounces-774806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798DB2B7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48E6561995
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015D2F39AD;
	Tue, 19 Aug 2025 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k47Ps8Sb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190212E22AA;
	Tue, 19 Aug 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574697; cv=none; b=ekdC6gXed/t68J91ElmueV2/MITLSM5zb7cxJhCUi8ypaRU80xiDa/xNrw9Ty32QBuUnjUvguVNOQmHuQWBDGrFGS96N1OrqT90Tp5+JPylPbKf70AIYEyzElHIkVdSCwq8z1TQzlY3FDt0611N/2GeJGY7xTEpXlDXy2bEQGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574697; c=relaxed/simple;
	bh=qSFieO8Cel9KlPL3NAoUBzU1UL6uW8E4kaBvUL8HCj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMuefbHN8J6pJi+ImeGWmDNAEq0YxZKGUImmk0cup+YhDm45XBrFI14T+h31inXP+jjTKRtA4KQ3+MPIU1w8nOe6s7PQP8u8zfN1CZaBuBX657BWDngrWTq4GP/BGcjifDSaKi9wIFCiS5iwgYSQvcGonTuL3xa3Sn5BwgQe8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k47Ps8Sb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecdc21e47cad11f0b33aeb1e7f16c2b6-20250819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zTwFQbiahKuVur4FiMdEux7IBBiZSXrfDzUUPEN8Sro=;
	b=k47Ps8SbUks5DoAPr8uKzLlgk6o5y9UPXyIZsz1TxOd03whVaI083XK/mPS3r3n+GTSvsxV5yf6AStr8XWRwzmvm5aUKIEp9eBn+6kdOSf8MFSfMhEXJItVNok6aTjOSCUYo5zxc7/AS/k1DemWdHbsWzNPtsxZ9/pXVYqfVqI4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:8b122c16-2f83-4427-a8b6-0b86b33a4200,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b49f5c6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ecdc21e47cad11f0b33aeb1e7f16c2b6-20250819
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1680763906; Tue, 19 Aug 2025 11:38:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 19 Aug 2025 11:38:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 19 Aug 2025 11:38:06 +0800
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
Subject: [PATCH v3 4/4] mailbox: mtk-cmdq: modify clk api for suspend/resume
Date: Tue, 19 Aug 2025 11:36:11 +0800
Message-ID: <20250819033746.16405-5-xiandong.wang@mediatek.com>
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

Since it is necessary to use clk_bulk_prepare_enable
and clk_bulk_disable_unprepare instead of clk_bulk
enable and clk_bulk_disable because, on 8189, the
gce clk is mounted on the mminfra clk. When disabling
and enabling, the parent clk must be enabled and
disabled first to correctly switch the clk for gce usage.
Modify the clk api for suspend and resume, modify the api for
suspend and resume to disable/enable clk, so it can disable/enable
module clk and parent clk successfully.

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 543cd86b5bb0..590f0f6e51b0 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -161,14 +161,14 @@ static void cmdq_init(struct cmdq *cmdq)
 {
 	int i;
 
-	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
+	WARN_ON(clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->clocks));
 
 	cmdq_gctl_value_toggle(cmdq, true);
 
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
 		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 }
 
 static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -332,7 +332,7 @@ static int cmdq_runtime_resume(struct device *dev)
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	ret = clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->clocks);
 	if (ret)
 		return ret;
 
@@ -345,7 +345,7 @@ static int cmdq_runtime_suspend(struct device *dev)
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 
 	cmdq_gctl_value_toggle(cmdq, false);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 	return 0;
 }
 
@@ -384,12 +384,8 @@ static int cmdq_resume(struct device *dev)
 
 static void cmdq_remove(struct platform_device *pdev)
 {
-	struct cmdq *cmdq = platform_get_drvdata(pdev);
-
 	if (!IS_ENABLED(CONFIG_PM))
 		cmdq_runtime_suspend(&pdev->dev);
-
-	clk_bulk_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 }
 
 static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
@@ -708,8 +704,6 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cmdq);
 
-	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
-
 	cmdq_init(cmdq);
 
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-- 
2.46.0


