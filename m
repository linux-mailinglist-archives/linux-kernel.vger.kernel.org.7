Return-Path: <linux-kernel+bounces-844534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FEBC225E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4923E4E1E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE242E7186;
	Tue,  7 Oct 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTIX/8tU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5594316E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855742; cv=none; b=qeqAIvpDVGFzW4dmu07cqcBtkYBtgnSmo2af6S02RpiVjhhEpy7TKNgquuJ1sRQCwSMILGYvhrL33dypZulxx4QN0IO6xwX5Gqg8wuC00JgDQrUaHqUxAhzmJxtmrBdePIXYVCg+zIjRaIbLi8n0wki5VncPhVtkOs/LO5KD9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855742; c=relaxed/simple;
	bh=cHDBYJfvjG7v+4M83QWIYjRPAvCeL8fjNTM/fc0GtaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snPzN548i0nrx/BYoUY0ga4L3l/Ap60Ee5pSCJiT6b4bPK6YWxAaSokflZEzmlaeHuwyF9/YluhsZZV2XNX9m46l6ly0S69EtNhkYTuoD8LfbBq7lEmNnqAzMCIwlLBEdWsBXRjSyg6dW/oZ00GD0zWE1rfivJKpKjpXUZzQleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTIX/8tU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759855741; x=1791391741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cHDBYJfvjG7v+4M83QWIYjRPAvCeL8fjNTM/fc0GtaM=;
  b=NTIX/8tUAA17sP0PvsWeemo5qevQy9xzdfY2N3RWlB6R2K6HvJplsQ8n
   LjVtTSTWCX0FTgcupE6yx4psGzv0FxwvepUoY0JgP84LMHqdXe/+lDqkn
   4TR1CJ+qM2Hpa7nLPRMIBoKvX1aJNFi+se6Y9urKMYBrZdfNAmauWp1qy
   xAQf9tgkYhdFuf+zjN+L7mMd1E9Cj8fiYfj5TgKbickoV/ZGZptmS696/
   YRrOPlCvVJR/+iGWikqUP9bb9jxGSBXzBwGiCJIM2GkIQ3f6Kabz6H14k
   qp5x1I1gucd0fUW3+ndrNIYSzdMes1sArm5qIgN8vkmTTHx3B/VfO5jcO
   A==;
X-CSE-ConnectionGUID: CsILuTGIS9+A2xnv0mJkEw==
X-CSE-MsgGUID: TVWuVy6YQwGIKroBCteOcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72658011"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72658011"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:49:00 -0700
X-CSE-ConnectionGUID: tgfysv6CRN6YhcPO6HyoQg==
X-CSE-MsgGUID: rhkQx1+pTGuwkrG7C65fWg==
X-ExtLoop1: 1
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.162]) ([10.125.110.162])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:48:59 -0700
Message-ID: <20264c7b-36dd-4fd3-a755-3f46584f37bc@intel.com>
Date: Tue, 7 Oct 2025 09:48:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/tsc: Disable clocksource watchdog for TSC on
 recent UV
To: Dimitri Sivanich <sivanich@hpe.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Wiesner <jwiesner@suse.de>, Steve Wahl <steve.wahl@hpe.com>,
 Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
 Russ Anderson <russ.anderson@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marco Elver <elver@google.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Nikunj A Dadhania <nikunj@amd.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>
References: <aOVAkYWjk+aWcM3F@hpe.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aOVAkYWjk+aWcM3F@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 09:32, Dimitri Sivanich wrote:
> +static inline int is_uvx_hub(void) { return 0; }
> +static inline int is_uvy_hub(void) { return 0; }
> +static inline int is_uv_hub(void) { return 0; }
>  
>  #endif	/* X86_UV */
>  
> diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
> index ea877fd83114..6e085ce8fc02 100644
> --- a/arch/x86/include/asm/uv/uv_hub.h
> +++ b/arch/x86/include/asm/uv/uv_hub.h
> @@ -246,6 +246,7 @@ static inline int is_uv5_hub(void) { return is_uv(UV5); }
>   * then test if is UV4.
>   */
>  
> +#ifdef CONFIG_X86_UV
>  /* UVX class: UV2,3,4 */
>  static inline int is_uvx_hub(void) { return is_uv(UVX); }
>  
> @@ -254,6 +255,7 @@ static inline int is_uvy_hub(void) { return is_uv(UVY); }
>  
>  /* Any UV Hubbed System */
>  static inline int is_uv_hub(void) { return is_uv(UV_ANY); }
> +#endif

Defining those helpers across two different headers seems like a recipe
for pain.

I suspect a big chunk of those stubs (and their #ifdefs could completely
go away if you _just_ did:

#ifdef CONFIG_X86_UV
static inline int uv_hub_type(void)
{
        return uv_hub_info->hub_type;
}
#else
static inline int uv_hub_type(void)
{
	return 0;
}
#endif

In any case, this is precisely the kind of patch that would be best
refactored into two piece: one to expose the is_uv...() function and
another to actually use it.

Also, at this point, this:

>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> -	    topology_max_packages() <= 4)
> +	    (topology_max_packages() <= 4 || is_uvy_hub()))
>  		tsc_disable_clocksource_watchdog();

has IMNHO gotten out of hand.

It should probably be:

 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
	    platform_is_exempt_from_watchdog())
 		tsc_disable_clocksource_watchdog();

In addition, 233756a640be talked quite a bit about *why* the 4-socket
line was chosen. This needs to have a similar explanation for UV systems.

