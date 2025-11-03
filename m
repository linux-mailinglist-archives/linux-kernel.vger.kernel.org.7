Return-Path: <linux-kernel+bounces-882350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3BC2A3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39A404E4C44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25228DF07;
	Mon,  3 Nov 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aqYUWSKZ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56D8BEC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153419; cv=none; b=ijYHpv2N3639uzhiPHyIy8XpXLIvJDzoG/TG4j0IXV5knTFRWoad0mwiiLBNzpOVkU1SBzxBGgzc3DHf9didZuAz6UcWwgLLPMIzE3TxHG+lpcSFFpjo7nxGcWDLP08BBsUotT6rE4XNoED3bEHKgX7LkhEWX9tIr5RbuagY7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153419; c=relaxed/simple;
	bh=dWO9sUj3cFDm5DbEAzzNrc/MDZEY0ElBLA/lytWb+3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQqzk3qpxbFP4VMHXjuXhFLXDQV7Or2RnSq35sFSpulwUhU8BFPZ5Ehyje5AQgqE57j/EGiHsTZg59UHgiMNfXE+XEg0xIDEwCc1KdE4EnBgkvPcm9Sq8Bxay9YGD8yc590vaJmc5rcX3dMjLFc9Z3y2pnUOgUD5gOZLFvJQrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aqYUWSKZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781997d195aso2995780b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762153417; x=1762758217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5P3j3pQdM3AH1u51YzJ0Fa/KQtK+2/TBxkltuxNOgs=;
        b=aqYUWSKZWOIZQ3IqoIg8FIsCs7OkwX6V+PI2zIzduypbmvoI5GbiUu2QtwGfQFt9Wo
         m7VULIHJwWsRB5R6aTpFpXrrIJqi6ej/lYu9WZLMQKyUmclTiYwRMaw+ZzMuyK3UfIZs
         gAyzNxzt0Dv9oQaUbYjjgi7DqLfZhPLSsdKF+4UhRdhscq0Hi9A0WVjSBdi67ctR5J1L
         rZa4DM0qakVKmW1oqeVDOa2THi7cd6m4lx1/AekeWIxhV2V1dES5InynujBy+ZWpCpn1
         dBMExw6gFKX0PhknUBlTP5LpsCYUHhfnSNUZHvxcHkoXH6m5OfDQdIb7w/VRlbqPWyS4
         zT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153417; x=1762758217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5P3j3pQdM3AH1u51YzJ0Fa/KQtK+2/TBxkltuxNOgs=;
        b=DI/wSy8EyrMmAMXGdFu8NoiMgoKzkER0jBHoqukggXvHa1yptPMhWDOrucG86q49sH
         PHXrxHyhOdr6v6QgmXj30Jim994HB1TsbANSkpDngBC5QlAZvk6t+q+Hwoo/UUGlnzOk
         pISViLZjVjcEyEmceGJGQKBh1uLqKr+23Hf16XhIhWTkmuOMPDe22sSxCum/+LTEijcj
         mw8ZMFi3C4As7Y62zlNQqCBtoSzCJX85XRdiyDr0hMZ3N4Vng1TT7yxvccKWsFm6mRn7
         Q7qe+W+Z1ln/Jk2ukYHExHoEMJkAJnascYoKs00/XOc721F0XFNv4qMbXswRKSauDyQP
         mPlw==
X-Forwarded-Encrypted: i=1; AJvYcCWJjBBHrZF03jjWYiAtUb6UIT88mZ/9awJ8x1N6GzYxLDBdIQeaRFfcySWPWYyrL/W22/Cx0g2kejDR50o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IhDw8ejICOsCrYqndsjSVMWwDK8+1G3fWWuSVv8GxbbN3AQY
	3s56D06SZIlaR9gV+XEHvb58wV/My99NSiNccfgn5Ni3rKWyU4HuMQAfmJ6BMGU10W8=
X-Gm-Gg: ASbGncvuEAf1HmTFq92Ohvqlv+zUQHDkQq4lWdYO8Kva2se+Nv7ljqA6N7VC4nYeA1p
	KSGV2/EjSVZ8RzWslKZ3YYDS5UXs0wql6J6RbAuwUhWBquZDsS8R44DTcLrR+JEW4vsf0kY9QST
	CG3nN1TaoA0JBse8OXFVsxEu4JT6ZvWqMn6FIBe3zZ7PR68VxpmJxAAUMzOCRCnGwXojuWAgmCB
	4wgu+Qp0XcXyzlqFwcCu23stuM32+tLDGTBMHIJomKfq1ZI1XSAj0qHp90/mq/iF23fbCMjAStQ
	U/x0YxHoDqV//PT5zFvKFAi6ANaMw8bPGCGsjAmR5E3IVJCifNcbq108Bdwo12YbgQG81xZvc57
	N6PlFYBa3lIzGvhEshuxW5KIs0PNEcB7L1JUbO9Bz8CdfgunTrzlOUJ/tcQ7wWQvsVgVeU8FgOz
	XTJyJPlkavwihb/eKk6/CXKETtpPnehkTjCJjsPw==
X-Google-Smtp-Source: AGHT+IGTNhaBgPV94HpLwq3wxD5moGyXJBQ3HMvWngLRZxDRivXq6LV1O8EW9Wa5ai847X2dvYueZA==
X-Received: by 2002:a05:6a21:3283:b0:344:c254:d9ee with SMTP id adf61e73a8af0-348cd21bc02mr16031690637.45.1762153417086;
        Sun, 02 Nov 2025 23:03:37 -0800 (PST)
Received: from [100.82.90.5] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b95c44f7363sm7270941a12.6.2025.11.02.23.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 23:03:36 -0800 (PST)
Message-ID: <044e3f9a-3de2-4939-afff-3bb527eb024b@bytedance.com>
Date: Mon, 3 Nov 2025 15:03:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
To: Dev Jain <dev.jain@arm.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, hannes@cmpxchg.org
Cc: ryan.roberts@arm.com, hpa@zytor.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shakeel.butt@linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251103063718.90743-1-dev.jain@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20251103063718.90743-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dev,

On 11/3/25 2:37 PM, Dev Jain wrote:
> The implementation of CONFIG_PT_RECLAIM is completely contained in generic
> mm code. It depends on the RCU callback which will reclaim the pagetables -
> there is nothing arch-specific about that. So, enable this config for
> all architectures.

Thanks for doing this!

But unfortunately, not all architectures call tlb_remove_ptdesc() in
__pte_free_tlb(). Some architectures directly call pte_free() to
free PTE pages (without RCU).

We need to modify these architectures first, otherwise it will
lead to UAF. This approach is feasible because Hugh provides similar
support in pte_free_defer().

Enabling PT_RECLAIM on all architecture has always been on my
TODO list, but it's been blocked by other things. :(

Thanks,
Qi

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   arch/x86/Kconfig | 1 -
>   mm/Kconfig       | 5 +----
>   mm/pt_reclaim.c  | 2 +-
>   3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..5681308a5650 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -327,7 +327,6 @@ config X86
>   	select FUNCTION_ALIGNMENT_4B
>   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>   	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>   	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>   	select SCHED_SMT			if SMP
>   	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..903c37d02555 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>   config PT_RECLAIM
>   	bool "reclaim empty user page table pages"
>   	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> +	depends on MMU && SMP
>   	select MMU_GATHER_RCU_TABLE_FREE
>   	help
>   	  Try to reclaim empty user page table pages in paths other than munmap
> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
> index 7e9455a18aae..049e17f08c6a 100644
> --- a/mm/pt_reclaim.c
> +++ b/mm/pt_reclaim.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/hugetlb.h>
> -#include <asm-generic/tlb.h>
> +#include <asm/tlb.h>
>   #include <asm/pgalloc.h>
>   
>   #include "internal.h"


