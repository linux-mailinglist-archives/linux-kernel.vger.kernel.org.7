Return-Path: <linux-kernel+bounces-751381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267CB168ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622387B4A34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1022B595;
	Wed, 30 Jul 2025 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0UkmTIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3D132103
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913520; cv=none; b=hMMDW8aYpl8kx0bW55zC2YPRGYqrl1IbDiUzC2rOxiwlP29M/OfDA47arVb+Gcf6T+Hk318J2RgGM7P7DR/wQUASJyPoZLw0yT7W60CUpqY5tPvk1lzZcYBdQ7c3UwhXaSyVgC66q7MJQmVZPZVmcbE+naLqoMv34EA8mjunFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913520; c=relaxed/simple;
	bh=yYOA1pLmN0sVFxakiTkblQuK9ECzy3Zjk+AwR/ykPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TB9MyX6k1ZnS51ACPyXbTHkiTTtDE+DG7Ut692bJhHC7MZGOZdX3m7yq93lziEGuGwCEKorcLFK4uF4n8wAraC55MjWGGirPHSIPW7MBYzU2MuJuBZCwauaaZ5y3KNae2P/mNS4/DVWjoZ3o7v6ZOYXQJDvxUhpQPuJtvTqg7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0UkmTIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E55C4CEE3;
	Wed, 30 Jul 2025 22:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753913520;
	bh=yYOA1pLmN0sVFxakiTkblQuK9ECzy3Zjk+AwR/ykPeI=;
	h=From:To:Cc:Subject:Date:From;
	b=q0UkmTIuQRR3zMRPfIaEcB9MJHEPRVT8UFC4HTfnL2LszqZqdlRdQGl2smuAMF9hV
	 t4pEYv3GgkTrDZ5miSCGv0B6/rEGdoGMJIEiCSW7n3bWnUWM27x5KC3OqP05ic7pSu
	 Cv3IHnBa+cEMwie445Rw5qzBcXpmoIa/2IqQ6ZoBgnYOOvPTlwJw/J5+4mKX788CPq
	 M14nL3t1CY+Q27Raje2205TchR27RZXeK6nsEWRep1KNgkKaBgNf/OJyriTf5Nu5IC
	 UjLxB3gmWZwsxDPl3lAaTV6VemFobSm6H941rEn8VZek6kCzKALjpdYhsssTfkle37
	 azLHeMp63UJwg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Lance Yang <ioworker0@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yongliang Gao <leonylgao@tencent.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hung_task: Dump blocker task if it is not hung
Date: Thu, 31 Jul 2025 07:11:54 +0900
Message-ID: <175391351423.688839.11917911323784986774.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Dump the lock blocker task if it is not hung because if the blocker
task is also hung, it should be dumped by the detector. This will
de-duplicate the same stackdumps if the blocker task is also blocked
by another task (and hung).

Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Lance Yang <lance.yang@linux.dev>
---
 Changes in v2:
  - Rebase on next-20250730
  - Merge task state checks.
  - Add Lance's ack.
---
 kernel/hung_task.c |   78 +++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..b2c1f14b8129 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -95,9 +95,41 @@ static struct notifier_block panic_block = {
 	.notifier_call = hung_task_panic,
 };
 
+static bool task_is_hung(struct task_struct *t, unsigned long timeout)
+{
+	unsigned long switch_count = t->nvcsw + t->nivcsw;
+	unsigned int state = READ_ONCE(t->__state);
+
+	/*
+	 * skip the TASK_KILLABLE tasks -- these can be killed
+	 * skip the TASK_IDLE tasks -- those are genuinely idle
+	 * skip the TASK_FROZEN task -- it reasonably stops scheduling by freezer
+	 */
+	if (!(state & TASK_UNINTERRUPTIBLE) ||
+	    (state & (TASK_WAKEKILL | TASK_NOLOAD | TASK_FROZEN)))
+		return false;
+
+	/*
+	 * When a freshly created task is scheduled once, changes its state to
+	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
+	 * musn't be checked.
+	 */
+	if (unlikely(!switch_count))
+		return false;
+
+	if (switch_count != t->last_switch_count) {
+		t->last_switch_count = switch_count;
+		t->last_switch_time = jiffies;
+		return false;
+	}
+	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+		return false;
+
+	return true;
+}
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-static void debug_show_blocker(struct task_struct *task)
+static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 {
 	struct task_struct *g, *t;
 	unsigned long owner, blocker, blocker_type;
@@ -174,41 +206,21 @@ static void debug_show_blocker(struct task_struct *task)
 			       t->pid, rwsem_blocked_by);
 			break;
 		}
-		sched_show_task(t);
+		/* Avoid duplicated task dump, skip if the task is also hung. */
+		if (!task_is_hung(t, timeout))
+			sched_show_task(t);
 		return;
 	}
 }
 #else
-static inline void debug_show_blocker(struct task_struct *task)
+static inline void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 {
 }
 #endif
 
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
-	unsigned long switch_count = t->nvcsw + t->nivcsw;
-
-	/*
-	 * Ensure the task is not frozen.
-	 * Also, skip vfork and any other user process that freezer should skip.
-	 */
-	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
-		return;
-
-	/*
-	 * When a freshly created task is scheduled once, changes its state to
-	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
-	 * musn't be checked.
-	 */
-	if (unlikely(!switch_count))
-		return;
-
-	if (switch_count != t->last_switch_count) {
-		t->last_switch_count = switch_count;
-		t->last_switch_time = jiffies;
-		return;
-	}
-	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+	if (!task_is_hung(t, timeout))
 		return;
 
 	/*
@@ -243,7 +255,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
-		debug_show_blocker(t);
+		debug_show_blocker(t, timeout);
 		hung_task_show_lock = true;
 
 		if (sysctl_hung_task_all_cpu_backtrace)
@@ -299,7 +311,6 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		unsigned int state;
 
 		if (!max_count--)
 			goto unlock;
@@ -308,15 +319,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
-		/*
-		 * skip the TASK_KILLABLE tasks -- these can be killed
-		 * skip the TASK_IDLE tasks -- those are genuinely idle
-		 */
-		state = READ_ONCE(t->__state);
-		if ((state & TASK_UNINTERRUPTIBLE) &&
-		    !(state & TASK_WAKEKILL) &&
-		    !(state & TASK_NOLOAD))
-			check_hung_task(t, timeout);
+
+		check_hung_task(t, timeout);
 	}
  unlock:
 	rcu_read_unlock();


