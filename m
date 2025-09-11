Return-Path: <linux-kernel+bounces-811700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7929B52CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A0E3B1E65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953CB2E8B62;
	Thu, 11 Sep 2025 09:10:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179E2E8894
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581819; cv=none; b=bMVMfhzjXtySD/P/nalrRMUNjH0WomxgnpAZosaJKFfWiLXrwHPabr/EU9SlOzPNkGsFhiOlYWXfDLiuUrOJKnJpfrTkMk+vRYQOk1ieKOTg3/A/1wpa4ysNbdxdF0Pfnh7nqPv08UYKBZnjHkQtPMljscUAB7kywYKQn5tkC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581819; c=relaxed/simple;
	bh=Di0qckkiILABfPBUA/UucUE/MxrbBO3qar4bS40BEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY+jkwBhy3E93mIRerg+KF5gX9WPCpyKVfSBGRjULWxMgrKEEG4/CdnpqKvyglZen8H9y0gjOyUEtdHPIXhA03H9JOWInsj5yi0450gruObZriGWREg3jlQKR4Djt/2ZSzHPcTFTHZcQVgUYAfCToakYDGjatZ65fbN8t8ZnCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38ED9153B;
	Thu, 11 Sep 2025 02:10:05 -0700 (PDT)
Received: from [10.57.70.14] (unknown [10.57.70.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457633F694;
	Thu, 11 Sep 2025 02:10:11 -0700 (PDT)
Message-ID: <eb8bd2da-48be-4c4e-bf52-48ea1718e02b@arm.com>
Date: Thu, 11 Sep 2025 11:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
To: Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20250910104454.317067-1-kevin.brodsky@arm.com>
 <41f3227e-b945-4303-90b7-732affb0a101@arm.com>
 <CAMj1kXEmfCHpssFjn_+4ZjKCUaWPeiVwznCpGumTfz33k-rfkg@mail.gmail.com>
 <f8c268ce-798a-4d3a-bab2-16eea633f9db@arm.com>
 <CAMj1kXHDKGsaOn96zecba=-6Bib0SVYs=voMr5DLjWOn_qAqAQ@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CAMj1kXHDKGsaOn96zecba=-6Bib0SVYs=voMr5DLjWOn_qAqAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 08:24, Ard Biesheuvel wrote:
> On Thu, 11 Sept 2025 at 08:18, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>> On 11/09/25 11:38 AM, Ard Biesheuvel wrote:
>>> On Thu, 11 Sept 2025 at 07:13, Anshuman Khandual
>>> <anshuman.khandual@arm.com> wrote:
>>>>
>>>>
>>>> On 10/09/25 4:14 PM, Kevin Brodsky wrote:
>>>>> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
>>>>> mmu.c without matching declaration in a header; instead cpufeature.c
>>>>> makes its own declaration. This is clearly not pretty, and as commit
>>>>> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
>>>>> function signature") showed, it also makes it very easy for the
>>>>> prototypes to go out of sync.
>>>>>
>>>>> All this would be much simpler if kpti_install_ng_mappings() and
>>>>> associated functions lived in mmu.c, where they logically belong.
>>>>> This is what this patch does:
>>>>> - Move kpti_install_ng_mappings() and associated functions from
>>>>>   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
>>>>> - Make create_kpti_ng_temp_pgd() a static function that simply calls
>>>>>   __create_pgd_mapping_locked() instead of aliasing it
>>>>> - Mark all these functions __init
>>>>> - Move __initdata after kpti_ng_temp_alloc (as suggested by
>>>>>   checkpatch)
>>>>>
>>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>>> ---
>>>>> Note: as things stand, create_kpti_ng_temp_pgd() could be removed,
>>>>> but a separate patch [1] will make use of it to add an
>>>>> assertion.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20250813145607.1612234-3-chaitanyas.prakash@arm.com/
>>>>> ---
>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Kees Cook <kees@kernel.org>,
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/mmu.h   |   6 ++
>>>>>  arch/arm64/kernel/cpufeature.c |  97 ------------------------------
>>>>>  arch/arm64/mm/mmu.c            | 106 ++++++++++++++++++++++++++++++---
>>>>>  3 files changed, 103 insertions(+), 106 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>>>> index 49f1a810df16..624edd6c4964 100644
>>>>> --- a/arch/arm64/include/asm/mmu.h
>>>>> +++ b/arch/arm64/include/asm/mmu.h
>>>>> @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
>>>>>       return true;
>>>>>  }
>>>>>
>>>>> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>>> +void kpti_install_ng_mappings(void);
>>>> Could the declarations be moved here instead ?
>>> Why?
>> To avoid both typedef and external instance declaration in the C
>> code even though there is just a single call site in there.
> But why would we want to avoid those in the first place?
>
> Moving these into mmu.h pollutes the global namespace with
> declarations that must never be used outside of
> __kpti_install_ng_mappings() to begin with.

That makes sense to me - no need for these declarations to be in a
header as they're implementation details of
__kpti_install_ng_mappings(). What is more common is to have them at the
top-level in the .c file instead of inside a function, but I think
either way is fine.

- Kevin

