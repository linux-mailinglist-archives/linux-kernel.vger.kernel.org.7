Return-Path: <linux-kernel+bounces-849174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C1ABCF572
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B0F425CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4627AC43;
	Sat, 11 Oct 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2p2WGfW"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0927990E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186916; cv=none; b=GpegiLOwEB6ytzZsIFSEc2AEAHHvnVGyHI9UR1IVZMI1HUZ+JhGG5XV40BWBuefVljB3OoCk4X4dUqvKhW1p04MCZYXr5ljxd/r6KfirFVEhrEp2qJx7KgqSczpk9Cc86tqA7lcGvm/D3MnMbrOc2PxbHRH+DjksmsKs/w5ttZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186916; c=relaxed/simple;
	bh=oLFwtnz4/1nYejwJpMumUq3xNTQyfLYnC0l0ONQtxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWU/Sfp2Wip8DULZu7+TFWdt9cSw90FYv8xIRfvEsPmR1aDEMcuVD+J3ifpBQQoyZErKScXQ793HBK4FUvVBtdI7NojCXk1DAqPurIEjpUq8Ie17iUS3tdTJ3R4L5H4Oe7NT5FdgHOSXH9ZK6/teVqV8Qy3+8m8r9YOwPxLsvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2p2WGfW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso2550038a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760186909; x=1760791709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfZcdpoJrjBJZWXof4dHLVFSEs9CKFeUZZ3CpQmMUvQ=;
        b=O2p2WGfWt3yjLh8/Ao9g9tEJFBuFsdrvTbKWdu6yVn46saiIX4FQp/4HjdP7uFiYfD
         I0t5DUZ0SZJfVimxsXvXv7bO+KTgyZ/jzkpcdP7FaqKmVroXGzL98mRrajBLDOKxN31i
         JIZOGYBF8LIXHNtyaL1Nz86Mnx6m7LgAtqBsdzR5WTgbT0mbJSnMYvFgnWf5hbbQe4KN
         QvjtNX9DyX5yAws2t3BAZ+FxYlp99it79yteHk9/IdcxiEtNJGZbYyAvttcXlhbdQyHl
         lQKd7iDw3b5KBTRPANu1/QXghIWRJy4iXzAgZH4znkdEfQjbkBYBS4Fd51ybRABtSlXj
         21sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760186909; x=1760791709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfZcdpoJrjBJZWXof4dHLVFSEs9CKFeUZZ3CpQmMUvQ=;
        b=qur82x54FoknXvfAzqjZgng1/JeTErb92ZvrYH2plKlYKkgdRhlwnuoup0PQ3w8K1v
         pA9FJwn4Xs7QcgZZiaAQ37Y18sk3xCAJawjluS4xoOt47ed8ABKa9fDDlo27D8df3nAZ
         ROb7KyEwg0FGrTvKv5J5iFvRTRUsG6U0GRuAEYsSPjyk70X9TSUhQ/H0K/eUzXGwd8US
         0c5zrKQbRo8XONVT+HeEw2vgszWHkjJC9f44OYdliGgA5L+CwFDH1GKq9880W5sxaX4d
         A/3i2N5cWyqO5pXw3EjJCMEQJ3hHliRqY+hHxwEKieOuCM6GLeyv2J3IAMJDNiH83mVx
         hWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVNB3FBa4oAisQ6OQE2nA6/s6G/vPDbN7OfPl48Je9E+xAz+gqIvCE0RuGx4ZoY8oxiH2a+WZDr+EdVRz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouaCDagyfhq1fd4hRozH3L/2dkKh1QQl714Nded6DCENSdXTI
	dpP5IEmzLDmjW40D76AHaNF36KcWC/y6FG9W6XmOcoV7QOOJ4/v16Et1
X-Gm-Gg: ASbGncvSRKcTMy2BCdVUw0gPanfmP9crz4YSWsHyCDZRCmF4v3eUQPafzLPRgFPncCC
	/OjH22XIABiYQeXgJziz30CXkDWQFYst00CXMRhs/z3/ba+76TF1ZTU/WzmQ88ZNgJ1Wr5UtSxx
	PWK+jr0idbtVUlflXX0AE4Sc0uJRpy6f00qMTeQUgrbhETNa8V8I8rh12/Zgqr+nnnBWz9VWdVQ
	l99Tloe16Y/RJ97BmzVdazokegXqeeF7A0562bfay3W3X0KvCSC2w/S0Ovrc9kILQpMMPBc15xD
	H/6y014yaNrUQ03KxxWTgAVHXL7KKLwVaZGeZMx0N34JMS292jpwYKtE4KpP/wW+1BDalrwLgVH
	HRVVtYc7TfOGnCNykbAGBubxEgh8K3xeTvalvHjNaN0Z2GWjFZJe7
X-Google-Smtp-Source: AGHT+IE3AHxFWYswoEKawHh8CnypL++DQF/QW93jEt7+3yabRyzSQz8VviBzvqWHPD7rOO//5c4gKA==
X-Received: by 2002:a17:90b:3a8a:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-33b5139a3aamr21550746a91.29.1760186909071;
        Sat, 11 Oct 2025 05:48:29 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:4151:fa75:b28e:228e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac7af3sm6246199a91.17.2025.10.11.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:48:28 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH v2 1/1] statmount: accept fd as a parameter
Date: Sat, 11 Oct 2025 18:16:11 +0530
Message-ID: <20251011124753.1820802-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_FD
flag. When a valid fd is provided and STATMOUNT_FD is set, statmount
will return mountinfo about the mount the fd is on.

This even works for "unmounted" mounts (mounts that have been umounted
using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
on that mount. These "umounted" mounts will have no mountpoint hence we
return "[detached]" and the mnt_ns_id to be 0.

Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c             | 80 ++++++++++++++++++++++++++++----------
 include/uapi/linux/mount.h |  8 ++++
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..eb82a22cffd5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
+{
+	seq_puts(seq, "[detached]");
+	return 0;
+}
+
 static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
@@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
-	s->sm.mnt_ns_id = ns->ns.ns_id;
+	if (ns)
+		s->sm.mnt_ns_id = ns->ns.ns_id;
+	else
+		s->sm.mnt_ns_id = 0;
 }
 
 static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
@@ -5431,7 +5440,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		break;
 	case STATMOUNT_MNT_POINT:
 		offp = &sm->mnt_point;
-		ret = statmount_mnt_point(s, seq);
+		if (!s->root.mnt && !s->root.dentry)
+			ret = statmount_mnt_point_detached(s, seq);
+		else
+			ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
 		offp = &sm->mnt_opts;
@@ -5572,29 +5584,33 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 
 /* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
-			struct mnt_namespace *ns)
+			struct mnt_namespace *ns, unsigned int flags)
 {
 	struct mount *m;
 	int err;
 
 	/* Has the namespace already been emptied? */
-	if (mnt_ns_id && mnt_ns_empty(ns))
+	if (!(flags & STATMOUNT_FD) && mnt_ns_id && mnt_ns_empty(ns))
 		return -ENOENT;
 
-	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
-	if (!s->mnt)
-		return -ENOENT;
+	if (!(flags & STATMOUNT_FD)) {
+		s->mnt = lookup_mnt_in_ns(mnt_id, ns);
+		if (!s->mnt)
+			return -ENOENT;
+	}
 
-	err = grab_requested_root(ns, &s->root);
-	if (err)
-		return err;
+	if (ns) {
+		err = grab_requested_root(ns, &s->root);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Don't trigger audit denials. We just want to determine what
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
+	if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -5718,12 +5734,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 }
 
 static int copy_mnt_id_req(const struct mnt_id_req __user *req,
-			   struct mnt_id_req *kreq)
+			   struct mnt_id_req *kreq, unsigned int flags)
 {
 	int ret;
 	size_t usize;
 
-	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER1);
+	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER2);
 
 	ret = get_user(usize, &req->size);
 	if (ret)
@@ -5738,6 +5754,11 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 		return ret;
 	if (kreq->spare != 0)
 		return -EINVAL;
+	if (flags & STATMOUNT_FD) {
+		if (kreq->fd < 0)
+			return -EINVAL;
+		return 0;
+	}
 	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
 	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
 		return -EINVAL;
@@ -5788,23 +5809,37 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct kstatmount *ks __free(kfree) = NULL;
+	struct vfsmount *fd_mnt;
 	struct mnt_id_req kreq;
 	/* We currently support retrieval of 3 strings. */
 	size_t seq_size = 3 * PATH_MAX;
 	int ret;
 
-	if (flags)
+	if (flags & ~STATMOUNT_FD)
 		return -EINVAL;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, flags);
 	if (ret)
 		return ret;
 
-	ns = grab_requested_mnt_ns(&kreq);
-	if (!ns)
-		return -ENOENT;
+	if (flags & STATMOUNT_FD) {
+		CLASS(fd_raw, f)(kreq.fd);
+		if (fd_empty(f))
+			return -EBADF;
+		fd_mnt = fd_file(f)->f_path.mnt;
+		ns = real_mount(fd_mnt)->mnt_ns;
+		if (ns)
+			refcount_inc(&ns->passive);
+		else
+			if (!ns_capable_noaudit(fd_file(f)->f_cred->user_ns, CAP_SYS_ADMIN))
+				return -ENOENT;
+	} else {
+		ns = grab_requested_mnt_ns(&kreq);
+		if (!ns)
+			return -ENOENT;
+	}
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+	if (ns && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -ENOENT;
 
@@ -5817,8 +5852,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
+	if (flags & STATMOUNT_FD)
+		ks->mnt = fd_mnt;
+
 	scoped_guard(namespace_shared)
-		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
+		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns, flags);
 
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
@@ -5957,7 +5995,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
 		return -EFAULT;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7fa67c2031a5..dfe8b8e7fa8d 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -201,11 +201,14 @@ struct mnt_id_req {
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
+	__s32 fd;
+	__u32 spare2;
 };
 
 /* List of all mnt_id_req versions. */
 #define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
 #define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
+#define MNT_ID_REQ_SIZE_VER2	40 /* sizeof third published struct */
 
 /*
  * @mask bits for statmount(2)
@@ -232,4 +235,9 @@ struct mnt_id_req {
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
 #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
+/*
+ * @flag bits for statmount(2)
+ */
+#define STATMOUNT_FD		0x0000001U /* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.51.0


