Return-Path: <linux-kernel+bounces-886590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D66C36067
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD04462388
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966CE315D3F;
	Wed,  5 Nov 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMVDDg6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3721CFF6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352484; cv=none; b=pRH3usBrZwm7iKBpnj7MIzemRkVNqgNGckEoUF4WgUVYlGTdwNv+p834BVcEsL+EP+W9xhoFNPdk5MT8vAm3aNVIdqsVIZy9I4U4XeTBznoVwu0Jsq08BUFAWcvDv2jLBn96yE0B/4XgXGyPrNtdfE56Mc0au2Yt4m1NTKagGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352484; c=relaxed/simple;
	bh=KDZATPE9X1vCi/Nk0hVLycBqSpHsTQBD3TNCN9EBGvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDP75lVYfkx9YVvN43YC7ukUn7B/5XIrqC2GmG9yQWmWfwvKCj/rlXTFCeZm09vf/KY5OYJtIVyhH1gKWY/c/rLUim4j2avJaLocCaPDL7ykj1uxtvPzFDfU0uxpqY84RlGfZrUGh2+vuBkLLp1BIIsqnSqIe3SMSP25Cu4aRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMVDDg6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54263C4CEF5;
	Wed,  5 Nov 2025 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762352483;
	bh=KDZATPE9X1vCi/Nk0hVLycBqSpHsTQBD3TNCN9EBGvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMVDDg6Yo0t9IjFgm+3etBRD3hShAzZ9ImdsaRXGGOvEvjYmA6Nozb10N0c5kZcAe
	 mnkdv70xnmcmKC/RqRSkW0SqYq5TSHISco8uy0uAX8TUPzIT1Ih/Ize61KenaBCkwE
	 azc9KHtUkxkzSu4ibpfRFAFXUe9tnO8AyZppkCJY1kxEGb9iU/GdLTsK2Elwrr7Zr9
	 9Njk6NccBQtvPdDUqoQ0ZJbz9VdLad6ogrzujuSLQ4lam4sA7IR6yy6idCbWRHsfCV
	 i66ttLJBjKY9iIAveH3CtdGHE987+oH08DpPjCPDCmUh/OWJoPA8kXbC2BGe9rKdBQ
	 evLb1C6Sj+TiQ==
Message-ID: <c6e5aa34-25ab-44f9-b6dc-127f3084adc8@kernel.org>
Date: Wed, 5 Nov 2025 15:21:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-2-pedrodemargomes@gmail.com>
 <a6574561-02bc-4ba6-9fb4-418dcb07cd5f@kernel.org>
 <42byvvz55omaszu6ep3g7n2dj5z7mfxy5h3zbc3xjdnslemkpp@kvdzrjz423mb>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <42byvvz55omaszu6ep3g7n2dj5z7mfxy5h3zbc3xjdnslemkpp@kvdzrjz423mb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 14:28, Pedro Demarchi Gomes wrote:
> On Mon, Nov 03, 2025 at 06:00:08PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
>>> This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
>>> function break_ksm_pmd_entry() to use folios.
>>>
>>> This reverts break_ksm() to use walk_page_range_vma() instead of
>>> folio_walk_start().
>>> This will make it easier to later modify break_ksm() to perform a proper
>>> range walk.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
>>> ---
>>>    mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
>>>    1 file changed, 47 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 4f672f4f2140..922d2936e206 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>>    	return atomic_read(&mm->mm_users) == 0;
>>>    }
>>> +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>>> +			struct mm_walk *walk)
>>> +{
>>> +	struct folio *folio = NULL;
>>> +	spinlock_t *ptl;
>>> +	pte_t *pte;
>>> +	pte_t ptent;
>>> +	int ret;
>>> +
>>> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>>> +	if (!pte)
>>> +		return 0;
>>> +	ptent = ptep_get(pte);
>>> +	if (pte_present(ptent)) {
>>> +		folio = vm_normal_folio(walk->vma, addr, ptent);
>>> +	} else if (!pte_none(ptent)) {
>>> +		swp_entry_t entry = pte_to_swp_entry(ptent);
>>> +
>>> +		/*
>>> +		 * As KSM pages remain KSM pages until freed, no need to wait
>>> +		 * here for migration to end.
>>> +		 */
>>> +		if (is_migration_entry(entry))
>>> +			folio = pfn_swap_entry_folio(entry);
>>> +	}
>>> +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
>>> +	ret = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(ptent);
>>
>> Staring again, we should really call is_ksm_zero_pte() only if we know the
>> folio is present.
>>
>> It's not super dangerous in the old code (because we would only look at
>> present an migration entries), but now you are making it possible to call it
>> on even more non-present ptes.
>>
> 
> IIUC vm_normal_folio will return NULL in the case of a ksm zero pte, so
> we can not do
> 	found = folio && (folio_test_ksm(folio) || is_ksm_zero_pte(pte))
> because it will always be false for a ksm zero pte.
> So we should do
> 	found = (folio && folio_test_ksm(folio)) || (pte_present(ptent)
> 		&& is_ksm_zero_pte(ptent));
> since if the pte is present and is a zero pte we can guarantee that
> the folio is present.

Yes exactly.


-- 
Cheers

David

