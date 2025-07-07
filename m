Return-Path: <linux-kernel+bounces-720400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2199AFBB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9515F1BC0BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8526739E;
	Mon,  7 Jul 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxemsZ/s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FD265632
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913977; cv=none; b=gcaTmD5tG6EHlBxyu+GHvELau/bueEsq98Oov8NvSdmn4pLRf1KGB+n9rJJyKTy0/kXmLqJMLGc9P5+Rr36kzIP457G+wPGZ9zVEbCMrGhedmapaJXAx44ryrvCquc6X21Uz957H8p4Eo8mK7M+EuPh8f/CQDgH8IsOnocDUyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913977; c=relaxed/simple;
	bh=83Ba0mK1VEiznArAENk9nArtQQK30RYW79zt7Z+AzM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfiCJKBFtXSYS4Kx1FKHZGiFQuKVktJ9nyTrDCGETTcQjrwEhFxRm4DKt/M3jr8Q/Ye9Hk1LHKYBed3WCyEI5QDapEwPgfW041TPIswy1nUHJr9/aI9NuDiOkdvo5WayGsP/HavPlxBMjwnNpORg1n1kDRjCdUdGVrUyOx0V0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxemsZ/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751913974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6jUDIY0+wkpp5w9gqMEkqBb/sfMBkyBmQ7+Gp3OVZQ=;
	b=OxemsZ/smHKdRiX+EujtX93Lx7EUD1PlZDyHTu/b2b9pL2tl3dpfOoim9G06vQ3zzB+9C7
	IFhEJSz4JaQIhga2pmFzeBGHvnlokwK+40M1awTI/QQA2vFq8h6qBjGIFWDkjnzM6kJlUU
	rsPNR9ke4aoxtBpXkLRV9K9liUZwVsY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-0crdWXRUMv6UFj4ZrVrLGw-1; Mon,
 07 Jul 2025 14:46:10 -0400
X-MC-Unique: 0crdWXRUMv6UFj4ZrVrLGw-1
X-Mimecast-MFC-AGG-ID: 0crdWXRUMv6UFj4ZrVrLGw_1751913969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A17818089B4;
	Mon,  7 Jul 2025 18:46:09 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3326C1956095;
	Mon,  7 Jul 2025 18:46:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djeffery@redhat.com,
	loberman@redhat.com
Subject: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for allocation flags
Date: Mon,  7 Jul 2025 14:46:04 -0400
Message-ID: <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
In-Reply-To: <cover.1751913604.git.bcodding@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The NFS client writeback paths change which flags are passed to their
memory allocation calls based on whether the current task is running from
within a workqueue or not.  More specifically, it appears that during
writeback allocations with PF_WQ_WORKER set on current->flags will add
__GFP_NORETRY | __GFP_NOWARN.  Presumably this is because nfsiod can
simply fail quickly and later retry to write back that specific page should
the allocation fail.

However, the check for PF_WQ_WORKER is too general because tasks can enter NFS
writeback paths from other workqueues.  Specifically, the loopback driver
tends to perform writeback into backing files on NFS with PF_WQ_WORKER set,
and additionally sets PF_MEMALLOC_NOIO.  The combination of
PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
failures and the loopback driver has no retry functionality.  As a result,
after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
mempool_alloc()") users are seeing corrupted loop-mounted filesystems backed
by image files on NFS.

In a preceding patch, we introduced a function to allow NFS to detect if
the task is executing within a specific workqueue.  Here we use that helper
to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is nfsiod.

Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool_alloc()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/internal.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..173172afa3f5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -12,6 +12,7 @@
 #include <linux/nfs_page.h>
 #include <linux/nfslocalio.h>
 #include <linux/wait_bit.h>
+#include <linux/workqueue.h>
 
 #define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
@@ -669,9 +670,18 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 		!nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier);
 }
 
+static inline bool is_nfsiod(void)
+{
+	struct workqueue_struct *current_wq = current_workqueue();
+
+	if (current_wq)
+		return current_wq == nfsiod_workqueue;
+	return false;
+}
+
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
+	if (is_nfsiod())
 		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
 	return GFP_KERNEL;
 }
-- 
2.47.0


