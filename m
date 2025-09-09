Return-Path: <linux-kernel+bounces-807221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90387B4A1BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B327E1BC48EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49DC3009C1;
	Tue,  9 Sep 2025 06:03:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA903002C1;
	Tue,  9 Sep 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397822; cv=none; b=dSVxQIUBJvH3j5GNBkDP1+jPKGgJpmJKMIbmfeImPFeMYWLFNX49sr9r/iMJrLqaHTte4+6tAG3Bu8Vj3MLHacu1hJ42r6lQFudN9e0hYuKeHkkmN2gOClum1wd7h8JTvFG9Z5ivClyIcTTCQV0ssGBAhD7Ps66E2hTh9ID/Nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397822; c=relaxed/simple;
	bh=yucePQQXalTmQpke8L/YvxaI6o+fEb0p9YAdKmOXYzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGZLuSgyJTfd/M6RwdAWIHb8q6HvM3syNvxtW6J41MFsxsgGSsnyn8YKMC+KEtlfG8xIGKiiIueG0rQkK1/dNKWW2FOvRipN1rXvJSJd53+4D8B2n+Y2B/zDXePUv9zj/63Q2EYic2SVNljPYoEkPPYBGez/VatcxrVflJSYJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1715315A1;
	Mon,  8 Sep 2025 23:03:30 -0700 (PDT)
Received: from [10.163.72.34] (unknown [10.163.72.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2433F66E;
	Mon,  8 Sep 2025 23:03:31 -0700 (PDT)
Message-ID: <a2f95b96-cc0a-44a4-bd2a-05ba65b39b6a@arm.com>
Date: Tue, 9 Sep 2025 11:33:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] arm64: refactor the rodata=xxx
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, corbet@lwn.net, paulmck@kernel.org,
 akpm@linux-foundation.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 bp@alien8.de, ardb@kernel.org, suzuki.poulose@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org
References: <20250909033236.4099-1-shijie@os.amperecomputing.com>
 <20250909033236.4099-2-shijie@os.amperecomputing.com>
 <bc0ae013-2314-4513-a759-cbf2b922aa6a@arm.com>
 <a18f3b2a-0869-436b-ab20-41a92f1f468a@amperemail.onmicrosoft.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a18f3b2a-0869-436b-ab20-41a92f1f468a@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/25 10:56 AM, Shijie Huang wrote:
> 
> On 09/09/2025 12:29, Anshuman Khandual wrote:
>> On 09/09/25 9:02 AM, Huang Shijie wrote:
>>> As per admin guide documentation, "rodata=on" should be the default on
>>> platforms. Documentation/admin-guide/kernel-parameters.txt describes
>>> these options as
>>>
>>>     rodata=         [KNL,EARLY]
>>>             on      Mark read-only kernel memory as read-only (default).
>>>             off     Leave read-only kernel memory writable for debugging.
>>>             full    Mark read-only kernel memory and aliases as read-only
>>>                     [arm64]
>>>
>>> But on arm64 platform, RODATA_FULL_DEFAULT_ENABLED is enabled by default,
>>> so "rodata=full" is the default instead.
>>>
>>> This patch implements the following changes:
>>>   - Make "rodata=on" behaviour same as the original "rodata=full".
>>>     This keeps align with the x86.
>>>   - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>>>   - Drop the original "rodata=full"
>>>
>>> After this patch, the "rodata=on" will be the default on arm64 platform
>>> as well.
>>>
>>> Different rodata options may have different performance, so record more
>>> detail information here:
>>>
>>>   rodata=on (default)
>>>      This applies read-only attributes to VM areas and to the linear
>>>      alias of the backing pages as well. This prevents code or read-
>>>      only data from being modified (inadvertently or intentionally),
>>>      via another mapping for the same memory page.
>>>
>>>      But this might cause linear map region to be mapped down to base
>>>      pages, which may adversely affect performance in some cases.
>>>
>>>   rodata=off
>>>      This provides more block mappings and contiguous hints for linear
>>>      map region which would minimize TLB footprint. This also leaves
>>>      read-only kernel memory writable for debugging.
>>>
>>>   rodata=noalias
>>>      This provides more block mappings and contiguous hints for linear
>>>      map region which would minimize TLB footprint. This leaves the linear
>>>      alias of read-only mappings in the vmalloc space writeable, making
>>                         typo     ^^^^^^^^
> What's the typo? It seems "writeable" is okay.

Alright.
>>>      them susceptible to inadvertent modification by software.
>>>
>>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>>> ---
>>>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>>   arch/arm64/include/asm/setup.h                  | 4 ++--
>>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index db84a629f7b1..138e0db5af64 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -6418,8 +6418,9 @@
>>>       rodata=        [KNL,EARLY]
>>>           on    Mark read-only kernel memory as read-only (default).
>>>           off    Leave read-only kernel memory writable for debugging.
>>> -        full    Mark read-only kernel memory and aliases as read-only
>>> -                [arm64]
>>> +        noalias    Mark read-only kernel memory as read-only but retain
>>> +            writable aliases in the direct map for regions outside
>>> +            of the kernel image. [arm64]
>> Should not the arm64 specific performance implications be mentioned
>> in the above documentation update as well ? But in case this appears
>> too much platform specific - probably do consider adding them above
>> or inside arch_parse_debug_rodata() as an in-code documentation.
> 
> Will had already suggested do not add them for the arch_parse_debug_rodata():
> 
> https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1060135.html
Alright.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

