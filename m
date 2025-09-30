Return-Path: <linux-kernel+bounces-837244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82446BABC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7231C3ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A92BE02D;
	Tue, 30 Sep 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BDMZTUH9"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B126F462
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216296; cv=none; b=H5BKgLtX9GiCAA2fTGzCrF5scPWsmu9J+V7rEWckigr6l2V1SMR6F0W9pOoNK8MAMHdIHDhpcHaNjIY7jR+q9jCPd5SC0sQBhTCB9lxEEHzLT+8PzqMYTP8dH71uU2TMCW+9726po7Jr9n8UmzyM1wKZLGozmPjLKTRNQstjwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216296; c=relaxed/simple;
	bh=wU7LKPEWgp8v64IOBUq45JwQFdXugbm6cOiATPmV9CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DorwumHn1uxDUlg0t6Eb2p17MZTJHH3S4B3gu310s/e91Nf23S0YkqEbYmHY/my+B0QMX4wuW2PMi8WjIhKUjrWpo5k7uSg3M6lgA13qKtjYiQ5DQQCXKdsBPlDLMufFafMbonfieVkdBMXtEjWRYKy9/9cjE5aNRtmBf3ERajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BDMZTUH9; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f9eb204baso39724b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759216293; x=1759821093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR+v3DYyPIQfSuBgQSD/F1YEBoxZbmD+6/3elV5THH0=;
        b=BDMZTUH9pvj1q3ZmJ7w+1z1WJ7tdEfOzM154R+mlWma6AWkQNy2o2uVZUZHgdamTCH
         LLnMNYfZUw+ZUkscYF8SHyXu1SUqRXFDoQgS/Gn2GsZhC+j0GpkcRN1XkEDXvkolecZj
         fHE+wMc3TKMkqj9tIjbw444Lna3I2nIJIAujHGAtDsZXhlozxAp4AVqpFOf2arHPnZfh
         OtIHSdjLyMpX16DZU1xcjoRfxLMCIiVJtbMhmM94bLd6xyWRE+vls9sr6au3ml1+Lm6r
         ZcZwP90A5dQg4nz2eWpwDHcM0ZyrQJY4ECblU+EKzNqyy6pLivZJvUIWt++aZOluuJ4a
         Qp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216293; x=1759821093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR+v3DYyPIQfSuBgQSD/F1YEBoxZbmD+6/3elV5THH0=;
        b=kAoYe2EYzmffWVJmkBTlVwc/Hzb/ddgowx+8tNbyw4Exbe6WG/AtuIn2c9zTWuK6JQ
         dgz12HT5ESrXvmHAc2N+lqMEi7UXCrwdaA5SoflHncCOBjcye92OHSDN+jVYnpMfr85S
         oOYvwskeQ73bsMkJ8lr1korBJe1ybOPStYcRYH5iw5KJLwS6XX3P3Hr2H2mLWzosZO5e
         1fI2Ot6NoO0nS11BTsCEXQVhGOJBhNeOiGYx2sY5Qt7isuJib/SuqaomhR26I+rmb874
         kYEpRnViHnXr4PBC7LCzT9uG88wnxJLD3aEXdCjp+aInmgLlnr/eHaoGEtIIybDhXk8u
         /SpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW52VQaTokfT5sWaYK6aeYJj+5qb31DlWfKpFh77NjY7NZfPFc2uvD7Qer0P2QgWkbclkDGRtPh5/QZBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotvaS1gdLJV1GjjaCJTILcukdh0AnsQ4xrAwvnC8vFIe3+4jJ
	SkW6TFsT6nv0Cnp2K4b8j1aqulYaISY64gxounPbxPD3QstwAwzf14+DKfRLidX42j45gytvxEL
	K8+yZb2JOqMyXrPfN+oRGgd8JCmTq9aQJ2/OPOVCoGA==
X-Gm-Gg: ASbGncsuplqSMBelWJrFvuMeqRDdXZ/lL4HWJk9BbQx3GDRvrKg0rF+/mBKYHMs7G4Q
	DstRmfQBKLl1SGV87vIfafOKowYeZIOAJPtm5segCdt48VdJA7K0IAOaoWa8gwJ4/NCbCQatUwU
	RjUDWkY5LX2O6Qcei6pjQW3ggnK0KR+nZpEd279xNwTSlb5t4VLQc4XlUvAw967EiAWAcVyU9tg
	DXc7di+bETF8HGhGNltlMALBdDlmAfQp8AUd2Sdi1bsbUtb/dc=
X-Google-Smtp-Source: AGHT+IG13enBpViuqbJkl3egtFONm0MWRV/sewI1GNsujGwdIAgHii202fyE/GTui5/tKuBeRANEDhPr69i6SXBk7hQ=
X-Received: by 2002:a05:6808:158d:b0:437:d0a7:e7aa with SMTP id
 5614622812f47-43f9401fe52mr1763089b6e.19.1759216292941; Tue, 30 Sep 2025
 00:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
 <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
 <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com> <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com>
In-Reply-To: <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Sep 2025 15:11:21 +0800
X-Gm-Features: AS18NWBdZh_HxwD18sk9IRGlss7IupBdkXT8d-g2velRw5frfqvDCFq41tp_kn0
Message-ID: <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Doug Anderson <dianders@chromium.org>
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

Hi Doug,

On Tue, Sep 30, 2025 at 9:53=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Tue, Sep 30, 2025 at 6:56=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Sat, Sep 27, 2025 at 7:38=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Sat, Sep 27, 2025 at 4:58=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Hi Doug,
> > > > >
> > > > > On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@c=
hromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@b=
ytedance.com> wrote:
> > > > > > >
> > > > > > > @@ -17,6 +17,7 @@
> > > > > > >  #include <linux/cpu_pm.h>
> > > > > > >  #include <linux/export.h>
> > > > > > >  #include <linux/kernel.h>
> > > > > > > +#include <linux/nmi.h>
> > > > > > >  #include <linux/perf/arm_pmu.h>
> > > > > > >  #include <linux/slab.h>
> > > > > > >  #include <linux/sched/clock.h>
> > > > > > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct ar=
m_pmu *pmu, int cpu)
> > > > > > >         return per_cpu(hw_events->irq, cpu);
> > > > > > >  }
> > > > > > >
> > > > > > > -bool arm_pmu_irq_is_nmi(void)
> > > > > > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > > > > > +bool arch_perf_nmi_is_available(void)
> > > > > > >  {
> > > > > > >         return has_nmi;
> > > > > > >  }
> > > > > > > +#endif
> > > > > >
> > > > > > Should the previous comment move here, AKA:
> > > > > >
> > > > > > /*
> > > > > >  * hardlockup_detector_perf_init() will success even if Pseudo-=
NMI turns off,
> > > > >
> > > > > Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_p=
robe()=E2=80=9D
> > > > >
> > > > > >  * however, the pmu interrupts will act like a normal interrupt=
 instead of
> > > > > >  * NMI and the hardlockup detector would be broken.
> > > > > > */
> > > > > >
> > > > > >
> > > > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > > > +{
> > > > > > > +       return cpufreq_register_notifier(&watchdog_freq_notif=
ier,
> > > > > > > +                                        CPUFREQ_POLICY_NOTIF=
IER);
> > > > > >
> > > > > > I think you need to do something to prevent this from happening=
 on any
> > > > > > platforms that override hw_nmi_get_sample_period(), right? Thes=
e
> > > > > > cpufreq notifiers will be useless in that case...
> > > > >
> > > > > I understand this is not a problem. watchdog_perf uses
> > > > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by=
 the
> > > > > CPU's main frequency. After we make such a change, a larger value=
 may
> > > > > be used as the period, so the NMI period will become longer, but =
this
> > > > > value will not change after the system starts.
> > > >
> > > > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> > > >
> > > > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > {
> > > >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > > > }
> > >
> > > I have added the maintainers for arch/x86.
> > >
> > > 1. cpu_khz can be understood as returning the base operating frequenc=
y
> > > of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> > > downclock to 800MHz under low load and overclock to 4.4GHz under high
> > > load.
> > >
> > > 2. Because the event provided to the PMU has the
> > > PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is based
> > > on 2.3GHz, the execution cycle of watchdog_overflow_callback() is not
> > > fixed; it varies with the CPU's core frequency. When the CPU runs at =
a
> > > frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise,
> > > it will lengthen.
> > >
> > > 3. After our modification, if the architecture is not integrated with
> > > cpufreq, it returns 0 and will not update the cycle. If integrated
> > > with cpufreq, it returns the maximum frequency supported by the CPU,
> > > so the NMI cycle is only slightly lengthened, with no impact on the
> > > actual hardlockup detection function.
> > >
> > > 4. I have also conducted tests:
> > > stress-ng --cpu 1 --taskset 1 --cpu-load 80
> > > echo 800000 > scaling_max_freq
> > > turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectivel=
y.
> > > And the NMI cycle became approximately 30 seconds:
> > > [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu =
=3D 1
> > > [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu =
=3D 1
> >
> > Whether or not having x86 and powerpc start looking at cpufreq is an
> > improvement, certainly it is a change in behavior, right? If we're
> > really changing the behavior here then the commit subject and commit
> > message need to mention this. Right now this is billed as a simple
> > rename...
> >
> > I don't personally have lots of experience with x86 cpufreq but I do
> > know it doesn't work quite the same as how it does on arm. It would
> > definitely be good to get someone on x86 / powerpc to make sure that
> > they are happy with this. ...or you just keep making it work the way
> > it did before and then you don't have to worry about getting any
> > buy-in from x86 / powerpc folks. Up to you, I guess.
>
> Well, I fully agree with your suggestion. What I can think of for now
> is wrapping the newly added content with #if defined(CONFIG_ARM64) ||
> defined(CONFIG_RISCV).

I=E2=80=99ve also thought of an alternative approach: add a generic
WATCHDOG_PERF_ADJUST_PERIOD to /lib/Kconfig.debug, then have the
Kconfig files for arch/arm64 and riscv select
WATCHDOG_PERF_ADJUST_PERIOD. What=E2=80=99s your take on this?

Do you have a more elegant approach to
> recommend?
>
> >
> > Note that folks on x86 have definitely had to deal with turbo mode
> > before.  See commit 7edaeb6841df ("kernel/watchdog: Prevent false
> > positives with turbo modes").
> >
> > -Doug
> >
>
> Thanks,
> Yunhui

Thanks,
Yunhui

