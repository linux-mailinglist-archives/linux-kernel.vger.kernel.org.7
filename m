Return-Path: <linux-kernel+bounces-874072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13656C15726
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9682C4067FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454733F8BE;
	Tue, 28 Oct 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMe6PPFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984C30BF75
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665203; cv=none; b=KNHUzMTLIrTYyJVOeoeGCtW1H1MJNUaE7zDZZTW9kUnusKG9ZfCnqTWoC/vL1TIsWQU6knDQyzoBGyRuX/YFJPk7ZlFuV+EBzE096sL+XQcgXsOIOItqUXyMy/dQ6K16hJlUhapE9fffB7BGwMzq4T/QTlRAA65Gl97G8ZObd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665203; c=relaxed/simple;
	bh=og4RpLkQbHwN8FOYj4/Ae2jn1OJFGZDc8igUI8xWOMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLlz3rU03yAVRtw72CKkUr5ZAEUYZQ0JvUHrUx0UiVGTzaFb+EHX1lZO2f+Az5ALhqfAzv04KQbjjny+oI19DRvzMTRtL6WF1scqUuBb3iaKadQuBlkOvYy9wrZntzG75DUue0otD5XBEqBuCYUygJDCd6TJ6vAJHkbhRZQadUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMe6PPFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77991C4CEF7;
	Tue, 28 Oct 2025 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665202;
	bh=og4RpLkQbHwN8FOYj4/Ae2jn1OJFGZDc8igUI8xWOMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VMe6PPFDylySqOED17+YvMfnapMzSDc1WEfDcbD/ml3q+KmNrwBDXmvCq7BatsDXy
	 okJyPIfexJrWSbCBiu4AN0dZ4RGPKPwBcerg91Dbns7qi6cC/0YEWAzWo9q8Eq9krZ
	 /65wbFPshhoFg0r4/HcdHbrG5Nl0VHxFp47alG2fKpmtGVcLButFfi+Qd1K3PL6RIo
	 mjbGE+RoiqkLniwCPUqy7Fw7SGijxVFo2wH7n6KUq9TqSysVukOTh/aUwXwEQ6ErvN
	 TeOGgkjxmwRwDBOP2t5UDuTVVVfiNwy4SRlAcY3asqh4veB/u8QHZvDFaKzjYOS128
	 Xweo7JtwJbXBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:24 +0100
Subject: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

Many of the nvmet-fc log messages cannot print the device used, because
it's not there yet:

  (NULL device *): {0:0} Association deleted

Use the pr_* macros consistently throughout the module and match the
output of the nvme-fc module.

Using port:association ids are more useful when debugging what's going
on, because these match now with the log entries from nvme-fc.
---
 drivers/nvme/target/fc.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7d84527d5a43..0d9784004c9b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -490,8 +490,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 			sizeof(*discon_rqst) + sizeof(*discon_acc) +
 			tgtport->ops->lsrqst_priv_sz), GFP_KERNEL);
 	if (!lsop) {
-		dev_info(tgtport->dev,
-			"{%d:%d} send Disconnect Association failed: ENOMEM\n",
+		pr_info("{%d:%d}: send Disconnect Association failed: ENOMEM\n",
 			tgtport->fc_target_port.port_num, assoc->a_id);
 		return;
 	}
@@ -513,8 +512,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	ret = nvmet_fc_send_ls_req_async(tgtport, lsop,
 				nvmet_fc_disconnect_assoc_done);
 	if (ret) {
-		dev_info(tgtport->dev,
-			"{%d:%d} XMT Disconnect Association failed: %d\n",
+		pr_info("{%d:%d}: XMT Disconnect Association failed: %d\n",
 			tgtport->fc_target_port.port_num, assoc->a_id, ret);
 		kfree(lsop);
 	}
@@ -1187,8 +1185,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	if (oldls)
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	ida_free(&tgtport->assoc_cnt, assoc->a_id);
-	dev_info(tgtport->dev,
-		"{%d:%d} Association freed\n",
+	pr_info("{%d:%d}: Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
 	kfree(assoc);
 }
@@ -1224,8 +1221,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 			flush_workqueue(assoc->queues[i]->work_q);
 	}
 
-	dev_info(tgtport->dev,
-		"{%d:%d} Association deleted\n",
+	pr_info("{%d:%d}: Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
 
 	nvmet_fc_tgtport_put(tgtport);
@@ -1716,9 +1712,9 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret) {
-		dev_err(tgtport->dev,
-			"Create Association LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Create Association LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
@@ -1730,8 +1726,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	atomic_set(&queue->connected, 1);
 	queue->sqhd = 0;	/* best place to init value */
 
-	dev_info(tgtport->dev,
-		"{%d:%d} Association created\n",
+	pr_info("{%d:%d}: Association created\n",
 		tgtport->fc_target_port.port_num, iod->assoc->a_id);
 
 	/* format a response */
@@ -1809,9 +1804,9 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret) {
-		dev_err(tgtport->dev,
-			"Create Connection LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Create Connection LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
@@ -1871,9 +1866,9 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	}
 
 	if (ret || !assoc) {
-		dev_err(tgtport->dev,
-			"Disconnect LS failed: %s\n",
-			validation_errors[ret]);
+		pr_err("{%d}: Disconnect LS failed: %s\n",
+		       tgtport->fc_target_port.port_num,
+		       validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
 				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
@@ -1907,8 +1902,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
 	if (oldls) {
-		dev_info(tgtport->dev,
-			"{%d:%d} Multiple Disconnect Association LS's "
+		pr_info("{%d:%d}: Multiple Disconnect Association LS's "
 			"received\n",
 			tgtport->fc_target_port.port_num, assoc->a_id);
 		/* overwrite good response with bogus failure */
@@ -2051,8 +2045,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	struct fcnvme_ls_rqst_w0 *w0 = (struct fcnvme_ls_rqst_w0 *)lsreqbuf;
 
 	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: payload too large (%d)\n",
+		pr_info("{%d}: RCV %s LS failed: payload too large (%d)\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "",
 			lsreqbuf_len);
@@ -2060,8 +2054,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	}
 
 	if (!nvmet_fc_tgtport_get(tgtport)) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: target deleting\n",
+		pr_info("{%d}: RCV %s LS failed: target deleting\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		return -ESHUTDOWN;
@@ -2069,8 +2063,8 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 
 	iod = nvmet_fc_alloc_ls_iod(tgtport);
 	if (!iod) {
-		dev_info(tgtport->dev,
-			"RCV %s LS failed: context allocation failed\n",
+		pr_info("{%d}: RCV %s LS failed: context allocation failed\n",
+			tgtport->fc_target_port.port_num,
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		nvmet_fc_tgtport_put(tgtport);

-- 
2.51.0


