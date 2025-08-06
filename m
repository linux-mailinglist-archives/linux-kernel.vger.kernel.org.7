Return-Path: <linux-kernel+bounces-758168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CEB1CBE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FFA3ABCB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6C299A8E;
	Wed,  6 Aug 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9f0vIBH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B019273D94
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504706; cv=none; b=imtybDZlzHRoe/k4uczVB5ZeTde0Lxi0WRw3jSjQt3C4Hklg3HN2f8wUm5e4uHbdJOdv8qA+x6OJ4RRfjlRvDt5Rl+HuZaK6g1bbfzKE6JZLHMo+WF3KkN5H8Zjwu73qxniUVxscGhbT4Xwrk5zfaY3O1ZX1X9n5mS6VsDI04lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504706; c=relaxed/simple;
	bh=JX5oUavFFqQqj+Rxf7FPL1xWJfm0bvNC7e/n/vdVurM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oBhVvNBqtC4lWvqMBgg3hQ/taPWV95kDOaW55suXDX7tKzEqwaxSd1taqlspYWL+wBXpK6yJvP3Ywwm95fRARiA0UyfQ4aygMFwwy1zJeC7sNmwh/B0mzwaVvPB45ojPhDUvZXQzjVEhvzr4EvwXqJRtY3scpUnQc46TKS38MhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9f0vIBH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754504702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JX5oUavFFqQqj+Rxf7FPL1xWJfm0bvNC7e/n/vdVurM=;
	b=c9f0vIBHcHKe8DuqIoXv6Fzp3CdPeuucuMVghA929bfC3N/cTge2vRA8AREMtWNNTre8Qo
	W17OnOwe3KsVlfkxdNjvUMiP0OFWpsKjDH/tdID5XjyreINPDWB0T+xw/vA5QLKQJai9gU
	l8RsICtwD0Uot+NrAYYogvjOl0rchy8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-K8AR6j1YP_uY2Hm0XbpqgQ-1; Wed, 06 Aug 2025 14:24:58 -0400
X-MC-Unique: K8AR6j1YP_uY2Hm0XbpqgQ-1
X-Mimecast-MFC-AGG-ID: K8AR6j1YP_uY2Hm0XbpqgQ_1754504697
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af4f3e4514dso13750866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504697; x=1755109497;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JX5oUavFFqQqj+Rxf7FPL1xWJfm0bvNC7e/n/vdVurM=;
        b=DKVPFW9ez1em4km1bXmcM72trcxklBgr7gcvrzqJlvVFuGzvNqcz7mcaN1E5AAh4FY
         YqoEz1Eg2jWO3/1zIsDhfVKFW9OB/THd6DzAc1BL76758YyS3Njc1W3huSSZtx5kKAW4
         Ht9MILDV8aIzbSmVjCNSz6qy3zQVcLXpsSaChO44VQ2P4Nyi63MVC+eduos10NvEICYd
         /Klu51PAgTGFFo21LA897HdY0CegyHBPMumFJnCu7Evq+P6SIS+24uu3EZjMos2KvpMb
         wdghytIisKAE37rQWbOPXrw4Ql0f9comNvAwP3XicwRuOMrR8Fh809xHzrWplDzE6Uap
         UlYg==
X-Gm-Message-State: AOJu0YzF/hDjGIP0G7KZNOFLTNzrhEsMRPTbtZ0w7OtvJjuSiaSfCU0I
	pfScBJfTjaGmh7Eem4Hdn7WdnaLSASV/MjSq5xsg4SVcBOPdhCxvk2jujNO+aNvWZYSDUEniS7U
	ax8ntcTndAAgV/pyaHaiOrxmjU2X7J531/GVfzxZcCWku5CYW0gMB35nnDoDOAmacDg==
X-Gm-Gg: ASbGncuqVtUkx84uFSZkEMkBw8t2g+75UmPmwqjsjy6pySR3KPZGCDsMslmQBC/4jeA
	bBKwpTMmjynTNCRz45qC0+gE4rL2VQsUq0bEWairhLhrNks9vd552bvJrVvO+fCu6LXnRtWPW19
	Y6hdGjzZMjT72Cpa3m6U+TnODtbbSyFii3Y8XPo7+XJ2dXzPGjnUrjNq0waJA4P3/gDxehBKPfg
	8x8sdYmzPCXKyVbolalkerQmFgNYh9BXOC0rN7kZHrLv7tJKIfJ62J5zrvJ3NtayDeG/J9+EtiQ
	fzRggipzdD1ka8C+OPPs3lP8MM2vV9Lrcw2aPQ==
X-Received: by 2002:a17:907:3f8c:b0:ae0:cde3:4bbd with SMTP id a640c23a62f3a-af992bb401fmr333495366b.44.1754504696850;
        Wed, 06 Aug 2025 11:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXiFaKm8tozJKFfkh9RjhTHF9EJmEpSCAf/SsoYyEm22zYpSZxGWBqVR3a9B8NBCvIOwmrw==
X-Received: by 2002:a17:907:3f8c:b0:ae0:cde3:4bbd with SMTP id a640c23a62f3a-af992bb401fmr333492966b.44.1754504696366;
        Wed, 06 Aug 2025 11:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771basm1137605666b.29.2025.08.06.11.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 11:24:56 -0700 (PDT)
Date: Wed, 6 Aug 2025 18:24:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Message-ID: <cf6fb15b-7a0f-4919-9bdd-a7bb7bb8f961@redhat.com>
In-Reply-To: <6144e652-7599-4b04-a08e-9f059ff81e26@efficios.com>
References: <20250716160603.138385-6-gmonaco@redhat.com> <20250716160603.138385-9-gmonaco@redhat.com> <9c72396b5a9757913e061c0aa7f3d488b57a8a64.camel@redhat.com> <6144e652-7599-4b04-a08e-9f059ff81e26@efficios.com>
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <cf6fb15b-7a0f-4919-9bdd-a7bb7bb8f961@redhat.com>

2025-08-06T16:57:51Z Mathieu Desnoyers <mathieu.desnoyers@efficios.com>:

> On 2025-08-05 08:42, Gabriele Monaco wrote:
>> On Wed, 2025-07-16 at 18:06 +0200, Gabriele Monaco wrote:
>>> Currently, task_mm_cid_work() is called from resume_user_mode_work().
>>> This can delay the execution of the corresponding thread for the
>>> entire duration of the function, negatively affecting the response in
>>> case of real time tasks.
>>> In practice, we observe task_mm_cid_work increasing the latency of
>>> 30-35us on a 128 cores system, this order of magnitude is meaningful
>>> under PREEMPT_RT.
>>>
>>> Run the task_mm_cid_work in batches of up to
>>> CONFIG_RSEQ_CID_SCAN_BATCH CPUs, this reduces the duration of the
>>> delay for each scan.
>>>
>>> The task_mm_cid_work contains a mechanism to avoid running more
>>> frequently than every 100ms. Keep this pseudo-periodicity only on
>>> complete scans.
>>> This means each call to task_mm_cid_work returns prematurely if the
>>> period did not elapse and a scan is not ongoing (i.e. the next batch
>>> to scan is not the first).
>>> This way full scans are not excessively delayed while still keeping
>>> each run, and introduced latency, short.
>>>
>> Mathieu, would you have some time to look at this implementation?
>
> Hi Gabriele,
>
> Please note that I am currently on vacation. I'll be back shortly
> before the end of August, but I'm afraid there are other tasks I
> need to focus on before I can get back to this. I'm adding this
> review to my todo list for September.
>

No problem, thanks for the update and enjoy your vacation!

Thanks,
Gabriele

> Thanks,
>
> Mathieu
>
>> Thanks,
>> Gabriele
>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by
>>> mm_cid")
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> ---
>>> =C2=A0include/linux/mm_types.h | 15 +++++++++++++++
>>> =C2=A0init/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
>>> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37 ++++++++++=
++++++++++++++++++++++++---
>>> =C2=A03 files changed, 61 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index e6d6e468e64b4..a822966a584f3 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -995,6 +995,13 @@ struct mm_struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When the next mm_cid scan =
is due (in jiffies).
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mm_cid_next_scan;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @mm_cid_scan_batch: Count=
er for batch used in the
>>> next scan.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Scan in batches of CONFIG=
_RSEQ_CID_SCAN_BATCH.
>>> This field
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * increments at each scan a=
nd reset when all
>>> batches are done.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mm_cid_scan_batch;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /**
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @nr_cpus_allowed: Number o=
f CPUs allowed for mm.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> @@ -1385,6 +1392,7 @@ static inline void mm_init_cid(struct mm_struct
>>> *mm, struct task_struct *p)
>>> =C2=A0=C2=A0 raw_spin_lock_init(&mm->cpus_allowed_lock);
>>> =C2=A0=C2=A0 cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
>>> =C2=A0=C2=A0 cpumask_clear(mm_cidmask(mm));
>>> +=C2=A0=C2=A0 mm->mm_cid_scan_batch =3D 0;
>>> =C2=A0}
>>> =C2=A0=C2=A0 =C2=A0static inline int mm_alloc_cid_noprof(struct mm_stru=
ct *mm, struct
>>> task_struct *p)
>>> @@ -1423,8 +1431,15 @@ static inline void mm_set_cpus_allowed(struct
>>> mm_struct *mm, const struct cpumas
>>> =C2=A0=C2=A0 =C2=A0static inline bool mm_cid_needs_scan(struct mm_struc=
t *mm)
>>> =C2=A0{
>>> +=C2=A0=C2=A0 unsigned int next_batch;
>>> +
>>> =C2=A0=C2=A0 if (!mm)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> +=C2=A0=C2=A0 next_batch =3D READ_ONCE(mm->mm_cid_scan_batch);
>>> +=C2=A0=C2=A0 /* Always needs scan unless it's the first batch. */
>>> +=C2=A0=C2=A0 if (CONFIG_RSEQ_CID_SCAN_BATCH * next_batch <
>>> num_possible_cpus() &&
>>> +=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 next_batch)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> =C2=A0=C2=A0 return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan)=
);
>>> =C2=A0}
>>> =C2=A0#else /* CONFIG_SCHED_MM_CID */
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 666783eb50abd..98d7f078cd6df 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1860,6 +1860,18 @@ config DEBUG_RSEQ
>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 If unsure, say N.
>>> =C2=A0 +config RSEQ_CID_SCAN_BATCH
>>> +=C2=A0=C2=A0 int "Number of CPUs to scan at every mm_cid compaction
>>> attempt"
>>> +=C2=A0=C2=A0 range 1 NR_CPUS
>>> +=C2=A0=C2=A0 default 8
>>> +=C2=A0=C2=A0 depends on SCHED_MM_CID
>>> +=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0 =C2=A0 CPUs are scanned pseudo-periodically to compact th=
e CID of
>>> each task,
>>> +=C2=A0=C2=A0 =C2=A0 this operation can take a longer amount of time on=
 systems
>>> with many
>>> +=C2=A0=C2=A0 =C2=A0 CPUs, resulting in higher scheduling latency for t=
he
>>> current task.
>>> +=C2=A0=C2=A0 =C2=A0 A higher value means the CID is compacted faster, =
but
>>> results in
>>> +=C2=A0=C2=A0 =C2=A0 higher scheduling latency.
>>> +
>>> =C2=A0config CACHESTAT_SYSCALL
>>> =C2=A0=C2=A0 bool "Enable cachestat() system call" if EXPERT
>>> =C2=A0=C2=A0 default y
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 27b856a1cb0a9..eae4c8faf980b 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -10591,11 +10591,26 @@ static void
>>> sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>>> =C2=A0=C2=A0 =C2=A0void task_mm_cid_work(struct task_struct *t)
>>> =C2=A0{
>>> +=C2=A0=C2=A0 int weight, cpu, from_cpu, this_batch, next_batch, idx;
>>> =C2=A0=C2=A0 unsigned long now =3D jiffies, old_scan, next_scan;
>>> =C2=A0=C2=A0 struct cpumask *cidmask;
>>> -=C2=A0=C2=A0 int weight, cpu;
>>> =C2=A0=C2=A0 struct mm_struct *mm =3D t->mm;
>>> =C2=A0 + /*
>>> +=C2=A0=C2=A0=C2=A0 * This function is called from __rseq_handle_notify=
_resume,
>>> which
>>> +=C2=A0=C2=A0=C2=A0 * makes sure t is a user thread and is not exiting.
>>> +=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0 this_batch =3D READ_ONCE(mm->mm_cid_scan_batch);
>>> +=C2=A0=C2=A0 next_batch =3D this_batch + 1;
>>> +=C2=A0=C2=A0 from_cpu =3D cpumask_nth(this_batch *
>>> CONFIG_RSEQ_CID_SCAN_BATCH,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_possible_mask);
>>> +=C2=A0=C2=A0 if (from_cpu >=3D nr_cpu_ids) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_cpu =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_batch =3D 1;
>>> +=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0 /* Delay scan only if we are done with all cpus. */
>>> +=C2=A0=C2=A0 if (from_cpu !=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cid_compact;
>>> =C2=A0=C2=A0 old_scan =3D READ_ONCE(mm->mm_cid_next_scan);
>>> =C2=A0=C2=A0 next_scan =3D now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>>> =C2=A0=C2=A0 if (!old_scan) {
>>> @@ -10611,17 +10626,33 @@ void task_mm_cid_work(struct task_struct
>>> *t)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0 if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan,
>>> next_scan))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>> +cid_compact:
>>> +=C2=A0=C2=A0 if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch,
>>> next_batch))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0 cidmask =3D mm_cidmask(mm);
>>> =C2=A0=C2=A0 /* Clear cids that were not recently used. */
>>> -=C2=A0=C2=A0 for_each_possible_cpu(cpu)
>>> +=C2=A0=C2=A0 idx =3D 0;
>>> +=C2=A0=C2=A0 cpu =3D from_cpu;
>>> +=C2=A0=C2=A0 for_each_cpu_from(cpu, cpu_possible_mask) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idx =3D=3D CONFIG_RSEQ_CID_SC=
AN_BATCH)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_mm_cid_remote_clear_old(mm, =
cpu);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++idx;
>>> +=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0 weight =3D cpumask_weight(cidmask);
>>> =C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0 * Clear cids that are greater or equal to the cidmas=
k
>>> weight to
>>> =C2=A0=C2=A0=C2=A0 * recompact it.
>>> =C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0 for_each_possible_cpu(cpu)
>>> +=C2=A0=C2=A0 idx =3D 0;
>>> +=C2=A0=C2=A0 cpu =3D from_cpu;
>>> +=C2=A0=C2=A0 for_each_cpu_from(cpu, cpu_possible_mask) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idx =3D=3D CONFIG_RSEQ_CID_SC=
AN_BATCH)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_mm_cid_remote_clear_weight(m=
m, cpu, weight);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++idx;
>>> +=C2=A0=C2=A0 }
>>> =C2=A0}
>>> =C2=A0=C2=A0 =C2=A0void init_sched_mm_cid(struct task_struct *t)
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com


