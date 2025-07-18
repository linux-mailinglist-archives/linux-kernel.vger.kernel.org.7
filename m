Return-Path: <linux-kernel+bounces-736705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52128B0A0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644387ACB33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28E29E10F;
	Fri, 18 Jul 2025 10:36:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626B198A2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834971; cv=none; b=GOcmnaT7JPBigljDOII0VpwjBtctvnHVkgPC9JaxtAN2jL4e6o7fHYlLq8lV/d4yqNi+z6qyvBgI+YQCG7GnfUU1W404m0cbGN6IE5lQnyR7w/dvWprrbXtICg0wCKVGASeNWnXmVcN9H1Uzq3ZHExnCfkf0ADMR5q3AxhqWyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834971; c=relaxed/simple;
	bh=m3yGFkStv2dCYBfm0tFx+7tY/z6BYh+9F2TCemhKWcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAjVEh+x40yF3fGkrEd1jEDhGgGsYZBv+Au6Y3Ydd40b9N6sIcQ7imGEJSQx5WCB+gimakw6txENRiMHVPctnTuuLdfephdUTKYuI8nn8Qg3E+HVkqziF57qovI/GcAaJPe7UmzMl1G7PaokXOiUAB8s6Jj5dmMzyw+r6EiMKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AAE176C;
	Fri, 18 Jul 2025 03:35:56 -0700 (PDT)
Received: from [10.57.87.202] (unknown [10.57.87.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE213F694;
	Fri, 18 Jul 2025 03:36:00 -0700 (PDT)
Message-ID: <5f171093-93fc-4f86-98ef-048b15890e7c@arm.com>
Date: Fri, 18 Jul 2025 11:35:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: arm64: Map hyp text as RO and dump instr on
 panic
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
 maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com,
 keirf@google.com
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-3-smostafa@google.com>
 <38b08607-b9d9-425b-81c4-b227dda427b3@arm.com> <aHogf50CvjeSklRo@google.com>
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <aHogf50CvjeSklRo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mostafa,

On 18/07/2025 11:22, Mostafa Saleh wrote:
> Hi Ben,
> 
> On Fri, Jul 18, 2025 at 11:16:18AM +0100, Ben Horgan wrote:
>> Hi Mostafa,
>>
>> On 18/07/2025 00:47, Mostafa Saleh wrote:
>>> Map the hyp text section as RO, there are no secrets there
>>> and that allows the kernel extract info for debugging.
>>>
>>> As in case of panic we can now dump the faulting instructions
>>> similar to the kernel.
>>>
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>    arch/arm64/kvm/handle_exit.c    |  4 +---
>>>    arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
>>>    2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>>> index de12b4d4bccd..d59f33c40767 100644
>>> --- a/arch/arm64/kvm/handle_exit.c
>>> +++ b/arch/arm64/kvm/handle_exit.c
>>> @@ -566,9 +566,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>>>    	kvm_nvhe_dump_backtrace(hyp_offset);
>>>    	/* Dump the faulting instruction */
>>> -	if (!is_protected_kvm_enabled() ||
>>> -	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
>>> -		dump_instr(panic_addr + kaslr_offset());
>>> +	dump_instr(panic_addr + kaslr_offset());
>> This makes the dumping in nvhe no longer conditional on
>> CONFIG_NVHE_EL2_DEBUG. A change from what you introduced in the patch.
>> Perhaps it makes sense to reorder the patches; do the preparatory work for
>> instruction dumping before the enabling.>
> 
> Yes, I thought about squashing both patches, but I was worried this patch
> might be more controversial, so I split the code into 2 patches, where the
> first one can be merged separately if needed. But no strong opinion.

My concern was you were changing the non-pkvm case too in this patch but 
I see now that you weren't. Sorry, my mistake. I'm ok with this patch 
split.>
> Thanks,
> Mostafa
> 
>>>    	/*
>>>    	 * Hyp has panicked and we're going to handle that by panicking the
>>> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
>>> index a48d3f5a5afb..90bd014e952f 100644
>>> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
>>> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
>>> @@ -192,6 +192,7 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>>>    	enum pkvm_page_state state;
>>>    	struct hyp_page *page;
>>>    	phys_addr_t phys;
>>> +	enum kvm_pgtable_prot prot;
>>>    	if (!kvm_pte_valid(ctx->old))
>>>    		return 0;
>>> @@ -210,11 +211,18 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>>>    	 * configured in the hypervisor stage-1, and make sure to propagate them
>>>    	 * to the hyp_vmemmap state.
>>>    	 */
>>> -	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
>>> +	prot = kvm_pgtable_hyp_pte_prot(ctx->old);
>>> +	state = pkvm_getstate(prot);
>>>    	switch (state) {
>>>    	case PKVM_PAGE_OWNED:
>>>    		set_hyp_state(page, PKVM_PAGE_OWNED);
>>> -		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
>>> +		/* hyp text is RO in the host stage-2 to be inspected on panic. */
>>> +		if (prot == PAGE_HYP_EXEC) {
>>> +			set_host_state(page, PKVM_NOPAGE);
>>> +			return host_stage2_idmap_locked(phys, PAGE_SIZE, KVM_PGTABLE_PROT_R);
>>> +		} else {
>>> +			return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
>>> +		}
>>>    	case PKVM_PAGE_SHARED_OWNED:
>>>    		set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
>>>    		set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
>> -- 
>> Thanks,
>>
>> Ben
>>
Thanks,

Ben


