Return-Path: <linux-kernel+bounces-882993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86114C2C3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A3E42336C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3E30C613;
	Mon,  3 Nov 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k5QAeU1S"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA601D5ACE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177023; cv=none; b=Pr8IhfEJLL2Ts8Px1CT6XbehbAKhMMSbM6Rdm4DkDyFYOm0wH+0BR70cgbIuYck4v+nY+jgv2DZ/Sdl1qM1XRGw5uuNP8wgxQhWVlfFz8oICwrfr3x+cGU7aPjD8jRfyJjBjXIwvgHtjBrEgGkkm9Ww3GCbX7MBDeSpRDlPbSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177023; c=relaxed/simple;
	bh=sV2NzZ9MuKiSd0jFkuwPru5WDmqFqHDoVXqfXuCBIgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BypeHbn1i3yBlYIiic87LnK1l3PzIhkwUcwMvB4vhjzvtg09nOy8mvPozIOuBqt97LjI+RehyqI88WZvkZDGrzENrz1NnMlxSYdDs/VYX3JxoYgAKPRHv8GMvd5EI/BpslZvb3aucKsV29nSvJHT/COZOK2o1A9Vl4d2nZNZHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k5QAeU1S; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3d5bb03d5c2so3099318fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762177019; x=1762781819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x2PNH1XVpX0/xUj5h6A40SdIzafWZ2JQ7TPS4dKdos=;
        b=k5QAeU1SZHHcKj7GnTTxE7cL6Z/kzdib61BVvv5AYwuZqL69xG0PB3UaXtx+tw0Dhd
         1wSjX60s4aKaCgBNDIX7HHVxn0GTbt1gBre/wgFaVKzh1Ga4Or0Y09J4Gfb0+PfDcUPB
         xQWjtc+ENDSV3a76lm/3uhbbrit8AfLmdXkrRmh1tDaJ8P3npErFIpciF1R2f/TBJ3jf
         pfPiqLNXQ/H/etH6Rfd1q4+PgzCOBAWKm1uwHgRzLDgjAkswO6ltm9tcC0o61aZ42EIs
         Q7H/VCzyJ8XzjbFGX8yibiFcruks1XA8JhAe7PIkRh44bfbcKgddE2IM5DTUFZhpObJq
         Y8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177019; x=1762781819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x2PNH1XVpX0/xUj5h6A40SdIzafWZ2JQ7TPS4dKdos=;
        b=wQ4YPGxux9oV7gbVvVMWbVXrwW/ci+quq/h9nt0f5inMtgVuMlPLxiSPTwkRxR3Ba/
         TUIc7gma6m60jWLcunznfGJOJ5Vyh6Mfdkf3Uw9mIlCBqUus5h6gCGqmBzZ8fhpLKIG4
         1Nx1+/mfHyPbXi7zLKEbye4BCqaKEjoRaZ4phcs185udjy/hrYw1KyQp8I2bJNQKv2Ng
         4LE7d7qV8AMBQfd4EtyiNdS6Q7Ann3ThiJD0TKlbtBtWKC/oyk4NLYnd+/za/tSM6s0Y
         rICRDEj0N3LQBlgxtXss8KucidMbgoykeAczXfaXb24YKOgdEh4DoSZ6i3PO3f6g/chC
         +uSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwWgvjUGLx/AJ+w6uTkwN02UX3mUs3CXF+//Yn0l7U4GlBJ76WbODdHBP7/1kqjJLQ8Bbh5nj1Ts5FXJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9EGMMncrgrLVDMDnFIj5Sj672krtOlNDf/ZyYJC9QKmTwedNQ
	aJqok2wK2Lqs94YhigOuDvp/bv7reQmbecbg1XRrWb3+/remuCTVT/AaSeKRS9oz1RoGtFM3a2r
	N6PpL+Va1xDhtn7EGgzcJfx7wsF/jjN8DYbf2ymfP4A==
X-Gm-Gg: ASbGncvyfDItE+vIR7XgpOJVSBjsUR+Q9UuhqSlrVX9PEdTWjk76t5+WmOWEXG2UL7R
	PzwaNiGUyBsfv6hoxItxbdtjMJoC74iRyisN2TKHT2gANQBruYmfvLnrTsLCYdVRdIAAmoLuPxp
	xU3Krq/g9kLQ0dv/wAr7mZMD8jXP1loi6fZe8V5WiVRUPScA/qY0qjb9dRqHIgGHQjf5yDG5aZU
	0j1jxlrQcIkk9Iet8w0citLrFg53APGmi54QyIXb5hLwzXjv8xSTFmUtaCr6dlOnE0GbYcTCA==
X-Google-Smtp-Source: AGHT+IGvvlL4yPDC4GadAbAGY6MLbxgjhf94hWJQ4VciM9/6vXBnEXuXzrMgo6y3rVzva/mjZSRd1Awa/215L7uCAaA=
X-Received: by 2002:a05:6808:4fd4:b0:43f:5c61:448d with SMTP id
 5614622812f47-44f95e34f34mr4997678b6e.9.1762177018667; Mon, 03 Nov 2025
 05:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com> <20251028-scallion-list-c8aa5f350286@spud>
In-Reply-To: <20251028-scallion-list-c8aa5f350286@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 3 Nov 2025 21:36:47 +0800
X-Gm-Features: AWmQ_bn0FO04sfOT2IjBFc6WCQCcorPHQqVl8YCrf5iAWjzDZDV_z5j46SPZDU8
Message-ID: <CAEEQ3wngRa-YHbrodOVhSoRzam4MSd8ihxXEd-6rhBmx_rtzTg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, luxu.kernel@bytedance.com, atishp@rivosinc.com, 
	cleger@rivosinc.com, ajones@ventanamicro.com, apatel@ventanamicro.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	songshuaishuai@tinylab.org, bjorn@rivosinc.com, charlie@rivosinc.com, 
	masahiroy@kernel.org, valentina.fernandezalanis@microchip.com, 
	jassisinghbrar@gmail.com, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tue, Oct 28, 2025 at 6:42=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Oct 27, 2025 at 09:34:31PM +0800, Yunhui Cui wrote:
> > NMI is more robust than IPI for stopping CPUs during crashes,
> > especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NMI
> > eventid to implement NMI for stopping CPUs.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/crash.h   |  1 +
> >  arch/riscv/include/asm/sbi.h     |  1 +
> >  arch/riscv/kernel/crash.c        | 31 +++++++++++++-
> >  drivers/firmware/riscv/sse_nmi.c | 71 +++++++++++++++++++++++++++++++-
> >  include/linux/sse_nmi.h          |  8 ++++
> >  5 files changed, 109 insertions(+), 3 deletions(-)
> >  create mode 100644 include/linux/sse_nmi.h
> >
> > diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/cr=
ash.h
> > index b64df919277d4..5076f297cbc15 100644
> > --- a/arch/riscv/include/asm/crash.h
> > +++ b/arch/riscv/include/asm/crash.h
> > @@ -5,6 +5,7 @@
> >
> >  #ifdef CONFIG_KEXEC_CORE
> >  void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
> > +void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
> >  #else
> >  static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs=
 *regs)
> >  {
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 52d3fdf2d4cc1..65cce85237879 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
> >  #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS    0x00108000
> >  #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED        0xffff0000
> >  #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI              0xffff0001
> > +#define SBI_SSE_EVENT_LOCAL_CRASH_NMI                0xffff0002
> >  #define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED       0xffff8000
> >
> >  #define SBI_SSE_EVENT_PLATFORM               BIT(14)
> > diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
> > index 12598bbc2df04..9f3f0becfdd95 100644
> > --- a/arch/riscv/kernel/crash.c
> > +++ b/arch/riscv/kernel/crash.c
> > @@ -3,14 +3,16 @@
> >  #include <linux/cpu.h>
> >  #include <linux/delay.h>
> >  #include <linux/kexec.h>
> > +#include <linux/sse_nmi.h>
> >  #include <linux/smp.h>
> >  #include <linux/sched.h>
> >
> > +#include <asm/crash.h>
> >  #include <asm/cpu_ops.h>
> >
> >  static atomic_t waiting_for_crash_ipi =3D ATOMIC_INIT(0);
> >
> > -inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> > +void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> >  {
> >       crash_save_cpu(regs, cpu);
> >
> > @@ -27,6 +29,11 @@ inline void ipi_cpu_crash_stop(unsigned int cpu, str=
uct pt_regs *regs)
> >               wait_for_interrupt();
> >  }
> >
> > +inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> > +{
> > +     cpu_crash_stop(cpu, regs);
> > +}
> > +
> >  /*
> >   * The number of CPUs online, not counting this CPU (which may not be
> >   * fully online and so not counted in num_online_cpus()).
> > @@ -38,6 +45,24 @@ static inline unsigned int num_other_online_cpus(voi=
d)
> >       return num_online_cpus() - this_cpu_online;
> >  }
> >
> > +#ifdef CONFIG_RISCV_SSE_NMI
> > +static int send_nmi_stop_cpu(cpumask_t *mask)
> > +{
> > +     unsigned int cpu;
> > +     int ret =3D 0;
> > +
> > +     for_each_cpu(cpu, mask)
> > +             ret +=3D carsh_nmi_stop_cpu(cpu);
>
> +=3D ? I don't really get why this sort of overcomplication is needed, wh=
y
> not just return immediately here with a real error code, since you're
> going to have to go to the ipi fallback anyway?

A cpumask may be needed to mark the CPUs where NMI failed, and then
continue to stop the CPUs via IPI.

>
> > +
> > +     return ret;
> > +}
> > +#else
> > +static inline int send_nmi_stop_cpu(cpumask_t *mask)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >  void crash_smp_send_stop(void)
> >  {
> >       static int cpus_stopped;
> > @@ -66,7 +91,9 @@ void crash_smp_send_stop(void)
> >       atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
> >
> >       pr_crit("SMP: stopping secondary CPUs\n");
> > -     send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
> > +
> > +     if (send_nmi_stop_cpu(&mask))
> > +             send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
> >
> >       /* Wait up to one second for other CPUs to stop */
> >       timeout =3D USEC_PER_SEC;
> > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/=
sse_nmi.c
> > index 2c1eaea2bbabc..152d787075345 100644
> > --- a/drivers/firmware/riscv/sse_nmi.c
> > +++ b/drivers/firmware/riscv/sse_nmi.c
> > @@ -4,13 +4,16 @@
> >
> >  #include <linux/nmi.h>
> >  #include <linux/riscv_sbi_sse.h>
> > +#include <linux/sse_nmi.h>
> >  #include <linux/sysctl.h>
> >
> > +#include <asm/crash.h>
> >  #include <asm/irq_regs.h>
> >  #include <asm/sbi.h>
> >
> >  int unknown_nmi_panic;
> >  static struct sse_event *unknown_nmi_evt;
> > +static struct sse_event *crash_nmi_evt;
> >  static struct ctl_table_header *unknown_nmi_sysctl_header;
> >
> >  static int __init setup_unknown_nmi_panic(char *str)
> > @@ -32,6 +35,12 @@ const struct ctl_table unknown_nmi_table[] =3D {
> >       },
> >  };
> >
> > +static inline struct sbiret sbi_sse_ecall(int fid, unsigned long arg0,
> > +                                       unsigned long arg1)
> > +{
> > +     return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
> > +}
> > +
> >  static int unknown_nmi_handler(u32 evt, void *arg, struct pt_regs *reg=
s)
> >  {
> >       pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_i=
d());
> > @@ -73,9 +82,69 @@ static int unknown_nmi_init(void)
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_KEXEC_CORE
> > +int carsh_nmi_stop_cpu(unsigned int cpu)
>
> typo: crash

Okay.

>
> > +{
> > +     unsigned int hart_id =3D cpuid_to_hartid_map(cpu);
> > +     u32 evt =3D SBI_SSE_EVENT_LOCAL_CRASH_NMI;
> > +     struct sbiret ret;
> > +
> > +     ret =3D sbi_sse_ecall(SBI_SSE_EVENT_INJECT, evt, hart_id);
> > +     if (ret.error) {
> > +             pr_err("Failed to signal event %x, error %ld\n", evt, ret=
.error);
>
> Isn't this going to emit pointless (and maybe confusing) error messages
> on systems that enable the option but don't support SSE? And it's going
> to be one for each secondary CPU too.

Okay, I'll fix this in the next version.

>
> > +             return sbi_err_map_linux_errno(ret.error);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int crash_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
> > +{
> > +     cpu_crash_stop(smp_processor_id(), regs);
> > +
> > +     return 0;
> > +}
> > +
> > +static int crash_nmi_init(void)
> > +{
> > +     int ret;
> > +
> > +     crash_nmi_evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_CRASH_NM=
I, 0,
> > +                              crash_nmi_handler, NULL);
> > +     if (IS_ERR(crash_nmi_evt))
> > +             return PTR_ERR(crash_nmi_evt);
> > +
> > +     ret =3D sse_event_enable(crash_nmi_evt);
> > +     if (ret) {
> > +             sse_event_unregister(crash_nmi_evt);
> > +             return ret;
> > +     }
> > +
> > +     pr_info("Using SSE for crash NMI event delivery\n");
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> >  static int __init sse_nmi_init(void)
> >  {
> > -     return unknown_nmi_init();
> > +     int ret;
> > +
> > +     ret =3D unknown_nmi_init();
> > +     if (ret) {
> > +             pr_err("Unknown_nmi_init failed with error %d\n", ret);
> > +             return ret;
> > +     }
>
> This change looks like it shouldn't be in this patch, if you want it to
> print an error, just do that from the start?

Okay.

>
> > +
> > +#ifdef CONFIG_KEXEC_CORE
>
> Can this be IS_ENABLED() or does crash_nmi_init() not have a stub?

I'll add a stub function in the next version, so no more #ifdef
CONFIG_KEXEC_CORE here.

>
> > +     ret =3D crash_nmi_init();
> > +     if (ret) {
> > +             pr_err("Crash_nmi_init failed with error %d\n", ret);
> > +             return ret;
> > +     }
> > +#endif
> > +
> > +     return 0;
> >  }
> >
> >  late_initcall(sse_nmi_init);
> > diff --git a/include/linux/sse_nmi.h b/include/linux/sse_nmi.h
> > new file mode 100644
> > index 0000000000000..548a348ac0a46
> > --- /dev/null
> > +++ b/include/linux/sse_nmi.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_RISCV_SSE_NMI_H
> > +#define __LINUX_RISCV_SSE_NMI_H
> > +
> > +int carsh_nmi_stop_cpu(unsigned int cpu);
> > +
> > +#endif
> > --
> > 2.39.5
> >

Thanks,
Yunhui

