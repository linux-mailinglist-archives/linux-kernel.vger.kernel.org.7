Return-Path: <linux-kernel+bounces-792028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76AB3BF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B71CC2DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD192334723;
	Fri, 29 Aug 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJoMFQE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B53375CD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481857; cv=none; b=AmuTVclKrXK13XYyjgXohMh/2hX3n6CzziiWUG4v5RfDDcOhbpbkUvnDmxa4ibvzB/CscA/cvFHytL2LsRRxZ5+VuJcPABvYQh7m4aR16m5AHCiwcgSv4Lf91oyHO28zPyuNioYlq4NLoCZ45tOM+cFxquojZAeHrUlDQdObEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481857; c=relaxed/simple;
	bh=Mr2XxeVwhgDsdCkBNqqoxxvgifdIeVB4y93gZzDxi3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfgA2aQvCDECZO+j9jqLN1KHJFJXJlaTcWU3IWoaVGwgcVKMDFCtBcYAOT6CoLDU7eypCgRYtci5ylqNIBkzQBZLRsuhF429nlJ3/mPOmF7GTE5Cinoc9qbX2Tam+GSbiUftnML9CzH3W3yGFKytfQAYP6OjqOGxUzGtu5/o/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJoMFQE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26274C4CEF0;
	Fri, 29 Aug 2025 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481857;
	bh=Mr2XxeVwhgDsdCkBNqqoxxvgifdIeVB4y93gZzDxi3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJoMFQE9dGTgCVsCM38gB1OW7WaOH2xFgw4JND7AWDUd7iB8aF7ypLr3f7+didaA1
	 rYZ9t5uV9gv3G4i6V3GckegmWAMWr0VlerZbGZu9g/HSxX4XN3aLXzo2Q7pnBDG6lB
	 sAAr8StkcZ5q/ABDZObMPjU0SDE+JEkW8t/YbSJIJzWhiAp0POGFLGPyeGsAAfHVQA
	 hlpb89cjZ9A4+ygGOV1y1ZB8jR17KzcjH+tZ/kflcWzRJYgSOR4UEnKbQqOd4cVZ+0
	 DlhLqVaT67pT6lktztK9qTFHsdYTGFIU2488KaKraGNJB4JOWNT1Lb36Wkn6gS0yBg
	 ze4BcIMJr/2Ug==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:37:26 +0200
Subject: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The lifetime of the controller is managed by the upper layers. This
ensures that the controller does not go away as long as there are
commands in flight. Thus, there is no need to take references in the
command handling code.

Currently, the refcounting code is partially open-coded for handling
error paths. By moving the cleanup code fully under refcounting and
releasing references when necessary, the error handling can be
simplified.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 102 ++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 70 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index db5dbbf6aee21db45e91ea6f0c122681b9bdaf6f..3e6c79bf0bfd3884867c9ebeb24771323a619934 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -228,6 +228,9 @@ static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
 
+static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
+static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
+
 /* *********************** FC-NVME Port Management ************************ */
 
 static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
@@ -826,7 +829,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
+			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
 	}
@@ -980,9 +983,6 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 /* *********************** FC-NVME LS Handling **************************** */
 
-static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
-static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
-
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
 static void
@@ -1476,8 +1476,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 	spin_lock_irqsave(&rport->lock, flags);
 
 	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
-		if (!nvme_fc_ctrl_get(ctrl))
-			continue;
 		spin_lock(&ctrl->lock);
 		if (association_id == ctrl->association_id) {
 			oldls = ctrl->rcv_disconn;
@@ -1485,10 +1483,6 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 			ret = ctrl;
 		}
 		spin_unlock(&ctrl->lock);
-		if (ret)
-			/* leave the ctrl get reference */
-			break;
-		nvme_fc_ctrl_put(ctrl);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
@@ -1567,9 +1561,6 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	/* fail the association */
 	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
 
-	/* release the reference taken by nvme_fc_match_disconn_ls() */
-	nvme_fc_ctrl_put(ctrl);
-
 	return false;
 }
 
@@ -2036,7 +2027,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
-		nvme_fc_ctrl_put(ctrl);
 		goto check_error;
 	}
 
@@ -2349,37 +2339,18 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_ctrl_free(struct kref *ref)
+nvme_fc_ctrl_delete(struct kref *ref)
 {
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
-	unsigned long flags;
-
-	if (ctrl->ctrl.tagset)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
 
-	/* remove from rport list */
-	spin_lock_irqsave(&ctrl->rport->lock, flags);
-	list_del(&ctrl->ctrl_list);
-	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
-
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
-
-	kfree(ctrl->queues);
-
-	put_device(ctrl->dev);
-	nvme_fc_rport_put(ctrl->rport);
-
-	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	nvmf_ctrl_options_put(ctrl->ctrl.opts);
-	kfree(ctrl);
+	nvme_delete_ctrl(&ctrl->ctrl);
 }
 
 static void
 nvme_fc_ctrl_put(struct nvme_fc_ctrl *ctrl)
 {
-	kref_put(&ctrl->ref, nvme_fc_ctrl_free);
+	kref_put(&ctrl->ref, nvme_fc_ctrl_delete);
 }
 
 static int
@@ -2397,9 +2368,20 @@ nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	WARN_ON(nctrl != &ctrl->ctrl);
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
+
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 
-	nvme_fc_ctrl_put(ctrl);
+	kfree(ctrl->queues);
+
+	put_device(ctrl->dev);
+	nvme_fc_rport_put(ctrl->rport);
+
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	nvmf_ctrl_options_put(ctrl->ctrl.opts);
+	kfree(ctrl);
 }
 
 /*
@@ -2649,9 +2631,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 		return BLK_STS_RESOURCE;
 
-	if (!nvme_fc_ctrl_get(ctrl))
-		return BLK_STS_IOERR;
-
 	/* format the FC-NVME CMD IU and fcp_req */
 	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
 	cmdiu->data_len = cpu_to_be32(data_len);
@@ -2696,7 +2675,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		ret = nvme_fc_map_data(ctrl, op->rq, op);
 		if (ret < 0) {
 			nvme_cleanup_cmd(op->rq);
-			nvme_fc_ctrl_put(ctrl);
 			if (ret == -ENOMEM || ret == -EAGAIN)
 				return BLK_STS_RESOURCE;
 			return BLK_STS_IOERR;
@@ -2737,8 +2715,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 			nvme_cleanup_cmd(op->rq);
 		}
 
-		nvme_fc_ctrl_put(ctrl);
-
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
 				ret != -EBUSY)
 			return BLK_STS_IOERR;
@@ -2822,7 +2798,6 @@ nvme_fc_complete_rq(struct request *rq)
 
 	nvme_fc_unmap_data(ctrl, rq, op);
 	nvme_complete_rq(rq);
-	nvme_fc_ctrl_put(ctrl);
 }
 
 static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
@@ -3251,9 +3226,16 @@ static void
 nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
+	unsigned long flags;
 
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+
+	/* remove from rport list */
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	list_del(&ctrl->ctrl_list);
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -3307,7 +3289,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
-		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
+		nvme_fc_ctrl_put(ctrl);
 	}
 }
 
@@ -3521,6 +3503,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
+	nvme_fc_rport_put(rport);
 	/* exit via here doesn't follow ctlr ref points */
 	return ERR_PTR(ret);
 }
@@ -3539,7 +3522,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ret = nvme_add_ctrl(&ctrl->ctrl);
 	if (ret)
-		goto out_put_ctrl;
+		goto fail_ctrl;
 
 	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
 			&nvme_fc_admin_mq_ops,
@@ -3574,26 +3557,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return &ctrl->ctrl;
 
 fail_ctrl:
-	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
-	cancel_work_sync(&ctrl->ioerr_work);
-	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
-
-	/* initiate nvme ctrl ref counting teardown */
-	nvme_uninit_ctrl(&ctrl->ctrl);
-
-out_put_ctrl:
-	/* Remove core ctrl ref. */
-	nvme_put_ctrl(&ctrl->ctrl);
-
-	/* as we're past the point where we transition to the ref
-	 * counting teardown path, if we return a bad pointer here,
-	 * the calling routine, thinking it's prior to the
-	 * transition, will do an rport put. Since the teardown
-	 * path also does a rport put, we do an extra get here to
-	 * so proper order/teardown happens.
-	 */
-	nvme_fc_rport_get(rport);
+	nvme_fc_ctrl_put(ctrl);
 
 	return ERR_PTR(-EIO);
 }
@@ -3703,8 +3667,6 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 			spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 			ctrl = nvme_fc_init_ctrl(dev, opts, lport, rport);
-			if (IS_ERR(ctrl))
-				nvme_fc_rport_put(rport);
 			return ctrl;
 		}
 	}
@@ -3929,7 +3891,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
 }

-- 
2.51.0


