Return-Path: <linux-kernel+bounces-765830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C90B23EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAE31AA19C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD81226C398;
	Wed, 13 Aug 2025 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7qnOZXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAA271450
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054833; cv=none; b=eojZTFxtarHYSA0vAdtxWRI/aZoviTFrnGdxjAtZVsQLVxpUJNrTGpbVrQF2b37+09ywv0H0yqY4I/peK+LyjQPPSe36RaxkS5S3Lv9RMYokxCnmJCuN08ZhGo60eWsgxuNTbSiDcxWFrcB7OutNcvgB3LWE4H/zEbx+qN6No/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054833; c=relaxed/simple;
	bh=to93wvGgdB2JumL5bq5nj5QU70pcOgN2KZVHuFT6VLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc07ceJDj4CzfjRdRHCyyoxoLjRTKZG3ABFiT6Qoa4xFbecMNzmq/H3AmfZL/qPIMBDNnNLgWikpZOzY/XKcexcGF6pos6YxD4nJ2r6gB8vliyDf7mvrYlg0GRcUKMRH+fazLE6ql5a8BMfwQ7azq9qbhDTKDOjL7yRxGBdbj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7qnOZXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE85C4AF0B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755054832;
	bh=to93wvGgdB2JumL5bq5nj5QU70pcOgN2KZVHuFT6VLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y7qnOZXgdriwSkd6iEpRJuONcYfnPCPZX3DLbofh9MbetvOLnSXOaMj8Gu3fguNj/
	 0EXKoQ3MTIzr9B53AR2uhHbwwqXStj0Pi7//yyEssxPDNLnL7JygjUsBM7wMrLl92Z
	 0z5tvRP7ZJZUg+t7RNjiykJE8BMsSNGWrXPMbLlh2e80xLrYvqj4DUHSB/QltlA0Az
	 DmkGD9HXxbZ2eMmGWftmm7QZGUKzK+0BrQLXec2vWwl53bia4ESLdTeTK97xxfErsn
	 vIk+ZpW228O7iMI693C9Mn8WefGzmSDl2aJFpDLnHkv7IoaC8QrJA2kAxzT/WdkZC+
	 HN1Tcd5meV5Tg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af922ab4849so936249666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:13:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXodE7RI5HNpKpVz5wesrAmMQA5dBVoTWy7C2OrvmsFYBmb3DXLhnTnSvAiJY7FFk82TfRx3q9zt/uAGsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YjQGA7MrwMeVcPZpScKMPDkLQkJ6AkSQQhQYnBeo+L6WzBDY
	PAlszullTJe4+ZhXVa9KmHgnn9DD5ERqC4+S+ImOweTF9mA7cU/nzfCHq0lGuNCQC5Om6msl9Ui
	zaSYuTD4Li/sUbsa0xY2ibGAHi+3luC0=
X-Google-Smtp-Source: AGHT+IEBMr0Yr+5+m8zRBSt5Nfl2BWrRavF5q9eWLpCJJbH3XJlbHLHLFXp61Wnsi4jraXxbw6BnPgknNZ+J3Jt41lA=
X-Received: by 2002:a17:907:7f23:b0:af9:61b1:e180 with SMTP id
 a640c23a62f3a-afca4e3e022mr129547866b.41.1755054831245; Tue, 12 Aug 2025
 20:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812090056.771379-1-lixianglai@loongson.cn>
 <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
 <da4311b0-7e8e-647a-260f-1733878cf394@loongson.cn> <CAAhV-H7uhvZeZ9L40AWuRN7t4JAFLNDj4YUOZ_K-oPrCcnpEjA@mail.gmail.com>
 <13a54d23-24c2-8e59-77ac-900a63cd38ef@loongson.cn> <61c858da-8c5e-7652-e580-fc51c211ebb0@loongson.cn>
In-Reply-To: <61c858da-8c5e-7652-e580-fc51c211ebb0@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 13 Aug 2025 11:13:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6P3Ld_-3kf=fTyptpNGnHE8svzQWveKfZTZm8oH795VQ@mail.gmail.com>
X-Gm-Features: Ac12FXzWVAS30dTCeDz6CwYlHV75Fuheb0lW1B1iqio4mK6xSAlXZzAwZ53ojUU
Message-ID: <CAAhV-H6P3Ld_-3kf=fTyptpNGnHE8svzQWveKfZTZm8oH795VQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: lixianglai <lixianglai@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>, 
	Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:27=E2=80=AFAM lixianglai <lixianglai@loongson.cn=
> wrote:
>
> Hi Huacai Chen:
> >> On Tue, Aug 12, 2025 at 8:50=E2=80=AFPM lixianglai <lixianglai@loongso=
n.cn>
> >> wrote:
> >>>
> >>>
> >>> Hi Huacai Chen:
> >>>> Hi, Xianglai,
> >>>>
> >>>> There is something that can be improved.
> >>>>
> >>>> On Tue, Aug 12, 2025 at 5:24=E2=80=AFPM Xianglai Li
> >>>> <lixianglai@loongson.cn> wrote:
> >>>>> When the cpu is offline, the timer under loongarch is not
> >>>>> correctly closed,
> >>>>> resulting in an excessively high cpu usage rate of the offline
> >>>>> vcpu thread
> >>>>> in the virtual machine.
> >>>>>
> >>>>> To correctly close the timer, we have made the following
> >>>>> modifications:
> >>>>>
> >>>>> Register the cpu hotplug timer start event for loongarch.This
> >>>>> event will
> >>>>> be called to close the timer when the cpu is offline.
> >>>>>
> >>>>> Clear the timer interrupt when the timer is turned off
> >>>>>
> >>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> >>>>> ---
> >>>>>    arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
> >>>>>    include/linux/cpuhotplug.h   |  1 +
> >>>>>    2 files changed, 21 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/loongarch/kernel/time.c
> >>>>> b/arch/loongarch/kernel/time.c
> >>>>> index 367906b10f81..4daa11512eba 100644
> >>>>> --- a/arch/loongarch/kernel/time.c
> >>>>> +++ b/arch/loongarch/kernel/time.c
> >>>>> @@ -12,6 +12,7 @@
> >>>>>    #include <linux/kernel.h>
> >>>>>    #include <linux/sched_clock.h>
> >>>>>    #include <linux/spinlock.h>
> >>>>> +#include <linux/cpu.h>
> >>>>>
> >>>>>    #include <asm/cpu-features.h>
> >>>>>    #include <asm/loongarch.h>
> >>>>> @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct
> >>>>> clock_event_device *evt)
> >>>>>           timer_config &=3D ~CSR_TCFG_EN;
> >>>>>           csr_write64(timer_config, LOONGARCH_CSR_TCFG);
> >>>>>
> >>>>> +       /* Clear Timer Interrupt */
> >>>>> +       write_csr_tintclear(CSR_TINTCLR_TI);
> >>>>> +
> >>>>>           raw_spin_unlock(&state_lock);
> >>>>>
> >>>>>           return 0;
> >>>>> @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
> >>>>>           return res;
> >>>>>    }
> >>>>>
> >>>>> +static int arch_timer_dying_cpu(unsigned int cpu)
> >>>> We can use arch_timer_dying() for short. And then add an
> >>>> arch_timer_starting() like this:
> >>>>
> >>>> static int arch_timer_starting(unsigned int cpu)
> >>>> {
> >>>>           set_csr_ecfg(ECFGF_TIMER);
> >>>>
> >>>>           return 0;
> >>>> }
> >>>>
> >>>> Though ECFGF_TIMER may be enabled in other places, for syntax we
> >>>> need it here.
> >>>>
> >>>>> +{
> >>>>> +       constant_set_state_shutdown(NULL);
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +
> >>>>>    void __init time_init(void)
> >>>>>    {
> >>>>> +       int err;
> >>>>> +
> >>>>>           if (!cpu_has_cpucfg)
> >>>>>                   const_clock_freq =3D cpu_clock_freq;
> >>>>>           else
> >>>>> @@ -220,4 +233,11 @@ void __init time_init(void)
> >>>>>           constant_clockevent_init();
> >>>>>           constant_clocksource_init();
> >>>>>           pv_time_init();
> >>>>> +
> >>>>> +       err =3D
> >>>>> cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> >>>>> + "loongarch/timer:starting",
> >>>>> +                                       NULL, arch_timer_dying_cpu)=
;
> >>>> Then we need use cpuhp_setup_state() here, because we have a startup
> >>>> function now.
> >>>>
> >>>> And "loongarch/timer:starting" should be
> >>>> "clockevents/loongarch/timer:starting" like others.
> >>>>
> >>>> And the whole should be moved to the last of
> >>>> constant_clockevent_init() because it is clockevent specific.
> >>> like this?
> >>>
> >>> @@ -164,6 +182,10 @@ int constant_clockevent_init(void)
> >>>
> >>>           timer_irq_installed =3D 1;
> >>>
> >>> + cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> >>> + "clockevents/loongarch/timer:starting",
> >>> +                         arch_timer_starting, arch_timer_dying_cpu);
> >>> +
> >>>           sync_counter();
> >>>
> >>>
> >>> I was wondering whether it should be placed before or after the
> >>> "timer_irq_installed" judgment
> >> Should be after "timer_irq_installed" because we only need to run once=
.
> >>
> >> The best place is after pr_info("Constant clock event device
> >> register\n");
> >
> > Got it!
> >> And there is another question:
> >> Should we move "write_csr_tintclear(CSR_TINTCLR_TI)" from
> >> constant_set_state_shutdown() to arch_timer_dying()?
> >
> > We may not need to do this. If the context in which the timer is
> > turned off is to disable interrupts, and the last timing period just
> > arrives during this process, when the interrupt is re-enabled,
> > an additional interrupt will be triggered and the next timing expiratio=
n
> > time will be filled. This is not in line with expectations.
> > Isn't it more reasonable to clean up the interrupt flag after turning o=
ff
> > the timer instead of just doing so cpu offline context cleaning.
> >
>
> This is my personal opinion, but I just trace the process of cpu offline
> and need to clear the timer interrupt.
> Because is not particularly proficient in of the overall system
> architecture, I might have a one-sided view.
> Do you have a better suggestion?
Without this patch constant_set_state_shutdown() seems work well, so I
think clearing interrupt may only needed by cpuhotplug. The reason is
that the timer interrupt handler doesn't work when the cpu is offline,
but not in other cases.

However, whether the clearing is in constant_set_state_shutdown() or
not are both OK for me.

Huacai

>
> Thanks!
> Xianglai.
>
> > Thanks!
> > Xianglai.
> >
> >>
> >> Huacai
> >>
> >>>
> >>>>> +       if (err)
> >>>>> +               pr_info("cpu hotplug event register failed");
> >>>> This is not so useful, because the error isn't fatal.
> >>>>
> >>>>
> >>>> Huacai
> >>>>
> >>>>> +
> >>>>>    }
> >>>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.=
h
> >>>>> index edfa61d80702..6606c1546afc 100644
> >>>>> --- a/include/linux/cpuhotplug.h
> >>>>> +++ b/include/linux/cpuhotplug.h
> >>>>> @@ -159,6 +159,7 @@ enum cpuhp_state {
> >>>>>           CPUHP_AP_PERF_ARM_STARTING,
> >>>>>           CPUHP_AP_PERF_RISCV_STARTING,
> >>>>>           CPUHP_AP_ARM_L2X0_STARTING,
> >>>>> +       CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> >>>>>           CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
> >>>>>           CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> >>>>>           CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
> >>>>>
> >>>>> base-commit: 53e760d8949895390e256e723e7ee46618310361
> >>>>> --
> >>>>> 2.39.1
> >>>>>
> >>>
> >
>

