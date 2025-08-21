Return-Path: <linux-kernel+bounces-779792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF90B2F8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A13AC73B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374432277F;
	Thu, 21 Aug 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkw0uhHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB88321F2D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780517; cv=none; b=hkmj7MfLaKxhtL2UvdTxcFXFVfKvthmhn9kXskB+Ntt5qdc+BwPnSomVk2wXxrnk1dZo+WeG+oYGV6bVzpVTgA2hHT9P4h014jbE5ediLtqXZxJsABHcNM83c28myeJjamMOpXtyWO/aCk34Zya5oPi7QYce1xVVBUgt1oDeTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780517; c=relaxed/simple;
	bh=ywe9PAENkpsG/lb1PRHlt2Cm4TQuC7VjkL3tA0Q+BfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZlYAJcfRgMHyQV6Kyl+G6SQnOSu7XG5GeMsGxAGh+okpisLXB1EB7dLc+BwUIkCS/05GS5jJvJY0Qd+8cyJWTGgkIk1mFbU3kMkuudcJvOZZooLpDzLE/p2+UvQaQmsDaOswYhZLPPDVK28caMRzJo2wVM4CyE6njFg9U3St4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkw0uhHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA54C113CF;
	Thu, 21 Aug 2025 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755780516;
	bh=ywe9PAENkpsG/lb1PRHlt2Cm4TQuC7VjkL3tA0Q+BfU=;
	h=From:Date:Subject:To:Cc:From;
	b=lkw0uhHKH0DjxChL+3RoH8cCefgGS6+l8W1Pe984+gry1NdW1oKyOhScOvo+5OHwQ
	 nUK4vlAIFwJLMVg8UHnedNY4HRPtV2+cImTiQuvb9rUsF7x6QOthr7EYS2hCfVZg75
	 zCANODihUp3XHptyrbS+b5RTuBhOO8XrZ4+7DNg2dqkGtPcPuGCLbFOc74qdpLNvQB
	 0sLgvmw50ULi9H8/SzDqcKRBOB46+aFoT5CGGcGwQ17ChQMEhBNVoAazB71YJ+1bI0
	 ZZzvbFEADC7K4tWIjMaw6iU/7kUl5gOv3QxrqoXCeNCUd3/fV06OltFtdJjhPlkpxV
	 BjHTSLCFg4Gig==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 21 Aug 2025 14:48:32 +0200
Subject: [PATCH] nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ8Vp2gC/x2MQQqAIBAAvyJ7bkGlQPtKdBBbaw9ZaEgg/j3pO
 AwzFTIlpgyzqJCocOYrdlCDAH+4uBPy1hm01JM0WmHgF2M56cHgUblgjbVq1CZAT+5E3f+7ZW3
 tA2zG5cheAAAA
X-Change-ID: 20250821-fix-nvmet-fc-1af98991428f
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

It’s possible for more than one async command to be in flight from
__nvmet_fc_send_ls_req. For each command, a tgtport reference is taken.

In the current code, only one put work item is queued at a time, which
results in a leaked reference.

To fix this, move the work item to the nvmet_fc_ls_req_op struct, which
already tracks all resources related to the command.

Fixes: 710c69dbaccd ("nvmet-fc: avoid deadlock on delete association path")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a9b18c051f5bd830a6ae45ff0f4892c3f28c8608..6725c34dd7c90ae38f8271368e609fd0ba267561 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -54,6 +54,8 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 	int				ls_error;
 	struct list_head		lsreq_list; /* tgtport->ls_req_list */
 	bool				req_queued;
+
+	struct work_struct		put_work;
 };
 
 
@@ -111,8 +113,6 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
-
-	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -235,12 +235,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
-static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+static void nvmet_fc_put_lsop_work(struct work_struct *work)
 {
-	struct nvmet_fc_tgtport *tgtport =
-		container_of(work, struct nvmet_fc_tgtport, put_work);
+	struct nvmet_fc_ls_req_op *lsop =
+		container_of(work, struct nvmet_fc_ls_req_op, put_work);
 
-	nvmet_fc_tgtport_put(tgtport);
+	nvmet_fc_tgtport_put(lsop->tgtport);
+	kfree(lsop);
 }
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
@@ -367,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  DMA_BIDIRECTIONAL);
 
 out_putwork:
-	queue_work(nvmet_wq, &tgtport->put_work);
+	queue_work(nvmet_wq, &lsop->put_work);
 }
 
 static int
@@ -388,6 +389,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsreq->done = done;
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
+	INIT_WORK(&lsop->put_work, nvmet_fc_put_lsop_work);
 
 	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
@@ -447,8 +449,6 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
 	__nvmet_fc_finish_ls_req(lsop);
 
 	/* fc-nvme target doesn't care about success or failure of cmd */
-
-	kfree(lsop);
 }
 
 /*
@@ -1410,7 +1410,6 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
-	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250821-fix-nvmet-fc-1af98991428f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


