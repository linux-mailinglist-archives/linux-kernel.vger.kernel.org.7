Return-Path: <linux-kernel+bounces-822759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419BB849A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0136E3BC7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D22D3225;
	Thu, 18 Sep 2025 12:35:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC493594E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198926; cv=none; b=jPckzILDwBjOhJcYyOcDsnLY+7JZAA0WLbCgCoTIJJJxcEfX9Ik58q7w9LrmhOyGTD+NL5VNHkJqSywcf7squvSrudVJpks5Me98kAFlHhLvtmMmePNighA5bSBtaKJq5GtjbxtUXqUr8gv9YBKhqFlUAQgzkzznZoUAAOz8tUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198926; c=relaxed/simple;
	bh=ffw7ax0TPCQ17jdzTuqVFKG7mOQe23DKGJqgS3ROAs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohNAYPy+EtMBPtx28lg5bnmEXZlp9B/lKPGS5I5VQMISy8VvYy1fO7I0R02iJeXHXkmiXfWdH2jLG/0Qtp49+o+FwyLc4PPEZnemD6IlpFDaBKbHaVNXjfCVY+XnhQEQMN+3ezE/tNoCtqcUe0w1VOUos7ey79yd9ztmnuJSQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F801A25;
	Thu, 18 Sep 2025 05:35:14 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566643F673;
	Thu, 18 Sep 2025 05:35:21 -0700 (PDT)
Message-ID: <fdd95a19-f787-428b-b184-a5de19469c0b@arm.com>
Date: Thu, 18 Sep 2025 13:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: acpi: Enable ACPI CCEL support
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, catalin.marinas@arm.com, gshan@redhat.com,
 aneesh.kumar@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
 steven.price@arm.com
References: <20250908223519.1759020-1-suzuki.poulose@arm.com>
 <20250908223519.1759020-4-suzuki.poulose@arm.com>
 <aMv7tbA3JGd7ZcbW@willie-the-truck>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aMv7tbA3JGd7ZcbW@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will

On 18/09/2025 13:31, Will Deacon wrote:
> On Mon, Sep 08, 2025 at 11:35:19PM +0100, Suzuki K Poulose wrote:
>> Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
>> As per UEFI specifications NVS memory is reserved for Firmware use even
>> after exiting boot services. Thus map the region as read-only.
>>
>> Cc: Sami Mujawar <sami.mujawar@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v1
>>   - Map NVS region as read-only, update comment to clarify that the region
>>     is reserved for firmware use.
>>
>> ---
>>   arch/arm64/kernel/acpi.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index 4d529ff7ba51..93b70f48a51f 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -360,6 +360,17 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>>   			prot = PAGE_KERNEL_RO;
>>   			break;
>>   
>> +		case EFI_ACPI_MEMORY_NVS:
>> +			/*
>> +			 * ACPI NVS marks an area reserved for use by the
>> +			 * firmware, even after exiting the boot service.
>> +			 * This may be used by the firmware for sharing dynamic
>> +			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
>> +			 * as read-only.
>> +			 */
>> +			prot = PAGE_KERNEL_RO;
>> +			break;
>> +
> 
> Shouldn't this be merged with the other case handling read-only mappings?
> e.g. something like:
> 

I thought about it, but went against it, to keep the code separate. But
surely this is fine. I will resend the series with the proposed change.

Suzuki

> 		switch (region->type) {
> 		case EFI_LOADER_CODE:
> 		case EFI_LOADER_DATA:
> 		case EFI_BOOT_SERVICES_CODE:
> 		case EFI_BOOT_SERVICES_DATA:
> 		case EFI_CONVENTIONAL_MEMORY:
> 		case EFI_PERSISTENT_MEMORY:
> 			if (memblock_is_map_memory(phys) ||
> 			    !memblock_is_region_memory(phys, size)) {
> 				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> 				return NULL;
> 			}
> 			/*
> 			 * Mapping kernel memory is permitted if the region in
> 			 * question is covered by a single memblock with the
> 			 * NOMAP attribute set: this enables the use of ACPI
> 			 * table overrides passed via initramfs, which are
> 			 * reserved in memory using arch_reserve_mem_area()
> 			 * below. As this particular use case only requires
> 			 * read access, fall through to the R/O mapping case.
> 			 */
> 			fallthrough;
> 
> 		case EFI_RUNTIME_SERVICES_CODE:
> 			/*
> 			 * This would be unusual, but not problematic per se,
> 			 * as long as we take care not to create a writable
> 			 * mapping for executable code.
> 			 */
> 			fallthrough;
> 
> 		case EFI_ACPI_MEMORY_NVS:
> 			/*
> 			 * ACPI NVS marks an area reserved for use by the
> 			 * firmware, even after exiting the boot service.
> 			 * This may be used by the firmware for sharing dynamic
> 			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
> 			 * as read-only.
> 			 */
> 			prot = PAGE_KERNEL_RO;
> 			break;
> 
> 
> With that, I'm happy to pick up the series (let me know if you want me
> to make the change above locally to save you a resend).
> 
> Will


