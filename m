Return-Path: <linux-kernel+bounces-796120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C047B3FC33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52787AF81E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390F283FDC;
	Tue,  2 Sep 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLlZYqdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5A283FC4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808543; cv=none; b=ZkF8FfuNTKPY9liyCGUXRvniMgW6d72K48+Uo/+1e3QrKN+TgtJKY69COK2JviqqUAnfzjrlOynPBl8T6NM1q5IzpdM4kvoXpY2qKNkElAm2pcrMtsBU6J+KqD/PkRDcF18RpDChPFYK5Igu5Z2zMOmuY6ud++pMAqSO/BAcU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808543; c=relaxed/simple;
	bh=pExNi9+edZehDdqmuJ6i1lZki0E/5kjYkaDbpM/DJjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fntkUgSR4ozXvHKc9exlcYDey9uPeufxvIn3shE0QaELB0LrwRlOjpXIcSqggTsMrw43NZl8NgPAfp6IAHvql3wdwO+CJzvs7/uThgigkotpRXAx/GP6n9alV4KgOHP7peLybz/X0cYOgzUJ9EGwvzGyBNpcWT9cVlTG67Kj/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLlZYqdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBDC4CEF5;
	Tue,  2 Sep 2025 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808542;
	bh=pExNi9+edZehDdqmuJ6i1lZki0E/5kjYkaDbpM/DJjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LLlZYqdU3KevwmEYeq6IAuWJMuVjLgmlYSDvY8XcXlg5uESCn2/2XSr3OcrWbOshx
	 NYEoGFa93Yz2tQS9HvcUKkw0uXX0FPG7Hjnd1tUscJkRtmXqtr0omOEjQw3DDvIKgq
	 dly3pWhOgx+ltIbnFLBl3SPtTT7TnYX2y3QDQqhTen1CkXFs4eMQQGqynbPmmPL1hn
	 Hv2O6EUlvAbkOgG4uCy04bsbXwK9fB8iNcg8aHBnkFuCPknvTxu+Od59fLz3Lkx6AD
	 QafS3M3rVgydFCI839AOxoUcVfYrdS4cn4wGBSAqELl2oitWIa4+7Kq1aEfew6HWBm
	 Tes6f5rhbm3LQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:01 +0200
Subject: [PATCH v3 2/4] nvmet-fc: avoid scheduling association deletion
 twice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-2-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
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

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3/
Reviewed-by: Hannes Reinecke <hare@suse.de>
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


