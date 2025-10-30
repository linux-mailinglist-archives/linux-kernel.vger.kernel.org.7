Return-Path: <linux-kernel+bounces-877340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE450C1DE32
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 396CD34C623
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0D21423C;
	Thu, 30 Oct 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzHBS45a"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C31F9F51
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783556; cv=none; b=SZBkEMyiY9iQ+1cevCHpQQecLEYg8gd3ssSQ0KKdipzfvQr1axTgTBRToMaygjis7XVsMRwM47kKg9dnBx246IPzHtFCKvprMPwK5DfXWc8uG3vQJ6ayl4kVUt74sMWiwZlTQtZPZxkSD4Np55OLyFkCTDM5uP57yhxyO3oIMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783556; c=relaxed/simple;
	bh=QT2Nn6r16DWwFofbrW5JWVa/vRxzfFyLiIq5haDNeb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ui5zEQkI2li6gxbsFYoEJ6INGeXPwfbVevs3eMac0K5nlLIqZbO9C+Wfyn22jJ0CJ/kOy6Qq2ICbhSCn0owSFZd2w+kTIivjMMyPwES6LCbkVPzGw7b4YP1iUvC6cf6dVLfXT4HWbRwhHV43lTpuIcKqiUkh9eGBUn465UAiJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzHBS45a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340299e05easo374217a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783553; x=1762388353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdkyYHakwh6AX8cS6PHwqXSwqMmduHkXajdeceToMQw=;
        b=XzHBS45aOkRJjj4ncwSGsJ7u9Z9xDlRJZTVnP3AXlRo9D/DuuAlmghsYHC/uT56CUo
         93uQdHppZWG9wWtdOP41RgahnnpHpvbUE3Ff0Fy4dPkD3tIo2BWv6/GYKuqgZwK2m0ZZ
         RsUf7Z1aKPpzBSQwXmyR3Di8HlIw1i0zYXoigIDKBx0bF1Bvv0DlL549LIsPxu3wk8vg
         9Ahf3V8LnzhgJVyy6mmlRUloddEe9dc/Ok4Hlf751+q35sda5yCBaGMQiqcocGcoTrX8
         PJNLt2POPfbd1RiJXHFVEKecTQRBlFa1vYsUCL/C7XcouU6IIXuotyoda6mXg5PfvIAG
         ui6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783553; x=1762388353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdkyYHakwh6AX8cS6PHwqXSwqMmduHkXajdeceToMQw=;
        b=jAUuCyPqttpzU4t8hbPbyN2LfPSEbory7Fhmi0kZLYYwjt1tk7L3kbQDg+6Roco1lo
         eJCfOv+RPHxgewzxiq3110Klj8MlMX4wsjZLJj549KoEeWcz9jdPDYFFIFGUxTV1k1GR
         BUltmLd1uPSGaPC4C5Eu4VGMsNmykZsuXRE5Qs/FX86FGa7H8tnHBRJw9BNh/8PjUnZT
         80P5ZEa6xYLsG6QcgFRG/EYZ0wXj1OF5CakjtCdqoOQHBl8WMIalcGDLpok+pMlJis6o
         mrTB2ZrElyjEgmu3U5ystj8KfuCONJ/ioP9Y2l6i4CcLOu/2ewprl58Eml6hz10cIoFa
         qiCw==
X-Gm-Message-State: AOJu0Yx0+bOq8FhtbGbMjVhz5iVt/odBIoT+3wvJ3UdZ1WjKc1fMWBX7
	iZNXpYekU6UZTfWWm0uXTuWuHKgV5pqtnBaE6OcPWadAkSgGD3gfJ/2maX8XaiE8liT8J9KAA15
	9fHTnBBwuFe9HPzQSFBzZPWhh2/i+u7dwWPgHmnYW2oKBi14b/rpjEqqDt7tMoyN/GxEjf8c6tg
	Ey6Edz+o9TR7VpE3C/unrm6/zI6wufCq87AJ7E72l49PjYXT8M
X-Google-Smtp-Source: AGHT+IHSHADYsMGDlyHaovcsHv/qUc2C7LapBPUP7hDYFNT8mAqO2A6EAMsnBHjAfPf5FqNWi2R74uPK8rB4
X-Received: from pjbms9.prod.google.com ([2002:a17:90b:2349:b0:33d:69cf:1f82])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:32e:1b1c:f8b8
 with SMTP id 98e67ed59e1d1-3403a2f1869mr6063113a91.26.1761783553236; Wed, 29
 Oct 2025 17:19:13 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:48 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-8-jstultz@google.com>
Subject: [PATCH v23 7/9] sched: Have try_to_wake_up() handle return-migration
 for PROXY_WAKING case
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

This patch adds logic so try_to_wake_up() will notice if we are
waking a task where blocked_on == PROXY_WAKING, and if necessary
dequeue the task so the wakeup will naturally return-migrate the
donor task back to a cpu it can run on.

This helps performance as we do the dequeue and wakeup under the
locks normally taken in the try_to_wake_up() and avoids having
to do proxy_force_return() from __schedule(), which has to
re-take similar locks and then force a pick again loop.

This was split out from the larger proxy patch, and
significantly reworked.

Credits for the original patch go to:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

Signed-off-by: John Stultz <jstultz@google.com>
---
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
 kernel/sched/core.c | 74 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cf5e75abf21e..4546ceb8eae56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3697,6 +3697,56 @@ static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
 	__set_task_cpu(p, cpu);
 	p->wake_cpu = wake_cpu;
 }
+
+static bool proxy_task_runnable_but_waking(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+	return (READ_ONCE(p->__state) == TASK_RUNNING &&
+		READ_ONCE(p->blocked_on) == PROXY_WAKING);
+}
+
+static inline struct task_struct *proxy_resched_idle(struct rq *rq);
+
+/*
+ * Checks to see if task p has been proxy-migrated to another rq
+ * and needs to be returned. If so, we deactivate the task here
+ * so that it can be properly woken up on the p->wake_cpu
+ * (or whichever cpu select_task_rq() picks at the bottom of
+ * try_to_wake_up()
+ */
+static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
+{
+	bool ret = false;
+
+	if (!sched_proxy_exec())
+		return false;
+
+	raw_spin_lock(&p->blocked_lock);
+	if (p->blocked_on == PROXY_WAKING) {
+		if (!task_current(rq, p) && p->wake_cpu != cpu_of(rq)) {
+			if (task_current_donor(rq, p))
+				proxy_resched_idle(rq);
+
+			deactivate_task(rq, p, DEQUEUE_NOCLOCK);
+			ret = true;
+		}
+		__clear_task_blocked_on(p, PROXY_WAKING);
+		resched_curr(rq);
+	}
+	raw_spin_unlock(&p->blocked_lock);
+	return ret;
+}
+#else /* !CONFIG_SCHED_PROXY_EXEC */
+static bool proxy_task_runnable_but_waking(struct task_struct *p)
+{
+	return false;
+}
+
+static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
+{
+	return false;
+}
 #endif /* CONFIG_SCHED_PROXY_EXEC */
 
 static void
@@ -3784,6 +3834,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
 			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+		if (proxy_needs_return(rq, p))
+			goto out;
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
@@ -3794,6 +3846,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		ttwu_do_wakeup(p);
 		ret = 1;
 	}
+out:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
@@ -3924,6 +3977,14 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 		return false;
 #endif
 
+	/*
+	 * If we're PROXY_WAKING, we have deactivated on this cpu, so we should
+	 * activate it here as well, to avoid IPI'ing a cpu that is stuck in
+	 * task_rq_lock() spinning on p->on_rq, deadlocking that cpu.
+	 */
+	if (task_on_rq_migrating(p))
+		return false;
+
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
 	 * in hotplug state.
@@ -4181,6 +4242,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
 		WARN_ON_ONCE(p->se.sched_delayed);
+		/* If p is current, we know we can run here, so clear blocked_on */
+		clear_task_blocked_on(p, NULL);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
@@ -4197,8 +4260,15 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		smp_mb__after_spinlock();
-		if (!ttwu_state_match(p, state, &success))
-			break;
+		if (!ttwu_state_match(p, state, &success)) {
+			/*
+			 * If we're already TASK_RUNNING, and PROXY_WAKING
+			 * continue on to ttwu_runnable check to force
+			 * proxy_needs_return evaluation
+			 */
+			if (!proxy_task_runnable_but_waking(p))
+				break;
+		}
 
 		trace_sched_waking(p);
 
-- 
2.51.1.930.gacf6e81ea2-goog


