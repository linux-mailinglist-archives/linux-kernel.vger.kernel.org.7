Return-Path: <linux-kernel+bounces-846366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E59BC7B83
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE94200DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F42D063D;
	Thu,  9 Oct 2025 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="PsXJjTFJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED52D0C88
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994995; cv=none; b=KBEShdiaqRCqlVmmrNyeoPOtDtN0/hLOHUXk84DpHYOWxZXUWFtPEjc/Rso46VfgdL1Tcb1nbbUj2QWBRRVf+Z3cpQDOb3N2kl61aaVLRtQGESemSNXvaBlhxBML3uPHLo+Z6wqrJkzHgDpS1Zj/fBXe+gq/P+D+GT5i74yQFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994995; c=relaxed/simple;
	bh=Ptuq9ZamF0xwhyOv46hmuYfawAkXSJ5s8i8/cNa0jkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR/Bgxu8yI5VBNHpOmkxZJCyG4tkTlJKHY+1G4IELmvrTV+CW/sQL9LRS1WeVckeDj03y5H2X7kAeVP5qZOi/+M4+rFEgHCRFVTxiCQnPSau+HY2KQGUgqkv64eKquVfq5fTGX814/khEqFHbKaoOp1ACHXG6JsXjX+lPRIxSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=PsXJjTFJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-636535e4b1aso2523397a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759994991; x=1760599791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C47yijSASNtbJu2Z921Frq1uQ3PXMKDKuD6iscEsY5Q=;
        b=PsXJjTFJyYSj4CgqgVvdSAqRKR6joHQenv23T7dR62iIQEBBObJ2JR/8ptVEg7J8Ja
         RWyz82xINRGrH/FG/jNBLcX9zcavAIN1e7aTAQXK+qtfslTrimS8TEIdvsHSE6ZCWg9K
         UqRVWhXzEHDABlMhQRLJuQleE7hK0UyKfgKtCCL2VpZxRt4GR7oWY2ESzlj83PRWEjKL
         spwZOCNNINgRARy5Z1e6V3ZATZ1ZCnZiZlljTHWxTyd46omCzPujVumfGTKDqbwHWpqm
         dYvambyYq7fL+QZapii763E9cK0FC9RksZJzeWiQQv/jlYzkSufkHUR7R5pIuqXAh+Ff
         UUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994991; x=1760599791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C47yijSASNtbJu2Z921Frq1uQ3PXMKDKuD6iscEsY5Q=;
        b=abvriOcS2ADt55EqwRY6h6ZiDEqWF3XhKVqTo8sdf1YNMyvfgDIbcW3bEQ60+ipOSe
         ovfhpt5DIgUAWUsqZoA6WH9a11pApnV/z7Ng9xdhhv4BUMlLxmvlzuDWPQrLnYViMVXb
         O96SIsPY4BvtWkOQjtUJHmJv0mtkuq/yqMUGIIWyVypdkSQhuv6zOfdxdEA1uGof3BXU
         OwtIV/L+RRflXdW91K38+pPCEMAXKN/Fi5w0Us0ghq8ZeqkSsvg5nmTzMgwBIQDa/U9/
         xdqR7YwebKkrv/3SbfkPUcoIPkqH59tUS81Q3LiPs3u4lxL+MzKbvw3UpcO07n2u/0lQ
         rHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+c3rlRhqmH3q2IDS2M4jVt2JpLfxmdqV73rphQq9yrw4+/UfjrfowgOLMOvE4+fWxZ50gVRPdrZKds4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqBsMSzs4YVOTPc6JTU0lALv8ASXoNf7PleI3D8fHk2xGRO3K
	amLub3Q01Zu83OSAnOJdnTz9G5S6YGQhw7tmlh8QpcWYl4RTxfmgZdhkF+Q5bhUCIJsd2vsQ7cg
	S7p4Njd6leU/JrEePq5zAbyKZApUMmlM4qt8gHaIJ+g==
X-Gm-Gg: ASbGnctve736Yh+SeiUBORmoM6+XNGHbZYyCef6i6cfkLUvdAipkQiyeiDA91+p2DD1
	MBhihlyK5Qk3A+BudiqFBxfvdLhS1vPRIzag9GtJ46X2inGIlFaqQj1wxPbYvKW8CzUZ1L8ACaj
	USXL0Pp1IYGDdQQAppccoFGRKEYJai1eCdthr/i/NFrfKQbcCRmJptDeyV6iT00tjX4qrM4pWWh
	fuPRfTd6JGrTGcHgUVk9VwZhXBQ5ujsWt0F6Wq/bpNRVuivdbmv/w+fzgsHBXUB
X-Google-Smtp-Source: AGHT+IFr4AMtubP2WDrtOoVrsbg21M61hekI0rPdwjItm1dalRwNH6jXD/DGKbL80PoF5hIdcjnAymscV4K/A0H3wqQ=
X-Received: by 2002:a17:907:6d11:b0:b46:7e8c:c0e3 with SMTP id
 a640c23a62f3a-b50bedbf4e5mr768178566b.20.1759994991471; Thu, 09 Oct 2025
 00:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org>
 <1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr> <CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com>
In-Reply-To: <CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 9 Oct 2025 09:29:40 +0200
X-Gm-Features: AS18NWBXBWA9dGTsEl3pgH-G9lCZV-xwYAwbfPhfz7e9lGYBSESF3PEv9R0ptVo
Message-ID: <CAHVXubgrbjHXAPSLjk6uZmUoa52fTYBvutk4q0GFYJPQ0swrGA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Han Gao <rabenda.cn@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, guoren@kernel.org, palmer@dabbelt.com, conor@kernel.org, 
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Han,

On Tue, Oct 7, 2025 at 11:36=E2=80=AFPM Han Gao <rabenda.cn@gmail.com> wrot=
e:
>
> Hi Alex
>      This patch is included in the 6.17 merge window but not in the
> 6.18 merge window.
>      Is it possible that the patch was missed?

Unfortunately, I can't say, you should ask the maintainers.

Thanks,

Alex

>
> On Thu, Jul 17, 2025 at 4:22=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > On 7/13/25 17:53, guoren@kernel.org wrote:
> > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> > >
> > > The early version of XuanTie C910 core has a store merge buffer
> > > delay problem. The store merge buffer could improve the store queue
> > > performance by merging multi-store requests, but when there are not
> > > continued store requests, the prior single store request would be
> > > waiting in the store queue for a long time. That would cause
> > > significant problems for communication between multi-cores. This
> > > problem was found on sg2042 & th1520 platforms with the qspinlock
> > > lock torture test.
> > >
> > > So appending a fence w.o could immediately flush the store merge
> > > buffer and let other cores see the write result.
> > >
> > > This will apply the WRITE_ONCE errata to handle the non-standard
> > > behavior via appending a fence w.o instruction for WRITE_ONCE().
> > >
> > > This problem is only observed on the sg2042 hardware platform by
> > > running the lock_torture test program for half an hour. The problem
> > > was not found in the user space application, because interrupt can
> > > break the livelock.
> > >
> > > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > > ---
> > >   arch/riscv/Kconfig.errata                    | 17 ++++++++++
> > >   arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
> > >   arch/riscv/include/asm/errata_list_vendors.h |  3 +-
> > >   arch/riscv/include/asm/rwonce.h              | 34 +++++++++++++++++=
+++
> > >   include/asm-generic/rwonce.h                 |  2 ++
> > >   5 files changed, 75 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/riscv/include/asm/rwonce.h
> > >
> > > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > > index e318119d570d..d2c982ba5373 100644
> > > --- a/arch/riscv/Kconfig.errata
> > > +++ b/arch/riscv/Kconfig.errata
> > > @@ -130,4 +130,21 @@ config ERRATA_THEAD_GHOSTWRITE
> > >
> > >         If you don't know what to do here, say "Y".
> > >
> > > +config ERRATA_THEAD_WRITE_ONCE
> > > +     bool "Apply T-Head WRITE_ONCE errata"
> > > +     depends on ERRATA_THEAD
> > > +     default y
> > > +     help
> > > +       The early version of T-Head C9xx cores of sg2042 & th1520 hav=
e a store
> > > +       merge buffer delay problem. The store merge buffer could impr=
ove the
> > > +       store queue performance by merging multi-store requests, but =
when there
> > > +       are no continued store requests, the prior single store reque=
st would be
> > > +       waiting in the store queue for a long time. That would cause =
signifi-
> > > +       cant problems for communication between multi-cores. Appendin=
g a
> > > +       fence w.o could immediately flush the store merge buffer and =
let other
> > > +       cores see the write result.
> > > +
> > > +       This will apply the WRITE_ONCE errata to handle the non-stand=
ard beh-
> > > +       avior via appending a fence w.o instruction for WRITE_ONCE().
> > > +
> > >   endmenu # "CPU errata selection"
> > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/the=
ad/errata.c
> > > index 0b942183f708..fbe46f2fa8fb 100644
> > > --- a/arch/riscv/errata/thead/errata.c
> > > +++ b/arch/riscv/errata/thead/errata.c
> > > @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int=
 stage,
> > >       return true;
> > >   }
> > >
> > > +static bool errata_probe_write_once(unsigned int stage,
> > > +                                 unsigned long arch_id, unsigned lon=
g impid)
> > > +{
> > > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > > +             return false;
> > > +
> > > +     /* target-c9xx cores report arch_id and impid as 0 */
> > > +     if (arch_id !=3D 0 || impid !=3D 0)
> > > +             return false;
> > > +
> > > +     if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> > > +         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   static u32 thead_errata_probe(unsigned int stage,
> > >                             unsigned long archid, unsigned long impid=
)
> > >   {
> > > @@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
> > >
> > >       errata_probe_ghostwrite(stage, archid, impid);
> > >
> > > +     if (errata_probe_write_once(stage, archid, impid))
> > > +             cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> > > +
> > >       return cpu_req_errata;
> > >   }
> > >
> > > diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/risc=
v/include/asm/errata_list_vendors.h
> > > index a37d1558f39f..a7473cb8874d 100644
> > > --- a/arch/riscv/include/asm/errata_list_vendors.h
> > > +++ b/arch/riscv/include/asm/errata_list_vendors.h
> > > @@ -18,7 +18,8 @@
> > >   #define     ERRATA_THEAD_MAE 0
> > >   #define     ERRATA_THEAD_PMU 1
> > >   #define     ERRATA_THEAD_GHOSTWRITE 2
> > > -#define      ERRATA_THEAD_NUMBER 3
> > > +#define      ERRATA_THEAD_WRITE_ONCE 3
> > > +#define      ERRATA_THEAD_NUMBER 4
> > >   #endif
> > >
> > >   #endif
> > > diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm=
/rwonce.h
> > > new file mode 100644
> > > index 000000000000..081793d4d772
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/rwonce.h
> > > @@ -0,0 +1,34 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_RWONCE_H
> > > +#define __ASM_RWONCE_H
> > > +
> > > +#include <linux/compiler_types.h>
> > > +#include <asm/alternative-macros.h>
> > > +#include <asm/vendorid_list.h>
> > > +#include <asm/errata_list_vendors.h>
> > > +
> > > +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATI=
VE)
> > > +
> > > +#define write_once_fence()                           \
> > > +do {                                                 \
> > > +     asm volatile(ALTERNATIVE(                       \
> > > +             "nop",                                  \
> > > +             "fence w, o",                           \
> > > +             THEAD_VENDOR_ID,                        \
> > > +             ERRATA_THEAD_WRITE_ONCE,                \
> > > +             CONFIG_ERRATA_THEAD_WRITE_ONCE)         \
> > > +             : : : "memory");                        \
> > > +} while (0)
> > > +
> > > +#define __WRITE_ONCE(x, val)                         \
> > > +do {                                                 \
> > > +     *(volatile typeof(x) *)&(x) =3D (val);            \
> > > +     write_once_fence();                             \
> > > +} while (0)
> > > +
> > > +#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALT=
ERNATIVE) */
> > > +
> > > +#include <asm-generic/rwonce.h>
> > > +
> > > +#endif       /* __ASM_RWONCE_H */
> > > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonc=
e.h
> > > index 52b969c7cef9..4e2d941f15a1 100644
> > > --- a/include/asm-generic/rwonce.h
> > > +++ b/include/asm-generic/rwonce.h
> > > @@ -50,10 +50,12 @@
> > >       __READ_ONCE(x);                                                =
 \
> > >   })
> > >
> > > +#ifndef __WRITE_ONCE
> > >   #define __WRITE_ONCE(x, val)                                       =
         \
> > >   do {                                                               =
         \
> > >       *(volatile typeof(x) *)&(x) =3D (val);                         =
   \
> > >   } while (0)
> > > +#endif
> > >
> > >   #define WRITE_ONCE(x, val)                                         =
 \
> > >   do {                                                               =
         \
> >
> > I'll send this patchset in my next PR for 6.17:
> >
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> > Thanks,
> >
> > Alex
> >

