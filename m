Return-Path: <linux-kernel+bounces-827165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33944B91019
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF718A376C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4D2BE7BB;
	Mon, 22 Sep 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XRcD7QZr"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F71A9FB7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542298; cv=none; b=bQIdptmckFWClp6iS3mjphjCwKGrc2s/XbKTcWhGIyBzIXGwekrPOha+B/3z1EkovM/we3MqKyfnXXZUR9Gphu9qMafGrQTKmg+0mO2lDXNo33+90S5h6oJgpUXiEQmUA6CGxWF6H1N50bxui9wLU1gUZ/7DEcz4EBq3o77iLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542298; c=relaxed/simple;
	bh=6a4ETzpG9tirVF6AImiEw6KJtUpdDdskVqRYGWnxaCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0ca+iSDvmi1SrNLjCIUn+RKN8xp/18GNvmG73pEsPlhQYQ9TaZf5SoMbCSrMN+IVInu8njwGsZ08SjcCnHBbJ2yTntt+/XsOfWf5gniawXDfipO3zGf4C3EtG+avbxT6kKoxhgUiQDy9TQ4UH0TpJzFgLfyFzHtfPne8H/2mds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XRcD7QZr; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce5be7d0so1902251fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758542294; x=1759147094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHVHNKzjAmVSWuUaTlYGOUC+2+S4tCnVfERUbvElmqo=;
        b=XRcD7QZrB9kcclj2Kk/ktRE3k9rKL4mChLsxB3YO1++ER/2sOsZ99pYiFX7QGhdZy1
         fBHDx6mJHxjk5/q23uGqDk4kO8hTXYZZaI2fzJy9JPiAObdAfq3ea0/Ws3abXTt3OCLc
         U8x4dIymoNzgqpLPJ4b4wVTYgQ/R9eSNLbn6GHINE+73KEuYH0KcgIpvnlaCwz9lzN+v
         alpCoC1ASxrKu0eQhpNpYhAmKEExPOcqyWm9hj0s/04OBDUJqn5A1MsnPHejTIF3gtt6
         iQXGVojkwquL6oncYdAKjpVkGFgGoHKZQTRu6xCgRcjGEnYU+v1e2xmSvsuqbRWgjsfd
         c9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542294; x=1759147094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHVHNKzjAmVSWuUaTlYGOUC+2+S4tCnVfERUbvElmqo=;
        b=A1meQciNW/RHe5aR7skrNWNqef3UFyS42idO+f08z8jN25OdZPmp7GxBzrrAUKvQjW
         fLEJTs9gbiUbqTJW5UcHGqHeVXwK9BE2nX8RMAYpDFfrEIF+dUNetqKSDOQQQN5t/gl4
         kMPaxUlJ/hFedN2LBXSpm7yafbM4DGxH5gJZhDlyxkgii6xzX4NNE6DQPETMzvLNpPkz
         xxKgSbGimH0BFRSsz8PKZEYeEGjT4o9W0+WKE0lpKfE67dZmozLJFTan1SD5giiAm4Mj
         SzYSRv9InvZwrNic3gUUK3v3u/5jpqSxuZHifFY6vIJBtZuP562fF6U+MH3YgVFJJVfQ
         aGuw==
X-Forwarded-Encrypted: i=1; AJvYcCWqf5ou1rzK78a7rw5kGjedk0FcRWu3MXwE6jw3sZpzjQYX8p7cYD4bQSRObhW8LK2W/g2ONuatJNsRMN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhdMKQ88Jm+/nNvr/P9S8uXO/+g9UOnr8nwIk2qSAY3kqEn9E
	KgX9nHaIuShzydGMJ73LKrYIw1j2HDjhKkeeu0s1IoOKf+NlZRp2wttEv2qIAU3G/fdoMNntAJd
	WA27QMQB5ksJ6ASG3mak19zTZKLw9pKfNCQTCdflPCQ==
X-Gm-Gg: ASbGnct2j8spwg1BCf3hRHnSWS7nQLsIjtSnywGAfbE826mXjrrXijRFAOxe5VJxPFo
	6n21QfSa+M8EkSXvQ2VBQ0vCn1zLgN95/N9/U6DBU+WJ+FRYN6qrmsG3QhKHGjQ0j/V6ESG+Kcv
	dhy+aXo5pw6DSyicveuG2RoJ53Zcdp+gP9qcDE/EDm7GEIIyyIR04YWQcrdozQpGHOAPwiKYWel
	fL4LAicfSk33g==
X-Google-Smtp-Source: AGHT+IFJaMyLLCh1Xm+EZRUU2+rVaRKBzkqwv8+0XArTrfmXbw0CF/H9pB9vYB/gkBfkl/r0bzWiKcLdIy2R5yrNQnM=
X-Received: by 2002:a05:6870:a0b1:b0:30c:839:bb78 with SMTP id
 586e51a60fabf-33bb0bd0756mr6178956fac.0.1758542294547; Mon, 22 Sep 2025
 04:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com> <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
 <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
 <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com> <CAAhSdy3ioaOBxO++XBBWfx9RRH-7BJQDLR0q6sSEr2m8W2cdwg@mail.gmail.com>
In-Reply-To: <CAAhSdy3ioaOBxO++XBBWfx9RRH-7BJQDLR0q6sSEr2m8W2cdwg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Sep 2025 19:58:03 +0800
X-Gm-Features: AS18NWBB7CIpnNNnwnsIJI6KeeoQ1Ich7LHywJ7i-hVNXt5nzQMuy6tJsG4YhD0
Message-ID: <CAEEQ3wmDFfmbr0fGxNUOX16p0b5zeR8bKTDTePuCFPYaKOyuqg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: Anup Patel <anup@brainfault.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, conor@kernel.org, atishp@rivosinc.com, ajones@ventanamicro.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Mon, Sep 22, 2025 at 6:40=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Mon, Sep 22, 2025 at 1:42=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Cl=C3=A9ment,
> >
> > On Fri, Sep 19, 2025 at 3:52=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Cl=C3=A9ment,
> > >
> > > On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
> > > >
> > > >
> > > >
> > > > On 19/09/2025 09:00, Yunhui Cui wrote:
> > > > > Unknown NMI can force the kernel to respond (e.g., panic) when th=
e
> > > > > system encounters unrecognized critical hardware events, aiding i=
n
> > > > > troubleshooting system faults. This is implemented via the Superv=
isor
> > > > > Software Events (SSE) framework.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/sbi.h     |  1 +
> > > > >  drivers/firmware/riscv/Kconfig   | 10 +++++
> > > > >  drivers/firmware/riscv/Makefile  |  1 +
> > > > >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 89 insertions(+)
> > > > >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/as=
m/sbi.h
> > > > > index 874cc1d7603a5..5801f90a88f62 100644
> > > > > --- a/arch/riscv/include/asm/sbi.h
> > > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> > > > >
> > > > >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> > > > >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000001
> > > > > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0x0=
0000002
> > > >
> > > > Was this submitted to the PRS WG ? This a specification modificatio=
n so
> > > > it should go through the usual process.
> > > >
> > > > >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> > > > >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> > > > >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > > > > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/ri=
scv/Kconfig
> > > > > index ed5b663ac5f91..746bac862ac46 100644
> > > > > --- a/drivers/firmware/riscv/Kconfig
> > > > > +++ b/drivers/firmware/riscv/Kconfig
> > > > > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> > > > >         this option provides support to register callbacks on spe=
cific SSE
> > > > >         events.
> > > > >
> > > > > +config RISCV_SSE_UNKNOWN_NMI
> > > > > +     bool "Enable SBI Supervisor Software Events unknown NMI sup=
port"
> > > > > +     depends on RISCV_SBI_SSE
> > > > > +     default y
> > > > > +     help
> > > > > +       This option enables support for delivering unknown Non-Ma=
skable Interrupt (NMI)
> > > > > +       notifications via the Supervisor Software Events (SSE) fr=
amework. When enabled,
> > > > > +       unknown NMIs can trigger kernel responses (e.g., panic) f=
or unrecognized critical
> > > > > +       hardware events, aiding in system fault diagnosis.
> > > > > +
> > > > >  endmenu
> > > > > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/r=
iscv/Makefile
> > > > > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > > > > --- a/drivers/firmware/riscv/Makefile
> > > > > +++ b/drivers/firmware/riscv/Makefile
> > > > > @@ -1,3 +1,4 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >
> > > > >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > > > > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > > > > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/=
riscv/sse_nmi.c
> > > > > new file mode 100644
> > > > > index 0000000000000..43063f42efff0
> > > > > --- /dev/null
> > > > > +++ b/drivers/firmware/riscv/sse_nmi.c
> > > > > @@ -0,0 +1,77 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +
> > > > > +#include <linux/mm.h>
> > > > > +#include <linux/nmi.h>
> > > > > +#include <linux/riscv_sbi_sse.h>
> > > > > +#include <linux/sched/debug.h>
> > > > > +#include <linux/sysctl.h>
> > > > > +
> > > > > +#include <asm/irq_regs.h>
> > > > > +#include <asm/sbi.h>
> > > > > +
> > > > > +int panic_on_unknown_nmi =3D 1;
> > > > > +struct sse_event *evt;
> > > > > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > > > > +
> > > > > +const struct ctl_table unknown_nmi_table[] =3D {
> > > > > +     {
> > > > > +             .procname       =3D "panic_enable",
> > > > > +             .data           =3D &panic_on_unknown_nmi,
> > > > > +             .maxlen         =3D sizeof(int),
> > > > > +             .mode           =3D 0644,
> > > > > +             .proc_handler   =3D proc_dointvec_minmax,
> > > > > +             .extra1         =3D SYSCTL_ZERO,
> > > > > +             .extra2         =3D SYSCTL_ONE,
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +static void nmi_handler(struct pt_regs *regs)
> > > > > +{
> > > > > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_proce=
ssor_id());
> > > > > +
> > > > > +     if (panic_on_unknown_nmi)
> > > > > +             nmi_panic(regs, "NMI: Not continuing");
> > > > > +
> > > > > +     pr_emerg("Dazed and confused, but trying to continue\n");
> > > > > +}
> > > >
> > > > I'm dazed and confused as well ;) What's the point of this except
> > > > interrupting the kernel with a panic ? It seems like it's a better =
idea
> > > > to let the firmware handle that properly and display whatever
> > > > information are needed. Was your idea to actually force the kernel =
to
> > > > enter in some debug mode ?
> > >
> > > There is an important scenario: when the kernel becomes unresponsive,
> > > we need to trigger an unknown NMI to cause the system to panic() and
> > > then collect the vmcore, and such a requirement is common on x86
> > > servers.
> > >
> > > >
> > > > Thanks,
> > > >
> > > > Cl=C3=A9ment
> > > >
> > > > > +
> > > > > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *r=
egs)
> > > > > +{
> > > > > +     nmi_handler(regs);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int sse_nmi_init(void)
> > > > > +{
> > > > > +     int ret;
> > > > > +
> > > > > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI,=
 0,
> > > > > +                              nmi_sse_handler, NULL);
> >
> > Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI spec?
>
> The ratified SBI v3.0 defines a "Software injected local event" (ID 0xfff=
f0000)
> which can be used to inject panic() on a particular HART from another HAR=
T.

Has SBI_SSE_EVENT_LOCAL_SOFTWARE (0xffff0000) been given meaning
currently? The scenario of the unknown NMI is that after a HART
receives an interrupt from the platform, M-mode responds to this
interrupt and then enters S-mode to execute the registered handler.
Can SBI_SSE_EVENT_LOCAL_SOFTWARE be used directly?


>
> Regards,
> Anup

Thanks,
Yunhui

