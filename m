Return-Path: <linux-kernel+bounces-841487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0024BB77F9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D50E4ED99D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0529E11A;
	Fri,  3 Oct 2025 16:12:48 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514514A8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507967; cv=none; b=lu0gX85UxriK9P+HioLJ81p7pIgwnv3fM9Njz5fe5opn4o1HyT8hVNXj4L4uvkleQFFVHArHwmepg4z3t9UY8AobTHYehJ22Ip/wgzjH+ijK1i8MFpyk9MKmCaNMU4Vd7fWb2mo8oehbF6jf69dkHfJOSGKUMfldo9airUpgEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507967; c=relaxed/simple;
	bh=q9ExXmkuFaHhZqkZkGv2wZ/F5DBUYLBWd1H70gVQuWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QPbum6zvTMdY8RkvHw7L5xoe9vOFy6xqQIpo0KbNVvwv6JBRaEFq0mXAIf78OzTi9Jr4lpX/uPZfDM94jdMSrDOT+3D2AF2JPt6DxmzyykbIWUohWfERWsoyaewBr9OSaxkEvve68U8VZ5gE2AdVMaavyleesIA6g3kfpiQ6i8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 24DAF11AF30;
	Fri,  3 Oct 2025 16:12:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 8E4F220013;
	Fri,  3 Oct 2025 16:12:39 +0000 (UTC)
Date: Fri, 3 Oct 2025 12:14:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Waiman Long <longman@redhat.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Michal
 =?UTF-8?B?S291dG7DvQ==?=" <mkoutny@suse.com>, Andrea Righi
 <righi.andrea@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>, Joseph Salisbury
 <joseph.salisbury@oracle.com>
Subject: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <20251003121421.0cf4372d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1gqkuc8oibgawwgbyqbnybxoqddp3oyk
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8E4F220013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/znqxXtSnlvTkyKAZ74lLfh53Xu+u9HME=
X-HE-Tag: 1759507959-517395
X-HE-Meta: U2FsdGVkX18BS2BcHVmqQuYwMn/VkFiumXonfGyDwWLmhMIm7KUc0XDJUa5F2ZKRSzfW9543djMMXKvSF9d7Wr9esq3B+Qm8ShErZAvbdjKiNlcGsQ5cyHpz8gX5+FlWdsW4RGzKJd4bD97NNBPdkE/s2syZXxNH8QTtvR6V6HjEyd7yGTPCKWQ/gkRWv807rCqlV5Yw2cjIdktVZ5EVRxUcpIS95TFZS4wouBAKj+fj9uxmNBm9uUDjWr10kmmNpQzclKVAVELQd/LAdOIFH8ESAxEaXuWuqw3r5/T9NjuTgTkRe0M0eUw8RjpNSuJYax6fFkVdjmX1gAHNrK6gAEWwOKrB3AQb2QACDxAxOgUyo8svBQBe1IWkkbjC9v2H

From: Steven Rostedt <rostedt@goodmis.org>

At our monthly stable meeting, we were talking about documenting non
static functions and randomly picked a function to look at. That was
task_can_attach(). It was then noticed that it's only used by
cgroup/cpuset.c and nothing else. It's a simple function that doesn't
reference anything unique to sched/core.c, hence there's no reason that
function should be there.

Move it to cgroup/cpuset.c as that's the only place it is used. Also make
it a static inline as it is so small.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h  |  1 -
 kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
 kernel/sched/core.c    | 19 -------------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4ce0a76831e..4ee4fa973eda 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1849,7 +1849,6 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..21fe872803e8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3009,6 +3009,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
 	cs->sum_migrate_dl_bw = 0;
 }
 
+static inline int task_can_attach(struct task_struct *p)
+{
+	int ret = 0;
+
+	/*
+	 * Kthreads which disallow setaffinity shouldn't be moved
+	 * to a new cpuset; we don't want to change their CPU
+	 * affinity and isolating such threads by their set of
+	 * allowed nodes is unnecessary.  Thus, cpusets are not
+	 * applicable for such threads.  This prevents checking for
+	 * success of set_cpus_allowed_ptr() on all attached tasks
+	 * before cpus_mask may be changed.
+	 */
+	if (p->flags & PF_NO_SETAFFINITY)
+		ret = -EINVAL;
+
+	return ret;
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..a195c4b25475 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8070,25 +8070,6 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p)
-{
-	int ret = 0;
-
-	/*
-	 * Kthreads which disallow setaffinity shouldn't be moved
-	 * to a new cpuset; we don't want to change their CPU
-	 * affinity and isolating such threads by their set of
-	 * allowed nodes is unnecessary.  Thus, cpusets are not
-	 * applicable for such threads.  This prevents checking for
-	 * success of set_cpus_allowed_ptr() on all attached tasks
-	 * before cpus_mask may be changed.
-	 */
-	if (p->flags & PF_NO_SETAFFINITY)
-		ret = -EINVAL;
-
-	return ret;
-}
-
 bool sched_smp_initialized __read_mostly;
 
 #ifdef CONFIG_NUMA_BALANCING
-- 
2.50.1


