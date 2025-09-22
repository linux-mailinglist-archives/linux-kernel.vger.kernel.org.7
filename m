Return-Path: <linux-kernel+bounces-827078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84BB90360
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1809A18A49A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545083090C5;
	Mon, 22 Sep 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="mVWfa13Z"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C8286D56
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537593; cv=none; b=VuM2f1CwFgHfgjxNmRJrayj3p2j9F5yD84JgDFj2sqTafq61rlH0JeEP892hHvvuP16sXBbGSrTwdCSWUdmg0X0PU2LX37l4t9jpk6IPz117NYEbLhuF9NEMP9zz5F+1DXSuepNoNNhqZ/PJzZGZ5whgiHv9dI9as/c84Qm3eIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537593; c=relaxed/simple;
	bh=g+hxZa0s1DMUMrdMd7k4Xs6wUdvuoAFGjHrAPmuk0Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWbEe+vxTqWg7FAew/vBgoVK1XhGD8deH0pDklzAGVsq6s6nM/ZhrDF4aQ43DOBWkHSxNQA/J7lQfGFa7Ssc7XvCKNEbTiTETp9JER9muqCPH6cfX7RG8mlo/O7c4bTDU6vJXFOlHlQMrNbuwsCKInA40OjhIO3Au1aSzulEt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=mVWfa13Z; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-425635acc4dso19225085ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1758537591; x=1759142391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKKYBW3TEit9DV3MnVC+0Xh5Lri4Ge0jB2/Y1Xi7PgY=;
        b=mVWfa13Zr06QhwMt4H6NLxCINob4t7pL45gdCXtlhNujL+ueFDcvBTyVwLZ6dfw32s
         bL4Gm9hO8VwbA45lYmSa5mHn1wKIRsshn9LYAUo2o2wfI59QYx3t2NJaFymf/k3WHYOS
         2VZRJbe0XxxtJRkrAYVwaczI/HDFqO/h3wRF/q5YeFz4YaUiiU4y78ipBkTgQ6MLoIb3
         S6O58rV9ZrZK58D7zSSVNvw7JKP3b1WcsLvFi2bKJEMXmt+DJbYqsDt4tValUzn03I1M
         SOZoE+8xnAHWTgmQdfn+Wv0LFXqk50tVR0dPEIfSxHHP88bhmS+B9z0caVbAsO97QyaK
         KSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537591; x=1759142391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKKYBW3TEit9DV3MnVC+0Xh5Lri4Ge0jB2/Y1Xi7PgY=;
        b=RontDI8TdW5I71/eOrTG8PjAAKPsQ0UxxLeokDzJb2Q/L6ZvkCSyMQelBu6gtd5m1d
         WLGnwHsGmb3m/bte5555HOPHNbN+DjmOmzxLdfpCP/ho1mgInuf16BPn7KD999alDlgP
         4WVjqPIMhz/l0+v9cojPZuls0sb16J9SSOCPCwuTlt9VE5dotPNM2p2meOovnP3GjisW
         mO55pexKc8uNLvQ/GJlhxFXYYW0ZewEN/SguONaKKXWx9mkVyAAuy0G/kLJjLKQ3hTLX
         BxNULk8PSaTwMvQvNL4/RuEueJwO2VYFknw5q+Mu41ovvZweAq9HKdMJU+6mB4QRngc6
         TuUw==
X-Forwarded-Encrypted: i=1; AJvYcCX0mHFVBdJvf6SS46nLfEJ2vRpzcM+GPvBHN3wwVRVL/4ewoord3KR6rKWP6qNai7Ic6GRwEgQfIhY+F6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWZJK2UQmik7l6+tHZGnzWLmnuAQzuwF1IQREV+vM5gbVeORi
	teDGyMhEU/aDDz+n00sZWlaSKIco6dGSIO1BzHEcePR+zn/sjk0wNPvvaFIJPUgK16FkIeSHZyg
	SmuVjvDNDFBLJf4lpBImiE5msJwvQEbD+/eXzUTbQ+g==
X-Gm-Gg: ASbGncuMzQgLUdoA0o6rnQs1IdfhR7xsjVE2oBd5Ut1vySLE1nBduOMZFx1DGgMiS6E
	OFu7TJKDs/hItUVdK+UhO9MsIpTIppNju/mZgstw7AuuQ4FUTGgcBbPhqPxt/h00EZKpxa/YuPB
	loDi4fppIeBuyLBZ2M+fR1HZViW8EImAsOSwVqzM+zLJKFeHu24VMAKXVZWhk4Gxwj9Ymi+96s9
	XGv5MULmVXqbuy0lu8wWXlubal/gZiM0ARcIBFq
X-Google-Smtp-Source: AGHT+IFqGdebv6+dbsAdCn6tm5poQkoAGXJ+MYESTNHbfomqc5g/QGl3VYxeUqw42DtXEAPiFmWASIlo4+PXvlYRB6k=
X-Received: by 2002:a05:6e02:12c8:b0:425:7974:fe3e with SMTP id
 e9e14a558f8ab-425797500ccmr46686815ab.17.1758537590596; Mon, 22 Sep 2025
 03:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com> <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
 <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com> <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
In-Reply-To: <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Sep 2025 16:09:39 +0530
X-Gm-Features: AS18NWDdIl_oVq2lFdvJg5TQaiARn3GFkx7edDGcTJYNE-HcnObbBa-06mo7hiU
Message-ID: <CAAhSdy3ioaOBxO++XBBWfx9RRH-7BJQDLR0q6sSEr2m8W2cdwg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, conor@kernel.org, atishp@rivosinc.com, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:42=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Fri, Sep 19, 2025 at 3:52=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Cl=C3=A9ment,
> >
> > On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> > >
> > >
> > >
> > > On 19/09/2025 09:00, Yunhui Cui wrote:
> > > > Unknown NMI can force the kernel to respond (e.g., panic) when the
> > > > system encounters unrecognized critical hardware events, aiding in
> > > > troubleshooting system faults. This is implemented via the Supervis=
or
> > > > Software Events (SSE) framework.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  arch/riscv/include/asm/sbi.h     |  1 +
> > > >  drivers/firmware/riscv/Kconfig   | 10 +++++
> > > >  drivers/firmware/riscv/Makefile  |  1 +
> > > >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 89 insertions(+)
> > > >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> > > >
> > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/=
sbi.h
> > > > index 874cc1d7603a5..5801f90a88f62 100644
> > > > --- a/arch/riscv/include/asm/sbi.h
> > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> > > >
> > > >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> > > >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000001
> > > > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0x000=
00002
> > >
> > > Was this submitted to the PRS WG ? This a specification modification =
so
> > > it should go through the usual process.
> > >
> > > >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> > > >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> > > >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > > > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/risc=
v/Kconfig
> > > > index ed5b663ac5f91..746bac862ac46 100644
> > > > --- a/drivers/firmware/riscv/Kconfig
> > > > +++ b/drivers/firmware/riscv/Kconfig
> > > > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> > > >         this option provides support to register callbacks on speci=
fic SSE
> > > >         events.
> > > >
> > > > +config RISCV_SSE_UNKNOWN_NMI
> > > > +     bool "Enable SBI Supervisor Software Events unknown NMI suppo=
rt"
> > > > +     depends on RISCV_SBI_SSE
> > > > +     default y
> > > > +     help
> > > > +       This option enables support for delivering unknown Non-Mask=
able Interrupt (NMI)
> > > > +       notifications via the Supervisor Software Events (SSE) fram=
ework. When enabled,
> > > > +       unknown NMIs can trigger kernel responses (e.g., panic) for=
 unrecognized critical
> > > > +       hardware events, aiding in system fault diagnosis.
> > > > +
> > > >  endmenu
> > > > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/ris=
cv/Makefile
> > > > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > > > --- a/drivers/firmware/riscv/Makefile
> > > > +++ b/drivers/firmware/riscv/Makefile
> > > > @@ -1,3 +1,4 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >
> > > >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > > > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > > > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/ri=
scv/sse_nmi.c
> > > > new file mode 100644
> > > > index 0000000000000..43063f42efff0
> > > > --- /dev/null
> > > > +++ b/drivers/firmware/riscv/sse_nmi.c
> > > > @@ -0,0 +1,77 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +#include <linux/mm.h>
> > > > +#include <linux/nmi.h>
> > > > +#include <linux/riscv_sbi_sse.h>
> > > > +#include <linux/sched/debug.h>
> > > > +#include <linux/sysctl.h>
> > > > +
> > > > +#include <asm/irq_regs.h>
> > > > +#include <asm/sbi.h>
> > > > +
> > > > +int panic_on_unknown_nmi =3D 1;
> > > > +struct sse_event *evt;
> > > > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > > > +
> > > > +const struct ctl_table unknown_nmi_table[] =3D {
> > > > +     {
> > > > +             .procname       =3D "panic_enable",
> > > > +             .data           =3D &panic_on_unknown_nmi,
> > > > +             .maxlen         =3D sizeof(int),
> > > > +             .mode           =3D 0644,
> > > > +             .proc_handler   =3D proc_dointvec_minmax,
> > > > +             .extra1         =3D SYSCTL_ZERO,
> > > > +             .extra2         =3D SYSCTL_ONE,
> > > > +     },
> > > > +};
> > > > +
> > > > +static void nmi_handler(struct pt_regs *regs)
> > > > +{
> > > > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_process=
or_id());
> > > > +
> > > > +     if (panic_on_unknown_nmi)
> > > > +             nmi_panic(regs, "NMI: Not continuing");
> > > > +
> > > > +     pr_emerg("Dazed and confused, but trying to continue\n");
> > > > +}
> > >
> > > I'm dazed and confused as well ;) What's the point of this except
> > > interrupting the kernel with a panic ? It seems like it's a better id=
ea
> > > to let the firmware handle that properly and display whatever
> > > information are needed. Was your idea to actually force the kernel to
> > > enter in some debug mode ?
> >
> > There is an important scenario: when the kernel becomes unresponsive,
> > we need to trigger an unknown NMI to cause the system to panic() and
> > then collect the vmcore, and such a requirement is common on x86
> > servers.
> >
> > >
> > > Thanks,
> > >
> > > Cl=C3=A9ment
> > >
> > > > +
> > > > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *reg=
s)
> > > > +{
> > > > +     nmi_handler(regs);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sse_nmi_init(void)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0=
,
> > > > +                              nmi_sse_handler, NULL);
>
> Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI spec?

The ratified SBI v3.0 defines a "Software injected local event" (ID 0xffff0=
000)
which can be used to inject panic() on a particular HART from another HART.

Regards,
Anup

