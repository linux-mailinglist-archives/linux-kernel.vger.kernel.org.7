Return-Path: <linux-kernel+bounces-877968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE15C1F71A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D96422728
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2D354708;
	Thu, 30 Oct 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZMNID5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742034F468
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818764; cv=none; b=Pnawnqp/tfX7bg0ziVeJqqahUdCofTlct3EjRnkZHlmKp5XMcELjgOnfkcKc+l0WVNG8uk0OQLislczA4OTPD3rZRiwc2Vgd3NGGiHMuD9cGGUfiMU+wGDzGxN31vaHVEer3eAtmnipeux0qpMcC3XsS8KPAhQ+ZPax4AW2fdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818764; c=relaxed/simple;
	bh=e0DStP5hUJf7YK1iKoYaQGpA0g5OWWSFDrWkvEoshXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAW9DFoy8ThoU7+iGR12SAkHaI8GmTL+SPbnSMAmD+2cXEXOxumDuBNj4VhH5HjYFogfwyHHfzBvyCTSp0xBXEJzolQuY5U35+OM/0Q+watfSWfcRHKkU0RaCJ72A4XdLFoyxgVjmfHne7wUuGTFeMa1iRqu8M69Pp3CX8mu/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZMNID5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF1C4CEF1;
	Thu, 30 Oct 2025 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818764;
	bh=e0DStP5hUJf7YK1iKoYaQGpA0g5OWWSFDrWkvEoshXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZMNID5g+7eLLOAqaRxOgc8yU3iJFHExWC4KViArijg1ylTvtjBRFh8cb6lS/Xyr4
	 ROf9E2tkXQMzyNVzpFe7HHB1p4fn0Fci50sVddLoy8XsD2+H3P+ttBN7qzaTo2Xbtk
	 d1+Ixg4CvwODY5obH02tG1oFaE4S1Ne58HROF6qfgNO0fMhTGIYuFuUmenZzRY7Zqg
	 7JXUuD2pYhGowE3Mg6GVxgiWRs9+dWYgTf8vGSC1IyAImSWSrp/6vKDDhBIg6qGj2z
	 SgZlsc+wfAsYogFPa/0AHOmg0XSIxAmwhoVTlhxWfodqHsGvu/mUQCp2Eo04kXDwBk
	 vI4n9NvVzU5ig==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:49 +0100
Subject: [PATCH v2 5/5] nvmet-fc: use pr_* print macros instead of dev_*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-5-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
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
2.51.1


