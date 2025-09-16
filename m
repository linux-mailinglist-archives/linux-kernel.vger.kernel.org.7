Return-Path: <linux-kernel+bounces-819480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021E3B5A171
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611893BF9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768E1CAA6C;
	Tue, 16 Sep 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlDQEdc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126D26AD9;
	Tue, 16 Sep 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051069; cv=none; b=Jo2vPCRJWu2invxJ7i85dCankLOcRCGQoDIx1XGmeMwjOaO7klLC/8XkYI95uoJUUMqbcBnp0yzx6AtI1IJE+2cxVvB5DmBews6ES348SM3i4zevhxCU3QiHpx8cQB8v/T12JmXf6nTATf10cwLcr6u2k/wgHykobxPKSD/4I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051069; c=relaxed/simple;
	bh=N49H9fou0UCpbCTf6jTtg2kx/FPk8dM2Ik20j+Oj/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeJQAy6v83Tq1qP5/accigik2hYrFLhDVgx29CL9038l1W7bWwaSrAl3hDhc6zrFKj590fyXNK3iXrm2+TIZTVFZL4GChBZiJAYcs2wNAjmNEeTSZwblRuwDGBodWFJlkDcdvnHCIoncRKs4XnyBVHeTf1OkjkgtqiirHpNa+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlDQEdc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1697BC4CEEB;
	Tue, 16 Sep 2025 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758051068;
	bh=N49H9fou0UCpbCTf6jTtg2kx/FPk8dM2Ik20j+Oj/oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlDQEdc09HmzC/9s1VCr8wF2BT2hvOdmrkUyhzvIQqlAdft1VDLtl5Ho1w4XzEihL
	 8FGJo8hZJnyWVj0xRfE84U6wZ50Ji1FWF+kZ1o7PtJLb3HxZOmvfU7pbErjFyG4LcX
	 Un2pOqeAhX5/Nn8T6HjAhV0AJ3hcopqnycaRB0hYiOwkKKC/qSHYy/WV4avw/wisrX
	 Uf0mKamMoW34VAyRsuzsrBK/Wp5Zx917SXGKep2jYh7TGbuG2kJpj+fTFWwm56S9Fi
	 uUTNIADkGV6RBGXVj0H+wNvDPN7Bx40u5EdY9iqS4wj9VEJTUW33iP//U0nT2wTVE4
	 DnbICveY3izOw==
Date: Tue, 16 Sep 2025 20:31:00 +0100
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <aMm69C3IGuDHF248@willie-the-truck>
References: <20250903150020.1131840-1-yeoreum.yun@arm.com>
 <20250903150020.1131840-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903150020.1131840-2-yeoreum.yun@arm.com>

On Wed, Sep 03, 2025 at 04:00:19PM +0100, Yeoreum Yun wrote:
> Since Armv8.9, FEATURE_MTE_STORE_ONLY feature is introduced to restrict
> raise of tag check fault on store operation only.
> Introcude KASAN write only mode based on this feature.

Typo ^^

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
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst  |  3 ++
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  6 +++
>  arch/arm64/kernel/cpufeature.c     |  2 +-
>  arch/arm64/kernel/mte.c            | 18 ++++++++
>  mm/kasan/hw_tags.c                 | 70 +++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h                   |  7 +++
>  7 files changed, 104 insertions(+), 3 deletions(-)

[...]

> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b54..d5b5fb47d52b 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -41,9 +41,16 @@ enum kasan_arg_vmalloc {
>  	KASAN_ARG_VMALLOC_ON,
>  };
>  
> +enum kasan_arg_write_only {
> +	KASAN_ARG_WRITE_ONLY_DEFAULT,
> +	KASAN_ARG_WRITE_ONLY_OFF,
> +	KASAN_ARG_WRITE_ONLY_ON,
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
> +/* Whether to check write accesses only. */
> +static bool kasan_flag_write_only = false;
> +
>  #define PAGE_ALLOC_SAMPLE_DEFAULT	1
>  #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT	3
>  
> @@ -141,6 +151,23 @@ static int __init early_kasan_flag_vmalloc(char *arg)
>  }
>  early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
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
>  static inline const char *kasan_mode_info(void)
>  {
>  	if (kasan_mode == KASAN_MODE_ASYNC)
> @@ -257,15 +284,28 @@ void __init kasan_init_hw_tags(void)
>  		break;
>  	}
>  
> +	switch (kasan_arg_write_only) {
> +	case KASAN_ARG_WRITE_ONLY_DEFAULT:
> +		/* Default is specified by kasan_flag_write_only definition. */
> +		break;
> +	case KASAN_ARG_WRITE_ONLY_OFF:
> +		kasan_flag_write_only = false;
> +		break;
> +	case KASAN_ARG_WRITE_ONLY_ON:
> +		kasan_flag_write_only = true;
> +		break;
> +	}
> +
>  	kasan_init_tags();

I'm probably missing something here, but why have 'enum
kasan_arg_write_only' at all? What stops you from setting
'kasan_flag_write_only' directly from early_kasan_flag_write_only()?

This all looks weirdly over-engineered, as though 'kasan_flag_write_only'
is expected to be statically initialised to something other than 'false'.

>  	/* KASAN is now initialized, enable it. */
>  	static_branch_enable(&kasan_flag_enabled);
>  
> -	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
> +	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s, write_only=%s)\n",
>  		kasan_mode_info(),
>  		str_on_off(kasan_vmalloc_enabled()),
> -		str_on_off(kasan_stack_collection_enabled()));
> +		str_on_off(kasan_stack_collection_enabled()),
> +		str_on_off(kasan_arg_write_only));

It's also confusing, because now you appear to be passing the funny new
'enum' type to str_on_off(), which expects a bool.

Will

