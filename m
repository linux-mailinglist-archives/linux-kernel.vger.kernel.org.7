Return-Path: <linux-kernel+bounces-751325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3CB167BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E191886B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC2220F35;
	Wed, 30 Jul 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+D9R1GR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3218633F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908248; cv=none; b=IVfF9X/Dac5n5k5mNpSFsGH7meCYnuYXsqzoxNDVWoswITvVyWct1yj4AGSmv9JoB1BjJZtgvHStDKbp/jhEFpuyYyszrWk97p9Jn64KypLef8z1RMFFAe1cOw9XcxIlS1N0PnWkCKn3moC0OhgIeYi5TeqNjpLop/s3WA1aPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908248; c=relaxed/simple;
	bh=9DGGOM6EwJkIBDAlhMmSBcz1QoJ4tVGZFEhbp72aT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujVFrkVb3w3Z6qW9idh6Nd7EJGirVp74Rrd4S7UzsSGbbJcp6Wty4ZOPjRJD2CDh9nQg4wesFn9vO06YjLTkJf8m8lrK8Kz/puMkq47W9JLPxVGG53609NxU8elRJmRERnsaBirvn3A7KvEFCjSTM8/DtYSBnGUk2cbNHH79N0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+D9R1GR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83A6C4CEE3;
	Wed, 30 Jul 2025 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753908248;
	bh=9DGGOM6EwJkIBDAlhMmSBcz1QoJ4tVGZFEhbp72aT4o=;
	h=From:To:Cc:Subject:Date:From;
	b=W+D9R1GR4Tykso/U8BLc/iPWkdl6T6lr2XR6f+oc2MvT6VbaSrJFe3HF8e8FClgRq
	 rCq+krrpCxpi80UYdb00d4GVLnEQIwZ8G/K1E/cgeAiYqUfulMbYPusVPJ5WqxDq6p
	 zakJF6v/vd1zS9YOYLMp84c81jT31vMhseYC9uz/X5yvWaLRj3XQFrqxBZSSY7hQSQ
	 gIfJsaBgokcIes/D48u5oacmIkvQB5V5uK2qaDvmqpolyiPSdDJCNLZv0mfD9GUNU3
	 T9/meV+X/AmOKr4RXVXpZMIz60cOYhclRNyVxvYAvTmnZyJTax34aAFfyIQRjFwGf7
	 yjLsjSa/ezLkg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH v2] nvme: Fix typos
Date: Wed, 30 Jul 2025 15:32:45 -0500
Message-ID: <20250730204353.3383702-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in comments.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v1: https://lore.kernel.org/r/20250723202801.2909506-1-helgaas@kernel.org

This v2 based on nvme/nvme-6.17 (e97c0040215f ("nvme-auth: remove unneeded
semicolon"))

Changes from v1:
  - Drop drivers/nvme/host/apple.c fix; already fixed by 164c187d25b6
    ("nvme: fix multiple spelling and grammar issues in host drivers")
  - Drop hunks from drivers/nvme/host/fc.c; also fixed by 164c187d25b6
  - Drop drivers/nvme/host/pci.c nvme_setup_io_queues() fix; the comment
    added by e4b9852a0f4a ("nvme-pci: fix multiple races in
    nvme_setup_io_queues") needs more grammatical work than I can do to be
    intelligible; authors cc'd
  - Drop drivers/nvme/host/rdma.c fix; also fixed by 164c187d25b6
  - Add Chaitanya's Reviewed-by since I only dropped hunks, nothing new
    added

 drivers/nvme/host/fc.c     | 4 ++--
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/fc.c   | 6 +++---
 drivers/nvme/target/rdma.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 08a5ea3e9383..3e12d4683ac7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1363,7 +1363,7 @@ nvme_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
  * down, and the related FC-NVME Association ID and Connection IDs
  * become invalid.
  *
- * The behavior of the fc-nvme initiator is such that it's
+ * The behavior of the fc-nvme initiator is such that its
  * understanding of the association and connections will implicitly
  * be torn down. The action is implicit as it may be due to a loss of
  * connectivity with the fc-nvme target, so you may never get a
@@ -2777,7 +2777,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
 	 * there is no actual payload to be transferred.
 	 * To get it right, key data transmission on there being 1 or
-	 * more physical segments in the sg list. If there is no
+	 * more physical segments in the sg list. If there are no
 	 * physical segments, there is no payload.
 	 */
 	if (blk_rq_nr_phys_segments(rq)) {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9233f088fac8..c0fe8cfb7229 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2179,7 +2179,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 25598a46bf0d..a9b18c051f5b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -459,7 +459,7 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
  * down, and the related FC-NVME Association ID and Connection IDs
  * become invalid.
  *
- * The behavior of the fc-nvme target is such that it's
+ * The behavior of the fc-nvme target is such that its
  * understanding of the association and connections will implicitly
  * be torn down. The action is implicit as it may be due to a loss of
  * connectivity with the fc-nvme host, so the target may never get a
@@ -2313,7 +2313,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
 	ret = tgtport->ops->fcp_op(&tgtport->fc_target_port, fod->fcpreq);
 	if (ret) {
 		/*
-		 * should be ok to set w/o lock as its in the thread of
+		 * should be ok to set w/o lock as it's in the thread of
 		 * execution (not an async timer routine) and doesn't
 		 * contend with any clearing action
 		 */
@@ -2629,7 +2629,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
  * and the api of the FC LLDD which may issue a hw command to send the
  * response, but the LLDD may not get the hw completion for that command
  * and upcall the nvmet_fc layer before a new command may be
- * asynchronously received - its possible for a command to be received
+ * asynchronously received - it's possible for a command to be received
  * before the LLDD and nvmet_fc have recycled the job structure. It gives
  * the appearance of more commands received than fits in the sq.
  * To alleviate this scenario, a temporary queue is maintained in the
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 67f61c67c167..0485e25ab797 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1731,7 +1731,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
  * We registered an ib_client to handle device removal for queues,
  * so we only need to handle the listening port cm_ids. In this case
  * we nullify the priv to prevent double cm_id destruction and destroying
- * the cm_id implicitely by returning a non-zero rc to the callout.
+ * the cm_id implicitly by returning a non-zero rc to the callout.
  */
 static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
@@ -1742,7 +1742,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		/*
 		 * This is a queue cm_id. we have registered
 		 * an ib_client to handle queues removal
-		 * so don't interfear and just return.
+		 * so don't interfere and just return.
 		 */
 		return 0;
 	}
@@ -1760,7 +1760,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 
 	/*
 	 * We need to return 1 so that the core will destroy
-	 * it's own ID.  What a great API design..
+	 * its own ID.  What a great API design..
 	 */
 	return 1;
 }
-- 
2.43.0


