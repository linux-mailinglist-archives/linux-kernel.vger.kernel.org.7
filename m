Return-Path: <linux-kernel+bounces-828267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77548B94482
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581663B7F44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041030CB3D;
	Tue, 23 Sep 2025 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="eigJSSkt"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506F25B662
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603973; cv=none; b=exXVzNz1Bm7IPymKHoIiWF6V6oGHeBkE8X5ZcdcqBV8FbUjI8XLb4F/EPTUCkVgMx7DYpWWINJF/MHd8+L0BrjjVBaCQ7wXU2zvTEcRmuRLs9QV10PSXo3cwscTT4/FE7AvAsHBcwOasD4ACPmWy68F7c/rUBqsz9Rqh0NCSzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603973; c=relaxed/simple;
	bh=EsQlcFApyXDcRuOj67aZRNilTwhPvkP+p41WAQnKQNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se8n0x3iYIdG2geSqMlxCwFNxig2/lPm0cL2ukXEjvmWwa2i4XQ/zpzDeE9n2up8QF0xsZuyyLAYcLpxH9+xLQ8HY55+qgICeFUDh4bNEBGReerG7iaaoLC+EXMSovgbKL704u/SggT4TLJ1z8CXZcF+reePF84Uvb+UWUAc+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=eigJSSkt; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8d9fb6fc138so83275939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1758603970; x=1759208770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+BozLEV3M5HFvnO6spU5aK5mXn77UxIipfobMtOevc=;
        b=eigJSSktn5FlU4YEdBAeZ/KYlx04mwNhs7Gg2Wr4qX0v8a4tbwyZU9aBi9HWmq4k8v
         rXB4UmPocFyRZOdT8M9Vow2H6KaoQJ3dtjuP064Rl4OhJMeAbC5E5rl0kkrG7az2rRqE
         WiWxCw92TlBLIa/kzllUAqGnVFtHRk212rCLqGOumKyBK3RHDYFI+uxObdR5bzKL2hc5
         S2A0a4n3VUQZ2Y/mTEFWxK2uvm9TrIPDjvmbiCfV0/F59a8IQ7a3hsXl067H1MkIEysw
         POSLKzKh7NvgWlygs5r6ohGdBn834UrltiH9YA4VcZWiCBAnsp2uN0k07rCa5mHESdYz
         YtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758603970; x=1759208770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+BozLEV3M5HFvnO6spU5aK5mXn77UxIipfobMtOevc=;
        b=uc0ziZhxZL8U1hkgG2YB5wxozpBNAAGFpafIWY/ISRVkwyYqfq77kCdsDFM3dFvsim
         tiyUYXE8rp5JFjUEdVgrkSSiYF9aB/zHw4AZh3Pyxr8Iz1RTewOQ4cEysRRbvg1gpkzb
         aKr1Xeo3DpRyPVdXyLPl6RXqe/cvEJbLYZzVOqm6W0JQryWDGF88OHqDW7CBzyknp7f6
         FO+rPZHtqgQty4stk/DU1aNK6PTQ4/HD3XArsAw6HUcdsFHLseIp9E1vIQsSFMwwc98c
         LbiWNrUqOHk/ChFOF8qucps5OECG26B9pWiE2KQve4jACdtF+be8TomEymOs0vcXmhkN
         qtnA==
X-Forwarded-Encrypted: i=1; AJvYcCUVZ6aYIvuulomW7GvcMXMlDQhfN/Sy7gbLn9IUfqa6GCYIAKXEWAmvx2kWJezJsjNasgdIaVief4msy5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6tVI7ciP5hapHup7qIfivnZqJu1hTfgAhDPgsZlYaXRqhbNC
	Sd2ERHN2R24y9BGKC9B/hTiizfXWb/IrdZb9BcBzz3pxfcz9rXesziviXBVoAY39fH4g7zQXxLM
	vC/II8/5XWva0oou9gFT565vHU37kFpM6UtLcxliSrQ==
X-Gm-Gg: ASbGncvScE8UGPay9H6xy9BYsVQqxl5Bwhh3WT16b18ujKjkUUErbI3HbZpAkoq586G
	r5nNVm+9yQUsnbF37RPhm8pjYujgZLR+EJGl/9hPQOOA9pvQqSyQokAkiEpxPGpedVG0Mxu0/AN
	mNEVFKHXf1srl8HsrdC8K3A63U68540zd3LbhRXB4zXrHMkz/Xupg5kW+NTERGr1QEVoQlfR1cr
	jhtBjO9rt88WaQkuU5Q3VRJIaS9k3Re+A2l46nx
X-Google-Smtp-Source: AGHT+IFPzBj9cvcCxvfYV4AAndyg6lGBppbSsKACXmClezws1hELgG2i965acf/otg6nsNQhfO4Ome6gfhrCG4p8Jd4=
X-Received: by 2002:a05:6e02:16c9:b0:424:7f6c:78c5 with SMTP id
 e9e14a558f8ab-42581e1723amr19435825ab.7.1758603970187; Mon, 22 Sep 2025
 22:06:10 -0700 (PDT)
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
From: Anup Patel <anup@brainfault.org>
Date: Tue, 23 Sep 2025 10:35:58 +0530
X-Gm-Features: AS18NWDPWs1SxPcSj_YWUsuS2lkU6YvNufUXIqsGGfl7idfocTAilPqNT7_nbKo
Message-ID: <CAAhSdy2e90AhkWaaCWsyEjRpovQbS9eBNpC60bLsLTLqUEWSkw@mail.gmail.com>
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

On Mon, Sep 22, 2025 at 5:28=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
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
> interrupt and then enters S-mode to execute the registered handler.
> Can SBI_SSE_EVENT_LOCAL_SOFTWARE be used directly?

It's a software injected event with lower priority which can be used by
supervisor software on a HART to inject an event to another HART.

If you need a platform specific event then there are multiple ranges
with different priority-levels.

Regards,
Anup

