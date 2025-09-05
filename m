Return-Path: <linux-kernel+bounces-803099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869BB45A89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D28C1BC4D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC853705A2;
	Fri,  5 Sep 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wh9iY/Qv"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1035E4F4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082612; cv=none; b=qVHCdTQqgdiU4/P1Pp2bV2JAzmX3BMqxRelI/yN/nu4vr7KwRTDC8NaLpUPNxGOxJqRU72OfWKKcyzZJtkDAD+hxgJIcmKrascAWRUT4nZgfWDPg6xI8esHiV2TwTIOvZsuXODHi+uknkjKlEs1VjtEw77lVWS2PV7JfTyiwRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082612; c=relaxed/simple;
	bh=8za7Led7D4aJfemB4PVED3Zs6Yn9ydiPIUGtGx6Zjn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkxNSd19ebNDPeT1yeNqTacIrj9Q4VUgg10NoAsRekE5s6S920VqE+cLADxQz4wU0vUERRlHJldPgEfqmcSrPfTwYvbZgFEh4QmANLWF35L7Y+fg5dADcC6SxGPKvpwpw6XKa/ROFaN5ySGUffvavSlcqOx11/qoQCQlUVDKAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wh9iY/Qv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJJf56Q90z9sTl;
	Fri,  5 Sep 2025 16:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757082605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev4jgj8g0fTNZJltLUp+cJJPga8rWwR8rDlO94sZYmI=;
	b=wh9iY/QvbGvwg28pN/htEhvEiWKV2zp9ojU3BF39AiKc1X+fq9ANWtEHWntHkW4PY78st2
	vFbr3XsShutGe/ye/N/o0Ml/ynD+GZ53HefAP/7Py6wG/25KSrNK8wno1k3ss8ADPaEQHA
	itTsE27PiSnMDJtkkcqvIHLuLk+JdgJ6Xn2PEiB/Zum+sz2Icx8XZlNdknxu5K7OdFeuJf
	iv/2/U7zg7y7wcKEF2cRkJ4zckjRug7O5ftGKw1Bj1LfXjn2/RbEJDg7SaiUy5UKCGk8OZ
	ifUjqKIetJzWHMIXaCUGT7Q81iUxsqV9rrmbO0BHKMPMPLwtNQZ5vCKQKt9IEA==
Message-ID: <8918c4b9-5156-4b9a-83cb-d1d4856ae48d@mailbox.org>
Date: Fri, 5 Sep 2025 16:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup
 failure
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Donnellan <ajd@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org>
 <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1ysqxpzg7idqdqmdink5xg9ag6hqs4sn
X-MBO-RS-ID: c4f9d3b81d940f5d21c

On 9/4/25 18:33, Christophe Leroy wrote:
> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
> kernel text has to be mapped read-only or read-write based on build
> time options.
> 
> But nowadays, with functionnalities like jump_labels, static links,
> etc ... more only less all kernels need to be read-write at some
> point, and some combinations of configs failed to work due to
> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
> access to kernel modifications.
> 
> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
> possible options that may imply kernel text modification, always
> set kernel text read-write at startup and rely on
> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.

I can confirm your patch fixes the startup failure for my G4 .config. 
Thanks!

Regards,
Erhard

> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org/
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/include/asm/pgtable.h | 12 ------------
>   arch/powerpc/mm/book3s32/mmu.c     |  4 ++--
>   arch/powerpc/mm/pgtable_32.c       |  2 +-
>   3 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 93d77ad5a92f..d8f944a5a037 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -20,18 +20,6 @@ struct mm_struct;
>   #include <asm/nohash/pgtable.h>
>   #endif /* !CONFIG_PPC_BOOK3S */
>   
> -/*
> - * Protection used for kernel text. We want the debuggers to be able to
> - * set breakpoints anywhere, so don't write protect the kernel text
> - * on platforms where such control is possible.
> - */
> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> -#else
> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> -#endif
> -
>   /* Make modules code happy. We don't set RO yet */
>   #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
>   
> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
> index be9c4106e22f..c42ecdf94e48 100644
> --- a/arch/powerpc/mm/book3s32/mmu.c
> +++ b/arch/powerpc/mm/book3s32/mmu.c
> @@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
>   
>   	for (i = 0; i < nb - 1 && base < top;) {
>   		size = bat_block_size(base, top);
> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>   		base += size;
>   	}
>   	if (base < top) {
> @@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
>   				pr_warn("Some RW data is getting mapped X. "
>   					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
>   		}
> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>   		base += size;
>   	}
>   	for (; i < nb; i++)
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 15276068f657..0c9ef705803e 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>   	p = memstart_addr + s;
>   	for (; s < top; s += PAGE_SIZE) {
>   		ktext = core_kernel_text(v);
> -		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
> +		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
>   		v += PAGE_SIZE;
>   		p += PAGE_SIZE;
>   	}


