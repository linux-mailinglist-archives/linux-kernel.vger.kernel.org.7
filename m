Return-Path: <linux-kernel+bounces-801014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F34B43EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D31EA0262F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC38307492;
	Thu,  4 Sep 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwHXLpl6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATWbNFL0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EE30ACEB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995934; cv=none; b=sNZKqi7qvlPjqYc/WHEiSKSBuVArl8BgE0hnDPD5FIeep/UR51wiHwvx5WgTGCliyk1cpZsdU98o/gFKEN1H8+20eoVBbxMnDxADNaxO6zIDK8WLOEQ2L+k8+kN764pyPHCZgsMpiNR3HSoIRH+nBeGsWjkC5krBJ1g80Vh2ecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995934; c=relaxed/simple;
	bh=ntLMxMTJJL8iq2rbfSuz0Vqw+9K2PaY2gC9lbyvr3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXYotaZLKoK8r4ldF/03bT1P+wV+ylnOgJd0MBhetbJ+CFQaLTfaoQev41jF0cYHpmiWdf+jNpYwZHt5IyTsWhNunQ0LRB2Apo2pIshFDmRQsaidZF4g3IRHQaQAzZeF8EbmnyZ6UWjmx3G0VuTsVnaPK86eYlc9vIBn3S245Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwHXLpl6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATWbNFL0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756995930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpqMI9FznM8U9iJMEFpqpF+IGwhgXp8qLalooxsCxCo=;
	b=JwHXLpl6xv9sfs63bZWNe0iyugit6HI/0Fc0SbY0Y/oQ17Ohn1JrknA/t4H8P+KKJH5qSj
	rLhueLBLxDsqQGrDrqcm6S8fSulE82TCdgD4WN7CG4+ja52S7aYyIKllVmyH7xJDWDow92
	BmFQPoJKapX51HShVAD+bcUCyp8Geyvb4h0+1KT8wjf8eK7Q35ICZhJTqVk05VTbWw4lBT
	Zq6Vac4/3RI3kyxwJ8wmVoOy9U1iBLEdhdp0PWwOk3sT0uZnBPXG95vsoNLhYBMlYJ1B8d
	E+MHmvf1D5mgkulHVIDSlI+Nsh6LXF4VLIWVyx5H6JAPXabpEWtwMVIgHtCUsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756995930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpqMI9FznM8U9iJMEFpqpF+IGwhgXp8qLalooxsCxCo=;
	b=ATWbNFL0nwNSTIilXUwnO3DMbkuntpl4xbBcB5vugC264PsT4MoCg8LIuJ0e4xdYNqVcZm
	BkYFtsajdSh9lPAg==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 3/3] softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT
Date: Thu,  4 Sep 2025 16:25:25 +0200
Message-ID: <20250904142526.1845999-4-bigeasy@linutronix.de>
In-Reply-To: <20250904142526.1845999-1-bigeasy@linutronix.de>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

softirqs are preemptible on PREEMPT_RT. There is synchronisation between
individual sections which disable bottom halves. This in turn means that
a forced threaded interrupt can not preempt another forced threaded
interrupt. Instead it will PI-boost the other handler and wait for its
completion.

This is required because code within a softirq section is assumed to be
non-preemptible and may expect exclusive access to per-CPU resources
such as variables or pinned timers.
Code with such expectation has been identified and updated to use
local_lock_nested_bh() for locking of the per-CPU resource. This means
the lock can be removed.

Add CONFIG_PREEMPT_RT_NEEDS_BH_LOCK which keeps the old behaviour if
selected. Otherwise the softirq synchronising is lifted. The
softirq_ctrl.cnt accounting remains to let NOHZ code if softirqs are
currently handled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/Kconfig.preempt | 13 +++++++
 kernel/softirq.c       | 83 ++++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59ff8fbeb..da326800c1c9b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -103,6 +103,19 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
=20
+config PREEMPT_RT_NEEDS_BH_LOCK
+	bool "Enforce softirq synchronisation on PREEMPT_RT"
+	depends on PREEMPT_RT
+	help
+	  Enforce synchronisation across the softirqs context. On PREEMPT_RT
+	  the softirq is preemptible. This enforces the same per-CPU BLK
+	  semantic non-PREEMPT_RT builds have. This should not be needed
+	  because per-CPU locks were added to avoid the per-CPU BKL.
+
+	  This switch provides the old behaviour for testing reasons. Select
+	  this if you suspect an error with preemptible softirq and want test
+	  the old synchronized behaviour.
+
 config PREEMPT_COUNT
        bool
=20
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4e2c980e7712e..77198911b8dd4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -165,7 +165,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned =
int cnt)
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
-			local_lock(&softirq_ctrl.lock);
+			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+				local_lock(&softirq_ctrl.lock);
+			else
+				migrate_disable();
+
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
@@ -177,17 +181,34 @@ void __local_bh_disable_ip(unsigned long ip, unsigned=
 int cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt =3D __this_cpu_add_return(softirq_ctrl.cnt, cnt);
-	/*
-	 * Reflect the result in the task state to prevent recursion on the
-	 * local lock and to make softirq_count() & al work.
-	 */
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_add_return(softirq_ctrl.cnt, cnt);
+		/*
+		 * Reflect the result in the task state to prevent recursion on the
+		 * local lock and to make softirq_count() & al work.
+		 */
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
-		raw_local_irq_save(flags);
-		lockdep_softirqs_off(ip);
-		raw_local_irq_restore(flags);
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
+	} else {
+		bool sirq_dis =3D false;
+
+		if (!current->softirq_disable_cnt)
+			sirq_dis =3D true;
+
+		this_cpu_add(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt +=3D cnt;
+		WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_dis) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
@@ -195,23 +216,42 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
 	unsigned long flags;
+	bool sirq_en =3D false;
 	int newcnt;
=20
-	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
-			    this_cpu_read(softirq_ctrl.cnt));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
+				    this_cpu_read(softirq_ctrl.cnt));
+		if (softirq_count() =3D=3D cnt)
+			sirq_en =3D true;
+	} else {
+		if (current->softirq_disable_cnt =3D=3D cnt)
+			sirq_en =3D true;
+	}
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() =3D=3D cnt) {
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_en) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
=20
-	newcnt =3D __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (!newcnt && unlock) {
-		rcu_read_unlock();
-		local_unlock(&softirq_ctrl.lock);
+		if (!newcnt && unlock) {
+			rcu_read_unlock();
+			local_unlock(&softirq_ctrl.lock);
+		}
+	} else {
+		current->softirq_disable_cnt -=3D cnt;
+		this_cpu_sub(softirq_ctrl.cnt, cnt);
+		if (unlock && !current->softirq_disable_cnt) {
+			migrate_enable();
+			rcu_read_unlock();
+		} else {
+			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+		}
 	}
 }
=20
@@ -228,7 +268,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned i=
nt cnt)
 	lock_map_release(&bh_lock_map);
=20
 	local_irq_save(flags);
-	curcnt =3D __this_cpu_read(softirq_ctrl.cnt);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+		curcnt =3D this_cpu_read(softirq_ctrl.cnt);
+	else
+		curcnt =3D current->softirq_disable_cnt;
=20
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
--=20
2.51.0


