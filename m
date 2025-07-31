Return-Path: <linux-kernel+bounces-752063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E1B170ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A7D17707C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3348223DED;
	Thu, 31 Jul 2025 12:15:56 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44110C120
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964156; cv=none; b=brZysY4EGnwU1nFWFCmdmIcqtGWkBlTKOp7DUMJGD6zTE/sh8nxA+qPw/GKS44vE0qRGXi/ljFsLBXryULDbK7stu0dvc4g0B9LgueghBi+MLE/K4MmqyJE9hVVyYtzmTn1FVsfJ3q65wh4IiuVH1qYucd7pW2zhycGgxrpkrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964156; c=relaxed/simple;
	bh=/AlRXjyWbfEosjXA+W7RlO/tBXADFQ5LZY68630rcVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TmcQNnEji/UJu+F8ALCJHtNL3NB8JzXQGHcPEARe6zBECP3pRGtukvwV0z39fTojLYtyAV1oKMSMIzGvnxD5ygsaeq18V9jSwn0HYWiUXYprp+ucikNET37hfABvGgHLhzrbwpuAu7X3oVLryUR4PhiFn0lgjtaAAuM16mj5X3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] sched/cputime: Simplify seq retry logic in thread_group_cputime()
Date: Thu, 31 Jul 2025 20:15:06 +0800
Message-ID: <20250731121506.6423-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The new logic maintains equivalent functionality but streamlines the code:
  1. First iteration: seq becomes 2 (even -> lockless path)
  2. Contended iterations: seq becomes odd -> locked path
Eliminates redundant state tracking variables

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/cputime.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2..7eeff8d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -315,7 +315,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	struct signal_struct *sig = tsk->signal;
 	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
+	unsigned int seq = 1;
 	unsigned long flags;
 
 	/*
@@ -330,10 +330,8 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 		(void) task_sched_runtime(current);
 
 	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
 	do {
-		seq = nextseq;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 		times->utime = sig->utime;
 		times->stime = sig->stime;
@@ -345,8 +343,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 			times->stime += stime;
 			times->sum_exec_runtime += read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq = 1;
 	} while (need_seqretry(&sig->stats_lock, seq));
 	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 	rcu_read_unlock();
-- 
2.9.4


