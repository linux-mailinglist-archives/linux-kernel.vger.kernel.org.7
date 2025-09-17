Return-Path: <linux-kernel+bounces-821576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F5B81AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7305829C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A13009CA;
	Wed, 17 Sep 2025 19:40:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A818D656
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138049; cv=none; b=tIw5M2lKwzjkwrLYuTpoygMzwpY98bmCmQhIcer25Zyne0LsTVpCmfIp7agoXKoXoAsU2HKWWvUV0NbJ2HVvAOIg2oQrXBxACFqtqhGp+FoaYkYFwZ+mu9iGLgkHTOUr1kjR12uB6pzU80pM5SmyjQW85S3QVlrnV4fuh3+q9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138049; c=relaxed/simple;
	bh=FCGXz0w7Rb4baiKk2KU8OhaYUbEnOpCe/h9+95S5IdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf0TnEPkd8i7URrmzFowOcrqCdvcmbuK7o0DEAgExvVDvdp+2M8F8dB3STLqprKz6rv75DZkxDddZhgwU4CjZ2KwxsqSzSdR/Wh2VVdujWeLg8y0LP+JV2LiqfHcD0fWxwY7BPe5pvKBcScaXhEVu4bHZcukYyoYOlxHqfGdmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803762696;
	Wed, 17 Sep 2025 12:40:38 -0700 (PDT)
Received: from [10.57.80.26] (unknown [10.57.80.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F053F3F694;
	Wed, 17 Sep 2025 12:40:44 -0700 (PDT)
Message-ID: <3cbda17c-4c1c-4c04-a1fe-bd6ea6714de8@arm.com>
Date: Wed, 17 Sep 2025 20:40:43 +0100
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
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
 <39c2f841-9043-448d-b644-ac96612d520a@os.amperecomputing.com>
 <d7cd4004-bacf-47b0-9cd8-f99125e02238@arm.com>
 <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
 <8c363997-7b8d-4b54-b9b0-1a1b6a0e58ed@arm.com>
 <4aa4eedc-550f-4538-a499-504dc925ffc2@os.amperecomputing.com>
 <1cfda234-1339-4d83-bd87-b219fbd72664@arm.com>
 <55a79826-48e3-41c0-8dbd-b6398e7e49a6@os.amperecomputing.com>
 <92719b15-daf8-484f-b0db-72e23ae696ad@os.amperecomputing.com>
 <e86e2aa5-c66c-41a9-a56d-74451df0d105@arm.com>
 <f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com>
 <047c0f7b-e46d-4a3f-8bc0-ce007eac36a7@arm.com>
 <45dc2746-153a-482d-954f-11fe1cd8d18e@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <45dc2746-153a-482d-954f-11fe1cd8d18e@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2025 20:15, Yang Shi wrote:
> 
> 
> On 9/17/25 11:58 AM, Ryan Roberts wrote:
>> On 17/09/2025 18:21, Yang Shi wrote:
>>>
>>> On 9/17/25 9:28 AM, Ryan Roberts wrote:
>>>> Hi Yang,
>>>>
>>>> Sorry for the slow reply; I'm just getting back to this...
>>>>
>>>> On 11/09/2025 23:03, Yang Shi wrote:
>>>>> Hi Ryan & Catalin,
>>>>>
>>>>> Any more concerns about this?
>>>> I've been trying to convince myself that your assertion that all users that set
>>>> the VM_FLUSH_RESET_PERMS also call set_memory_*() for the entire range that was
>>>> returned my vmalloc. I agree that if that is the contract and everyone is
>>>> following it, then there is no problem here.
>>>>
>>>> But I haven't been able to convince myself...
>>>>
>>>> Some examples (these might intersect with examples you previously raised):
>>>>
>>>> 1. bpf_dispatcher_change_prog() -> bpf_jit_alloc_exec() -> execmem_alloc() ->
>>>> sets VM_FLUSH_RESET_PERMS. But I don't see it calling set_memory_*() for
>>>> rw_image.
>>> Yes, it doesn't call set_memory_*(). I spotted this in the earlier email. But it
>>> is actually RW, so it should be ok to miss the call. The later
>>> set_direct_map_invalid call in vfree() may fail, but set_direct_map_default call
>>> will set RW permission back. But I think it doesn't have to use execmem_alloc(),
>>> the plain vmalloc() should be good enough.
>>>
>>>> 2. module_memory_alloc() -> execmem_alloc_rw() -> execmem_alloc() -> sets
>>>> VM_FLUSH_RESET_PERMS (note that execmem_force_rw() is nop for arm64).
>>>> set_memory_*() is not called until much later on in module_set_memory().
>>>> Another
>>>> error in the meantime could cause the memory to be vfreed before that point.
>>> IIUC, execmem_alloc_rw() is used to allocate memory for modules' text section
>>> and data section. The code will set mod->mem[type].is_rox according to the type
>>> of the section. It is true for text, false for data. Then set_memory_rox() will
>>> be called later if it is true *after* insns are copied to the memory. So it is
>>> still RW before that point.
>>>
>>>> 3. When set_vm_flush_reset_perms() is set for the range, it is called before
>>>> set_memory_*() which might then fail to split prior to vfree.
>>> Yes, all call sites check the return value and bail out if set_memory_*() failed
>>> if I don't miss anything.
>>>
>>>> But I guess as long as set_memory_*() is never successfully called for a
>>>> *sub-range* of the vmalloc'ed region, then for all of the above issues, the
>>>> memory must still be RW at vfree-time, so this issue should be benign... I
>>>> think?
>>> Yes, it is true.
>> So to summarise, all freshly vmalloc'ed memory starts as RW. set_memory_*() may
>> only be called if VM_FLUSH_RESET_PERMS has already been set. If set_memory_*()
>> is called at all, the first call MUST be for the whole range.
> 
> Whether the default permission is RW or not depends on the type passed in by
> execmem_alloc(). It is defined by execmem_info in arch/arm64/mm/init.c. For
> ARM64, module and BPF have PAGE_KERNEL permission (RW) by default, but kprobes
> is PAGE_KERNEL_ROX (ROX).

Perhaps I missed it, but as far as I could tell the prot that the arch sets for
the type only determines the prot that is set for the vmalloc map. It doesn't
look like the linear map is modified at all... which feels like a bug to me
since the linear map will be RW while the vmalloc map will be ROX... I guess I
must have missed something...

> 
>> If those requirements are all met, then if VM_FLUSH_RESET_PERMS was set but
>> set_memory_*() was never called, the worst that can happen is for both the
>> set_direct_map_invalid() and set_direct_map_default() calls to fail due to not
>> enough memory. But that is safe because the memory was always RW. If
>> set_memory_*() was called for the whole range and failed, it's the same as if it
>> was never called. If it was called for the whole range and succeeded, then the
>> split must have happened already and set_direct_map_invalid() and
>> set_direct_map_default() will therefore definitely succeed.
>>
>> The only way this could be a problem is if someone vmallocs a range then
>> performs a set_memory_*() on a sub-region without having first done it for the
>> whole region. But we have not found any evidence that there are any users that
>> do that.
> 
> Yes, exactly.
> 
>>
>> In fact, by that logic, I think alloc_insn_page() must also be safe; it only
>> allocates 1 page, so if set_memory_*() is subsequently called for it, it must by
>> definition be covering the whole allocation; 1 page is the smallest amount that
>> can be protected.
> 
> Yes, but kprobes default permission is ROX.
> 
>>
>> So I agree we are safe.
>>
>>
>>>> In summary this all looks horribly fragile. But I *think* it works. It would be
>>>> good to clean it all up and have some clearly documented rules regardless.
>>>> But I
>>>> think that could be a follow up series.
>>> Yeah, absolutely agreed.
>>>
>>>>> Shall we move forward with v8?
>>>> Yes; Do you wnat me to post that or would you prefer to do it? I'm happy to do
>>>> it; there are a few other tidy ups in pageattr.c I want to make which I
>>>> spotted.
>>> I actually just had v8 ready in my tree. I removed pageattr_pgd_entry and
>>> pageattr_pud_entry in pageattr.c and fixed pmd_leaf/pud_leaf as you suggested.
>>> Is it the cleanup you are supposed to do?
>> I was also going to fix up the comment in change_memory_common() which is now
>> stale.
> 
> Oops, I missed that in my v8. Please just comment for v8, I can fix it up later.

Ahh no biggy. If there is a chance Will will take the series, let's not hold it
up for a comment.

> 
> Thanks,
> Yang
> 
> 
>>
>>> And I also rebased it on top of
>>> Shijie's series (https://git.kernel.org/pub/scm/linux/kernel/git/arm64/
>>> linux.git/commit/?id=bfbbb0d3215f) which has been picked up by Will.
>>>
>>>>> We can include the
>>>>> fix to kprobes in v8 or I can send it separately, either is fine to me.
>>>> Post it on list, and I'll also incorporate into the series.
>>> I can include it in v8 series.
>>>
>>>>> Hopefully we can make v6.18.
>>>> It's probably getting a bit late now. Anyway, I'll aim to get v8 out
>>>> tomorrow or
>>>> Friday and we will see what Will thinks.
>>> Thank you. I can post v8 today.
>> OK great - I'll leave it all to you then - thanks!
>>
>>> Thanks,
>>> Yang
>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>> Thanks,
>>>>> Yang
>>>>>
> 


