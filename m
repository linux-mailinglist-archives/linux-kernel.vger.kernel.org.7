Return-Path: <linux-kernel+bounces-657420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3ABABF3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF847B4506
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716FF265CB9;
	Wed, 21 May 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FDvduVAg"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1979264FA6
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829575; cv=none; b=Yh398fO6SNdhDvvbQ8n5AxuSCqTew1mqXQZudo/RbDOKnNmT370hHYtuYyJbnJFtEwVA865x2hLVyzMINodQucB4JZzk2lhFcNh2XiJLACaXLK+u0PeXvS1tgX15Hx0KhCCvJuk8onoibDFXN+GuIbThmmVQLBeyUrs0MXafeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829575; c=relaxed/simple;
	bh=glzgGwBa0z73tkF70TipUoFYetOf3XZBdMqwFj57g9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elctIUSbYQRdkk5MdHo7qLNalCUfmSJo4dCjFw1HCq9MvtVyKfYDxYPP5yk6LXKiqYSli0eiTWNzBYemr0eaqVdbCYFEKwRNMphLE0EvpQzBZvlZ0jXaLt/7ICdgDz1OAOqolSPQjl6D8ipIKKliXTAL+4Fggc3JbdfKDXhdhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FDvduVAg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747829569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ydwoQy174fnIeX8b6mxNKv5PHl9MRDMKnEHAr6lH5I=;
	b=FDvduVAgb7KRekIuAHzjrMKYnyeh67n1/SbYQDgrxEiVTWVFTiHIi5924JBERDmsrOSK4/
	NTkHV7BlJ2v0Xt9EImnx3z0YfCUZISO/Bl4YP7mzFB/im+yzAuq8maoRXWev14My5vb6/N
	s/WpWP5IDKzkVxPU84eAEM+NjEIIAFs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vishal Bhakta <vishal.bhakta@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] scsi: vmw_pvscsi: Use str_enabled_disabled() helper in pvscsi_probe()
Date: Wed, 21 May 2025 14:12:29 +0200
Message-ID: <20250521121229.4738-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
warning.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/vmw_pvscsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 32242d86cf5b..4927c6a33bd8 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
+#include <linux/string_choices.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
@@ -1508,8 +1509,8 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_reset_adapter;
 
 	adapter->use_req_threshold = pvscsi_setup_req_threshold(adapter, true);
-	printk(KERN_DEBUG "vmw_pvscsi: driver-based request coalescing %sabled\n",
-	       adapter->use_req_threshold ? "en" : "dis");
+	pr_debug("vmw_pvscsi: driver-based request coalescing %s\n",
+		 str_enabled_disabled(adapter->use_req_threshold));
 
 	if (adapter->dev->msix_enabled || adapter->dev->msi_enabled) {
 		printk(KERN_INFO "vmw_pvscsi: using MSI%s\n",
-- 
2.49.0


