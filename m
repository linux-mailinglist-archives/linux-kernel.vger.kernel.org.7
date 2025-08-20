Return-Path: <linux-kernel+bounces-777397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550AB2D8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868655C4D67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376A2E613B;
	Wed, 20 Aug 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G7tU03cB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C72DCC05;
	Wed, 20 Aug 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682726; cv=none; b=ccG9j5eVcxm14HULbY8SUJcwXL9IW2+YRAFUl+hFgWYMGGB43MnyD9GKUnUULMTcXVYIJTS9x6cXT2m3VIRd95MTk/hmFNOF3B0K764tjYZuQkti4Ob4eEy+V8+b5Rwk4H9lGBre7ayiEIG/0HtuIjfmpINcEytLxbF1QwpEe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682726; c=relaxed/simple;
	bh=i2RS9ufnn3gc7ItTemTi/RCxCeB/pqw9n7JsnJJ+DuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTvRRuRVmx7YLC3/lg5XkUKkaF4eLiRRNjCmo0rn4WU7voU/8f6lW/DJDaUxT7cFW6xOhU1YK1/KHM/a2lZCkHzL0LkKMcvtLJf3dhkKYnqXygJp+/RHJoiLVRUoJ6odlhoiZSVKDOJcdPWKaxtc6/LxnAuzTvml/WOvIV1JFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G7tU03cB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7407a4447da911f08729452bf625a8b4-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xkR4rONaXtekytURydVCH77DowLYp9V+d3cs5YgAAAU=;
	b=G7tU03cBBKnrvyMDfO9Gjwbumfh66GXPMGfXk4ZUw9TIDFd7fvXJ/nF3eRemD2hr35A/cCnhVB0Z8nyPG2Q5/MDoCLWtJLbnfpDGALyt85/27azc1uNeNWKxKYYivmNFykG6d4H8AnNHuVESxW5ZQf5s9BBKwWwqLZYlbXqfgpk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:16c76fbe-c493-42f0-a8cd-197549ee2e29,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:049b6a6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7407a4447da911f08729452bf625a8b4-20250820
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2090453162; Wed, 20 Aug 2025 17:38:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 17:38:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 17:38:36 +0800
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
Subject: [PATCH v4 4/4] mailbox: mtk-cmdq: Fix clock handling using clk_bulk_prepare_enable
Date: Wed, 20 Aug 2025 17:38:23 +0800
Message-ID: <20250820093831.23437-5-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250820093831.23437-1-xiandong.wang@mediatek.com>
References: <20250820093831.23437-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On MT8189, the GCE clock is mounted on the MMInfra clock, so it is
necessary to enable or disable the parent clock before handling  the GCE
clock to ensure correct switching for GCE usage.

Replace clk_bulk_enable and clk_bulk_disable with
clk_bulk_prepare_enable and clk_bulk_disable_unprepare in  suspend and
resume, so both the module clock and its parent clock can be enabled or
disabled properly.

This change modifies the clock API used for suspend and resume
to ensure correct module and parent clock handling on MT8189.

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 54d008ebdf33..98c9742ea6f4 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -211,7 +211,7 @@ static void cmdq_init(struct cmdq *cmdq)
 {
 	int i;
 
-	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
+	WARN_ON(clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->clocks));
 
 	cmdq_vm_toggle(cmdq, true);
 	cmdq_gctl_value_toggle(cmdq, true);
@@ -219,7 +219,7 @@ static void cmdq_init(struct cmdq *cmdq)
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
 		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 }
 
 static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
@@ -383,7 +383,7 @@ static int cmdq_runtime_resume(struct device *dev)
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	ret = clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->clocks);
 	if (ret)
 		return ret;
 
@@ -398,7 +398,7 @@ static int cmdq_runtime_suspend(struct device *dev)
 
 	cmdq_gctl_value_toggle(cmdq, false);
 	cmdq_vm_toggle(cmdq, false);
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->clocks);
 	return 0;
 }
 
@@ -437,12 +437,8 @@ static int cmdq_resume(struct device *dev)
 
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
@@ -761,8 +757,6 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cmdq);
 
-	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
-
 	cmdq_init(cmdq);
 
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-- 
2.46.0


