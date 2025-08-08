Return-Path: <linux-kernel+bounces-759805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FFB1E2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F897565BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D9224B06;
	Fri,  8 Aug 2025 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="RTtPRDsG"
Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [61.16.102.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AE21CFFD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.16.102.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637261; cv=none; b=kx2TNB7xuiroOHbMuXmCsEt8wrKHfRBBy9nlMZefL1dIvZDFNn+GtrMLwwq5sBP12LFGalnsnJRIWTdOK+8x3K/9xUtEZMJO2PEgOT2UrYp0Y+jHEn3yIESvWSyaCyn5O3VWoLi5ydo9yyXl3dNCNmMdZDJcbDm3GXsrMH8yKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637261; c=relaxed/simple;
	bh=8kfvlj008YnIaM0038ps/kn/WSlIbvQUXKwo7ioLDZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jYeikZhvcRl1+dgsteF91Fx/MfPd9cRMBEq+lsFGcDuZ8COkLCBO2abXmaCPqb+YGtb7Ythe3FH2Ej4ttHT3wmlfu3w37IcjqJM+yqSMrYEAbhsZ6T8nJu/a85zVb/3FrUuUmUfiDJWNYX4kVEvnlmYke0LLATKarUUt+DZSWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=RTtPRDsG; arc=none smtp.client-ip=61.16.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Received: from m7-spam02.kuaishou.com (unknown [172.28.1.162])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 3A3794B8F;
	Fri, 08 Aug 2025 15:08:24 +0800 (CST)
Received: from bjm7-pm-mail03.kuaishou.com (unknown [172.28.1.3])
	by m7-spam02.kuaishou.com (Postfix) with ESMTPS id DF22B1800B05E;
	Fri,  8 Aug 2025 15:08:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1754636902; h=from:subject:to:date:message-id;
	bh=VrHFno4d3tb31dFkgFC1+IuRcN3RMBYUuHFLXeLm1k0=;
	b=RTtPRDsGWaPTQSUShZkYE3QWtzBHXZrG59vGQA7TQZzQG8Du2nvff/19Hw6tdLANsTS2sZfFN5N
	9TX6mO1d0uvUoRKIbR1qQGz83o2fefyYkiJkKL4WEtV6gQV5DawD0Wh9QzSPpMu/Fv08LL69o+jEt
	SummK/n95gY2/46EKNM=
Received: from localhost.localdomain (172.28.1.32) by
 bjm7-pm-mail03.kuaishou.com (172.28.1.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 8 Aug 2025 15:08:22 +0800
From: Zhao Sun <sunzhao03@kuaishou.com>
To: <xiubli@redhat.com>, <idryomov@gmail.com>, <amarkuze@redhat.com>
CC: <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zhao Sun
	<sunzhao03@kuaishou.com>
Subject: [PATCH v2] ceph: fix deadlock in ceph_readdir_prepopulate
Date: Fri, 8 Aug 2025 15:08:19 +0800
Message-ID: <20250808070819.18878-1-sunzhao03@kuaishou.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjxm-pm-mail07.kuaishou.com (172.28.128.7) To
 bjm7-pm-mail03.kuaishou.com (172.28.1.3)

A deadlock can occur when ceph_get_inode is called outside of locks:

1) handle_reply calls ceph_get_inode, gets a new inode with I_NEW,
   and blocks on mdsc->snap_rwsem for write.

2) At the same time, ceph_readdir_prepopulate calls ceph_get_inode
   for the same inode while holding mdsc->snap_rwsem for read,
   and blocks on I_NEW.

This causes an ABBA deadlock between mdsc->snap_rwsem and the I_NEW bit.

The issue was introduced by commit bca9fc14c70f
("ceph: when filling trace, call ceph_get_inode outside of mutexes")
which attempted to avoid a deadlock involving ceph_check_caps.

That concern is now obsolete since commit 6a92b08fdad2
("ceph: don't take s_mutex or snap_rwsem in ceph_check_caps")
which made ceph_check_caps fully lock-free.

This patch primarily reverts bca9fc14c70f to resolve the new deadlock,
with a few minor adjustments to fit the current codebase.

Link: https://tracker.ceph.com/issues/72307
Signed-off-by: Zhao Sun <sunzhao03@kuaishou.com>
---
 fs/ceph/inode.c      | 26 ++++++++++++++++++++++----
 fs/ceph/mds_client.c | 29 -----------------------------
 2 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 06cd2963e41e..d0f0035ee117 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1623,10 +1623,28 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	}
 
 	if (rinfo->head->is_target) {
-		/* Should be filled in by handle_reply */
-		BUG_ON(!req->r_target_inode);
+		in = xchg(&req->r_new_inode, NULL);
+		tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
+		tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
+
+		/*
+		 * If we ended up opening an existing inode, discard
+		 * r_new_inode
+		 */
+		if (req->r_op == CEPH_MDS_OP_CREATE &&
+		    !req->r_reply_info.has_create_ino) {
+			/* This should never happen on an async create */
+			WARN_ON_ONCE(req->r_deleg_ino);
+			iput(in);
+			in = NULL;
+		}
+
+		in = ceph_get_inode(mdsc->fsc->sb, tvino, in);
+		if (IS_ERR(in)) {
+			err = PTR_ERR(in);
+			goto done;
+		}
 
-		in = req->r_target_inode;
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
@@ -1636,13 +1654,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		if (err < 0) {
 			pr_err_client(cl, "badness %p %llx.%llx\n", in,
 				      ceph_vinop(in));
-			req->r_target_inode = NULL;
 			if (in->i_state & I_NEW)
 				discard_new_inode(in);
 			else
 				iput(in);
 			goto done;
 		}
+		req->r_target_inode = in;
 		if (in->i_state & I_NEW)
 			unlock_new_inode(in);
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 230e0c3f341f..8b70f2b96f46 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3874,36 +3874,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 				       session->s_con.peer_features);
 	mutex_unlock(&mdsc->mutex);
 
-	/* Must find target inode outside of mutexes to avoid deadlocks */
 	rinfo = &req->r_reply_info;
-	if ((err >= 0) && rinfo->head->is_target) {
-		struct inode *in = xchg(&req->r_new_inode, NULL);
-		struct ceph_vino tvino = {
-			.ino  = le64_to_cpu(rinfo->targeti.in->ino),
-			.snap = le64_to_cpu(rinfo->targeti.in->snapid)
-		};
-
-		/*
-		 * If we ended up opening an existing inode, discard
-		 * r_new_inode
-		 */
-		if (req->r_op == CEPH_MDS_OP_CREATE &&
-		    !req->r_reply_info.has_create_ino) {
-			/* This should never happen on an async create */
-			WARN_ON_ONCE(req->r_deleg_ino);
-			iput(in);
-			in = NULL;
-		}
-
-		in = ceph_get_inode(mdsc->fsc->sb, tvino, in);
-		if (IS_ERR(in)) {
-			err = PTR_ERR(in);
-			mutex_lock(&session->s_mutex);
-			goto out_err;
-		}
-		req->r_target_inode = in;
-	}
-
 	mutex_lock(&session->s_mutex);
 	if (err < 0) {
 		pr_err_client(cl, "got corrupt reply mds%d(tid:%lld)\n",
-- 
2.39.2 (Apple Git-143)


