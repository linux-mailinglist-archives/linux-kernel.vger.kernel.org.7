Return-Path: <linux-kernel+bounces-722377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5756AFD91A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B8D16D3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29C245028;
	Tue,  8 Jul 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="St3kjWPV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231A242D62
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008569; cv=none; b=J28esb7fDYYtOivP8fG07qfHRAhHp6DjIJy3gdO/QC5Z9CIuiImT6Z+zhEQj6pBpkISSN0lLjFzr+HQBuIXWptTUEBa8RD1R0/TNKucdb9WqHItpC+YH1MtHZIaZ+eePeQSvfPrrKDsOmNuPX0Ph7Ur1Tdb00NofoBpAs8gbUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008569; c=relaxed/simple;
	bh=E5gAPcRaC5owrB9cZz4SndL4f5kENevaVe3ku6851wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pboqNccbDNk37WoHKX2TdFGtFg+aA+u0sVA8rRO0Gpva1+SHdNTr0r6NJ2J0MBHCoJaAnMNSYdm3lYIjAJ5alfGLLH2behIB4oadSj6lRe/qJwsS/ui7GzXvi3rRKfNlNDWU4DuJdt84UmKXrgMfQuY8C1U9DFl/yl+Uyz5MSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=St3kjWPV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ge7XwJTLyJ0dEyoCh9PM7+IJP1W3TbtWtMKVl41QdUk=; b=St3kjWPVaZW6DXcqtX1K8bCgRp
	dtlCPtHHz6hD3z4gkEvVa4im8L5C2EB6NkT9UU+lfBSgax4WemJyXgYHZRJJHQfPanKCB3emaVqO7
	DtxKhe4U1DoUVz7p6QcMUt3slF4uJTeKsTuP6t7GsAa6GQ24JtdUVNcw8Kf9SgavYs106/gyBEIO1
	ANuHwhpblZFytOFcGioERyk0m3BtTJTe7RdDLVt4nN7QbJ4ZsviPUmd7ZW+w2DCX8DKYrAozW/6Bj
	oAQ4U8T9+UxUJud/Qjra9Lt81XOoEyK5sJhqmls51HL73z2hPuO4UuBoo0RR3niGxXf+2lnBgjbmd
	6w5hgg3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFSU-00000008n2s-1t7L;
	Tue, 08 Jul 2025 21:02:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53F77300125; Tue, 08 Jul 2025 23:02:33 +0200 (CEST)
Date: Tue, 8 Jul 2025 23:02:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
Message-ID: <20250708210233.GG477119@noisy.programming.kicks-ass.net>
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
 <ae9f49dc-b300-4827-9cb6-be40354f5d57@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9f49dc-b300-4827-9cb6-be40354f5d57@arm.com>

On Tue, Jul 08, 2025 at 02:44:56PM +0200, Dietmar Eggemann wrote:

> > +	/*
> > +	 * NOTE: unlike the regular try_to_wake_up() path, this runs both
> > +	 * select_task_rq() and ttwu_do_migrate() while holding rq->lock
> > +	 * rather than p->pi_lock.
> > +	 */
> > +	cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> 
> There are 'lockdep_assert_held(&p->pi_lock)'s in select_task_rq() and
> select_task_rq_fair() which should trigger IMHO? Can they be changed the
> same way like  __task_rq_lock()?

It needs a slightly different fix; notably the reason for these is the
stability of the cpumasks. For that holding either p->pi_lock or
rq->lock is sufficient.

Something a little like so...

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3557,13 +3557,13 @@ static int select_fallback_rq(int cpu, s
 	return dest_cpu;
 }
 
-/*
- * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
- */
 static inline
 int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
 {
-	lockdep_assert_held(&p->pi_lock);
+	/*
+	 * Ensure the sched_setaffinity() state is stable.
+	 */
+	lockdep_assert_sched_held(p);
 
 	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p)) {
 		cpu = p->sched_class->select_task_rq(p, cpu, *wake_flags);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8499,7 +8499,7 @@ select_task_rq_fair(struct task_struct *
 	/*
 	 * required for stable ->cpus_allowed
 	 */
-	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_sched_held(p);
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1500,6 +1500,12 @@ static inline void lockdep_assert_rq_hel
 	lockdep_assert_held(__rq_lockp(rq));
 }
 
+static inline void lockdep_assert_sched_held(struct task_struct *p)
+{
+	lockdep_assert(lockdep_is_held(&p->pi_lock) ||
+		       lockdep_is_held(__rq_lockp(task_rq(p))));
+}
+
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
 extern bool raw_spin_rq_trylock(struct rq *rq);
 extern void raw_spin_rq_unlock(struct rq *rq);

