Return-Path: <linux-kernel+bounces-836850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3BBAAB67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9089D1653C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA0248F75;
	Mon, 29 Sep 2025 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zhl6UT4A"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36346BF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759186552; cv=none; b=k7AnUSNcCuEysB9YUKu7EeOXjViVwvrixINYdT3lT/jKH4IsUd6HQ8hpNrKfg9I5CBT3BZdQBFnMa2x6dow+PhJ4IsEx7Jrq85DwAWvEwcAishg0IwDO8GKfYAKYjQsG/p70voPoqnTnC6z7FLBNN/pF2r3R7KX3BPQ3ltVo8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759186552; c=relaxed/simple;
	bh=yWltR5UMzQ7WPVaW6BAgCDmNnZZsCVW/Imk+hdrGYds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEmq3Q1pMR2PeooqIrJYsZ0PqoacCq5MCPhzIdE0x4tps12UXqi+dgDkaHIrUEkv2LNtrXMzsYuPZp8/Jdbl6RUGGYBWV/CjGUed+EkDafnvBBFOFLeV8HPdXGEf9Q/744DACJkwVxJyrxX3LOOrBiOQ80fOzA1mVr5u3qTgKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zhl6UT4A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698d47e776so45701975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759186548; x=1759791348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWwi2YKfcBmpXzN2h2HKSfYkQo0+gXnuV1TKOkK9JPg=;
        b=Zhl6UT4A58Kha+SzPH+hu7RGYU16PschMC77VeiaGGywB5tY4unAK/59k5w1AElraO
         NW2MfbKOt57SHfTh9HcJ9h4E6IV6G2EORKAQplrU+d1vgLi13E7qxxFnJx5t/izMDd8z
         skrIAJhXBYVUFd/qiw2M8S6j7ToxKRovu3mVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759186548; x=1759791348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWwi2YKfcBmpXzN2h2HKSfYkQo0+gXnuV1TKOkK9JPg=;
        b=V1n4v696drw9cJFp444qwXtbxirJUs/RNbIm+TdyRdhM8BBS+LG+OuJ4s/1Q/MgtNk
         XD718wyXuMZTJl76E5cx6YULEStmV0L5cX7fZ1wRQPc19DAJN1vLslYvgC3TSju+7tLf
         ZOHimgMPk80ivLv4s0LFaSJvz5PZVugczpnP28SFK8CQ3FXpqWS9lOY4eu6BglynkWXa
         9c2f7TPzAOAxPHK7Gy+xZP3bG5b/fSLgFOpn/SNIG/vXSWTGXy2HFnowZ+ZqRa2ftRtD
         uxXzko0X9qMxhl/TK9y3zi8L08FDxahMlk3g2Xte3F/tHyuWkPprMdB89XbdbZ5W9Nvx
         e5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkG71vtTK4j0iH8Gvuo7w64QMzwm9oukiYGZd28z06m5QrxIyLDQIxUUz2LOc20G9jv6Bm2S4OSrFGIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2VtUf5kmWxhc1Gznf7h2IB3gpH2HG/Rkjz0gm/4VxwKtG09s
	NuGjR3+PWjHTJ9MRmbX669vqjYtDXErQHiMn+xPNIOMBKQdbgdO/X7OSQNA8XtCIhGLH80VdtXK
	UDIg=
X-Gm-Gg: ASbGncsQr5dK2KEnWr4cR093Ydu+EquKrrAu5yILP00o8/c1djmiWDT3wUKERIxdNgn
	xfjzHU8BCrw2EGomEMk9DmN3oJEQna2D4trCQxSD6qcXNE8KCkasPXkqctcDpgkzaz6IvLFzTvg
	aLWZ/3RgM3QpvdUO7NTU7YzDhfePB2voL15S/ZSS/nMu9j13iU1Pkx40qB8uQ/Qnm+k/XXm8AOr
	0fwCNiUa2vGpGKSxBO6zs904/ubV9C304uq/ks3ilQ//cuXPGVjXJx1M5hBSTQwt+X756r9UB91
	GmL+9BoKMCLD2ShlgCZ1Ac2TWCtCYWnlkLNQmy1JLEkpTx8r+ixmqCWRLv5W9ZNo83lzsPWNkeS
	e6x/+1tazHBZmcpPPhZBIxUgJU9bwyhZG73nvwYW1a4Pq91SzGZgyYyakZK24PMWelQ==
X-Google-Smtp-Source: AGHT+IEvNxKOjqEiNgff07LdMBFDWie3u1N5enHhDKl2UwaObGu2Af+FEFSJv9p5e/0FSwqPMpKmnA==
X-Received: by 2002:a17:902:f68e:b0:246:4077:4563 with SMTP id d9443c01a7336-27ed4a2d5c5mr210059795ad.34.1759186548070;
        Mon, 29 Sep 2025 15:55:48 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b12cdsm139389355ad.115.2025.09.29.15.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 15:55:46 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698d47e776so45701475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZBTduWqpLsnjQU1aYVXq+0oMm3ySO+JU6UNgqKgPbCfFC/cZna9AsNEBKyMT8g6h/YM3MfRkYvQxbrRA=@vger.kernel.org
X-Received: by 2002:a17:903:2291:b0:27e:dc53:d222 with SMTP id
 d9443c01a7336-27edc53d5ddmr177688785ad.44.1759186545584; Mon, 29 Sep 2025
 15:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com> <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
In-Reply-To: <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Sep 2025 15:55:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
X-Gm-Features: AS18NWAnKZZMEtwxIM0YbV4Mazpr4rnQGlLmvr3-cqjcbEOsSH_1wE2lEHBVzYs
Message-ID: <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ziqianlu@bytedance.com, akpm@linux-foundation.org, alex@ghiti.fr, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	catalin.marinas@arm.com, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 27, 2025 at 7:38=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include <linux/cpu_pm.h>
> > > > >  #include <linux/export.h>
> > > > >  #include <linux/kernel.h>
> > > > > +#include <linux/nmi.h>
> > > > >  #include <linux/perf/arm_pmu.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/sched/clock.h>
> > > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pm=
u *pmu, int cpu)
> > > > >         return per_cpu(hw_events->irq, cpu);
> > > > >  }
> > > > >
> > > > > -bool arm_pmu_irq_is_nmi(void)
> > > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > > +bool arch_perf_nmi_is_available(void)
> > > > >  {
> > > > >         return has_nmi;
> > > > >  }
> > > > > +#endif
> > > >
> > > > Should the previous comment move here, AKA:
> > > >
> > > > /*
> > > >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI =
turns off,
> > >
> > > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe=
()=E2=80=9D
> > >
> > > >  * however, the pmu interrupts will act like a normal interrupt ins=
tead of
> > > >  * NMI and the hardlockup detector would be broken.
> > > > */
> > > >
> > > >
> > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > +{
> > > > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > > > +                                        CPUFREQ_POLICY_NOTIFIER)=
;
> > > >
> > > > I think you need to do something to prevent this from happening on =
any
> > > > platforms that override hw_nmi_get_sample_period(), right? These
> > > > cpufreq notifiers will be useless in that case...
> > >
> > > I understand this is not a problem. watchdog_perf uses
> > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> > > CPU's main frequency. After we make such a change, a larger value may
> > > be used as the period, so the NMI period will become longer, but this
> > > value will not change after the system starts.
> >
> > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> >
> > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > {
> >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > }
>
> I have added the maintainers for arch/x86.
>
> 1. cpu_khz can be understood as returning the base operating frequency
> of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> downclock to 800MHz under low load and overclock to 4.4GHz under high
> load.
>
> 2. Because the event provided to the PMU has the
> PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
> on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
> fixed; it varies with the CPU's core frequency. When the CPU runs at a
> frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
> it will lengthen.
>
> 3. After our modification, if the architecture is not integrated with
> cpufreq, it returns 0 and will not update the cycle. If integrated
> with cpufreq, it returns the maximum frequency supported by the CPU,
> so the NMI cycle is only slightly lengthened, with no impact on the
> actual hardlockup detection function.
>
> 4. I have also conducted tests:
> stress-ng --cpu 1 --taskset 1 --cpu-load 80
> echo 800000 > scaling_max_freq
> turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectively.
> And the NMI cycle became approximately 30 seconds:
> [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1
> [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =3D 1

Whether or not having x86 and powerpc start looking at cpufreq is an
improvement, certainly it is a change in behavior, right? If we're
really changing the behavior here then the commit subject and commit
message need to mention this. Right now this is billed as a simple
rename...

I don't personally have lots of experience with x86 cpufreq but I do
know it doesn't work quite the same as how it does on arm. It would
definitely be good to get someone on x86 / powerpc to make sure that
they are happy with this. ...or you just keep making it work the way
it did before and then you don't have to worry about getting any
buy-in from x86 / powerpc folks. Up to you, I guess.

Note that folks on x86 have definitely had to deal with turbo mode
before.  See commit 7edaeb6841df ("kernel/watchdog: Prevent false
positives with turbo modes").

-Doug

