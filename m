Return-Path: <linux-kernel+bounces-792029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E87B3BF99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD73C16F6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F4338F22;
	Fri, 29 Aug 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6q5PNE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADB337697
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481860; cv=none; b=MOh2k7Csr1cWQoC7q3NfhiFW6mTJ6F2/ycOX/ZlZ1yj5jK+yaw3xYSUw078XIvLNn8w22YSyxsZ/choa/ai5gCwojM8UPPozM5NSm/2NJNuL/aGm0L6ifp1Ep8sDurKwdgWM+aF754FO1Q4pJEWLOVBXj3MQ+mcrU3KJ/ggYJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481860; c=relaxed/simple;
	bh=1D+KKEVMrSYTaxz25aM5XfBdCuC1VdSpDaU+c8DEwFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VI8i6qJVhmqhVtOOYQbBTCQnP+lL7L3AqdE+Qfmco2cOhYsE6ewcyCG2eYwYnCJuFJL88ae819KJJqIs8Ur+16C3sX74dRd8xq81tJcuWCd21y7FV2TbNeVYrIMb4Mv8ERfFz06SNwVNfZ32p/pbXoPIvV/j82Mfwi3DojdYHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6q5PNE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2FEC4CEF0;
	Fri, 29 Aug 2025 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481860;
	bh=1D+KKEVMrSYTaxz25aM5XfBdCuC1VdSpDaU+c8DEwFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R6q5PNE+cEAEH+7JIhevtWU+ym8Utaq6iEFv5FWmZ+cSV7dBwzkXl2JUC9U8ujVBS
	 A1/IvYT5RvY3xbiWgP7kypXeoVaPYGRV6B87iFlJr+4wZGIaqIPZBZbGZFbf/rvWqf
	 RfhK55t1LINEALEbKziQ/dT0DoogSbhgG0dIj2GCNjREfM45XMZpSHe4/84FLC8GE3
	 oZCSWibHTXUqhwdpBly9Hf25/CnncwuqOecUx6Penb7+j9zXtPvnBrgXlzCujynP7P
	 GHdpSQQeAOzo7BuF7EFk8vTBPxFfcfXjBCIKlt2XxM3rTQFA2oOTvF4wNhJ3Ndph8S
	 I++CPRlY+nXxg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:37:27 +0200
Subject: [PATCH v3 3/4] nvme-fc: refactore nvme_fc_reconnect_or_delete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Instead using if else blocks, apply the 'early return' and 'goto out'
pattern. This reduces the overall complexity of this function as the
conditions can be read in a linear order.

The only function change is that always the next reconnect attempt
message will be printed.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e6c79bf0bfd3884867c9ebeb24771323a619934..5d9e193bd2525ae1a2f08e2a0a16ca41e08a7304 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3249,7 +3249,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	struct nvme_fc_rport *rport = ctrl->rport;
 	struct nvme_fc_remote_port *portptr = &rport->remoteport;
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
-	bool recon = true;
 
 	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
 		return;
@@ -3259,38 +3258,43 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
-		recon = false;
+		goto delete_log;
 
-	if (recon && nvmf_should_reconnect(&ctrl->ctrl, status)) {
-		if (portptr->port_state == FC_OBJSTATE_ONLINE)
-			dev_info(ctrl->ctrl.device,
-				"NVME-FC{%d}: Reconnect attempt in %ld "
-				"seconds\n",
-				ctrl->cnum, recon_delay / HZ);
-		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
-			recon_delay = rport->dev_loss_end - jiffies;
+	if (!nvmf_should_reconnect(&ctrl->ctrl, status))
+		goto delete_log;
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
-	} else {
-		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
-			if (status > 0 && (status & NVME_STATUS_DNR))
-				dev_warn(ctrl->ctrl.device,
-					 "NVME-FC{%d}: reconnect failure\n",
-					 ctrl->cnum);
-			else
-				dev_warn(ctrl->ctrl.device,
-					 "NVME-FC{%d}: Max reconnect attempts "
-					 "(%d) reached.\n",
-					 ctrl->cnum, ctrl->ctrl.nr_reconnects);
-		} else
+	if (portptr->port_state != FC_OBJSTATE_ONLINE &&
+	    time_after(jiffies + recon_delay, rport->dev_loss_end))
+		recon_delay = rport->dev_loss_end - jiffies;
+
+	dev_info(ctrl->ctrl.device,
+		 "NVME-FC{%d}: Reconnect attempt in %ld seconds\n",
+		 ctrl->cnum, recon_delay / HZ);
+
+	queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
+
+	return;
+
+delete_log:
+	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
+		if (status > 0 && (status & NVME_STATUS_DNR))
 			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: dev_loss_tmo (%d) expired "
-				"while waiting for remoteport connectivity.\n",
-				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
-					(ctrl->ctrl.opts->max_reconnects *
-					 ctrl->ctrl.opts->reconnect_delay)));
-		nvme_fc_ctrl_put(ctrl);
-	}
+				 "NVME-FC{%d}: reconnect failure\n",
+				 ctrl->cnum);
+		else
+			dev_warn(ctrl->ctrl.device,
+				 "NVME-FC{%d}: Max reconnect attempts "
+				 "(%d) reached.\n",
+				 ctrl->cnum, ctrl->ctrl.nr_reconnects);
+	} else
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: dev_loss_tmo (%d) expired "
+			 "while waiting for remoteport connectivity.\n",
+			 ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
+					   (ctrl->ctrl.opts->max_reconnects *
+					    ctrl->ctrl.opts->reconnect_delay)));
+
+	nvme_fc_ctrl_put(ctrl);
 }
 
 static void

-- 
2.51.0


