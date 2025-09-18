Return-Path: <linux-kernel+bounces-823135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F2B85A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE47481D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC230EF97;
	Thu, 18 Sep 2025 15:30:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5830EF86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209407; cv=none; b=MdoM4MtMDzKpDIWcXOR9sMv5ubGzAiXjbC+OKJk3AZlKBBJIiyHzzqx7FBFSjUTUBQNsfqFwXDctaOThMiklgQdbgyLS1Y24sfDpCVE/F5W3S9jhiXzP1js0XIcOnErL16im3PdaCN/C4U93BIcX2TMZdS69xIrVsnBagFwl1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209407; c=relaxed/simple;
	bh=TEx//e613YBG3XMaESjbwFhOqJQ5125+PthChFz465g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox8sY51aWdHq0u16c+nhxHgDWotbkzLQy5yZq0q/OkFi7Chw/3cVAQj09qzUwatP2k2g/c0xVS2l96CBPd4wRFtnk701nO8ISf6CXOiwAWUNBMIN+7La5rLa78X48igXutyh1MlOkYncrd25aPQiPTzDtjgDa68MOh91qiGznHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474C3176C;
	Thu, 18 Sep 2025 08:29:56 -0700 (PDT)
Received: from [10.1.33.171] (XHFQ2J9959.cambridge.arm.com [10.1.33.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563263F66E;
	Thu, 18 Sep 2025 08:30:02 -0700 (PDT)
Message-ID: <960fbbba-8018-4e42-b1fd-6ed96c148007@arm.com>
Date: Thu, 18 Sep 2025 16:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: kprobes: call set_memory_rox() for kprobe
 page
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-6-yang@os.amperecomputing.com>
 <aMv_nhEuCSHKp5J6@arm.com>
 <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/09/2025 16:05, Yang Shi wrote:
> 
> 
> On 9/18/25 5:48 AM, Catalin Marinas wrote:
>> On Wed, Sep 17, 2025 at 12:02:11PM -0700, Yang Shi wrote:
>>> The kprobe page is allocated by execmem allocator with ROX permission.
>>> It needs to call set_memory_rox() to set proper permission for the
>>> direct map too. It was missed.
>>>
>>> And the set_memory_rox() guarantees the direct map will be split if it
>>> needs so that set_direct_map calls in vfree() won't fail.
>>>
>>> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/
>>> kprobes.c
>>> index 0c5d408afd95..c4f8c4750f1e 100644
>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>> @@ -10,6 +10,7 @@
>>>     #define pr_fmt(fmt) "kprobes: " fmt
>>>   +#include <linux/execmem.h>
>>>   #include <linux/extable.h>
>>>   #include <linux/kasan.h>
>>>   #include <linux/kernel.h>
>>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>   static void __kprobes
>>>   post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs
>>> *);
>>>   +void *alloc_insn_page(void)
>>> +{
>>> +    void *page;
>> Nit: I'd call this 'addr'. 'page' makes me think of a struct page.
> 
> Sure.
> 
>>
>>> +
>>> +    page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>> +    if (!page)
>>> +        return NULL;
>>> +    set_memory_rox((unsigned long)page, 1);
>> It's unfortunate that we change the attributes of the ROX vmap first to
>> RO, then to back to ROX so that we get the linear map changed. Maybe
>> factor out some of the code in change_memory_common() to only change the
>> linear map.
> 
> I want to make sure I understand you correctly, you meant set_memory_rox()
> should do:
> 
> change linear map to RO (call a new helper, for example, set_direct_map_ro())
> change vmap to ROX (call change_memory_common())
> 
> Is it correct?
> 
> If so set_memory_ro() should do the similar thing.
> 
> And I think we should have the cleanup patch separate from this bug fix patch
> because the bug fix patch should be applied to -stable release too. Keeping it
> simpler makes the backport easier.
> 
> Shall I squash the cleanup patch into patch #1?


Personally I think we should drop this patch from the series and handle it
separately.

We worked out that the requirement is to either never call set_memory_*() or to
call set_memory_*() for the entire vmalloc'ed range prior to optionally calling
set_memory_*() for a sub-range in order to guarrantee vm_reset_perms() works
correctly.

Given this is only allocating a single page, it is impossible to call
set_memory_*() for a sub-range. So the requirement is met.

I agree it looks odd/wrong to have different permissions in the linear map vs
the vmap but that is an orthogonal bug that can be fixed separately.

What do you think?

Thanks,
Ryan


> 
> Thanks,
> Yang
> 
>>
>> Otherwise it looks fine.
>>
> 


