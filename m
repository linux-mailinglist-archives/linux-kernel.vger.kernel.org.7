Return-Path: <linux-kernel+bounces-773337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E3B29E75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995D53B0006
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327B30F81F;
	Mon, 18 Aug 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmab21+o"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91730F815;
	Mon, 18 Aug 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510823; cv=none; b=q0YeA7H0+TRYQnVtz+L8mJUoSnIPUu84ApjkimSg4k/uZ7kZ9iVqW8O/kcOlNF2mh8NIBPu2mm/1hHGC84645+T/jArFi+tibZFnNy5zBWhsT43wnZW0ipbQYClaoh+W27ki7CMzPupM1EY4a4RbT1YCfTraY79eYp40GoC+0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510823; c=relaxed/simple;
	bh=E7gwz9n9CpYdb77k+B0PvKvSgtJUdlSp7T2ofGAPwoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGcNovJf+Xn98AKPv94TUtKlUolzh3aytuTuYOprnPPYJBjb3z9c88rvnBVbjXiAgfbZTKxy+19ohrNCOCc7+t79wAv/ghp0fr4c9iqNh2DY2WPlv907XokogDs8HYR7q3da03hgZQqjNtW0Vk+9q+oxMfMoh4xEd5gDjyRlHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmab21+o; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso3734331f8f.2;
        Mon, 18 Aug 2025 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755510819; x=1756115619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aUrhtA5C8N8LDrztESsi6kkNfyVuogrllyu5DxXOhU=;
        b=lmab21+ogmMhtte2QVjuO/lFMIHK54k6WQ/JWy/Pp0P+hIGm9Xp4vHf0l16EcD/FUD
         Kufu4jKvQHy952AW0Kvl8StovQQ65kxbiuy4NgkrbCqw9poYTDb9m1NBRowROgLp4Tk7
         0lmRkbxuWxhYR9baBsunuZoG+scYTAJVCSubfvBkwLvUhWiy93QU2hwZOS9s61bwB7gT
         xkbQcbqDxTubuTYQIUcGRIBgfdpj643J9yTZzXvUhe0IwAWZUjs67rNH0PK64RWMenGu
         g4iB0ipHU0MqpJcTxforkHTI/pUiVvsEcZEcEGDJmkPE+n/notFCRpCcIFKVbN9csR7h
         wwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510819; x=1756115619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aUrhtA5C8N8LDrztESsi6kkNfyVuogrllyu5DxXOhU=;
        b=XK/tkrfBOd2NCxxmnwjqdgL81gHxsLahrdWMkZbnBFV4rquJR0B4IbEAHBgr047txy
         YV4Q9T6as3BEGsMY6C2DbmXQSVvU0wThbkH+8+PE7GQ29wAPai3ifzHs64weft3EOm/e
         UNuy8XuJ+m0APxoykh3nZKUzklO9NWtuYYgs7JnQe6ZYhVrJIHOZlRf52NJrXtr6GAec
         HqgdPOVQzMq8EbPvx4tKgjGTGR0QXr0UAIF4mSssTG+EYjRFZugGNlN9v9W/YSlf2/md
         SC3KMlEmvfQhay51OhdOIp4K7WWcuSCtoE8+4wWsdq8WJCN+KVSR4E8Zk4FPl0+gm+HR
         rOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa3WL8XNhXF+KJNrpsMsNFFSDy4H8MmIe2sYBYd0l8f+IqLTvNbS9UpzJUUMh0KDlqw5RJxwYHqBw=@vger.kernel.org, AJvYcCW+FAoTDBF2PAOB08wBdjllKtY68BXwN+dLHRx8AbSygFjiB5Nj/SSyfQjL9BJmmj7GqHNsM5BTFiMvR47G@vger.kernel.org, AJvYcCWgUWwoASIPyFNmZtISLikmv/kehE9g3zFItb3Qp1J0fKtqg//85d/U01oTqRB0RHRzAwmEWT6Ty8iv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xEVInq8bZUWEYmwODQ9r6xKFT1ArjvgxZ37YDtly4scSf7h2
	8209pNluHl79AnuxCm3FSLmvUh3r3qaBrFphcJQd4/nvUz1/f5LdSY/LZyOseVZC4h0j0ltE1B3
	6w7t8ZzrRzbSiEXGRscK61jOy2a4lUG8=
X-Gm-Gg: ASbGncvQbImIX7iJoYR0AymshY1Dk6Kfa58VbrDzwGH5AimaEUu4Dr5h6WHpTCi0oF4
	Mkh5bHf/sPfXzUG/CuJ7pxLk66RZOXXGjW/tTSScjQvAqS+DGTXqaJfrEuNBMpIICJRgPWnDBR/
	7hxa3WW1GQ7I8TfT7oIzbFfNVQxoOYqsT43BvaKPPgHkAc0+BSCQRg82jj2uW9v6WqHB8KNEJWk
	mHsC3qvaA==
X-Google-Smtp-Source: AGHT+IE5sWPnO2jWHmGFO9/uqaRATarRkbmdpoRmK2O7FZqlephlWzYr5r52Bl9rK+p5u8FdUbRUw0a6xAxNdaOOYWo=
X-Received: by 2002:a05:6000:2382:b0:3b7:664a:8416 with SMTP id
 ffacd0b85a97d-3bb672ef363mr7732028f8f.23.1755510819196; Mon, 18 Aug 2025
 02:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818075051.996764-1-yeoreum.yun@arm.com> <20250818075051.996764-2-yeoreum.yun@arm.com>
In-Reply-To: <20250818075051.996764-2-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 18 Aug 2025 11:53:26 +0200
X-Gm-Features: Ac12FXzRBfgg3LizE0EW60Q0iO4G5vgy9DjWhPtH5IcEjjDvGoLaCnutYA-AZ-c
Message-ID: <CA+fCnZcce88Sj=oAe-cwydu7Ums=wk2Ps=JZkz0RwO-M_DjfVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kasan/hw-tags: introduce kasan.write_only option
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

On Mon, Aug 18, 2025 at 9:51=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
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
>  arch/arm64/include/asm/mte-kasan.h |  6 ++++
>  arch/arm64/kernel/cpufeature.c     |  2 +-
>  arch/arm64/kernel/mte.c            | 18 ++++++++++
>  mm/kasan/hw_tags.c                 | 54 ++++++++++++++++++++++++++++--
>  mm/kasan/kasan.h                   |  7 ++++
>  7 files changed, 88 insertions(+), 3 deletions(-)
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
> index e5e773844889..cd5452eb7486 100644
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
> +       pr_info_once("MTE: enabled stonly mode at EL1\n");
> +
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b54..df67b48739b4 100644
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
> @@ -67,6 +74,8 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
>  #endif
>  EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
>
> +static bool kasan_flag_write_only;
> +
>  #define PAGE_ALLOC_SAMPLE_DEFAULT      1
>  #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT        3
>
> @@ -141,6 +150,23 @@ static int __init early_kasan_flag_vmalloc(char *arg=
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
> @@ -257,15 +283,26 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> +       switch (kasan_arg_write_only) {
> +       case KASAN_ARG_WRITE_ONLY_DEFAULT:

Let's keep this part similar to the other parameters for consistency:

/* Default is specified by kasan_flag_write_only definition. */
break;

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
> @@ -392,6 +429,13 @@ void kasan_enable_hw_tags(void)
>                 hw_enable_tag_checks_asymm();
>         else
>                 hw_enable_tag_checks_sync();
> +
> +       if (kasan_arg_write_only =3D=3D KASAN_ARG_WRITE_ONLY_ON &&

We already set kasan_flag_write_only by this point, right? Let's check
that one then.

> +           hw_enable_tag_checks_write_only()) {
> +               kasan_arg_write_only =3D=3D KASAN_ARG_WRITE_ONLY_OFF;

Typo in =3D=3D in the line above. But also I think we can just drop the
line: kasan_arg_write_only is KASAN_ARG_WRITE_ONLY_ON after all, it's
just not supported and thus kasan_flag_write_only is set to false to
reflect that.

> +               kasan_flag_write_only =3D false;
> +               pr_warn_once("System doesn't support write-only option. D=
isable it\n");

Let's do pr_err like the rest of KASAN code. And:

pr_err_once("write-only mode is not supported and thus not enabled\n");



> +       }
>  }
>
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> @@ -404,4 +448,10 @@ VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
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
> index 129178be5e64..c1490136c96b 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -428,6 +428,7 @@ static inline const void *arch_kasan_set_tag(const vo=
id *addr, u8 tag)
>  #define hw_enable_tag_checks_sync()            arch_enable_tag_checks_sy=
nc()
>  #define hw_enable_tag_checks_async()           arch_enable_tag_checks_as=
ync()
>  #define hw_enable_tag_checks_asymm()           arch_enable_tag_checks_as=
ymm()
> +#define hw_enable_tag_checks_write_only()      arch_enable_tag_checks_wr=
ite_only()
>  #define hw_suppress_tag_checks_start()         arch_suppress_tag_checks_=
start()
>  #define hw_suppress_tag_checks_stop()          arch_suppress_tag_checks_=
stop()
>  #define hw_force_async_tag_fault()             arch_force_async_tag_faul=
t()
> @@ -437,11 +438,17 @@ static inline const void *arch_kasan_set_tag(const =
void *addr, u8 tag)
>                         arch_set_mem_tag_range((addr), (size), (tag), (in=
it))
>
>  void kasan_enable_hw_tags(void);
> +bool kasan_write_only_enabled(void);

This should go next to kasan_force_async_fault().

>
>  #else /* CONFIG_KASAN_HW_TAGS */
>
>  static inline void kasan_enable_hw_tags(void) { }
>
> +static inline bool kasan_write_only_enabled(void)
> +{
> +       return false;
> +}

And this too.


> +
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

