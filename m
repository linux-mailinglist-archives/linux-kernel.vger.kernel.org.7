Return-Path: <linux-kernel+bounces-770650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6422DB27D79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F6DAA695F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6421FF47;
	Fri, 15 Aug 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PECbCfN1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A01EBA14
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251250; cv=none; b=rfpwR8VgVcHN2LaO6dZKWUV6nHeSLe09umzV0x0qDhAe46/XH+aaZremTRJYlNu8YXI6+9w4KUxT1LlUb0bN2+Z6kIXAglTmymcYTHTgJxRVvhFwClC2wKR92Kc1mlj+qhgOhFTVF3tyFOE8q/Cdy8lk+Ysp5Ee9w3U1AQafSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251250; c=relaxed/simple;
	bh=lTQ5tpiaUIBr6tU7mj0dwA/6Z4MoV1fHePe29ZV8Y5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYOYzAE2JfB8Rn9/MEz0zRNj1Usiqs0AdfMzQq4qDlHtKpoSb1fXNbWCk11V2wggA8ET1oJLObFmvO2e3iYetLIHHDRtn/9QrWrvN+ekw8iL5AqIpUDVSM+Li+4RM6zzOO7mpE/GgPcrEs2bnpaMxVQSX9LdLyTEFewm7ZRYLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PECbCfN1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so12325315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251247; x=1755856047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivrbru2LNxSs8CTXNjbMj9DkY8mGo4uquvi8+ow7/88=;
        b=PECbCfN15pXN7Yg+fS1aAdCgB7Agq0bk5ZiT8YpcqOq5LMdYOp1dHoVTVjMKyBVDqQ
         9TTz8k2fUjrOcLDFC9OBWPCyA4hRmZKo56xnjdjR46g8+CdltlpJdVAY3OuJpdlPykbK
         CnXi7QQGeVM2FGxD8L/2LKtG/sWpEH6OUdR2JLd/jdmYKzP4cID3wAzfM9XjEmp4UhRW
         fGkgD5RfLS6gBAhNTJCIFIykxOlbWKAn7c2PbXxEvkcU06dZRiC738+whU5dSuJNeq1m
         JsmTwi+/k7rPdKio0lK5R79etgvWmyL5D5Q//VsnX+G5jnUNwUZ6yBCuB31c6w4cDLqT
         zeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251247; x=1755856047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivrbru2LNxSs8CTXNjbMj9DkY8mGo4uquvi8+ow7/88=;
        b=SpKg3WvFv2gsxUdJPVSlHl5d4aHdcvQWUiIT0marstkOPwotM3HKjJ+oqlj3N8IuCn
         H6keIMKkyVsb+R9Slw9+r5+JH98CX842BuOnma2giuCrGaHbFmEbwaN8dHpsVq+aTcox
         UONeJGhEWCtptDcGZDS+GHQc87KGAjCmxfKeGVPDn/R0XszTan1Pn7O7ARJRUYsaung+
         EAkZ5/4xwuyMaKCL+31BqNxHJy51GeGkFZxwI8kSXZ79waKQan5p9ZKGV8S+kTOApXUZ
         9sOqMY3lalHE/fOFxBl47Qu5YRx3w9zVfsPwqAyTYOu+zJQTgY1ifWyU1Rek3hsdqBfV
         lY4Q==
X-Gm-Message-State: AOJu0YzcLhDKXj2GCwMjRtkR3IOJmsjM2QR8e/z2BA62DCdxXbbo2ByH
	4/lE/GZPMFEcTxQFNQkhmxkP979kR0MKEcyy/VxkguqRqdgf1VzRog60+9E4RSb/ZUKRarJVfyk
	nGfzg
X-Gm-Gg: ASbGncvE8kp6gApsawvjEiJORQTlECB4YyzTCJ7gc1w0T8ugGbaHJqB8nMUaI64JhRX
	PuzSjxFVIw/jP8FSNYLqnrCL8H5CB7GHuC//pNa51RQbfuvjFVqsrZLEQfBrG4Ql5yn36+IstC0
	K/JA033MUOgVUMakmtgbm4Zg2WB6dcK0DiobdHKZ+JO+bOrpi1wX9SkHKsT3WPXbyJilVtrbyDF
	b/3QeDzR2tmlnKwViyb2TQs49n0IbR4xevGFQQm86jCR3PQ5WXgrYnUO14n/LrxnZiHDT88QdsO
	h6xMRhvCejZyC5s+cmt8FwUzPYPeBvk6XtmbWNTU4QrqlsNFKiZLYOUvLS/LQ8Tt+Q4o6BlQ3RA
	UugBFNnf8oy1kS8DTk3b+yI9pcA6F6S7R+2m/pK8azfDZeQ==
X-Google-Smtp-Source: AGHT+IEWWcyeWf2RawrfispWFJ4ayT853diB9diyYZjKJIx+rPP6kPEBfuT4cX+69xNA9OsBoXwvGQ==
X-Received: by 2002:a05:600c:a43:b0:459:a1c7:99ad with SMTP id 5b1f17b1804b1-45a21839edbmr12813255e9.22.1755251246585;
        Fri, 15 Aug 2025 02:47:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a209c25a1sm23241755e9.22.2025.08.15.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:47:25 -0700 (PDT)
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
Subject: [PATCH 1/2] Workqueue: fs: replace use of system_wq with system_percpu_wq
Date: Fri, 15 Aug 2025 11:47:14 +0200
Message-ID: <20250815094715.54121-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815094715.54121-1-marco.crivellari@suse.com>
References: <20250815094715.54121-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users.
Make it clear by adding a system_percpu_wq to all the fs subsystem.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/aio.c            | 2 +-
 fs/fs-writeback.c   | 2 +-
 fs/fuse/dev.c       | 2 +-
 fs/fuse/inode.c     | 2 +-
 fs/nfs/namespace.c  | 2 +-
 fs/nfs/nfs4renewd.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7b976b564cfc..747e9b5bba23 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -636,7 +636,7 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 
 	/* Synchronize against RCU protected table->table[] dereferences */
 	INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
-	queue_rcu_work(system_wq, &ctx->free_rwork);
+	queue_rcu_work(system_percpu_wq, &ctx->free_rwork);
 }
 
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..cf51a265bf27 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2442,7 +2442,7 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write)
-		mod_delayed_work(system_wq, &dirtytime_work, 0);
+		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
 	return ret;
 }
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6dcbaa218b7a..64b623471a09 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -118,7 +118,7 @@ void fuse_check_timeout(struct work_struct *work)
 	    goto abort_conn;
 
 out:
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..6a608ea77d09 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1268,7 +1268,7 @@ static void set_request_timeout(struct fuse_conn *fc, unsigned int timeout)
 {
 	fc->timeout.req_timeout = secs_to_jiffies(timeout);
 	INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 }
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 973aed9cc5fe..0689369c8a63 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -336,7 +336,7 @@ static int param_set_nfs_timeout(const char *val, const struct kernel_param *kp)
 			num *= HZ;
 		*((int *)kp->arg) = num;
 		if (!list_empty(&nfs_automount_list))
-			mod_delayed_work(system_wq, &nfs_automount_task, num);
+			mod_delayed_work(system_percpu_wq, &nfs_automount_task, num);
 	} else {
 		*((int *)kp->arg) = -1*HZ;
 		cancel_delayed_work(&nfs_automount_task);
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index db3811af0796..18ae614e5a6c 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -122,7 +122,7 @@ nfs4_schedule_state_renewal(struct nfs_client *clp)
 		timeout = 5 * HZ;
 	dprintk("%s: requeueing work. Lease period = %ld\n",
 			__func__, (timeout + HZ - 1) / HZ);
-	mod_delayed_work(system_wq, &clp->cl_renewd, timeout);
+	mod_delayed_work(system_percpu_wq, &clp->cl_renewd, timeout);
 	set_bit(NFS_CS_RENEWD, &clp->cl_res_state);
 	spin_unlock(&clp->cl_lock);
 }
-- 
2.50.1


