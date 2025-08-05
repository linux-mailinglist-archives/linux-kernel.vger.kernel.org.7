Return-Path: <linux-kernel+bounces-756407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFCB1B39E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D1D7A7B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46B27144B;
	Tue,  5 Aug 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAfFos6v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AD2701B1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397734; cv=none; b=MvIuGUDx2tB73JILe/R5MBKVDk4RDkhZkYThp4O7vORHYFdFsxxtcw5dyTao57HPqvsoMcp33n8wwLi4xmf3n+IjGc3vP7P8wPLUn3aGQPL/1AmHh0Vm0ouPWUr8Tm8htqrfs55bMXuFYFOm472tj/d8j0UafCnfEEDxsDp1Vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397734; c=relaxed/simple;
	bh=BRvo3zq69qmS04+mTQCvqV4fi2Zqo8rXPr7chJ8Tksc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2+L15DfgI2A3TXdiQ6xEiYCXoxjxWVyhutMBSe+A9RVAbEZNSHHxZgMWyd8WLh1WPTGQ1R2kRBvtfQpx9QAviL8ux8r5FZcCM79XcJ7wklFV7fIYPANgo7jheweOW52GqHKmzWcuBy1yoEl843oGE9259TgtYWbeaV5I22+070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAfFos6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754397731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PM6TOliDUIGTrOcw7g4Dt5QgVYMK9ObpEH9rQfaVu+U=;
	b=dAfFos6vYXpY87er4qlTCNQDI6KqnnN7GJtew3CAdJabvguwQggWPGl0DpejqyhekojhtK
	GKg09VKkicnVpzb2pnJLg5eks0BplxQzIxSAwb7ksfdH2J9eJ3WiBlJ3q8y+g7yVwiAacH
	hp6KOyz+mmEozURh8JOBHdpcgBK8ftY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-SroGBDY9M3u3uM0OjwNx-A-1; Tue, 05 Aug 2025 08:42:09 -0400
X-MC-Unique: SroGBDY9M3u3uM0OjwNx-A-1
X-Mimecast-MFC-AGG-ID: SroGBDY9M3u3uM0OjwNx-A_1754397729
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78329f180so4018668f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397728; x=1755002528;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PM6TOliDUIGTrOcw7g4Dt5QgVYMK9ObpEH9rQfaVu+U=;
        b=mjyIpLLFGRCCp6oXF7j6IeJYWmgsaQvJcdgWB/F8zRG8sbJ1MRzL7nxn6fNTcEDEK9
         HSQ+0cUvDRuW7yNX8lFcanKZjSzU3xsCAdBj3Cvkh3dgvsUGI7t08R5xbbuMonF/THfU
         bk5y33FYP1kqkyYALjvBr8at7nZm+2APpnnjkCHXl0LEVoyOVvdh/swJ/DKT+MqCRNNp
         q0NQhkw0r1u9YQQrv9HLtszkGf6Eia7l7o0YNv0PmmTroU4cgvz5mxotj+NvCk9YhX52
         NQAitg179pzI9NSpHeY+0YGdcl5vCB/PeQlqkV7v3nmQSLh1byp3H9Dhm/EyUO51BxBr
         Rjfg==
X-Gm-Message-State: AOJu0YzO3HtpZu6bphP9QsDw7P0w9DH/Mj+KS4lnXdsSDa0CFFr7rY3g
	VQnLxJDm56bJVi3jcfEXuzILYWDoE105/O0XditxoNn9tWBbaZqS1iQo8uZvodR/Js35IN8e9/j
	Z+nY/VYQgEv04RDprOc050rWtbdAFn3BZDi1BS8beRoiW2yg/lLJvShITB6DIaiAA4i2Ae46Fkf
	ChRIPnIu7xdAjfXh/blNgH6Gu7MM2UOWK7O1wuqYzcd+1Jp9nRK64=
X-Gm-Gg: ASbGnctxHVXZxsGjAifmtBJ4RzLcMv97OUkO4N0Jm6RH4/5SWqDKq850zLtYUFUrozv
	6R4kptRh2ZKqAEFhPyCScqK2RYUPdxdLdYnN6tKRhAtG2xR9u0hTeX+hbbsWv7S0UBzDvtuK9PV
	YoGEmhhhbE9F6oQpxIR7c4PND/zu02CzYyH1IIC29rk2wuaCZ1Wi2deIczaXDLGfKReABhxy9UA
	AEvsXEh1Q1KVDM/tz37EO4//1bZvMItF89YpWvr2b8WBepvTDvkAvqL8H2TLTQtRABhAUgJFMUo
	U8ShcUBdlle7sWVgIJHJ+UKmqil4ec8aDHoGvwc+/j02PHMd4u7llK40gGYWP/I+UA==
X-Received: by 2002:adf:f847:0:b0:3b8:d955:c598 with SMTP id ffacd0b85a97d-3b8d955c5bemr6460624f8f.30.1754397728481;
        Tue, 05 Aug 2025 05:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2N7fXJX0tZ1A8i4QVQ0PUZgEIztl3/ixSNfK581GhDe7bx6c+xjMGuZ5JnMgrstXehA1z/Q==
X-Received: by 2002:adf:f847:0:b0:3b8:d955:c598 with SMTP id ffacd0b85a97d-3b8d955c5bemr6460596f8f.30.1754397727922;
        Tue, 05 Aug 2025 05:42:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfeaesm264703035e9.16.2025.08.05.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:42:07 -0700 (PDT)
Message-ID: <9c72396b5a9757913e061c0aa7f3d488b57a8a64.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	 <david@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	 <peterz@infradead.org>
Date: Tue, 05 Aug 2025 14:42:05 +0200
In-Reply-To: <20250716160603.138385-9-gmonaco@redhat.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
	 <20250716160603.138385-9-gmonaco@redhat.com>
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

On Wed, 2025-07-16 at 18:06 +0200, Gabriele Monaco wrote:
> Currently, task_mm_cid_work() is called from resume_user_mode_work().
> This can delay the execution of the corresponding thread for the
> entire duration of the function, negatively affecting the response in
> case of real time tasks.
> In practice, we observe task_mm_cid_work increasing the latency of
> 30-35us on a 128 cores system, this order of magnitude is meaningful
> under PREEMPT_RT.
>=20
> Run the task_mm_cid_work in batches of up to
> CONFIG_RSEQ_CID_SCAN_BATCH CPUs, this reduces the duration of the
> delay for each scan.
>=20
> The task_mm_cid_work contains a mechanism to avoid running more
> frequently than every 100ms. Keep this pseudo-periodicity only on
> complete scans.
> This means each call to task_mm_cid_work returns prematurely if the
> period did not elapse and a scan is not ongoing (i.e. the next batch
> to scan is not the first).
> This way full scans are not excessively delayed while still keeping
> each run, and introduced latency, short.
>=20

Mathieu, would you have some time to look at this implementation?

Thanks,
Gabriele

> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by
> mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> =C2=A0include/linux/mm_types.h | 15 +++++++++++++++
> =C2=A0init/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37 ++++++++++++=
++++++++++++++++++++++---
> =C2=A03 files changed, 61 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e6d6e468e64b4..a822966a584f3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -995,6 +995,13 @@ struct mm_struct {
> =C2=A0		 * When the next mm_cid scan is due (in jiffies).
> =C2=A0		 */
> =C2=A0		unsigned long mm_cid_next_scan;
> +		/*
> +		 * @mm_cid_scan_batch: Counter for batch used in the
> next scan.
> +		 *
> +		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH.
> This field
> +		 * increments at each scan and reset when all
> batches are done.
> +		 */
> +		unsigned int mm_cid_scan_batch;
> =C2=A0		/**
> =C2=A0		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
> =C2=A0		 *
> @@ -1385,6 +1392,7 @@ static inline void mm_init_cid(struct mm_struct
> *mm, struct task_struct *p)
> =C2=A0	raw_spin_lock_init(&mm->cpus_allowed_lock);
> =C2=A0	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
> =C2=A0	cpumask_clear(mm_cidmask(mm));
> +	mm->mm_cid_scan_batch =3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct
> task_struct *p)
> @@ -1423,8 +1431,15 @@ static inline void mm_set_cpus_allowed(struct
> mm_struct *mm, const struct cpumas
> =C2=A0
> =C2=A0static inline bool mm_cid_needs_scan(struct mm_struct *mm)
> =C2=A0{
> +	unsigned int next_batch;
> +
> =C2=A0	if (!mm)
> =C2=A0		return false;
> +	next_batch =3D READ_ONCE(mm->mm_cid_scan_batch);
> +	/* Always needs scan unless it's the first batch. */
> +	if (CONFIG_RSEQ_CID_SCAN_BATCH * next_batch <
> num_possible_cpus() &&
> +	=C2=A0=C2=A0=C2=A0 next_batch)
> +		return true;
> =C2=A0	return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan));
> =C2=A0}
> =C2=A0#else /* CONFIG_SCHED_MM_CID */
> diff --git a/init/Kconfig b/init/Kconfig
> index 666783eb50abd..98d7f078cd6df 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1860,6 +1860,18 @@ config DEBUG_RSEQ
> =C2=A0
> =C2=A0	=C2=A0 If unsure, say N.
> =C2=A0
> +config RSEQ_CID_SCAN_BATCH
> +	int "Number of CPUs to scan at every mm_cid compaction
> attempt"
> +	range 1 NR_CPUS
> +	default 8
> +	depends on SCHED_MM_CID
> +	help
> +	=C2=A0 CPUs are scanned pseudo-periodically to compact the CID of
> each task,
> +	=C2=A0 this operation can take a longer amount of time on systems
> with many
> +	=C2=A0 CPUs, resulting in higher scheduling latency for the
> current task.
> +	=C2=A0 A higher value means the CID is compacted faster, but
> results in
> +	=C2=A0 higher scheduling latency.
> +
> =C2=A0config CACHESTAT_SYSCALL
> =C2=A0	bool "Enable cachestat() system call" if EXPERT
> =C2=A0	default y
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 27b856a1cb0a9..eae4c8faf980b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10591,11 +10591,26 @@ static void
> sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
> =C2=A0
> =C2=A0void task_mm_cid_work(struct task_struct *t)
> =C2=A0{
> +	int weight, cpu, from_cpu, this_batch, next_batch, idx;
> =C2=A0	unsigned long now =3D jiffies, old_scan, next_scan;
> =C2=A0	struct cpumask *cidmask;
> -	int weight, cpu;
> =C2=A0	struct mm_struct *mm =3D t->mm;
> =C2=A0
> +	/*
> +	 * This function is called from __rseq_handle_notify_resume,
> which
> +	 * makes sure t is a user thread and is not exiting.
> +	 */
> +	this_batch =3D READ_ONCE(mm->mm_cid_scan_batch);
> +	next_batch =3D this_batch + 1;
> +	from_cpu =3D cpumask_nth(this_batch *
> CONFIG_RSEQ_CID_SCAN_BATCH,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_possible_mask);
> +	if (from_cpu >=3D nr_cpu_ids) {
> +		from_cpu =3D 0;
> +		next_batch =3D 1;
> +	}
> +	/* Delay scan only if we are done with all cpus. */
> +	if (from_cpu !=3D 0)
> +		goto cid_compact;
> =C2=A0	old_scan =3D READ_ONCE(mm->mm_cid_next_scan);
> =C2=A0	next_scan =3D now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> =C2=A0	if (!old_scan) {
> @@ -10611,17 +10626,33 @@ void task_mm_cid_work(struct task_struct
> *t)
> =C2=A0		return;
> =C2=A0	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan,
> next_scan))
> =C2=A0		return;
> +
> +cid_compact:
> +	if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch,
> next_batch))
> +		return;
> =C2=A0	cidmask =3D mm_cidmask(mm);
> =C2=A0	/* Clear cids that were not recently used. */
> -	for_each_possible_cpu(cpu)
> +	idx =3D 0;
> +	cpu =3D from_cpu;
> +	for_each_cpu_from(cpu, cpu_possible_mask) {
> +		if (idx =3D=3D CONFIG_RSEQ_CID_SCAN_BATCH)
> +			break;
> =C2=A0		sched_mm_cid_remote_clear_old(mm, cpu);
> +		++idx;
> +	}
> =C2=A0	weight =3D cpumask_weight(cidmask);
> =C2=A0	/*
> =C2=A0	 * Clear cids that are greater or equal to the cidmask
> weight to
> =C2=A0	 * recompact it.
> =C2=A0	 */
> -	for_each_possible_cpu(cpu)
> +	idx =3D 0;
> +	cpu =3D from_cpu;
> +	for_each_cpu_from(cpu, cpu_possible_mask) {
> +		if (idx =3D=3D CONFIG_RSEQ_CID_SCAN_BATCH)
> +			break;
> =C2=A0		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> +		++idx;
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0void init_sched_mm_cid(struct task_struct *t)


