Return-Path: <linux-kernel+bounces-740531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58FB0D553
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684251892C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700C2DA760;
	Tue, 22 Jul 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NJ1dF+vU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8552236E8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175340; cv=none; b=MzX/s+/UQF7ZuySyF3ycmPrDH0UBx/nKqmdWKasib97q3V8yLXZCpKoNXZoouCpFdGffGYJbCwnljqBCoA3nrVUvv0PgmpszUQciZQjt8pI+/dt/YA0/7Wo0POMm1exUT+nGnRROmlNO14Aqy/5EHVmKvug02siae/fHbe4ROXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175340; c=relaxed/simple;
	bh=7g5TcZqhFRX/me+tMxGLZKo7fKEWw70YL4VjZOwSd14=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vkh5GI+UETiPr3wO1Hvwe4h+W2BzMvT0Py9pAUTJd9gWNB1ZAeg0BXX2Omt0xV20tzUFQdbxOr3M+8pMoEASUTkKZp/AdAeigsMIoWuzdMTRqgb2rjRU/Y8XMhm5VPvEfQhEjf9jmPb+p1H3SwzA5j25btX5qBTmyGn3tEZqCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NJ1dF+vU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56M98SmG471807
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 02:08:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56M98SmG471807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753175309;
	bh=YHKVV5kv5jsDqdQJolZk/Edn0dtS4CBCeXZ06HoXdVE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=NJ1dF+vUpUXHm+oa8IwUsr4GP3wgwt1hQPB1ZiV0yzJ5ZhqYRToRD9JGq+RMV0ng3
	 anwanqaOLKQtt/zwLyfdC8eOranJG+qPW4j48MoFsLAXgcORcfOMtrKuOWmARilbUv
	 DuQvAPwglcNQgFS1G3OfNpEBc7HEbEYeKv12jpWoNmbxCuIZAh8V9KmsXaAtw4KZV1
	 ak2EqBR5oltb87B5VFYWiYutL9cWSV+OutsiLQg1QBckyu9V+Bm7K3DGihFLgmPYGH
	 BX6Yb90CwpyH/FAG6i4Vr56ZcPDEj7uRWq4kyGpV4GtRZ28mAqthef3sgDP8/frtR0
	 fbyUoLMUmu7yA==
Message-ID: <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
Date: Tue, 22 Jul 2025 02:08:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xin Li <xin@zytor.com>
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
To: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
Cc: Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo <mingo@redhat.com>,
        Petkov Borislav <bp@alien8.de>,
        Hansen Dave <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Anvin H. Peter" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> On Jul 22, 2025, at 12:54 AM, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com> wrote:
> 
> ﻿If LAM (CONFIG_ADDRESS_MASKING) or FRED (CONFIG_X86_FRED) are disabled
> during compile time, they still are enumerated in macros such as
> cpu_has() or this_cpu_has() that use the x86_capability bitmask. The
> features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file.

I'm curious how this bug is introduced with my patch set that adds the
AWK script which automatically generates the CPU feature mask header.

> 
> The documentation for x86/cpuinfo.rst also states how to handle features
> disabled at compile time:
> 
>    The kernel disabled support for it at compile-time
>    --------------------------------------------------
> 
>    For example, if Linear Address Masking (LAM) is not enabled when
>    building (i.e., CONFIG_ADDRESS_MASKING is not selected) the flag
>    "lam" will not show up. Even though the feature will still be
>    detected via CPUID, the kernel disables it by clearing via
>    setup_clear_cpu_cap(X86_FEATURE_LAM).
> 
> Clear feature bits if they are present in the DISABLED_MASK.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

And we need a Fixes tag and CC stable.

> ---
> arch/x86/kernel/cpu/common.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 77afca95cced..1c5af795cedc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1782,6 +1782,16 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>    if (!pgtable_l5_enabled())
>        setup_clear_cpu_cap(X86_FEATURE_LA57);
> 
> +    /*
> +     * If a feature is disabled during compile time clear its feature
> +     * bit to prevent it from showing up in the x86_capability bitmask.
> +     */
> +    if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +        setup_clear_cpu_cap(X86_FEATURE_LAM);
> +
> +    if (!cpu_feature_enabled(X86_FEATURE_FRED))
> +        setup_clear_cpu_cap(X86_FEATURE_FRED);
> +

The following code will work as a generic fix:

	c->x86_capability[i] &= ~DISABLED_MASK(i);

And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x).

Thanks!
     Xin

