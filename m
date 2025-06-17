Return-Path: <linux-kernel+bounces-690319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49924ADCEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DFE189785C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555E2E2656;
	Tue, 17 Jun 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyITXxVd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591F2E3AE7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168858; cv=none; b=ETSWrj/zVB3uotPhDmSbM9Fy6919sgNoXlYsl4sknmIy642EPwdblnRcv04js1dxcZBtxmElG/tuwDVRe3S9XZVHL/zsFszy5z18TTH/7l5CB8JmZ3Wl8rIqPSeYR6sc0lEq7DxSvppCNhoRDM08C2Zxk4qcrqTsqIEFl2R7Qfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168858; c=relaxed/simple;
	bh=VWqs12/t307iHBDKgmmGx2T/aVI+DKR7qApYXtvTGbA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bc8AfAb5P9OtD55EGuytxn/2vkdCC+3vQFvTxy+cH/sgKKqKhHYqiruDSjRyPEJCejxrgFqr5E7aN0eB8Z095aGFFUcFvtJ9mdDaZ+0vIjJws6Pe1G+6WNVSmMOkLe+6c82IrtBNMxvaKolgFAxYXIUdcroPzFq9DC2s1cvW+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyITXxVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750168855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=7a9CVQnw+1QjaRn3gqbCj146WpraTRQqcra/ObDVQ0c=;
	b=GyITXxVdTnOA51AWPzTXOy+BHAxxElVTr74c7uo3k2XOr1+4M91fu0SlLNGVdlDS8Nx0IU
	Tcs6g386CElT6hO4WeuKnj2HZvxn78hze/LQewjyvI5Xn6oKiGE+I/VoakD69UluLMr1fY
	26cZSvRI5qsa/BS23p6OV0XXBzqCbH4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588--e7l9gccO22dA3dam0EELQ-1; Tue,
 17 Jun 2025 10:00:51 -0400
X-MC-Unique: -e7l9gccO22dA3dam0EELQ-1
X-Mimecast-MFC-AGG-ID: -e7l9gccO22dA3dam0EELQ_1750168839
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 459CF19560BD;
	Tue, 17 Jun 2025 14:00:39 +0000 (UTC)
Received: from localhost (unknown [10.22.89.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6181180045B;
	Tue, 17 Jun 2025 14:00:37 +0000 (UTC)
Date: Tue, 17 Jun 2025 11:00:36 -0300
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
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v5] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aFF1BKtdQCnuYMaS@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Fix that by unconditionally resorting to the deferred call to
__put_task_struct() if PREEMPT_RT is enabled.

Suggested-by: Crystal Wood <crwood@redhat.com>
Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

v2: (Rostedt) remove the #ifdef from put_task_struct() and create
    tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
v4: Fix the implementation of what was requested on v3.
v5: Add the "Fixes:" tag.

 include/linux/sched/task.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb04..51678a541477a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
-	/*
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	/* In !RT, it is always safe to call __put_task_struct(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
 
 		lock_map_acquire_try(&put_task_map);
@@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
 	}
 
 	/*
-	 * under PREEMPT_RT, we can't call put_task_struct
+	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
 	 *
-	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
 	 * __put_task_struct() is called when
@@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 *
 	 * delayed_free_task() also uses ->rcu, but it is only called
 	 * when it fails to fork a process. Therefore, there is no
-	 * way it can conflict with put_task_struct().
+	 * way it can conflict with __put_task_struct().
 	 */
 	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }


