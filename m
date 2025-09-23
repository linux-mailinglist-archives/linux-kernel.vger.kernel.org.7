Return-Path: <linux-kernel+bounces-829321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0303B96CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189723AD3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77A2E7F39;
	Tue, 23 Sep 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en+ApHXv"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B930F55D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644494; cv=none; b=MS3VkxcdEDyPRXCPX/DkUUEVIYj3cE/B2VVfeIM/X/Qxz7MqtzLYJ1+3l8fxH272lswpdVoTuW7SLn2DjzpQ+wEUzaFZJyZRorydfjYJCWtVMhrgcYp4KndV3XBXAU1nttUc/IDu1UMovktZplGlrn7sjkpW/yljBmgjdiOcz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644494; c=relaxed/simple;
	bh=2yr8BZH2ZCizdkGAyIQ2PU8QVbZRyONMsaqqxtVZnb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eit0NYl1ziL36HGqeiiax/vPhyMiUcZ9UZplwWhW8CB1zHyrBkZ+ATbn+Z7UqAJOFi1hc9cQlLm9jFf21MV1dVsIdm7/wmkZLdsy9SKxYATSjyQ0spxX2tmG6WGvh35SkNe/DHVEcNHzKYf52iU2AYLraev7OFur06A6JgZn7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en+ApHXv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso2682987f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758644490; x=1759249290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX/x2YQu8IshGIhtT2j6+6VZWl/6xDk05tyNGFgYJMM=;
        b=en+ApHXvKFAEB2tmQ1n/8R7a2E335UoPFKu4DfHqF+QlB2M5DQVEL5czgvO42XAp/F
         /zv3kpIULY0WiaB5x4L2InGG8hUpnQ3tjaZIpbcTClTDyQ6LjTXa3SwKUAVQk8N+fH2X
         qj2gm+kvWZvWJBdsCD/m4d2V8phwiUuJZ8ce62403aYDSw6BKJzxP0moRzhu6cJW/i93
         JUTXrzgVCCcz5cZrMn/C8eDg2uzc5HVqvHOV6xow5GbznfGLSoL9puPABTXnqIlDTU0P
         X8W4LCjL7Qh6a1hvVI2UHoeMbECZSCEw9cHN9w3Bt+/5Wevg7dNe7N6xs6bJ3kX6ulqx
         Q+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644490; x=1759249290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX/x2YQu8IshGIhtT2j6+6VZWl/6xDk05tyNGFgYJMM=;
        b=TWW19iu/6+OaaAKViYmGNHBJ8A4qUSkV1sAbJO09hrizGuiv1DZBtD/74O8aBxGcMJ
         GPxQnndR6fOom3qkKWh3v3CilBS5wndaMqQKN/JPNnHg2RlqR0Oi/UPKDebi1lKghNLq
         9L7ZSCFOhvTju6+tTtnvyIvJHUv7sNjnf+gozPxGQLVxCfMKQCcVzEcwIbEe0qK8FKKV
         eGp6XOj8GfVIPTO9cb4wqGnRpc/ViCSbcnY/aeU0e8XWiI+C9Tlo3inb43IO7qqe+VXG
         hRgVEb3cXoWV8q7uLsjlJKSjoMdvstqoRDx2xBqEffh3g6qP3VCpe8AXxvroyojQ6U7C
         wQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVo1mFiBQagiuS5lDsKsw9eEr+wp/H6LBvB5fZKBIs7grK17x7qk35shrTmMvc3ccSoiVDWOdHcl1nEFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRa5kjcUwN4cNRmalH7mUamy/y6hp2FS01J1Lt8QUMEpcxDwl
	54x+GY0IQaCfg4Yf026DoVGku8XZxMdJJGpbJzYE2JaFzmhV6mv3mjsZiTIE0p8VDldS5/os8nD
	e/tqPTo5jDqaGGq81hp4SDO0EIAuNftk=
X-Gm-Gg: ASbGnctrbOSRSGSk0Q9eCWNjz42u4i6vPRQuV8RaLH912i4wGvJeOpYY98ekoq+UAeh
	HW+qoACsI5fSXDTKvhtf1LukTpk2F19eDYYmhz7gNd9qx4HepEYV2ujWigVyy8yHQT2Ow+v8755
	jwuInLU6mZzIGB/gPdIQhW6hoW+YCASELaPAcW2S/O68PJAZq/wzO6R6HumrFD5/FplSj1pEeOA
	OndNcNmEA==
X-Google-Smtp-Source: AGHT+IFLsDfbMe1B7TKn5qcjOcHKMSiE+AnSedjc8CXlaTSbb/VI4iDnnpzChliLj+DF3rJyI7LW0Ktytb6lz8NGyJA=
X-Received: by 2002:a05:6000:2012:b0:3e5:190b:b04e with SMTP id
 ffacd0b85a97d-405c9a01b60mr2346265f8f.37.1758644490092; Tue, 23 Sep 2025
 09:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916222755.466009-1-yeoreum.yun@arm.com> <20250916222755.466009-2-yeoreum.yun@arm.com>
In-Reply-To: <20250916222755.466009-2-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 23 Sep 2025 18:21:19 +0200
X-Gm-Features: AS18NWDlzRK91ohBlIigdupIpzh6rhNy0WQJ68f3CbaJYvAQUJclJ8mywpVCdno
Message-ID: <CA+fCnZdRySvANWkT1oK38Ke1Uf9yUm1qyb5-vatJhZR+-eay5g@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kasan/hw-tags: introduce kasan.write_only option
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

On Wed, Sep 17, 2025 at 12:28=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> =
wrote:
>
> Since Armv8.9, FEATURE_MTE_STORE_ONLY feature is introduced to restrict
> raise of tag check fault on store operation only.
> Introduce KASAN write only mode based on this feature.
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
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst  |  3 ++
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  6 ++++
>  arch/arm64/kernel/cpufeature.c     |  2 +-
>  arch/arm64/kernel/mte.c            | 18 ++++++++++++
>  mm/kasan/hw_tags.c                 | 45 ++++++++++++++++++++++++++++--
>  mm/kasan/kasan.h                   |  7 +++++
>  7 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 0a1418ab72fd..a034700da7c4 100644
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
``).
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
> index ef269a5a37e1..1f6e8c87aae7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2945,7 +2945,7 @@ static const struct arm64_cpu_capabilities arm64_fe=
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
> index 9a6927394b54..646f090e57e3 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -67,6 +67,9 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
>  #endif
>  EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
>
> +/* Whether to check write accesses only. */
> +static bool kasan_flag_write_only =3D false;
> +
>  #define PAGE_ALLOC_SAMPLE_DEFAULT      1
>  #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT        3
>
> @@ -141,6 +144,23 @@ static int __init early_kasan_flag_vmalloc(char *arg=
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
> +               kasan_flag_write_only =3D false;
> +       else if (!strcmp(arg, "on"))
> +               kasan_flag_write_only =3D true;
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
> @@ -262,10 +282,11 @@ void __init kasan_init_hw_tags(void)
>         /* KASAN is now initialized, enable it. */
>         static_branch_enable(&kasan_flag_enabled);
>
> -       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s)\n",
> +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s, write_only=3D%s)\n",
>                 kasan_mode_info(),
>                 str_on_off(kasan_vmalloc_enabled()),
> -               str_on_off(kasan_stack_collection_enabled()));
> +               str_on_off(kasan_stack_collection_enabled()),
> +               str_on_off(kasan_flag_write_only));
>  }
>
>  #ifdef CONFIG_KASAN_VMALLOC
> @@ -392,6 +413,20 @@ void kasan_enable_hw_tags(void)
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
> +        * finds the feature unsupported, kasan_flag_write_only is set to=
 OFF
> +        * to avoid further unnecessary calls on other CPUs.
> +        */
> +       if (kasan_flag_write_only && hw_enable_tag_checks_write_only()) {
> +               kasan_flag_write_only =3D false;
> +               pr_err_once("write-only mode is not supported and thus no=
t enabled\n");
> +       }
>  }
>
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> @@ -404,4 +439,10 @@ VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

