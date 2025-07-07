Return-Path: <linux-kernel+bounces-719985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA57AFB588
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAE23A3CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E62BDC38;
	Mon,  7 Jul 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLHLeFWH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443017A31B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897067; cv=none; b=bl7I8/QIMgGQ8MEnVPZOm8T8MUgo4mVW2hmNEVHvg3eoApTktIxmhyFOKSK7hhM78VaIBsGviSq5YKCvsaAju0ozqMCI+P7fgmqSB/5hDU4RWoCUMShp3kjkRnAnEOJF4zLQAnXQH5axVtUo8bKXHZyaZzYNebTQ6OHnCfAjqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897067; c=relaxed/simple;
	bh=zjmPES/qMj2C6qWapuR4Rcsi2V/S6BbnyPqI5YbhQcw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HYKUn/DuvDIU3uOaos6TOQvurZY3iow2HdiMcyHJsBCAkcOoOBFZ0nO8Z7z41ltpyqtijM6/gUnuvQbP1jY3ABtqIkIslZR81tMjnrCfs4yYKLC4m3tEsroGdA4buXQv3vBwUUW/K667fLmeh2xH5JHG0OqlyJjEDTV7HgLleZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLHLeFWH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751897064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=pxPD34Ul1bvSrq91y/XFaT/LldnkRBWF3DvS4cmeDDY=;
	b=dLHLeFWH4N01CaumvIBfasi7loeupQbcRwemRCjkPAvrcngI3aQTm5b1dj+Wze2JEUFlTI
	u8y49BcSsZ8io0mstM1N1KeRny2r8UWqgzTyocwMkHU7pn+1XFe+XEZJvycbH0c+PdzcII
	B3KUr6hGbMHXb7OaOvlfhF0+qwA9H5k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-irXs6swOMwGdwR52WscQpQ-1; Mon,
 07 Jul 2025 10:04:19 -0400
X-MC-Unique: irXs6swOMwGdwR52WscQpQ-1
X-Mimecast-MFC-AGG-ID: irXs6swOMwGdwR52WscQpQ_1751897043
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 907991809C9A;
	Mon,  7 Jul 2025 14:04:02 +0000 (UTC)
Received: from localhost (unknown [10.22.81.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B2EE195608F;
	Mon,  7 Jul 2025 14:04:00 +0000 (UTC)
Date: Mon, 7 Jul 2025 11:03:59 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>, lclaudio00@gmail.com
Subject: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aGvTz5VaPFyj0pBV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
from rt_mutex_adjust_prio_chain() could happen in preemptible context and
with a mutex enqueued. That could lead to this sequence:

        rt_mutex_adjust_prio_chain()
          put_task_struct()
            __put_task_struct()
              sched_ext_free()
                spin_lock_irqsave()
                  rtlock_lock() --->  TRIGGERS
                                      lockdep_assert(!current->pi_blocked_on);

This is not a SCHED_EXT bug. The first cleanup function called by
__put_task_struct() is sched_ext_free() and it happens to take a
(RT) spin_lock, which in the scenario described above, would trigger
the lockdep assertion of "!current->pi_blocked_on".

Crystal Wood was able to identify the problem as __put_task_struct()
being called during rt_mutex_adjust_prio_chain(), in the context of
a process with a mutex enqueued.

Instead of adding more complex conditions to decide when to directly
call __put_task_struct() and when to defer the call, unconditionally
resort to the deferred call on PREEMPT_RT to simplify the code.

Suggested-by: Crystal Wood <crwood@redhat.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

v6: (Sebastian) rework patch description with the note from Crystal Wood.
v5: Add the "Fixes:" tag.
v4: Fix the implementation of what was requested on v3.
v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
v2: (Rostedt) remove the #ifdef from put_task_struct() and create
    tsk_is_pi_blocked_on() in sched.h to make the change cleaner.

 include/linux/sched/task.h | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb0..5873de8804d4 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -135,24 +135,17 @@ static inline void put_task_struct(struct task_struct *t)
 		return;
 
 	/*
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
-		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
-
-		lock_map_acquire_try(&put_task_map);
-		__put_task_struct(t);
-		lock_map_release(&put_task_map);
-		return;
-	}
-
-	/*
-	 * under PREEMPT_RT, we can't call put_task_struct
+	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
+	 *
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Though, in order to simplify the code, resort to the
+	 * deferred call too.
 	 *
-	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
 	 * __put_task_struct() is called when
@@ -165,7 +158,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 *
 	 * delayed_free_task() also uses ->rcu, but it is only called
 	 * when it fails to fork a process. Therefore, there is no
-	 * way it can conflict with put_task_struct().
+	 * way it can conflict with __put_task_struct().
 	 */
 	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
-- 
2.50.0


