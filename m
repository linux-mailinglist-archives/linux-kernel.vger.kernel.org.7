Return-Path: <linux-kernel+bounces-877964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D2C1F726
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF414E9C41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC2350A25;
	Thu, 30 Oct 2025 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et4SFdyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7C34F48D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818753; cv=none; b=XL3kymEqb/wyDhyFsEWO9cGGM+nZseTiHQ13erT2RFnOeLD7DBmxD8wKZ/9bg4ubu8krEcXdj2oOdS3tW8dNIaFzMShnSau2JbVYculUe+dujZdGmX/m8BXK8gOGZb+3F64cA+WKXFKOOAgSMQY26j1VeXpCGJWowwGfiOmQXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818753; c=relaxed/simple;
	bh=SP1ioKSaDdMcidA7eYCAEjoEi4/LMlq8R1no50L2IRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLWrzasDzq28IHEmXQI6HdDCTKOzp2cPJXcvEUYPRn/oxS5HJ6CmykdLSWUtFNwkwVb3fMxjJhWbhn8saG4Kbozl60PpNhQHZJIxbNLWuOPesi/uNHEpOxezM+GWM8o1ruE1+N4+PEnBLOI48cqZMLdd0/BP+Lsr++3sqjjPSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et4SFdyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7862EC4CEFD;
	Thu, 30 Oct 2025 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818752;
	bh=SP1ioKSaDdMcidA7eYCAEjoEi4/LMlq8R1no50L2IRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=et4SFdyIawUd5x6LQxcCM6jCvAN/uXHLEyMWIlaC4VyTGkZRcaPeeDLbkXNfw5dLH
	 Bby/g7oU0w5wQEoOUG0snaFyx65o/GXWYDCwpbEt+muwXO6r55NCBpPxSKzMSMBODn
	 1wEgn5gz+QowarVYi0wyR2SCXPs8flL52iw38RPCPy2O7pH6yoqxVsyp6kGhOHivJF
	 NeHvL/coZjmUAe+iuVI/UI2gLxfkc7NqnT02tAXO0sBVMVaeelr9f+lAjupUhqdMDZ
	 p3drvSxZksygoVw62F/4rTgcR14aWIUmxkvfzQ3HKFJURvWfpf7MwpfFy4SIFmrzpp
	 JqGJU/wahqrsA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:45 +0100
Subject: [PATCH v2 1/5] nvme-fc: don't hold rport lock when putting ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-1-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

nvme_fc_ctrl_put can acquire the rport lock when freeing the
ctrl object:

nvme_fc_ctrl_put
  nvme_fc_ctrl_free
    spin_lock_irqsave(rport->lock)

Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

Justin suggested use the safe list iterator variant because
nvme_fc_ctrl_put will also modify the rport->list.

Cc: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b..3ff70e6e8131 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1468,14 +1468,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
 					&lsop->rqstbuf->rq_dis_assoc;
-	struct nvme_fc_ctrl *ctrl, *ret = NULL;
+	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
 	struct nvmefc_ls_rcv_op *oldls = NULL;
 	u64 association_id = be64_to_cpu(rqst->associd.association_id);
 	unsigned long flags;
 
 	spin_lock_irqsave(&rport->lock, flags);
 
-	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
 		if (!nvme_fc_ctrl_get(ctrl))
 			continue;
 		spin_lock(&ctrl->lock);
@@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
+		spin_unlock_irqrestore(&rport->lock, flags);
 		nvme_fc_ctrl_put(ctrl);
+		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);

-- 
2.51.1


