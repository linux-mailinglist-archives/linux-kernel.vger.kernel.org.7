Return-Path: <linux-kernel+bounces-827679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74181B92643
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B843A5B50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926C313541;
	Mon, 22 Sep 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VLNu/cQB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983132E9743
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561617; cv=none; b=gwXbS0sIlByMTlKQDmWnCr2yixpdLL62v5pgB7WrvjyDO1/5Kuohg9Hm3CGcb1e9OwvdqwmW3xB4zdT5ybbCcILGb8DTwgnvX5b5mf4d78P0eJ/DV6qKigxGyaagvreWErD5Sp3tTX+CNP9MzI1FMCFycJjhe7cjLfldL289SqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561617; c=relaxed/simple;
	bh=vIkYNvuwFnFQFATO+JFn0WXfz0U+YKo0oflJrXC7UGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Nmp/D7GbK8hLG0VDsrnPK8VoEIBgVEeQh0tXevylMPL6cfJVJ33qAp3ZPkVD0cNn8P5pUk5BkRfywUcWujYpbfI0ROoxh/cHB4ZP9CzyRB4pm4dhZkUnpfCOBqMibmqL3SBH7ZZlLFUI6NgdG2vqjiASXgKxbLmfC0KVl12Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VLNu/cQB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2153184a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758561615; x=1759166415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuXiZkuCzHr0FvIM9EjTHty5sC7Ahnw4MxvPy9OfLdU=;
        b=VLNu/cQBhrVaNRRUYSmq8CoKNGWKQNyBbsZ3Uaqk/eUmkM05ccMA8kiaGx1cvx+J8b
         MwoFWsy4gJy9P71oLMSteNtQiiEjhW6EWecm8ORYkSbbV95MSikYUE5NwFe3U0u/nbB+
         R6cp4ukREKMUioHdYgiznFLNheiGCtjm8/rm6oATstDCwU+S2TczKSSkCpe7JDv0TQS/
         K5+ozeTMh0JY9wOMqiSX4Naz5U2JmQjsOCe3aVjVJxktiV1HjfOVk4UuUdcAGbkDbyaB
         If4tOF/S4RvDrRtJMhl9uF8J8zadDjtxuFOLRJAw7JIrGhhDJnscYRWyXBbfoDiaYjQR
         +jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561615; x=1759166415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuXiZkuCzHr0FvIM9EjTHty5sC7Ahnw4MxvPy9OfLdU=;
        b=CelzoQJJbZmiLIIy4ljczfCB4p8rODWuY0XVrVMiXq3k+OKCsuT8QYnM/FaIc8fA9B
         rJSs3Z5iRDx20fJsxX0LMINjJDw8uZOdWUFiHUuI9SbVeG90/bdmOUi5OpcTqk5MbJHH
         s19GhmWYGL2gExVmy21EunDVrQCsjVNL59+aRIRm9MLPINR77HDK4fKuLvQ7vgxQfdzH
         +iiF1qkJ4XxDte00lumwLCMtTAkacLj9zhJ53/zgRJW8aQZIjJOweXQsW737S24teWqL
         wVLy8hZcX1Ac7qQR6G/PmpNRMlBjfwlsFbshROpadkOAtSEyqsK8PSQje8v3ERqc77Ce
         hwfA==
X-Forwarded-Encrypted: i=1; AJvYcCWm5dJ81w4Cqlk60BMf0DHcH8B6LTs3Z069KUvNA9guKcORalKUGBR44AByQPMbkylWZcaTjGBWdqihW3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+88ZG0zSReazfnkmnouGC7R7bv+Vu0XL/PMoI4a1r7hedeUrW
	KBDyVX5s6Ad3732zHmz4cxUUxl6rPTUMeOMm6paAhAS9Kp37b4+QeQ68QGsYoLbMnUbStvAjeO0
	C4dnLZ4S1YzslMLNrvpGakkkIM8nLucdlwIapB0DDRw==
X-Gm-Gg: ASbGncuO5G8ovklHgPnFxC2LpW+iRFR/Il1p+Sce2tBG4SB2sRuBIPSr1Y+QWYuTDsM
	MoS9GwK2b9sxUW6Cq52ifnkeDI1A8wZ2ZE9w1Y+rRIZGH7BcQ4bHjqB0+s9z8AJmpJJg5ROg/F3
	+z5tOx/Uv0aCnLi8YuGbZAQQ3+24NW3saC+YHbkqM5cjWMVAmKvuI5nTfhzyMv9vE2/qVMMlUCL
	IY72Q==
X-Google-Smtp-Source: AGHT+IFTttnmZqDzi8zOx9w+G3Sjs1pUW8dvwEyQTxC5g7hPtxCsNtCpLx/xIf2Mzzipor1lWhR3Jf6UgjgaVrlb+sk=
X-Received: by 2002:a17:90b:4c10:b0:32e:3830:65e1 with SMTP id
 98e67ed59e1d1-33098385815mr15578731a91.33.1758561614634; Mon, 22 Sep 2025
 10:20:14 -0700 (PDT)
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
 <CAAhSdy3ioaOBxO++XBBWfx9RRH-7BJQDLR0q6sSEr2m8W2cdwg@mail.gmail.com> <CAEEQ3wmDFfmbr0fGxNUOX16p0b5zeR8bKTDTePuCFPYaKOyuqg@mail.gmail.com>
In-Reply-To: <CAEEQ3wmDFfmbr0fGxNUOX16p0b5zeR8bKTDTePuCFPYaKOyuqg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 22 Sep 2025 10:20:03 -0700
X-Gm-Features: AS18NWCsdyFlElOCGZXcX9traMsT6pdCxjgT2ZFn2KpFjcOlBWhNgNh9i5QAVbo
Message-ID: <CAHBxVyHgdm4amuicRB26Cy-vVd8wCB-YWt5gQW7yh_Bp7fEDhg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Anup Patel <anup@brainfault.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, conor@kernel.org, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:58=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Anup,
>
> On Mon, Sep 22, 2025 at 6:40=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Mon, Sep 22, 2025 at 1:42=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Cl=C3=A9ment,
> > >
> > > On Fri, Sep 19, 2025 at 3:52=E2=80=AFPM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Hi Cl=C3=A9ment,
> > > >
> > > > On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cl=
eger@rivosinc.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 19/09/2025 09:00, Yunhui Cui wrote:
> > > > > > Unknown NMI can force the kernel to respond (e.g., panic) when =
the
> > > > > > system encounters unrecognized critical hardware events, aiding=
 in
> > > > > > troubleshooting system faults. This is implemented via the Supe=
rvisor
> > > > > > Software Events (SSE) framework.
> > > > > >
> > > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/sbi.h     |  1 +
> > > > > >  drivers/firmware/riscv/Kconfig   | 10 +++++
> > > > > >  drivers/firmware/riscv/Makefile  |  1 +
> > > > > >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++=
++++++++
> > > > > >  4 files changed, 89 insertions(+)
> > > > > >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/=
asm/sbi.h
> > > > > > index 874cc1d7603a5..5801f90a88f62 100644
> > > > > > --- a/arch/riscv/include/asm/sbi.h
> > > > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > > > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> > > > > >
> > > > > >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> > > > > >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x0000000=
1
> > > > > > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0=
x00000002
> > > > >
> > > > > Was this submitted to the PRS WG ? This a specification modificat=
ion so
> > > > > it should go through the usual process.
> > > > >
> > > > > >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> > > > > >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> > > > > >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > > > > > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/=
riscv/Kconfig
> > > > > > index ed5b663ac5f91..746bac862ac46 100644
> > > > > > --- a/drivers/firmware/riscv/Kconfig
> > > > > > +++ b/drivers/firmware/riscv/Kconfig
> > > > > > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> > > > > >         this option provides support to register callbacks on s=
pecific SSE
> > > > > >         events.
> > > > > >
> > > > > > +config RISCV_SSE_UNKNOWN_NMI
> > > > > > +     bool "Enable SBI Supervisor Software Events unknown NMI s=
upport"
> > > > > > +     depends on RISCV_SBI_SSE
> > > > > > +     default y
> > > > > > +     help
> > > > > > +       This option enables support for delivering unknown Non-=
Maskable Interrupt (NMI)
> > > > > > +       notifications via the Supervisor Software Events (SSE) =
framework. When enabled,
> > > > > > +       unknown NMIs can trigger kernel responses (e.g., panic)=
 for unrecognized critical
> > > > > > +       hardware events, aiding in system fault diagnosis.
> > > > > > +
> > > > > >  endmenu
> > > > > > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware=
/riscv/Makefile
> > > > > > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > > > > > --- a/drivers/firmware/riscv/Makefile
> > > > > > +++ b/drivers/firmware/riscv/Makefile
> > > > > > @@ -1,3 +1,4 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > >
> > > > > >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > > > > > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > > > > > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmwar=
e/riscv/sse_nmi.c
> > > > > > new file mode 100644
> > > > > > index 0000000000000..43063f42efff0
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/firmware/riscv/sse_nmi.c
> > > > > > @@ -0,0 +1,77 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +
> > > > > > +#include <linux/mm.h>
> > > > > > +#include <linux/nmi.h>
> > > > > > +#include <linux/riscv_sbi_sse.h>
> > > > > > +#include <linux/sched/debug.h>
> > > > > > +#include <linux/sysctl.h>
> > > > > > +
> > > > > > +#include <asm/irq_regs.h>
> > > > > > +#include <asm/sbi.h>
> > > > > > +
> > > > > > +int panic_on_unknown_nmi =3D 1;
> > > > > > +struct sse_event *evt;
> > > > > > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > > > > > +
> > > > > > +const struct ctl_table unknown_nmi_table[] =3D {
> > > > > > +     {
> > > > > > +             .procname       =3D "panic_enable",
> > > > > > +             .data           =3D &panic_on_unknown_nmi,
> > > > > > +             .maxlen         =3D sizeof(int),
> > > > > > +             .mode           =3D 0644,
> > > > > > +             .proc_handler   =3D proc_dointvec_minmax,
> > > > > > +             .extra1         =3D SYSCTL_ZERO,
> > > > > > +             .extra2         =3D SYSCTL_ONE,
> > > > > > +     },
> > > > > > +};
> > > > > > +
> > > > > > +static void nmi_handler(struct pt_regs *regs)
> > > > > > +{
> > > > > > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_pro=
cessor_id());
> > > > > > +
> > > > > > +     if (panic_on_unknown_nmi)
> > > > > > +             nmi_panic(regs, "NMI: Not continuing");
> > > > > > +
> > > > > > +     pr_emerg("Dazed and confused, but trying to continue\n");
> > > > > > +}
> > > > >
> > > > > I'm dazed and confused as well ;) What's the point of this except
> > > > > interrupting the kernel with a panic ? It seems like it's a bette=
r idea
> > > > > to let the firmware handle that properly and display whatever
> > > > > information are needed. Was your idea to actually force the kerne=
l to
> > > > > enter in some debug mode ?
> > > >
> > > > There is an important scenario: when the kernel becomes unresponsiv=
e,
> > > > we need to trigger an unknown NMI to cause the system to panic() an=
d
> > > > then collect the vmcore, and such a requirement is common on x86
> > > > servers.
> > > >
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Cl=C3=A9ment
> > > > >
> > > > > > +
> > > > > > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs =
*regs)
> > > > > > +{
> > > > > > +     nmi_handler(regs);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int sse_nmi_init(void)
> > > > > > +{
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NM=
I, 0,
> > > > > > +                              nmi_sse_handler, NULL);
> > >
> > > Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI spec=
?
> >
> > The ratified SBI v3.0 defines a "Software injected local event" (ID 0xf=
fff0000)
> > which can be used to inject panic() on a particular HART from another H=
ART.
>
> Has SBI_SSE_EVENT_LOCAL_SOFTWARE (0xffff0000) been given meaning
> currently? The scenario of the unknown NMI is that after a HART
> receives an interrupt from the platform, M-mode responds to this

Which interrupt ? A standard one or platform specific one ?

> interrupt and then enters S-mode to execute the registered handler.
> Can SBI_SSE_EVENT_LOCAL_SOFTWARE be used directly?
>
>
> >
> > Regards,
> > Anup
>
> Thanks,
> Yunhui

