Return-Path: <linux-kernel+bounces-824173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD906B88469
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AE01C878A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33A2EAD13;
	Fri, 19 Sep 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Grb3j0HG"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41C2EB5C0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268340; cv=none; b=XKnU5CMUKx9e4y5D2qmcemh1wHlAVgBceaL/v9CHszi6gfEHMZiTKB8wymzICGWHqP7BwHK+41acqPynpIUO2rVHVAQUxslSnClWn6L+hsFN2hwnlbn77U9e1ULz99d2tv60BVuanWWmigieMPy7C6L//e4gpV4kBCAOnk6nXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268340; c=relaxed/simple;
	bh=8obywSQJ/xmg3WtDnSG13UUELGZHHwEO04/uTIP+9DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u98HhFaqNyU2JpxvhvKB/FuznAHQQpRnrQZ65muv38db47U5XUFU1HKnCDB9vnrbMEUGNHqC6MLAJ4Lrf8m+bOsQIUv/uPe0nfWJMZET/Uy6LmXRp6ULQg2IqYfDZEzBkcFHsFn+NshBB0AgnGKog2EFJvyU8BYIlRTuhohXHgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Grb3j0HG; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3305aceab00so901388fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758268337; x=1758873137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP5v61DcWR0npM9XGzP9QRf4i7M8VdPYZ8EzlkbskQY=;
        b=Grb3j0HGeAO10fOzsrTGPURUvKF49T1wx+k0Nk4GK5GcLOj7GLJDcfKhcs+2BvdHKK
         CfEJJ4MixQcwRjHchaO3TZWT7WOiw6ykcbWhkJyY2Qp/fhBiosikpp628YksXAfTcGO8
         LwENYP7EJ9DnW7vyyUwpXYaHz3jBSo+2mFjGBuGzkNNBtSIwFVpTmMGg7kw+o0+UypZc
         NnKOMRNrK9Iq3dfs0eyh31Y0okcE5FJ52vw6jLmrWupeBlkd95LuaPXqvicJFsZSExvh
         uxwsmATSeMMm4ur6cZkrtng9tsdL3pw7Fo8K+Q+tViXVwLomtl2frXUr8gmtknVg/vTu
         3MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268337; x=1758873137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP5v61DcWR0npM9XGzP9QRf4i7M8VdPYZ8EzlkbskQY=;
        b=QmgGuFctykO3Y2HWtvcoAf3vwejcgAkI3qbihP2I+w31rKozNjJFMoXURrLzVMata9
         3RQEr8wCNSUQetK4JPsTcBcLUuulzOUezjVMbEMPXQMBxQg9gF9WEKYlDsOqG0q9FU+u
         svhT0bcFSvi8rca69M72phkPCPjZCLfYR0ujaERw6wDpHhv+wUWYUJgZwZKLiOXNb8pJ
         Ll1EaWsRytxdqqdtq0+pfAudASzyz5Pkyp1Cr5ypMtm1ikSod8oKhhF7flsELX3K4R8O
         Timu64IjJXn9gXBBcZr07rlQtoZDBrRV8vqyc1wPbvg8BzLKDVB3Z1LBFv2j40kSysDU
         FhmA==
X-Forwarded-Encrypted: i=1; AJvYcCX+yB/hpHPrImPpQaqsMn+ao4Y/YRQarfilcpDzNs7DYSt3gJMhuEykk1KBK0BEzoUJA++YDGnc+6pmFnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKi6/eRIe3j7rOwl7zI6mOhE0RKhFE3hiyPzrscM75HyOV9oAJ
	6Fp9Jgcdx345Fr+5jXM4Mm5IkmNzhWKfqTgVfcE4xvkyPy9iJvWTAIab6RoS1id3AO46Gd5VQtl
	/ic1rdU7hRLvDz3aYErKcBdBY/Zd0QfDeVqKZCV0yD2fzO/FT/sbVkPdGaitv
X-Gm-Gg: ASbGnctCogrwSgnsvqkooi6hZ2hLhxfSxobh8TaSxF7O5XPppWc0eA+ctPAF9nnk++b
	QLJGjlF6Lz4miobHMwlMOPQe+JlEUFUJRMArMecOrODOaxqxJ9ppA8iCeJRCoZwYeWfex+8MVJ2
	jFy6G03OVlLYAZh3Nx2a2Or/Ofun9QLVtSQGQv9YSZl7vEAbZCUJ0y1JNp8SsErmeH7hidV25ae
	2lAsV8R4ZHmgnWXCFUo
X-Google-Smtp-Source: AGHT+IEBnW4z9AmI4VxlHxhjfD0na9kXgwRmbwPRjQzLSxtLo50CDbAwqixrAUkenpe9jUFSM4wSS6MadHv2IdRBbEY=
X-Received: by 2002:a05:6871:7a14:b0:315:a087:71e5 with SMTP id
 586e51a60fabf-33bb3ff70a2mr1263523fac.25.1758268337126; Fri, 19 Sep 2025
 00:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com> <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
In-Reply-To: <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 19 Sep 2025 15:52:05 +0800
X-Gm-Features: AS18NWDYFZfpbhYXFeekhZPcceSOGnqbfdDxxsO6hWHlOxekMpKbAiofdZPa31c
Message-ID: <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, conor@kernel.org, atishp@rivosinc.com, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 19/09/2025 09:00, Yunhui Cui wrote:
> > Unknown NMI can force the kernel to respond (e.g., panic) when the
> > system encounters unrecognized critical hardware events, aiding in
> > troubleshooting system faults. This is implemented via the Supervisor
> > Software Events (SSE) framework.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/sbi.h     |  1 +
> >  drivers/firmware/riscv/Kconfig   | 10 +++++
> >  drivers/firmware/riscv/Makefile  |  1 +
> >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++++
> >  4 files changed, 89 insertions(+)
> >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 874cc1d7603a5..5801f90a88f62 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> >
> >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000001
> > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0x0000000=
2
>
> Was this submitted to the PRS WG ? This a specification modification so
> it should go through the usual process.
>
> >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kc=
onfig
> > index ed5b663ac5f91..746bac862ac46 100644
> > --- a/drivers/firmware/riscv/Kconfig
> > +++ b/drivers/firmware/riscv/Kconfig
> > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> >         this option provides support to register callbacks on specific =
SSE
> >         events.
> >
> > +config RISCV_SSE_UNKNOWN_NMI
> > +     bool "Enable SBI Supervisor Software Events unknown NMI support"
> > +     depends on RISCV_SBI_SSE
> > +     default y
> > +     help
> > +       This option enables support for delivering unknown Non-Maskable=
 Interrupt (NMI)
> > +       notifications via the Supervisor Software Events (SSE) framewor=
k. When enabled,
> > +       unknown NMIs can trigger kernel responses (e.g., panic) for unr=
ecognized critical
> > +       hardware events, aiding in system fault diagnosis.
> > +
> >  endmenu
> > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/M=
akefile
> > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > --- a/drivers/firmware/riscv/Makefile
> > +++ b/drivers/firmware/riscv/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/=
sse_nmi.c
> > new file mode 100644
> > index 0000000000000..43063f42efff0
> > --- /dev/null
> > +++ b/drivers/firmware/riscv/sse_nmi.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/mm.h>
> > +#include <linux/nmi.h>
> > +#include <linux/riscv_sbi_sse.h>
> > +#include <linux/sched/debug.h>
> > +#include <linux/sysctl.h>
> > +
> > +#include <asm/irq_regs.h>
> > +#include <asm/sbi.h>
> > +
> > +int panic_on_unknown_nmi =3D 1;
> > +struct sse_event *evt;
> > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > +
> > +const struct ctl_table unknown_nmi_table[] =3D {
> > +     {
> > +             .procname       =3D "panic_enable",
> > +             .data           =3D &panic_on_unknown_nmi,
> > +             .maxlen         =3D sizeof(int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE,
> > +     },
> > +};
> > +
> > +static void nmi_handler(struct pt_regs *regs)
> > +{
> > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_i=
d());
> > +
> > +     if (panic_on_unknown_nmi)
> > +             nmi_panic(regs, "NMI: Not continuing");
> > +
> > +     pr_emerg("Dazed and confused, but trying to continue\n");
> > +}
>
> I'm dazed and confused as well ;) What's the point of this except
> interrupting the kernel with a panic ? It seems like it's a better idea
> to let the firmware handle that properly and display whatever
> information are needed. Was your idea to actually force the kernel to
> enter in some debug mode ?

There is an important scenario: when the kernel becomes unresponsive,
we need to trigger an unknown NMI to cause the system to panic() and
then collect the vmcore, and such a requirement is common on x86
servers.

>
> Thanks,
>
> Cl=C3=A9ment
>
> > +
> > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
> > +{
> > +     nmi_handler(regs);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sse_nmi_init(void)
> > +{
> > +     int ret;
> > +
> > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
> > +                              nmi_sse_handler, NULL);
> > +     if (IS_ERR(evt))
> > +             return PTR_ERR(evt);
> > +
> > +     ret =3D sse_event_enable(evt);
> > +     if (ret) {
> > +             sse_event_unregister(evt);
> > +             return ret;
> > +     }
> > +
> > +     unknown_nmi_sysctl_header =3D register_sysctl("kernel", unknown_n=
mi_table);
> > +     if (!unknown_nmi_sysctl_header) {
> > +             sse_event_disable(evt);
> > +             sse_event_unregister(evt);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     pr_info("Using SSE for NMI event delivery\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init unknow_nmi_init(void)
> > +{
> > +     return sse_nmi_init();
> > +}
> > +
> > +late_initcall(unknow_nmi_init);
>

Thanks,
Yunhui

