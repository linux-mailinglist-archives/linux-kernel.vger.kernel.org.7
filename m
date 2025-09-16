Return-Path: <linux-kernel+bounces-818367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17797B590A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75B21BC55A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64182EC541;
	Tue, 16 Sep 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gLU0A4oT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873C2EC093
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011383; cv=none; b=KPP2YX1wx1PJpzHf2CjkditKbnWZeXKPvA5nua1tyqrNKpc16RFdVaQNPwednYkgseVEhOJ8C5MELwc4TidFcmrzLjeJsHsF5BPqvBfpTo03RrdyNfuaTrZ15+Y83xTBpqg0PzAKxWkaPeLTZ4NObtBzpugX5r2Sb9OLNKKJXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011383; c=relaxed/simple;
	bh=/i+TGxphlbcwtQ06iusDU6Wu8PnYL1IFwfBvQeHM9/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieXCIJZnPUeNeLAaO/VjKXESF214X1+2fgQiA8ZoMMBtvPcy4bVOn9KA6DHxeo2TYrm8wr9vmiAAu/PUghEQFKwK3BkxSFEIVFamhDe+Ikcb7+mbLI+zijA7Ss+2I/6dZf+onyYNTuMhzbkDBgiNd4WZWFkp6Jb4zFMWpuzxAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gLU0A4oT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e9042021faso1808915f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758011379; x=1758616179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBilMR31EpsMq6XriB2xtLqKoFrteD6oJai1ocFwypA=;
        b=gLU0A4oTioaddwUTo8FFda9LTV0uH2x+/xXf1vwFrS4EOElyA03Si0bpB0xpcRrrIG
         3hsdauoXd1+P7fJnFG1x/H8iBpxnWCF80UtwY8p4Sf3wcaqCYOR0sh6VZj5jH0Urr05y
         w3jgiMWmPpdbV3rgFr0A/RvwP1foQFhBcyH49C3stnD0vI+/soM4ivH261HRwtMEOnmm
         47MhuhoqXazbpMfbMKjr8aoV9nTc3zJJOj+7o7s+XcaeOiFUbMkPXVEKkrccxiDE6pI4
         nbwto4lHlGJVLXAXbgMon0OHavzzndtEV2jiWIA0eyfnh1gixEd3m0VLiWiQQs8hd30n
         El8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758011379; x=1758616179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBilMR31EpsMq6XriB2xtLqKoFrteD6oJai1ocFwypA=;
        b=YlD0vgiJKCmGnEtWDI+nDd9SLkpdmHfnD7o5UatyXVGk9iwh+NkFW6F59rTpT1pPwa
         dBtge0CqdO6uVi+3XwVYdWbVLWeCNroPuUMDlKZHxduxVCrlyRZ/OD0dc1SZhbFyUdea
         qHSKawZZ1RcCFWZy/sphzhVUMNTxVTGKAEm6G51aUQlUYyodBvidrb01YJ2JnRKHadt+
         fK1NF7dJRB3GEDzl4TR8cbTDCvcSf4vFudvXKe7nuhNcr42jr/70wGflfGhBPj6LDviu
         w1k5A4U3c6KMBLibn0RagXoTtQNF5G3TQodzPuUjMYe8AxCHeBd4oEQi5ZiprG0JbXDc
         Zwiw==
X-Gm-Message-State: AOJu0Ywb8SADEF2aBIa9/Vsoh18U3jfcm+1Pjs+QwIc00TO4SOU9FGlX
	Htk/KFYeYkp3xMvuW+IHv/X8hFDSNLK6PMiE/4qMjUSslghd0JVLykolT4m4UmPSmXjv77hUDib
	0xNWLyRo=
X-Gm-Gg: ASbGncu1kw0/1rKCJuELVTMmnTb2qx12sxrvBeB99bA3gRxhQRzny3bGIsNVgYK+ClP
	1HJGAaVwy6l1SbW2Vu3nbkz6hYsID3dj1yvEjrKHbR7F9WXk2H28DR27DUN5ReqM41W4HP+Hmc1
	uASOM8mwsN2uihBkU/gIgDuJ3OwAmbSEh2fG0FcmklBNMXXawuPH562VV1q+RGLoybcrePAYU5K
	th9JmweSSnbs5RjwIc5+5FStvBao3wQVL3FHsHUuoK10etY38xP4sKaqLAGoCUA9pZ/BnHu0757
	X4uqdhorLm5tNFs/Fh3kpTEM92S17YW9p/+oQ4zsh5KV7eFbgJCGEjEwf+mh2UCPOE2ucodBtS+
	vJYl6fODSW0EgEvqZSLfMkHP68kdC14ZOwtgVRjJJD1iS1gI=
X-Google-Smtp-Source: AGHT+IECcPkK/uCDcwuj6Jp8VaNKrf3F0LNpSEAIH7H9DBNggSNoOwxQSChtkKRsK7+vN0Ie0bYeOA==
X-Received: by 2002:a05:6000:25c8:b0:3ea:dd2b:5dc with SMTP id ffacd0b85a97d-3eadd2b09f0mr5198924f8f.14.1758011378538;
        Tue, 16 Sep 2025 01:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm11006125f8f.32.2025.09.16.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:29:38 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 2/3] fs: replace use of system_wq with system_percpu_wq
Date: Tue, 16 Sep 2025 10:29:05 +0200
Message-ID: <20250916082906.77439-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916082906.77439-1-marco.crivellari@suse.com>
References: <20250916082906.77439-1-marco.crivellari@suse.com>
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
index 7fc7b6221312..6002617f078c 100644
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
index a07b8cf73ae2..21aaed728929 100644
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
index e80cd8f2c049..8520eb94c527 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -119,7 +119,7 @@ void fuse_check_timeout(struct work_struct *work)
 	    goto abort_conn;
 
 out:
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..1e044c4f4a00 100644
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
index 7f1ec9c67ff2..f9a3a1fbf44c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -335,7 +335,7 @@ static int param_set_nfs_timeout(const char *val, const struct kernel_param *kp)
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
2.51.0


