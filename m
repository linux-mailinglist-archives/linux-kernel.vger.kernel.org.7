Return-Path: <linux-kernel+bounces-864450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CFBFAD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CC11881606
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EB2FF668;
	Wed, 22 Oct 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vJpHD3lM"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC019C542
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120683; cv=none; b=Cs6Rvk6Ozzke8QKZdGnAzMqlFcDo/vrLDeSvO10M2B7SpDhdFXmwqxLV/JeRJWNCfD201Bp5cGrbnM6SnAVf66gGNUmmYZspLdPiSsDv4TH1U2XRk1ipVD4uBwrxgaVsWGatWFsw0U/NAsnN+D4VYFmR5NKvPvY3L/zlHifIPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120683; c=relaxed/simple;
	bh=AwxpqWyO34OqphnyM4CP9l0T2jrboQbpR0le/PmLeKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVnL1HU3pfvmzm9MNi7WzqeibULyJByE2V6L7XpFkbXdW7/7FXqshLoetKOSvsN3XoVIC7ySWl1AMZXe7jKqAJuN1RScG/ou9oq2UL7ah0v+e4GwsajtZFsaGxoKZJXH2dCXq1Vj2ub0g3DDkD1Cm5xxt8WmiPXlMSV6XXSdvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vJpHD3lM; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761120677; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=LIvjRU+9W1e02BD6k4Ej3q4cCT3RiCjRqqzBqmFHkYo=;
	b=vJpHD3lMj1ds9F7KUn0R3z5aJfgP9yz/RT64pbTFcTVi3EuXFdRSRe9pJHTtC8GxT9Lw87f3ga68wpyJNMHmHeq64apR+r2UKpXHP/EPevY8vnSt9U+x4o51e+62XrE07XBy2mvAQ/wqU57c3fP0BaYkzmjEHtC0M89s3R8e62I=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wqm7tPB_1761120676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 16:11:17 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org,  Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
In-Reply-To: <b5a1b52c-75ef-4915-a254-a502b9f78eeb@arm.com> (Anshuman
	Khandual's message of "Wed, 22 Oct 2025 13:28:43 +0530")
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
	<87ecqve6gg.fsf@DESKTOP-5N7EMDA>
	<b5a1b52c-75ef-4915-a254-a502b9f78eeb@arm.com>
Date: Wed, 22 Oct 2025 16:11:15 +0800
Message-ID: <87o6pzbbks.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 22/10/25 1:03 PM, Huang, Ying wrote:
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> 
>>> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> These tests clear on arm64 platform after the following recent patch.
>>>
>>> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>>>
>>> Changes in V2:
>>>
>>> - Added a new test combination per Huang
>>>
>>> Changes in V1:
>>>
>>> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>>>
>>>  mm/debug_vm_pgtable.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 830107b6dd08..def344bb4a32 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>>>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>> +
>>> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
>>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>>> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>> 
>> Why do you use
>> 
>> pte_mkwrite_novma(pte)
>> 
>> instead of
>> 
>> pte_mkwrite(pte, args->vma)
> Just wanted to have more coverage for pte_mkwrite_novma() helper which was missing
> till now in this test. But just wondering is there a specific reason for replacing
> this with pte_mkwrite() helper instead here ? Also we could probably add tests for
> both these helper variations if that is preferred.

IIUC, pte_mkwrite() is a more formal interface.  pte_mkwrite_novma() is
used to implement pte_mkwrite().  So, IMHO, we should use the more
formal pte_mkwrite() interface if possible.

---
Best Regards,
Huang, Ying

