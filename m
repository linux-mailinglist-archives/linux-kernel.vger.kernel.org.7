Return-Path: <linux-kernel+bounces-740293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C1B0D254
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF08A1AA85A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FA2C3240;
	Tue, 22 Jul 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjmI90/u"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAF2C08B6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167989; cv=none; b=VUdH8D9iOB51hBqRyzwPoxnQ34226FvEWFMgKK/apr+sVp4sS4QyvYSKefpvQogRVVAddFNDust2wHIhSDYnKUAR7cuZFZ52tRZqzDdxqRBpUInFWkceOVVlHGRP4VN+W+uPi8fB5qo6QUcWQGFkTF/MqsdaM0/kyxLP6sQDZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167989; c=relaxed/simple;
	bh=upFUszo1X4k/1v3kcSQhzPWQiLwPemqlypvnvLUec9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xdvz1ondjLy9QJCmhx+OwBV0isx/u2ukjQPkhikdJ4m+i6mrTbOc+yBAAG+f8cS93Qbu1cPE9l9wdoPgBzN/q1C0ZTmY3XNd4qxtw1pryqH61lW10doUE5JOk6PewuG+WPQUp99ec9SKg+d9b+kGEnxNlc8/u9UCc+LyG5VT9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjmI90/u; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235eefe6a8fso39213255ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167986; x=1753772786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mcaKefYRF9M4725G07PH0aETmeSusN8vwiT8bvtjZ0=;
        b=JjmI90/u6QhaglT9pSGJRWJR4NQ/Px1E2S+VWUP72cCHiJXJILv/anq5v+hPW7rL9U
         5xPACbk88yXNYLmUPZmOjDOPjRgKsVMjhRbwLLTFvICQWQdHdjaDDK0d5WYJ2NEHWb5N
         hJcF4LZDo9MhOn1AaEhwuI6gnWs4O9iPENeRo+Ec9ydhnKtU8aVQJDkx+t8wMggWUoqX
         XWUJziNsEhpifPuYOim/iw6a64a31zuDi5KzdnaW19ENnbj+cIV9d45w/JmzRsmhJlVE
         oR0PyPBKTp1wVkXbGMZCWx9d/Cf5HCqbaLNfcebTfYLuUnqflMwLkIO5IKK/idDe1uFe
         psjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167986; x=1753772786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mcaKefYRF9M4725G07PH0aETmeSusN8vwiT8bvtjZ0=;
        b=m45UwtuAQEVufXEyNEwxTaUYxL6wh2so2SdcB5R2819qXjldLb2wX9lGeQFfDXJyS9
         4urVDLALBOzNpz4kgRdRgJJcNmFokt2BT5K7rLrIC/Q/adxvhZW3544b0pKu6njFzstz
         T0ZDRVQjX/mljwsI/d8M1Zh+yC6ho/ZfKAoy104QUFw2blKUEnAbQUcn7Rmf7wzmTxmT
         /zXDGfvycOVtyoYrr4sfG6xtA6lE8q+YoIR3H4lprY4fBFz8S3bcn9Er6FPq1anY+X0I
         97lb54Kc7k5onmHcbrdNKj3M7kmgqMdtIpJbBcYlQl2ETX4qb/XffBzMLm95IeX3Z3tb
         LIyw==
X-Gm-Message-State: AOJu0YxUISznOebFgZqEu6TRKS0J7svYWjW7vTaIcMI0FEsN9m4sUadi
	6Vhgbzq5+QhNDfEbyxHCxdmpd7gKoMyU+9V+YXl9MmGJ4ruvj0+3We0OG+tOI9a5GMRVqQLGqqL
	ngiRUCU+3Mj4B4RBKrArYXfiNZHYEF9F1LbpOBPzIOoNruTQBn2EUiPe45lYH71pDGR8xEHefql
	W4aVcVu7eUfFx+Q52KVCU9rcEEXfBv75cDkt7dT+YMLnVNXzd6
X-Google-Smtp-Source: AGHT+IEUZiwpCUDJ17os2Y/Rny4HU3K/F+cfRT7oN03A9czTfyDTuS1tCWHOwPySx8wi0OhVDElCD9md2TRV
X-Received: from plgb6.prod.google.com ([2002:a17:902:d506:b0:236:369f:dfc9])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:988:b0:234:c22:c612
 with SMTP id d9443c01a7336-23e3b84f767mr214122725ad.43.1753167986411; Tue, 22
 Jul 2025 00:06:26 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:49 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-4-jstultz@google.com>
Subject: [RFC][PATCH v20 3/6] sched: Add logic to zap balance callbacks if we
 pick again
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
index 7ae5f2d257eb5..30e676c2d582b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4990,6 +4990,40 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
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
@@ -6920,8 +6954,11 @@ static void __sched notrace __schedule(int sched_mode)
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
2.50.0.727.gbf7dc18ff4-goog


