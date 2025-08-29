Return-Path: <linux-kernel+bounces-792039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B54B3BFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7812E3BB36D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0F5322DB2;
	Fri, 29 Aug 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Oaridc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAC326D58
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482196; cv=none; b=b83FHz9ZnrfB4IP6LXLxE0JI7Q5lOSz5dJh+xFL6QFkNxTMIUA+Q9455399BUaafAxeoSLdjdiVDfLU7oQAcya5lyLzw4o8SSmVDjrIzpjtowYWB4+oj/RG3eOdVvIwNFSUUbQak9fT59DPIyQEEPWnf3xRnsZuJvkVKFm5zzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482196; c=relaxed/simple;
	bh=fqRuJpbCT5D0SI6B1QuBDKlqWeqnFieL/HVZ3RqF/YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKnk3EZHZ31hORmAwtdhY8OMErH7ssevpWiOcouhMAuMXO4ecBfzEjU+3A12zaztbQmGf35lwj8cZHRE6UWCGar9rAjJaQ3397q4s922vBnrEJcMcFu/i54eNZk4SVg6Cv8DKL90CogV3o+xRW5iQ/I04FgS/PYr7qV6Md3WipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Oaridc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF43C4CEF6;
	Fri, 29 Aug 2025 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482195;
	bh=fqRuJpbCT5D0SI6B1QuBDKlqWeqnFieL/HVZ3RqF/YE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P2Oaridc/+ZIk9H+gKb71zx2+9aHlG2tVTkcao+8z7qWiBJZJV7xAuDDXQrM/HimZ
	 Wr7AfitBOhvmIXHc40LWraIv7YIbqRtKutDf41Wf6qBiHCuzfljKo9lOvIhST8BblI
	 IH5XogRtOcxCH4tmcZamHv3G6qmLdeDLZxpd8PPE2ohj8PH/Qoa6jTdzV9CsRoXPPF
	 yU6vLIlXjT9Vn7lYOGFmUsTTOUxx1zX4SN9Bcyw95B24FMsZQMTM8c5lrd+zizlJ2T
	 09KL+C9e/Jp4Vrp982rO0bI7rEBPMw4EBPAxf3lu6/jKpTPCOhf7P6HtADwhnjxFAu
	 YfV+oFNXKK9KQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:43:01 +0200
Subject: [PATCH v2 2/2] nvmet-fc: avoid scheduling association deletion
 twice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
In-Reply-To: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

When forcefully shutting down a port via the configfs interface,
nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
then nvmet_disable_port(). Both functions will eventually schedule all
remaining associations for deletion.

The current implementation checks whether an association is about to be
removed, but only after the work item has already been scheduled. As a
result, it is possible for the first scheduled work item to free all
resources, and then for the same work item to be scheduled again for
deletion.

Because the association list is an RCU list, it is not possible to take
a lock and remove the list entry directly, so it cannot be looked up
again. Instead, a flag (terminating) must be used to determine whether
the association is already in the process of being deleted.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6725c34dd7c90ae38f8271368e609fd0ba267561..7d84527d5a43efe1d43ccf5fb8010a4884f99e3e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1075,6 +1075,14 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
+	int terminating;
+
+	terminating = atomic_xchg(&assoc->terminating, 1);
+
+	/* if already terminating, do nothing */
+	if (terminating)
+		return;
+
 	nvmet_fc_tgtport_get(assoc->tgtport);
 	if (!queue_work(nvmet_wq, &assoc->del_work))
 		nvmet_fc_tgtport_put(assoc->tgtport);
@@ -1202,13 +1210,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	unsigned long flags;
-	int i, terminating;
-
-	terminating = atomic_xchg(&assoc->terminating, 1);
-
-	/* if already terminating, do nothing */
-	if (terminating)
-		return;
+	int i;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_del_rcu(&assoc->a_list);

-- 
2.51.0


