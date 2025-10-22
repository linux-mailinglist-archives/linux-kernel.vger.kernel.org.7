Return-Path: <linux-kernel+bounces-864699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C3BFB5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED54E4E924A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E17315777;
	Wed, 22 Oct 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I/eqHFV/"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BC2472A8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128422; cv=none; b=qwXKVkJXvd1kAw2X7eI/aPgR8shklqcEhNPgShnC43ENu7WOv5JdSVclvqGeGnDOcIegSNbKmEnaOTa6hl75NdtrmCQPTggl5XYCY0MRPBRWT1KZyHu98ASXVz1XkYYJke0up1oy9QiBScugl8hDmBi0I5KQjoeP9t02COo8/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128422; c=relaxed/simple;
	bh=Wit2FgAsksM00jyxZA/PpTKg3l/+DQthNW+OiFZbGZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urEevIHr0tJElDgi1ODUN8BVjuJhHkMadJMJd++LVGuACzvsZaTEVgFa2Bt2FGRt4ZDZ2BwgLFvLy0lnmrSHJLhAtsBLsOwwLtgJvW0PlpcCKUdG63q5hlBbnisoJ8wlg5ez+eWVmc6vuyBAzqAHd16AGRCrbl6KGrsrFt0hozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I/eqHFV/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAKJCE1391487;
	Wed, 22 Oct 2025 05:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761128419;
	bh=g4E9DI4BsITNFZaG/SQz7E1z2z+oQ3Vx4NpSt7dVHlE=;
	h=From:To:CC:Subject:Date;
	b=I/eqHFV/GI5VwwDp8jrO4TwvV3JosSkCQ7OjPiUb1lN9Zsq9XOS4nppK40vMOUc1n
	 4HzUqXHC3RoGdWpEc5/zuiBauUafXfG5W8rrOB+gtgjLVnig/foQZBR+WVVijbIeir
	 o+CK9CdIJCawFXB713R3VfEhTQ/YAjnZk154cquU=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAKJla1855158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 05:20:19 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:20:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:20:19 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAKGft1057060;
	Wed, 22 Oct 2025 05:20:17 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <afd@ti.com>, <hnagalla@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>
Subject: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before entering suspend
Date: Wed, 22 Oct 2025 15:50:15 +0530
Message-ID: <20251022102015.1345696-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There may be pending messages in the mailbox FIFO that are not consumed
by the remote processor for various reasons; the remote processor may
already be powered off or may be in a bad state. Instead of aborting
suspend because of these pending messages, flush the FIFOs and proceed
with suspend. Pending messages could also be restored in the resume
context, but since remote processors are typically rebooted during
suspend/resume today, there is no point in restoring stale messages.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 680243751d62..5e6373911630 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -341,13 +341,10 @@ static int omap_mbox_suspend(struct device *dev)
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
-	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
-		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
-			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
-				fifo);
-			return -EBUSY;
-		}
-	}
+	/* Flush out pending mbox messages before entering suspend */
+	for (fifo = 0; fifo < mdev->num_fifos; fifo++)
+		while (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo)) != 0)
+			mbox_read_reg(mdev, MAILBOX_MESSAGE(fifo));
 
 	for (usr = 0; usr < mdev->num_users; usr++) {
 		reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);
-- 
2.34.1


