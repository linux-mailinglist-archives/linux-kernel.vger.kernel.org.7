Return-Path: <linux-kernel+bounces-770959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37330B280F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF65AB00487
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2F301491;
	Fri, 15 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZu0iB3e"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CD27979A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265985; cv=none; b=H+x3DUiuD4DQyIMeayYivEORFqOBceXYxtT3TgVZA1bnbSVXSPG4GWU0Pf0mlSIYjSIOVOJYMvG7FcpkBsWa/tt4qR6twxy6MhKXmtI57wdQrYVJo1MWIcPw8tBG0NO89+SyLGsPLEHp+9rPS3P+0wJV2EFE1fWMh65x5l3PVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265985; c=relaxed/simple;
	bh=g/vPhjBo6pfq8Ike3sx/mysYBAkWoN4MuzwjkOrDY7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RutMNZUbDkdlZKLHJh8F94sNH6iT84XqErTyMDDnEYzn1JwCmA50MSZUjqFls2/8HTBOuxlYR0SjqMo5R2kDxvbrvwPxiEOI+rWAzeFJ7D8yWqI/NeDxqahUPGT/XhUZOHdH+Es7re/vVDA8W21jeNOg/jvrBSDsMgd7+JZeYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZu0iB3e; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b657bddso3798988a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755265981; x=1755870781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlDNemHgHehZYRKnGnKmxTj8s0R786HKuqGi/V9JmMU=;
        b=mZu0iB3eZR41UvSXy1Admh+dxnAPmsRP3EAS3SO5fm06t563XSxz1UyE581BSmXg9R
         Eo+PvxFxPEf9nUX11pBqjsaU6/VajJKQ7bEuE5otJA6CrlgMjcZOhFJt/MCZf9pbNx8J
         oGBU1Z5KV4HMGbbVTc90a01WJo83uGsff4xJGIuUf0ebLOwTlYxUkYQkZDnK/QGb7eYl
         Km1IJ2hlOtDKBbuTA/5v3JMjRLPZtkKn/sEHS5273F1aS05IEBj8aQLteJAnXapD8aCA
         ofLKRpnjG2uaKHCvxnINSdUkfY7Adk0QVaqh6ajl70O4qfbyniZcR49voRTArQfhXMWB
         AbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755265981; x=1755870781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlDNemHgHehZYRKnGnKmxTj8s0R786HKuqGi/V9JmMU=;
        b=VQByV8cNTJL1bXRyi8OK/oXTlmm1SfwMHTCmSqzuaVGeY17eDvNNYVIP72MzY7tV39
         glT1UN+DJ5OCkOCmxY8muOgPGYa78EDXZTOpw2Z2lksrtO1SD7O0/lufqJEheym3hNM5
         vR+AnJ8DRMGMPXRmWdsB+WvXBbHWstDtgf32lnsjL6r27yMr1HWb6Yz1eto9cR0Y9Y65
         j9SVEGPX374d9cfxhb3pSPAlT0iHM4AlArr/WEQZC96D60URJShtb0GcHg6Zs68jceZX
         gWNpbZnwqLVodgoT+9fZyvkZa/Hy162ugenlIGu8vJROKM2PLIcAR++Dg3Vq936xN4SE
         a6LQ==
X-Gm-Message-State: AOJu0Yzd6fjm5JkDjgJr/t8Y5xPxsZJqXoezMclVd3C0UePOOMUJ+72V
	w8ZVYto0PioEi2sFAojkywspILfUDTnWECNubq6YhpuTZ08lUZMHxZ/GrqJEGDlHMIdi8YJC8D8
	588QaumsVqPBq6H682u3SltmHWFlo/13RfqAUGLuBxQ==
X-Gm-Gg: ASbGncvGCfnQLQwb6oRanh2UuFR3cj6oNNtruCKbfMDMF4aLeEJoiKvCYRs6/9x+IDM
	3BGzzMO4pLbDqIhTEa2r4jvl2vrLaJ2rG70ynyOSz2MGc9+qYleuc2mbZoH20rzKjHSCluRvmBK
	E0Ig/30VB+xNi4SJCyfeCOw97DvD8M8snR0Ms9s8YnfTuvFY1p9sQXONoEC6NCZJdvTbl93+0wK
	RVw7GZzTQLlZ7PWslQVdxAOmlRK1f79kfkT
X-Google-Smtp-Source: AGHT+IGRjlv0jLjqGrR9HIVsF+cf1WMDQIUB9LB5IOx4H4/x/kMRc0JvHWyGpAJavDUX+ndSULpdmpjdTq3vTFKxmoo=
X-Received: by 2002:a05:6402:2811:b0:615:957f:416b with SMTP id
 4fb4d7f45d1cf-618b0502bf8mr1776534a12.6.1755265981337; Fri, 15 Aug 2025
 06:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YQXPR01MB511370FEF51299CEFBF7A511C257A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
 <YQXPR01MB511392C60F12F7D8B9F34176C258A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
 <CAKfTPtBEF92wUPsBF25ye3Dg5gUJr_giXcX5FSDF5RAo6dtS2w@mail.gmail.com> <YT3PR01MB51060ABC887AAC68F3713BCFC22AA@YT3PR01MB5106.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT3PR01MB51060ABC887AAC68F3713BCFC22AA@YT3PR01MB5106.CANPRD01.PROD.OUTLOOK.COM>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 15 Aug 2025 15:52:49 +0200
X-Gm-Features: Ac12FXxTMH9ugo1txpX3dsgF6zGfG_GY72EsQBlsxMRiJ2V-0hn333m_kR2dOws
Message-ID: <CAKfTPtC_xo7HzagsQ2vMavuimWeCnYWanCydN3=Jv3GJsvWQPg@mail.gmail.com>
Subject: Re: sched: cgroup cpu.weight unfairness for intermittent tasks on wake-up
To: Carl-Elliott Bilodeau-Savaria <carl-elliott.bilodeau-savaria@mail.mcgill.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 at 02:57, Carl-Elliott Bilodeau-Savaria
<carl-elliott.bilodeau-savaria@mail.mcgill.ca> wrote:
>
> Hi Vincent,
> Thanks for the follow-up. Answers below.
>
> > How long does it take for periodic load balance to migrate the task bac=
k on the right CPU?
>
> I instrumented the kernel to mark each "conflict", defined as both high-w=
eight tasks being co-located on one CPU. For conflicts resolved specificall=
y by periodic load balance, the delay from the second intermittent task's w=
ake-up to fairness being restored was:
>
> - median: 432 ms
> - mean: 733 ms
> - p95: 2,507 ms
>
> These figures are consistent with the earlier observation that the bad pl=
acement often persists for several hundred milliseconds (occasionally multi=
ple seconds), aligning with the ~32% combined-throughput drop for the two i=
ntermittent tasks when the low-weight tasks are present.
>
> > Do you have more details on your topology?
>
> - Single socket, single NUMA node; 8 physical cores with SMT (16 logical =
CPUs).
> - Caches: per-core private L1d/L1i/L2; shared L3 across the package.
> - CPU 0 and 1 are different cores (not SMT siblings). Sibling pairs:
>   (0,8), (1,9), (2,10), (3,11), (4,12), (5,13), (6,14), (7,15)

Okay I've been able to reproduce your problem. Your problem comes from
your CPU affinity of the tasks which screw up load balancing. Your 3
tasks are pinned to CPU0 and CPU1 so they can't migrate anywhere else.
Because they are fully busy or overloaded, we try to balance load
instead of task but the imbalance is calculated over the whole
scheduling domain so even if you have CPU1 with lw task (weight 1) and
CPU0 with 2 hw tasks (weight 10000, 5000 each), the average "load" per
CPU should be 625 (=3D10001/16). The load balance will try to migrate
625-1 from CPU0 to CPU1 but the weight of hw task is 5000 which is
higher than 624 and the load balance failed in order to let other CPUs
of the domain to pull some task/load. This is not possible because of
their CPU affinity. Side note: all this is impacted by the load of
other tasks running on the socket.

When a load balance fails, the next one will be less strict about the
amount of load to be migrated because we check "(task's load >> number
of failed load balance) <=3D imbalance". So 5000 is too big and fails
then 2500 then 1250 , 625 and 312 which is lower than 624 and one hw
task is migrated to CPU0
The periodic load balance of a busy CPU is 16*domain's weight =3D
16*16=3D256 so you need between 3 and 4 periods before migrating the
task 768-1024ms

Vincent

>
> Cheers,
>
> Carl-Elliott
>
> ________________________________________
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Sent: Monday, August 4, 2025 11:56 AM
> To: Carl-Elliott Bilodeau-Savaria
> Cc: linux-kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com;=
 juri.lelli@redhat.com; dietmar.eggemann@arm.com; rostedt@goodmis.org; bseg=
all@google.com; mgorman@suse.de; vschneid@redhat.com; sched@vger.kernel.org
> Subject: Re: sched: cgroup cpu.weight unfairness for intermittent tasks o=
n wake-up
>
> Hi Carl-Eliott,
>
> On Sat, 26 Jul 2025 at 22:59, Carl-Elliott Bilodeau-Savaria
> <carl-elliott.bilodeau-savaria@mail.mcgill.ca> wrote:
> >
> > Hi everyone,
> >
> > Apologies for the noise. I'm gently pinging on this scheduling question=
 from about 10 days ago as it may have been missed. I have now added the sc=
heduler mailing list and the relevant maintainers to the CC list.
> >
> > I've also created a small GitHub repo to reproduce the issue: https://g=
ithub.com/normal-account/sched-wakeup-locality-test
> >
> > Any insights would be greatly appreciated.
> >
> > Thanks,
> > Carl-Elliott
> >
> > --- [Original Email Below] ---
> >
> > Hi sched maintainers,
> >
> > I'm observing a CPU fairness issue in kernel 6.14 related to intermitte=
nt ("bursty") workloads under cgroup v2 with cpu.weight, where tasks do not=
 receive CPU time proportional to their configured weights.
> >
> >
> > SYSTEM & TEST SETUP
> > -------------------------
> >
> > System Details:
> >     - CPU: Intel Core i9-9980HK (8 cores, 16 threads, single L3 cache).
> >     - CONFIG_PREEMPT=3Dy
> >     - CPU governor: performance
> >     - SMT: Enabled
> >
> > Workloads:
> >     - continuous-burn: A simple, non-stop while(1) loop.
> >     - intermittent-burn: A loop that burns CPU for 3 seconds, then slee=
ps for 3 seconds.
> >
> > Cgroup Configuration:
> >
> >    parent/ (cpuset.cpus=3D"0-1")
> >        =E2=94=9C=E2=94=80=E2=94=80 lw/ (cpu.weight=3D1)
> >        =E2=94=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=94=94=E2=94=80=
=E2=94=80 1x continuous-burn process
> >        =E2=94=94=E2=94=80=E2=94=80 hw/ (cpu.weight=3D10000)
> >        =E2=94=94=E2=94=80=E2=94=80 2x intermittent-burn processes
> >
> > The goal is to have the two intermittent processes in the hw group stro=
ngly prioritized over the single continuous process in the lw group on CPUs=
 0 and 1.
> >
> >
> > PROBLEM SCENARIO & ANALYSIS
> > -------------------------------------
> >
> > The issue stems from the scheduler's wake-up path logic. Here is a typi=
cal sequence of events that leads to the unfairness.
> >
> > 1. The intermittent-0 process, previously running on CPU 0, finishes it=
s burst and goes to sleep.
> >         CPU 0 rq: [ (idle) ]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >         (Sleeping tasks: intermittent-0, intermittent-1)
> >
> > 2. intermittent-1 wakes up. Its previous CPU (CPU 1) is busy, so it is =
placed on CPU 0 (idle) by `select_idle_sibling()`:
> >         CPU 0 rq: [ intermittent-1 (running) ]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >         (Sleeping tasks: intermittent-0)
> >
> > 3. Finally, intermittent-0 wakes up. No CPUs are idle, so it's placed b=
ack on its previous CPU's runqueue (CPU 0), where it has to wait for interm=
ittent-1.
> >         CPU 0 rq: [ intermittent-1 (running), intermittent-0 (waiting) =
]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >
> > Now, both high-weight tasks are competing for CPU 0, while the low-weig=
ht task runs unopposed on CPU 1.
> >
> > This unfair state can persist until periodic load balancing eventually =
migrates one of the tasks, but due to the frequent sleep/wake pattern, the =
initial placement decision has a disproportionately large effect.
>
> How long does it take for periodic load balance to migrate the task
> back on the right CPU?
>
> >
> >
> > OBSERVED IMPACT
> > ---------------------
> >
> > With the continuous-burn task present, the combined throughput (measure=
d via loop iterations) of the two intermittent-burn tasks drops by ~32% com=
pared to running them alone.
>
> 32% is quite large for a 3sec running / 3 sec sleeping pattern. Looks
> like the periodic load balance takes too much time before fixing the
> unfairness
>
> Do you have more details on your topology ?
>
> >
> > This results in the low-weight task receiving a disproportionate share =
of CPU time, contrary to the cpu.weight configuration.
> >
> >
> > QUESTIONS
> > -------------
> >
> > I understand that EEVDF's wake-up placement logic favors idle CPUs to m=
inimize latency, which makes sense in general.
> >
> > However, in this mixed-workload scenario, that logic seems to override =
cgroup fairness expectations.
> > Wake-up placement leads to high-weight tasks dog-piling on one CPU, lea=
ving a low-weight task uncontended on another.
> >
> >     - Is this considered a known-issue/an expected trade-off under EEVD=
F's design?
> >     - Are there any existing tunables (e.g. sched_features or sysctls) =
to adjust wake-up placement behavior or increase weight enforcement in such=
 scenarios?
> >
> >
> > Thank you for your help!
> >
> > (Note: Using RT scheduling isn=E2=80=99t viable in the real-world versi=
on of this workload, so I=E2=80=99m specifically interested in fairness wit=
hin CFS/EEVDF.)
> >
> > ________________________________________
> > From: Carl-Elliott Bilodeau-Savaria
> > Sent: Tuesday, July 15, 2025 6:44 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: peterz@infradead.org
> > Subject: sched: cgroup cpu.weight unfairness for intermittent tasks on =
wake-up
> >
> > Hi sched maintainers,
> >
> > I'm observing a CPU fairness issue in kernel 6.14 related to intermitte=
nt ("bursty") workloads under cgroup v2 with cpu.weight, where tasks do not=
 receive CPU time proportional to their configured weights.
> >
> >
> > SYSTEM & TEST SETUP
> > -------------------------
> >
> > System Details:
> >     - CPU: Intel Core i9-9980HK (8 cores, 16 threads, single L3 cache).
> >     - CONFIG_PREEMPT=3Dy
> >     - CPU governor: performance
> >     - SMT: Enabled
> >
> > Workloads:
> >     - continuous-burn: A simple, non-stop while(1) loop.
> >     - intermittent-burn: A loop that burns CPU for 3 seconds, then slee=
ps for 3 seconds.
> >
> > Cgroup Configuration:
> >
> >    parent/ (cpuset.cpus=3D"0-1")
> >        =E2=94=9C=E2=94=80=E2=94=80 lw/ (cpu.weight=3D1)
> >        =E2=94=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=94=94=E2=94=80=
=E2=94=80 1x continuous-burn process
> >        =E2=94=94=E2=94=80=E2=94=80 hw/ (cpu.weight=3D10000)
> >        =E2=94=94=E2=94=80=E2=94=80 2x intermittent-burn processes
> >
> > The goal is to have the two intermittent processes in the hw group stro=
ngly prioritized over the single continuous process in the lw group on CPUs=
 0 and 1.
> >
> >
> > PROBLEM SCENARIO & ANALYSIS
> > -------------------------------------
> >
> > The issue stems from the scheduler's wake-up path logic. Here is a typi=
cal sequence of events that leads to the unfairness.
> >
> > 1. The intermittent-0 process, previously running on CPU 0, finishes it=
s burst and goes to sleep.
> >         CPU 0 rq: [ (idle) ]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >         (Sleeping tasks: intermittent-0, intermittent-1)
> >
> > 2. intermittent-1 wakes up. Its previous CPU (CPU 1) is busy, so it is =
placed on CPU 0 (idle) by `select_idle_sibling()`:
> >         CPU 0 rq: [ intermittent-1 (running) ]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >         (Sleeping tasks: intermittent-0)
> >
> > 3. Finally, intermittent-0 wakes up. No CPUs are idle, so it's placed b=
ack on its previous CPU's runqueue (CPU 0), where it has to wait for interm=
ittent-1.
> >         CPU 0 rq: [ intermittent-1 (running), intermittent-0 (waiting) =
]
> >         CPU 1 rq: [ continuous-1 (running) ]
> >
> > Now, both high-weight tasks are competing for CPU 0, while the low-weig=
ht task runs unopposed on CPU 1.
> >
> > This unfair state can persist until periodic load balancing eventually =
migrates one of the tasks, but due to the frequent sleep/wake pattern, the =
initial placement decision has a disproportionately large effect.
> >
> >
> > OBSERVED IMPACT
> > ---------------------
> >
> > With the continuous-burn task present, the combined throughput (measure=
d via loop iterations) of the two intermittent-burn tasks drops by ~32% com=
pared to running them alone.
> >
> > This results in the low-weight task receiving a disproportionate share =
of CPU time, contrary to the cpu.weight configuration.
> >
> >
> > QUESTIONS
> > -------------
> >
> > I understand that EEVDF's wake-up placement logic favors idle CPUs to m=
inimize latency, which makes sense in general.
> >
> > However, in this mixed-workload scenario, that logic seems to override =
cgroup fairness expectations.
> > Wake-up placement leads to high-weight tasks dog-piling on one CPU, lea=
ving a low-weight task uncontended on another.
> >
> >     - Is this considered a known-issue/an expected trade-off under EEVD=
F's design?
> >     - Are there any existing tunables (e.g. sched_features or sysctls) =
to adjust wake-up placement behavior or increase weight enforcement in such=
 scenarios?
> >
> >
> > Thank you for your help!
> >
> > (Note: Using RT scheduling isn=E2=80=99t viable in the real-world versi=
on of this workload, so I=E2=80=99m specifically interested in fairness wit=
hin CFS/EEVDF.)

