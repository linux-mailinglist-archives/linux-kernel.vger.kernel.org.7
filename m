Return-Path: <linux-kernel+bounces-702262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04889AE8036
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4CC3BEA48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BF2D6633;
	Wed, 25 Jun 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hGQ7VBMt"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372B25A624
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848595; cv=none; b=tjLXcbJM1xvv6NjcOxzmmNkDsvnw6H/sH6lLisufTiMVqokgZR2Q2WP91Flt21X7TCyWFoRDr/yt9kkwsdyhRaA6o+CkPfCFJ/Gp/y2pXeBnt079W1ErVOkofargXxgQYHbwm9kDHFAIJk7/W68Z23EWp0+mcWQy2bUf3lXDcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848595; c=relaxed/simple;
	bh=VxNADheGjMAF/tqRabY5ucZVCY3CmiMkqGaUgxmQ3lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2TWcQevNnXNL9aiXqcBl2v74VIK6SRsBFgeTwyHjkw+jt6LwEYxzPKr1n8gjDYzpfwOLjXp1K3Ew2JUioFku3QrjtaLeD6yUkM/nuM2gnQCebrW10Y35f/EqwM30wBy93+okZlkDXbkqGR/Eh7yZdhLBL+Cd4LTqEAzZzYXcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hGQ7VBMt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4530921461aso11762775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750848591; x=1751453391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNPPR1NoLDoLvQJNf3yIOwNilwXiKG9SafSPUCiF9aA=;
        b=hGQ7VBMtLrk7wk2cEap8u0s9d4Slkhx/YnSjdWFBb06TaUlOxH8r3G1Ft2IzkNvDx/
         u+hyyYVRLb4mZQnECIbzxYBQSFwgTySb58kSD9K6V60SG8XVL6zdb5Ftbq+j0TPUk9KN
         j22TXAT8cLdyJxnuyZay+RXfh3a1DL/MU3iZ2zjj10wIgOOtwoC9ocZKFrG+NwbzDT09
         o08iQ8WETI/1oKtsB+Tbh8IQKiz/S+Y6zztGI7sJpA31QYcuMFJYTs4YYF+c3mbYf6E5
         gbpPncI1T0PSCWfAfWcoe63/1nNYXdiGzZB6tiJLTZbSgZIU8ihA5LVem6DZVamvzbPq
         leZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848591; x=1751453391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNPPR1NoLDoLvQJNf3yIOwNilwXiKG9SafSPUCiF9aA=;
        b=FoSTAZzL4ELW+qRQZ9sHrj0/y4NkkJibRSElipA68GLjtSf1iPdItVa3AwGhUrGZ7T
         z72kurS2lyMUTGK5CztDbGwrHsLUSDqWVUGjzTLLqrtweAuSOZbdvHjC+10t5HS5HQ2B
         P0EEGlo7TZFwyKrEUalQkQevqsglvc+G0srYt6zKpfqMFQFrFM+Ymmpxo2z2O1FeGoc6
         +3D2CsQ36npAueTn/b6KViGURl4gs/prhzsHIHopKxKzvFm6JEa07wbxtF/dpqS2PXUi
         h2abLC0SCXQhcQVnjn9W8AQ+CxVoccEs9DGPiiTF9KGaEOcSQx5mnfVkNahSMeWHQTr9
         fUWw==
X-Gm-Message-State: AOJu0Yx5aQ5rwedK6s7Gh6zMv+fBt8WCCcXSoXztL/oLqqRmEgRRqe6M
	r9A/G8KnFzgM2zqX1Pg5W11Lbxdiz2mmrCH4TDJaUC9ceBlyadzuY2pw+zSp/8NsrVNImsfbAoE
	oRH3b5rg=
X-Gm-Gg: ASbGnctMB5HLbKkw6B/uLg+ADaYzs5H8IKLGBTPoW9YJO7Y797OYJhu+/amVB0z77kO
	oUgD7b08eSinmEHxVWdtFkQC7MDFsQyUvmv1gwuaZq3QA+JE8Wi75XsuJdzbkric18MqpiwSn2c
	Y6NA4kXdvruO4N05HHopFAnT25H1vqfQhPtHLbBXmMxD/hPBMk1PZXOhTSIb32JR+ps0JZWUNEP
	SwCmIJb5wwaCZfrXLbrSk9sO5aKQA3iZWIhoHfs6av+MXXYE0qpY/QXxzP+6gl8pkoekLE2pM2V
	uB19WKTxSivmLXC6WZP1Q9FNi+0llqHSxMI2UNvU35D+TMuurILMfT+f0acXGZ2giU11qYp4+2P
	FFAgjh1h0Mg==
X-Google-Smtp-Source: AGHT+IFskglkCbBP2dccuwMp69TqvcLrtuGMr8LDxllFiAdkNYZbuU8AMVLBB/y5pjLtirTSTEcBpw==
X-Received: by 2002:a05:600c:5298:b0:453:c39:d0d0 with SMTP id 5b1f17b1804b1-45381ac2c8dmr23911505e9.13.1750848590884;
        Wed, 25 Jun 2025 03:49:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c49fsm16195055e9.7.2025.06.25.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:49:50 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 08/10] Workqueue: fs: WQ_PERCPU added to alloc_workqueue users
Date: Wed, 25 Jun 2025 12:49:32 +0200
Message-ID: <20250625104934.184753-9-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625104934.184753-1-marco.crivellari@suse.com>
References: <20250625104934.184753-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to all the fs subsystem users to
explicitly request the use of the per-CPU behavior. Both flags coexist
for one release cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
---
 fs/afs/main.c                  |  4 ++--
 fs/bcachefs/super.c            | 10 +++++-----
 fs/btrfs/async-thread.c        |  3 +--
 fs/btrfs/disk-io.c             |  2 +-
 fs/ceph/super.c                |  2 +-
 fs/dlm/lowcomms.c              |  2 +-
 fs/dlm/main.c                  |  2 +-
 fs/fs-writeback.c              |  2 +-
 fs/gfs2/main.c                 |  5 +++--
 fs/gfs2/ops_fstype.c           |  6 ++++--
 fs/ocfs2/dlm/dlmdomain.c       |  3 ++-
 fs/ocfs2/dlmfs/dlmfs.c         |  3 ++-
 fs/smb/client/cifsfs.c         | 16 +++++++++++-----
 fs/smb/server/ksmbd_work.c     |  2 +-
 fs/smb/server/transport_rdma.c |  3 ++-
 fs/super.c                     |  3 ++-
 fs/verity/verify.c             |  2 +-
 fs/xfs/xfs_log.c               |  3 +--
 fs/xfs/xfs_mru_cache.c         |  3 ++-
 fs/xfs/xfs_super.c             | 15 ++++++++-------
 20 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/fs/afs/main.c b/fs/afs/main.c
index c845c5daaeba..6b7aab6abd78 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -168,13 +168,13 @@ static int __init afs_init(void)
 
 	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 registering.\n");
 
-	afs_wq = alloc_workqueue("afs", 0, 0);
+	afs_wq = alloc_workqueue("afs", WQ_PERCPU, 0);
 	if (!afs_wq)
 		goto error_afs_wq;
 	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!afs_async_calls)
 		goto error_async;
-	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM, 0);
+	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!afs_lock_manager)
 		goto error_lockmgr;
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index a58edde43bee..8bba5347a36e 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -909,15 +909,15 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 	if (!(c->btree_update_wq = alloc_workqueue("bcachefs",
 				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_UNBOUND, 512)) ||
 	    !(c->btree_io_complete_wq = alloc_workqueue("bcachefs_btree_io",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 1)) ||
+				WQ_HIGHPRI | WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU, 1)) ||
 	    !(c->copygc_wq = alloc_workqueue("bcachefs_copygc",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 1)) ||
+				WQ_HIGHPRI | WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE | WQ_PERCPU, 1)) ||
 	    !(c->btree_read_complete_wq = alloc_workqueue("bcachefs_btree_read_complete",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 512)) ||
+				WQ_HIGHPRI | WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU, 512)) ||
 	    !(c->btree_write_submit_wq = alloc_workqueue("bcachefs_btree_write_sumit",
-				WQ_HIGHPRI|WQ_FREEZABLE|WQ_MEM_RECLAIM, 1)) ||
+				WQ_HIGHPRI | WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU, 1)) ||
 	    !(c->write_ref_wq = alloc_workqueue("bcachefs_write_ref",
-				WQ_FREEZABLE, 0)) ||
+				WQ_FREEZABLE | WQ_PERCPU, 0)) ||
 #ifndef BCH_WRITE_REF_DEBUG
 	    percpu_ref_init(&c->writes, bch2_writes_disabled,
 			    PERCPU_REF_INIT_DEAD, GFP_KERNEL) ||
diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index f3bffe08b290..0a84d86a942d 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -109,8 +109,7 @@ struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
 		ret->thresh = thresh;
 	}
 
-	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
-					 name);
+	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active, name);
 	if (!ret->normal_wq) {
 		kfree(ret);
 		return NULL;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3dd555db3d32..f817b29a43de 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1963,7 +1963,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
 	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
-	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE;
+	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f3951253e393..a0302a004157 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -862,7 +862,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	fsc->inode_wq = alloc_workqueue("ceph-inode", WQ_UNBOUND, 0);
 	if (!fsc->inode_wq)
 		goto fail_client;
-	fsc->cap_wq = alloc_workqueue("ceph-cap", 0, 1);
+	fsc->cap_wq = alloc_workqueue("ceph-cap", WQ_PERCPU, 1);
 	if (!fsc->cap_wq)
 		goto fail_inode_wq;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 70abd4da17a6..6ced1fa90209 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1702,7 +1702,7 @@ static int work_start(void)
 		return -ENOMEM;
 	}
 
-	process_workqueue = alloc_workqueue("dlm_process", WQ_HIGHPRI | WQ_BH, 0);
+	process_workqueue = alloc_workqueue("dlm_process", WQ_HIGHPRI | WQ_BH | WQ_PERCPU, 0);
 	if (!process_workqueue) {
 		log_print("can't start dlm_process");
 		destroy_workqueue(io_workqueue);
diff --git a/fs/dlm/main.c b/fs/dlm/main.c
index 4887c8a05318..a44d16da7187 100644
--- a/fs/dlm/main.c
+++ b/fs/dlm/main.c
@@ -52,7 +52,7 @@ static int __init init_dlm(void)
 	if (error)
 		goto out_user;
 
-	dlm_wq = alloc_workqueue("dlm_wq", 0, 0);
+	dlm_wq = alloc_workqueue("dlm_wq", WQ_PERCPU, 0);
 	if (!dlm_wq) {
 		error = -ENOMEM;
 		goto out_plock;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cf51a265bf27..4b1a53a3266b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1180,7 +1180,7 @@ void cgroup_writeback_umount(struct super_block *sb)
 
 static int __init cgroup_writeback_init(void)
 {
-	isw_wq = alloc_workqueue("inode_switch_wbs", 0, 0);
+	isw_wq = alloc_workqueue("inode_switch_wbs", WQ_PERCPU, 0);
 	if (!isw_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 0727f60ad028..9d65719353fa 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -151,7 +151,8 @@ static int __init init_gfs2_fs(void)
 
 	error = -ENOMEM;
 	gfs2_recovery_wq = alloc_workqueue("gfs2_recovery",
-					  WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+					  WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU,
+					  0);
 	if (!gfs2_recovery_wq)
 		goto fail_wq1;
 
@@ -160,7 +161,7 @@ static int __init init_gfs2_fs(void)
 	if (!gfs2_control_wq)
 		goto fail_wq2;
 
-	gfs2_freeze_wq = alloc_workqueue("gfs2_freeze", 0, 0);
+	gfs2_freeze_wq = alloc_workqueue("gfs2_freeze", WQ_PERCPU, 0);
 
 	if (!gfs2_freeze_wq)
 		goto fail_wq3;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..0dccb5882ef6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1189,13 +1189,15 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = -ENOMEM;
 	sdp->sd_glock_wq = alloc_workqueue("gfs2-glock/%s",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE | WQ_PERCPU,
+			0,
 			sdp->sd_fsname);
 	if (!sdp->sd_glock_wq)
 		goto fail_free;
 
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
-			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
+			WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU, 0,
+			sdp->sd_fsname);
 	if (!sdp->sd_delete_wq)
 		goto fail_glock_wq;
 
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 2018501b2249..2347a50f079b 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -1876,7 +1876,8 @@ static int dlm_join_domain(struct dlm_ctxt *dlm)
 	dlm_debug_init(dlm);
 
 	snprintf(wq_name, O2NM_MAX_NAME_LEN, "dlm_wq-%s", dlm->name);
-	dlm->dlm_worker = alloc_workqueue(wq_name, WQ_MEM_RECLAIM, 0);
+	dlm->dlm_worker = alloc_workqueue(wq_name, WQ_MEM_RECLAIM | WQ_PERCPU,
+					  0);
 	if (!dlm->dlm_worker) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5130ec44e5e1..0b730535b2c8 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -595,7 +595,8 @@ static int __init init_dlmfs_fs(void)
 	}
 	cleanup_inode = 1;
 
-	user_dlm_worker = alloc_workqueue("user_dlm", WQ_MEM_RECLAIM, 0);
+	user_dlm_worker = alloc_workqueue("user_dlm",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!user_dlm_worker) {
 		status = -ENOMEM;
 		goto bail;
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a08c42363ffc..3d3a76fa7210 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1883,7 +1883,9 @@ init_cifs(void)
 		cifs_dbg(VFS, "dir_cache_timeout set to max of 65000 seconds\n");
 	}
 
-	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	cifsiod_wq = alloc_workqueue("cifsiod",
+				     WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+				     0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
 		goto out_clean_proc;
@@ -1911,28 +1913,32 @@ init_cifs(void)
 	}
 
 	cifsoplockd_wq = alloc_workqueue("cifsoplockd",
-					 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					 WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					 0);
 	if (!cifsoplockd_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_fileinfo_put_wq;
 	}
 
 	deferredclose_wq = alloc_workqueue("deferredclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					   0);
 	if (!deferredclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsoplockd_wq;
 	}
 
 	serverclose_wq = alloc_workqueue("serverclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+					   0);
 	if (!serverclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_deferredclose_wq;
 	}
 
 	cfid_put_wq = alloc_workqueue("cfid_put_wq",
-				      WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				      WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
+				      0);
 	if (!cfid_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_serverclose_wq;
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 72b00ca6e455..4a71f46d7020 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -78,7 +78,7 @@ int ksmbd_work_pool_init(void)
 
 int ksmbd_workqueue_init(void)
 {
-	ksmbd_wq = alloc_workqueue("ksmbd-io", 0, 0);
+	ksmbd_wq = alloc_workqueue("ksmbd-io", WQ_PERCPU, 0);
 	if (!ksmbd_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 4998df04ab95..43b7062335fa 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2198,7 +2198,8 @@ int ksmbd_rdma_init(void)
 	 * for lack of credits
 	 */
 	smb_direct_wq = alloc_workqueue("ksmbd-smb_direct-wq",
-					WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+					WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
+					0);
 	if (!smb_direct_wq)
 		return -ENOMEM;
 
diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..0a9af48f30dd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2174,7 +2174,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
 {
 	struct workqueue_struct *old;
 	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
-						      WQ_MEM_RECLAIM, 0,
+						      WQ_MEM_RECLAIM | WQ_PERCPU,
+						      0,
 						      sb->s_id);
 	if (!wq)
 		return -ENOMEM;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..b8f53d1cfd20 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -357,7 +357,7 @@ void __init fsverity_init_workqueue(void)
 	 * latency on ARM64.
 	 */
 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_HIGHPRI,
+						  WQ_HIGHPRI | WQ_PERCPU,
 						  num_online_cpus());
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 6493bdb57351..3fecb066eeb3 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1489,8 +1489,7 @@ xlog_alloc_log(
 	log->l_iclog->ic_prev = prev_iclog;	/* re-write 1st prev ptr */
 
 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM |
-				    WQ_HIGHPRI),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!log->l_ioend_workqueue)
 		goto out_free_iclog;
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index d0f5b403bdbe..152032f68013 100644
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -293,7 +293,8 @@ int
 xfs_mru_cache_init(void)
 {
 	xfs_mru_reap_wq = alloc_workqueue("xfs_mru_cache",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 1);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU),
+			1);
 	if (!xfs_mru_reap_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..38584c5618f4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -565,19 +565,19 @@ xfs_init_mount_workqueues(
 	struct xfs_mount	*mp)
 {
 	mp->m_buf_workqueue = alloc_workqueue("xfs-buf/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			1, mp->m_super->s_id);
 	if (!mp->m_buf_workqueue)
 		goto out;
 
 	mp->m_unwritten_workqueue = alloc_workqueue("xfs-conv/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			0, mp->m_super->s_id);
 	if (!mp->m_reclaim_workqueue)
 		goto out_destroy_unwritten;
@@ -589,13 +589,14 @@ xfs_init_mount_workqueues(
 		goto out_destroy_reclaim;
 
 	mp->m_inodegc_wq = alloc_workqueue("xfs-inodegc/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU),
 			1, mp->m_super->s_id);
 	if (!mp->m_inodegc_wq)
 		goto out_destroy_blockgc;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_PERCPU), 0,
+			mp->m_super->s_id);
 	if (!mp->m_sync_workqueue)
 		goto out_destroy_inodegc;
 
@@ -2499,8 +2500,8 @@ xfs_init_workqueues(void)
 	 * AGs in all the filesystems mounted. Hence use the default large
 	 * max_active value for this workqueue.
 	 */
-	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+	xfs_alloc_wq = alloc_workqueue("xfsalloc", XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_PERCPU),
+			0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
-- 
2.49.0


