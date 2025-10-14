Return-Path: <linux-kernel+bounces-853224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB5BDAF60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4765E3B2141
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21492BD59C;
	Tue, 14 Oct 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPCZk9t8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36212951B3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467080; cv=none; b=tJXSEMg1ZRSdaGykc3yLvjPVTOmlwgvtkjXJ/4TVUYSn+xk+UnrNzJss5my3iRO5NajOag9/SGp6NwZe96XF7+xKuZsrUb+64eAV/j3e8HdM+FJYsBus4KAh1he6U8ZHuNQiq+63aDF9ZoDvrK5vxzDbn5/az6o7xTJJ/A15qcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467080; c=relaxed/simple;
	bh=MJS+eUrMfmj2mMl0f3BB/puIU4qDp7SzMxeYKIl6gnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyJ6RMcaHONASnqO2J6bPJjxPN7022WuDDX3I43Xu+XdIAKHtiVt/CcssLFcl1AHmZowxtFkHiRg2xzvkCsrTc/4G+Q50EvAmM2yqvYjS2sn9zqUQzGZTnOXNP838esOyRfDMiv+r3QgO9rh83fy4nox+LJJRA4X9RnUbIw7eA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPCZk9t8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760467079; x=1792003079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MJS+eUrMfmj2mMl0f3BB/puIU4qDp7SzMxeYKIl6gnY=;
  b=HPCZk9t8/f8zhYwmYFJlpj7LCJbD5ZGC6NkmI4nWLIfVOpOVLjj8yJ0v
   2RcA0/7pF/OXcVSpdFSJLXH64fyDcKzt31vfUDT9QEUU+haG8hKL5DlUL
   7WE6Bx57AaZuSKocoAiRPK+SW1yQCZp3kjquVuGERLJMel0IKN98rnRBn
   idIVStlBA2Kik/EhQb6OZbpxkQoMdENx8Kws4zbsUj+uC0S1G5oD40ij/
   IuKgZ2k3gaUm0UtpWGDY9rxlR2BdDW+htBO0XqJrEoVSU7s0H9r1DAWXW
   nlRSQ5VjZBd6o2SbUNaAS4DF0PX6MSfa9p4UFH6jBXSymkVNNL9pk5sGj
   w==;
X-CSE-ConnectionGUID: RYXOhm4KTyK5TiJCRuLCBA==
X-CSE-MsgGUID: +uYtbnX8R0GGX+Rm2jBw7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62677352"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62677352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:37:58 -0700
X-CSE-ConnectionGUID: +gZHGQ8lT3ac+qqPKj9LhQ==
X-CSE-MsgGUID: xXQCKBV3R1CJMvk06TDBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="181897544"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.172]) ([10.125.111.172])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:37:57 -0700
Message-ID: <839b7bc9-b155-4458-ad36-fa083659283c@intel.com>
Date: Tue, 14 Oct 2025 11:37:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-5-david.kaplan@amd.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20251013143444.3999-5-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 07:33, David Kaplan wrote:
...
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void spectre_v1_reset_mitigation(void)
> +{
> +	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
> +	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
> +	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_AUTO;
> +}
> +#endif
> +
>  static int __init nospectre_v1_cmdline(char *str)
>  {
>  	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
> @@ -3794,3 +3805,10 @@ void __warn_thunk(void)
>  {
>  	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
>  }
> +
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +void arch_cpu_reset_mitigations(void)
> +{
> +	spectre_v1_reset_mitigation();
> +}
> +#endif

Are all the #ifdefs necessary? For instance, a single:

 void arch_cpu_reset_mitigations(void)
 {
+	if (!IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS))
+		return;
...

and removing *all* the #ifdefs might be enough to tell the compiler that
all the *_reset_mitigation() functions are unreachable.

But the larger concern through all of this is that this is all *new*
code. The reset concept is completely new and the reset functions look
to be ad-hoc. They follow a few patterns, but nothing super consistent.

Also, this series is going to need to be broken up. I'd suggest going
after the dynamic alternatives, first. I'm sure there's a need for that
_somewhere_ other than for vulnerabilities.

But, in the end, (IMNHO) this series really just adds complexity. It
doesn't do enough refactoring or complexity reduction to go in with this
approach.

