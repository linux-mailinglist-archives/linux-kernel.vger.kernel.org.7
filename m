Return-Path: <linux-kernel+bounces-806188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7CB4932A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E9C4474E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382830E0DC;
	Mon,  8 Sep 2025 15:25:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C18F30C616
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345137; cv=none; b=E87OwyxzOMUwLzkM+kAQTdmPof7Qqezhk9hETqrNqSC9ghAzWqN6rHbkx/nEQp37v9WTEn7JXy7MCLZR9xoAImJWggyP6zRGLU1Np9YeEHhE0G0PF2qBVUiyOt64238drQFh1r+ttI4xtBf0tAqu692dT0Laqyiz1uYqkS4A87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345137; c=relaxed/simple;
	bh=CaU6ntgVJZiXsq8SnBOe9GnPVwL3idZLUWWZyjCgpmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prA7hUtDfE8iS0svRjSw98r+WaQt7fLesZRZ0sLymRJeX0SXRuaYmOgaM1ygcx1E/zQFncTycwnMrN/0/+iJ6f7gRACGSphr/uf/zw4lvbZbkVKvbagQ8eRQrtX6VbUAVg73GOhdpjP7/BEOjj0TF2vWb7BEkNUJku41+DP2dDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623132C46;
	Mon,  8 Sep 2025 08:25:24 -0700 (PDT)
Received: from [10.57.91.39] (unknown [10.57.91.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57CEF3F63F;
	Mon,  8 Sep 2025 08:25:30 -0700 (PDT)
Message-ID: <11f84d00-8c76-402d-bbad-014a3542992f@arm.com>
Date: Mon, 8 Sep 2025 16:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-6-ryan.roberts@arm.com> <aLnFd1Hl_FSHZR3z@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aLnFd1Hl_FSHZR3z@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2025 17:59, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 12:52:46PM +0100, Ryan Roberts wrote:
>> The kernel linear mapping is painted in very early stage of system boot.
>> The cpufeature has not been finalized yet at this point. So the linear
>> mapping is determined by the capability of boot CPU only. If the boot
>> CPU supports BBML2, large block mappings will be used for linear
>> mapping.
>>
>> But the secondary CPUs may not support BBML2, so repaint the linear
>> mapping if large block mapping is used and the secondary CPUs don't
>> support BBML2 once cpufeature is finalized on all CPUs.
>>
>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>> same BBML2 capability with the boot CPU, repainting the linear mapping
>> is not needed.
>>
>> Repainting is implemented by the boot CPU, which we know supports BBML2,
>> so it is safe for the live mapping size to change for this CPU. The
>> linear map region is walked using the pagewalk API and any discovered
>> large leaf mappings are split to pte mappings using the existing helper
>> functions. Since the repainting is performed inside of a stop_machine(),
>> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
>> since we are still early in boot, it is expected that there is plenty of
>> memory available so we will never need to sleep for reclaim, and so
>> GFP_ATOMIC is acceptable here.
>>
>> The secondary CPUs are all put into a waiting area with the idmap in
>> TTBR0 and reserved map in TTBR1 while this is performed since they
>> cannot be allowed to observe any size changes on the live mappings. Some
>> of this infrastructure is reused from the kpti case. Specifically we
>> share the same flag (was __idmap_kpti_flag, now idmap_kpti_bbml2_flag)
>> since it means we don't have to reserve any extra pgtable memory to
>> idmap the extra flag.
>>
>> Co-developed-by: Yang Shi <yang@os.amperecomputing.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> I think this works, so:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> 
> However, I wonder how likely we are to find this combination in the
> field to be worth carrying this code upstream. With kpti, we were aware
> of platforms requiring it but is this also the case for BBM? If not, I'd
> keep the patch out until we get a concrete example.

Cortex-X4 supports BBML2_NOABORT (and is in the allow list). According to
Wikipedia [1], X4 is in:

 - Google Tensor G4 [2]
 - MediaTek Dimensity 9300/9300+ [3]
 - Qualcomm Snapdragon 8 Gen 3 [4]

And in each of those SoCs, the X4s are paired with A720 and A520 cores.

To my knowledge, neither A720 nor A520 support BBML2_NOABORT. Certainly they are
not currently in the allow list. So on that basis, I think the require the
fallback path, assuming these platforms use one of the X4 cores as the boot CPU.

[1] https://en.wikipedia.org/wiki/ARM_Cortex-X4
[2] https://en.wikipedia.org/wiki/Google_Tensor
[3] https://en.wikipedia.org/wiki/List_of_MediaTek_systems_on_chips
[4] https://en.wikipedia.org/wiki/List_of_Qualcomm_Snapdragon_systems_on_chips

Thanks,
Ryan


