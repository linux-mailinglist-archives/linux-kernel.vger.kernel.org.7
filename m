Return-Path: <linux-kernel+bounces-832286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC1B9ED16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC5B165E48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373D2F28E3;
	Thu, 25 Sep 2025 10:50:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E802EFD90
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797458; cv=none; b=ec6jM18V66g/QKqE54s9Ej9b1V8g+vr0Rsq1lbjnmV+2B1YRWescQp997S55oRGa7pU+/RVOELweRft65So3uFfXVPrcDE8P90pcTLpwNAb4gB1ORtUKmSVXigzFQp/deL7/bsjPx6WZWui3dGv9KR2HAXIb5B+kwjB8mu7Ibzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797458; c=relaxed/simple;
	bh=ifRZ5Zq7yTB/SAMgpajRTa4OCzOPrHx7Rm1kmko/XPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvfqIVHbk8RBb+m33cFMcvy8Wc02sBsOf6x/Gch7olNVw4uQRXoJNF2S6SVh5RZ2iHoRQ62NUZaETN/El6B0k71kIl2gwLF8JOZRSqzwNK7XNu3smAgmbaLzNMMCw3kfP5agn2PqeyiLM3xMrO0Ebq/G0puoNYnVUnbK84kU/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011731692;
	Thu, 25 Sep 2025 03:50:48 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D123F694;
	Thu, 25 Sep 2025 03:50:53 -0700 (PDT)
Message-ID: <26ca0d6b-5fd4-42f9-b985-936d9a72d307@arm.com>
Date: Thu, 25 Sep 2025 16:20:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
References: <20250925085429.41607-1-dev.jain@arm.com>
 <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
 <45e08ee0-c85e-469e-a3eb-4ca2e8b7ec0c@arm.com>
 <462bb4e3-7a38-4155-9f95-52fbb4b6d464@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <462bb4e3-7a38-4155-9f95-52fbb4b6d464@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 25/09/25 4:07 pm, David Hildenbrand wrote:
> On 25.09.25 12:33, Dev Jain wrote:
>>
>> On 25/09/25 2:46 pm, David Hildenbrand wrote:
>>> On 25.09.25 10:54, Dev Jain wrote:
>>>> At wp-fault time, when we find that a folio is exclusively mapped, we
>>>> move
>>>> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
>>>> reduces. This is currently done for small folios (base pages) and
>>>> PMD-mapped THPs. Do this for mTHP too.
>>>
>>> I deliberately didn't add this back then because I was not able to
>>> convince myself easily that it is ok in all corner cases. So this
>>> needs some thought.
>>
>> Thanks for your detailed reply.
>>
>>
>>>
>>>
>>> We know that the folio is exclusively mapped to a single MM and that
>>> there are no unexpected references from others (GUP pins, whatsoever).
>>>
>>> But a large folio might be
>>>
>>> (a) mapped into multiple VMAs (e.g., partial mprotect()) in the same MM
>>
>> I think we have the same problem then for PMD-THPs? I see that
>> vma_adjust_trans_huge() only does a PMD split and not folio split.
>
> Sure, we can end up in this reuse function here for any large anon 
> folio, including PMD ones after a PMD->PTE remapping.

Ah alright, I was thinking that something may go wrong through 
folio_move_anon_rmap() in do_huge_pmd_wp_page, but

that case will *not* have the PMD split guaranteeing that it lies in the 
same VMA. Interesting.


