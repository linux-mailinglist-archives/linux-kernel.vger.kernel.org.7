Return-Path: <linux-kernel+bounces-828116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B8B93FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA2189FE43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51D19258E;
	Tue, 23 Sep 2025 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PEhFJ0D+"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A22F5B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593733; cv=none; b=Po9CuzqyDvsezwnTFe6A5M5hGCZZ+XkT1grDc5AIPvSCC2RDbgrtH7SKw52a4Jqnlh5jwvkyzpGRzkkCjviFX8BUUq05rbdfMP6eLNjxieU4ysPbRBlRcy8I/97iV6+zkZhFBDgiVLBSS5xzmztKLOrgT8DA7rx6ixeQggnaSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593733; c=relaxed/simple;
	bh=YOSQgSQojjaApDTBWTY5KxTIY/EjO+hAoXdD89mKdsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM57KGXBAXk2xQRi4B0ENVv0pGeeVhLC0ioTaWGm/l+U1C6ZGbuxyX3l0zr15hUB9abTv6F20CFENVIVqTsGg+DaCdPQSWAJ+aDcCI05ySJvRBjYytJUpBi0VPBcEksa4MnJA7zFmo203MpEYUdKhd+m1uEw4aqi6GSUC9nV4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PEhFJ0D+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cceb3be82so4305306fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758593730; x=1759198530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eQH+Q/BQXEhgQYu1pd1EXuK3o31quj91cNDcQrzCl8=;
        b=PEhFJ0D+9qHkiYM6rQrQ0DhPK8G0e2c3Yi1w5hs/FhlGr7ouNLC+i8NMyrmTiSvs9T
         RFRk8titmYjOWpIt7ujSiaoPpP3X53I17HGCaxyslU8Ys59ADkZt4wE+M212YN9wiAG3
         6+VLPqPNgL1IfMBggrFFdzdwts51E2lmwMbDNWwBJjJcyIcGIA9Uz3lzl1fB2TYevGfq
         mfcag+XvAuZdqUNLyKzIkpfLv3+Ll2kBkkWEj8gWaglb8ke8scgXx5cVYDSXQfjHNIHS
         V1/IyeQayPguHyxr9Tz6OSsHtVUHJdANXyxPDuA8/6rlsTMaJ9wShQuEp6j3K/tFaqpY
         CFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758593730; x=1759198530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eQH+Q/BQXEhgQYu1pd1EXuK3o31quj91cNDcQrzCl8=;
        b=ZhbgOEHrDF/zcxPYXfAt1QdMvLUcvf06QlBH9e3esmOEUfMroPX9yEDIAX1sCZfh1M
         SssaOl0Ln5gPn/nSykBCfcRtuFYnr26inq5W76j9FPTVkGUgKaxM+1KrFMfgBkpL5XeV
         fe/JQzGZNNffHW5YIxwbnyEMM9Bc5jIGknmbsi94kJvhz/jt+ptCC3O9HrLyqFEwBnWe
         aXCXFJ9u2A8mJqm2I3PP4HVBXol84Wh5qyEkQpvVO77R73ESEWnLykNQlN4XIJbRBtd9
         HI0GRqlyn84r4wZIDi3/V9G7VCFLQBzH29pIxrSU2domS1p3C3w9or7kLlklb/f7bWFV
         fHjA==
X-Forwarded-Encrypted: i=1; AJvYcCXat+dNnTB/XoA5Kr2YR3ov52KPJTHPNzC4rK/+awQi51XOYaHNxE68yisl73Q8TkIw+LBKawNJhOF8fco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECbdpMtEhfnggH9xQp1IsNWTguiME2lNbeK0vFhJucN29D7Rs
	VxHHmcaTtjY/+ekSmJbLZcFulBJdjITqhPhHpwSXdooRb3OXQpJqxf1gI9uckhUukHCKKHLYcL9
	MEwp7rYauAU9YtsrYTSrBm4sg80L7EvTHAVyvIkKyuA==
X-Gm-Gg: ASbGncu68iBawVBAdBfOjuX5F6XR2skT13FQ4v13KCYQE3t0NHOYVVBo1yRjpJbXjxy
	DJtCd63Fjm30ethroJ8ILTpUvNpKcGyakevj8YtbWDkufLqxtiTdU046wmPPduF/sB48Rn2GrU0
	fUrnl3oLA7yU07h/OC1CcKo4x259wCbHBHySO/8/7BBo8ZkRUyWftAzBVyBlU6fkgLGwTEhApfs
	KiWI3KrFEgMPiPMQ64w
X-Google-Smtp-Source: AGHT+IFo8K2nq2pvsFZGvxQ/MRgGmpmKRhgup8ijbEKRYusV/i24RmK6pHRHQfH8m8ZyulD9ZJHlbp9bEZu7JmN9zoM=
X-Received: by 2002:a05:6871:2b0c:b0:331:15b8:807 with SMTP id
 586e51a60fabf-34c88354f2bmr555585fac.41.1758593729902; Mon, 22 Sep 2025
 19:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com> <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
 <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
 <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
 <CAAhSdy3ioaOBxO++XBBWfx9RRH-7BJQDLR0q6sSEr2m8W2cdwg@mail.gmail.com>
 <CAEEQ3wmDFfmbr0fGxNUOX16p0b5zeR8bKTDTePuCFPYaKOyuqg@mail.gmail.com> <CAHBxVyHgdm4amuicRB26Cy-vVd8wCB-YWt5gQW7yh_Bp7fEDhg@mail.gmail.com>
In-Reply-To: <CAHBxVyHgdm4amuicRB26Cy-vVd8wCB-YWt5gQW7yh_Bp7fEDhg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Sep 2025 10:15:18 +0800
X-Gm-Features: AS18NWAaYvaC1hGOJAAqFL22W54c1XHylEK_8p3Zuj7EoyToUMrdjOWGjkTsL6c
Message-ID: <CAEEQ3wm0fmWcyKU8r9d=kpZY4QkGgqwmQzVMBcYJ2pu-aRGSvg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, conor@kernel.org, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Atish,

On Tue, Sep 23, 2025 at 1:20=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Mon, Sep 22, 2025 at 4:58=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Anup,
> >
> > On Mon, Sep 22, 2025 at 6:40=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > On Mon, Sep 22, 2025 at 1:42=E2=80=AFPM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Hi Cl=C3=A9ment,
> > > >
> > > > On Fri, Sep 19, 2025 at 3:52=E2=80=AFPM yunhui cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Hi Cl=C3=A9ment,
> > > > >
> > > > > On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <=
cleger@rivosinc.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 19/09/2025 09:00, Yunhui Cui wrote:
> > > > > > > Unknown NMI can force the kernel to respond (e.g., panic) whe=
n the
> > > > > > > system encounters unrecognized critical hardware events, aidi=
ng in
> > > > > > > troubleshooting system faults. This is implemented via the Su=
pervisor
> > > > > > > Software Events (SSE) framework.
> > > > > > >
> > > > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/sbi.h     |  1 +
> > > > > > >  drivers/firmware/riscv/Kconfig   | 10 +++++
> > > > > > >  drivers/firmware/riscv/Makefile  |  1 +
> > > > > > >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++=
++++++++++
> > > > > > >  4 files changed, 89 insertions(+)
> > > > > > >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> > > > > > >
> > > > > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/includ=
e/asm/sbi.h
> > > > > > > index 874cc1d7603a5..5801f90a88f62 100644
> > > > > > > --- a/arch/riscv/include/asm/sbi.h
> > > > > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > > > > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> > > > > > >
> > > > > > >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> > > > > > >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000=
001
> > > > > > > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                     =
 0x00000002
> > > > > >
> > > > > > Was this submitted to the PRS WG ? This a specification modific=
ation so
> > > > > > it should go through the usual process.
> > > > > >
> > > > > > >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> > > > > > >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> > > > > > >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > > > > > > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmwar=
e/riscv/Kconfig
> > > > > > > index ed5b663ac5f91..746bac862ac46 100644
> > > > > > > --- a/drivers/firmware/riscv/Kconfig
> > > > > > > +++ b/drivers/firmware/riscv/Kconfig
> > > > > > > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> > > > > > >         this option provides support to register callbacks on=
 specific SSE
> > > > > > >         events.
> > > > > > >
> > > > > > > +config RISCV_SSE_UNKNOWN_NMI
> > > > > > > +     bool "Enable SBI Supervisor Software Events unknown NMI=
 support"
> > > > > > > +     depends on RISCV_SBI_SSE
> > > > > > > +     default y
> > > > > > > +     help
> > > > > > > +       This option enables support for delivering unknown No=
n-Maskable Interrupt (NMI)
> > > > > > > +       notifications via the Supervisor Software Events (SSE=
) framework. When enabled,
> > > > > > > +       unknown NMIs can trigger kernel responses (e.g., pani=
c) for unrecognized critical
> > > > > > > +       hardware events, aiding in system fault diagnosis.
> > > > > > > +
> > > > > > >  endmenu
> > > > > > > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmwa=
re/riscv/Makefile
> > > > > > > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > > > > > > --- a/drivers/firmware/riscv/Makefile
> > > > > > > +++ b/drivers/firmware/riscv/Makefile
> > > > > > > @@ -1,3 +1,4 @@
> > > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > > >
> > > > > > >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > > > > > > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > > > > > > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmw=
are/riscv/sse_nmi.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000000000..43063f42efff0
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/firmware/riscv/sse_nmi.c
> > > > > > > @@ -0,0 +1,77 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +
> > > > > > > +#include <linux/mm.h>
> > > > > > > +#include <linux/nmi.h>
> > > > > > > +#include <linux/riscv_sbi_sse.h>
> > > > > > > +#include <linux/sched/debug.h>
> > > > > > > +#include <linux/sysctl.h>
> > > > > > > +
> > > > > > > +#include <asm/irq_regs.h>
> > > > > > > +#include <asm/sbi.h>
> > > > > > > +
> > > > > > > +int panic_on_unknown_nmi =3D 1;
> > > > > > > +struct sse_event *evt;
> > > > > > > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > > > > > > +
> > > > > > > +const struct ctl_table unknown_nmi_table[] =3D {
> > > > > > > +     {
> > > > > > > +             .procname       =3D "panic_enable",
> > > > > > > +             .data           =3D &panic_on_unknown_nmi,
> > > > > > > +             .maxlen         =3D sizeof(int),
> > > > > > > +             .mode           =3D 0644,
> > > > > > > +             .proc_handler   =3D proc_dointvec_minmax,
> > > > > > > +             .extra1         =3D SYSCTL_ZERO,
> > > > > > > +             .extra2         =3D SYSCTL_ONE,
> > > > > > > +     },
> > > > > > > +};
> > > > > > > +
> > > > > > > +static void nmi_handler(struct pt_regs *regs)
> > > > > > > +{
> > > > > > > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_p=
rocessor_id());
> > > > > > > +
> > > > > > > +     if (panic_on_unknown_nmi)
> > > > > > > +             nmi_panic(regs, "NMI: Not continuing");
> > > > > > > +
> > > > > > > +     pr_emerg("Dazed and confused, but trying to continue\n"=
);
> > > > > > > +}
> > > > > >
> > > > > > I'm dazed and confused as well ;) What's the point of this exce=
pt
> > > > > > interrupting the kernel with a panic ? It seems like it's a bet=
ter idea
> > > > > > to let the firmware handle that properly and display whatever
> > > > > > information are needed. Was your idea to actually force the ker=
nel to
> > > > > > enter in some debug mode ?
> > > > >
> > > > > There is an important scenario: when the kernel becomes unrespons=
ive,
> > > > > we need to trigger an unknown NMI to cause the system to panic() =
and
> > > > > then collect the vmcore, and such a requirement is common on x86
> > > > > servers.
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Cl=C3=A9ment
> > > > > >
> > > > > > > +
> > > > > > > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_reg=
s *regs)
> > > > > > > +{
> > > > > > > +     nmi_handler(regs);
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int sse_nmi_init(void)
> > > > > > > +{
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_=
NMI, 0,
> > > > > > > +                              nmi_sse_handler, NULL);
> > > >
> > > > Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI sp=
ec?
> > >
> > > The ratified SBI v3.0 defines a "Software injected local event" (ID 0=
xffff0000)
> > > which can be used to inject panic() on a particular HART from another=
 HART.
> >
> > Has SBI_SSE_EVENT_LOCAL_SOFTWARE (0xffff0000) been given meaning
> > currently? The scenario of the unknown NMI is that after a HART
> > receives an interrupt from the platform, M-mode responds to this
>
> Which interrupt ? A standard one or platform specific one ?

Platform specific one.
Are there any recommended event IDs? Or should a new UNKNOWN NMI event
ID be added to the SBI spec?

>
> > interrupt and then enters S-mode to execute the registered handler.
> > Can SBI_SSE_EVENT_LOCAL_SOFTWARE be used directly?
> >
> >
> > >
> > > Regards,
> > > Anup
> >
> > Thanks,
> > Yunhui

Thanks,
Yunhui

