Return-Path: <linux-kernel+bounces-732079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E869AB061A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B1504BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F671E9B04;
	Tue, 15 Jul 2025 14:38:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5FC533D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590326; cv=none; b=azibnDNGPzEWHvSSRVhCwTZAnbkSWFyBZ/HvCYhE8mtbDPPxYyHbZ1nZWpP13mnuRPVVmczbtik41nyScjjiSIta6lrRtxuP6PWo3P2h6Gtjm6z5lbaLtXZf6ZlZQQ6MpzzQR3qQ9D+T0XH7jk0Vq13iVZDcoLM+WkrGVC5xwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590326; c=relaxed/simple;
	bh=P3j1E9KS66ASSlCoDWZJbpV0GTjtVplMundCobaQwhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd7/sZ9XzXjJOw+4jAVIjCHp+gHbZ5D/vCSYD/CH+dM59X05+2phTWxtFIauZRTwAL54OVk1a728Tl5dKy7aElMoqqXsoFpn1IVwH/Iu0vP95IQm/BJvRiiPmKuOCWB28lgxeLtqVPrKp7zQNPrHuRu7Xe5A4WSJs93GxnXhzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B38112FC;
	Tue, 15 Jul 2025 07:38:34 -0700 (PDT)
Received: from [10.57.0.241] (unknown [10.57.0.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D52943F694;
	Tue, 15 Jul 2025 07:38:41 -0700 (PDT)
Message-ID: <bf56dab4-8a11-4e91-b330-2a8126c94acc@arm.com>
Date: Tue, 15 Jul 2025 15:38:41 +0100
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aHZeCKNyDeZEsuCt@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 14:56, Will Deacon wrote:
> On Fri, Jun 13, 2025 at 12:11:53PM +0100, Suzuki K Poulose wrote:
>> ACPI CCEL memory area is reported as Non-Volatile storage area. Map it as
>> PAGE_KERNEL.
> 
> It would be helpful to have a citation for that. I've tried digging it
> out of the ACPI spec, but that pointed me to the Intel TDX site and I
> got lost in whitepapers :/
> 

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table

>> Cc: Sami Mujawar <sami.mujawar@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/kernel/acpi.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index b9a66fc146c9..f52439d411a0 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -356,6 +356,11 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>>   			prot = PAGE_KERNEL_RO;
>>   			break;
>>   
>> +		case EFI_ACPI_MEMORY_NVS:
>> +			/* Non-volatile storage, required for CCEL */
>> +			prot = PAGE_KERNEL;
> 
> By "storage" you just mean memory, right?

Yep, it is just memory. I will drop the "NV storage" and simply mention, 
CCEL.

Thanks!

Suzuki


> 
> Will


