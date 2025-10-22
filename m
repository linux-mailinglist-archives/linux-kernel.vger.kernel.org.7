Return-Path: <linux-kernel+bounces-865601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED89BFD864
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C13B1A00C43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2D274B55;
	Wed, 22 Oct 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nfh8zFc2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DA23313E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153542; cv=none; b=KsTCldIHm1JwD/vj0P5rmz3j3WR5fMfXIJ2OvwrTTdydIMtQmspqgvY98++imO4lWnCI2/Kpmwn9+cBoiee1OldxoFQglrxHcMrvQ8yhwm+epf2g2zqstpkJ9DGuuruJX1tOow3pKYkZAf2SODTBQ+1iIFiDwiiLNmdVbMmgZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153542; c=relaxed/simple;
	bh=TY0uuAVGd/+F7azSrSzdgWuu3qWmPzr328QCE8H0ATM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fhu0QOsnh3VHLGLqr7x6cZm4XzvwIidwhjOUEehjUU0qsZZfqTWQS+cCrIGfxB5NgQ84vRb7LpGMhHg18lxvGcLA3DBAZ4eToNfedIvE/IhH5SPfYY1H75CsP4Un7tjKXYpL3ZECGUKToBg2xHt9faIq+/8LdTI0SorQQ1JplEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Nfh8zFc2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2dfe0dc8af6b11f0b33aeb1e7f16c2b6-20251023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EPP4wVPPUF3TysxbibtNWe6M149EJZiCu2ZRsWc1mP4=;
	b=Nfh8zFc29EJs6brAz5eNpWYsA9IHceeADS1ktIV5gsjhqbPX07AXcxdorqZubGMe0nJiSe5VFpksbxVjXjYD0OTOWT35+eIjEdyFZ4aeu9CejAB33bdHyKvg6AQywFZ01HTxGSzsg7qGvz53sve4vKZTvHFTPH0WDnA0ill2z/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:21c61238-6837-4bec-b1e2-fbae21693847,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:44f23384-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2dfe0dc8af6b11f0b33aeb1e7f16c2b6-20251023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1754218862; Thu, 23 Oct 2025 01:18:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 23 Oct 2025 01:18:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 23 Oct 2025 01:18:49 +0800
From: Jason-JH Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Jason-JH Lin
	<jason-jh.lin@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Paul-PL Chen <paul-pl.chen@mediatek.com>, Moudy
 Ho <moudy.ho@mediatek.com>, Xiandong Wang <xiandong.wang@mediatek.com>,
	Sirius Wang <sirius.wang@mediatek.com>, Fei Shao <fshao@chromium.org>,
	Chen-yu Tsai <wenst@chromium.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH] mailbox: mtk-cmdq: Refine DMA address handling for the command buffer
Date: Thu, 23 Oct 2025 01:16:30 +0800
Message-ID: <20251022171847.379470-1-jason-jh.lin@mediatek.com>
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

GCE can only fetch the command buffer address from a 32-bit register.
Some SoCs support a 35-bit command buffer address for GCE, which
requires a right shift of 3 bits before setting the address into
the 32-bit register. A comment has been added to the header of
cmdq_get_shift_pa() to explain this requirement.

To prevent the GCE command buffer address from being DMA mapped beyond
its supported bit range, the DMA bit mask for the device is set during
initialization.

Additionally, to ensure the correct shift is applied when setting or
reading the register that stores the GCE command buffer address,
new APIs, cmdq_convert_gce_addr() and cmdq_revert_gce_addr(), have
been introduced for consistent operations on this register.

The variable type for the command buffer address has been standardized
to dma_addr_t to prevent handling issues caused by type mismatches.

Fixes: 0858fde496f8 ("mailbox: cmdq: variablize address shift in platform")
Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This patch is separated from series[1] because it is a fixes patch and
it needs to be landed first.

[1] Add GCE support for MT8196
- https://lore.kernel.org/all/20251017065028.1676930-1-jason-jh.lin@mediatek.com
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 45 ++++++++++++++++--------
 include/linux/mailbox/mtk-cmdq-mailbox.h | 10 ++++++
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 654a60f63756..5791f80f995a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -92,6 +92,18 @@ struct gce_plat {
 	u32 gce_num;
 };
 
+static inline u32 cmdq_convert_gce_addr(dma_addr_t addr, const struct gce_plat *pdata)
+{
+	/* Convert DMA addr (PA or IOVA) to GCE readable addr */
+	return addr >> pdata->shift;
+}
+
+static inline dma_addr_t cmdq_revert_gce_addr(u32 addr, const struct gce_plat *pdata)
+{
+	/* Revert GCE readable addr to DMA addr (PA or IOVA) */
+	return (dma_addr_t)addr << pdata->shift;
+}
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -188,13 +200,12 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
 	struct cmdq_task *prev_task = list_last_entry(
 			&thread->task_busy_list, typeof(*task), list_entry);
 	u64 *prev_task_base = prev_task->pkt->va_base;
+	u32 gce_addr = cmdq_convert_gce_addr(task->pa_base, task->cmdq->pdata);
 
 	/* let previous task jump to this task */
 	dma_sync_single_for_cpu(dev, prev_task->pa_base,
 				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
-	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
-		(u64)CMDQ_JUMP_BY_PA << 32 |
-		(task->pa_base >> task->cmdq->pdata->shift);
+	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] = (u64)CMDQ_JUMP_BY_PA << 32 | gce_addr;
 	dma_sync_single_for_device(dev, prev_task->pa_base,
 				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
 
@@ -237,7 +248,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 				    struct cmdq_thread *thread)
 {
 	struct cmdq_task *task, *tmp, *curr_task = NULL;
-	u32 curr_pa, irq_flag, task_end_pa;
+	u32 irq_flag, gce_addr;
+	dma_addr_t curr_pa, task_end_pa;
 	bool err;
 
 	irq_flag = readl(thread->base + CMDQ_THR_IRQ_STATUS);
@@ -259,7 +271,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 	else
 		return;
 
-	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
+	gce_addr = readl(thread->base + CMDQ_THR_CURR_ADDR);
+	curr_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
@@ -378,7 +391,8 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
-	unsigned long curr_pa, end_pa;
+	u32 gce_addr;
+	dma_addr_t curr_pa, end_pa;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
@@ -402,20 +416,20 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 		 */
 		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
 
-		writel(task->pa_base >> cmdq->pdata->shift,
-		       thread->base + CMDQ_THR_CURR_ADDR);
-		writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->pdata->shift,
-		       thread->base + CMDQ_THR_END_ADDR);
+		gce_addr = cmdq_convert_gce_addr(task->pa_base, cmdq->pdata);
+		writel(gce_addr, thread->base + CMDQ_THR_CURR_ADDR);
+		gce_addr = cmdq_convert_gce_addr(task->pa_base + pkt->cmd_buf_size, cmdq->pdata);
+		writel(gce_addr, thread->base + CMDQ_THR_END_ADDR);
 
 		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
 		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
 		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
 	} else {
 		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
-		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) <<
-			cmdq->pdata->shift;
-		end_pa = readl(thread->base + CMDQ_THR_END_ADDR) <<
-			cmdq->pdata->shift;
+		gce_addr = readl(thread->base + CMDQ_THR_CURR_ADDR);
+		curr_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
+		gce_addr = readl(thread->base + CMDQ_THR_END_ADDR);
+		end_pa = cmdq_revert_gce_addr(gce_addr, cmdq->pdata);
 		/* check boundary */
 		if (curr_pa == end_pa - CMDQ_INST_SIZE ||
 		    curr_pa == end_pa) {
@@ -646,6 +660,9 @@ static int cmdq_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	dma_set_coherent_mask(dev,
+			      DMA_BIT_MASK(sizeof(u32) * BITS_PER_BYTE + cmdq->pdata->shift));
+
 	cmdq->mbox.dev = dev;
 	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->pdata->thread_nr,
 					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 4c1a91b07de3..e1555e06e7e5 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -77,6 +77,16 @@ struct cmdq_pkt {
 	size_t			buf_size; /* real buffer size */
 };
 
+/**
+ * cmdq_get_shift_pa() - get the shift bits of physical address
+ * @chan: mailbox channel
+ *
+ * GCE can only fetch the command buffer address from a 32-bit register.
+ * Some SOCs support more than 32-bit command buffer address for GCE, which
+ * requires some shift bits to make the address fit into the 32-bit register.
+ *
+ * Return: the shift bits of physical address
+ */
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
 
 #endif /* __MTK_CMDQ_MAILBOX_H__ */
-- 
2.43.0


