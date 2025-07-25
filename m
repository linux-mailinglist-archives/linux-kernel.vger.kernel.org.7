Return-Path: <linux-kernel+bounces-745571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C284CB11BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D468AC3A96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA752D63E4;
	Fri, 25 Jul 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzY5mYz0"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B3198E8C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438068; cv=none; b=t5lg6colpxi3K+k1DSRnWvz5DBurVx+ahSxf8WQmoOFHL04d37OeU7gTjM94z+ofUDhsZNAV1TCH0/Bnotkl1jq9VJeWAgYRdJ/34MZnAvZMLI2XVa9vfGBUkRAuTh9oxRaISthQrRbZUhDxa/4M+aM/WEDZdsRgEm8PlvGWGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438068; c=relaxed/simple;
	bh=ZsCYlrpjUIYNkaYhG3e1Kp3P16XvvzYj/hGIvmf8CPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PslypDsW0scs06Oq3BQjmKik1Z0BarVNyy3s3VI/i0pFgSk6TIXHRhQcpF2NLq+cFqm/f3zHvQUjMF51AD+A3dSItwIGEHL7I0yQbB/t7zthKNLCbNQC26yqgnq9zCFDfQEnnqmX4AFNXzfM+ZJYRxKYss4WslUHkVYpI3UdMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzY5mYz0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fafdd322d3so19981516d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753438065; x=1754042865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq57YvRXrwTcYsKh+D33blhDVrknv64jxZ2lz0EJIqo=;
        b=MzY5mYz0u9Y4Nr4qQ5SuEbctrKSiskvPoh1TZtO5hFPKGAtCyOMIy981wYbUKxg6NH
         8VRIOAkVhMxpUHVJ9OP6pQ17BnIcgl0BO1frIRS4u8ENdHAYAsGuLHxzEFeCsPdmMw5N
         yU20Jimmb0QubekvjYGKCFG/WYtN+Rktb0zCoQFdy4xMpi2T8Nzj3fXzq3j09w4EUjGW
         4Ia5GdWsgbvPewdI+8RRhgy5kPDQoJlbWqewwn2MDKT09rHwA0Hd8Xf77eyMp4xGzvx7
         e/X3nkOXzWkIVto95IELO7q5XfU2xtUP8g4dZneEa9WRWOoSVuPh1GJygP5qJc3DgUN+
         uQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438065; x=1754042865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq57YvRXrwTcYsKh+D33blhDVrknv64jxZ2lz0EJIqo=;
        b=gWXFqq7AzcTgtg/nL4XXNKq/UcmjjHzo04Xy9Y/12hVPhAafNgOIG51vb/EcncDhhf
         S5puIAwFoHFCebDRrZyPxlCfGB8kn4AiPbifPseAiV/KZrfCVWDphwAw9nHWELV/8rER
         VUhyUJjeMha0yJvU1NOEFMETcxlgYA1CAkDdkDc6VUa/pGvYDw49fPsSO/eYP5fEYYOJ
         bsuaH3TwHUF9ZiBi0dz2d4vCCgj3AAyErsZek1RSAncutLd4v62Eu2OyCegqaKDzuynz
         gecjVNpzXB8XjrZtbVbRBHr65zyzyRHKwpPDC/1wmR7uMNP3NoraewJzP+Xo1W7Kzrps
         P8FA==
X-Forwarded-Encrypted: i=1; AJvYcCWEMSGmlfHZxlwevVYJBdtjGJZtiGLJY1jTVrsuLovD0v1q7l06PoQyK6t30Cjxd81ZzqtZDAs4JmipM+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV07elOjxm97GSko1p8gKz67fUNBb/Aq1UhK7QSh78lcyqcjdC
	GyhRw37jYgvJ0ADWwV44074OOgVRdWACAS8Bd/5CrySYcRrQOJa5tNmMxaJcpBKvkzuWworENgM
	opIl1WGaWQkyjFnCwFcnj8WSt0Gk/fHZ2GoihyN6x
X-Gm-Gg: ASbGnctHzTkqU1YoWMPPwQzyfjhFDD3oPIusXWPim5FqSr5Ge6Sf5jG9xJYGxIWuxaK
	UjaF7KJaQywuX/EnGFEwnFJQqsEyRdQ9zKIouFLAVTOzG/ViVM0qoX+DVgqsVAwHvpZB9ZooIeU
	ZJDjrjpZSTg7yjXUjYusbHHhUN1BHcPUOFa1D0BnKyOoluJnMZdEv9VehWDOwc30Zat7F1Yyiru
	GzrDxP/5N4BQqhRATB1WEVwXPKt9lN7QlrlZA==
X-Google-Smtp-Source: AGHT+IGuMjeMC8K1zmbnYERhNN88JIXkAgYRELXmYcpJklOwF+gb0MBbPlErXPj5NCFtAJ1sIiTZ2cLWYGkgvU7FKYU=
X-Received: by 2002:a05:6214:f0b:b0:707:bba:40d4 with SMTP id
 6a1803df08f44-7072052762emr19107456d6.11.1753438064731; Fri, 25 Jul 2025
 03:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-7-glider@google.com>
 <CACT4Y+b_KkqF0dm8OM1VUfwzDph6gHisk2amkk9RrLiGV24s9A@mail.gmail.com>
In-Reply-To: <CACT4Y+b_KkqF0dm8OM1VUfwzDph6gHisk2amkk9RrLiGV24s9A@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 25 Jul 2025 12:07:07 +0200
X-Gm-Features: Ac12FXyiwwfyc1H4wzpo6zW675-o_drEgRHCr_MkKkiDI7okUQOE1MYpFzghCq4
Message-ID: <CAG_fn=VymVR+RNeeNOkVaOD3tpY=MFwP-8vU+w0+H5vS7jWMMA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] kcov: x86: introduce CONFIG_KCOV_UNIQUE
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, x86@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:01=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> w=
rote:
>
> On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > The new config switches coverage instrumentation to using
> >   __sanitizer_cov_trace_pc_guard(u32 *guard)
> > instead of
> >   __sanitizer_cov_trace_pc(void)
> >
> > This relies on Clang's -fsanitize-coverage=3Dtrace-pc-guard flag [1].
> >
> > Each callback receives a unique 32-bit guard variable residing in the
> > __sancov_guards section. Those guards can be used by kcov to deduplicat=
e
> > the coverage on the fly.
> >
> > As a first step, we make the new instrumentation mode 1:1 compatible
> > with the old one.
> >
> > [1] https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-pcs-with=
-guards
> >
> > Cc: x86@kernel.org
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > ---
> > Change-Id: Iacb1e71fd061a82c2acadf2347bba4863b9aec39
> >
> > v2:
> >  - Address comments by Dmitry Vyukov
> >    - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
> >    - update commit description and config description
> >  - Address comments by Marco Elver
> >    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
> >    - make config depend on X86_64 (via ARCH_HAS_KCOV_UNIQUE)
> >    - swap #ifdef branches
> >    - tweak config description
> >    - remove redundant check for CONFIG_CC_HAS_SANCOV_TRACE_PC_GUARD
> > ---
> >  arch/x86/Kconfig                  |  1 +
> >  arch/x86/kernel/vmlinux.lds.S     |  1 +
> >  include/asm-generic/vmlinux.lds.h | 14 ++++++-
> >  include/linux/kcov.h              |  2 +
> >  kernel/kcov.c                     | 61 +++++++++++++++++++++----------
> >  lib/Kconfig.debug                 | 24 ++++++++++++
> >  scripts/Makefile.kcov             |  4 ++
> >  scripts/module.lds.S              | 23 ++++++++++++
> >  tools/objtool/check.c             |  1 +
> >  9 files changed, 110 insertions(+), 21 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index e21cca404943e..d104c5a193bdf 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -93,6 +93,7 @@ config X86
> >         select ARCH_HAS_FORTIFY_SOURCE
> >         select ARCH_HAS_GCOV_PROFILE_ALL
> >         select ARCH_HAS_KCOV                    if X86_64
> > +       select ARCH_HAS_KCOV_UNIQUE             if X86_64
> >         select ARCH_HAS_KERNEL_FPU_SUPPORT
> >         select ARCH_HAS_MEM_ENCRYPT
> >         select ARCH_HAS_MEMBARRIER_SYNC_CORE
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.ld=
s.S
> > index cda5f8362e9da..8076e8953fddc 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -372,6 +372,7 @@ SECTIONS
> >                 . =3D ALIGN(PAGE_SIZE);
> >                 __bss_stop =3D .;
> >         }
> > +       SANCOV_GUARDS_BSS
> >
> >         /*
> >          * The memory occupied from _text to here, __end_of_kernel_rese=
rve, is
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 58a635a6d5bdf..875c4deb66208 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -102,7 +102,8 @@
> >   * sections to be brought in with rodata.
> >   */
> >  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG) || \
> > -defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> > +       defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG=
) || \
> > +       defined(CONFIG_KCOV_UNIQUE)
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> >  #else
> >  #define TEXT_MAIN .text
> > @@ -121,6 +122,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PR=
OPELLER_CLANG)
> >  #define SBSS_MAIN .sbss
> >  #endif
> >
> > +#if defined(CONFIG_KCOV_UNIQUE)
> > +#define SANCOV_GUARDS_BSS                      \
> > +       __sancov_guards(NOLOAD) : {             \
> > +               __start___sancov_guards =3D .;    \
> > +               *(__sancov_guards);             \
> > +               __stop___sancov_guards =3D .;     \
> > +       }
> > +#else
> > +#define SANCOV_GUARDS_BSS
> > +#endif
> > +
> >  /*
> >   * GCC 4.5 and later have a 32 bytes section alignment for structures.
> >   * Except GCC 4.9, that feels the need to align on 64 bytes.
> > diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> > index 0e425c3524b86..dd8bbee6fe274 100644
> > --- a/include/linux/kcov.h
> > +++ b/include/linux/kcov.h
> > @@ -107,6 +107,8 @@ typedef unsigned long long kcov_u64;
> >  #endif
> >
> >  void __sanitizer_cov_trace_pc(void);
> > +void __sanitizer_cov_trace_pc_guard(u32 *guard);
> > +void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *st=
op);
> >  void __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2);
> >  void __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2);
> >  void __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2);
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index ff7f118644f49..8e98ca8d52743 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -195,27 +195,15 @@ static notrace unsigned long canonicalize_ip(unsi=
gned long ip)
> >         return ip;
> >  }
> >
> > -/*
> > - * Entry point from instrumented code.
> > - * This is called once per basic-block/edge.
> > - */
> > -void notrace __sanitizer_cov_trace_pc(void)
> > +static notrace void kcov_append_to_buffer(unsigned long *area, int siz=
e,
> > +                                         unsigned long ip)
> >  {
> > -       struct task_struct *t;
> > -       unsigned long *area;
> > -       unsigned long ip =3D canonicalize_ip(_RET_IP_);
> > -       unsigned long pos;
> > -
> > -       t =3D current;
> > -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> > -               return;
> > -
> > -       area =3D t->kcov_state.area;
> >         /* The first 64-bit word is the number of subsequent PCs. */
> > -       pos =3D READ_ONCE(area[0]) + 1;
> > -       if (likely(pos < t->kcov_state.size)) {
> > -               /* Previously we write pc before updating pos. However,=
 some
> > -                * early interrupt code could bypass check_kcov_mode() =
check
> > +       unsigned long pos =3D READ_ONCE(area[0]) + 1;
> > +
> > +       if (likely(pos < size)) {
> > +               /*
> > +                * Some early interrupt code could bypass check_kcov_mo=
de() check
> >                  * and invoke __sanitizer_cov_trace_pc(). If such inter=
rupt is
> >                  * raised between writing pc and updating pos, the pc c=
ould be
> >                  * overitten by the recursive __sanitizer_cov_trace_pc(=
).
> > @@ -226,7 +214,40 @@ void notrace __sanitizer_cov_trace_pc(void)
> >                 area[pos] =3D ip;
> >         }
> >  }
> > +
> > +/*
> > + * Entry point from instrumented code.
> > + * This is called once per basic-block/edge.
> > + */
> > +#ifdef CONFIG_KCOV_UNIQUE
> > +void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
> > +{
> > +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> > +               return;
> > +
> > +       kcov_append_to_buffer(current->kcov_state.area,
> > +                             current->kcov_state.size,
> > +                             canonicalize_ip(_RET_IP_));
> > +}
> > +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
> > +
> > +void notrace __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
> > +                                                uint32_t *stop)
> > +{
> > +}
> > +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard_init);
> > +#else /* !CONFIG_KCOV_UNIQUE */
> > +void notrace __sanitizer_cov_trace_pc(void)
> > +{
> > +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> > +               return;
> > +
> > +       kcov_append_to_buffer(current->kcov_state.area,
> > +                             current->kcov_state.size,
> > +                             canonicalize_ip(_RET_IP_));
> > +}
> >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> > +#endif
> >
> >  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
> >  static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 =
ip)
> > @@ -254,7 +275,7 @@ static void notrace write_comp_data(u64 type, u64 a=
rg1, u64 arg2, u64 ip)
> >         start_index =3D 1 + count * KCOV_WORDS_PER_CMP;
> >         end_pos =3D (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
> >         if (likely(end_pos <=3D max_pos)) {
> > -               /* See comment in __sanitizer_cov_trace_pc(). */
> > +               /* See comment in kcov_append_to_buffer(). */
> >                 WRITE_ONCE(area[0], count + 1);
> >                 barrier();
> >                 area[start_index] =3D type;
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f9051ab610d54..24dcb721dbb0b 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2156,6 +2156,8 @@ config ARCH_HAS_KCOV
> >  config CC_HAS_SANCOV_TRACE_PC
> >         def_bool $(cc-option,-fsanitize-coverage=3Dtrace-pc)
> >
> > +config CC_HAS_SANCOV_TRACE_PC_GUARD
> > +       def_bool $(cc-option,-fsanitize-coverage=3Dtrace-pc-guard)
> >
> >  config KCOV
> >         bool "Code coverage for fuzzing"
> > @@ -2172,6 +2174,28 @@ config KCOV
> >
> >           For more details, see Documentation/dev-tools/kcov.rst.
> >
> > +config ARCH_HAS_KCOV_UNIQUE
> > +       bool
> > +       help
> > +         An architecture should select this when it can successfully
> > +         build and run with CONFIG_KCOV_UNIQUE.
> > +
> > +config KCOV_UNIQUE
> > +       depends on KCOV
> > +       depends on CC_HAS_SANCOV_TRACE_PC_GUARD && ARCH_HAS_KCOV_UNIQUE
> > +       bool "Use coverage guards for KCOV"
> > +       help
> > +         Use coverage guards instrumentation for KCOV, passing
> > +         -fsanitize-coverage=3Dtrace-pc-guard to the compiler.
>
> I think this should talk about the new mode, the new ioctl's, and
> visible differences for end users first.

Something like this, maybe?

          This option enables KCOV's unique program counter (PC)
collection mode,
          which deduplicates PCs on the fly when the KCOV_UNIQUE_ENABLE ioc=
tl is
          used.

          This significantly reduces the memory footprint for coverage data
          collection compared to trace mode, as it prevents the kernel from
          storing the same PC multiple times.
          Enabling this mode incurs a slight increase in kernel binary size=
.


> > +         Every coverage callback is associated with a global variable =
that
> > +         allows to efficiently deduplicate coverage at collection time=
.
> > +         This drastically reduces the buffer size required for coverag=
e
> > +         collection.
> > +
> > +         This config comes at a cost of increased binary size (4 bytes=
 of .bss
> > +         plus 1-2 instructions to pass an extra parameter, per basic b=
lock).
> > +
> >  config KCOV_ENABLE_COMPARISONS
> >         bool "Enable comparison operands collection by KCOV"
> >         depends on KCOV
> > diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> > index 67e8cfe3474b7..0b17533ef35f6 100644
> > --- a/scripts/Makefile.kcov
> > +++ b/scripts/Makefile.kcov
> > @@ -1,5 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +ifeq ($(CONFIG_KCOV_UNIQUE),y)
> > +kcov-flags-y                                   +=3D -fsanitize-coverag=
e=3Dtrace-pc-guard
> > +else
> >  kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)    +=3D -fsanitize-coverag=
e=3Dtrace-pc
> > +endif
> >  kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)   +=3D -fsanitize-coverag=
e=3Dtrace-cmp
> >  kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)         +=3D -fplugin=3D$(objtr=
ee)/scripts/gcc-plugins/sancov_plugin.so
> >
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index 450f1088d5fd3..314b56680ea1a 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -64,6 +64,29 @@ SECTIONS {
> >                 MOD_CODETAG_SECTIONS()
> >         }
> >  #endif
> > +
> > +#ifdef CONFIG_KCOV_UNIQUE
> > +       __sancov_guards(NOLOAD) : {
> > +               __start___sancov_guards =3D .;
> > +               *(__sancov_guards);
> > +               __stop___sancov_guards =3D .;
> > +       }
> > +
> > +       .text : {
> > +               *(.text .text.[0-9a-zA-Z_]*)
> > +               *(.text..L*)
> > +       }
>
> Why do we need these here? .text does not look specific to CONFIG_KCOV_UN=
IQUE.
> Is it because of constructors/destructors emitted by the compiler, and
> .init.text/.exit.text don't work w/o .text?
> A comment here would be useful.

This is because the compiler creates duplicate .init.text/.exit.text,
making the module loader unhappy.
I'll add a comment.

