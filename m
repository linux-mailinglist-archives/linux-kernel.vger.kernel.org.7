Return-Path: <linux-kernel+bounces-749312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27041B14CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577CD18A35A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E728C02E;
	Tue, 29 Jul 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usmABHuK"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82D227EA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787494; cv=none; b=N5zW+fM/fVOR7SYRiMZJuJ187vBWjk6qDYTEDmwFbLZkF8Hxu6LiK9aLkIbUJINimhCOkZTVfrfzQpSkfR2opRvtLiua/FB5fJybivOvziu3ZT1v9pAqR6ZqS3oIGIVqJNQujdVTk1tQa5NUhn13ZQC/mbyYjdlfSah+DQBW+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787494; c=relaxed/simple;
	bh=cjKkd+dqRxeXddhvtS7Da5KWwdcK/S8t4q9XeZzLXs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFNxf7kDuT3jmPl9xj/S+xuTOCJ0H5Orp9vqnYT+91RfV70RhvuPxhr2OWOVkTv881Ts83033y6k2rf4Ac9rYxBbqyy2v/avhA/lKwz03g4JM6ub97LUJ4Kq8lE633zXItljlkWxH+W8NA11ZNq2caTjg3KZgrsV+QDE3CsrruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usmABHuK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b561a861fso46173041fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753787491; x=1754392291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=geMEPUiSmJiNkIaRsYiTOZ0Li48P2NhVSHcF23entUk=;
        b=usmABHuK9K87cfeqf3tnb7wTu77/77KKvZ/Gtu6YAC9b9lQQAzfYDSaTmIE4Zez26p
         Tb6DsUqzF9BHxD+3zyTXrDJfP0ueACteLLehPRgjuh/LORkUM3cng1p93lwwvlBQRItX
         WUWZ8cjGwR+61Ng5I08vSFXJmY3QLegbbwWWf/TgRboKYgtEQQ3Y9MtI6cybh9AtojAu
         8EmOosL2pRnTWqVmUpQ18ZF5t7oi5iUkp7ZD3Nnq6oTudMVBZS5Is0T/tIjQpAo3XzIm
         e6Oy9pQt6gPB1F6m3T80xJLkEf28sqbVduCme466eSV2DI42zAd9MtZOv9vRxJOtJO8s
         JBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787491; x=1754392291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geMEPUiSmJiNkIaRsYiTOZ0Li48P2NhVSHcF23entUk=;
        b=E06Uu0R2fYakkev1ww76GTM5MXtZww9SKcll/eUHGmD1TJspLu6deSXDetEfC9VFCL
         k5FjtEimwXB1T/j2sA1ROJNVusUaMSDtsKrQ89SJcH8nuadvuXLO5FObldSUNB+PlXFT
         bC7IOdon8YqBSpC0FArdXaf+kPVfJaPTCmUDLOi9FCuQXHHjsMUh/tTt1Fyh/7cP/lrT
         YuyqaVVtPzydOorPp+NpvIBUi52/sbR1cdoE07TT2TJzcWJ9eUrt6A1mSGBarlMCiqwc
         4bNGiocDxRmWxOiw4rzlG18nXlF8Lwf6+Jcxd0d74xiBTePsypRnempTJOnL2zEkoocB
         mzkg==
X-Forwarded-Encrypted: i=1; AJvYcCVeK/fUHoaosTr7c7Tcm8u2ZmEqDxVD6qrfB4Dik1hLk/bRO9TjJmN1mDBbE3C+Km6iQRtlWeLqZoBEvJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+A4ePlrpDGJnFYuEpVcV6STYz4cWxo1Z2xJoC5C0u5Ux9AajU
	gS4t7/PPdLIG3aeBxKQRkg5p61EjRnuhsBLvw+uIU6cygo5PQu6WAIXrJel2dA7fu8kvQh8L/HI
	OA4cMAsoTzmlEG4njYSMOK20V0a4vvcs4G/1oYERy
X-Gm-Gg: ASbGncv/eTAu5NIVlG6I75jJNJCemnOmJHWR0mBvOVrOCu874O1jGHR/QHWP59pDldK
	5PGuLE9Jit9VOIuqxO0w6deNdB4OaCAz1HtIWnD5x1uoV8fXZsZKSRpeOICvas8An7cKacefNF2
	k6sZbjBqpXmKD6P2S5O9XnGb05vfp1QnuNPNZMpbrvlw3Isl+VmtsSDzA5tTqX8/sUiyLGfuToS
	DZJX2/J2O3mVTHyuAexeCMiAwseu1Zag4ywgDuaJmoAqjR2
X-Google-Smtp-Source: AGHT+IEyY/Qpf0t6eiH1KOYt7ck0cilU1VF/+T5bj5P0WHxZVNNSDGDebwV9oLijqfEGZtDLy48rExTu+Bag8m8laRk=
X-Received: by 2002:a2e:bea5:0:b0:32a:66e6:9ffe with SMTP id
 38308e7fff4ca-331ee7d3804mr47508031fa.21.1753787490459; Tue, 29 Jul 2025
 04:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-6-glider@google.com>
In-Reply-To: <20250728152548.3969143-6-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 29 Jul 2025 13:11:16 +0200
X-Gm-Features: Ac12FXyE_yOxvtIZ9BhHw-sxSVPKEVbpNzROyHI24hsB_aKzQ2JBO_NoNNA7L-8
Message-ID: <CACT4Y+a5ZLpHEwd5LDK7oc8g9HgjsTbo6XgvEBTDBdqU8zCj8g@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] kcov: x86: introduce CONFIG_KCOV_UNIQUE
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, x86@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> wrote:
>
> The new config switches coverage instrumentation to using
>   __sanitizer_cov_trace_pc_guard(u32 *guard)
> instead of
>   __sanitizer_cov_trace_pc(void)
>
> This relies on Clang's -fsanitize-coverage=trace-pc-guard flag [1].
>
> Each callback receives a unique 32-bit guard variable residing in .bss.
> Those guards can be used by kcov to deduplicate the coverage on the fly.
>
> As a first step, we make the new instrumentation mode 1:1 compatible
> with the old one.
>
> [1] https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-pcs-with-guards
>
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


>
> ---
> v3:
>  - per Dmitry Vyukov's request, add better comments in
>    scripts/module.lds.S and lib/Kconfig.debug
>  - add -sanitizer-coverage-drop-ctors to scripts/Makefile.kcov
>    to drop the unwanted constructors emitting unsupported relocations
>  - merge the __sancov_guards section into .bss
>
> v2:
>  - Address comments by Dmitry Vyukov
>    - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
>    - update commit description and config description
>  - Address comments by Marco Elver
>    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
>    - make config depend on X86_64 (via ARCH_HAS_KCOV_UNIQUE)
>    - swap #ifdef branches
>    - tweak config description
>    - remove redundant check for CONFIG_CC_HAS_SANCOV_TRACE_PC_GUARD
>
> Change-Id: Iacb1e71fd061a82c2acadf2347bba4863b9aec39
> ---
>  arch/x86/Kconfig                  |  1 +
>  arch/x86/kernel/vmlinux.lds.S     |  1 +
>  include/asm-generic/vmlinux.lds.h | 13 ++++++-
>  include/linux/kcov.h              |  2 +
>  kernel/kcov.c                     | 61 +++++++++++++++++++++----------
>  lib/Kconfig.debug                 | 26 +++++++++++++
>  scripts/Makefile.kcov             |  7 ++++
>  scripts/module.lds.S              | 35 ++++++++++++++++++
>  tools/objtool/check.c             |  1 +
>  9 files changed, 126 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8bed9030ad473..0533070d24fe7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -94,6 +94,7 @@ config X86
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_KCOV                    if X86_64
> +       select ARCH_HAS_KCOV_UNIQUE             if X86_64
>         select ARCH_HAS_KERNEL_FPU_SUPPORT
>         select ARCH_HAS_MEM_ENCRYPT
>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 4fa0be732af10..52fe6539b9c91 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -372,6 +372,7 @@ SECTIONS
>                 . = ALIGN(PAGE_SIZE);
>                 *(BSS_MAIN)
>                 BSS_DECRYPTED
> +               BSS_SANCOV_GUARDS
>                 . = ALIGN(PAGE_SIZE);
>                 __bss_stop = .;
>         }
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index fa5f19b8d53a0..ee78328eecade 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -102,7 +102,8 @@
>   * sections to be brought in with rodata.
>   */
>  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
> -defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> +       defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG) || \
> +       defined(CONFIG_KCOV_UNIQUE)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
>  #else
>  #define TEXT_MAIN .text
> @@ -121,6 +122,16 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define SBSS_MAIN .sbss
>  #endif
>
> +#if defined(CONFIG_KCOV_UNIQUE)
> +/* BSS_SANCOV_GUARDS must be part of the .bss section so that it is zero-initialized. */
> +#define BSS_SANCOV_GUARDS                      \
> +       __start___sancov_guards = .;            \
> +       *(__sancov_guards);                     \
> +       __stop___sancov_guards = .;
> +#else
> +#define BSS_SANCOV_GUARDS
> +#endif
> +
>  /*
>   * GCC 4.5 and later have a 32 bytes section alignment for structures.
>   * Except GCC 4.9, that feels the need to align on 64 bytes.
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 2b3655c0f2278..2acccfa5ae9af 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -107,6 +107,8 @@ typedef unsigned long long kcov_u64;
>  #endif
>
>  void __sanitizer_cov_trace_pc(void);
> +void __sanitizer_cov_trace_pc_guard(u32 *guard);
> +void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *stop);
>  void __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2);
>  void __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2);
>  void __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2);
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 5170f367c8a1b..8154ac1c1622e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -194,27 +194,15 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
>         return ip;
>  }
>
> -/*
> - * Entry point from instrumented code.
> - * This is called once per basic-block/edge.
> - */
> -void notrace __sanitizer_cov_trace_pc(void)
> +static notrace void kcov_append_to_buffer(unsigned long *area, int size,
> +                                         unsigned long ip)
>  {
> -       struct task_struct *t;
> -       unsigned long *area;
> -       unsigned long ip = canonicalize_ip(_RET_IP_);
> -       unsigned long pos;
> -
> -       t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> -               return;
> -
> -       area = t->kcov_state.area;
>         /* The first 64-bit word is the number of subsequent PCs. */
> -       pos = READ_ONCE(area[0]) + 1;
> -       if (likely(pos < t->kcov_state.size)) {
> -               /* Previously we write pc before updating pos. However, some
> -                * early interrupt code could bypass check_kcov_mode() check
> +       unsigned long pos = READ_ONCE(area[0]) + 1;
> +
> +       if (likely(pos < size)) {
> +               /*
> +                * Some early interrupt code could bypass check_kcov_mode() check
>                  * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
>                  * raised between writing pc and updating pos, the pc could be
>                  * overitten by the recursive __sanitizer_cov_trace_pc().
> @@ -225,7 +213,40 @@ void notrace __sanitizer_cov_trace_pc(void)
>                 area[pos] = ip;
>         }
>  }
> +
> +/*
> + * Entry point from instrumented code.
> + * This is called once per basic-block/edge.
> + */
> +#ifdef CONFIG_KCOV_UNIQUE
> +void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
> +{
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> +               return;
> +
> +       kcov_append_to_buffer(current->kcov_state.area,
> +                             current->kcov_state.size,
> +                             canonicalize_ip(_RET_IP_));
> +}
> +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
> +
> +void notrace __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
> +                                                uint32_t *stop)
> +{
> +}
> +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard_init);
> +#else /* !CONFIG_KCOV_UNIQUE */
> +void notrace __sanitizer_cov_trace_pc(void)
> +{
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> +               return;
> +
> +       kcov_append_to_buffer(current->kcov_state.area,
> +                             current->kcov_state.size,
> +                             canonicalize_ip(_RET_IP_));
> +}
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> +#endif
>
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>  static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> @@ -253,7 +274,7 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         start_index = 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <= max_pos)) {
> -               /* See comment in __sanitizer_cov_trace_pc(). */
> +               /* See comment in kcov_append_to_buffer(). */
>                 WRITE_ONCE(area[0], count + 1);
>                 barrier();
>                 area[start_index] = type;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6e..a7441f89465f3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2153,6 +2153,12 @@ config ARCH_HAS_KCOV
>           build and run with CONFIG_KCOV. This typically requires
>           disabling instrumentation for some early boot code.
>
> +config CC_HAS_SANCOV_TRACE_PC
> +       def_bool $(cc-option,-fsanitize-coverage=trace-pc)
> +
> +config CC_HAS_SANCOV_TRACE_PC_GUARD
> +       def_bool $(cc-option,-fsanitize-coverage=trace-pc-guard)
> +
>  config KCOV
>         bool "Code coverage for fuzzing"
>         depends on ARCH_HAS_KCOV
> @@ -2166,6 +2172,26 @@ config KCOV
>
>           For more details, see Documentation/dev-tools/kcov.rst.
>
> +config ARCH_HAS_KCOV_UNIQUE
> +       bool
> +       help
> +         An architecture should select this when it can successfully
> +         build and run with CONFIG_KCOV_UNIQUE.
> +
> +config KCOV_UNIQUE
> +       depends on KCOV
> +       depends on CC_HAS_SANCOV_TRACE_PC_GUARD && ARCH_HAS_KCOV_UNIQUE
> +       bool "Enable unique program counter collection mode for KCOV"
> +       help
> +         This option enables KCOV's unique program counter (PC) collection mode,
> +         which deduplicates PCs on the fly when the KCOV_UNIQUE_ENABLE ioctl is
> +         used.
> +
> +         This significantly reduces the memory footprint for coverage data
> +         collection compared to trace mode, as it prevents the kernel from
> +         storing the same PC multiple times.
> +         Enabling this mode incurs a slight increase in kernel binary size.
> +
>  config KCOV_ENABLE_COMPARISONS
>         bool "Enable comparison operands collection by KCOV"
>         depends on KCOV
> diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> index 78305a84ba9d2..c3ad5504f5600 100644
> --- a/scripts/Makefile.kcov
> +++ b/scripts/Makefile.kcov
> @@ -1,5 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +ifeq ($(CONFIG_KCOV_UNIQUE),y)
> +kcov-flags-y                                   += -fsanitize-coverage=trace-pc-guard
> +# Drop per-file constructors that -fsanitize-coverage=trace-pc-guard inserts by default.
> +# Kernel does not need them, and they may produce unknown relocations.
> +kcov-flags-y                                   += -mllvm -sanitizer-coverage-drop-ctors
> +else
>  kcov-flags-y                                   += -fsanitize-coverage=trace-pc
> +endif
>  kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)   += -fsanitize-coverage=trace-cmp
>
>  kcov-rflags-y                                  += -Cpasses=sancov-module
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 450f1088d5fd3..17f36d5112c5d 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -47,6 +47,7 @@ SECTIONS {
>         .bss : {
>                 *(.bss .bss.[0-9a-zA-Z_]*)
>                 *(.bss..L*)
> +               *(__sancov_guards)
>         }
>
>         .data : {
> @@ -64,6 +65,40 @@ SECTIONS {
>                 MOD_CODETAG_SECTIONS()
>         }
>  #endif
> +
> +#ifdef CONFIG_KCOV_UNIQUE
> +       /*
> +        * CONFIG_KCOV_UNIQUE creates COMDAT groups for instrumented functions,
> +        * which has the following consequences in the presence of
> +        * -ffunction-sections:
> +        *  - Separate .init.text and .exit.text sections in the modules are not
> +        *    merged together, which results in errors trying to create
> +        *    duplicate entries in /sys/module/MODNAME/sections/ at module load
> +        *    time.
> +        *  - Each function is placed in a separate .text.funcname section, so
> +        *    there is no .text section anymore. Collecting them together here
> +        *    has mostly aesthetic purpose, although some tools may be expecting
> +        *    it to be present.
> +        */
> +       .text : {
> +               *(.text .text.[0-9a-zA-Z_]*)
> +               *(.text..L*)
> +       }
> +       .init.text : {
> +               *(.init.text .init.text.[0-9a-zA-Z_]*)
> +               *(.init.text..L*)
> +       }
> +       .exit.text : {
> +               *(.exit.text .exit.text.[0-9a-zA-Z_]*)
> +               *(.exit.text..L*)
> +       }
> +       .bss : {
> +               *(.bss .bss.[0-9a-zA-Z_]*)
> +               *(.bss..L*)
> +               *(__sancov_guards)
> +       }
> +#endif
> +
>         MOD_SEPARATE_CODETAG_SECTIONS()
>  }
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 67d76f3a1dce5..60eb5faa27d28 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1156,6 +1156,7 @@ static const char *uaccess_safe_builtin[] = {
>         "write_comp_data",
>         "check_kcov_mode",
>         "__sanitizer_cov_trace_pc",
> +       "__sanitizer_cov_trace_pc_guard",
>         "__sanitizer_cov_trace_const_cmp1",
>         "__sanitizer_cov_trace_const_cmp2",
>         "__sanitizer_cov_trace_const_cmp4",
> --
> 2.50.1.470.g6ba607880d-goog
>

