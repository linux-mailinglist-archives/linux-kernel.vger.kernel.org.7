Return-Path: <linux-kernel+bounces-774542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883FAB2B405
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD575E3728
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67927AC4B;
	Mon, 18 Aug 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjHN9BkH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CA27C154
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555189; cv=none; b=o/1OFgZZiA+r9e3hHs20LXfeW7UjL4I8WuZtaI/ML5USotbQG9CM26hOyeXUX2iMD0EO54FE8i8fN8+Wz+/DfeQFMHj1QaPnjaB1Wb1LmUNHjJtJjpMonGBfzoG2SOYDlKkU/MOE9hs7bUazbP7cSvDOpZSBdTwSF0YXb7rwEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555189; c=relaxed/simple;
	bh=LPARwn5YFjJ+zQFgZwWKEYjeBxdrL3pw7TthR4mjtPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tmj+6vU068h86DVIf+xfdhh/VJZkBX3k3RpKHAwJ4vlA2kWD7ocsC6BennPmerZYb/3WG+TqvtY0JDELEHloT931+fAdVmob0LbVDur7iaWxr/sbPj3FijdNKIRFoUfeuSZn8euWJDT30IqZuF1nZG9AYpJStaGfFkecCu+CTFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjHN9BkH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326779c67so4298933a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555187; x=1756159987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYej5+PATweapRaW2v5W509uiAl7TcWS+WeozR2WGGw=;
        b=QjHN9BkHZieDkZ234EHVCbPl4/ow1lHbZAsD+Aig43IGx4zhUo5uvQZgNvIWWmUWAn
         NcJKLZarfJm3OmRJv1WgAu4YtQaHJFEbqe2OSjY8HLqJkZa+1ynFHgMiaIDQDqpUNrCG
         KIaS8D4uOdOf6zz//WS7h6QhbLOKKkEoUHArTH+qUaYN/UfR4cjF0G//zZJKrKw0cfSw
         9RrhgB2OpUw8JyJSMVk1Hona6j9bedJt5gcAcgOPpAolmoWfN7iZlY83DBUY4FNncqQ5
         4P79UhkizgreTV8VIUVXnIHen+nEbDs3B3bImWoHmPSgMRhJTY5ekbluNfJIbFfLvjbl
         EgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555187; x=1756159987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYej5+PATweapRaW2v5W509uiAl7TcWS+WeozR2WGGw=;
        b=U7uG199IRQj6puj108j/WkhaDIhkgat6o4Tbz1EYaxyNSJn4+sgdWFjG2/D5XfrZnV
         BOBM3Zg3le/TFOaRX/izKuePo4WToA34dqwFGE49XmxTmYheyHXb+QWLSKLvWfEOh5jB
         ZgqwP2cGcBSvCwqSL4u3Jwpluv6busxm0qUnR4Q6Jf1GRmSjYNKgpd6NeRDq2v70Znay
         HjiQOF28aGqsRrh1h++4zXMUPjhhaxKeWXOtbuEwxMvxwXHFFpUCYC3iKHDO3AfZ0oJT
         uR3CrMANQb3PgKgclCQ0GT5Yzx6dD9kUmc5dnXZC3iWKzd0YlT3RZBjuGWzt0kMz9cyq
         j6WA==
X-Gm-Message-State: AOJu0YzmQQbnEy6r1qwMdtFi14doHpboKDBJXhDjIfg72h4/7b1DasIk
	7MAo366+cZ9hr/Zl3hIUkIpnY1AZT/7mkaMVIUf0iP+VT/KWKJJdS19uCo8IHeCR02/YlAsG5P3
	KLMhXmP0whp5f3Q0QHs5MrpwiEyTPg+hwcZwEUEI5iWSSEELRfGsaTfAET6kGXURQmVJBcG+D5V
	3v1L+RLZ1/P40UOmpKOkbY9nT2Qd09IfsHlU+K7MvxsVo20F/B
X-Google-Smtp-Source: AGHT+IGFzIbGz/0yiwjgmVDEipezNaaEZSGx2E6sIsc2gVAuAQDnLQGl7KmmsYOUQ49JgQRpZyA4UjnB7PCN
X-Received: from pjbqb10.prod.google.com ([2002:a17:90b:280a:b0:321:76a2:947c])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f43:b0:31f:6d6b:b453
 with SMTP id 98e67ed59e1d1-32476a97988mr625417a91.30.1755555187173; Mon, 18
 Aug 2025 15:13:07 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:12:53 +0000
In-Reply-To: <20250818221300.2948078-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818221300.2948078-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818221300.2948078-4-jstultz@google.com>
Subject: [PATCH v21 3/6] sched: Add logic to zap balance callbacks if we pick again
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

With proxy-exec, a task is selected to run via pick_next_task(),
and then if it is a mutex blocked task, we call find_proxy_task()
to find a runnable owner. If the runnable owner is on another
cpu, we will need to migrate the selected donor task away, after
which we will pick_again can call pick_next_task() to choose
something else.

However, in the first call to pick_next_task(), we may have
had a balance_callback setup by the class scheduler. After we
pick again, its possible pick_next_task_fair() will be called
which calls sched_balance_newidle() and sched_balance_rq().

This will throw a warning:
[    8.796467] rq->balance_callback && rq->balance_callback != &balance_push_callback
[    8.796467] WARNING: CPU: 32 PID: 458 at kernel/sched/sched.h:1750 sched_balance_rq+0xe92/0x1250
...
[    8.796467] Call Trace:
[    8.796467]  <TASK>
[    8.796467]  ? __warn.cold+0xb2/0x14e
[    8.796467]  ? sched_balance_rq+0xe92/0x1250
[    8.796467]  ? report_bug+0x107/0x1a0
[    8.796467]  ? handle_bug+0x54/0x90
[    8.796467]  ? exc_invalid_op+0x17/0x70
[    8.796467]  ? asm_exc_invalid_op+0x1a/0x20
[    8.796467]  ? sched_balance_rq+0xe92/0x1250
[    8.796467]  sched_balance_newidle+0x295/0x820
[    8.796467]  pick_next_task_fair+0x51/0x3f0
[    8.796467]  __schedule+0x23a/0x14b0
[    8.796467]  ? lock_release+0x16d/0x2e0
[    8.796467]  schedule+0x3d/0x150
[    8.796467]  worker_thread+0xb5/0x350
[    8.796467]  ? __pfx_worker_thread+0x10/0x10
[    8.796467]  kthread+0xee/0x120
[    8.796467]  ? __pfx_kthread+0x10/0x10
[    8.796467]  ret_from_fork+0x31/0x50
[    8.796467]  ? __pfx_kthread+0x10/0x10
[    8.796467]  ret_from_fork_asm+0x1a/0x30
[    8.796467]  </TASK>

This is because if a RT task was originally picked, it will
setup the rq->balance_callback with push_rt_tasks() via
set_next_task_rt().

Once the task is migrated away and we pick again, we haven't
processed any balance callbacks, so rq->balance_callback is not
in the same state as it was the first time pick_next_task was
called.

To handle this, add a zap_balance_callbacks() helper function
which cleans up the blance callbacks without running them. This
should be ok, as we are effectively undoing the state set in
the first call to pick_next_task(), and when we pick again,
the new callback can be configured for the donor task actually
selected.

Signed-off-by: John Stultz <jstultz@google.com>
---
v20:
* Tweaked to avoid build issues with different configs

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 kernel/sched/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0007660161fa..01bf5ef8d9fcc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5001,6 +5001,40 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
+#if defined(CONFIG_SCHED_PROXY_EXEC)
+/*
+ * Only called from __schedule context
+ *
+ * There are some cases where we are going to re-do the action
+ * that added the balance callbacks. We may not be in a state
+ * where we can run them, so just zap them so they can be
+ * properly re-added on the next time around. This is similar
+ * handling to running the callbacks, except we just don't call
+ * them.
+ */
+static void zap_balance_callbacks(struct rq *rq)
+{
+	struct balance_callback *next, *head;
+	bool found = false;
+
+	lockdep_assert_rq_held(rq);
+
+	head = rq->balance_callback;
+	while (head) {
+		if (head == &balance_push_callback)
+			found = true;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+	}
+	rq->balance_callback = found ? &balance_push_callback : NULL;
+}
+#else
+static inline void zap_balance_callbacks(struct rq *rq)
+{
+}
+#endif
+
 static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
@@ -6941,8 +6975,11 @@ static void __sched notrace __schedule(int sched_mode)
 	rq_set_donor(rq, next);
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
-		if (!next)
+		if (!next) {
+			/* zap the balance_callbacks before picking again */
+			zap_balance_callbacks(rq);
 			goto pick_again;
+		}
 		if (next == rq->idle)
 			goto keep_resched;
 	}
-- 
2.51.0.rc1.167.g924127e9c0-goog


