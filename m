Return-Path: <linux-kernel+bounces-800198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C6B43477
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696F81C80D68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620692BEC2D;
	Thu,  4 Sep 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EehghjjK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1132BDC1E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971942; cv=none; b=i1Xz3YbG2u4m3VbhWKzlBSohh1jNKAQRfn8fj7v2bLfSo7wLGl9OgCJ2zzMEG8iR/QuVs9SMSU9MsSxn2BDasEn4kD4dmGcprMAb2DYRL5ygjwUWHZclZUoEbv45ZPq+K//0sxaulDk5wsv1OpknUkAOd3RxB4a5nDznoqblh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971942; c=relaxed/simple;
	bh=wGsiIfQUQg/WTtwMSkaRvIdISfO5jt8VkPbxNhDPvTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbcIwwNB8Ra/werFxe3ZjMYSNiudh0dcqO2dGdKjQrM/i1UCpjzIL2l1E8kJcymaujtPAQ+XFRzwcYTbczyhQRgzVXDsj0UMh7X3tmY8CiSSqNUaXjrKnnoLBuREEzYLH0aioECb2hYPXl/HEBlKI6rWhV2KsTzU8RRsgqrE6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EehghjjK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24c786130feso7361575ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756971940; x=1757576740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuolykUobTjBETf08U7gHpnXoxj2AwzfcmjE5XBVCYE=;
        b=EehghjjKij+gVjUuQZ0Bvt3HLFjxT9qXSAQijsrsUdUCEj0oK0yERnXqpL6sFCBgoo
         mr15VpbnbCNbMEi6hc3xjf7oQwr2/JZZmXMWi7OUO9vML0OmfTy9ZeaKotqAzZM/xuG/
         EXBy4BR0CT0CK//5MyXKa3Hfl+yq4JgfisDRGw7QMcsiMD2goW2USqn4KGWlb/drnu1b
         6kuv2myv1B67aKpYgMw8CkiPeK0mLJqYfDux4EDYEdVyVBvitkA7B/0kmKLhajE0hQLQ
         2y3YcAdusgzrjVb8ezZ5hzDiiJI6strI7gmR7HaXDcyOHLyo7gHRp2UnCysBD2T0uuG7
         EEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971940; x=1757576740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuolykUobTjBETf08U7gHpnXoxj2AwzfcmjE5XBVCYE=;
        b=uBAKX1W8KkW/dRzorlGsYN5EdbgUeskKsatwdhkxtNkV30uMVJFaADl5Hg/y+1QSZu
         Ci12uOQtj2m2N4MXGiP5Zc+LVBS83w6oY2F60aqtiPsLoHrRi0WeBEtwXZhBr9OVWCJs
         hOpiBkTFYPgluFjhUJ0hOBdgdR8/z2SzAjTRHtJpBBfM8OiNj5IcsFgmAUBT7uzV9moJ
         5hJgJHSz59bP1Whja3Z+gyc2O692Zq9F0hfKHtjvKDjuqH3saQsK3bt2mHWljb0qMCXI
         1Plz1W2B+HLbKQFnnh0aPdbtVAzWmMQG5enyg8H24Iy9CMwvgh6JPqGt0/r5LDvlZ3kd
         J+SQ==
X-Gm-Message-State: AOJu0Yy3rUG50ACOuGNg5uH/U0mCRjXvSa93OK24YqDtifoCT4decix+
	h4pzQ89URwMGmrzg4K08lTBGmdst7ANLikXRrlVxukIkoKhtspzR3/oKITmujqU1f0o=
X-Gm-Gg: ASbGncsQgeAq/8Af6EQ7sDvqmfHixFB3BejJx9QCi+wAFLb+oWYvP2uY3jfdw1vDpwI
	/0wFTQIt4Tl63lXW2BEcs4YrdMSs9ySS5nfIpuuvWiS5ECzM+AsfBHu7R8zPKnEM1lCC5/OjWsj
	C2HOAEReXz8g4nYhf0Fz0bTE9FuhI+wU72KLTXLKV0nR7IyCbDv0CA42IHp74V4lbX+eMUPQbxD
	javCy5MnRGKy6vV1HY986Dbfo37gKO+1YfPXTg+MDX2aB+AWdqKTCZY6fcd3+SbkRXPcIUam+xR
	f2q3fUzFuUUOB9PlnKzWWj9IFck5mva+bpunYPvTUSytGjTgmakDMqhaslNxn4I7rTU03KqksiI
	EbJxCni6AHp+dYuLMzQK4qxT5N/lyXWwXdwWWDv0HHDY15nzxc3fu/edJOg==
X-Google-Smtp-Source: AGHT+IF4ZwJuiduG/I5ADuH4RiaVQvKpQU8gkjMtOHHk6LOoWCigeGRGz1bm7CC17uoFh4QFPVXteQ==
X-Received: by 2002:a17:903:298f:b0:24c:9c29:c9d1 with SMTP id d9443c01a7336-24c9c29cca0mr64320275ad.59.1756971940245;
        Thu, 04 Sep 2025 00:45:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f7492d8sm63504395ad.129.2025.09.04.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:45:40 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 2/3] cpuset: Defer flushing of the cpuset_migrate_mm_wq to task_work
Date: Thu,  4 Sep 2025 15:45:04 +0800
Message-Id: <20250904074505.1722678-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now in cpuset_attach(), we need to synchronously wait for
flush_workqueue to complete. The execution time of flushing
cpuset_migrate_mm_wq depends on the amount of mm migration initiated by
cpusets at that time. When the cpuset.mems of a cgroup occupying a large
amount of memory is modified, it may trigger extensive mm migration,
causing cpuset_attach() to block on flush_workqueue for an extended period.
This could be dangerous because cpuset_attach() is within the critical
section of cgroup_mutex, which may ultimately cause all cgroup-related
operations in the system to be blocked.

This patch attempts to defer the flush_workqueue() operation until
returning to userspace using the task_work which is originally proposed by
tejun[1], so that flush happens after cgroup_mutex is dropped. That way we
maintain the operation synchronicity while avoiding bothering anyone else.

[1]: https://lore.kernel.org/cgroups/ZgMFPMjZRZCsq9Q-@slm.duckdns.org/T/#m117f606fa24f66f0823a60f211b36f24bd9e1883

Originally-by: tejun heo <tj@kernel.org>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/cgroup/cpuset.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3d8492581c8c4..ceb467079e41f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -40,6 +40,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/task_work.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -2582,9 +2583,24 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
 	}
 }
 
-static void cpuset_post_attach(void)
+static void flush_migrate_mm_task_workfn(struct callback_head *head)
 {
 	flush_workqueue(cpuset_migrate_mm_wq);
+	kfree(head);
+}
+
+static void schedule_flush_migrate_mm(void)
+{
+	struct callback_head *flush_cb;
+
+	flush_cb = kzalloc(sizeof(struct callback_head), GFP_KERNEL);
+	if (!flush_cb)
+		return;
+
+	init_task_work(flush_cb, flush_migrate_mm_task_workfn);
+
+	if (task_work_add(current, flush_cb, TWA_RESUME))
+		kfree(flush_cb);
 }
 
 /*
@@ -3141,6 +3157,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
 	bool cpus_updated, mems_updated;
+	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
@@ -3191,15 +3208,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 			 * @old_mems_allowed is the right nodesets that we
 			 * migrate mm from.
 			 */
-			if (is_memory_migrate(cs))
+			if (is_memory_migrate(cs)) {
 				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
 						  &cpuset_attach_nodemask_to);
-			else
+				queue_task_work = true;
+			} else
 				mmput(mm);
 		}
 	}
 
 out:
+	if (queue_task_work)
+		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
 	if (cs->nr_migrate_dl_tasks) {
@@ -3257,7 +3277,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	if (of_cft(of)->private == FILE_MEMLIST)
-		flush_workqueue(cpuset_migrate_mm_wq);
+		schedule_flush_migrate_mm();
 	return retval ?: nbytes;
 }
 
@@ -3725,7 +3745,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.can_attach	= cpuset_can_attach,
 	.cancel_attach	= cpuset_cancel_attach,
 	.attach		= cpuset_attach,
-	.post_attach	= cpuset_post_attach,
 	.bind		= cpuset_bind,
 	.can_fork	= cpuset_can_fork,
 	.cancel_fork	= cpuset_cancel_fork,
-- 
2.20.1


