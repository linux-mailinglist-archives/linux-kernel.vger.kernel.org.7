Return-Path: <linux-kernel+bounces-869881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B6FC08EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDAC3ABCC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886752EA479;
	Sat, 25 Oct 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X+lXwJdZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38682E7F03
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761386839; cv=none; b=A+Ok5zraMQHvlH/z+x71+HMPG+FjahW7qs2937Wqf7lwNt174CjSSx1MjAvw4IlQoC2p3oWRv0KsKSBShe4DyHJADyUoHRWHcglGqNWlDhyUBnXb8auy+8wkVj8dEBXatmMQAg3tYaWF30s91F17zdW3lBunYax16Ce3/nFRQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761386839; c=relaxed/simple;
	bh=edOzaU61N4jljydWVSjFQQhkDWFBQyZ/Jw/fLttgTXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQT3bmh8KQEDOPiCjEElpz0ajuahGZ7KAyd3PRi92BaAwGsCJj3Av1Cfrx1GNAFIJ/Z3MkSWVi7rwwC1eB30TQatAFUwedXnIeyhARlp7oOl4u+6k1qyIaJKRf6+F8eCfCWGZqY4Xv65nARfzKd/Ceh08F1EPKYvBUCMWsAZfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X+lXwJdZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2669040E019F;
	Sat, 25 Oct 2025 10:07:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rKwqvsflQOVQ; Sat, 25 Oct 2025 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761386831; bh=kMoOUP8YPuXv/puO8vDWRWdRTtB4oFAsNjhiFeQqdvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+lXwJdZ/8NGNTTEMe+Kyw8cOzXcrJyGOHMk7EJJ+QScYTrklQj0nJkj3D85/4nIR
	 oUIY+B6d4uVEsmNF/WBMkld1X7lpFIPf1bhNCmDKzBOn7fZV8wzkjWIU0sXbtzOV66
	 Z+0MsuSNojWn/lfiDIaKuyoERnBfelGSSxs1uSFFzriODc3bF+0LA4aISmyDdCv7NO
	 KTu2W/cteIHMsPUrr4ZJltVcwZgBQ7UeLv9rmeiAX3FXLAMMSkCuQs4BmDZ1bjte4d
	 pLzphIXf4j8+Mw0eM4JJPCrqwqcq8/zOISUAAzn5cayIkmQzD07RAUgZQlhG8Lj1kb
	 4QkE1TtRuxeGsziudb5ANXzEnZxsCG3JuLbPkGzzBzaaAYHk3TllgZUqZsL2Fx6hwT
	 c/6txnWJiVpoNcyhZgG1LH4WIqrYyF9Dwu3QUMPmEv6NeyJqmcIy6uD1/v+DOFSsAO
	 HdkbaQ7e0U9x8tun8oF3IWrwHhfEyxCZDVtI74qZodVVfn4F/9f+JIOuPB5WwY9mBT
	 n2KlCXlJZa4zRsRcGYA6GsWbXBqE8uLJE2ANZzxSf6XQfYcio3WMiyO5hOqddQHXHR
	 8YMgG5eryRXm8zbQqHITvdxetr/Sc7B+Kwiw+zmIUYpLDTsnJrkOOjhUWyhT74CK1D
	 jzJZM4inMOprSshv5SIaNbSE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 046E340E019B;
	Sat, 25 Oct 2025 10:06:44 +0000 (UTC)
Date: Sat, 25 Oct 2025 12:06:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH 02/21] x86/mm/asi: add X86_FEATURE_ASI and asi=
Message-ID: <20251025100642.GVaPyhMp4CEmsYW3xy@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com>

On Wed, Sep 24, 2025 at 02:59:37PM +0000, Brendan Jackman wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e581b5192b66c6f25aba38d4f8ff8..9b8330fc1fe31721af39b08b58b729ced78ba803 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5324,6 +5324,14 @@
>  
>  			Not specifying this option is equivalent to pti=auto.
>  
> +	asi=		[X86-64] Control Address Space Isolation (ASI), a
> +			technology for mitigating CPU vulnerabilities.

> 			ASI is
> +			not yet ready to provide security guarantees but can be
> +			enabled for evaluation.

Yeah, no need for such "temporary" statements in the help text since you're
going to have to touch it again once it becomes a full-fledged feature.

> +			on   - unconditionally enable
> +			off  - unconditionally disable

"unconditionally" as opposed to some other setting which is conditional?

> +
>  	pty.legacy_count=
>  			[KNL] Number of legacy pty's. Overwrites compiled-in
>  			default number.
> diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
> index 53acdf22fe33efc6ccedbae52b262a904868459a..32a4c04c4be0f6f425c7cbcff4c58f1827a4b4c4 100644
> --- a/arch/x86/include/asm/asi.h
> +++ b/arch/x86/include/asm/asi.h
> @@ -2,4 +2,14 @@
>  #ifndef _ASM_X86_ASI_H
>  #define _ASM_X86_ASI_H
>  
> +#include <asm/cpufeature.h>
> +
> +void asi_check_boottime_disable(void);
> +
> +/* Helper for generic code. Arch code just uses cpu_feature_enabled(). */
> +static inline bool asi_enabled_static(void)

"static" because? There will be a dynamic one too?

> +{
> +	return cpu_feature_enabled(X86_FEATURE_ASI);
> +}
> +
>  #endif /* _ASM_X86_ASI_H */
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 4091a776e37aaed67ca93b0a0cd23cc25dbc33d4..3eee24a4cabf3b2131c34596236d8bc8eec05b3b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -499,6 +499,7 @@
>  #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
>  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
>  #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
> +#define X86_FEATURE_ASI			(21*32+17) /* Kernel Address Space Isolation */

I think we really will need to show this in /proc/cpuinfo as it is a real, big
feature which gets proper kernel glue vs some silly CPUID bit.

IOW,

#define X86_FEATURE_ASI			(21*32+17) /* "asi" Kernel Address Space Isolation */
						      ^^^^

Not sure, though, when we should make it an ABI - perhaps once the whole pile
has landed...

>  /*
>   * BUG word(s)
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5b9908f13dcfd092897f3778ee56ea4d45bdb868..5ecbff70964f61a903ac96cec3736a7cec1221fd 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
>  obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
>  obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
>  obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
> +obj-$(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION)	+= asi.o
>  
>  obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
> diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8c907f3c84f43f66e412ecbfa99e67390d31a66f
> --- /dev/null
> +++ b/arch/x86/mm/asi.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/asi.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +
> +#include <asm/cmdline.h>
> +#include <asm/cpufeature.h>
> +
> +void __init asi_check_boottime_disable(void)
> +{
> +	bool enabled = false;
> +	char arg[4];
> +	int ret;
> +
> +	ret = cmdline_find_option(boot_command_line, "asi", arg, sizeof(arg));
> +	if (ret == 3 && !strncmp(arg, "off", 3)) {
> +		enabled = false;
> +		pr_info("ASI explicitly disabled by kernel cmdline.\n");
> +	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
> +		enabled = true;
> +		pr_info("ASI enabled.\n");

I'm not sure about those pr_info()s. When it is disabled, you can clear
X86_FEATURE_ASI so you won't see it in /proc/cpuinfo and then it is disabled.
And the same when it is enabled.

> +	} else if (ret) {
> +		pr_err("Unknown asi= flag '%s', try 'off' or 'on'\n", arg);
> +	}
> +
> +	if (enabled)
> +		setup_force_cpu_cap(X86_FEATURE_ASI);
> +}

Not an early_param() ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

