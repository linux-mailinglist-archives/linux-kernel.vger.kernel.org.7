Return-Path: <linux-kernel+bounces-732506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E699B067C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2BD1C211AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D62741A3;
	Tue, 15 Jul 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YniPcURD"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508B14C5B0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611451; cv=none; b=tp4k+81D/r1crr8O7pjVZI2BTqIp5lVCiMNEjdmdG0F4Mmcsr5oN/YtU2UiGqXQ2vxpTQ6+ThGkKx9AuRzxk9an8MjdVoSmdkupvHxHAxae4ngm4CkKLFQZl/pD52VyUKz/94GfgPkRkYrbhxfxns1NADerte2lMghn6bYOXq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611451; c=relaxed/simple;
	bh=RFjknytw46vyEdMLpvZ063QiDIV6PkBDAUckvb8lJf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS/RUozrWqeT4C0n/kg4FUJ+GdlCd8+hEAZuyQKD9jFiB4vR+fUjdGxyTy5B3gUQo4pym1XRPPPHlbYfd+MYI9sP3pFS4s2YytWfNP08NGOiYabQkR+kupn2EnIplSRWthN3VshrwDDip1iwyQlkGJ0SwyH8ELCv9AGWP8wtIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YniPcURD; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:6556:8629:7dba:d48c] ([IPv6:2601:646:8081:9482:6556:8629:7dba:d48c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56FKUD3L1139211
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Jul 2025 13:30:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56FKUD3L1139211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752611414;
	bh=gxHi2vI43gFbOLjaPZbkA/KX2bV0pbYr4IpZY5Wn/k0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YniPcURDZcjZIZvFKqFrZyLwnEPOc/BL5mL2Yig0v5yRpLznh315KRbSyFdIUpWby
	 afHtxFShC1UotIYK9uQd6+317Uhzzzcg/C0avnidBYrBgHJyNCUyqaRrcOomsiAujy
	 GSRMBqxqYzEVTvX6bMwJxShtZiZZXtjF8nRnu8G51wsjr4sluJaLmHvHRanX1l6hus
	 5uKvMHsZxawBKfRlG1SgNIAChLp61o696tuK3T2cG0Up894QI/guvxOeO29tTdikwU
	 2LKWDmxPw5vukNkz0hK6F9Aj99FwOweezxuzZU0Y0LKvYqaAjjRoB+dL7G8uGj2nfJ
	 0/MdnFIHL88gQ==
Message-ID: <6650dd3f-c9fc-4d23-83b6-6f351eb5237e@zytor.com>
Date: Tue, 15 Jul 2025 13:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, ardb@kernel.org, ubizjak@gmail.com, brgerst@gmail.com,
        linux-kernel@vger.kernel.org
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-15 11:16, Khalid Ali wrote:
> From: Khalid Ali <khaliidcaliy@gmail.com>
> 
> When Initializing cr4 bit PSE and PGE, cr4 is written twice for	
> each bit. This is redundancy.
> 
> Instead, set both bits first and write CR4 once, avoiding redundant
> writes. This makes consistent with cr0 writes, which is set bits and
> write once.
> 
> Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> ---
>   arch/x86/kernel/head_64.S | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 4390a28f7dad..dfb5390e5c9a 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -222,12 +222,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>   
>   	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
>   	btsl	$X86_CR4_PSE_BIT, %ecx
> -	movq	%rcx, %cr4
> -
> -	/*
> -	 * Set CR4.PGE to re-enable global translations.
> -	 */
> +	/* Set CR4.PGE to re-enable global translations. */
>   	btsl	$X86_CR4_PGE_BIT, %ecx
> +	
>   	movq	%rcx, %cr4
>   
>   #ifdef CONFIG_SMP

The double write is intentional:

         /*
          * Create a mask of CR4 bits to preserve. Omit PGE in order to 
flush
          * global 1:1 translations from the TLBs.
          *
          * From the SDM:
          * "If CR4.PGE is changing from 0 to 1, there were no global TLB
          *  entries before the execution; if CR4.PGE is changing from 1 
to 0,
          *  there will be no global TLB entries after the execution."
          */
         movl    $(X86_CR4_PAE | X86_CR4_LA57), %edx

