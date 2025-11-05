Return-Path: <linux-kernel+bounces-885892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DEBC342EC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EE23B5174
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E762D0C8F;
	Wed,  5 Nov 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4fBQDXj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqrwOTD7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A122D1916
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326724; cv=none; b=jKtpgVnN53ogPSDIkUzs5PFj9fOYzixf6BZdzc2fAV/FOt6DmtZhu9DUeYWLfF2/mXQNweZXuOgkOVAlAv6j5Zmkct7UP919OmI0zd5bp77pclSgAdVe2BIAM9Hm8QUJ5lMrHRpB5nyIqS12dCwlAnA/GN9YjGPPqT0r4rb8Tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326724; c=relaxed/simple;
	bh=9YVR2xg15jieWFBv7AAqGNPRtvxnHox4sbmbvg2DSuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgh3HzoTq7jmSoNSTHAsT1w9nY0no5jcy5vKPzsoTm5EJQJLwbIeB5z0jsFdRQIhTK18wU481I4KBJGVs6JPaV4qXgH4OXYB8YI21o4cdp3QWuJ4NUtfim/Fd/Ywk7dJ1Wl7DgvVkBpbXLYS1TMbOOVqdDeVIrEDc/oJEe0zUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4fBQDXj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqrwOTD7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762326721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
	b=L4fBQDXjcPLyOvd2VT/7IGTTSACD+Ga6r6LVc6mDKmnVQCnG5p9CpMujfZGXyvkX3ZHiTM
	7Ief6u025I1AH/UOTMFPyfvx9PAe5TSVb1rqsyeOjqkG/xNCloGdkAX8Bfn3Zg1R01vW4h
	HTDzXxWFesBgLFpYfaj7lEgGbPbioY0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-bvOHOzhbPaaZIWoGKiI2AQ-1; Wed, 05 Nov 2025 02:11:59 -0500
X-MC-Unique: bvOHOzhbPaaZIWoGKiI2AQ-1
X-Mimecast-MFC-AGG-ID: bvOHOzhbPaaZIWoGKiI2AQ_1762326719
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce25bea3eso6171714a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762326719; x=1762931519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
        b=RqrwOTD7CGGVuZMNWT1trDhEmjhJvYTtjfFsjUxFlAp3f0sAC/xUoM4D2ByiTCnfyG
         f1QlX21qVE1t+RbngfFeZQvqhcCig6b+iXVFJpE8ZvKRTlOJQIeNLgPooKUq67Kl8VkM
         ZvQVpXA5SRKlJIdG2Kx0cAnkMlm5qhmCuRFNi9AkG8yI15GoI8AfIpckbJvIYrMTsQGg
         hvZ4GZCG2GyXeBG1w6e/YZH9MY0k3KHIMqieTv6gCdGC0mgwoQfJZ6ohc2RmmTX93vNg
         +/yzfmG35y8XOkWHs+8UHwTfoYKavGs5T16LvAB9vAM/QZcg6QbztvJ/0RQB9b42o+Qw
         fGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326719; x=1762931519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
        b=PFY9YIj/3yvZkwq1v9jZlJj29dLo8zlRwN77ZOQZnVSNMnnJlL60M6PQJcJyr3lR6r
         harfb6StyOB2BhdEbLW/K/zZ52yea2Egnno+cJJcVVkOhpr+hylZhkbRxsl5zV3A2/mF
         pVhRRYqfZYiHm8arC+xqnNRIHU8wEsTFX11PSzwYTlW3hcg6xautNKF4QixHqEiv4rty
         LJo1BvHPDiftybE5kA6NGy6YdExvD2Kb5CJCC4AWG56v1VuRQOFCOnEC7JkYERonIE0K
         vhxAs/Z3DCRZOr+l+rn0OD1sfhyMxVw3k/DTKcsJQiyvRQYvMxcxLpZHnYrVO2+74FWD
         qJvA==
X-Gm-Message-State: AOJu0YxK230z6+ec+taXR8HZWyB69Ryuq5qpzKGkCS0L4h8e92zcScLf
	dgByel8uJtSE75aclb/PeskraB7QupXIEylrH5eVnCCwGL5c1kba5Sr4cHP2a/cpGvl/O9MaCHp
	sOlzcu7zvhVqnvzvTIfK1TIZDIVqNvHyqHI82ULTM+UXtc/ckPlCO86gEd7sKtygDCZ/Nf2Bxyy
	kyXQIIwdgx/tJagqdxK/sc8EqdHAc0VTLgfmaEqszk
X-Gm-Gg: ASbGncsjm3EHjPXCIjNHXeu1022Ugcun1pT03zvzDhurxwxAvb+00wh3c3Q1hgumFJV
	jzb+V7nIgU8k5MS4bMvahE3I7UuzimFnbZ8SkCOM97GbpxAmJOcWcKqBk5lU5gEiB39ry0HnSkL
	/FU5Xu17qzt3253DVYzHbI5UtxyPzW2SBvWmnMYqLCxHNI7pKB8iwkEqpJ
X-Received: by 2002:a05:6300:6a0d:b0:34f:c83b:b3ea with SMTP id adf61e73a8af0-34fc83bbb44mr1329609637.18.1762326718555;
        Tue, 04 Nov 2025 23:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF++biCJTOk6UG9a+n/zjnVMPbzdi/vZ0rWWtLLDLagx3HGwaYaeAqOPx45pqAJew1Uc67DsPx4RM9059DYF0Y=
X-Received: by 2002:a05:6300:6a0d:b0:34f:c83b:b3ea with SMTP id
 adf61e73a8af0-34fc83bbb44mr1329591637.18.1762326718188; Tue, 04 Nov 2025
 23:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028034357.11055-1-piliu@redhat.com> <20251028034357.11055-2-piliu@redhat.com>
 <f50cd9b8-684c-4f62-a67e-3cde74d1d324@huaweicloud.com>
In-Reply-To: <f50cd9b8-684c-4f62-a67e-3cde74d1d324@huaweicloud.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 5 Nov 2025 15:11:46 +0800
X-Gm-Features: AWmQ_bla7QzFIqgjKHbFmZnpT29S2vwo0B6GiXswMHGbUvJg3jglSBkiOYj4SDU
Message-ID: <CAF+s44QmUOUeJyuqZuYH_TmYoG9p_OLpm_wUHzyasBOuPnPatw@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:24=E2=80=AFAM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
>
>
> On 2025/10/28 11:43, Pingfan Liu wrote:
> > *** Bug description ***
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=3Dmanaged_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> >
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=3D-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > [...]
> >
> > In essence, the issue originates from the CPU hot-removal process, not
> > limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
> > program that waits indefinitely on a semaphore, spawning multiple
> > instances to ensure some run on CPU 72, and then offlining CPUs 1=E2=80=
=93143
> > one by one. When attempting this, CPU 143 failed to go offline.
> >   bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devi=
ces/system/cpu/cpu$i/online 2>/dev/null; done'
> >
> > `
> > *** Issue ***
> > Tracking down this issue, I found that dl_bw_deactivate() returned
> > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > But that is not the fact, and contributed by the following factors:
> > When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
> > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > migrated to CPU0, and its task_rq() information is stale. So its rq->rd
> > points to def_root_domain instead of the one shared with CPU0.  As a
> > result, its bandwidth is wrongly accounted into a wrong root domain
> > during domain rebuild.
> >
> > The key point is that root_domain is only tracked through active rq->rd=
.
> > To avoid using a global data structure to track all root_domains in the
> > system, there should be a method to locate an active CPU within the
> > corresponding root_domain.
> >
> > *** Solution ***
> > To locate the active cpu, the following rules for deadline
> > sub-system is useful
> >   -1.any cpu belongs to a unique root domain at a given time
> >   -2.DL bandwidth checker ensures that the root domain has active cpus.
> >
> > Now, let's examine the blocked-state task P.
> > If P is attached to a cpuset that is a partition root, it is
> > straightforward to find an active CPU.
> > If P is attached to a cpuset that has changed from 'root' to 'member',
> > the active CPUs are grouped into the parent root domain. Naturally, the
> > CPUs' capacity and reserved DL bandwidth are taken into account in the
> > ancestor root domain. (In practice, it may be unsafe to attach P to an
> > arbitrary root domain, since that domain may lack sufficient DL
> > bandwidth for P.) Again, it is straightforward to find an active CPU in
> > the ancestor root domain.
> >
> > This patch groups CPUs into isolated and housekeeping sets. For the
> > housekeeping group, it walks up the cpuset hierarchy to find active CPU=
s
> > in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > To: cgroups@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> > v3 -> v4:
> > rename function with cpuset_ prefix
> > improve commit log
> >
> >  include/linux/cpuset.h  | 18 ++++++++++++++++++
> >  kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
> >  kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
> >  3 files changed, 68 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b51..d4da93e51b37b 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/topology.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/sched/housekeeping.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/mm.h>
> > @@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
> >
> >  extern void cpuset_print_current_mems_allowed(void);
> >  extern void cpuset_reset_sched_domains(void);
> > +extern void cpuset_get_task_effective_cpus(struct task_struct *p, stru=
ct cpumask *cpus);
> >
> >  /*
> >   * read_mems_allowed_begin is required when making decisions involving
> > @@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void=
)
> >       partition_sched_domains(1, NULL, NULL);
> >  }
> >
> > +static inline void cpuset_get_task_effective_cpus(struct task_struct *=
p,
> > +             struct cpumask *cpus)
> > +{
> > +     const struct cpumask *hk_msk;
> > +
> > +     hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +     if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +             if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > +                     /* isolated cpus belong to a root domain */
> > +                     cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +                     return;
> > +             }
> > +     }
> > +     cpumask_and(cpus, cpu_active_mask, hk_msk);
> > +}
> > +
> >  static inline void cpuset_print_current_mems_allowed(void)
> >  {
> >  }
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 27adb04df675d..6ad88018f1a4e 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
> >       mutex_unlock(&cpuset_mutex);
> >  }
> >
> > +/* caller hold RCU read lock */
> > +void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpum=
ask *cpus)
> > +{
> > +     const struct cpumask *hk_msk;
> > +     struct cpuset *cs;
> > +
> > +     hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +     if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +             if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > +                     /* isolated cpus belong to a root domain */
> > +                     cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +                     return;
> > +             }
> > +     }
> > +     /* In HK_TYPE_DOMAIN, cpuset can be applied */
> > +     cs =3D task_cs(p);
> > +     while (cs !=3D &top_cpuset) {
> > +             if (is_sched_load_balance(cs))
> > +                     break;
> > +             cs =3D parent_cs(cs);
> > +     }
> > +
> > +     /* For top_cpuset, its effective_cpus does not exclude isolated c=
pu */
> > +     cpumask_and(cpus, cs->effective_cpus, hk_msk);
> > +}
> > +
>
> It seems cpuset_cpus_allowed functions is enough for you, no new function=
s need to be introduced.
>

Ah! Yes, it is good enough.

Best Regards,

Pingfan


