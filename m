Return-Path: <linux-kernel+bounces-802073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2DB44D59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FC8583D32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E8275864;
	Fri,  5 Sep 2025 05:20:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1B2D3A96
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049637; cv=none; b=qsfq2uHANOxqb3J57rLr5Oe61omJpbMhHgIRE6+SrijkaCwXfVICzkCtw22YkxuX2SQRUYhOe2fNZRd1GrIZFbQYIBZQplOJzQ+RI5BktQFU3JZKJV8M9w6czvcsGjVciY9XNYlyVCFFJ7nR4wGc3LxKOqcMER5zDqBj+herVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049637; c=relaxed/simple;
	bh=y4ZuibRa1gj1RmSKdbQKOlVlKioJzL1dXRJO+KlbKTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSMsM8IvblkFkXOMzCQRS3IJzlZE7j0qoNWIiRKo/BeD94Y/Fm2U+4bMwBGm1+GVq7rLu2Aai+S8QWXVLGiebyeE40iRqTzHLC8ZZHWvuSxgB2PAp4a1L7rRCVsfJZuj5cH2dnbKbnhR5NMy35tVdjaZEEj5MrRLAA4QOCDA2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cJ49T6rBWz9sS8;
	Fri,  5 Sep 2025 07:07:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2prVwxcUqBz; Fri,  5 Sep 2025 07:07:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cJ49T5lfZz9sRy;
	Fri,  5 Sep 2025 07:07:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A74128B774;
	Fri,  5 Sep 2025 07:07:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Oc7jo1la4Whs; Fri,  5 Sep 2025 07:07:56 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 292148B773;
	Fri,  5 Sep 2025 07:07:56 +0200 (CEST)
Message-ID: <7b3c83c1-bdf1-4778-948f-223ef0bce2a0@csgroup.eu>
Date: Fri, 5 Sep 2025 07:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/32: Remove PAGE_KERNEL_TEXT to fix startup
 failure
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Erhard Furtner <erhard_f@mailbox.org>
References: <342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org>
 <4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu>
 <68ba6bee.170a0220.3b821b.ca9d@mx.google.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <68ba6bee.170a0220.3b821b.ca9d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2025 à 05:55, Ritesh Harjani a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> PAGE_KERNEL_TEXT is an old macro that is used to tell kernel whether
>> kernel text has to be mapped read-only or read-write based on build
>> time options.
>>
>> But nowadays, with functionnalities like jump_labels, static links,
>> etc ... more only less all kernels need to be read-write at some
>> point, and some combinations of configs failed to work due to
>> innacurate setting of PAGE_KERNEL_TEXT. On the other hand, today
>> we have CONFIG_STRICT_KERNEL_RWX which implements a more controlled
>> access to kernel modifications.
>>
>> Instead of trying to keep PAGE_KERNEL_TEXT accurate with all
>> possible options that may imply kernel text modification, always
>> set kernel text read-write at startup and rely on
>> CONFIG_STRICT_KERNEL_RWX to provide accurate protection.
>>
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Closes: https://lore.kernel.org/all/342b4120-911c-4723-82ec-d8c9b03a8aef@mailbox.org/
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/pgtable.h | 12 ------------
>>   arch/powerpc/mm/book3s32/mmu.c     |  4 ++--
>>   arch/powerpc/mm/pgtable_32.c       |  2 +-
>>   3 files changed, 3 insertions(+), 15 deletions(-)
>>
> 
> AFAIU - mmu_mark_initmem_nx gets called during kernel_init() which is
> way after static call initialization correct? i.e.
> 
> start_kernel
>    ...
>    jump_label_init()
>    static_call_init()
>    ...
>    ...
>    rest_init()      /* Do the rest non-__init'ed, we're now alive */
>      kernel_init()
>        free_initmem() -> mark_initmem_nx() -> __mark_initmem_nx -> mmu_mark_initmem_nx()
>        mark_readonly()
>          if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && rodata_enabled) {
>             jump_label_init_ro()
>             mark_rodata_ro() -> ....
>             ...
>          ...
> 
> Then I guess we mainly only need __mapin_ram_chunk() to be PAGE_KERNEL_X (RWX)
> instead of PAGE_KERNEL_TEXT (ROX), isn't it?
> 
> Let me quickly validate it...
> ...Ok, so I was able to get just this diff to be working.
> 
> Thoughts?

setibat() doesn't take into account whether it is RO or RW. Only X or NX 
is taken into account, so it doesn't matter whether it is X or ROX.

Then allthough you are right in principle, once the PAGE_KERNEL_TEXT is 
removed from __mapin_ram_chunk() it becomes completely useless, so 
better get rid of PAGE_KERNEL_TEXT completely.

> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 15276068f657..0c9ef705803e 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>          p = memstart_addr + s;
>          for (; s < top; s += PAGE_SIZE) {
>                  ktext = core_kernel_text(v);
> -               map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
> +               map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
>                  v += PAGE_SIZE;
>                  p += PAGE_SIZE;
>          }
> 
> -ritesh
> 
> 
> 
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 93d77ad5a92f..d8f944a5a037 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -20,18 +20,6 @@ struct mm_struct;
>>   #include <asm/nohash/pgtable.h>
>>   #endif /* !CONFIG_PPC_BOOK3S */
>>   
>> -/*
>> - * Protection used for kernel text. We want the debuggers to be able to
>> - * set breakpoints anywhere, so don't write protect the kernel text
>> - * on platforms where such control is possible.
>> - */
>> -#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
>> -	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
>> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
>> -#else
>> -#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
>> -#endif
>> -
>>   /* Make modules code happy. We don't set RO yet */
>>   #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
>>   
>> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
>> index be9c4106e22f..c42ecdf94e48 100644
>> --- a/arch/powerpc/mm/book3s32/mmu.c
>> +++ b/arch/powerpc/mm/book3s32/mmu.c
>> @@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
>>   
>>   	for (i = 0; i < nb - 1 && base < top;) {
>>   		size = bat_block_size(base, top);
>> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
>> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>>   		base += size;
>>   	}
>>   	if (base < top) {
>> @@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
>>   				pr_warn("Some RW data is getting mapped X. "
>>   					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
>>   		}
>> -		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
>> +		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
>>   		base += size;
>>   	}
>>   	for (; i < nb; i++)
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 15276068f657..0c9ef705803e 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>>   	p = memstart_addr + s;
>>   	for (; s < top; s += PAGE_SIZE) {
>>   		ktext = core_kernel_text(v);
>> -		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
>> +		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
>>   		v += PAGE_SIZE;
>>   		p += PAGE_SIZE;
>>   	}
>> -- 
>> 2.49.0


