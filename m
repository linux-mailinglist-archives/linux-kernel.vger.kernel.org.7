Return-Path: <linux-kernel+bounces-808426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850A9B4FF94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D94160ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B834A314;
	Tue,  9 Sep 2025 14:36:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8128322DBD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428581; cv=none; b=QWj5SfIBHUPHXaUA505jQyIc6ELuzEnqlgSBfx/yl63G2tMlhKwhhbX3/ecCYx4mxUadL7TgQjTyvUc1zjG7MLRLHZl6Q5VhE6d00h6NY+AF3bLGisk9lMKcWMRzm/dtFBdz6DF5hBmg5mY1ONZ3Wg8SuhqZGIyaY75vaniFs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428581; c=relaxed/simple;
	bh=1Umuf4upW+1VXFRm4vnDYX56KY3jeasenowD3GeyOmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guuw625/dJp+4Ba68eovEAcFZILaGiO1hpoVFjYkw+E25sc1m+74CzZ+ggFdwj+gQQmnTM21pkXtZ1L9ozex8aCIyfKbwm6w2T+yE1Nb79I69oD6m/pilRf+e5dzhW1HtXUf3RqQHCnv1KoaRxkzLbDN0kd6CkEB9Ea3W4Sk01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DE7B1424;
	Tue,  9 Sep 2025 07:36:09 -0700 (PDT)
Received: from [10.1.33.194] (unknown [10.1.33.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64A9D3F66E;
	Tue,  9 Sep 2025 07:36:16 -0700 (PDT)
Message-ID: <8c363997-7b8d-4b54-b9b0-1a1b6a0e58ed@arm.com>
Date: Tue, 9 Sep 2025 15:36:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
 <39c2f841-9043-448d-b644-ac96612d520a@os.amperecomputing.com>
 <d7cd4004-bacf-47b0-9cd8-f99125e02238@arm.com>
 <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/09/2025 19:31, Yang Shi wrote:
> 
> 
> On 9/8/25 9:34 AM, Ryan Roberts wrote:
>> On 04/09/2025 22:49, Yang Shi wrote:
>>>
>>> On 9/4/25 10:47 AM, Yang Shi wrote:
>>>>
>>>> On 9/4/25 6:16 AM, Ryan Roberts wrote:
>>>>> On 04/09/2025 14:14, Ryan Roberts wrote:
>>>>>> On 03/09/2025 01:50, Yang Shi wrote:
>>>>>>>>>> I am wondering whether we can just have a warn_on_once or something
>>>>>>>>>> for the
>>>>>>>>>> case
>>>>>>>>>> when we fail to allocate a pagetable page. Or, Ryan had
>>>>>>>>>> suggested in an off-the-list conversation that we can maintain a cache
>>>>>>>>>> of PTE
>>>>>>>>>> tables for every PMD block mapping, which will give us
>>>>>>>>>> the same memory consumption as we do today, but not sure if this is
>>>>>>>>>> worth it.
>>>>>>>>>> x86 can already handle splitting but due to the callchains
>>>>>>>>>> I have described above, it has the same problem, and the code has been
>>>>>>>>>> working
>>>>>>>>>> for years :)
>>>>>>>>> I think it's preferable to avoid having to keep a cache of pgtable memory
>>>>>>>>> if we
>>>>>>>>> can...
>>>>>>>> Yes, I agree. We simply don't know how many pages we need to cache, and it
>>>>>>>> still can't guarantee 100% allocation success.
>>>>>>> This is wrong... We can know how many pages will be needed for splitting
>>>>>>> linear
>>>>>>> mapping to PTEs for the worst case once linear mapping is finalized. But it
>>>>>>> may
>>>>>>> require a few hundred megabytes memory to guarantee allocation success. I
>>>>>>> don't
>>>>>>> think it is worth for such rare corner case.
>>>>>> Indeed, we know exactly how much memory we need for pgtables to map the
>>>>>> linear
>>>>>> map by pte - that's exactly what we are doing today. So we _could_ keep a
>>>>>> cache.
>>>>>> We would still get the benefit of improved performance but we would lose the
>>>>>> benefit of reduced memory.
>>>>>>
>>>>>> I think we need to solve the vm_reset_perms() problem somehow, before we can
>>>>>> enable this.
>>>>> Sorry I realise this was not very clear... I am saying I think we need to
>>>>> fix it
>>>>> somehow. A cache would likely work. But I'd prefer to avoid it if we can
>>>>> find a
>>>>> better solution.
>>>> Took a deeper look at vm_reset_perms(). It was introduced by commit
>>>> 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions"). The
>>>> VM_FLUSH_RESET_PERMS flag is supposed to be set if the vmalloc memory is RO
>>>> and/or ROX. So set_memory_ro() or set_memory_rox() is supposed to follow up
>>>> vmalloc(). So the page table should be already split before reaching vfree().
>>>> I think this why vm_reset_perms() doesn't not check return value.
>> If vm_reset_perms() is assuming it can't/won't fail, I think it should at least
>> output a warning if it does?
> 
> It should. Anyway warning will be raised if split fails. We have somehow
> mitigation.
> 
>>
>>>> I scrutinized all the callsites with VM_FLUSH_RESET_PERMS flag set.
>> Just checking; I think you made a comment before about there only being a few
>> sites that set VM_FLUSH_RESET_PERMS. But one of them is the helper,
>> set_vm_flush_reset_perms(). So just making sure you also followed to the places
>> that use that helper?
> 
> Yes, I did.
> 
>>
>>>> The most
>>>> of them has set_memory_ro() or set_memory_rox() followed.
>> And are all callsites calling set_memory_*() for the entire cell that was
>> allocated by vmalloc? If there are cases where it only calls that for a portion
>> of it, then it's not gurranteed that the memory is correctly split.
> 
> Yes, all callsites call set_memory_*() for the entire range.
> 
>>
>>>> But there are 3
>>>> places I don't see set_memory_ro()/set_memory_rox() is called.
>>>>
>>>> 1. BPF trampoline allocation. The BPF trampoline calls
>>>> arch_protect_bpf_trampoline(). The generic implementation does call
>>>> set_memory_rox(). But the x86 and arm64 implementation just simply return 0.
>>>> For x86, it is because execmem cache is used and it does call
>>>> set_memory_rox(). ARM64 doesn't need to split page table before this series,
>>>> so it should never fail. I think we just need to use the generic
>>>> implementation (remove arm64 implementation) if this series is merged.
>> I know zero about BPF. But it looks like the allocation happens in
>> arch_alloc_bpf_trampoline(), which for arm64, calls bpf_prog_pack_alloc(). And
>> for small sizes, it grabs some memory from a "pack". So doesn't this mean that
>> you are calling set_memory_rox() for a sub-region of the cell, so that doesn't
>> actually help at vm_reset_perms()-time?
> 
> Took a deeper look at bpf pack allocator. The "pack" is allocated by
> alloc_new_pack(), which does:
> bpf_jit_alloc_exec()
> set_vm_flush_reset_perms()
> set_memory_rox()
> 
> If the size is greater than the pack size, it calls:
> bpf_jit_alloc_exec()
> set_vm_flush_reset_perms()
> set_memory_rox()
> 
> So it looks like bpf trampoline is good, and we don't need do anything. It
> should be removed from the list. I didn't look deep enough for bpf pack
> allocator in the first place.
> 
>>
>>>> 2. BPF dispatcher. It calls execmem_alloc which has VM_FLUSH_RESET_PERMS set.
>>>> But it is used for rw allocation, so VM_FLUSH_RESET_PERMS should be
>>>> unnecessary IIUC. So it doesn't matter even though vm_reset_perms() fails.
>>>>
>>>> 3. kprobe. S390's alloc_insn_page() does call set_memory_rox(), x86 also
>>>> called set_memory_rox() before switching to execmem cache. The execmem cache
>>>> calls set_memory_rox(). I don't know why ARM64 doesn't call it.
>>>>
>>>> So I think we just need to fix #1 and #3 per the above analysis. If this
>>>> analysis look correct to you guys, I will prepare two patches to fix them.
>> This all seems quite fragile. I find it interesting that vm_reset_perms() is
>> doing break-before-make; it sets the PTEs as invalid, then flushes the TLB, then
>> sets them to default. But for arm64, at least, I think break-before-make is not
>> required. We are only changing the permissions so that can be done on live
>> mappings; essentially change the sequence to; set default, flush TLB.
> 
> Yeah, I agree it is a little bit fragile. I think this is the "contract" for
> vmalloc users. You allocate ROX memory via vmalloc, you are required to call
> set_memory_*(). But there is nothing to guarantee the "contract" is followed.
> But I don't think this is the only case in kernel.
> 
>>
>> If we do that, then if the memory was already default, then there is no need to
>> do anything (so no chance of allocation failure). If the memory was not default,
>> then it must have already been split to make it non-default, in which case we
>> can also gurrantee that no allocations are required.
>>
>> What am I missing?
> 
> The comment says:
> Set direct map to something invalid so that it won't be cached if there are any
> accesses after the TLB flush, then flush the TLB and reset the direct map
> permissions to the default.
> 
> IIUC, it guarantees the direct map can't be cached in TLB after TLB flush from
> _vm_unmap_aliases() by setting them invalid because TLB never cache invalid
> entries. Skipping set direct map to invalid seems break this. Or "changing
> permission on live mappings" on ARM64 can achieve the same goal?

Here's my understanding of the intent of the code:

Let's say we start with some memory that has been mapped RO. Our goal is to
reset the memory back to RW and ensure that no TLB entry remains in the TLB for
the old RO mapping. There are 2 ways to do that:

Approach 1 (used in current code):
1. set PTE to invalid
2. invalidate any TLB entry for the VA
3. set the PTE to RW

Approach 2:
1. set the PTE to RW
2. invalidate any TLB entry for the VA

The benefit of approach 1 is that it is guarranteed that it is impossible for
different CPUs to have different translations for the same VA in their
respective TLB. But for approach 2, it's possible that between steps 1 and 2, 1
CPU has a RO entry and another CPU has a RW entry. But that will get fixed once
the TLB is flushed - it's not really an issue.

(There is probably also an obscure way to end up with 2 TLB entries (one with RO
and one with RW) for the same CPU, but the arm64 architecture permits that as
long as it's only a permission mismatch).

Anyway, approach 2 is used when changing memory permissions on user mappings, so
I don't see why we can't take the same approach here. That would solve this
whole class of issue for us.

Thanks,
Ryan


> 
> Thanks,
> Yang
> 
>> Thanks,
>> Ryan
>>
>>
>>> Tested the below patch with bpftrace kfunc (allocate bpf trampoline) and
>>> kprobes. It seems work well.
>>>
>>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/
>>> kprobes.c
>>> index 0c5d408afd95..c4f8c4750f1e 100644
>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>> @@ -10,6 +10,7 @@
>>>
>>>   #define pr_fmt(fmt) "kprobes: " fmt
>>>
>>> +#include <linux/execmem.h>
>>>   #include <linux/extable.h>
>>>   #include <linux/kasan.h>
>>>   #include <linux/kernel.h>
>>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>   static void __kprobes
>>>   post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs
>>> *);
>>>
>>> +void *alloc_insn_page(void)
>>> +{
>>> +       void *page;
>>> +
>>> +       page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>> +       if (!page)
>>> +               return NULL;
>>> +       set_memory_rox((unsigned long)page, 1);
>>> +       return page;
>>> +}
>>> +
>>>   static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>   {
>>>          kprobe_opcode_t *addr = p->ainsn.xol_insn;
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> index 52ffe115a8c4..3e301bc2cd66 100644
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>> @@ -2717,11 +2717,6 @@ void arch_free_bpf_trampoline(void *image, unsigned int
>>> size)
>>>          bpf_prog_pack_free(image, size);
>>>   }
>>>
>>> -int arch_protect_bpf_trampoline(void *image, unsigned int size)
>>> -{
>>> -       return 0;
>>> -}
>>> -
>>>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>>>                                  void *ro_image_end, const struct
>>> btf_func_model *m,
>>>                                  u32 flags, struct bpf_tramp_links *tlinks,
>>>
>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Ryan
>>>>>>
>>>>>>> Thanks,
>>>>>>> Yang
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Yang
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Ryan
>>>>>>>>>
>>>>>>>>>
> 


