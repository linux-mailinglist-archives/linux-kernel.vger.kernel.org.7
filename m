Return-Path: <linux-kernel+bounces-800583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69652B4398C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312DF1B27BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3292FC030;
	Thu,  4 Sep 2025 11:07:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4922EC08B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984029; cv=none; b=sMlUIVjP26dwgXv8L0lBHwc+YH+xXPQGgi3lIsD2NjcOwKO6gN+6jUfQ5117c2YdLdSm5REhiO6Kc0r9jI2eLQKWJe5Z+Iq6mhEz7LMoN6L+BXdX/O0ZMRsOa9TDNB2FGYYwdoRrprRM8UJpMyCuwVBALf3tewvPpt3IlkNdi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984029; c=relaxed/simple;
	bh=MWlqjpV2qVKmTm0NVzJ05O4+p98eyvHw2JmOhER1CWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFDfWSqOnr3sZp1aLTXjjtpHQXeNDWNvBy9f2+qyRDyVeLv+Gso1ou/OaKSSO17QXmGnPR7Ty9IAdFkAWH4mtIuknLR/Vnypj42ybaW6QiALOIzK+rPdTttAX+qxY3Sc8TlN47+Bh8oIzrQvoomFjevDQU+4CHkpU7DpcWHpAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A4D1756;
	Thu,  4 Sep 2025 04:06:58 -0700 (PDT)
Received: from [10.1.37.179] (XHFQ2J9959.cambridge.arm.com [10.1.37.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754B23F6A8;
	Thu,  4 Sep 2025 04:07:05 -0700 (PDT)
Message-ID: <a2ab7671-093d-4b7d-b0a2-2a6f73bb80e4@arm.com>
Date: Thu, 4 Sep 2025 12:07:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] arm64: cpufeature: add AmpereOne to BBML2 allow
 list
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-3-ryan.roberts@arm.com>
 <b3f4e006-6101-496f-a4a5-13474470109d@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b3f4e006-6101-496f-a4a5-13474470109d@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/08/2025 23:08, Yang Shi wrote:
> 
> 
> On 8/29/25 4:52 AM, Ryan Roberts wrote:
>> From: Yang Shi <yang@os.amperecomputing.com>
>>
>> AmpereOne supports BBML2 without conflict abort, add to the allow list.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> I saw Catalin gave Reviewed-by to v6 of this patch, I think we can keep it.

Sorry I missed that. I see Catalin and Rb'ed again.

> 
> Yang
> 
>> ---
>>   arch/arm64/kernel/cpufeature.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9ad065f15f1d..b93f4ee57176 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2234,6 +2234,8 @@ static bool has_bbml2_noabort(const struct
>> arm64_cpu_capabilities *caps, int sco
>>       static const struct midr_range supports_bbml2_noabort_list[] = {
>>           MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>>           MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>>           {}
>>       };
>>   
> 


