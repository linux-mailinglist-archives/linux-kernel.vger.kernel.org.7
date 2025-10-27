Return-Path: <linux-kernel+bounces-872611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF26C1191F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995A81A20F89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C0317711;
	Mon, 27 Oct 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNCAotoY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F171F7586
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601264; cv=none; b=c95KOq14iM9Or5KvE3IUgiMiCjiLbnsK4PXJZnRs7weplYpYh8wQG/PbxJMtus0/iLizpNXFOQb9pZ82PXQQ5AHCv6jyXPux8BiLjdC/swOZEOgtRM4tBP77gwXwplK0WV41Tbx9jYwfZ9Db98Zg8wMnX18C7Kcdt2hLTb575+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601264; c=relaxed/simple;
	bh=dLT3B8ZA6Ht1bFv7Vb3gkMysy9Yskr654hM8aGJObAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb+Lr/hbKRheVqWkMm7HU/DD1i/IXuzTA66AL09P7uu9lACQgjHSAFJ/Wn98rXqnHhrxQSrHejdOEZv1mT3osrozMLonasrT4cUTV+ZylCE1zAModCXH7lrILJnWWFcT8ehCTMPyJqIYJoH5tdP9sj6MtsQDWuIsZSS/EMhIOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNCAotoY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761601260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XkjBBaXgpKGLfkvDiDitmNblMwUisvIpJlc3+fvkapA=;
	b=BNCAotoYjiShRwQJXTMf+dMDLcJOkaq8XwQEvm6c1G1BtHzg1SFaYIvufZvk7Iw2Aj5MvS
	lJ4/HkCZZDnnn7efjsIM3/m0+Hn/n32iwSVFIvBZxlIVvYvKN5y17RM0X1Exwle0TbJI3p
	hxGFgu4WwVi0k+tLeRs61hJmqdHQsRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-jxIY3PkzNAK45Q8zzToFrw-1; Mon, 27 Oct 2025 17:40:54 -0400
X-MC-Unique: jxIY3PkzNAK45Q8zzToFrw-1
X-Mimecast-MFC-AGG-ID: jxIY3PkzNAK45Q8zzToFrw_1761601253
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4298955a6d9so3925777f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601253; x=1762206053;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkjBBaXgpKGLfkvDiDitmNblMwUisvIpJlc3+fvkapA=;
        b=rvEWVegfhsGUU5Zj9R0bLU8Sjo7tgdOcgMfEefZCoLh3XTX8rSA60+Z+vKmrh53kAT
         fgdzFwERWbcGs3PvoxsnqWCIrf9JqI/N5jYAqQc86NqXzbqj4jzOSuNHI8VfbPU/0A+/
         7kuV0RAWGuq3C9xgE1doeIa99IH0xNlzR/MysvbrxzJtr0kavucqld7AZWlCeZGJ2gJW
         0su+zby3kaL37OBx2Lf986U/o/td4LogKKNQdHf9+0y8jN4+4mNhRdaXgwWyVTWQ33io
         N9A/GpA4lcr314dsvuM6ldOQUuuNsVbo8RC65Opt8z+oU7ivQIyK2QfgprH+rqx8Jddu
         92aA==
X-Forwarded-Encrypted: i=1; AJvYcCUV9nBT1ldoMD3ZKa/9T5X+B0XfBnkXHtWAKntfwqqqhYJ9iBUtywqStFURqg2L8BRwYwbnD3gQm2keksg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOzoBXyH1LHB/DFF78OIrKHOBOFVqVty76xFFk4KpmARnuWyP
	rvCapbXnEzaLBQBoQRYHJgC7v9S8MpoLES0MBaPxjwyDcf0+uY4YSkuw+Xrl/dBcX9MyOqWcmr9
	+1ZchFaMKb+beB/EHDvGE+6dnKtHHo3c+2+jH3ouwaIHIlkWFG/mdo9JAKzJIG4fxkg==
X-Gm-Gg: ASbGnctLCZkHuYSflR6Y5nfc1KJWznZaP15XIoyRz61QiRa6Y0fLMoOV8fQgUrl2q/2
	YIlHaSgjwRhIEB1zlYoD2OtnkgfVUQOikiRHRXr7Mb8kxMvm7sJLzr0aqccfNiaG6zKBNUj+/Di
	QoJy2zVY5RV5w/SHgZYNO/pPtH/qP+mromTgA/MfkOlQaldaWooXGbRxvwTX5Y+RhFjxeSfeC/H
	qpgd6IREB8ba5r4DJ6CPBW0dLHcxuJrBDsfMWa6xwmVW2nJKkkjBjS8FfG2ljNeMtnTM8VX8UoL
	fRNFlAtrMvwCRXzbSTyz/v13WCsbPZf6Y4YGgCaYKoYli7iUWsyrPpKK+XK2mnmFHjNeMWaOzDU
	+hnFjXBODT9OOED5HQRPGMf5JzNt/aUZGpbAVjzOdPwf88HcbjtBvnOo0mAAi8fUiXQL7/BdzfB
	oiovlzrC16Cj/RWIpYoInboMC7vF0=
X-Received: by 2002:a05:6000:1848:b0:426:d4f0:fc13 with SMTP id ffacd0b85a97d-429a7e91df9mr1034881f8f.50.1761601253290;
        Mon, 27 Oct 2025 14:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVHH/EU7h9KHXTO2YxY9StY8XKPGPrmbBP7flGxT0mdJo0M2AUzWdKHDS1fciN0obwq+KWIg==
X-Received: by 2002:a05:6000:1848:b0:426:d4f0:fc13 with SMTP id ffacd0b85a97d-429a7e91df9mr1034848f8f.50.1761601252769;
        Mon, 27 Oct 2025 14:40:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm16339288f8f.41.2025.10.27.14.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:40:50 -0700 (PDT)
Message-ID: <726dcb51-82a7-49a7-a8e5-49bc3eb05dcf@redhat.com>
Date: Mon, 27 Oct 2025 22:40:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: Optimize mremap() by PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 mingo@kernel.org, libang.li@antgroup.com, maobibo@loongson.cn,
 zhengqi.arch@bytedance.com, baohua@kernel.org, anshuman.khandual@arm.com,
 willy@infradead.org, ioworker0@gmail.com, yang@os.amperecomputing.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hughd@google.com
References: <20250610035043.75448-1-dev.jain@arm.com>
 <20250610035043.75448-3-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250610035043.75448-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 05:50, Dev Jain wrote:
> Use folio_pte_batch() to optimize move_ptes(). On arm64, if the ptes
> are painted with the contig bit, then ptep_get() will iterate through all 16
> entries to collect a/d bits. Hence this optimization will result in a 16x
> reduction in the number of ptep_get() calls. Next, ptep_get_and_clear()
> will eventually call contpte_try_unfold() on every contig block, thus
> flushing the TLB for the complete large folio range. Instead, use
> get_and_clear_full_ptes() so as to elide TLBIs on each contig block, and only
> do them on the starting and ending contig block.
> 
> For split folios, there will be no pte batching; nr_ptes will be 1. For
> pagetable splitting, the ptes will still point to the same large folio;
> for arm64, this results in the optimization described above, and for other
> arches (including the general case), a minor improvement is expected due to
> a reduction in the number of function calls.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/mremap.c | 39 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 180b12225368..18b215521ada 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -170,6 +170,23 @@ static pte_t move_soft_dirty_pte(pte_t pte)
>   	return pte;
>   }
>   
> +static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, pte_t pte, int max_nr)
> +{
> +	const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> +	struct folio *folio;
> +
> +	if (max_nr == 1)
> +		return 1;
> +
> +	folio = vm_normal_folio(vma, addr, pte);
> +	if (!folio || !folio_test_large(folio))
> +		return 1;
> +
> +	return folio_pte_batch(folio, addr, ptep, pte, max_nr, flags, NULL,
> +			       NULL, NULL);
> +}

Dev, I think there is another bug hiding in here. That function ignores
the writable bit, which is not what you need here, in particular for
anonymous folios in some cases.

Later set_ptes() could end up marking ptes writable that were not writable
before, which is bad (at least for anonymous folios, maybe also for pagecache
folios).

I think you really must respect the writable bit through something like
FPB_RESPECT_WRITE.

I patched out the "pte_batch_hint(ptep, pte) == 1" check we have upstream
to make it reproduce on x86_64, but the following reproducer should likely
reproduce on aarch64 without further kernel modifications.


# ./mremap
BUG: Memory modified


#define _GNU_SOURCE
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <x86intrin.h>
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/wait.h>

static size_t pagesize;
static size_t thpsize;
static int pagemap_fd;

static uint64_t pagemap_get_entry(int fd, char *start)
{
         const unsigned long pfn = (unsigned long)start / getpagesize();
         uint64_t entry;
         int ret;

         ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
         if (ret != sizeof(entry)) {
                 perror("reading pagemap failed");
                 exit(-1);
         }
         return entry;
}

static bool pagemap_is_populated(int fd, char *start)
{
         return pagemap_get_entry(fd, start) & ((1ULL << 62) | (1ULL << 63));
}

unsigned long pagemap_get_pfn(int fd, char *start)
{
         uint64_t entry = pagemap_get_entry(fd, start);

         /* If present (63th bit), PFN is at bit 0 -- 54. */
         if (entry & (1ULL << 63))
                 return entry & 0x007fffffffffffffull;
         return -1ul;
}

int main(void)
{
         char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
         size_t size, mmap_size;
         int ret;

         pagesize = getpagesize();
         thpsize = 2 * 1024 * 1024ul;
         pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
         if (pagemap_fd < 0) {
                 perror("opening pagemap failed");
                 return -1;
         }

         /* For alignment purposes, we need twice the thp size. */
         mmap_size = 2 * thpsize;
         mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (mmap_mem == MAP_FAILED) {
                 perror("mmap() failed");
                 return -1;
         }

         /* We need a THP-aligned memory area. */
         mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));

         ret = madvise(mem, thpsize, MADV_HUGEPAGE);
         if (ret) {
                 perror("MADV_HUGEPAGE failed");
                 return -1;
         }

         /*
          * Try to populate a THP. Touch the first sub-page and test if we get
          * another sub-page populated automatically.
          */
         mem[0] = 0;
         if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
                 perror("Did not get a THP populated");
                 return -1;
         }

         /* Share only the first page of the THP. */
         if (madvise(mem, pagesize, MADV_DONTFORK)) {
                 perror("MADV_DONTFORK failed");
                 return -1;
         }

         ret = fork();
         if (ret < 0) {
                 perror("fork() failed");
                 return -1;
         } else if (!ret) {
                 while (true) {
                         char c = *((volatile char *)(mem + pagesize));

                         if (c) {
                                 fprintf(stderr, "BUG: Memory modified\n");
                                 exit(-2);
                         }
                 }
         }

         /* Merge VMAs again. */
         if (madvise(mem, pagesize, MADV_DOFORK)) {
                 perror("MADV_DONTFORK failed");
                 return -1;
         }

         /* Mremap multiple pages. */
         mremap_mem = mmap(NULL, 2 * pagesize, PROT_NONE,
                           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (mem == MAP_FAILED) {
                 perror("mmap() failed");
                 return -1;
         }
         tmp = mremap(mem, 2 * pagesize, 2 * pagesize, MREMAP_MAYMOVE | MREMAP_FIXED,
                      mremap_mem);
         if (tmp != mremap_mem) {
                 perror("mremap() failed");
                 return -1;
         }

         /* Write into both pages. The child should never see these updates. */
         memset(mremap_mem, 1, 2 * pagesize);

         pause();
}

-- 
Cheers

David / dhildenb


