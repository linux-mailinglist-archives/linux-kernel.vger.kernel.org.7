Return-Path: <linux-kernel+bounces-787779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9907AB37AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4920A1B67C15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DE317711;
	Wed, 27 Aug 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw2yywEx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D7313E14
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277728; cv=none; b=IskZ4cgI52KwGt3mdIlgsCmNnEzVEOYbZNehGXL0bwl62JBQ+ufLiCAs6miMlCOVSIlvEsPIrExjOrnxQnyPVPc1nKCOMbsZrR1urhOMOd0REnHT3YqumLMjGoY1/o77B5QGU6fPkwzAzhbCbcKmPkXsXbAD5Ae2EWx8gYxEp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277728; c=relaxed/simple;
	bh=zinYmh13SzJeGGHLE0mNejbpnHv3xhyI7OV0XOcsBMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcuZY483PDJBZ9UAry2qfgQQWTDifzozt1sZF2DOaBqTdu6kj6acf1xuq/zSqz0aICiBPyaXtm87GcBhKGX3NFXYD9EiFsnqBiVmGpoTIq2F+xYJwzod3NZIrmBSANSEIH/51Ze3+5zsN2HoEBEfurBKC8pH6zLo1SyNWjfPFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw2yywEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756277725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pow7M+fTsSOthVOEOnrZkGfP5h5ssWZXQ1Q2jZT3zcA=;
	b=Hw2yywExhOBeP7LUoTzs5rtrI7LhBB+iPrU7ijWmGKXYSorAFpNokNXCp59WOPki2YEBBe
	9rj+enP9hJGLsU7bSzNtJWrsMZVRDEe0moawt0wwxoTLn4ErE3C2y3ihpuzw/uPUQt+dEX
	mZNShf+x387e8IwBLyQQwIdbjaXu3iQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-OF6JrXt2OceUkYz3F3hUeA-1; Wed, 27 Aug 2025 02:55:23 -0400
X-MC-Unique: OF6JrXt2OceUkYz3F3hUeA-1
X-Mimecast-MFC-AGG-ID: OF6JrXt2OceUkYz3F3hUeA_1756277722
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f2942a1aa1so165572285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277722; x=1756882522;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pow7M+fTsSOthVOEOnrZkGfP5h5ssWZXQ1Q2jZT3zcA=;
        b=dXosX/fOUmhUC5sKqTow06A17ZCH5hdtOzsyDN3wp4YPeLsNJwUgJaqDrzoc50XT2+
         PtOO/+DWheswQhvJtM+z1BBT9HPoessrQQCk/ZBPTT8A+NumNLk1Mx/ZkmPaM7AlXuYj
         /UgmnfKaNCHodP0HB7VjvIBFAoZ2X0o1/Qlun4klKO7iwlyD7+K9L69daue52e10JRt1
         fyG9kdEZ/Nj/mxczZpvRBXtcsotcceCTLcpdd7I8HJfRRmSZGA4K++KXB0n6b+uOaoJZ
         qFfx4V6wvAEXnhn2Elm6P9pZAoOSpYieuH/or10FP8HEiKUosVyH30y4Q9UM7mUgIpWz
         tbzg==
X-Gm-Message-State: AOJu0YyIfMpYR3qAk4uDRdyXVqqhX4VXLctx+yDIR5mIpIJiw0LKs4+x
	LCZQIMXINRGLeHLcpQE52c5VRnwfhDugqUnlKgVAIbVnW3dp4MiLnhV5MxU7FiXX8PK+MpkwiKH
	DuUjkx6hIqwu3eyS+TCjH58Mn/6060L1ri8wr1/FlNsp9jwDekIRmrbBzG/mYo5ue4g==
X-Gm-Gg: ASbGncsMBM4nH76KILabyZBf3CeDaWNlAcrVE2+CdLaksHnNnmkojw4+DSphaEaVf0M
	ynDvbNLNEO5H/lGfLd/NfN+3w+nLowsNx9spsQD8PGoQU9R+Mwj2D7qRT8McvFpqrVxUvk9vQND
	dBqmUagDH7/I3CFSoZJeWzoUC647So0p5Uy+tJFosMl/gi64zVfnxORRvQm5Y2xvEIwc1N0NSFo
	EnqBKfXF5X20aHb6cQ6SqzyfknO4WsBnnwXzLxEvw1Is1O2JkRYO2kBo8Iwx/EAp18VMJsqlkM3
	CVvvLzrYBkKj+O8IBFy65k+tFUWELTVGXqTsC8Xuu97FHsOHPA7wPV4F5kbOZQENCw==
X-Received: by 2002:a05:620a:3709:b0:7e6:9753:d959 with SMTP id af79cd13be357-7f58d941f00mr487401985a.4.1756277722419;
        Tue, 26 Aug 2025 23:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5GbWpLPk9G24jIMJyu1vTYwzxENPmSLw0NmnokCV3YFAqEvFp+wBeuJYDQ6A1ndzrQr8JnQ==
X-Received: by 2002:a05:620a:3709:b0:7e6:9753:d959 with SMTP id af79cd13be357-7f58d941f00mr487399985a.4.1756277721755;
        Tue, 26 Aug 2025 23:55:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed79a712sm815647885a.17.2025.08.26.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:55:21 -0700 (PDT)
Message-ID: <8620f69a3726e2e818305027ef79605decbd4148.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] rseq: Run the mm_cid_compaction from
 rseq_handle_notify_resume()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand	 <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra	 <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, 	linux-mm@kvack.org, Thomas Gleixner
 <tglx@linutronix.de>
Date: Wed, 27 Aug 2025 08:55:18 +0200
In-Reply-To: <d5183516-92ea-4a76-9506-2f7e4da0b0ad@efficios.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
	 <20250716160603.138385-8-gmonaco@redhat.com>
	 <d5183516-92ea-4a76-9506-2f7e4da0b0ad@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 14:01 -0400, Mathieu Desnoyers wrote:
> On 2025-07-16 12:06, Gabriele Monaco wrote:
> > Currently the mm_cid_compaction is triggered by the scheduler tick
> > and
> > runs in a task_work, behaviour is more unpredictable with periodic
> > tasks
> > with short runtime, which may rarely run during a tick.
> >=20
> > Run the mm_cid_compaction from the rseq_handle_notify_resume()
> > call,
> > which runs from resume_user_mode_work. Since the context is the
> > same
> > where the task_work would run, skip this step and call the
> > compaction
> > function directly.
> > The compaction function still exits prematurely in case the scan is
> > not
> > required, that is when the pseudo-period of 100ms did not elapse.
> >=20
> > Keep a tick handler used for long running tasks that are never
> > preempted
> > (i.e. that never call rseq_handle_notify_resume), which triggers a
> > compaction and mm_cid update only in that case.
>=20
> Your approach looks good, but please note that this will probably
> need to be rebased on top of the rseq rework from Thomas Gleixner.
>=20
> Latest version can be found here:
>=20
> https://lore.kernel.org/lkml/20250823161326.635281786@linutronix.de/
>=20

Mmh that's quite a large one, thanks for sharing!
I'm going to have a look but it might make sense to wait until that's
included, I guess.

Thanks,
Gabriele


> Thanks,
>=20
> Mathieu
>=20
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2=
 ++
> > =C2=A0 include/linux/mm_types.h | 11 ++++++++
> > =C2=A0 include/linux/sched.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 kernel/rseq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 55 +++++++++=
++++++++++++++++----------
> > -----
> > =C2=A0 kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 6 files changed, 53 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fa538feaa8d95..cc8c1c9ae26c1 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2294,6 +2294,7 @@ void sched_mm_cid_before_execve(struct
> > task_struct *t);
> > =C2=A0 void sched_mm_cid_after_execve(struct task_struct *t);
> > =C2=A0 void sched_mm_cid_fork(struct task_struct *t);
> > =C2=A0 void sched_mm_cid_exit_signals(struct task_struct *t);
> > +void task_mm_cid_work(struct task_struct *t);
> > =C2=A0 static inline int task_mm_cid(struct task_struct *t)
> > =C2=A0 {
> > =C2=A0=C2=A0	return t->mm_cid;
> > @@ -2303,6 +2304,7 @@ static inline void
> > sched_mm_cid_before_execve(struct task_struct *t) { }
> > =C2=A0 static inline void sched_mm_cid_after_execve(struct task_struct
> > *t) { }
> > =C2=A0 static inline void sched_mm_cid_fork(struct task_struct *t) { }
> > =C2=A0 static inline void sched_mm_cid_exit_signals(struct task_struct
> > *t) { }
> > +static inline void task_mm_cid_work(struct task_struct *t) { }
> > =C2=A0 static inline int task_mm_cid(struct task_struct *t)
> > =C2=A0 {
> > =C2=A0=C2=A0	/*
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index d6b91e8a66d6d..e6d6e468e64b4 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1420,6 +1420,13 @@ static inline void
> > mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
> > =C2=A0=C2=A0	WRITE_ONCE(mm->nr_cpus_allowed,
> > cpumask_weight(mm_allowed));
> > =C2=A0=C2=A0	raw_spin_unlock(&mm->cpus_allowed_lock);
> > =C2=A0 }
> > +
> > +static inline bool mm_cid_needs_scan(struct mm_struct *mm)
> > +{
> > +	if (!mm)
> > +		return false;
> > +	return time_after(jiffies, READ_ONCE(mm-
> > >mm_cid_next_scan));
> > +}
> > =C2=A0 #else /* CONFIG_SCHED_MM_CID */
> > =C2=A0 static inline void mm_init_cid(struct mm_struct *mm, struct
> > task_struct *p) { }
> > =C2=A0 static inline int mm_alloc_cid(struct mm_struct *mm, struct
> > task_struct *p) { return 0; }
> > @@ -1430,6 +1437,10 @@ static inline unsigned int mm_cid_size(void)
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0 static inline void mm_set_cpus_allowed(struct mm_struct *mm,
> > const struct cpumask *cpumask) { }
> > +static inline bool mm_cid_needs_scan(struct mm_struct *mm)
> > +{
> > +	return false;
> > +}
> > =C2=A0 #endif /* CONFIG_SCHED_MM_CID */
> > =C2=A0=20
> > =C2=A0 struct mmu_gather;
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index aa9c5be7a6325..a75f61cea2271 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1428,7 +1428,7 @@ struct task_struct {
> > =C2=A0=C2=A0	int				last_mm_cid;	/* Most
> > recent cid in mm */
> > =C2=A0=C2=A0	int				migrate_from_cpu;
> > =C2=A0=C2=A0	int				mm_cid_active;	/* Whether
> > cid bitmap is active */
> > -	struct callback_head		cid_work;
> > +	unsigned long			last_cid_reset;	/*
> > Time of last reset in jiffies */
> > =C2=A0 #endif
> > =C2=A0=20
> > =C2=A0=C2=A0	struct tlbflush_unmap_batch	tlb_ubc;
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index b7a1ec327e811..100f81e330dc6 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -441,6 +441,8 @@ void __rseq_handle_notify_resume(struct ksignal
> > *ksig, struct pt_regs *regs)
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	if (unlikely(rseq_update_cpu_node_id(t)))
> > =C2=A0=C2=A0		goto error;
> > +	/* The mm_cid compaction returns prematurely if scan is
> > not needed. */
> > +	task_mm_cid_work(t);
> > =C2=A0=C2=A0	return;
> > =C2=A0=20
> > =C2=A0 error:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 81c6df746df17..27b856a1cb0a9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -10589,22 +10589,13 @@ static void
> > sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
> > =C2=A0=C2=A0	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
> > =C2=A0 }
> > =C2=A0=20
> > -static void task_mm_cid_work(struct callback_head *work)
> > +void task_mm_cid_work(struct task_struct *t)
> > =C2=A0 {
> > =C2=A0=C2=A0	unsigned long now =3D jiffies, old_scan, next_scan;
> > -	struct task_struct *t =3D current;
> > =C2=A0=C2=A0	struct cpumask *cidmask;
> > -	struct mm_struct *mm;
> > =C2=A0=C2=A0	int weight, cpu;
> > +	struct mm_struct *mm =3D t->mm;
> > =C2=A0=20
> > -	WARN_ON_ONCE(t !=3D container_of(work, struct task_struct,
> > cid_work));
> > -
> > -	work->next =3D work;	/* Prevent double-add */
> > -	if (t->flags & PF_EXITING)
> > -		return;
> > -	mm =3D t->mm;
> > -	if (!mm)
> > -		return;
> > =C2=A0=C2=A0	old_scan =3D READ_ONCE(mm->mm_cid_next_scan);
> > =C2=A0=C2=A0	next_scan =3D now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> > =C2=A0=C2=A0	if (!old_scan) {
> > @@ -10643,23 +10634,47 @@ void init_sched_mm_cid(struct task_struct
> > *t)
> > =C2=A0=C2=A0		if (mm_users =3D=3D 1)
> > =C2=A0=C2=A0			mm->mm_cid_next_scan =3D jiffies +
> > msecs_to_jiffies(MM_CID_SCAN_DELAY);
> > =C2=A0=C2=A0	}
> > -	t->cid_work.next =3D &t->cid_work;	/* Protect against
> > double add */
> > -	init_task_work(&t->cid_work, task_mm_cid_work);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> > =C2=A0 {
> > -	struct callback_head *work =3D &curr->cid_work;
> > -	unsigned long now =3D jiffies;
> > +	u64 rtime =3D curr->se.sum_exec_runtime - curr-
> > >se.prev_sum_exec_runtime;
> > =C2=A0=20
> > +	/*
> > +	 * If a task is running unpreempted for a long time, it
> > won't get its
> > +	 * mm_cid compacted and won't update its mm_cid value
> > after a
> > +	 * compaction occurs.
> > +	 * For such a task, this function does two things:
> > +	 * A) trigger the mm_cid recompaction,
> > +	 * B) trigger an update of the task's rseq->mm_cid field
> > at some point
> > +	 * after recompaction, so it can get a mm_cid value closer
> > to 0.
> > +	 * A change in the mm_cid triggers an rseq_preempt.
> > +	 *
> > +	 * B occurs once after the compaction work completes,
> > neither A nor B
> > +	 * run as long as the compaction work is pending, the task
> > is exiting
> > +	 * or is not a userspace task.
> > +	 */
> > =C2=A0=C2=A0	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD))
> > ||
> > -	=C2=A0=C2=A0=C2=A0 work->next !=3D work)
> > +	=C2=A0=C2=A0=C2=A0 test_tsk_thread_flag(curr, TIF_NOTIFY_RESUME))
> > =C2=A0=C2=A0		return;
> > -	if (time_before(now, READ_ONCE(curr->mm-
> > >mm_cid_next_scan)))
> > +	if (rtime < RSEQ_UNPREEMPTED_THRESHOLD)
> > =C2=A0=C2=A0		return;
> > -
> > -	/* No page allocation under rq lock */
> > -	task_work_add(curr, work, TWA_RESUME);
> > +	if (mm_cid_needs_scan(curr->mm)) {
> > +		/* Trigger mm_cid recompaction */
> > +		rseq_set_notify_resume(curr);
> > +	} else if (time_after(jiffies, curr->last_cid_reset +
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > msecs_to_jiffies(MM_CID_SCAN_DELAY))) {
> > +		/* Update mm_cid field */
> > +		int old_cid =3D curr->mm_cid;
> > +
> > +		if (!curr->mm_cid_active)
> > +			return;
> > +		mm_cid_snapshot_time(rq, curr->mm);
> > +		mm_cid_put_lazy(curr);
> > +		curr->last_mm_cid =3D curr->mm_cid =3D mm_cid_get(rq,
> > curr, curr->mm);
> > +		if (old_cid !=3D curr->mm_cid)
> > +			rseq_preempt(curr);
> > +	}
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 void sched_mm_cid_exit_signals(struct task_struct *t)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 475bb5998295e..90a5b58188232 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3606,6 +3606,7 @@ extern const char *preempt_modes[];
> > =C2=A0=20
> > =C2=A0 #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/*
> > 100ms */
> > =C2=A0 #define MM_CID_SCAN_DELAY	100			/* 100ms
> > */
> > +#define RSEQ_UNPREEMPTED_THRESHOLD	SCHED_MM_CID_PERIOD_NS
> > =C2=A0=20
> > =C2=A0 extern raw_spinlock_t cid_lock;
> > =C2=A0 extern int use_cid_lock;
> > @@ -3809,6 +3810,7 @@ static inline int mm_cid_get(struct rq *rq,
> > struct task_struct *t,
> > =C2=A0=C2=A0	int cid;
> > =C2=A0=20
> > =C2=A0=C2=A0	lockdep_assert_rq_held(rq);
> > +	t->last_cid_reset =3D jiffies;
> > =C2=A0=C2=A0	cpumask =3D mm_cidmask(mm);
> > =C2=A0=C2=A0	cid =3D __this_cpu_read(pcpu_cid->cid);
> > =C2=A0=C2=A0	if (mm_cid_is_valid(cid)) {
>=20


