Return-Path: <linux-kernel+bounces-826821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0AB8F6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C4D161F65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D42FD1C3;
	Mon, 22 Sep 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZO/rq/n/"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7E271443
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528691; cv=none; b=C4yNWJSyv023DiMGvHWBmBy+9KzRr/ucpxO6ce+A4V6htDUMSwRKs/pSEo8VAkGFQJiB9ZXvCaowbTwzbzG4kEtLg6X6loQNfc/UMR1JQDG1lzLl8gNc/BDFxfZwQZdzkBdW6+2ql/uFX50eYOvghdZGSFeJyK04LkkxUxRCa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528691; c=relaxed/simple;
	bh=DiOju5Bt+LHkGLXiTEMRfdVy48IXtVkt2BLIjyBQWEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0jQw5gjPvj3ahl7rL9XiFdHVcOcsHQovpR6R/k+bhcKdZZTwejS/BxZ+V8ELD33WYBJX9OTEGjz06V3htLGFGZgsSrMWyYfZsvMYIgnYXQQHfBqt3QKiWuAyYkaEY1PHY74U1GSWSBwBWX0hqfAQquPtpnlxAHzyFANzWoskZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZO/rq/n/; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-34049023e98so245183fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758528688; x=1759133488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTYI9b1YVpTY7QvyQYWdgeohTyw1IGddoA/28t5dEc=;
        b=ZO/rq/n/wchLeBil1BC7Noz6/4yfX6sdNpanvNcaEm8hc9V/wCYDvrB0BHeRIj1BEH
         YCrwVVO90sUnufZzGKuKl7HXnNGYIv7fXSb2sfm9/owL1kNv51p9Sl6FqUZr4vxZKeSe
         9G1EmDKbH3TJEL/7gEMgMPPh5zpIq6U5voKVz2zrpU2ZIzWRmkL6xA2r1u33TTpCKBe7
         d1CXyKWO52RPKWEtCY7k6LcNMhqlUplQa2/bGucW/9k0V1ZY4ECRC1VOHMb5ylQMaBT3
         ZTLfDohKWx5s6ygycAhJ9J5HwOEUIk6v8dcjfNnUcw46nH+zKJvDlIofAwxoY7dZRq05
         dOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528688; x=1759133488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDTYI9b1YVpTY7QvyQYWdgeohTyw1IGddoA/28t5dEc=;
        b=OkhqHt8Oz9pUpTe0pJL+8Xj/J4YMsmbZTSfM2qlHy30IRCJZAbVF/ndYMBiotfRYxt
         r8I2nJ0EgxP4TN3vkx6hBC+0ehxYQAQ82lR7YHCMLPOIq7cEPbpDrBlp8ArqbdU+tGTu
         3yzfiqR7PDQN0tKAs+PB/24MNhCqfVhD5jhntclO067RYkUNCuEJWhaQZtAOw/+8IoRt
         evYRR0i0NMNpnSwb14a62x3qRplrVM5MSQzyJUIyU92XXF7RSfZLfIaPc9TGpNmBG0bF
         zDNZf6943UNCBvX2dQt/M1Vh26q6P0+sOTpvoCpQD4casP3C2aclm2PNBP6EMtkx/Sf9
         OveQ==
X-Forwarded-Encrypted: i=1; AJvYcCV45KQbNe79DuwhkxEp7rq7pMBrsH2iRUmiJ+8SbStxadY3MuSJjFDMZ4eh0BxiXyx14RKBW65RmB32fKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98KSlk9xIcZwCRNM5mTPqZEt64wiah8lLOvZWYJjJbZAkrpnS
	R3z5kEeuHU31Be22eUWZvOlMDVWa1+rYeSaa6WaUu5JBONpMAnFBrET0FKR+BitVQcGY6Naelqs
	FTP4Xfr2WwX8jfi1YPA0DyzJ3UUfKfVoblHK7i4jGBQ==
X-Gm-Gg: ASbGncvQP9YnTFdYRXtP0P/sWx9q7Iih3mim+5uFVwld8hCBKjs7xU1L7oNL+YfbIBR
	WL2QbyoJFZJnRyp+0AYGmAuXtJj1DvUiHBtRXDcFDwghvqwm5rhIJ54k0XJsY6LgHDPIqNP9Prm
	Y4H1kP9Ga4K3ZbVf7jk3e3b+56rEUTHZK5nO/JfBPLQw1/PI+QyJsElkxP79W0FIH0f9JSpKpK/
	d4sI0nXIhRSlQJwKs7thBRc
X-Google-Smtp-Source: AGHT+IFXQzTCUzI8K5cHXrROdpysEPm4Z8r4rBmaaOGUzXW/yMCZuSV7TNKUMvuHBsxKrhO0g3kJ3eTx1TQ6/KU9/6g=
X-Received: by 2002:a05:6870:8a27:b0:331:cbf1:e04b with SMTP id
 586e51a60fabf-33bb506931bmr5485476fac.46.1758528687811; Mon, 22 Sep 2025
 01:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com> <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
 <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
In-Reply-To: <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Sep 2025 16:11:15 +0800
X-Gm-Features: AS18NWC_nIPhbcA4wlMemBhePC9PC4Rh7umDJjFYuGZF1PqAVqUIfy-e4ryuzIk
Message-ID: <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
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

On Fri, Sep 19, 2025 at 3:52=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Fri, Sep 19, 2025 at 3:18=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@r=
ivosinc.com> wrote:
> >
> >
> >
> > On 19/09/2025 09:00, Yunhui Cui wrote:
> > > Unknown NMI can force the kernel to respond (e.g., panic) when the
> > > system encounters unrecognized critical hardware events, aiding in
> > > troubleshooting system faults. This is implemented via the Supervisor
> > > Software Events (SSE) framework.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/riscv/include/asm/sbi.h     |  1 +
> > >  drivers/firmware/riscv/Kconfig   | 10 +++++
> > >  drivers/firmware/riscv/Makefile  |  1 +
> > >  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 89 insertions(+)
> > >  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> > >
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sb=
i.h
> > > index 874cc1d7603a5..5801f90a88f62 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
> > >
> > >  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
> > >  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000001
> > > +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0x00000=
002
> >
> > Was this submitted to the PRS WG ? This a specification modification so
> > it should go through the usual process.
> >
> > >  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
> > >  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
> > >  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
> > > diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/=
Kconfig
> > > index ed5b663ac5f91..746bac862ac46 100644
> > > --- a/drivers/firmware/riscv/Kconfig
> > > +++ b/drivers/firmware/riscv/Kconfig
> > > @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
> > >         this option provides support to register callbacks on specifi=
c SSE
> > >         events.
> > >
> > > +config RISCV_SSE_UNKNOWN_NMI
> > > +     bool "Enable SBI Supervisor Software Events unknown NMI support=
"
> > > +     depends on RISCV_SBI_SSE
> > > +     default y
> > > +     help
> > > +       This option enables support for delivering unknown Non-Maskab=
le Interrupt (NMI)
> > > +       notifications via the Supervisor Software Events (SSE) framew=
ork. When enabled,
> > > +       unknown NMIs can trigger kernel responses (e.g., panic) for u=
nrecognized critical
> > > +       hardware events, aiding in system fault diagnosis.
> > > +
> > >  endmenu
> > > diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv=
/Makefile
> > > index c8795d4bbb2ea..9242c6cd5e3e9 100644
> > > --- a/drivers/firmware/riscv/Makefile
> > > +++ b/drivers/firmware/riscv/Makefile
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > >  obj-$(CONFIG_RISCV_SBI_SSE)          +=3D riscv_sbi_sse.o
> > > +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  +=3D sse_nmi.o
> > > diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/risc=
v/sse_nmi.c
> > > new file mode 100644
> > > index 0000000000000..43063f42efff0
> > > --- /dev/null
> > > +++ b/drivers/firmware/riscv/sse_nmi.c
> > > @@ -0,0 +1,77 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include <linux/mm.h>
> > > +#include <linux/nmi.h>
> > > +#include <linux/riscv_sbi_sse.h>
> > > +#include <linux/sched/debug.h>
> > > +#include <linux/sysctl.h>
> > > +
> > > +#include <asm/irq_regs.h>
> > > +#include <asm/sbi.h>
> > > +
> > > +int panic_on_unknown_nmi =3D 1;
> > > +struct sse_event *evt;
> > > +static struct ctl_table_header *unknown_nmi_sysctl_header;
> > > +
> > > +const struct ctl_table unknown_nmi_table[] =3D {
> > > +     {
> > > +             .procname       =3D "panic_enable",
> > > +             .data           =3D &panic_on_unknown_nmi,
> > > +             .maxlen         =3D sizeof(int),
> > > +             .mode           =3D 0644,
> > > +             .proc_handler   =3D proc_dointvec_minmax,
> > > +             .extra1         =3D SYSCTL_ZERO,
> > > +             .extra2         =3D SYSCTL_ONE,
> > > +     },
> > > +};
> > > +
> > > +static void nmi_handler(struct pt_regs *regs)
> > > +{
> > > +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor=
_id());
> > > +
> > > +     if (panic_on_unknown_nmi)
> > > +             nmi_panic(regs, "NMI: Not continuing");
> > > +
> > > +     pr_emerg("Dazed and confused, but trying to continue\n");
> > > +}
> >
> > I'm dazed and confused as well ;) What's the point of this except
> > interrupting the kernel with a panic ? It seems like it's a better idea
> > to let the firmware handle that properly and display whatever
> > information are needed. Was your idea to actually force the kernel to
> > enter in some debug mode ?
>
> There is an important scenario: when the kernel becomes unresponsive,
> we need to trigger an unknown NMI to cause the system to panic() and
> then collect the vmcore, and such a requirement is common on x86
> servers.
>
> >
> > Thanks,
> >
> > Cl=C3=A9ment
> >
> > > +
> > > +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
> > > +{
> > > +     nmi_handler(regs);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int sse_nmi_init(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     evt =3D sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
> > > +                              nmi_sse_handler, NULL);

Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI spec?


> > > +     if (IS_ERR(evt))
> > > +             return PTR_ERR(evt);
> > > +
> > > +     ret =3D sse_event_enable(evt);
> > > +     if (ret) {
> > > +             sse_event_unregister(evt);
> > > +             return ret;
> > > +     }
> > > +
> > > +     unknown_nmi_sysctl_header =3D register_sysctl("kernel", unknown=
_nmi_table);
> > > +     if (!unknown_nmi_sysctl_header) {
> > > +             sse_event_disable(evt);
> > > +             sse_event_unregister(evt);
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     pr_info("Using SSE for NMI event delivery\n");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int __init unknow_nmi_init(void)
> > > +{
> > > +     return sse_nmi_init();
> > > +}
> > > +
> > > +late_initcall(unknow_nmi_init);
> >
>
> Thanks,
> Yunhui

Thanks,
Yunhui

