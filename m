Return-Path: <linux-kernel+bounces-846003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7113EBC6B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E104EBE8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405CB2C0F72;
	Wed,  8 Oct 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7McYbCc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AD4A06
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959391; cv=none; b=eQvltZjeIs7qUCvxWMOyvekzw+2U49IEZbVFFuFTLpfJ+HFoIelYoaHi43EpBUCh5zNnhFUKh5+2FWPat3P/D4Szf6UQpo3tzMgQA/ZAIyzcny54T3/0QYumtaYSOg7rBQyBcqForaJI3p4R2Wul34XrhKYbnncklYRcTZ/r+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959391; c=relaxed/simple;
	bh=bDmSgMq7eSaNrZswPzikgCfxfHSy/sW3Ghv1O+8Sbf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uz/uBDOY2d/vDuUUfrPLZqa3XBqlDaXvvkKabp4DgKRZ/k3wn4AHn5fPlMeycNF/Y4lJpYmrMaOIIn85yyFpiJ3oQmuPjCeDZYGbHI9h2lr5C6bijfoFpKNA3Ple0RpIkWwUVTbb4SNmhWbEGtMpajmmi+60lHKbXMc2SdRWsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7McYbCc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fa528f127fso291772f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759959387; x=1760564187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEmyrKTdVo56+b/Tyh73u1BP5jkBeN0eSir3I6ZA6yY=;
        b=X7McYbCcr77QDfdaUTaM4vYd1E6zQxf4pkamFjaI2V03Wkf5B38gf8WeEV08SFDIP5
         bbM3uFi7qn4wWRlq2CT/LhgG69AITH5D6bFIW4NV3wGWJKq4eH2DOIYqx42cSYXBlTcf
         foBym2EZCjhZVjNjrKdGFpK6u6oqlmrM4U/RXvdTBv8SWhwT4UeZw3C5/x2oU9JyHPck
         7Tv6AXV3PGLIWbTvOnaammnuEHnt1Y1+gxFJyXBpRnP0+yNKGG1jVoaqCkqTFya88xVc
         4dDcULzfLhDLr5lEu+AjjV3Rd3EPLRQjt9mKJV08fyC3hTXOxNS9rW2/kvrdna5y7oP1
         Tnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959387; x=1760564187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEmyrKTdVo56+b/Tyh73u1BP5jkBeN0eSir3I6ZA6yY=;
        b=WbfYjXEw6A5fmAg9z3ATN2lBq4O4rxCuyqC4UK40tEYETvaKWk3l9sxjtZuT2Uu4fM
         Y4o70M2ao1/duwY2iM1kIO/k943RkGBwxg/3yhNqtOk2mDiN9xfCnFa1L0ExJzDXKw9r
         bDrCFgsn68Ap7bnarjyLN5OgJOyChTPtvaQmcMV082oLNuivbYhHfTFYsRPx9tDvMu4j
         ar67g9C3B7W+WbjKcbSd952Liqkzt4eH7I9Qo7lFsQA0cbNcLJ+Ne50Ica9h/dbxEXmY
         rQzNm8Az95olwMU4LGB/vEN3LBsb9VCuOqt1za8xNjfH2SxB4GRgqh3LaHp4A+hdQg3u
         IESA==
X-Forwarded-Encrypted: i=1; AJvYcCU7SyajYio3WJYDsoG8kFk7OQ7b1XaOyCjFhqmPe0ItyL0sz+39xonCLjC0zVrd/nRQP0BysZp/y4AAZ8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvOEabqVJgftESkoRK3Kngcpgk3p7y60R7CBCgoVYKPoVlOUO
	K/lk1lKkQa7CVC+0pKIRGIFnnJp8GpZfU68RuFgBLdDnIrXfX4CKe7p5igBzqut8g/X6GnJl/Tk
	sFfhU2/iWcaqJ1yjybqQ4x/r4zkEfSh0=
X-Gm-Gg: ASbGncsupmEGBJgtbeDnKQT7v+BB8U5ceItakLjloUwMzNhkVOKSy6D9YwbWZUYxLHI
	kbp47VDlAqC20u9lSzdNi+JHAQPyGfJottW+VOFKgtIFO177QLqwZHxpMZh0H0NzN0+gvSq+jQM
	F3ZeCMkYN/Z3wq1g0APMlB4Fj3CDFeO/s9eYGoXKOTpchDKVTmFMxz+9mJSBXK07faqdd9lJSuR
	r+0NKEofDnHZnM9Lm+GuZM8Uxh3AcU3
X-Google-Smtp-Source: AGHT+IHXDMXzRuIrjtVCYc8sacB+jXqu+5SuRp51RmL35yz4GrVsLEh/lQW5/Ztr3Zx0xXXl3nk8dBBNTp5RWCaCgp4=
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id
 ffacd0b85a97d-42666aa6354mr3738354f8f.7.1759959387489; Wed, 08 Oct 2025
 14:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008210425.125021-3-ysk@kzalloc.com>
In-Reply-To: <20251008210425.125021-3-ysk@kzalloc.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 8 Oct 2025 23:36:16 +0200
X-Gm-Features: AS18NWDr7cACmDmTAFMFA6336Xs4RqGaLFCrqQxRq3mWW-FZjr-4oeDaD1dmdEM
Message-ID: <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
Subject: Re: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when
 KASAN_GENERIC is active
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:13=E2=80=AFPM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> When a kernel built with CONFIG_KASAN_GENERIC=3Dy is booted on MTE-capabl=
e
> hardware, a kernel panic occurs early in the boot process. The crash
> happens when the CPU feature detection logic attempts to enable the Memor=
y
> Tagging Extension (MTE) via cpu_enable_mte().
>
> Because the kernel is instrumented by the software-only Generic KASAN,
> the code within cpu_enable_mte() itself is instrumented. This leads to
> a fatal memory access fault within KASAN's shadow memory region when
> the MTE initialization is attempted. Currently, the only workaround is
> to boot with the "arm64.nomte" kernel parameter.
>
> This bug was discovered during work on supporting the Debian debug kernel
> on the Arm v9.2 RADXA Orion O6 board:
>
>  https://salsa.debian.org/kernel-team/linux/-/merge_requests/1670
>
> Related kernel configs:
>
>  CONFIG_ARM64_AS_HAS_MTE=3Dy
>  CONFIG_ARM64_MTE=3Dy
>
>  CONFIG_KASAN_SHADOW_OFFSET=3D0xdfff800000000000
>  CONFIG_HAVE_ARCH_KASAN=3Dy
>  CONFIG_HAVE_ARCH_KASAN_SW_TAGS=3Dy
>  CONFIG_HAVE_ARCH_KASAN_HW_TAGS=3Dy
>  CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
>  CONFIG_CC_HAS_KASAN_GENERIC=3Dy
>  CONFIG_CC_HAS_KASAN_SW_TAGS=3Dy
>
>  CONFIG_KASAN=3Dy
>  CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
>  CONFIG_KASAN_GENERIC=3Dy
>
> The panic log clearly shows the conflict:
>
> [    0.000000] kasan: KernelAddressSanitizer initialized (generic)
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] percpu: Embedded 486 pages/cpu s1950104 r8192 d32360 u1990=
656
> [    0.000000] pcpu-alloc: s1950104 r8192 d32360 u1990656 alloc=3D486*409=
6
> [    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] =
06 [0] 07
> [    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: detected: Address authentication (architecte=
d QARMA3 algorithm)
> [    0.000000] CPU features: detected: GICv3 CPU interface
> [    0.000000] CPU features: detected: HCRX_EL2 register
> [    0.000000] CPU features: detected: Virtualization Host Extensions
> [    0.000000] CPU features: detected: Memory Tagging Extension
> [    0.000000] CPU features: detected: Asymmetric MTE Tag Check Fault
> [    0.000000] CPU features: detected: Spectre-v4
> [    0.000000] CPU features: detected: Spectre-BHB
> [    0.000000] CPU features: detected: SSBS not fully self-synchronizing
> [    0.000000] Unable to handle kernel paging request at virtual address =
dfff800000000005
> [    0.000000] KASAN: null-ptr-deref in range [0x0000000000000028-0x00000=
0000000002f]
> [    0.000000] Mem abort info:
> [    0.000000]   ESR =3D 0x0000000096000005
> [    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    0.000000]   SET =3D 0, FnV =3D 0
> [    0.000000]   EA =3D 0, S1PTW =3D 0
> [    0.000000]   FSC =3D 0x05: level 1 translation fault
> [    0.000000] Data abort info:
> [    0.000000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> [    0.000000]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [    0.000000]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [    0.000000] [dfff800000000005] address between user and kernel address=
 ranges
> [    0.000000] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17+unrele=
ased-debug-arm64 #1 PREEMPTLAZY  Debian 6.17-1~exp1
> [    0.000000] pstate: 800000c9 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    0.000000] pc : cpu_enable_mte+0x104/0x440
> [    0.000000] lr : cpu_enable_mte+0xf4/0x440
> [    0.000000] sp : ffff800084f67d80
> [    0.000000] x29: ffff800084f67d80 x28: 0000000000000043 x27: 000000000=
0000001
> [    0.000000] x26: 0000000000000001 x25: ffff800084204008 x24: ffff80008=
4203da8
> [    0.000000] x23: ffff800084204000 x22: ffff800084203000 x21: ffff80008=
65a8000
> [    0.000000] x20: fffffffffffffffe x19: fffffdffddaa6a00 x18: 000000000=
0000011
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: ffff70001=
0a04829
> [    0.000000] x11: 1ffff00010a04828 x10: ffff700010a04828 x9 : dfff80000=
0000000
> [    0.000000] x8 : ffff800085024143 x7 : 0000000000000001 x6 : ffff70001=
0a04828
> [    0.000000] x5 : ffff800084f9d200 x4 : 0000000000000000 x3 : ffff80008=
00794ac
> [    0.000000] x2 : 0000000000000005 x1 : dfff800000000000 x0 : 000000000=
000002e
> [    0.000000] Call trace:
> [    0.000000]  cpu_enable_mte+0x104/0x440 (P)
> [    0.000000]  enable_cpu_capabilities+0x188/0x208
> [    0.000000]  setup_boot_cpu_features+0x44/0x60
> [    0.000000]  smp_prepare_boot_cpu+0x9c/0xb8
> [    0.000000]  start_kernel+0xc8/0x528
> [    0.000000]  __primary_switched+0x8c/0xa0
> [    0.000000] Code: 9100c280 d2d00001 f2fbffe1 d343fc02 (38e16841)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task! ]---
>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
> index 5ed401ff79e3..a0a9fa1b376d 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2340,6 +2340,24 @@ static void cpu_enable_mte(struct arm64_cpu_capabi=
lities const *cap)
>
>         kasan_init_hw_tags_cpu();
>  }
> +
> +static bool has_usable_mte(const struct arm64_cpu_capabilities *entry, i=
nt scope)
> +{
> +       if (!has_cpuid_feature(entry, scope))
> +               return false;
> +
> +       /*
> +        * MTE and Generic KASAN are mutually exclusive. Generic KASAN is=
 a
> +        * software-only mode that is incompatible with the MTE hardware.
> +        * Do not enable MTE if Generic KASAN is active.

I do not understand this. Why is Generic KASAN incompatible with MTE?
Running Generic KASAN in the kernel while having MTE enabled (and e.g.
used in userspace) seems like a valid combination.

The crash log above looks like a NULL-ptr-deref. On which line of code
does it happen?


> +        */
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC) && kasan_enabled()) {
> +               pr_warn_once("MTE capability disabled due to Generic KASA=
N conflict\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
>  #endif /* CONFIG_ARM64_MTE */
>
>  static void user_feature_fixup(void)
> @@ -2850,7 +2868,7 @@ static const struct arm64_cpu_capabilities arm64_fe=
atures[] =3D {
>                 .desc =3D "Memory Tagging Extension",
>                 .capability =3D ARM64_MTE,
>                 .type =3D ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> -               .matches =3D has_cpuid_feature,
> +               .matches =3D has_usable_mte,
>                 .cpu_enable =3D cpu_enable_mte,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE2)
>         },
> @@ -2858,21 +2876,21 @@ static const struct arm64_cpu_capabilities arm64_=
features[] =3D {
>                 .desc =3D "Asymmetric MTE Tag Check Fault",
>                 .capability =3D ARM64_MTE_ASYMM,
>                 .type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
> -               .matches =3D has_cpuid_feature,
> +               .matches =3D has_usable_mte,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE3)
>         },
>         {
>                 .desc =3D "FAR on MTE Tag Check Fault",
>                 .capability =3D ARM64_MTE_FAR,
>                 .type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
> -               .matches =3D has_cpuid_feature,
> +               .matches =3D has_usable_mte,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTEFAR, IMP)
>         },
>         {
>                 .desc =3D "Store Only MTE Tag Check",
>                 .capability =3D ARM64_MTE_STORE_ONLY,
>                 .type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
> -               .matches =3D has_cpuid_feature,
> +               .matches =3D has_usable_mte,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTESTOREONLY, IMP)
>         },
>  #endif /* CONFIG_ARM64_MTE */
> --
> 2.51.0
>

