Return-Path: <linux-kernel+bounces-755485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AEB1A6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63125161E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BBF221D88;
	Mon,  4 Aug 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRfoFuyP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFA2040BF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322976; cv=none; b=BiXftgSMHRKx++bGhEDrq+iALF/Hug83Wa8s+s6nBRUc8aGZs1dsTQ8zfuq3Ow1gh911TLW1Y5sAfshjRbxXDoPQpSK4FAXh8kg09hhLVnKZ8Z9GXwB2lya3hlZ7Ph8ODIj76nAaGxdXtuqlM2U9RDdPTtGDRKEsSNCqvFIMdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322976; c=relaxed/simple;
	bh=FEyvL7hjJuFMMpaN5jqm11Vn7H2GMl37BNMt9wC6/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHHVxL7e6y8FmKMNHAZ4Og+IPi9INXnVmBw4b5elpomPPR7DxfoAQUlneakQ9xIS0pijRIl7ZQDoNcxKHhKLvED5pnUOl1K310F5KYani3WiwMJHPb5Id0m7n+t34kj8n+FyhGjecvwvDNNO5BQg2CWR0SLFFGd2xxculn4PG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lRfoFuyP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af96fba3b37so170772366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754322972; x=1754927772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOSfxECynLQLtKNLDYf22706/kw+9byvTelAznEHlRI=;
        b=lRfoFuyPkKiQ5oJhmgvJqs3SD4ghLFDrIahzQYliTWr+D2M3+2MYNLT6SrCKFtV1xN
         ia3uDs4mFbGO/zOmUjbBpFqiyTHgl0KjPbMqbqxENBPFYLzj5MzGIBM5r4TiB5VcEyQK
         Y/haETpuwu8YfGeNoGMxqXcSGlNRQf7r08qupheiLw82S1FZYYGQtrZ0noLAIzVbeFlh
         6VHuyaAwsi3OGKrF/YQlYDm3oFbjWzCNCKYK8WGHS6K0grr3C23Od0ZsMmikBKxn64ku
         8/+Ysaj4cJAaT0X8I1zAJ3AEaEObHaTlNrFpbiuH7gyWAk3TCXu0CdRDE1tkvQQltydz
         u6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322972; x=1754927772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOSfxECynLQLtKNLDYf22706/kw+9byvTelAznEHlRI=;
        b=ab2N4xfHBECaWTBBQYsceD/r3PD/oyWtVfQTlVq/hfPSXhlzMW/ivchgdxpLR0xx3w
         8X7MT2LCtIbAL0SqiGclpn8OaXPDas/LydNoTnhUrA7WhRS+tziwsDX81YpbpWB32pTB
         DZzu566xSrQGF/2alFyl5cFMHdtmVhEt0zSaxPUC8orW5oMuJe9W9B1aEXPsmC+Fe58r
         3bplJAyL9pwn5ssu5yjqeyuNDrZCLgehORviA8DK/WY0NlRzdpmkKgwEfjmelK2L4c9c
         kBCNQk7PpCJ7acq3wUTlfr6QvXZQVwGNv6b7Px+OepyMA01VNZOK+mA0vNPmlDa44u4x
         fqcQ==
X-Gm-Message-State: AOJu0Yx2Hc+9Xep8kCaizsIDRyUmkrszvQ3YCrzAy7uA4dgVeQm7Wjj2
	7RtBUDCeqIJt0SrUaKPvXpvAmEMqTPow9WEKm8NaGVM+ED+QEehgQo31BmIaPCXabnBbTqGV5Uw
	gCNbxkwOlqqg4IOpLvQ24xW3dRwHq+uKYPOofb/Pfng==
X-Gm-Gg: ASbGnctw6/8Bu27hn1Tc480lFmzZqBSb9ZXhKLiLufg6bdWeve0R+Z9dYjqVLNQ7lPr
	lvCbQyBXofKL5NLxLPiwCnlUP5leKctZAxZ53dBOCBRUVPvtpg+DgGBHhD0pwg6D9IBJdFFzifd
	lPViTosgdlG4K9gYaSOCaveSlyxsZcasbeF23bsqihGwTE1LpObOwlJ/J8UZfUOkaOWSSgPVmKv
	ALaKuC6FuVwnbK7FLAwBD2Uf/exboMzH71u
X-Google-Smtp-Source: AGHT+IGjJZQpbQmDi/N+di1pC2q+eEjMDG6XaAj9kOHkJAtXCOMQil8+eSwHgSnrcthzgHJTy2/HFl4BPTMmM4wPwjo=
X-Received: by 2002:a17:907:971e:b0:aec:4f33:e7db with SMTP id
 a640c23a62f3a-af940225030mr1106486566b.56.1754322972014; Mon, 04 Aug 2025
 08:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YQXPR01MB511370FEF51299CEFBF7A511C257A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
 <YQXPR01MB511392C60F12F7D8B9F34176C258A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR01MB511392C60F12F7D8B9F34176C258A@YQXPR01MB5113.CANPRD01.PROD.OUTLOOK.COM>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Aug 2025 17:56:00 +0200
X-Gm-Features: Ac12FXwjQPzxiLuUtAoX0jsE7Zz3iTcOLTKdW0zPKmPRzdvwo0HDjM6_ryjeesU
Message-ID: <CAKfTPtBEF92wUPsBF25ye3Dg5gUJr_giXcX5FSDF5RAo6dtS2w@mail.gmail.com>
Subject: Re: sched: cgroup cpu.weight unfairness for intermittent tasks on wake-up
To: Carl-Elliott Bilodeau-Savaria <carl-elliott.bilodeau-savaria@mail.mcgill.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "sched@vger.kernel.org" <sched@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carl-Eliott,

On Sat, 26 Jul 2025 at 22:59, Carl-Elliott Bilodeau-Savaria
<carl-elliott.bilodeau-savaria@mail.mcgill.ca> wrote:
>
> Hi everyone,
>
> Apologies for the noise. I'm gently pinging on this scheduling question f=
rom about 10 days ago as it may have been missed. I have now added the sche=
duler mailing list and the relevant maintainers to the CC list.
>
> I've also created a small GitHub repo to reproduce the issue: https://git=
hub.com/normal-account/sched-wakeup-locality-test
>
> Any insights would be greatly appreciated.
>
> Thanks,
> Carl-Elliott
>
> --- [Original Email Below] ---
>
> Hi sched maintainers,
>
> I'm observing a CPU fairness issue in kernel 6.14 related to intermittent=
 ("bursty") workloads under cgroup v2 with cpu.weight, where tasks do not r=
eceive CPU time proportional to their configured weights.
>
>
> SYSTEM & TEST SETUP
> -------------------------
>
> System Details:
>     - CPU: Intel Core i9-9980HK (8 cores, 16 threads, single L3 cache).
>     - CONFIG_PREEMPT=3Dy
>     - CPU governor: performance
>     - SMT: Enabled
>
> Workloads:
>     - continuous-burn: A simple, non-stop while(1) loop.
>     - intermittent-burn: A loop that burns CPU for 3 seconds, then sleeps=
 for 3 seconds.
>
> Cgroup Configuration:
>
>    parent/ (cpuset.cpus=3D"0-1")
>        =E2=94=9C=E2=94=80=E2=94=80 lw/ (cpu.weight=3D1)
>        =E2=94=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=94=94=E2=94=80=E2=
=94=80 1x continuous-burn process
>        =E2=94=94=E2=94=80=E2=94=80 hw/ (cpu.weight=3D10000)
>        =E2=94=94=E2=94=80=E2=94=80 2x intermittent-burn processes
>
> The goal is to have the two intermittent processes in the hw group strong=
ly prioritized over the single continuous process in the lw group on CPUs 0=
 and 1.
>
>
> PROBLEM SCENARIO & ANALYSIS
> -------------------------------------
>
> The issue stems from the scheduler's wake-up path logic. Here is a typica=
l sequence of events that leads to the unfairness.
>
> 1. The intermittent-0 process, previously running on CPU 0, finishes its =
burst and goes to sleep.
>         CPU 0 rq: [ (idle) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>         (Sleeping tasks: intermittent-0, intermittent-1)
>
> 2. intermittent-1 wakes up. Its previous CPU (CPU 1) is busy, so it is pl=
aced on CPU 0 (idle) by `select_idle_sibling()`:
>         CPU 0 rq: [ intermittent-1 (running) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>         (Sleeping tasks: intermittent-0)
>
> 3. Finally, intermittent-0 wakes up. No CPUs are idle, so it's placed bac=
k on its previous CPU's runqueue (CPU 0), where it has to wait for intermit=
tent-1.
>         CPU 0 rq: [ intermittent-1 (running), intermittent-0 (waiting) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>
> Now, both high-weight tasks are competing for CPU 0, while the low-weight=
 task runs unopposed on CPU 1.
>
> This unfair state can persist until periodic load balancing eventually mi=
grates one of the tasks, but due to the frequent sleep/wake pattern, the in=
itial placement decision has a disproportionately large effect.

How long does it take for periodic load balance to migrate the task
back on the right CPU?

>
>
> OBSERVED IMPACT
> ---------------------
>
> With the continuous-burn task present, the combined throughput (measured =
via loop iterations) of the two intermittent-burn tasks drops by ~32% compa=
red to running them alone.

32% is quite large for a 3sec running / 3 sec sleeping pattern. Looks
like the periodic load balance takes too much time before fixing the
unfairness

Do you have more details on your topology ?

>
> This results in the low-weight task receiving a disproportionate share of=
 CPU time, contrary to the cpu.weight configuration.
>
>
> QUESTIONS
> -------------
>
> I understand that EEVDF's wake-up placement logic favors idle CPUs to min=
imize latency, which makes sense in general.
>
> However, in this mixed-workload scenario, that logic seems to override cg=
roup fairness expectations.
> Wake-up placement leads to high-weight tasks dog-piling on one CPU, leavi=
ng a low-weight task uncontended on another.
>
>     - Is this considered a known-issue/an expected trade-off under EEVDF'=
s design?
>     - Are there any existing tunables (e.g. sched_features or sysctls) to=
 adjust wake-up placement behavior or increase weight enforcement in such s=
cenarios?
>
>
> Thank you for your help!
>
> (Note: Using RT scheduling isn=E2=80=99t viable in the real-world version=
 of this workload, so I=E2=80=99m specifically interested in fairness withi=
n CFS/EEVDF.)
>
> ________________________________________
> From: Carl-Elliott Bilodeau-Savaria
> Sent: Tuesday, July 15, 2025 6:44 PM
> To: linux-kernel@vger.kernel.org
> Cc: peterz@infradead.org
> Subject: sched: cgroup cpu.weight unfairness for intermittent tasks on wa=
ke-up
>
> Hi sched maintainers,
>
> I'm observing a CPU fairness issue in kernel 6.14 related to intermittent=
 ("bursty") workloads under cgroup v2 with cpu.weight, where tasks do not r=
eceive CPU time proportional to their configured weights.
>
>
> SYSTEM & TEST SETUP
> -------------------------
>
> System Details:
>     - CPU: Intel Core i9-9980HK (8 cores, 16 threads, single L3 cache).
>     - CONFIG_PREEMPT=3Dy
>     - CPU governor: performance
>     - SMT: Enabled
>
> Workloads:
>     - continuous-burn: A simple, non-stop while(1) loop.
>     - intermittent-burn: A loop that burns CPU for 3 seconds, then sleeps=
 for 3 seconds.
>
> Cgroup Configuration:
>
>    parent/ (cpuset.cpus=3D"0-1")
>        =E2=94=9C=E2=94=80=E2=94=80 lw/ (cpu.weight=3D1)
>        =E2=94=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=94=94=E2=94=80=E2=
=94=80 1x continuous-burn process
>        =E2=94=94=E2=94=80=E2=94=80 hw/ (cpu.weight=3D10000)
>        =E2=94=94=E2=94=80=E2=94=80 2x intermittent-burn processes
>
> The goal is to have the two intermittent processes in the hw group strong=
ly prioritized over the single continuous process in the lw group on CPUs 0=
 and 1.
>
>
> PROBLEM SCENARIO & ANALYSIS
> -------------------------------------
>
> The issue stems from the scheduler's wake-up path logic. Here is a typica=
l sequence of events that leads to the unfairness.
>
> 1. The intermittent-0 process, previously running on CPU 0, finishes its =
burst and goes to sleep.
>         CPU 0 rq: [ (idle) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>         (Sleeping tasks: intermittent-0, intermittent-1)
>
> 2. intermittent-1 wakes up. Its previous CPU (CPU 1) is busy, so it is pl=
aced on CPU 0 (idle) by `select_idle_sibling()`:
>         CPU 0 rq: [ intermittent-1 (running) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>         (Sleeping tasks: intermittent-0)
>
> 3. Finally, intermittent-0 wakes up. No CPUs are idle, so it's placed bac=
k on its previous CPU's runqueue (CPU 0), where it has to wait for intermit=
tent-1.
>         CPU 0 rq: [ intermittent-1 (running), intermittent-0 (waiting) ]
>         CPU 1 rq: [ continuous-1 (running) ]
>
> Now, both high-weight tasks are competing for CPU 0, while the low-weight=
 task runs unopposed on CPU 1.
>
> This unfair state can persist until periodic load balancing eventually mi=
grates one of the tasks, but due to the frequent sleep/wake pattern, the in=
itial placement decision has a disproportionately large effect.
>
>
> OBSERVED IMPACT
> ---------------------
>
> With the continuous-burn task present, the combined throughput (measured =
via loop iterations) of the two intermittent-burn tasks drops by ~32% compa=
red to running them alone.
>
> This results in the low-weight task receiving a disproportionate share of=
 CPU time, contrary to the cpu.weight configuration.
>
>
> QUESTIONS
> -------------
>
> I understand that EEVDF's wake-up placement logic favors idle CPUs to min=
imize latency, which makes sense in general.
>
> However, in this mixed-workload scenario, that logic seems to override cg=
roup fairness expectations.
> Wake-up placement leads to high-weight tasks dog-piling on one CPU, leavi=
ng a low-weight task uncontended on another.
>
>     - Is this considered a known-issue/an expected trade-off under EEVDF'=
s design?
>     - Are there any existing tunables (e.g. sched_features or sysctls) to=
 adjust wake-up placement behavior or increase weight enforcement in such s=
cenarios?
>
>
> Thank you for your help!
>
> (Note: Using RT scheduling isn=E2=80=99t viable in the real-world version=
 of this workload, so I=E2=80=99m specifically interested in fairness withi=
n CFS/EEVDF.)

