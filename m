Return-Path: <linux-kernel+bounces-877339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE0DC1DE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 130AE4E4C10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7301F4289;
	Thu, 30 Oct 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0u05ljFc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5D1ADC7E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783552; cv=none; b=rHVSBikXCgbEoXKKpc78YpWEn4ky42HAcTa/4lWbGheH+hJkCXsKVHk4JGWnZq/ObTUldKRpVwb3fxO965/OC2+KpM2zdUisJR5lhDxjy5fiXWiWNlxOFvkcNW60rYzuRMr4yrbJeLPgqgqQz8cSeVc9dVsXL4a2XoHsv9Qe2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783552; c=relaxed/simple;
	bh=g+QujWJnUwHRhuZe5J7seS3AUGCqreuCnAqkj/1MMkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8vxROfJMxVEEuYaWNUBMbXGfwjqfD1lU+DyN8wyKc2snhM39AxvMhi5N3S4mbWpfKULaPy0ElvSReSc2NC385Zb6j0116TM/w3RJBSmZ3ik9/mmJtZKi6EbpzXVHNk4c/hP/weePi+SIQBsObOLOLbmfb18PstvXo9mI3et1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0u05ljFc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3403e994649so825487a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783550; x=1762388350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqycFpEo/ajRT9W2GQLxpqJNtH5rJBZEesAjfi64RXc=;
        b=0u05ljFcTW8ewrDCoj4pfwUKG7JTgRH+NwlXN6fVhyCKyBqAWq46dADtcgkS2t04P0
         4sleK5i9tvqvxDkWngfyiapKA0Yacxvq/vw71+oMGDRe4XbL42tAvVgyvRaNLqbGFaJy
         qOQWA1rZmLzWqLfroIaoB53WjF1knPchxwvvCtjZ632+aitAZqgN2rvqqNmgVLzQdFNw
         zBKLtTL9IiqnYr0Jd5lU5wIXUfvS8BIKk9aQubA+dgku7bzrMU/+NlOKiUn5xJlob4yq
         Lbawr1wOifDyAmL9rKgwJNDXxNKJ2ELrbfstHXf43FCpO/mA7lFjiK6wGPyDV1CnkP10
         YOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783550; x=1762388350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqycFpEo/ajRT9W2GQLxpqJNtH5rJBZEesAjfi64RXc=;
        b=Rj89//g59VDU67sEZICxKPdJ6vdRJAjKdpsAQBRoVIsHRm+UcbOS2AsGE/2nnES7EW
         Vun9OT1YmG0w2+j2MKtsyn9yPrzONeSMBWzWhX/Hqa9ZYIxp8OlHeqPnV1+3Sh2ZjVeF
         5zi4uFZzSYgq+YfXWrCJLmXiTMSfhCPVjrfT3scJfpHiHrFYZyI9qJnnxpF/fLfLgFXD
         ajG01VQnwdK4KRNWiMZMMueLQA11A3ICCI/s4M2hhP0FD4Lt82YkM+n3WG8JLbqz305V
         IpJtHjyLjPGnD+yl8en23bl2vxjPJit/IrvmVZIdCul4i+2ZMmUoh7cTU2VS6iq2N5i6
         Q38w==
X-Gm-Message-State: AOJu0Yx9oOZ3h75dAnGU4JkOiFyU8JeNU/+3ybY9JFwE4HbfVzIWy1n2
	4C3xH0iRCI4+1XEmaA4XVvLc7tW+mv4s4QjQG82KctplVXyulqPyzj54y3MAE9211bqnBuIbuhd
	jcjviW5UHwxSIEFHgHBcPoQPUE8qv5w86IunzAXEYiuuB/XTFB2r1xAKwIgpsF04YQ5daeWRSvW
	UpfVqBnss6hlbGBBYt3rZPXEQ/AcwvpAcMz7k3ffJndeC+7Jna
X-Google-Smtp-Source: AGHT+IEXoNXvskRxfAbogtvPYzzCEwDJ/L6nfcxEd1zZm3+NJqeAnn6dI3CviE/FdnVtHYXBG79vkPCqqdHH
X-Received: from pjyq10.prod.google.com ([2002:a17:90a:e08a:b0:33b:51fe:1a88])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3811:b0:330:6d5e:f174
 with SMTP id 98e67ed59e1d1-3403a2a3438mr5495416a91.20.1761783550119; Wed, 29
 Oct 2025 17:19:10 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:46 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-6-jstultz@google.com>
Subject: [PATCH v23 5/9] sched: Add logic to zap balance callbacks if we pick again
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
which cleans up the balance callbacks without running them. This
should be ok, as we are effectively undoing the state set in
the first call to pick_next_task(), and when we pick again,
the new callback can be configured for the donor task actually
selected.

Signed-off-by: John Stultz <jstultz@google.com>
---
v20:
* Tweaked to avoid build issues with different configs
v22:
* Spelling fix suggested by K Prateek
* Collapsed the stub implementation to one line as suggested
  by K Prateek
* Zap callbacks when we resched idle, as suggested by K Prateek

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
 kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 680ff147d270d..ab6e14259bdf2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4970,6 +4970,38 @@ static inline void finish_task(struct task_struct *prev)
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
+static inline void zap_balance_callbacks(struct rq *rq) {}
+#endif
+
 static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
@@ -6901,10 +6933,15 @@ static void __sched notrace __schedule(int sched_mode)
 	rq_set_donor(rq, next);
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
-		if (!next)
+		if (!next) {
+			/* zap the balance_callbacks before picking again */
+			zap_balance_callbacks(rq);
 			goto pick_again;
-		if (next == rq->idle)
+		}
+		if (next == rq->idle) {
+			zap_balance_callbacks(rq);
 			goto keep_resched;
+		}
 	}
 picked:
 	clear_tsk_need_resched(prev);
-- 
2.51.1.930.gacf6e81ea2-goog


