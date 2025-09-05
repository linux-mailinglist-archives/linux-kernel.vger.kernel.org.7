Return-Path: <linux-kernel+bounces-802437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B7B4527A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5342A7BB113
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329EC2BDC35;
	Fri,  5 Sep 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZuCCrQDK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDE27FD68
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062952; cv=none; b=SqSY3/UiL46U5XdprVfugxuIHm037kEgQ3NijSBD+soctm/5nQGjleFTpZXKCEQTHqKw5ez6L9ET5o+1L81JUxLXJpRC0C3AtbaIN+piVkB16NhDX7UUP1U0jcudLOcY/nihA7K5LEe7fr8P5BKf3vI5HiaTJjXuSIzkSXCfJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062952; c=relaxed/simple;
	bh=HkVsUxd8i7iuNGh42viXIYRZPf8l9Ki5QLNRoUyrqhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw4ef+s+PV6iBDTrbSeF3lVBWFighfgi3wWJLYSovVsP+k51YX4eMgKj0cqwhe4Md41lMKJcJpmOJYLsKAwwyh6IppR6ffbEWSXmKzKLZxYkn9Ux0fBGj5qbVZyCWeeEBRACkqbrLMBlZgYFND3CA+w0xZu5b/4kvfq6223WvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZuCCrQDK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9853e630so17599565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062948; x=1757667748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmDIFRXAv1xZChIociSBZ0cJ3vqXOut7oWyeaUjJHUk=;
        b=ZuCCrQDK/zZA+BNDojzU1qHF1dD9yqL6T5gzSV61WY+G5sDevhtxhwXUCx9Dx4AgPw
         jMxtkDz0vAk365Ctid6JQTAXSHEwb/S9DgGBWfFlugCqpoaJxetZGlTnDkDOdDNLSzeJ
         MxHVp+AVy+LrNIGV865T8iB1stJeiyYDxynv7Ie6FLY7OpWtISjn1DGAGo1ontBy33wZ
         FmS+LK8NmEZxHmRN20DoeZ6J94SGYUPh7qEQzUryEvzb5NL/bpfDcdMifLvsrukd4fhH
         qqXc6Sv1uRT97cGNRJq5vsxb0EYthpR6JmuFlte2R/YdH+58vfuYxtB4FHcC6mQ7hdgj
         xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062948; x=1757667748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmDIFRXAv1xZChIociSBZ0cJ3vqXOut7oWyeaUjJHUk=;
        b=FU50VRTTbGwCEyoMwQGk42/zFX67byelUzJCW887Dp+JhIaQj+Ah50lzZKG+YifdJh
         KFanM9wkf8QWpouMn7hRK+diSBoLboHonz//sSUiDBI28ZMxPqRF2B9WExW0C2562c37
         eJlRQAqWX6sh8gwdKJXdThzSwjTvG0C+0m2xpTqWCMpmY6nMLEfjKC0sV8HJBDJ2AIbL
         /x85v2aSUpgx617SSFpTpFfVOeZPzf1kZbxyu8aZy7mp4yWLeel0fYejns5/boLLw8aB
         mDY8lXN8G7BCMaofvySeg+Mkly7/cYRgOQ4vhLbz7WnMLpYeK7xQwwvDIEV4kbdv3fTv
         V06A==
X-Gm-Message-State: AOJu0YwEGtgAiJJZg3B7/iHp3iBYMutZOUdMphXoLgz9merQe/uVRdgw
	z0T4/W/nec2tSvMCp+rpEYh7Dlroo5noUghHMbH+LuQiX7/jaObJC9Igjgr3goq/WKUPD9FGfaI
	D+bSX
X-Gm-Gg: ASbGncu0K8/fXovSMoVwiWmIR9ozIVepMKiTrzM7+A/vlMKQivgE8azvWin1H7Ey1y7
	oaeVbjZgBn4yHt6l7hjaSLJnkNK1TvJxPpDTS2bnLsGP1lH3SgNjPC5k1A6b45dxM9whF9A371j
	H4uM5NuqRerXdK55vxxWt85w7e/m0X0i40AG5rOkt/OVIDD5/NM2aVqJ2d9wZkextcE4uez88SH
	4ZnZJoOnHOpFCkvdYmXQ5jOYgdFF32qyJSYfV6qkCneqfGFx0FaNAnZWUezb2Xq/8tvvW2zkn3L
	eSjNSR49I68F3ilz7hP0GnKW88pYc78ueYbrPjcfUSXst3j1dVC+FrI9J4oxr3GVOQU1x5aDSNI
	0uJWu4LeoEAVTp5HwvOfPLb0Hd1qo3BDtX5+nxjU7nZr1bhFDd5yNeS8bUw==
X-Google-Smtp-Source: AGHT+IHqK9NaJpjvHLojOBdvStEYEORJxBDgmmtOnmc5YCVGkSBh2N6whpYmOsTcOykBgPN/mHJ4Gw==
X-Received: by 2002:a05:600c:4f50:b0:45b:9c97:af85 with SMTP id 5b1f17b1804b1-45cb50689admr104022495e9.17.1757062948184;
        Fri, 05 Sep 2025 02:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35324565e9.5.2025.09.05.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:02:27 -0700 (PDT)
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
Subject: [PATCH 2/3] fs: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:02:13 +0200
Message-ID: <20250905090214.102375-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090214.102375-1-marco.crivellari@suse.com>
References: <20250905090214.102375-1-marco.crivellari@suse.com>
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
2.51.0


