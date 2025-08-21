Return-Path: <linux-kernel+bounces-779436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E8B2F418
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184C13BBE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BC2D9ED8;
	Thu, 21 Aug 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGl+HZep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1A1DF74F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768994; cv=none; b=qzvuFR1pDbsvgAd9JUWHcZ0tMlGetoGOkaJfJB3TZg8Sg4Y+6bL6F99mFyiRnUbYDZ1xDjwmFB6THw5ExBEp9GvZg+jqw9lgtBBOBNvbslImbnUJ7GxHHDy9BoeCJcxeZxh6t2LnfF6SnHIIG/UNknqVOn+BiwccrcfC/6OmtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768994; c=relaxed/simple;
	bh=nqx9qiv0zX+m1DlAVHHEFQpBiJu5QKpiHNQao79cgLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx7Q9T2e2TfQRYKxGdqO2CNHXJBtZHT7s9MDF9JB1RiIEZJ/dBhvtwBSipDHqsaCmh4HTfFICYZx3qvPSY4GErLy/Kf4vIFIjZb15E1qPRewkTp8wrooddozbXysO24ZN/VwW9hRYeKH6Z1iAiB8j3TpWN1iqfMFPHaNXdGNMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGl+HZep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F263C116C6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755768994;
	bh=nqx9qiv0zX+m1DlAVHHEFQpBiJu5QKpiHNQao79cgLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LGl+HZepvSYTrSZQvPJz2CzFJjrPyIOlh2klCFObTfOrWk89AotH5iuMttASQbhRi
	 Igy+IKt1CzX8mQbM8uVBWL38CND+hu2eGAxD6+zoJs1UuFv88OgIukQJGOeSphEKag
	 vHP7epmux7UVDxIAaL0SUuQdMbaAW9EtxGkETU8aa/XDyyiqRrso5/37GxqIcsraip
	 zHMSiUihE/fZNEF6o9MLFOR4MTaQB//Jc38+L7h9XknM0RgSvRWrfrFpIo7BCZB7V1
	 AL1AVh1T1PAHvzEooatgXVC2khIcvjplxrqPXscyvR5mVvDbZUHks1bblPh6wjSzQD
	 PPk4EGJ542FtA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so1080969a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:36:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVare05ft/z/6aeCw1YmCE3CZcRWdKv5MpcRpkR5dq2wBXgBj/OTz/X38eOe/SNQtNGSWVCOm8Nt/WJ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3ClAKSDdt3rck6rDPt2ARU8FMeMq75aA+/rAKgp3jlURrIft
	yvZxpNgj3FneD8xoRnWdg+s+CV2OdpwIdPkMKXjIuVVDTo5UJ4U2XsFPopu0yj00OWUVBEDOlkP
	5R2DGd2Biwpbve70dhKt+QD2dr0lae3o=
X-Google-Smtp-Source: AGHT+IFEA4wBZ6jlw56hAlRjDBUN+5W/lUtKr64PRv6Oy8jgud1DgDbvtzdnv5gAySIvxnJ+6+zjVTdFxjbAUHGHioE=
X-Received: by 2002:a05:6402:34cc:b0:61a:7e43:65f7 with SMTP id
 4fb4d7f45d1cf-61bf8728294mr1495394a12.18.1755768992966; Thu, 21 Aug 2025
 02:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820021551.911917-1-lixianglai@loongson.cn>
In-Reply-To: <20250820021551.911917-1-lixianglai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 21 Aug 2025 17:36:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4+HQ9tZTKUgBqfkjDQnvhqVRcXy+yH0ZrYmCZoiv0BQA@mail.gmail.com>
X-Gm-Features: Ac12FXzhmiV55DKl9Us75CDtoKOVW4ffSqRstkEZquCXTuKFhGBz-lQsu-aTTUA
Message-ID: <CAAhV-H4+HQ9tZTKUgBqfkjDQnvhqVRcXy+yH0ZrYmCZoiv0BQA@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: time: Fix the issue of high cpu usage of
 vcpu threads in virtual machines
To: Xianglai Li <lixianglai@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>, 
	Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Aug 20, 2025 at 10:39=E2=80=AFAM Xianglai Li <lixianglai@loongson.c=
n> wrote:
>
> When the cpu is offline, the timer under loongarch is not correctly close=
d,
> resulting in an excessively high cpu usage rate of the offline vcpu threa=
d
> in the virtual machine.
>
> To correctly close the timer, we have made the following modifications:
>
> Register the cpu hotplug timer start event for loongarch.This event will
> be called to close the timer when the cpu is offline.
>
> Clear the timer interrupt when the timer is turned off, Because before th=
e
> timer is turned off, there may be a timer interrupt that has been in the
> pending state due to the interruption of the disabled, which also affects
> the halt state of the offline vcpu.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> V1->V2:
> 1.Add the implementation of the function arch_timer_starting
> 2.Add more descriptions about clear timer interrupts in the commit messag=
e
> 3.Delete useless prints
> 4.Adjust the calling position of the function cpuhp_setup_state
> 5.Adjust the timer interrupt clear position
>
>  arch/loongarch/kernel/time.c | 22 ++++++++++++++++++++++
>  include/linux/cpuhotplug.h   |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index 367906b10f81..09b95f28bdcc 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched_clock.h>
>  #include <linux/spinlock.h>
> +#include <linux/cpu.h>
>
>  #include <asm/cpu-features.h>
>  #include <asm/loongarch.h>
> @@ -102,6 +103,23 @@ static int constant_timer_next_event(unsigned long d=
elta, struct clock_event_dev
>         return 0;
>  }
>
> +static int arch_timer_dying_cpu(unsigned int cpu)
> +{
> +       constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_dev=
ice));
> +
> +       /* Clear Timer Interrupt */
> +       write_csr_tintclear(CSR_TINTCLR_TI);
> +
> +       return 0;
> +}
> +
> +static int arch_timer_starting(unsigned int cpu)
> +{
> +       set_csr_ecfg(ECFGF_TIMER);
> +
> +       return 0;
> +}
> +
>  static unsigned long get_loops_per_jiffy(void)
>  {
>         unsigned long lpj =3D (unsigned long)const_clock_freq;
> @@ -172,6 +190,10 @@ int constant_clockevent_init(void)
>         lpj_fine =3D get_loops_per_jiffy();
>         pr_info("Constant clock event device register\n");
>
> +       cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
> +                         "clockevents/loongarch/timer:starting",
> +                         arch_timer_starting, arch_timer_dying_cpu);
> +
>         return 0;
>  }
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index edfa61d80702..6606c1546afc 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -159,6 +159,7 @@ enum cpuhp_state {
>         CPUHP_AP_PERF_ARM_STARTING,
>         CPUHP_AP_PERF_RISCV_STARTING,
>         CPUHP_AP_ARM_L2X0_STARTING,
> +       CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>         CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>         CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>         CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
> --
> 2.39.1
>
>

