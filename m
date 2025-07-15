Return-Path: <linux-kernel+bounces-731260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C4DB051E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791271AA7422
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2A266574;
	Tue, 15 Jul 2025 06:36:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86C1F4174
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561403; cv=none; b=Ef9s3lbt+xNepazm7uJJgPhYbMd0on/iuGHL79RAeKF7BopacB8sUAYklqZX8vLibVJ6KZ0HZOO46xYSUmzMq2IueqCoDYEA4N0gWCGGSlzzja3u5xlHIo+9i/w6Cwx3BpqT5Aw5ZuJkRfY2eqIasQxUtHcRngwDXmE3fvq3f7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561403; c=relaxed/simple;
	bh=iClJ4l+3FY0XZkdAsM8PQVdplpdYCGImAAevbdgBcqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqfigckcuGqIWgA9ub1mjv9oemzrVwvFh58RBIJES6EL2hoQ/H2dCVRmlFTsOLHsBdAJB+kt9+uVUaI3WcBRh8eZQWlKLMPDR6uC/GsBynvu4SNEgJoOtAvOkxNC4ojOyMJjM1e+cHqOEo06W6aJgbqlbeWxHM2uBhyHE0rqYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828AC12FC;
	Mon, 14 Jul 2025 23:36:31 -0700 (PDT)
Received: from [10.163.92.132] (unknown [10.163.92.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A4FC3F6A8;
	Mon, 14 Jul 2025 23:36:37 -0700 (PDT)
Message-ID: <408a830d-11c5-4c29-95c1-21789cd07e32@arm.com>
Date: Tue, 15 Jul 2025 12:06:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop redundant addr increment in
 set_huge_pte_at()
To: Dev Jain <dev.jain@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
References: <20250715043922.57195-1-anshuman.khandual@arm.com>
 <e10e0fac-a81c-445e-8036-9db2b63b77f7@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <e10e0fac-a81c-445e-8036-9db2b63b77f7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/07/25 11:28 AM, Dev Jain wrote:
> 
> On 15/07/25 10:09 am, Anshuman Khandual wrote:
>> The 'addr' need not be incremented while operating on single entry basis as
>> BBM is not required for such updates.
> 
> "while operating on a single entry basis" should be replaced with
> "when transitioning from invalid to valid pte"; BBM is required
> for single entry updates when the cont bit is set, as described
> in the comment immediately below. In fact, let us not even mention
> BBM at all - the reasoning is that the code is written in a way
> that, the loop incrementing addr, immediately has a return after
> it, and it does not actually use the addr, so let's drop the
> increment. It is not immediately obvious from the commit description
> that the addr is passed ultimately to flush_tlb_range friends which
> is involved in BBM.

Agreed, the mention about BBM can be dropped as it is not really
relevant. Rather 'addr' variable being unused in the conditional
block, which exits right after is the real reason. I will update
the commit description as required.  

> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/hugetlbpage.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 0c8737f4f2ce..1d90a7e75333 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -225,7 +225,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>>       ncontig = num_contig_ptes(sz, &pgsize);
>>         if (!pte_present(pte)) {
>> -        for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>> +        for (i = 0; i < ncontig; i++, ptep++)
>>               __set_ptes_anysz(mm, ptep, pte, 1, pgsize);
>>           return;
>>       }

