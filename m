Return-Path: <linux-kernel+bounces-773336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A42B29E71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9414E247F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4230FF09;
	Mon, 18 Aug 2025 09:52:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E930F7EF;
	Mon, 18 Aug 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510773; cv=none; b=B7XIBtpqJI0lPRBSuND5bR14p7UCNWhBCI5Z0Yk4N4CNEDJI9O3A+1sXbrjMxW2AY0pLsoUt8hJcVjLtqrihp1hKLR9htDOPmWskiudqGygUM+W9xY1zDlsw8DPXDkIBPJQsHbh5YBYh9B2ck7azCUqvl7ywzknff6TW+3+vdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510773; c=relaxed/simple;
	bh=KU6O2Nw3omo+DHJINNo9JbkcNiVo7YkaJ0n2SG1v3dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4iMWD9x9EVx70jwsCIudawDCOvtjSHpqTWiKcOgtwkdN3N6lli7BVXBPnNw89vikHzz0eISFH8qs87spKFSNGD0u6YGnnz6WJjY8S33Mu6UdNOMGf2xT6UPqmsNhBBbELDhzNFuZkZcjsOb9kPJgV7dCf+bYyj+cuXLeftJ8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C0A1596;
	Mon, 18 Aug 2025 02:52:41 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09BE63F63F;
	Mon, 18 Aug 2025 02:52:45 -0700 (PDT)
Message-ID: <2736fe09-ef37-408c-ba53-a8e492dcc3e8@arm.com>
Date: Mon, 18 Aug 2025 10:52:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] kasan/hw-tags: introduce kasan.write_only option
To: Yeoreum Yun <yeoreum.yun@arm.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com,
 jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org,
 kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org,
 oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org,
 hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
 yang@os.amperecomputing.com
Cc: kasan-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20250818075051.996764-1-yeoreum.yun@arm.com>
 <20250818075051.996764-2-yeoreum.yun@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250818075051.996764-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yeoreum,

On 8/18/25 08:50, Yeoreum Yun wrote:
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
> When "kasan.write_only=on", KASAN checks write operation only otherwise
> KASAN checks all operations.
> 
> This changes the MTE_STORE_ONLY feature as BOOT_CPU_FEATURE like
> ARM64_MTE_ASYMM so that makes it initialise in kasan_init_hw_tags()
> with other function together.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   Documentation/dev-tools/kasan.rst  |  3 ++
>   arch/arm64/include/asm/memory.h    |  1 +
>   arch/arm64/include/asm/mte-kasan.h |  6 ++++
>   arch/arm64/kernel/cpufeature.c     |  2 +-
>   arch/arm64/kernel/mte.c            | 18 ++++++++++
>   mm/kasan/hw_tags.c                 | 54 ++++++++++++++++++++++++++++--
>   mm/kasan/kasan.h                   |  7 ++++
>   7 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 0a1418ab72fd..fe1a1e152275 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -143,6 +143,9 @@ disabling KASAN altogether or controlling its features:
>     Asymmetric mode: a bad access is detected synchronously on reads and
>     asynchronously on writes.
>   
> +- ``kasan.write_only=off`` or ``kasan.write_only=on`` controls whether KASAN
> +  checks the write (store) accesses only or all accesses (default: ``off``)
> +
>   - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
>     allocations (default: ``on``).
>   
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 5213248e081b..f1505c4acb38 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -308,6 +308,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>   #define arch_enable_tag_checks_sync()		mte_enable_kernel_sync()
>   #define arch_enable_tag_checks_async()		mte_enable_kernel_async()
>   #define arch_enable_tag_checks_asymm()		mte_enable_kernel_asymm()
> +#define arch_enable_tag_checks_write_only()	mte_enable_kernel_store_only()
>   #define arch_suppress_tag_checks_start()	mte_enable_tco()
>   #define arch_suppress_tag_checks_stop()		mte_disable_tco()
>   #define arch_force_async_tag_fault()		mte_check_tfsr_exit()
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 2e98028c1965..0f9b08e8fb8d 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -200,6 +200,7 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
>   void mte_enable_kernel_sync(void);
>   void mte_enable_kernel_async(void);
>   void mte_enable_kernel_asymm(void);
> +int mte_enable_kernel_store_only(void);
>   
>   #else /* CONFIG_ARM64_MTE */
>   
> @@ -251,6 +252,11 @@ static inline void mte_enable_kernel_asymm(void)
>   {
>   }
>   
> +static inline int mte_enable_kernel_store_only(void)
> +{
> +	return -EINVAL;
> +}
> +
>   #endif /* CONFIG_ARM64_MTE */
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9ad065f15f1d..505bd56e21a2 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2920,7 +2920,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   	{
>   		.desc = "Store Only MTE Tag Check",
>   		.capability = ARM64_MTE_STORE_ONLY,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTESTOREONLY, IMP)
>   	},
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e773844889..cd5452eb7486 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -157,6 +157,24 @@ void mte_enable_kernel_asymm(void)
>   		mte_enable_kernel_sync();
>   	}
>   }
> +
> +int mte_enable_kernel_store_only(void)
> +{
> +	/*
> +	 * If the CPU does not support MTE store only,
> +	 * the kernel checks all operations.
> +	 */
> +	if (!cpus_have_cap(ARM64_MTE_STORE_ONLY))
> +		return -EINVAL;
Would it be better to make this function return void and add a static 
key in the manner of mte_async_or_asymm_mode, perhaps 
mte_store_only_mode? This information could then be used to help 
determine whether it is required to enable and disable tco in 
__get_kernel_nofault() and load_unaligned_zeropad(). The function 
signature would also match that of the other hw_enable_tag_...().

> +
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCSO_MASK,
> +			 SYS_FIELD_PREP(SCTLR_EL1, TCSO, 1));
> +	isb();
> +
> +	pr_info_once("MTE: enabled stonly mode at EL1\n");
nit: stonly can be expanded to store only
> +
> +	return 0;
> +}
>   #endif
>   
>   #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b54..df67b48739b4 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -41,9 +41,16 @@ enum kasan_arg_vmalloc {
>   	KASAN_ARG_VMALLOC_ON,
>   };
>   
> +enum kasan_arg_write_only {
> +	KASAN_ARG_WRITE_ONLY_DEFAULT,
> +	KASAN_ARG_WRITE_ONLY_OFF,
> +	KASAN_ARG_WRITE_ONLY_ON,
> +};
> +
>   static enum kasan_arg kasan_arg __ro_after_init;
>   static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>   static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
> +static enum kasan_arg_write_only kasan_arg_write_only __ro_after_init;
>   
>   /*
>    * Whether KASAN is enabled at all.
> @@ -67,6 +74,8 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
>   #endif
>   EXPORT_SYMBOL_GPL(kasan_flag_vmalloc);
>   
> +static bool kasan_flag_write_only;
> +
>   #define PAGE_ALLOC_SAMPLE_DEFAULT	1
>   #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT	3
>   
> @@ -141,6 +150,23 @@ static int __init early_kasan_flag_vmalloc(char *arg)
>   }
>   early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
>   
> +/* kasan.write_only=off/on */
> +static int __init early_kasan_flag_write_only(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "off"))
> +		kasan_arg_write_only = KASAN_ARG_WRITE_ONLY_OFF;
> +	else if (!strcmp(arg, "on"))
> +		kasan_arg_write_only = KASAN_ARG_WRITE_ONLY_ON;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.write_only", early_kasan_flag_write_only);
> +
>   static inline const char *kasan_mode_info(void)
>   {
>   	if (kasan_mode == KASAN_MODE_ASYNC)
> @@ -257,15 +283,26 @@ void __init kasan_init_hw_tags(void)
>   		break;
>   	}
>   
> +	switch (kasan_arg_write_only) {
> +	case KASAN_ARG_WRITE_ONLY_DEFAULT:
> +	case KASAN_ARG_WRITE_ONLY_OFF:
> +		kasan_flag_write_only = false;
> +		break;
> +	case KASAN_ARG_WRITE_ONLY_ON:
> +		kasan_flag_write_only = true;
> +		break;
> +	}
> +
>   	kasan_init_tags();
>   
>   	/* KASAN is now initialized, enable it. */
>   	static_branch_enable(&kasan_flag_enabled);
>   
> -	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
> +	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s, write_only=%s\n",
>   		kasan_mode_info(),
>   		str_on_off(kasan_vmalloc_enabled()),
> -		str_on_off(kasan_stack_collection_enabled()));
> +		str_on_off(kasan_stack_collection_enabled()),
> +		str_on_off(kasan_arg_write_only));
>   }
>   
>   #ifdef CONFIG_KASAN_VMALLOC
> @@ -392,6 +429,13 @@ void kasan_enable_hw_tags(void)
>   		hw_enable_tag_checks_asymm();
>   	else
>   		hw_enable_tag_checks_sync();
> +
> +	if (kasan_arg_write_only == KASAN_ARG_WRITE_ONLY_ON &&
> +	    hw_enable_tag_checks_write_only()) {
> +		kasan_arg_write_only == KASAN_ARG_WRITE_ONLY_OFF;
> +		kasan_flag_write_only = false;
> +		pr_warn_once("System doesn't support write-only option. Disable it\n");
> +	}
>   }
>   
>   #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> @@ -404,4 +448,10 @@ VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
>   }
>   EXPORT_SYMBOL_IF_KUNIT(kasan_force_async_fault);
>   
> +VISIBLE_IF_KUNIT bool kasan_write_only_enabled(void)
> +{
> +	return kasan_flag_write_only;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(kasan_write_only_enabled);
> +
>   #endif
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 129178be5e64..c1490136c96b 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -428,6 +428,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>   #define hw_enable_tag_checks_sync()		arch_enable_tag_checks_sync()
>   #define hw_enable_tag_checks_async()		arch_enable_tag_checks_async()
>   #define hw_enable_tag_checks_asymm()		arch_enable_tag_checks_asymm()
> +#define hw_enable_tag_checks_write_only()	arch_enable_tag_checks_write_only()
>   #define hw_suppress_tag_checks_start()		arch_suppress_tag_checks_start()
>   #define hw_suppress_tag_checks_stop()		arch_suppress_tag_checks_stop()
>   #define hw_force_async_tag_fault()		arch_force_async_tag_fault()
> @@ -437,11 +438,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>   			arch_set_mem_tag_range((addr), (size), (tag), (init))
>   
>   void kasan_enable_hw_tags(void);
> +bool kasan_write_only_enabled(void);
>   
>   #else /* CONFIG_KASAN_HW_TAGS */
>   
>   static inline void kasan_enable_hw_tags(void) { }
>   
> +static inline bool kasan_write_only_enabled(void)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_KASAN_HW_TAGS */
>   
>   #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)

Thanks,

Ben


