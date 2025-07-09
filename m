Return-Path: <linux-kernel+bounces-723965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0BAFED17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DE55C3092
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573A52E7160;
	Wed,  9 Jul 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zoU4Q13"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E22E62B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073290; cv=none; b=Ba0S8cb0czIKd9+BMrWm3TNYbCPyN0dYo1JbjizO61VSRXOt4ineBIJKjTocSXTNNrWwC52Cm+DzdvLMNqkJKR3ubuR7SzeF9CBF5IOf30Gi1jmLlhZP04aunglMqaN/h9SJFV261ayIgCuj941Zj5MNSHS+5iDNxlj9j2iGgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073290; c=relaxed/simple;
	bh=3REAqfWsb9w2F/DhnR+CxRbOSM5cKHbnQp4U1pc8qr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F79GDj558hvlB8P1orRHkBmTLwvYc9SMRKs9FPdvO8lXzz4s5t/7yhr1uuADth8STa/b3sOvJLrAv2W9oF0NCNp2rfMIlSD/wxRQpsXZPSnDsiHc/qijrnDcsjzJCOflz5EQ+6WUJmfQaMTCb2bPGeFfUNN+5KvvmzV5mxeyH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zoU4Q13; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso10270731fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752073286; x=1752678086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EXZ6H+YoWJArAnXa1Z6UilH2W16N5kp2UTPdU52uK04=;
        b=2zoU4Q13GHkaIHT4HZENIaYlV1ex1Yfdn7CitdHhPhLFc6xDI8gSRI+WM4zinWMqSS
         EPQq2E7cxN88wkcCTxGjw6Y+hPJ7J5/H04gQWmQE1wCsqMaEogQ3ezv/xN5RtBBu1e+f
         YZSyXGzFNNXig3LAHBSzKFLPBkvOFo94+lQLRDWrh0IGj//X515cy9bOSMcGVmAehNZq
         PDfYtVAIb5NsusHBe03Z3mhI6HjLV1ckjtxS+alZ/8hryb9F9bfPqDVNSZ7ICQvAYsrz
         Sztj3FYaubLk27maM8odrrYO59851AMrIdomWY+2nEl5t0j89Kis1Xh+8TqQtgMDFyM6
         eQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073286; x=1752678086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXZ6H+YoWJArAnXa1Z6UilH2W16N5kp2UTPdU52uK04=;
        b=i35XjttB7O4zvS9Q92wKckJuSG19VIe0GuVDrSEarOcCTbiTd+N/dozYjy/JAeNaDv
         nqoDX9CXTnwc9JVJJXrQ4XlfTUaAItQJ3/dOeJd3kvt5iypv9/EkwcY8lA4Y/hldRtZu
         xR3ieKNGSRPsNC6qJIyv5W3AyHxFJWzC+yX3GguknQsFgOI+wbesY17s97Jb5OuN3Ibz
         IQPjACyyVXz6cyidvlxVzDuyDacTzRe2ZaFR7DC2fYzVRtTzw+DPuX+PIabmaUkbawYl
         M5Y+2pMIpb4xo5CMRi+Mw6Q9zL+y7pq/VV3TvVYno8OZJjwBVzjFugBFMot93OymN//0
         WNFA==
X-Forwarded-Encrypted: i=1; AJvYcCUWGcPsm/cJUP+HcApKocED7vdPf3Lhph1amqGv28xMtbh965iZ4qvIAROUpYIUdVIkybdZJoIjNBzDdo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzgh3uHxVlKY1LdMNOmmZPplkEVvDyHiu+E3uH/NkgB7PkIVH
	Y0f4KH60XclhfXwK2iRx7jhtJTa4oOELj7ZZiLFgf9XauCTcRFL0U7Z0h5wu8Bq+L9reGsB5ITA
	LgwoUZQxtQ2t9X/Ru6LLPPIfkyoR9HxWvGdxFuZrh
X-Gm-Gg: ASbGncsIBiu/xNdgT0jw82l6bx/1OZvQ3jxjvAGhfHi64s4JHuvrJ7yF8naddvoFxXC
	t6el1HmJK4vr3zWiXMDtyO/2a7lBaAjCbZ4JMLJbKd3Grz8YKR4sayr0Pm7eZCKDD8MR+psTM6K
	aERVBkerlQfQwKfblkfVP1eznCXOZ2edN9gpnsjTRIBfGniWOQDfSqw20vmaV72WGwBGSNc4R3j
	J++
X-Google-Smtp-Source: AGHT+IH5ZFMDWTGADULLu5fy78GGpCJakCCwStlHSm3CBeDYKYdUiE2DChI94XJbxyS5huGBOrGpOXINAZfhpQ9p1CY=
X-Received: by 2002:a2e:be0e:0:b0:32b:7811:d451 with SMTP id
 38308e7fff4ca-32f39b49274mr23241471fa.16.1752073284044; Wed, 09 Jul 2025
 08:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-7-glider@google.com>
In-Reply-To: <20250626134158.3385080-7-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 Jul 2025 17:01:12 +0200
X-Gm-Features: Ac12FXyg4ttgAUhDWzibcPhOOzL0-kmtMxmwZUbc31PqG9SfpgNYhtV4DobNjeM
Message-ID: <CACT4Y+b_KkqF0dm8OM1VUfwzDph6gHisk2amkk9RrLiGV24s9A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] kcov: x86: introduce CONFIG_KCOV_UNIQUE
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, x86@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wrote:
>
> The new config switches coverage instrumentation to using
>   __sanitizer_cov_trace_pc_guard(u32 *guard)
> instead of
>   __sanitizer_cov_trace_pc(void)
>
> This relies on Clang's -fsanitize-coverage=trace-pc-guard flag [1].
>
> Each callback receives a unique 32-bit guard variable residing in the
> __sancov_guards section. Those guards can be used by kcov to deduplicate
> the coverage on the fly.
>
> As a first step, we make the new instrumentation mode 1:1 compatible
> with the old one.
>
> [1] https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-pcs-with-guards
>
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
>
> ---
> Change-Id: Iacb1e71fd061a82c2acadf2347bba4863b9aec39
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
> ---
>  arch/x86/Kconfig                  |  1 +
>  arch/x86/kernel/vmlinux.lds.S     |  1 +
>  include/asm-generic/vmlinux.lds.h | 14 ++++++-
>  include/linux/kcov.h              |  2 +
>  kernel/kcov.c                     | 61 +++++++++++++++++++++----------
>  lib/Kconfig.debug                 | 24 ++++++++++++
>  scripts/Makefile.kcov             |  4 ++
>  scripts/module.lds.S              | 23 ++++++++++++
>  tools/objtool/check.c             |  1 +
>  9 files changed, 110 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e21cca404943e..d104c5a193bdf 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -93,6 +93,7 @@ config X86
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_KCOV                    if X86_64
> +       select ARCH_HAS_KCOV_UNIQUE             if X86_64
>         select ARCH_HAS_KERNEL_FPU_SUPPORT
>         select ARCH_HAS_MEM_ENCRYPT
>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index cda5f8362e9da..8076e8953fddc 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -372,6 +372,7 @@ SECTIONS
>                 . = ALIGN(PAGE_SIZE);
>                 __bss_stop = .;
>         }
> +       SANCOV_GUARDS_BSS
>
>         /*
>          * The memory occupied from _text to here, __end_of_kernel_reserve, is
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 58a635a6d5bdf..875c4deb66208 100644
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
> @@ -121,6 +122,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define SBSS_MAIN .sbss
>  #endif
>
> +#if defined(CONFIG_KCOV_UNIQUE)
> +#define SANCOV_GUARDS_BSS                      \
> +       __sancov_guards(NOLOAD) : {             \
> +               __start___sancov_guards = .;    \
> +               *(__sancov_guards);             \
> +               __stop___sancov_guards = .;     \
> +       }
> +#else
> +#define SANCOV_GUARDS_BSS
> +#endif
> +
>  /*
>   * GCC 4.5 and later have a 32 bytes section alignment for structures.
>   * Except GCC 4.9, that feels the need to align on 64 bytes.
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 0e425c3524b86..dd8bbee6fe274 100644
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
> index ff7f118644f49..8e98ca8d52743 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -195,27 +195,15 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
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
> @@ -226,7 +214,40 @@ void notrace __sanitizer_cov_trace_pc(void)
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
> @@ -254,7 +275,7 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         start_index = 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <= max_pos)) {
> -               /* See comment in __sanitizer_cov_trace_pc(). */
> +               /* See comment in kcov_append_to_buffer(). */
>                 WRITE_ONCE(area[0], count + 1);
>                 barrier();
>                 area[start_index] = type;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f9051ab610d54..24dcb721dbb0b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2156,6 +2156,8 @@ config ARCH_HAS_KCOV
>  config CC_HAS_SANCOV_TRACE_PC
>         def_bool $(cc-option,-fsanitize-coverage=trace-pc)
>
> +config CC_HAS_SANCOV_TRACE_PC_GUARD
> +       def_bool $(cc-option,-fsanitize-coverage=trace-pc-guard)
>
>  config KCOV
>         bool "Code coverage for fuzzing"
> @@ -2172,6 +2174,28 @@ config KCOV
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
> +       bool "Use coverage guards for KCOV"
> +       help
> +         Use coverage guards instrumentation for KCOV, passing
> +         -fsanitize-coverage=trace-pc-guard to the compiler.

I think this should talk about the new mode, the new ioctl's, and
visible differences for end users first.

> +         Every coverage callback is associated with a global variable that
> +         allows to efficiently deduplicate coverage at collection time.
> +         This drastically reduces the buffer size required for coverage
> +         collection.
> +
> +         This config comes at a cost of increased binary size (4 bytes of .bss
> +         plus 1-2 instructions to pass an extra parameter, per basic block).
> +
>  config KCOV_ENABLE_COMPARISONS
>         bool "Enable comparison operands collection by KCOV"
>         depends on KCOV
> diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> index 67e8cfe3474b7..0b17533ef35f6 100644
> --- a/scripts/Makefile.kcov
> +++ b/scripts/Makefile.kcov
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +ifeq ($(CONFIG_KCOV_UNIQUE),y)
> +kcov-flags-y                                   += -fsanitize-coverage=trace-pc-guard
> +else
>  kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)    += -fsanitize-coverage=trace-pc
> +endif
>  kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)   += -fsanitize-coverage=trace-cmp
>  kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)         += -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 450f1088d5fd3..314b56680ea1a 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -64,6 +64,29 @@ SECTIONS {
>                 MOD_CODETAG_SECTIONS()
>         }
>  #endif
> +
> +#ifdef CONFIG_KCOV_UNIQUE
> +       __sancov_guards(NOLOAD) : {
> +               __start___sancov_guards = .;
> +               *(__sancov_guards);
> +               __stop___sancov_guards = .;
> +       }
> +
> +       .text : {
> +               *(.text .text.[0-9a-zA-Z_]*)
> +               *(.text..L*)
> +       }

Why do we need these here? .text does not look specific to CONFIG_KCOV_UNIQUE.
Is it because of constructors/destructors emitted by the compiler, and
.init.text/.exit.text don't work w/o .text?
A comment here would be useful.

> +
> +       .init.text : {
> +               *(.init.text .init.text.[0-9a-zA-Z_]*)
> +               *(.init.text..L*)
> +       }
> +       .exit.text : {
> +               *(.exit.text .exit.text.[0-9a-zA-Z_]*)
> +               *(.exit.text..L*)
> +       }
> +#endif
> +
>         MOD_SEPARATE_CODETAG_SECTIONS()
>  }
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index b21b12ec88d96..62fbe9b2aa077 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1154,6 +1154,7 @@ static const char *uaccess_safe_builtin[] = {
>         "write_comp_data",
>         "check_kcov_mode",
>         "__sanitizer_cov_trace_pc",
> +       "__sanitizer_cov_trace_pc_guard",
>         "__sanitizer_cov_trace_const_cmp1",
>         "__sanitizer_cov_trace_const_cmp2",
>         "__sanitizer_cov_trace_const_cmp4",
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

