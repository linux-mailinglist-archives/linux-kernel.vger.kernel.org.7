Return-Path: <linux-kernel+bounces-770785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D291AB27EED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D197B74FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879728643D;
	Fri, 15 Aug 2025 11:13:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63903192D97;
	Fri, 15 Aug 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256406; cv=none; b=gS/XOvqAKtjluAZ5GFnbjCLOz+X0OJy7WgdUf1upHtLCEPfX7TbVhKFR09lKrlvLCorjSiQPoCBktlofD2oerXrHStCOnFpcUMqrfGdMfOfY3ZgOCbNZLi7xWu/Y2aX4EToiRa9CkjFqaFXM4GXwterOzab9+Qs7jzTS2yZcOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256406; c=relaxed/simple;
	bh=kZa8XaiNRy3Y5ddm4zbiVPAGgDC6F4xh5I/4z3Z0IQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIxYv3vcgbKRC7kPUGai3uHQICAeCEVWr9LymVPFTRJS7wxy3x6ed4h8g+bXQBBz5QoBvBG6NyOVoRbgH5901Ux8Y/d5luP0YnHKUkxkp+XeSbE8XnriGLOOogGwhwQqNtF1zYxffpRRZy/jl8kw8zVZ+uHJY0gDB6vPXVEbeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B8BC4CEEB;
	Fri, 15 Aug 2025 11:13:21 +0000 (UTC)
Date: Fri, 15 Aug 2025 12:13:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kasan/hw-tags: introduce kasan.store_only option
Message-ID: <aJ8WTyRJVznC9v4K@arm.com>
References: <20250813175335.3980268-1-yeoreum.yun@arm.com>
 <20250813175335.3980268-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813175335.3980268-2-yeoreum.yun@arm.com>

On Wed, Aug 13, 2025 at 06:53:34PM +0100, Yeoreum Yun wrote:
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 2e98028c1965..3e1cc341d47a 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -200,6 +200,7 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag,
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
> +static inline int mte_enable_kenrel_store_only(void)
				^^^^^^
This won't build with MTE disabled (check spelling).

> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_ARM64_MTE */
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9ad065f15f1d..7b724fcf20a7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2404,6 +2404,11 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  
>  	kasan_init_hw_tags_cpu();
>  }
> +
> +static void cpu_enable_mte_store_only(struct arm64_cpu_capabilities const *cap)
> +{
> +	kasan_late_init_hw_tags_cpu();
> +}
>  #endif /* CONFIG_ARM64_MTE */
>  
>  static void user_feature_fixup(void)
> @@ -2922,6 +2927,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_MTE_STORE_ONLY,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>  		.matches = has_cpuid_feature,
> +		.cpu_enable = cpu_enable_mte_store_only,

I don't think we should add this, see below.

>  		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTESTOREONLY, IMP)
>  	},
>  #endif /* CONFIG_ARM64_MTE */
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index e5e773844889..8eb1f66f2ccd 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -157,6 +157,20 @@ void mte_enable_kernel_asymm(void)
>  		mte_enable_kernel_sync();
>  	}
>  }
> +
> +int mte_enable_kernel_store_only(void)
> +{
> +	if (!cpus_have_cap(ARM64_MTE_STORE_ONLY))
> +		return -EINVAL;
> +
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCSO_MASK,
> +			 SYS_FIELD_PREP(SCTLR_EL1, TCSO, 1));
> +	isb();
> +
> +	pr_info_once("MTE: enabled stonly mode at EL1\n");
> +
> +	return 0;
> +}
>  #endif

If we do something like mte_enable_kernel_asymm(), that one doesn't
return any error, just fall back to the default mode.

> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b54..c2f90c06076e 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -219,6 +246,20 @@ void kasan_init_hw_tags_cpu(void)
>  	kasan_enable_hw_tags();
>  }
>  
> +/*
> + * kasan_late_init_hw_tags_cpu_post() is called for each CPU after
> + * all cpus are bring-up at boot.

Nit: s/bring-up/brought up/

> + * Not marked as __init as a CPU can be hot-plugged after boot.
> + */
> +void kasan_late_init_hw_tags_cpu(void)
> +{
> +	/*
> +	 * Enable stonly mode only when explicitly requested through the command line.
> +	 * If system doesn't support, kasan checks all operation.
> +	 */
> +	kasan_enable_store_only();
> +}

There's nothing late about this. We have kasan_init_hw_tags_cpu()
already and I'd rather have it all handled via this function. It's not
that different from how we added asymmetric support, though store-only
is complementary to the sync vs async checking.

Like we do in mte_enable_kernel_asymm(), if the feature is not available
just fall back to checking both reads and writes in the chosen
async/sync/asymm way. You can add some pr_info() to inform the user of
the chosen kasan mode. It's really mostly an performance choice.

-- 
Catalin

