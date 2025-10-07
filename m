Return-Path: <linux-kernel+bounces-844782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26538BC2C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F9A19A1550
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28424C06A;
	Tue,  7 Oct 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNAIyc/Y"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FA253950
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873007; cv=none; b=QEKO+ayYkNp7hJL4hwXylX6gq9Z2T+FnQvOlwkGEQNjGw8JGB5UbGDW7VdHcYyWEOXpY8R07td2J7IgQKLNndAOA3ZB/xSHc3vsruhe8HTX4NSq5nSGGDZnpXids3KTYYfDw83FxXQpk5w6Bjs/P084QX8Gntp7z3mTu0V/DQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873007; c=relaxed/simple;
	bh=bNBY2xF5L7YuBDKUBoZQ1i/tIKCd61h6ZBKkzuOC+fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNZFoRw7XtAOWOkoB01L1d6tsuNN9SIOzMS6OsqLCO2Wh262zSvRuSGnVo3SWZkqKGA7iw+sRg9e8ljepxqIEo1idHmyCvGL2l3IxKSnGryMM+yjWMSD3IhjeSHVUEk2AhwML++1OS5647yBWavhA/OJd7p0fM3QTRWEiIEdyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNAIyc/Y; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so5622830137.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759873004; x=1760477804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xQm9H5Jh49DcHPsr4D1tJwbXwJWx+yyuVuQXuRecGQ=;
        b=jNAIyc/Y3Ji/KMjQ1CqiZkLliZevfZE4eG0nJFPP7EDNPFgg5MB0GBOKENi+2M+ZKq
         cse7bDhGgDdeGe3ccmuvo6Hnq4oc+1wbFX2pMUML4IAS8xWts8tUT4In9brBxVU5+idD
         CDWxLCQgdaOKKEJZXHcGFqqE+7G5BylVmpjSdmTvd6UMew3DW51vulcJ8FFzbaJvQ6Hw
         1ra5RpqGQnEU6QOgzYz8PE1+tGbnnCyPVuU8mgbOlHNhG26f1m0heYS9YutOtxQIsSMu
         0jqIwm00xWmBrBuZb5TNyPOLNbothtL1+lo+GfSzCfbrSx/76HPFa/I9OdEq0uSkNCJK
         JOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873004; x=1760477804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xQm9H5Jh49DcHPsr4D1tJwbXwJWx+yyuVuQXuRecGQ=;
        b=Id1s2Rlh+ju7WuZzTgAQXLaMOHtN/rYU3UH0q3QcNwbsqmtT/iT41Z3wHxOCpzIjlC
         yez1HtzOcAyE9ZBew1SYtgDs3bN0qVb1HcO8Gfvjz+tFdyF2kxQUPyEBIxTVHv/PdN3Y
         Q8+G+hlHpKdwrZNjSnAD1QBGyoW0+0oBbAFneu90VroLVM6I7aMm2wZMqUDR1AacM0DS
         BUz4mKG2aNwehsT/los6cEZXeRwZ52Rz903np24VYgYAThRLrSYRdd6eMLa7haVIQ5IK
         XVb+nLIw8KM1aNerNEWI/XG3yEfquK/M5Kafn9dK8foEjJBa+hR28wANflplh02o+6dU
         Fdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVGhV9Tiq4KEemYBxYsyBEF87FPgiNY/oGuU0QYEsVRo4rJxp27a99XMRGI7KfvPilC77Jf3LHrITA4wfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZM8JNrgXYqFHWjaK04/clCGVvN1H67jT/TR+Nr6+A4bP5FlUV
	SxD90dp+gccQD1AxLIJOtU742+m0I3uv9RmNKPY0jLxScaZxRuMBk8+IxMRz0HZROFAg32jHpor
	SJtf1fyPIFZ6ziqTdzYoMrcaqCDE0YdE=
X-Gm-Gg: ASbGncszgVblkcqNcVFAgzupZEy4Tp1i67a4CVzREgqcR2bW3BKh0rXNzneC3ppCzZm
	Jwou229Zqp7yCYMxxz52C3WfzOal1USP0wO1bo+gzsXSxq5c1IHeZ05F3Oftx/Wq/DQcxXggZty
	IonW6ta/frtvdBZRRxigtlQCotwBo+d1JqI/5sQsCWQIk6vEJt2EAXQ0O4x2Yh+4ZceEbtgzNaz
	ZY/fSUDZXIZYUSh6fzv4CYpqLsWjpiFWOmgk/7PUWiC
X-Google-Smtp-Source: AGHT+IEQY0n4i1j9yeWTWQnks09NoqAyZT4ylH9okEwr3Jw4UNa6e2VWeMTPuD/XW35Mr9gxCH6SVqx7KjiwNeZAvlc=
X-Received: by 2002:a05:6102:3909:b0:5a4:8e70:be75 with SMTP id
 ada2fe7eead31-5d5e21d6a91mr545468137.7.1759873004264; Tue, 07 Oct 2025
 14:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org>
 <1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr>
In-Reply-To: <1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr>
From: Han Gao <rabenda.cn@gmail.com>
Date: Wed, 8 Oct 2025 05:36:30 +0800
X-Gm-Features: AS18NWCxXsPyJwGLgGNRNquERcHKe8sZ8VhiFTGIGQJDzKskj5XNWG3A1XF57L8
Message-ID: <CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: guoren@kernel.org, palmer@dabbelt.com, conor@kernel.org, 
	alexghiti@rivosinc.com, paul.walmsley@sifive.com, bjorn@rivosinc.com, 
	eobras@redhat.com, corbet@lwn.net, peterlin@andestech.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex
     This patch is included in the 6.17 merge window but not in the
6.18 merge window.
     Is it possible that the patch was missed?

On Thu, Jul 17, 2025 at 4:22=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 7/13/25 17:53, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > The early version of XuanTie C910 core has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 & th1520 platforms with the qspinlock
> > lock torture test.
> >
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> >
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> >
> > This problem is only observed on the sg2042 hardware platform by
> > running the lock_torture test program for half an hour. The problem
> > was not found in the user space application, because interrupt can
> > break the livelock.
> >
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >   arch/riscv/Kconfig.errata                    | 17 ++++++++++
> >   arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
> >   arch/riscv/include/asm/errata_list_vendors.h |  3 +-
> >   arch/riscv/include/asm/rwonce.h              | 34 +++++++++++++++++++=
+
> >   include/asm-generic/rwonce.h                 |  2 ++
> >   5 files changed, 75 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/riscv/include/asm/rwonce.h
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index e318119d570d..d2c982ba5373 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -130,4 +130,21 @@ config ERRATA_THEAD_GHOSTWRITE
> >
> >         If you don't know what to do here, say "Y".
> >
> > +config ERRATA_THEAD_WRITE_ONCE
> > +     bool "Apply T-Head WRITE_ONCE errata"
> > +     depends on ERRATA_THEAD
> > +     default y
> > +     help
> > +       The early version of T-Head C9xx cores of sg2042 & th1520 have =
a store
> > +       merge buffer delay problem. The store merge buffer could improv=
e the
> > +       store queue performance by merging multi-store requests, but wh=
en there
> > +       are no continued store requests, the prior single store request=
 would be
> > +       waiting in the store queue for a long time. That would cause si=
gnifi-
> > +       cant problems for communication between multi-cores. Appending =
a
> > +       fence w.o could immediately flush the store merge buffer and le=
t other
> > +       cores see the write result.
> > +
> > +       This will apply the WRITE_ONCE errata to handle the non-standar=
d beh-
> > +       avior via appending a fence w.o instruction for WRITE_ONCE().
> > +
> >   endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index 0b942183f708..fbe46f2fa8fb 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int s=
tage,
> >       return true;
> >   }
> >
> > +static bool errata_probe_write_once(unsigned int stage,
> > +                                 unsigned long arch_id, unsigned long =
impid)
> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > +             return false;
> > +
> > +     /* target-c9xx cores report arch_id and impid as 0 */
> > +     if (arch_id !=3D 0 || impid !=3D 0)
> > +             return false;
> > +
> > +     if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> > +         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static u32 thead_errata_probe(unsigned int stage,
> >                             unsigned long archid, unsigned long impid)
> >   {
> > @@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
> >
> >       errata_probe_ghostwrite(stage, archid, impid);
> >
> > +     if (errata_probe_write_once(stage, archid, impid))
> > +             cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> > +
> >       return cpu_req_errata;
> >   }
> >
> > diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/=
include/asm/errata_list_vendors.h
> > index a37d1558f39f..a7473cb8874d 100644
> > --- a/arch/riscv/include/asm/errata_list_vendors.h
> > +++ b/arch/riscv/include/asm/errata_list_vendors.h
> > @@ -18,7 +18,8 @@
> >   #define     ERRATA_THEAD_MAE 0
> >   #define     ERRATA_THEAD_PMU 1
> >   #define     ERRATA_THEAD_GHOSTWRITE 2
> > -#define      ERRATA_THEAD_NUMBER 3
> > +#define      ERRATA_THEAD_WRITE_ONCE 3
> > +#define      ERRATA_THEAD_NUMBER 4
> >   #endif
> >
> >   #endif
> > diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/r=
wonce.h
> > new file mode 100644
> > index 000000000000..081793d4d772
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/rwonce.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RWONCE_H
> > +#define __ASM_RWONCE_H
> > +
> > +#include <linux/compiler_types.h>
> > +#include <asm/alternative-macros.h>
> > +#include <asm/vendorid_list.h>
> > +#include <asm/errata_list_vendors.h>
> > +
> > +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE=
)
> > +
> > +#define write_once_fence()                           \
> > +do {                                                 \
> > +     asm volatile(ALTERNATIVE(                       \
> > +             "nop",                                  \
> > +             "fence w, o",                           \
> > +             THEAD_VENDOR_ID,                        \
> > +             ERRATA_THEAD_WRITE_ONCE,                \
> > +             CONFIG_ERRATA_THEAD_WRITE_ONCE)         \
> > +             : : : "memory");                        \
> > +} while (0)
> > +
> > +#define __WRITE_ONCE(x, val)                         \
> > +do {                                                 \
> > +     *(volatile typeof(x) *)&(x) =3D (val);            \
> > +     write_once_fence();                             \
> > +} while (0)
> > +
> > +#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTER=
NATIVE) */
> > +
> > +#include <asm-generic/rwonce.h>
> > +
> > +#endif       /* __ASM_RWONCE_H */
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.=
h
> > index 52b969c7cef9..4e2d941f15a1 100644
> > --- a/include/asm-generic/rwonce.h
> > +++ b/include/asm-generic/rwonce.h
> > @@ -50,10 +50,12 @@
> >       __READ_ONCE(x);                                                 \
> >   })
> >
> > +#ifndef __WRITE_ONCE
> >   #define __WRITE_ONCE(x, val)                                         =
       \
> >   do {                                                                 =
       \
> >       *(volatile typeof(x) *)&(x) =3D (val);                           =
 \
> >   } while (0)
> > +#endif
> >
> >   #define WRITE_ONCE(x, val)                                          \
> >   do {                                                                 =
       \
>
> I'll send this patchset in my next PR for 6.17:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex
>

