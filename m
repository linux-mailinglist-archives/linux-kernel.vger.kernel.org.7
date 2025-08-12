Return-Path: <linux-kernel+bounces-764672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37354B225D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352AF506841
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000C2ED842;
	Tue, 12 Aug 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVghQ63g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9C2EBDF8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997703; cv=none; b=n+sqZbtTKt7qxvkBsz2ifEdTPbBnuztWThDuhEeOLwQn70uzpqzz0yMvj6wehatp0rsVw5fpV9bHNzDngwtDnsTymtYBfxyEsDhI/SRbJ8zmXz/YsioCiY/IFp9wTXpCN78k8fXp/rLiFYFACsZeYje1zh8xcQ7cyi3ZuonkUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997703; c=relaxed/simple;
	bh=QpSx0vVwmunATald4q+nbzkGiZccZAod5vd2t8eYlus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFps9QbfdkqXuX6yLqewtcFKB7QV3HT6+1gZv78R0AKAyJmcbLZyccWYvaCXFM0+r/tgdnD19mAuDHfZTzdJBn8bCCynjPVpufbi3rFbokT0/VfQjX7NDA63stft+Erl8xlX4NmuCzSxzZ8D3g2gYGXJuh83p+mcs4QsH6H1HFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVghQ63g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE21C4CEF4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754997702;
	bh=QpSx0vVwmunATald4q+nbzkGiZccZAod5vd2t8eYlus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sVghQ63g0pOc4RU3v/vQpXOA4pS/Pgtqu8A1awAiyaNcn1qABdXF8ALLpgKgTp7ER
	 LMKa9aA+IOSgwF31vn2RzSOVQj1ugIGsMuiZoSF+cF0DFO/Vt53uOUYrsl+r8mkAj1
	 zXiJXYKBt8s08kuTgnY/sJmM2BW7VbWk+A4VxPG+9MaEp8HSeYBExTmXJXthB7UqS8
	 L1eh/KXC9Mi8Qo6eO6bqNUDV4WOPshEWTz9oa4MHPYI5sqck3UaHj2ASWCS0tiNzcc
	 Bc/G6cgr1bUPGX+CXoHt0AViQth5eKvgInuFoHfirYOHfWizGsFfBLab4jymMIBTvJ
	 +/UfCEwWoJ0Rg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61557997574so7620930a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:21:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUelYl3Kja2hVkmH5DL4rt1t1kzERLj0UXTKGKtWiyM0JcxXf8U7wiwhcGslySyqwgrkTQHN5aqRYwNGT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFajerlXaEw0ektKdjySoykjW0JEStAk2KuBl79ubvuj5m1sG
	EfGQVNci3J6GoZ+ctv6HuHqFwAxsNMtuj6jAsck00enymqpAwe+1o4hxsBJgBQ44gYnj/+Sj2wK
	qHE8PUjqYqGMOEnoVQd+9xyt1y1FzZfo=
X-Google-Smtp-Source: AGHT+IFY/od7koJy5dTouxPiA9x5+/+fmDNGhnExgJDsA2/upYVkDKf+le9JjNuHT5zycG6IxanvaebNxSaC6aN0nbY=
X-Received: by 2002:aa7:da50:0:b0:617:fe86:6bff with SMTP id
 4fb4d7f45d1cf-6184eb3596emr1766781a12.8.1754997701412; Tue, 12 Aug 2025
 04:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812090056.771379-1-lixianglai@loongson.cn> <f271abd3-e1b6-0968-abf8-6f1b74e21f65@loongson.cn>
In-Reply-To: <f271abd3-e1b6-0968-abf8-6f1b74e21f65@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 19:21:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H72TWAwxV5bcHMej_8=cH1GxJVJxKMASWpPXVcq++FUWg@mail.gmail.com>
X-Gm-Features: Ac12FXx9ex-QfAOCcoFmUNWnDdRgUyz_kPrVvH4euA-XDaC-zbaXP6m02_F_F1Y
Message-ID: <CAAhV-H72TWAwxV5bcHMej_8=cH1GxJVJxKMASWpPXVcq++FUWg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:50=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2025/8/12 =E4=B8=8B=E5=8D=885:00, Xianglai Li wrote:
> > When the cpu is offline, the timer under loongarch is not correctly clo=
sed,
> > resulting in an excessively high cpu usage rate of the offline vcpu thr=
ead
> > in the virtual machine.
> >
> > To correctly close the timer, we have made the following modifications:
> >
> > Register the cpu hotplug timer start event for loongarch.This event wil=
l
> > be called to close the timer when the cpu is offline.
> >
> > Clear the timer interrupt when the timer is turned off
> During timer is turned off, timer interrupt may be arriving. Here adding
> EOI with timer after disabling it so that there is no pending timer
> interrupt when offline cpu is halted state.
> >
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> >   arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
> >   include/linux/cpuhotplug.h   |  1 +
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.=
c
> > index 367906b10f81..4daa11512eba 100644
> > --- a/arch/loongarch/kernel/time.c
> > +++ b/arch/loongarch/kernel/time.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/sched_clock.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/cpu.h>
> >
> >   #include <asm/cpu-features.h>
> >   #include <asm/loongarch.h>
> > @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_e=
vent_device *evt)
> >       timer_config &=3D ~CSR_TCFG_EN;
> >       csr_write64(timer_config, LOONGARCH_CSR_TCFG);
> >
> > +     /* Clear Timer Interrupt */
> > +     write_csr_tintclear(CSR_TINTCLR_TI);
> > +
> >       raw_spin_unlock(&state_lock);
> >
> >       return 0;
> > @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
> >       return res;
> >   }
> >
> > +static int arch_timer_dying_cpu(unsigned int cpu)
> > +{
> NULL is a little strange here, how about something like this?
>
>          struct clock_event_device *evt;
>
>          evt =3D this_cpu_ptr(constant_clockevent_device);
>          constant_set_state_shutdown(evt);
Both OK for me, if really needed, we can use
constant_set_state_shutdown(this_cpu_ptr(constant_clockevent_device))
for short.


Huacai

>
> Regards
> Bibo Mao
>
> > +     constant_set_state_shutdown(NULL);
> > +
> > +     return 0;
> > +}
> > +
> >   void __init time_init(void)
> >   {
> > +     int err;
> > +
> >       if (!cpu_has_cpucfg)
> >               const_clock_freq =3D cpu_clock_freq;
> >       else
> > @@ -220,4 +233,11 @@ void __init time_init(void)
> >       constant_clockevent_init();
> >       constant_clocksource_init();
> >       pv_time_init();
> > +
> > +     err =3D cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_S=
TARTING,
> > +                                     "loongarch/timer:starting",
> > +                                     NULL, arch_timer_dying_cpu);
> > +     if (err)
> > +             pr_info("cpu hotplug event register failed");
> > +
> >   }
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index edfa61d80702..6606c1546afc 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -159,6 +159,7 @@ enum cpuhp_state {
> >       CPUHP_AP_PERF_ARM_STARTING,
> >       CPUHP_AP_PERF_RISCV_STARTING,
> >       CPUHP_AP_ARM_L2X0_STARTING,
> > +     CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> >       CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
> >       CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> >       CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
> >
> > base-commit: 53e760d8949895390e256e723e7ee46618310361
> >
>
>

