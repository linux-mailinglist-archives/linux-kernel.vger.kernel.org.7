Return-Path: <linux-kernel+bounces-745697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885CB11D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5FAE1866
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E32E5B14;
	Fri, 25 Jul 2025 11:09:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1842E4271
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441754; cv=none; b=IInxY3oMBKZ1gMOQbbtP/ltaF8o4iqVXTjR6kpbz6ATMWNqskvnNhsbJECa7zMlfsr+dqEpzvPmzIMKUlAwOtNptFtmMKTvAyDLbMTIMIGtD3Eh8PRb6K9qOoQFwxPZCHBlm3q6UpQmJqZ+XyEfTO1KNCZinHltO66kF8/DJoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441754; c=relaxed/simple;
	bh=41qyMRFeDX/9ZjBOVyEdbFVyEI6JUauBcTIF4RaSXv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AglEz4MLcxn5YZz/vlTrPYlply8v44swmZP8m5YvEZhXuIC7TwNlHZCHSxcdLm+cBHkgPba+kBDsI0pJxrUV3lAxMCvouxi0KO+vLkOooI17Xe9Nwd0Wekig4naEnsNtD0C8qfjwgC6To5egqrAzHO+ABSWgqmebZuafGLrddUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F389C1756;
	Fri, 25 Jul 2025 04:08:59 -0700 (PDT)
Received: from [10.57.31.179] (unknown [10.57.31.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E0053F66E;
	Fri, 25 Jul 2025 04:09:05 -0700 (PDT)
Message-ID: <9765ba29-91e1-42bd-bb46-14fdce7284fe@arm.com>
Date: Fri, 25 Jul 2025 12:09:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: acpi: Enable ACPI CCEL support
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 sami.mujawar@arm.com, aneesh.kumar@kernel.org, steven.price@arm.com,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com
References: <20250613111153.1548928-1-suzuki.poulose@arm.com>
 <20250613111153.1548928-4-suzuki.poulose@arm.com>
 <aHZeCKNyDeZEsuCt@willie-the-truck>
 <bf56dab4-8a11-4e91-b330-2a8126c94acc@arm.com>
 <aHZsgzNYwfCljX-G@willie-the-truck>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aHZsgzNYwfCljX-G@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will

On 15/07/2025 15:58, Will Deacon wrote:
> On Tue, Jul 15, 2025 at 03:38:41PM +0100, Suzuki K Poulose wrote:
>> On 15/07/2025 14:56, Will Deacon wrote:
>>> On Fri, Jun 13, 2025 at 12:11:53PM +0100, Suzuki K Poulose wrote:
>>>> ACPI CCEL memory area is reported as Non-Volatile storage area. Map it as
>>>> PAGE_KERNEL.
>>>
>>> It would be helpful to have a citation for that. I've tried digging it
>>> out of the ACPI spec, but that pointed me to the Intel TDX site and I
>>> got lost in whitepapers :/
>>>
>>
>> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table
> 
> Thanks, but I still can't spot where it specifies the memory attributes.
> I think we should be able to refer to that as justification for ignoring
> the attributes specified by EFI.

Here is the description for the Efi memory types.

https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#memory-type-usage-before-exitbootservices

 From that I gather that OS must map the area as read only.

> 
>>>> Cc: Sami Mujawar <sami.mujawar@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>>>> Cc: Steven Price <steven.price@arm.com>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>    arch/arm64/kernel/acpi.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>>> index b9a66fc146c9..f52439d411a0 100644
>>>> --- a/arch/arm64/kernel/acpi.c
>>>> +++ b/arch/arm64/kernel/acpi.c
>>>> @@ -356,6 +356,11 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>>>>    			prot = PAGE_KERNEL_RO;
>>>>    			break;
>>>> +		case EFI_ACPI_MEMORY_NVS:
>>>> +			/* Non-volatile storage, required for CCEL */
>>>> +			prot = PAGE_KERNEL;
>>>
>>> By "storage" you just mean memory, right?
>>
>> Yep, it is just memory. I will drop the "NV storage" and simply mention,
>> CCEL.
> 
> Thanks. Also, why don't we check against memblock_is_map_memory() for
> this, like we do for all the other types apart from
> EFI_RUNTIME_SERVICES_CODE?

As per the spec, the NVS type must be reserved and we do that in the
kernel. For the other types, you mentioned, they are usable by
general OS and in Linux we only reserve them, if they are have
WB attribute (See is_usable_memory()). Thus we do extra checks to
make sure, if it is in use and mark them as RO.

So, NVS is by default reserved and doesn't have to do extra checks.

That said, I will fix the prot to PAGE_KERNEL_RO to make sure
the OS doesn't write to it.

Thanks
Suzuki

> 
> Will


