Return-Path: <linux-kernel+bounces-881236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19EC27CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A804002D8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838922F49E3;
	Sat,  1 Nov 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2lHGrph"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE532F2909
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996371; cv=none; b=U/dU85qtlpiflkzbV2AqMkw+wHEc84JEs5QvOhvROaUaFxmWb886cowdD+pxskroycD/tPocDkEfZ4Hj6Xdz84xQg/q8ajBZMIccj1tzx4Ta89J1CrVmXdViJqMk8DJQqTYhbefipPh8SxF3nuHOaAitcP9B0X1wOv/tV2Nbg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996371; c=relaxed/simple;
	bh=P6U9jSxQzSxAMuDBWU6Hr8PbQHnhvGY7+raQ3YD7YEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtxHNWu80j5VIOtBlXTl3SFSAhNleyr9HfEEpgXt9yRZ7/lLo/90jf5lELYbu2Tiv6UCRND6QXzbzQKX9+EAW9KoZyuVkbNScgP6rmIOB92uqcCRALk4IWIdfmKN8CJyXaQZlU9tXXHuI1oxLiK4mtSd2pWkoZlAuHcEyoDFB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2lHGrph; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47728f914a4so15448445e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761996366; x=1762601166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apQHIdVHxDKUXTs9N4QKJgNs7mj7CIkDdRkworlkT+M=;
        b=k2lHGrphrA6tbQI0Ae7Ym5Kw66hfcmhksAMDx0zcZIoU+8dGj9ewU+u0oF29+fIxLP
         xuEM6fXhcma4DX83Gt+yHassC/6e5QpmR5r9q+2yHOuuyfkOvXPYP3q4n3HVEhM/xRHB
         diG0yhLydZTJZR8bKhbpIVnTlBl18Mn/cprzDjy+YNIhEZSJ60tVIhsCAmFcNHZlhM0A
         51a6sB1vZU+n0bZgIfFmAJi+GoBcjm0WbxdvYCBFNERTGNjL4193eroPa9pvSsCx7mR8
         +YJ7A4BgJEYXovtUQ1khRhf6qfDtHkPRJfC49r0QDne/fvDSSiecrNtSZY1LN2b2WxrH
         VwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761996366; x=1762601166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apQHIdVHxDKUXTs9N4QKJgNs7mj7CIkDdRkworlkT+M=;
        b=xNO27YIdQOTHLrKQD//rin+B4vtfiiSDpMSLQv5d5vzRgxg06KmmBOgwirNtURnuZK
         xvqJyipD6UlsC6SMOBFxWtJfHHnIIPv4fLFJSdXBoaG+arVCmBdCMMxHZNlLQpQBpx2U
         5BMUYYNuPDy2BGWvkLKTaczjT5CuEhdoS3ahmqkeRYnk1TpeJ2Y4+YebgqFCJ5PHzJRB
         wXd/yWw5gogKK/uXeuFfLAB9vlPIVO3RDZeQR0/lv5o/Nr0PXWuje82RX2r19RaCPr1M
         ebj1HYn8+33aTpQuXi7+NsGDA3Yqdwr6eg26mUBLX8uieX6C+iCWvmtgXYgXAspWziyE
         c5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWSyoOghEM78sKjaMLIHtltIovPOzFa8zCnItUBzgWT7SCd49nSfaiiY4So8ks1+BA9yinh6P+RseHR3+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfbn16pMoCapwjujA2dnj2C6MahrYc+LHccllu4pT7fgQohM1a
	o2c2+sd+xhBMs+/2k91NkFTOiP4PZI/dpNa8J2sftoep0DbV6fF8E1fF
X-Gm-Gg: ASbGncvbHshFQSabgFr7c9XcebkjtJj78mckDsdcREWlWxHdSMtw6CzWRfgFpPMukPt
	b3UCIJEjo6gURjtbS2xpBAY/FooRZ0tGEEdrIaneNw5YJLpZ7peYi6AbjVXKjZ5sKfvZaWfVADL
	VLFnZnFzD2FiRrHNvC0fYGmtBiEo5MjfFeCF+0zvB5Q//embCd2wLE5b90RG7JxTn4egugReYE9
	IMvtuwKC0LX/RjM3itb1e0LIGYN3g08ouhYzAmGQIkBbZybjoKxCog+x9YYhgPuTqEpQ4DfOC7u
	pOIwF7cAQbUOB565beFWs20pm7ms/1a+3rJdeMkxO63NW7MgQXneOv4v1n5Yoj0ieQKCORnPynK
	sdHIkzz/BtJOvW8/ROa7Wt00Dhyc+AUeCeEM25LoklijCGpTyBFJW3OP32quCyxFYv2ZO7Quflm
	GmpaPJcw4VU5FpxQTjUIhSQfHpcrbGZIZvD8i6ROFb3g==
X-Google-Smtp-Source: AGHT+IEr4/HldgWidFLXKjNmN2bl8DUgYLiLVXGnzbSW/gMHZwfUqjsaJPk8BTMHs+j38xWW6TZjNg==
X-Received: by 2002:a05:600c:1e29:b0:46e:1fc2:f9ac with SMTP id 5b1f17b1804b1-477307b8790mr52280285e9.10.1761996366207;
        Sat, 01 Nov 2025 04:26:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e66f8sm44797165e9.1.2025.11.01.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:26:05 -0700 (PDT)
Date: Sat, 1 Nov 2025 11:26:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251101112604.09d32993@pumpkin>
In-Reply-To: <20251031174220.43458-2-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
	<20251031174220.43458-1-mjguzik@gmail.com>
	<20251031174220.43458-2-mjguzik@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 18:42:18 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> [real commit message will land here later]

Hmmm... modules use the 0x123456789abcdef0 placeholder (the 0 might not be
in the right place), this is non-canonical so nothing is badly broken.
Just allows speculative accesses to kernel space on some cpu.

> ---
>  arch/x86/include/asm/uaccess_64.h | 17 +++++++++--------
>  arch/x86/kernel/cpu/common.c      |  8 +++++---
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index c8a5ae35c871..f60c0ed147c3 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -12,13 +12,14 @@
>  #include <asm/cpufeatures.h>
>  #include <asm/page.h>
>  #include <asm/percpu.h>
> -#include <asm/runtime-const.h>
>  
> -/*
> - * Virtual variable: there's no actual backing store for this,
> - * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
> - */
> -extern unsigned long USER_PTR_MAX;
> +extern unsigned long user_ptr_max;
> +#ifdef MODULE
> +#define __user_ptr_max_accessor	user_ptr_max
> +#else
> +#include <asm/runtime-const.h>
> +#define __user_ptr_max_accessor	runtime_const_ptr(user_ptr_max)
> +#endif
>  
>  #ifdef CONFIG_ADDRESS_MASKING
>  /*
> @@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
>  #endif
>  
>  #define valid_user_address(x) \
> -	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
> +	likely((__force unsigned long)(x) <= __user_ptr_max_accessor)
>  
>  /*
>   * Masking the user address is an alternative to a conditional
> @@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>  	asm("cmp %1,%0\n\t"
>  	    "cmova %1,%0"
>  		:"=r" (ret)
> -		:"r" (runtime_const_ptr(USER_PTR_MAX)),
> +		:"r" (__user_ptr_max_accessor),
>  		 "0" (ptr));
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 3ff9682d8bc4..f338f5e9adfc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -78,6 +78,9 @@
>  DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
>  EXPORT_PER_CPU_SYMBOL(cpu_info);
>  
> +unsigned long user_ptr_max __ro_after_init;
> +EXPORT_SYMBOL(user_ptr_max);

That doesn't appear to be inside a CONFIG_X86_64 define.
I think I'd initialise it to one of its two values - probably the LA48 one.

	David

> +
>  u32 elf_hwcap2 __read_mostly;
>  
>  /* Number of siblings per CPU package */
> @@ -2575,14 +2578,13 @@ void __init arch_cpu_finalize_init(void)
>  	alternative_instructions();
>  
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> -		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
> -
> +		user_ptr_max = TASK_SIZE_MAX;
>  		/*
>  		 * Enable this when LAM is gated on LASS support
>  		if (cpu_feature_enabled(X86_FEATURE_LAM))
>  			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
>  		 */
> -		runtime_const_init(ptr, USER_PTR_MAX);
> +		runtime_const_init(ptr, user_ptr_max);
>  
>  		/*
>  		 * Make sure the first 2MB area is not mapped by huge pages


