Return-Path: <linux-kernel+bounces-764860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2576B22802
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B656A627C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380B265292;
	Tue, 12 Aug 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M29NhZ/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28010E0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004088; cv=none; b=BOSCmH6LR4m7tIKj4GLJ4HeshUP1QM+oZTXtnenYslB0QLn3irexL10/gb5uwjZic/bGxzO6Txzkvls95MRxHML0/DQNoonrn+BAhJC2Eb5+xxJuZr/HXBNEG+b4z7PDpTASTFPzeysrUXFAcEO+XgTN2mmgEfkvHueSnkdoeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004088; c=relaxed/simple;
	bh=ENhWohJdXUUS1MTKMDzA+YV47rv2W52JUPatF4v3k3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCJ4JObx9TptcSigHwWV8z7T1O+l8Zayq3k0BTchWN196IAc/SmqXDFTMbceQac/DaRqgfJq9H2BoqwMUoM1oE0eA+CsdXgUXdpt/C30u5UG6FDHSsMIMt1j3Z4U/rv9O1DPhrNchMeluADQp1GRzhSwvz/3BApI5LM4yO8bUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M29NhZ/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E2C4CEF0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004088;
	bh=ENhWohJdXUUS1MTKMDzA+YV47rv2W52JUPatF4v3k3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M29NhZ/i88MJ4kLTiJe5o5anL94vD05MhPgXB9incJoLT8Daq1yC9kuH8YbTjpdqJ
	 bYeDcwkutQUNa4Vcy2Q7+Ae766dekpT9iK5mHRAyXb1RGWLBq12dQvSaP/8AL6N5NN
	 jNICy+Exy7jTpB5EsAKUwppVS7uV+HVZShKFjbAskDx3sqp6XaZnv+exiRfTCKEvRU
	 fBprfDbNAMxs0dFtrSi+af/HD0RQj5gfoAQuTe1Z3A6oSNiEP9lfbyl2MTmhz+ipfM
	 DRj4dOQMvJfE6K1a3gAr5JPEZuAsOjp70B6om17fZDwpenozOXdvTUROuu6+2cy0Sc
	 +jqqIRT9SZ03A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso7181645a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUiDYvKj3x+Fqh0jrTNCcPqAE5VmFd6nz7KMadcBmhSbkSqsLeMu+IfGyMpp0TX7QBYn1h6H/5pB9g9vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aeSjBAjLALryIzUebptKc7hcgBSqPb+rNQxibd9Z+k6lVPAf
	LTpJRwyANoFmuMepg9OlsUIXv1oUOOinMDb+dVdAtzE6h33M+jpUk7lWM8xg60j2b+kZgA9vLpl
	5kUeZkQxXn+YqjcRAZdtfA9vWC7Fw4dM=
X-Google-Smtp-Source: AGHT+IFudGAnAFNiT6SjRp7L6THpqvsswlm2XoTOBcXgnG826IQRjdWdOaRmSDIzP6PFrFKdc346NTBYaqIUnwW3j4g=
X-Received: by 2002:a05:6402:13c4:b0:617:ddc1:ddf4 with SMTP id
 4fb4d7f45d1cf-617e2bc5edfmr14149378a12.14.1755004086575; Tue, 12 Aug 2025
 06:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812090056.771379-1-lixianglai@loongson.cn>
 <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com> <da4311b0-7e8e-647a-260f-1733878cf394@loongson.cn>
In-Reply-To: <da4311b0-7e8e-647a-260f-1733878cf394@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 21:07:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7uhvZeZ9L40AWuRN7t4JAFLNDj4YUOZ_K-oPrCcnpEjA@mail.gmail.com>
X-Gm-Features: Ac12FXz4ArCfTVS2xsBmacHl-EbcS_6v8wbSGA2j9iZLcyhYLOzDDTQrG_ys3Xg
Message-ID: <CAAhV-H7uhvZeZ9L40AWuRN7t4JAFLNDj4YUOZ_K-oPrCcnpEjA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: lixianglai <lixianglai@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>, 
	Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:50=E2=80=AFPM lixianglai <lixianglai@loongson.cn>=
 wrote:
>
>
>
> Hi Huacai Chen:
> > Hi, Xianglai,
> >
> > There is something that can be improved.
> >
> > On Tue, Aug 12, 2025 at 5:24=E2=80=AFPM Xianglai Li <lixianglai@loongso=
n.cn> wrote:
> >> When the cpu is offline, the timer under loongarch is not correctly cl=
osed,
> >> resulting in an excessively high cpu usage rate of the offline vcpu th=
read
> >> in the virtual machine.
> >>
> >> To correctly close the timer, we have made the following modifications=
:
> >>
> >> Register the cpu hotplug timer start event for loongarch.This event wi=
ll
> >> be called to close the timer when the cpu is offline.
> >>
> >> Clear the timer interrupt when the timer is turned off
> >>
> >> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> >> ---
> >>   arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
> >>   include/linux/cpuhotplug.h   |  1 +
> >>   2 files changed, 21 insertions(+)
> >>
> >> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time=
.c
> >> index 367906b10f81..4daa11512eba 100644
> >> --- a/arch/loongarch/kernel/time.c
> >> +++ b/arch/loongarch/kernel/time.c
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/sched_clock.h>
> >>   #include <linux/spinlock.h>
> >> +#include <linux/cpu.h>
> >>
> >>   #include <asm/cpu-features.h>
> >>   #include <asm/loongarch.h>
> >> @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_=
event_device *evt)
> >>          timer_config &=3D ~CSR_TCFG_EN;
> >>          csr_write64(timer_config, LOONGARCH_CSR_TCFG);
> >>
> >> +       /* Clear Timer Interrupt */
> >> +       write_csr_tintclear(CSR_TINTCLR_TI);
> >> +
> >>          raw_spin_unlock(&state_lock);
> >>
> >>          return 0;
> >> @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
> >>          return res;
> >>   }
> >>
> >> +static int arch_timer_dying_cpu(unsigned int cpu)
> > We can use arch_timer_dying() for short. And then add an
> > arch_timer_starting() like this:
> >
> > static int arch_timer_starting(unsigned int cpu)
> > {
> >          set_csr_ecfg(ECFGF_TIMER);
> >
> >          return 0;
> > }
> >
> > Though ECFGF_TIMER may be enabled in other places, for syntax we need i=
t here.
> >
> >> +{
> >> +       constant_set_state_shutdown(NULL);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   void __init time_init(void)
> >>   {
> >> +       int err;
> >> +
> >>          if (!cpu_has_cpucfg)
> >>                  const_clock_freq =3D cpu_clock_freq;
> >>          else
> >> @@ -220,4 +233,11 @@ void __init time_init(void)
> >>          constant_clockevent_init();
> >>          constant_clocksource_init();
> >>          pv_time_init();
> >> +
> >> +       err =3D cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIME=
R_STARTING,
> >> +                                       "loongarch/timer:starting",
> >> +                                       NULL, arch_timer_dying_cpu);
> > Then we need use cpuhp_setup_state() here, because we have a startup
> > function now.
> >
> > And "loongarch/timer:starting" should be
> > "clockevents/loongarch/timer:starting" like others.
> >
> > And the whole should be moved to the last of
> > constant_clockevent_init() because it is clockevent specific.
>
> like this?
>
> @@ -164,6 +182,10 @@ int constant_clockevent_init(void)
>
>          timer_irq_installed =3D 1;
>
> +       cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> +                         "clockevents/loongarch/timer:starting",
> +                         arch_timer_starting, arch_timer_dying_cpu);
> +
>          sync_counter();
>
>
> I was wondering whether it should be placed before or after the
> "timer_irq_installed" judgment
Should be after "timer_irq_installed" because we only need to run once.

The best place is after pr_info("Constant clock event device register\n");

And there is another question:
Should we move "write_csr_tintclear(CSR_TINTCLR_TI)" from
constant_set_state_shutdown() to arch_timer_dying()?


Huacai

>
>
> >> +       if (err)
> >> +               pr_info("cpu hotplug event register failed");
> > This is not so useful, because the error isn't fatal.
> >
> >
> > Huacai
> >
> >> +
> >>   }
> >> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> >> index edfa61d80702..6606c1546afc 100644
> >> --- a/include/linux/cpuhotplug.h
> >> +++ b/include/linux/cpuhotplug.h
> >> @@ -159,6 +159,7 @@ enum cpuhp_state {
> >>          CPUHP_AP_PERF_ARM_STARTING,
> >>          CPUHP_AP_PERF_RISCV_STARTING,
> >>          CPUHP_AP_ARM_L2X0_STARTING,
> >> +       CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> >>          CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
> >>          CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> >>          CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
> >>
> >> base-commit: 53e760d8949895390e256e723e7ee46618310361
> >> --
> >> 2.39.1
> >>
>
>

