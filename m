Return-Path: <linux-kernel+bounces-764658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70011B225B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E87ACD22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B920C037;
	Tue, 12 Aug 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndZFhlCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445A78F58
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997488; cv=none; b=SCQ/j5gQk3qneTqp+ldxb/o3dPDPlJLBXLuu24lXkjLvgqtKQsQ/DAym6jIwlKSobTZVX9wOa1ktop31iRjF1RDtEQxwgfgboPgUaHJwICs8+YqRW4QmzsWRHWofDGFjVDKk+TqXAGcjtcTYykSn6R5/gB5RsB/xwmEnMlleOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997488; c=relaxed/simple;
	bh=7Vnu2SAXizOmganWVnq92MoEZwyQR7h6ks3qm8nNdWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuS34WlZlXv05aDpH1B5uB4PAuCihk6bUSCPDb7/iUojXuu3yUx8wRmNLzBEB5SWYObuSsd31LGJpuW4wOXk6L6/N7wXCst82i0itSgRTDUVe5P/I3NoC2FmcskHXqgQtgV33F6IGVO1BM8nMTcW6f6TDnmNZ1LTD3Hs2rQvwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndZFhlCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672CC4CEF4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754997487;
	bh=7Vnu2SAXizOmganWVnq92MoEZwyQR7h6ks3qm8nNdWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndZFhlCDbClRwYa2X+fO4oAfoeXoMO97pSPJobpfEJCjmAhTO9gqFTrSc/CE1RADa
	 yyr+cVaqcvDz0KuuRG1QuWYzBwZ5e1cx0gMwya5tD0RaKNMWHA36s1MV3578raJW9t
	 1J/cxF+V7XWR57kpXylFQZ4wP5t7ge0NnxGuVGarf4AJauJ4SIFT7WdQ6Fpg9otAg9
	 Dng+brjO8ym0AxWEHL5bkjBrTfxSIcu58a0owHzw0af6ob9/Pie1CbhJz/6Eq3sdy1
	 F9s92ORCt27TdUJSFoogXgAQ9W54D9z8f+SVz7duragXzhg+Yn4OaiZ6vP5F8lj+sR
	 4QckBZy1x8c+Q==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso887458666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:18:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyNi+GNGC3fXfN99+vqsfMLrFwO+Vt/k1MVp6QsslPR4Eb4uTEQhrMKAATiscSQjf02LiSo9WS3V2jGOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCh6chCxCF8ep9dDwJ0bB0NtMPCZC4ZJ3aRZw65E2lPyjy0hc
	ZV6nMVCN0SEb+cY4IR3qxtB0pveAL6ea8nPofmWH8EbAeanPtZf9CBiw2pyZ3mlSiMSMPcrcz4E
	pZjk7akkQHI9L/IVmuqTgKtJHszaLpog=
X-Google-Smtp-Source: AGHT+IFuln70EdbDCna43QEHC6Ua/glTqjvL9GOMUm7zyBpwQ4o6B64vtc/Kbnzs92VwvbE3JLPNV28gP92hgGWvtgM=
X-Received: by 2002:a17:906:4795:b0:af9:2bb9:ea36 with SMTP id
 a640c23a62f3a-afa1dfa0adcmr279535666b.7.1754997486345; Tue, 12 Aug 2025
 04:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812090056.771379-1-lixianglai@loongson.cn>
In-Reply-To: <20250812090056.771379-1-lixianglai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 19:17:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
X-Gm-Features: Ac12FXzwfoTd-Kc8DAHocCaNJA3fNCOmt3H_v7Qkr8thQcnqDtgu6VuaX6Z3oCg
Message-ID: <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: Xianglai Li <lixianglai@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>, 
	Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Xianglai,

There is something that can be improved.

On Tue, Aug 12, 2025 at 5:24=E2=80=AFPM Xianglai Li <lixianglai@loongson.cn=
> wrote:
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
> Clear the timer interrupt when the timer is turned off
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
>  include/linux/cpuhotplug.h   |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index 367906b10f81..4daa11512eba 100644
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
> @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_eve=
nt_device *evt)
>         timer_config &=3D ~CSR_TCFG_EN;
>         csr_write64(timer_config, LOONGARCH_CSR_TCFG);
>
> +       /* Clear Timer Interrupt */
> +       write_csr_tintclear(CSR_TINTCLR_TI);
> +
>         raw_spin_unlock(&state_lock);
>
>         return 0;
> @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
>         return res;
>  }
>
> +static int arch_timer_dying_cpu(unsigned int cpu)
We can use arch_timer_dying() for short. And then add an
arch_timer_starting() like this:

static int arch_timer_starting(unsigned int cpu)
{
        set_csr_ecfg(ECFGF_TIMER);

        return 0;
}

Though ECFGF_TIMER may be enabled in other places, for syntax we need it he=
re.

> +{
> +       constant_set_state_shutdown(NULL);
> +
> +       return 0;
> +}
> +
>  void __init time_init(void)
>  {
> +       int err;
> +
>         if (!cpu_has_cpucfg)
>                 const_clock_freq =3D cpu_clock_freq;
>         else
> @@ -220,4 +233,11 @@ void __init time_init(void)
>         constant_clockevent_init();
>         constant_clocksource_init();
>         pv_time_init();
> +
> +       err =3D cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_S=
TARTING,
> +                                       "loongarch/timer:starting",
> +                                       NULL, arch_timer_dying_cpu);
Then we need use cpuhp_setup_state() here, because we have a startup
function now.

And "loongarch/timer:starting" should be
"clockevents/loongarch/timer:starting" like others.

And the whole should be moved to the last of
constant_clockevent_init() because it is clockevent specific.

> +       if (err)
> +               pr_info("cpu hotplug event register failed");
This is not so useful, because the error isn't fatal.


Huacai

> +
>  }
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
>
> base-commit: 53e760d8949895390e256e723e7ee46618310361
> --
> 2.39.1
>

