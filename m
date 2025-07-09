Return-Path: <linux-kernel+bounces-723929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A43AFEC85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE4D18900B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3652E7163;
	Wed,  9 Jul 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF6n5VuT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A11D63E4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072493; cv=none; b=SQvvaJbDz/aMxsSKVaj/HMPMUXaplVINu+o5AUu1YD/G8Iv/U9AVCa6S8hMHWFv285TxqsUkYGU8DoW+OaAv+UpsSTqJqQiO64fW1xLJZ1at022j+qeC1HZDY4az9riLNAtWf3j4s6mDl5qo2XAk1n7bvyS2ve+kxQygdfARcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072493; c=relaxed/simple;
	bh=znGjZeNfcISgnIuBolbUXegTdHpJutXtuA0AIamwvs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGAxa5gmt6wRv3P8KspGm6DAN+enLZ9jOBCNnITWY9smmeFRqv0NBdtdT8MIP7RMC68JebpSMusQR1zS6bd8u8/jUljGH33G9e5vzMnXqK+giD32Ra0ygCQcUAB0XDyefR5LKk3Y3GxfNk2wp3f98PpYqcMIpQavg1wYAlMmzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF6n5VuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752072491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IvtHzdGRCCWhPpRsYp8sXiS0U91dJOKbbeEn3lL673g=;
	b=FF6n5VuTbpGdyT468B0QtMyutVLn8Xh7Xdbr51mezVQ5hBcmH8ueH8spBhwN1sbPNSTRf3
	2AopV/kP/zZYHV3VDhHpkZk+Qkd+RjDQyNH6Tx82+z6/OJPxzobx42MNB+0grHmNyc4fMM
	g5pKACoZOu3nKOKbMOr6NGH0Ea5fcds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-fU_ryyU9OTmw7flf1icw9A-1; Wed,
 09 Jul 2025 10:48:07 -0400
X-MC-Unique: fU_ryyU9OTmw7flf1icw9A-1
X-Mimecast-MFC-AGG-ID: fU_ryyU9OTmw7flf1icw9A_1752072486
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B17D1944AAD;
	Wed,  9 Jul 2025 14:48:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17FAC30001B1;
	Wed,  9 Jul 2025 14:48:04 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH v2] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Date: Wed,  9 Jul 2025 10:48:04 -0400
Message-ID: <9148ead966dbd7768d6dd832b61a8f1d93f43669.1752072235.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If the NFS client is doing writeback from a workqueue context, avoid using
__GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
failures much more likely.

We've seen those allocation failures show up when the loopback driver is
doing writeback from a workqueue to a file on NFS, where memory allocation
failure results in errors or corruption within the loopback device's
filesystem.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool_alloc()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---

	On V2: add missing 'Fixes' and Laurence's R-b T-b

 fs/nfs/internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..7f3213607431 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -671,9 +671,12 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
-		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-	return GFP_KERNEL;
+	gfp_t ret = current_gfp_context(GFP_KERNEL);
+
+	/* For workers __GFP_NORETRY only with __GFP_IO or __GFP_FS */
+	if ((current->flags & PF_WQ_WORKER) && ret == GFP_KERNEL)
+		return ret |= __GFP_NORETRY | __GFP_NOWARN;
+	return ret;
 }
 
 /*
-- 
2.47.0


