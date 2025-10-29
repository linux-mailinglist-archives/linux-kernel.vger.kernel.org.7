Return-Path: <linux-kernel+bounces-876117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056CC1A9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44155584576
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C1346778;
	Wed, 29 Oct 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul1ajjLx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHR1eJsx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A833F392
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743354; cv=none; b=K6gdlOLBNoaiRQW4y7nosZikyk/kcQ56uF66m5lCaKEIJzKN8iLaPP1qnIdVel4nv7q6VYUitxyjOOmts5NmdERQbcjwoVPHiAwLyycxISllGvlF6+/XKi5hrgBG8sIp/8aNQToQbsPtWCAPzxiUZPDw4YjK8UE/aDvftM/jqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743354; c=relaxed/simple;
	bh=TKMOla9TaovRDu2Sp7Tnk8OcJ07tOyGsiQU1ou6W8QY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WbWAUWbUE6m39jxGLQu77pm0zIowLcpIVqfP6eg+RcQ1bkls3W71UByEI4UnSEWWpuk1uCzzs5NuIYxHJ51DF+4rdRDH9lXcpVxmcuEL6ImtNNjCXWMflj9nzsggBrjACotRfek+UX7rCWiwzfxQndDzTis1bj/CCugaaKM6zcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ul1ajjLx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHR1eJsx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.780864526@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mpwniEw+AV5Dwqaz3ODdwHHYLewCz7p3AVMcluA8+MI=;
	b=ul1ajjLxdVM9PjdikN4Bo08s2eWcEae1DF2dtpFfazDHM8rNkVJVgaY3He1ZMUid+ALbiP
	/4tIzkEn/XQxi9oK4UoYr8zXwwgTM5cxOvG5fe/pttwfchppn/Qsc33e2X6RAUXpBGCazy
	xCsa+jQY7R5UjItoJC6XpRoUJ2tGV5erXoFnC8NBehvyTQry52sTjE3QvEBlWlyeDGvjCH
	FLXObk/Hke1xffw31RNGCWnaniWyR/hvo0r2WLov8qUcJbHaiZuIo9eezozrr1H6RCa70j
	oI3Rx9B+81oGR9ZuaJ74Bo0w5r8JYpg9TxI01NlUeGcNAdlunAPSFgtmzUkXMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mpwniEw+AV5Dwqaz3ODdwHHYLewCz7p3AVMcluA8+MI=;
	b=nHR1eJsxM+x3y9MeElzgsLL10xApVTuO7cctfn/4XypQ/CjjKGUyNkA7lXGWg34FAjXckO
	kc0VOysyCGKxlkCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 08/20] sched/mmcid: Use cpumask_weighted_or()
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:08 +0100 (CET)

Use cpumask_weighted_or() instead of cpumask_or() and cpumask_weight() on
the result, which walks the same bitmap twice. Results in 10-20% less
cycles, which reduces the runqueue lock hold time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10375,6 +10375,7 @@ void call_trace_sched_update_nr_running(
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	unsigned int weight;
 
 	if (!mm)
 		return;
@@ -10385,8 +10386,8 @@ static inline void mm_update_cpus_allowe
 	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	mm_allowed = mm_cpus_allowed(mm);
-	cpumask_or(mm_allowed, mm_allowed, affmsk);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+	weight = cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)


