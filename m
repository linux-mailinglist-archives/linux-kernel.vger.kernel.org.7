Return-Path: <linux-kernel+bounces-823946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A553B87C99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 504A94E1B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870F26B771;
	Fri, 19 Sep 2025 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SAGj5wp8"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD157082A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251940; cv=none; b=Hy7Z+Q1OuqgaQbTUeoYrafqSSI63I59fFhm0bFX38cg2gTmSNG1i2hF+938XfbwpRl1HJDviTBB/dnoxCNQ6d0HNhq4VZMcgEebTg7XYgHuVUJLRy0k0LdUoBqqfpYfCNJnCmBLR2tnMwVkqoS0tfbsSW9wSpbGkGn9eXgpC29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251940; c=relaxed/simple;
	bh=1JGOjgkyaQ7JzOt9+jHbcEjkIl4jGRKaPxRz9efRReg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDd/ZXCcHbcQFupWHFIwRnxk5D8epeu3InoWO3oR5RbJ1xZWtwEMi/+vdeKIqKX40NYm7uYe+G4v0hukBgiR57rrTkmB5wizZcScedV6n8wO1zlfaSCvjL5MWN5gO/hkbIj04/6TqmZC2WPbxf7+DuukCAYfHh7ieA/ZPiidBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SAGj5wp8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758251934; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3jyNZcyWmSv57/hy/i7IMAf+J2cMcU8oayGt4OVdOm8=;
	b=SAGj5wp828AnyRJIyba2Y1PdiUrtukIWQjfoIAhZ7um8k7N95VaZLp2046lvER4VMW3Vo4az+GRDgRuUTvEbpdATqm5QKspdrSMkqb0EBXva2NvrgSK5NqJdAMtf2hmKegj6YT7cFagtVGoYBlV1YbO3/W0rse4hIH2BBPpwwZo=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoIF9NG_1758251931 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 11:18:52 +0800
Message-ID: <7ca12da2-4ddc-4b4e-a8da-a1d9d2c44e03@linux.alibaba.com>
Date: Fri, 19 Sep 2025 11:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 kirill@shutemov.name, hughd@google.com, mpenttil@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <6BAE5498-D0AB-40F5-85F8-B92A05CA72AD@nvidia.com>
 <20e0fb73-3476-4b1c-959e-c1af38f8e1a0@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20e0fb73-3476-4b1c-959e-c1af38f8e1a0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/19 10:44, Lance Yang wrote:
> 
> 
> On 2025/9/19 03:12, Zi Yan wrote:
>> On 18 Sep 2025, at 1:04, Lance Yang wrote:
>>
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>>> lightweight guard regions.
>>>
>>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail 
>>> when
>>> encountering such a range.
>>>
>>> MADV_COLLAPSE fails deep inside the collapse logic when trying to 
>>> swap-in
>>> the special marker in __collapse_huge_page_swapin().
>>>
>>> hpage_collapse_scan_pmd()
>>>   `- collapse_huge_page()
>>>       `- __collapse_huge_page_swapin() -> fails!
>>>
>>> khugepaged's behavior is slightly different due to its max_ptes_swap 
>>> limit
>>> (default 64). It won't fail as deep, but it will still needlessly 
>>> scan up
>>> to 64 swap entries before bailing out.
>>>
>>> IMHO, we can and should detect this much earlier.
>>>
>>> This patch adds a check directly inside the PTE scan loop. If a guard
>>> marker is found, the scan is aborted immediately with 
>>> SCAN_PTE_NON_PRESENT,
>>> avoiding wasted work.
>>>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>   mm/khugepaged.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct 
>>> mm_struct *mm,
>>>                       result = SCAN_PTE_UFFD_WP;
>>>                       goto out_unmap;
>>>                   }
>>> +                /*
>>> +                 * Guard PTE markers are installed by
>>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>>> +                 * not touch them, so abort the scan immediately
>>> +                 * if one is found.
>>> +                 */
>>> +                if (is_guard_pte_marker(pteval)) {
>>
>> pteval is already is_swap_pte(), would is_guard_swp_entry() be a better
>> choice here? Save one is_swap_pte() call.

Agree. Then seems we don't need to move the is_guard_pte_marker() into a 
header file.


