Return-Path: <linux-kernel+bounces-779782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD7B2F8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01DC18886B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C731DDA4;
	Thu, 21 Aug 2025 12:44:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E831DDA2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780275; cv=none; b=F7Np6gVRTjwIWD5LJr1612jUu/JWVfCDwpWVmr07I/IYd8TOUkWA1W9SB0Po7Jd60v1h7ctgESA/+jwHnokoPkhy5tHyONyxNLJBiDVmcK2zR0dWZJ+1NqjnrYYpEsjlvcpatTzsiFpj+dnj0d1f0rpsucuSCze7pBuLW7sx264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780275; c=relaxed/simple;
	bh=JgAkO/7CkvUqQ9ODf3AhOe096pfeVuYElTBrWSd7cq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXA7+M+JS+MZSKrs3OXYkhpxZOlAqGfXwK10/97vWXVv60r8w0JJ0LViSBz5rvVa2Tl4K+5T4un7dUe2ktSAx/1JJhklsqoXwN/Xfm23lum75l6ajxmH+1Gx3+yAk3h26bWjr19OtavciwWRUwrKW5AOcaulWS3Ou35VwEHKOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F367C4CEED;
	Thu, 21 Aug 2025 12:44:33 +0000 (UTC)
Message-ID: <96148baf-f008-449b-988b-ea4f07d18528@redhat.com>
Date: Thu, 21 Aug 2025 14:44:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: tag kernel stack pages
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820202029.1909925-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
> Currently, we have no way to distinguish a kernel stack page from an
> unidentified page. Being able to track this information can be
> beneficial for optimizing kernel memory usage (i.e. analyzing
> fragmentation, location etc.). Knowing a page is being used for a kernel
> stack gives us more insight about pages that are certainly immovable and
> important to kernel functionality.

It's a very niche use case. Anything that's not clearly a folio or a 
special movable_ops page is certainly immovable. So we can identify 
pretty reliable what's movable and what's not.

Happy to learn how you would want to use that knowledge to reduce 
fragmentation. :)

So this reads a bit hand-wavy.

> 
> Add a new pagetype, and tag pages alongside the kernel stack accounting.
> Also, ensure the type is dumped to /proc/kpageflags and the page-types
> tool can find it.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   fs/proc/page.c                         |  3 ++-
>   include/linux/page-flags.h             |  5 +++++
>   include/uapi/linux/kernel-page-flags.h |  1 +
>   kernel/fork.c                          | 19 +++++++++++++++++--
>   tools/mm/page-types.c                  |  1 +
>   5 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 771e0b6bc630..46be207c5a02 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -201,7 +201,8 @@ u64 stable_page_flags(const struct page *page)
>   
>   	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
>   		u |= 1 << KPF_BUDDY;
> -
> +	if (folio_test_stack(folio))
> +		u |= 1 << KPF_KSTACK;
>   	if (folio_test_offline(folio))
>   		u |= 1 << KPF_OFFLINE;
>   	if (folio_test_pgtable(folio))
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d53a86e68c89..5ee6ffbdbf83 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -933,6 +933,7 @@ enum pagetype {
>   	PGTY_zsmalloc		= 0xf6,
>   	PGTY_unaccepted		= 0xf7,
>   	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_kstack		= 0xf9,
>   
>   	PGTY_mapcount_underflow = 0xff
>   };
> @@ -995,6 +996,10 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>   	page->page_type = UINT_MAX;					\
>   }
>   
> +/* PageStack() indicates that a page is used by kernel stacks.
> + */
> +PAGE_TYPE_OPS(Stack, kstack, stack)
> +
>   /*
>    * PageBuddy() indicates that the page is free and in the buddy system
>    * (see mm/page_alloc.c).
> diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
> index ff8032227876..56175b497ace 100644
> --- a/include/uapi/linux/kernel-page-flags.h
> +++ b/include/uapi/linux/kernel-page-flags.h
> @@ -36,5 +36,6 @@
>   #define KPF_ZERO_PAGE		24
>   #define KPF_IDLE		25
>   #define KPF_PGTABLE		26
> +#define KPF_KSTACK		27
>   
>   #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5115be549234..c8a6e1495acf 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -440,15 +440,22 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>   		struct vm_struct *vm_area = task_stack_vm_area(tsk);
>   		int i;
>   
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>   			mod_lruvec_page_state(vm_area->pages[i], NR_KERNEL_STACK_KB,
>   					      account * (PAGE_SIZE / 1024));
> +			__SetPageStack(vm_area->pages[i]);
> +		}
>   	} else {
>   		void *stack = task_stack_page(tsk);
> +		struct page *page = virt_to_head_page(stack);
> +		int i;
>   
>   		/* All stack pages are in the same node. */
>   		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>   				      account * (THREAD_SIZE / 1024));
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
> +			__SetPageStack(page);
>   	}
>   }
>   
> @@ -461,8 +468,16 @@ void exit_task_stack_account(struct task_struct *tsk)
>   		int i;
>   
>   		vm_area = task_stack_vm_area(tsk);
> -		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>   			memcg_kmem_uncharge_page(vm_area->pages[i], 0);
> +			__ClearPageStack(vm_area->pages[i]);
> +		}
> +	} else {
> +		struct page *page = virt_to_head_page(task_stack_page(tsk));
> +		int i;
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++, page++)
> +			__ClearPageStack(page);
>   	}
>   }

Note that exit_task_stack_account() stack calls 
account_kernel_stack(tsk, -1), where you would do a non-senical 
__SetPageStack() first.

... so this would better be done in account_kernel_stack() based on the 
"int account" flag.

But I wonder, if this should actually go to the actual place where we 
alloc/free.

Now that it's no longer required to clear page types when freeing, 
alloc_thread_stack_node() might be a better place to set it, and to 
leave it set until freed.

I'll leave Willy whether we actually want this type, cannot spot it 
under [1], but if we have sufficient types available, why not.

BUT

staring at [1], we allocate from vmalloc, so I would assume that these 
will be vmalloc-typed pages in the future and we cannot change the type 
later.


[1] https://kernelnewbies.org/MatthewWilcox/Memdescs

-- 
Cheers

David / dhildenb

