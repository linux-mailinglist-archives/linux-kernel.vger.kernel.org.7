Return-Path: <linux-kernel+bounces-790651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4088B3AB58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68515206A83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49534284B27;
	Thu, 28 Aug 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkXbPSUr"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C232273D8B;
	Thu, 28 Aug 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412085; cv=none; b=cFqt7tMERoldaR0j6VTs7FCOa7Mn22AJ7LkvOEya7zn6IkF94iIfugjg/UhHk1rWmBlVGCrL6BgaW0PDpRAr9ebb/kTK7ErPYKSF6+0g40eVjZot5HCI4RljP9QAvOefOIqW8Q5DFVveeBp+ptPsvwefaYPpwMGqObtD7fNLLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412085; c=relaxed/simple;
	bh=3uTy8R4T8zyBi6B1TRotzflSHvQ6MRS8I0ng0T9wUk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZxGA7ywlpkXWiiarYnbahc95V5SAgP2hVAEep9dBOAaIoB9vKxIYK+k8MpMCWLdCxv1+CC8iIR1OPF5PT8yHLGxOVXojHMrnDmzWK8Da0TA+ZnBKPduhpwAwc4yGyQNcU25skHGs6EHhlBeK4TT+J05yvyDPS2jZFl67RzT7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkXbPSUr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d892175so9205195e9.2;
        Thu, 28 Aug 2025 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412081; x=1757016881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gnvrp+Bx3ZYJFKBzNh94mqis3ow5fvVnk0m91vI1jw=;
        b=lkXbPSUr1qb3+zyan9VoXpxqVl27Ft0O9rFJM882rpnklUnAP09RaeW8tF8BnZ+j2/
         Q5m3sMx8B+QiTN/KzJIaWW1y8LkRZmt91eN62t+6wez0uOj5z1XXuTJVRDPE0Nc96e/r
         +vfFVTumUl+0XpDG7j3ABJDcZfGIjww4WyqRiFJkqw93lNAVAUaQ/upvFOFMCXAiVXKg
         IlafFRv0v9duoggKmF78U37bDh9efUFellu20BeCd/0mnxwdoFIr1AqqZYoiYWQekEtl
         WBbfM+Aiz9nkalERdtaXa/8e7Eo43nW2IPh8Z781YwvnvnaxRsgsTCofOUDWfYg3NueN
         duwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412081; x=1757016881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gnvrp+Bx3ZYJFKBzNh94mqis3ow5fvVnk0m91vI1jw=;
        b=l4+RhzSY1owYQ36Nv/PQWIdkDK3T+EMH7Jg+SvuVVHIjzxxnv1FrRK3+zns54NrU+K
         V0Gzq6f3cptRO599bx2t/oUlxmGkUad4QCImouNrUXt5JOJiMTZNDw/7ywXC8curvaNc
         j5I0RAbM8Ma6DC2HUS+SaocFl+4OZF/LeOHPw7j6bRhLcf7ow00M9ed78e/jexDNE8B0
         3AliMfG2Y8kUQCHnmK2BXn47xMjnjjW8Kor1FUSgQ4KenveYsKE6dxTSYuf9OhCOGTix
         gm5+fP1xfuDTp2pifnqrMvm/CTjKJXqvSRwV/Xc2U8Hke8DfWxCQikEGgsFGRAPDSyl5
         okrg==
X-Forwarded-Encrypted: i=1; AJvYcCUKU6BlYfen+n1K8eoH5hdtGWGBup/+HWpe/vWXSGtvWdeW1e6GjwO+NTVwrfKesoZrI4lx7lv/2hA=@vger.kernel.org, AJvYcCUuunI8G9h5GMRTLTmRhz8hCobujmKfh8ZC18IjspVZAPF/XH+m2TUQzxiO4s9rqD93NSjMFUSsExTvZMgX@vger.kernel.org, AJvYcCUx/yIcBqmT1PfNc1ldB62rfBVmXQG4icwa1A/YTvhM3Ri5cyyIZTBl93jDo7TilWRHelRiT6MeU90U@vger.kernel.org
X-Gm-Message-State: AOJu0YzAS4qgJ0bUodkkqVtAOnt22JrW9uAbe8SAv3bk8+iG7mw0mqTp
	EsW7bL/WM5oga7C4TBv4cT5FJuYlnKiiqIhA+NMnQeqR2wE4vO/IG6Iw2C2USzK82ejfTEpB7BK
	r5hRamuvARuK239/5A2n8OYyq7o0YNok=
X-Gm-Gg: ASbGncsC0HXOmT9p/SoP82QFuyBMF4ejAK+cADaKpONBMH3JctVyalEZ0h1Yyi6IzZ4
	eb0/FT09mDGAGXr8aOmMJvT5LKRdrx6xlBunzTXA2BjAMJO1bt3DgI2naJgXCKyrSHhVeZ20/U9
	UYhZC8dP9k0SE9tTbFeSDmDi6MdDo2jfQoBY1Pdca+h2+BRpcOUYiTeh8aPqUN7n38/zK2lmxqp
	wkGF8pVyUTNH98T2p9OGvdlSW2BoRU=
X-Google-Smtp-Source: AGHT+IGkMoq8h0tkXujVtGDFS8K8ZzpaXHvOixuVaujtWP0Wkn9zIKEQpxZ+6u9akm/7cu9i2UZVR/zTm0+xUXb1N/o=
X-Received: by 2002:a05:600c:4683:b0:458:bfb1:1fc7 with SMTP id
 5b1f17b1804b1-45b5179cc59mr217845785e9.6.1756412081217; Thu, 28 Aug 2025
 13:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820071243.1567338-1-yeoreum.yun@arm.com> <20250820071243.1567338-2-yeoreum.yun@arm.com>
In-Reply-To: <20250820071243.1567338-2-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 28 Aug 2025 22:14:29 +0200
X-Gm-Features: Ac12FXyhL3jNKGMqxsJ0nOjlFtUtP70OOH_yRbqkrkgUfzCeogdUcj5xo329MPY
Message-ID: <CA+fCnZfv6G19P=bWqEUpbA36E9zaHBqDBZyDYV5YnMuAX1zGug@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan/hw-tags: introduce kasan.write_only option
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 9:12=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> Since Armv8.9, FEATURE_MTE_STORE_ONLY feature is introduced to restrict
> raise of tag check fault on store operation only.
> Introcude KASAN write only mode based on this feature.
>
> KASAN write only mode restricts KASAN checks operation for write only and
> omits the checks for fetch/read operations when accessing memory.
> So it might be used not only debugging enviroment but also normal
> enviroment to check memory safty.
>
> This features can be controlled with "kasan.write_only" arguments.
> When "kasan.write_only=3Don", KASAN checks write operation only otherwise
> KASAN checks all operations.
>
> This changes the MTE_STORE_ONLY feature as BOOT_CPU_FEATURE like
> ARM64_MTE_ASYMM so that makes it initialise in kasan_init_hw_tags()
> with other function together.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst  |  3 ++
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  6 +++
>  arch/arm64/kernel/cpufeature.c     |  2 +-
>  arch/arm64/kernel/mte.c            | 18 ++++++++
>  mm/kasan/hw_tags.c                 | 70 +++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h                   |  7 +++
>  7 files changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 0a1418ab72fd..fe1a1e152275 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -143,6 +143,9 @@ disabling KASAN altogether or controlling its feature=
s:
>    Asymmetric mode: a bad access is detected synchronously on reads and
>    asynchronously on writes.
>
> +- ``kasan.write_only=3Doff`` or ``kasan.write_only=3Don`` controls wheth=
er KASAN
> +  checks the write (store) accesses only or all accesses (default: ``off=
``)

Nit: a dot missing at the end of the sentence.

> +
>  - ``kasan.vmalloc=3Doff`` or ``=3Don`` disables or enables tagging of vm=
alloc
>    allocations (default: ``on``).
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 5213248e081b..f1505c4acb38 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -308,6 +308,7 @@ static inline const void *__tag_set(const void *addr,=
 u8 tag)
>  #define arch_enable_tag_checks_sync()          mte_enable_kernel_sync()
>  #define arch_enable_tag_checks_async()         mte_enable_kernel_async()
>  #define arch_enable_tag_checks_asymm()         mte_enable_kernel_asymm()
> +#define arch_enable_tag_checks_write_only()    mte_enable_kernel_store_o=
nly()
>  #define arch_suppress_tag_checks_start()       mte_enable_tco()
>  #define arch_suppress_tag_checks_stop()                mte_disable_tco()
>  #define arch_force_async_tag_fault()           mte_check_tfsr_exit()
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/=
mte-kasan.h
> index 2e98028c1965..0f9b08e8fb8d 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -200,6 +200,7 @@ static inline void mte_set_mem_tag_range(void *addr, =
size_t size, u8 tag,
>  void mte_enable_kernel_sync(void);
>  void mte_enable_kernel_async(void);
>  void mte_enable_kernel_asymm(void);
> +int mte_enable_kernel_store_only(void);
>
>  #else /* CONFIG_ARM64_MTE */
>
> @@ -251,6 +252,11 @@ static inline void mte_enable_kernel_asymm(void)
>  {
>  }
>
> +static inline int mte_enable_kernel_store_only(void)
> +{
> +       return -EINVAL;
> +}
> +
>  #endif /* CONFIG_ARM64_MTE */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
> index 9ad065f15f1d..505bd56e21a2 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2920,7 +2920,7 @@ static const struct arm64_cpu_capabilities arm64_fe=
atures[] =3D {
>         {
>                 .desc =3D "Store Only MTE Tag Check",
>                 .capability =3D ARM64_MTE_STORE_ONLY,
> -               .type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
> +               .type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
>                 .matches =3D has_cpuid_feature,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTESTOREONLY, IMP)
>         },
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e773844889..54a52dc5c1ae 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -157,6 +157,24 @@ void mte_enable_kernel_asymm(void)
>                 mte_enable_kernel_sync();
>         }
>  }
> +
> +int mte_enable_kernel_store_only(void)
> +{
> +       /*
> +        * If the CPU does not support MTE store only,
> +        * the kernel checks all operations.
> +        */
> +       if (!cpus_have_cap(ARM64_MTE_STORE_ONLY))
> +               return -EINVAL;
> +
> +       sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCSO_MASK,
> +                        SYS_FIELD_PREP(SCTLR_EL1, TCSO, 1));
> +       isb();
> +
> +       pr_info_once("MTE: enabled store only mode at EL1\n");
> +
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b54..334e9e84983e 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -41,9 +41,16 @@ enum kasan_arg_vmalloc {
>         KASAN_ARG_VMALLOC_ON,
>  };
>
> +enum kasan_arg_write_only {
> +       KASAN_ARG_WRITE_ONLY_DEFAULT,
> +       KASAN_ARG_WRITE_ONLY_OFF,
> +       KASAN_ARG_WRITE_ONLY_ON,
> +};
> +
>  static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
> +static enum kasan_arg_write_only kasan_arg_write_only __ro_after_init;
>
>  /*
>   * Whether KASAN is enabled at all.
> @@ -67,6 +74,9 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
>  #endif
>  EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
>
> +/* Whether to check write access only. */

Nit: access =3D> accesses

> +static bool kasan_flag_write_only =3D false;
> +
>  #define PAGE_ALLOC_SAMPLE_DEFAULT      1
>  #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT        3
>
> @@ -141,6 +151,23 @@ static int __init early_kasan_flag_vmalloc(char *arg=
)
>  }
>  early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
>
> +/* kasan.write_only=3Doff/on */
> +static int __init early_kasan_flag_write_only(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_write_only =3D KASAN_ARG_WRITE_ONLY_OFF;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_write_only =3D KASAN_ARG_WRITE_ONLY_ON;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.write_only", early_kasan_flag_write_only);
> +
>  static inline const char *kasan_mode_info(void)
>  {
>         if (kasan_mode =3D=3D KASAN_MODE_ASYNC)
> @@ -257,15 +284,28 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> +       switch (kasan_arg_write_only) {
> +       case KASAN_ARG_WRITE_ONLY_DEFAULT:
> +               /* Default is specified by kasan_flag_write_only definiti=
on. */
> +               break;
> +       case KASAN_ARG_WRITE_ONLY_OFF:
> +               kasan_flag_write_only =3D false;
> +               break;
> +       case KASAN_ARG_WRITE_ONLY_ON:
> +               kasan_flag_write_only =3D true;
> +               break;
> +       }
> +
>         kasan_init_tags();
>
>         /* KASAN is now initialized, enable it. */
>         static_branch_enable(&kasan_flag_enabled);
>
> -       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s)\n",
> +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s, write_only=3D%s\n",
>                 kasan_mode_info(),
>                 str_on_off(kasan_vmalloc_enabled()),
> -               str_on_off(kasan_stack_collection_enabled()));
> +               str_on_off(kasan_stack_collection_enabled()),
> +               str_on_off(kasan_arg_write_only));
>  }
>
>  #ifdef CONFIG_KASAN_VMALLOC
> @@ -392,6 +432,26 @@ void kasan_enable_hw_tags(void)
>                 hw_enable_tag_checks_asymm();
>         else
>                 hw_enable_tag_checks_sync();
> +
> +       /*
> +        * CPUs can only be in one of two states:
> +        *   - All CPUs support the write_only feature
> +        *   - No CPUs support the write_only feature
> +        *
> +        * If the first CPU attempts hw_enable_tag_checks_write_only() an=
d
> +        * finds the feature unsupported, kasan_arg_write_only is set to =
OFF
> +        * to avoid further unnecessary calls on other CPUs.
> +        *
> +        * Although this could be tracked with a single variable, both
> +        * kasan_arg_write_only (boot argument) and kasan_flag_write_only
> +        * (hardware state) are kept separate, consistent with other opti=
ons.
> +        */
> +       if (kasan_arg_write_only =3D=3D KASAN_ARG_WRITE_ONLY_ON &&
> +           hw_enable_tag_checks_write_only()) {
> +               kasan_arg_write_only =3D KASAN_ARG_WRITE_ONLY_OFF;
> +               kasan_flag_write_only =3D false;
> +               pr_err_once("write-only mode is not supported and thus no=
t enabled\n");
> +       }
>  }
>
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> @@ -404,4 +464,10 @@ VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(kasan_force_async_fault);
>
> +VISIBLE_IF_KUNIT bool kasan_write_only_enabled(void)
> +{
> +       return kasan_flag_write_only;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(kasan_write_only_enabled);
> +
>  #endif
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 129178be5e64..844eedf2ef9c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -431,6 +431,7 @@ static inline const void *arch_kasan_set_tag(const vo=
id *addr, u8 tag)
>  #define hw_suppress_tag_checks_start()         arch_suppress_tag_checks_=
start()
>  #define hw_suppress_tag_checks_stop()          arch_suppress_tag_checks_=
stop()
>  #define hw_force_async_tag_fault()             arch_force_async_tag_faul=
t()
> +#define hw_enable_tag_checks_write_only()      arch_enable_tag_checks_wr=
ite_only()
>  #define hw_get_random_tag()                    arch_get_random_tag()
>  #define hw_get_mem_tag(addr)                   arch_get_mem_tag(addr)
>  #define hw_set_mem_tag_range(addr, size, tag, init) \
> @@ -451,11 +452,17 @@ void __init kasan_init_tags(void);
>  #if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>
>  void kasan_force_async_fault(void);
> +bool kasan_write_only_enabled(void);
>
>  #else /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>
>  static inline void kasan_force_async_fault(void) { }
>
> +static inline bool kasan_write_only_enabled(void)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

For the KASAN parts:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

