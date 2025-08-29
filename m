Return-Path: <linux-kernel+bounces-792038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66006B3BFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56C2584370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D7322DCE;
	Fri, 29 Aug 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RScIlWWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD41E51EA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482193; cv=none; b=EtMHsPccOOYhrEyoUNHlsd+87NgY+CWPbEE8nyjfbt3ljHf1kQEgry2xgtW4C/UyCRAjD3XrBIX/bw6VRQrYPmdBQFIzvaGGRtxdi7NO6dGMg34Y0pWpZx+v+5c9hEwpOpCCw+ojDbGPsGny6FCZH3QrzoNu7rwQLntgiWiRnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482193; c=relaxed/simple;
	bh=aoPIGzDgsINBf0Ebqd1cCI2ZeqD5+jR9ioyq3QpOSC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mp9J9Tz8RP2ggMRWezJ0m3foaymRjWp79fbYvRIXZsQxjwvJOYzyrXE+Dscy+fiWGPR7+0iRvj+aaBzU0Wy2gNb8eqQ8NeB/IpbPnGzxGV2CmqzdeIA1k3gU/OGtuZOtdXMkP+i0NHn5UJc6IvpEquKVkzv9TAg+TqXxnmgA4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RScIlWWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E653C4CEF5;
	Fri, 29 Aug 2025 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482192;
	bh=aoPIGzDgsINBf0Ebqd1cCI2ZeqD5+jR9ioyq3QpOSC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RScIlWWhzgJbNdbu3nEiGj1gatpovR7GejHeJFrJeo9hD/4NgLB1vvGr/1Od89alU
	 czJg9ktUZGmpVvxVdan1tLBCFWhUxvAdoxFIBeRp7ePDczy40jWpROG1/prHBK/13R
	 ou+54nR0iwgfHrW0Nic728fjdv2dhvMTPsBVE2H40Lhska/4vKPpLjVew2Evg6shyt
	 vOHmboA86T1mQ6QnXod6PP5bYsKQG6xqi3YbcEK31twncnLc1ZuJ6pJJZg/OlgwgK0
	 iYz/+lG737KIWAehiH117fhueoIDv7eoFuFrIaoQy6OlQMbONSDbOoVV+5V7uuiwsN
	 DtIY9FdHrUItA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:43:00 +0200
Subject: [PATCH v2 1/2] nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-fix-nvmet-fc-v2-1-26620e2742c7@kernel.org>
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
In-Reply-To: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
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

-- 
2.51.0


