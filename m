Return-Path: <linux-kernel+bounces-873065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAFC12F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 407F14FEC52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE42D7DD8;
	Tue, 28 Oct 2025 05:32:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F72D6E66
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629556; cv=none; b=F6wSwoffg8bcfOpCAO9GZL/UqulQ4azILvZg0p8WAvq0AFpdmwGevSb+M1W2ubm2j47FjsLAqKkgxWbBJw7DmtXg+AuMQsaBBh9+M+WNr6JxVeInVrvMQ0bZMZFj2ydDXQdODrGx6Gw7JKiVVb3y9CehOVBWxzdZwcjm49HOh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629556; c=relaxed/simple;
	bh=AVJs8/xr1MjxEfZOPrkCEy0n1Y/vLPA82yoJKq3yMzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8DqrIxYcI4tX6e/v11apsOY4tm1qQIJhIcziC6b5iSMUOtqmZbrM9RMkyGrAjzlza0WYQv5BCch9TE3o2EUtQ1s+kFF0xaYxZFDB7O+hDISxq3zSfF8eztKVBA/BFr1Qwwm97deC1J1hDrsZ0/6F0XJ7IAb020gTyDJAsERHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18A41688;
	Mon, 27 Oct 2025 22:32:24 -0700 (PDT)
Received: from [10.166.150.28] (Mac.noida.arm.com [10.166.150.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC253F66E;
	Mon, 27 Oct 2025 22:32:25 -0700 (PDT)
Message-ID: <92327ea4-cd11-41d4-9a72-7040281e12af@arm.com>
Date: Tue, 28 Oct 2025 11:02:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: Optimize mremap() by PTE batching
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 mingo@kernel.org, libang.li@antgroup.com, maobibo@loongson.cn,
 zhengqi.arch@bytedance.com, baohua@kernel.org, anshuman.khandual@arm.com,
 willy@infradead.org, ioworker0@gmail.com, yang@os.amperecomputing.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hughd@google.com
References: <20250610035043.75448-1-dev.jain@arm.com>
 <20250610035043.75448-3-dev.jain@arm.com>
 <726dcb51-82a7-49a7-a8e5-49bc3eb05dcf@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <726dcb51-82a7-49a7-a8e5-49bc3eb05dcf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 28/10/25 3:10 am, David Hildenbrand wrote:
> On 10.06.25 05:50, Dev Jain wrote:
>> Use folio_pte_batch() to optimize move_ptes(). On arm64, if the ptes
>> are painted with the contig bit, then ptep_get() will iterate through 
>> all 16
>> entries to collect a/d bits. Hence this optimization will result in a 
>> 16x
>> reduction in the number of ptep_get() calls. Next, ptep_get_and_clear()
>> will eventually call contpte_try_unfold() on every contig block, thus
>> flushing the TLB for the complete large folio range. Instead, use
>> get_and_clear_full_ptes() so as to elide TLBIs on each contig block, 
>> and only
>> do them on the starting and ending contig block.
>>
>> For split folios, there will be no pte batching; nr_ptes will be 1. For
>> pagetable splitting, the ptes will still point to the same large folio;
>> for arm64, this results in the optimization described above, and for 
>> other
>> arches (including the general case), a minor improvement is expected 
>> due to
>> a reduction in the number of function calls.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/mremap.c | 39 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 180b12225368..18b215521ada 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -170,6 +170,23 @@ static pte_t move_soft_dirty_pte(pte_t pte)
>>       return pte;
>>   }
>>   +static int mremap_folio_pte_batch(struct vm_area_struct *vma, 
>> unsigned long addr,
>> +        pte_t *ptep, pte_t pte, int max_nr)
>> +{
>> +    const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>> +    struct folio *folio;
>> +
>> +    if (max_nr == 1)
>> +        return 1;
>> +
>> +    folio = vm_normal_folio(vma, addr, pte);
>> +    if (!folio || !folio_test_large(folio))
>> +        return 1;
>> +
>> +    return folio_pte_batch(folio, addr, ptep, pte, max_nr, flags, NULL,
>> +                   NULL, NULL);
>> +}
>
> Dev, I think there is another bug hiding in here. That function ignores
> the writable bit, which is not what you need here, in particular for
> anonymous folios in some cases.
>
> Later set_ptes() could end up marking ptes writable that were not 
> writable
> before, which is bad (at least for anonymous folios, maybe also for 
> pagecache
> folios).
>
> I think you really must respect the writable bit through something like
> FPB_RESPECT_WRITE.
>
> I patched out the "pte_batch_hint(ptep, pte) == 1" check we have upstream
> to make it reproduce on x86_64, but the following reproducer should 
> likely
> reproduce on aarch64 without further kernel modifications.

You are right. Thanks! I recall during the mremap/mprotect stuff I had 
completely

forgotten that batching by default ignores the writable bit and 
remembered it during

the last version of mprotect series :(


Thanks for giving a reproducer; for some reason I am unable to reproduce 
on my machine as-is.

In any case the bug is obvious and I'll send out a patch.


>
>
> # ./mremap
> BUG: Memory modified
>
>
> #define _GNU_SOURCE
> #include <stdint.h>
> #include <string.h>
> #include <stdbool.h>
> #include <x86intrin.h>
> #include <stdio.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <errno.h>
> #include <signal.h>
> #include <fcntl.h>
> #include <sys/wait.h>
>
> static size_t pagesize;
> static size_t thpsize;
> static int pagemap_fd;
>
> static uint64_t pagemap_get_entry(int fd, char *start)
> {
>         const unsigned long pfn = (unsigned long)start / getpagesize();
>         uint64_t entry;
>         int ret;
>
>         ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
>         if (ret != sizeof(entry)) {
>                 perror("reading pagemap failed");
>                 exit(-1);
>         }
>         return entry;
> }
>
> static bool pagemap_is_populated(int fd, char *start)
> {
>         return pagemap_get_entry(fd, start) & ((1ULL << 62) | (1ULL << 
> 63));
> }
>
> unsigned long pagemap_get_pfn(int fd, char *start)
> {
>         uint64_t entry = pagemap_get_entry(fd, start);
>
>         /* If present (63th bit), PFN is at bit 0 -- 54. */
>         if (entry & (1ULL << 63))
>                 return entry & 0x007fffffffffffffull;
>         return -1ul;
> }
>
> int main(void)
> {
>         char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
>         size_t size, mmap_size;
>         int ret;
>
>         pagesize = getpagesize();
>         thpsize = 2 * 1024 * 1024ul;
>         pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>         if (pagemap_fd < 0) {
>                 perror("opening pagemap failed");
>                 return -1;
>         }
>
>         /* For alignment purposes, we need twice the thp size. */
>         mmap_size = 2 * thpsize;
>         mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (mmap_mem == MAP_FAILED) {
>                 perror("mmap() failed");
>                 return -1;
>         }
>
>         /* We need a THP-aligned memory area. */
>         mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
>
>         ret = madvise(mem, thpsize, MADV_HUGEPAGE);
>         if (ret) {
>                 perror("MADV_HUGEPAGE failed");
>                 return -1;
>         }
>
>         /*
>          * Try to populate a THP. Touch the first sub-page and test if 
> we get
>          * another sub-page populated automatically.
>          */
>         mem[0] = 0;
>         if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
>                 perror("Did not get a THP populated");
>                 return -1;
>         }
>
>         /* Share only the first page of the THP. */
>         if (madvise(mem, pagesize, MADV_DONTFORK)) {
>                 perror("MADV_DONTFORK failed");
>                 return -1;
>         }
>
>         ret = fork();
>         if (ret < 0) {
>                 perror("fork() failed");
>                 return -1;
>         } else if (!ret) {
>                 while (true) {
>                         char c = *((volatile char *)(mem + pagesize));
>
>                         if (c) {
>                                 fprintf(stderr, "BUG: Memory 
> modified\n");
>                                 exit(-2);
>                         }
>                 }
>         }
>
>         /* Merge VMAs again. */
>         if (madvise(mem, pagesize, MADV_DOFORK)) {
>                 perror("MADV_DONTFORK failed");
>                 return -1;
>         }
>
>         /* Mremap multiple pages. */
>         mremap_mem = mmap(NULL, 2 * pagesize, PROT_NONE,
>                           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (mem == MAP_FAILED) {
>                 perror("mmap() failed");
>                 return -1;
>         }
>         tmp = mremap(mem, 2 * pagesize, 2 * pagesize, MREMAP_MAYMOVE | 
> MREMAP_FIXED,
>                      mremap_mem);
>         if (tmp != mremap_mem) {
>                 perror("mremap() failed");
>                 return -1;
>         }
>
>         /* Write into both pages. The child should never see these 
> updates. */
>         memset(mremap_mem, 1, 2 * pagesize);
>
>         pause();
> }
>

