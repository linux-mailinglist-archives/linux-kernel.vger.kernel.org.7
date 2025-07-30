Return-Path: <linux-kernel+bounces-750524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39005B15D75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5F54E518D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400D291880;
	Wed, 30 Jul 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMQK3fqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4328469A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869228; cv=none; b=d6po4slfz2xIleewxjGzsnmGeH2+1V1tzjqpoaVLEUw2pzOsk3AMHUvOA88GSCX2MjWL/pNGPpdMRAJVy2wMcpOMZ/u8cb6QZOqTzIUOGj/MnzjZdkmS7AAYOmbklrSWvC2pyl39OeHU66vW7F8k1+hmgMYVwFYb8adMrayj9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869228; c=relaxed/simple;
	bh=CPQCteMb+OreyhViUgGbTgR10hVoo52HYT4Bi7mtTfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t01+xMBD5bhwN794nV+asiln5NermdNNdvw00Okoewwogn4lUPwZZBIqoN1bNl6ZhBJCyivt8W1H9SxqPyFjDJeRhXCA18r0shhG5gRrR8Fo80YyH8pj7xiSj5Na9UxaxqMD4K5wtO/OmSnVk/PxSytS3w8ARgvvXcg5n32eNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMQK3fqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67E0C4CEF9;
	Wed, 30 Jul 2025 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753869228;
	bh=CPQCteMb+OreyhViUgGbTgR10hVoo52HYT4Bi7mtTfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMQK3fqiwRoaASjsawAUdoJkEsVaq0PgVsmNockrHQ4pY8wpwNom7I6FgKl7PtUQy
	 JSux4sVaODbi3Jd4WEGjiWR7/mcyV7jkU9nc3nvOJAdqN6LBEu68aLSOYADPTMUywi
	 1L3WJnJjxLhc8eHrXWyMPkwK6mw3+zP7Of5wqTYI3AqOTFwe8bTPDXVDezknRUJb8T
	 xVgxtqyNOkDF+orDK5UcBui69q6gukLHYy7T0GUvgFXWxLzcigrAZPV1g0eWOVq4gH
	 ekYajVUvppFSn+IL/hsGCpZkDELS2Dzf8M38GFwqGNK6aGyqNrUt6pElk+ndmo77Uq
	 hEADdK7crDknA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH] hung_task: Dump blocker task if it is not hung
Date: Wed, 30 Jul 2025 18:53:42 +0900
Message-ID: <175386922226.617855.4016966678697742834.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
References: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
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
---
 kernel/hung_task.c |   86 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index d2432df2b905..52d72beb2233 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -94,9 +94,49 @@ static struct notifier_block panic_block = {
 	.notifier_call = hung_task_panic,
 };
 
+static bool task_is_hung(struct task_struct *t, unsigned long timeout)
+{
+	unsigned long switch_count = t->nvcsw + t->nivcsw;
+	unsigned int state;
+
+	/*
+	 * skip the TASK_KILLABLE tasks -- these can be killed
+	 * skip the TASK_IDLE tasks -- those are genuinely idle
+	 */
+	state = READ_ONCE(t->__state);
+	if (!(state & TASK_UNINTERRUPTIBLE) ||
+		(state & TASK_WAKEKILL) ||
+		(state & TASK_NOLOAD))
+		return false;
+
+	/*
+	 * Ensure the task is not frozen.
+	 * Also, skip vfork and any other user process that freezer should skip.
+	 */
+	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
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
@@ -153,41 +193,21 @@ static void debug_show_blocker(struct task_struct *task)
 			       task->comm, task->pid, t->comm, t->pid);
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
@@ -222,7 +242,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
-		debug_show_blocker(t);
+		debug_show_blocker(t, timeout);
 		hung_task_show_lock = true;
 
 		if (sysctl_hung_task_all_cpu_backtrace)
@@ -278,7 +298,6 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		unsigned int state;
 
 		if (!max_count--)
 			goto unlock;
@@ -287,15 +306,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
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


