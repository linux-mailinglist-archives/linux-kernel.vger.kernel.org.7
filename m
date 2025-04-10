Return-Path: <linux-kernel+bounces-598861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14B1A84BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 20:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD13B9A82C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4804C28A403;
	Thu, 10 Apr 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfEV3obp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B774685
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309180; cv=none; b=Uajd8uLOIu0se9sIrddcDQBKlke2LA2ZqeqAgDFcYWh3WbE4PP1hqV0cFCJ58U2Y+Auq3mcKQvhhdK+mt14sSoGmWjlOeP2AYyusK3HNU9wGIU9zfju4pgmAda2j4xZORjHYUnd9cRcaDA9uIfg9kEFOKLMhUG1CRIQLsu0gKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309180; c=relaxed/simple;
	bh=s+F3+gJeDcN4Do9GKJ/A/hDDYvWv2weoYn6og/5mDn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=If+8E5ahfegPimsPUkWOEj7xPqWgPjGrSnln7sH9V8O6JmFdKm1+x3h/sg5KLGeE7w9RJ6TpchvWI+MGcpE4MMn6DJpksmuRSomK/lH6VVHnYQEl4pxz9f4+2TkQRoRRUTZoSbzXi1P+EXzji7NW2A6oOWQ8n26sTx72KreSIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfEV3obp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744309177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5rtW4XsvaRDkSh6S8IuU20KYiNOWOKf3cWAbzVoT8Bk=;
	b=NfEV3obpuSEFfS8Fbfs/K65+GWC4eT7H4/DqoySf+h6aGL/DKQU7f71Xqy/vQLUq+Fg6oO
	7Pl2DwxKADUzWVBAEzo3OMhVKVje3gupZd5VrxF+Gz/odhJlEY/I7RhdaanRLCVi0pYDm6
	fzrfElyjBWSJ8hlgfTXc8pBQVt7UmB8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-E68ecc-jOJiJZ7TVv3_8bg-1; Thu,
 10 Apr 2025 14:19:34 -0400
X-MC-Unique: E68ecc-jOJiJZ7TVv3_8bg-1
X-Mimecast-MFC-AGG-ID: E68ecc-jOJiJZ7TVv3_8bg_1744309172
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82BA219560B1;
	Thu, 10 Apr 2025 18:19:31 +0000 (UTC)
Received: from localhost (unknown [10.22.88.250])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33C9A19560AD;
	Thu, 10 Apr 2025 18:19:29 +0000 (UTC)
Date: Thu, 10 Apr 2025 15:19:28 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: lclaudio00@gmail.com
Subject: [PATCH v4] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_gLsK6rOjV3KElO@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---

v2: (Rostedt) remove the #ifdef from put_task_struct() and create
    tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
v4: Fix the implementation of what was requested on v3.

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


