Return-Path: <linux-kernel+bounces-799596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F6B42E12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8448C178285
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70361B0437;
	Thu,  4 Sep 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPD9fM9C"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8119CCF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945331; cv=none; b=A2m9yT7JbsDWDf8yILBCtLKGYakKyVf8ZDHDiPtbyxJ3wOL47a6s3CZjWBtJXQNjXEGXjBFkaxTlsiNDdwCIJIurbOafN9PF0JUZjxONSr8qNNBIepUiTrJRtA8vA7iBSSqL2y7Hmv+Kga3JRVBV6dOJj0+pGXvT1d8gE1/9YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945331; c=relaxed/simple;
	bh=0C0beGOnuMmvTJ05/X24Md5t0O0RTWRq6BF8Z8LngD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjuPjGEZk7SwkVx8+wb1COogQNjfLd5lubuPvXrMrBzYrfOJEMMRxExL31BwbfUGxvUr0egqsxydxYoMzb168igJtscTbuvNHyoxbJV+7LKouiwE2HfJZLFGUJbZsCeVqOk3VXJsDdmUdM49jQ5QjRGBVZ1BoAxOH17sdrART9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPD9fM9C; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77241858ec1so404393b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945329; x=1757550129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XC30hM2d3vulBtQQBWOSF9HQ0rVcEYNwJDO/svkGcLs=;
        b=hPD9fM9CoQAZE+whbWvehl0hZ2Pv/Qs6pfs2KbEYTowixUon8gkg0Xya616zUxR4SC
         lPzZX7TxotbUklhP6wr377+SEfLIRPJb5v8JqNkDQtgGVjqstyFUcH2YbIfJ8kjWXjwk
         w6CHmUM7MkgsybMit8Snb67Wz1/+ZzAhs8A6z44TfQjWnOM5iKyVY0xZdoc6RH3FQO/Q
         1mVFn30rAvyNY8tjuvf1vngum3kijO2AeDl66lWf5JqU0Jxi5VGJpoKoV9QW6o6XDJLm
         0ueTAIioRcr6DBX8UguyVPbNrUWfS8hAPWuuv2L9K6EbKkfaomJOQ2ZWwrjvDnmYf7yV
         wz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945329; x=1757550129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XC30hM2d3vulBtQQBWOSF9HQ0rVcEYNwJDO/svkGcLs=;
        b=XAyZ3wCoBCLQPJeYShUrh+UgLJwYjml7WCe2icN7vi6QVxEuh4w0UkpvyZV4v5OEvK
         648pIvKxaU0CbftS/mZ+uzYIgFuP/p6p7PyNt0/zcVkkK+ZiSJ7a1+gD24P9dQX/cZMf
         3dR4qAQcvi/eDEMAZ3pdiKz5HrY4A6MMCqKZUXK6bB0JmOJnRVlLfKKajeXdLZbe26YA
         95FqhXhw46cDbri07mNEmavbr6THCbfu/QpjY4aphC18SoGPNoVe8BkXcsASDDmUOxuk
         qir1ASZhn9pGOrx9m2+/QyrKHCB2NsTgNfmIcTb+H40TCUIoMGp4Fdtya+yu+sQvJGW8
         pwKA==
X-Gm-Message-State: AOJu0Yw1lKJaULfiJTftxP7qOoQYiIBHMhDpcJE7rSoi2vV5ICCBy/W1
	fhTVgyu+qM8UUim4QtvrNUfnPcGgVzxNzR+34H+J5AWsb+B93I6xVLrCC9iG+isGZYIBobHytIF
	uu/UpOEN92oufHUUE24zyBlmeXu88TU7V6FY3Ge96Z+/8XrxoA5V6HKePU7UHEOGQ/wjEGwGf6c
	VK6lWWJUAYvgHMpws77LBGwDFhuJmpxzUzUDqOOxml4+WNAhwV
X-Google-Smtp-Source: AGHT+IEwrvPguhhNdtbkBeLo4cuV+PQSTPuc2tpQmhXGScPHHwlxRxkQsvNzfZdLajUCb4wLQW9WzdlZdOFB
X-Received: from pfbho6.prod.google.com ([2002:a05:6a00:8806:b0:772:46da:4dd1])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3286:b0:240:af8:1784
 with SMTP id adf61e73a8af0-243d6dd53dbmr22919025637.1.1756945328480; Wed, 03
 Sep 2025 17:22:08 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:53 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-4-jstultz@google.com>
Subject: [RESEND][PATCH v21 3/6] sched: Add logic to zap balance callbacks if
 we pick again
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
2.51.0.338.gd7d06c2dae-goog


