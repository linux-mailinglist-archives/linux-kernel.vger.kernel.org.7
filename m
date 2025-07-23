Return-Path: <linux-kernel+bounces-743175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60777B0FB76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D2D177F84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB216230D1E;
	Wed, 23 Jul 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX4MBjuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8823B624
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302487; cv=none; b=e/fh4G7EpUMFc+zfAgVsq4PMbYE90qzYvVsRM4/ePa1CJOzgzfg2M7AIWtV2Mj8+cUKNbGWKOyDlLoaUK33Ww6gULSEi9XGe7rBldPDbipdZS8IXztMQtMs2M68qq2VNMsYkazxktC0E4TWdfEqpoi2ZaStu2haOSS5GnjqH+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302487; c=relaxed/simple;
	bh=4G0qJWXzTgIhzJCFR5AflLsD2rnqsd9gHV06wB10rD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RA+zr+eIoARQa2hhQ/LROINCJgxRQEEgzyPjfQRK+PD6Mao5VksuPdg6xmbNIIT0z23cTbssLVrhTlMYwp1P4j1ILdqGMpZnH5+FrnTOfngomII2FFlGluWr6n/paDMJQktVTZLlqIkG9oortWYtmccDcdFSF1Lf5VuRi6lwGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX4MBjuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB2C4CEFA;
	Wed, 23 Jul 2025 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302486;
	bh=4G0qJWXzTgIhzJCFR5AflLsD2rnqsd9gHV06wB10rD8=;
	h=From:To:Cc:Subject:Date:From;
	b=WX4MBjuNZODHCR3kOaNx/hisUTqk1u8BcE8ZY2eJ3W5fSye/uEgJtjEfAxBz51AKy
	 uKsdwD0E7SXKGIIV8vz6eiF+C6Mxt9/pSKxDu/xhWLuOy6uSofwz9QPkQi0omOxTJi
	 dmhQhR798LARp0i/mxS9DV0Ov/yg1AlFrRQ5WBp/9iZCiehTzR9ncK4hzKUi6DX4pS
	 JHXhLvmxw4b8nOGGnmkxLqHq+Wwn+AbfRPd0b0YQY+dipNGruC5xeE2f5YjBrnZ++t
	 Q+95S7nPdWZRzAVpVKdO095uwPM/13d3VxGP/lyu0WDsxY9PMkt2FwImAEHwT9jc+8
	 hHoWDIGWy+qOw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] nvme: Fix typos
Date: Wed, 23 Jul 2025 15:27:51 -0500
Message-ID: <20250723202801.2909506-1-helgaas@kernel.org>
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
---
 drivers/nvme/host/apple.c  |  2 +-
 drivers/nvme/host/fc.c     | 10 +++++-----
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/fc.c   |  6 +++---
 drivers/nvme/target/rdma.c |  6 +++---
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1fddfa33ab9..c60f8a5e07a5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -302,7 +302,7 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 
 	/*
 	 * This lock here doesn't make much sense at a first glace but
-	 * removing it will result in occasional missed completetion
+	 * removing it will result in occasional missed completion
 	 * interrupts even though the commands still appear on the CQ.
 	 * It's unclear why this happens but our best guess is that
 	 * there is a bug in the firmware triggered when a new command
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 014b387f1e8b..2034dd70389a 100644
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
@@ -1955,8 +1955,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	/*
-	 * For the linux implementation, if we have an unsucceesful
-	 * status, they blk-mq layer can typically be called with the
+	 * For the linux implementation, if we have an unsuccessful
+	 * status, the blk-mq layer can typically be called with the
 	 * non-zero status and the content of the cqe isn't important.
 	 */
 	if (status)
@@ -2622,7 +2622,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
  * as part of the exchange.  The CQE is the last thing for the io,
  * which is transferred (explicitly or implicitly) with the RSP IU
  * sent on the exchange. After the CQE is received, the FC exchange is
- * terminaed and the Exchange may be used on a different io.
+ * terminated and the Exchange may be used on a different io.
  *
  * The transport to LLDD api has the transport making a request for a
  * new fcp io request to the LLDD. The LLDD then allocates a FC exchange
@@ -2777,7 +2777,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
 	 * there is no actual payload to be transferred.
 	 * To get it right, key data transmission on there being 1 or
-	 * more physical segments in the sg list. If there is no
+	 * more physical segments in the sg list. If there are no
 	 * physical segments, there is no payload.
 	 */
 	if (blk_rq_nr_phys_segments(rq)) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..f902bae348f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2548,7 +2548,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	/*
 	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
-	 * from set to unset. If there is a window to it is truely freed,
+	 * from set to unset. If there is a window to it is truly freed,
 	 * pci_free_irq_vectors() jumping into this window will crash.
 	 * And take lock to avoid racing with pci_free_irq_vectors() in
 	 * nvme_dev_disable() path.
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9bd3646568d0..190a4cfa8a5e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -877,7 +877,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..71e3a50d1ff7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2174,7 +2174,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
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


