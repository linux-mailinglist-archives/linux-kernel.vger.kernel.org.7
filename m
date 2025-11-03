Return-Path: <linux-kernel+bounces-883400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A25C2D557
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A4189D866
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A131B117;
	Mon,  3 Nov 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbbflDRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51E31AF2D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189213; cv=none; b=jE4pEP2N9QaA0G6Hizz0/shjH8m9qdDXTKmJfFjiFqIqWkdmojudk64XSjBPWK5dbTwUMWa0y28URid2Aw+6xtP6m6ZU1MztRj2wXg1J+xgSpFL65cDN3m7sn4DDVxgMd6X1QmkSFhCe1kznX3MhEf5hGXZXn2mujmrrWNOb6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189213; c=relaxed/simple;
	bh=zEvKfyASQ6FHSygxdwigaZ1gT1SuO69TZOAMJ+IO8IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnsKavca+Ub0dkrwWD2AdrfBLv3A+wnmhI8QotVitoiOsnvxeVjTOQaIqKlZ8/XozftAbls91G0TdiaNmoJFjW5ATqc3Ept1T5oytXkBLGE3/c1vuF9Jv49FO/VG0kJE7REoxVO6W9BI3eVeSXjDqWV6q5DXq5PvcyapyZELKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbbflDRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80385C4CEE7;
	Mon,  3 Nov 2025 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189212;
	bh=zEvKfyASQ6FHSygxdwigaZ1gT1SuO69TZOAMJ+IO8IU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbbflDRg+0BR0YL6QHTy3QksF2c/O8W207w9FOACd/Zk1zT848lDh2gt8mYj1nXGX
	 Z2Vc/yHX9GE7EgQSjmBVq6lu0us3oghlHfBw6ISuqW5wPEyHUm7cHA8zGWQkemCL7j
	 V2T/ztc28gaosH57atQLsv9GwD0s64gEkP97Uksh3AfgxufT43f3tbkKXr8ge9MMlO
	 rytBFsyMQTnTbUVwxZ+XJKQYFkDGwIXj8J+n3HLcCUt1tumrExhmZFQvBVYtHQ6i4U
	 DZouGTA2k070rcrxK+vjZ2z+tp+7YQcNLd9nG7WTTWI9JaqZbEnz6N8QWJ2tZo6yQS
	 3ueBx489Gd6Ow==
Message-ID: <a6574561-02bc-4ba6-9fb4-418dcb07cd5f@kernel.org>
Date: Mon, 3 Nov 2025 18:00:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-2-pedrodemargomes@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251031174625.127417-2-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
> This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
> function break_ksm_pmd_entry() to use folios.
> 
> This reverts break_ksm() to use walk_page_range_vma() instead of
> folio_walk_start().
> This will make it easier to later modify break_ksm() to perform a proper
> range walk.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4f672f4f2140..922d2936e206 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	struct folio *folio = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte;
> +	pte_t ptent;
> +	int ret;
> +
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return 0;
> +	ptent = ptep_get(pte);
> +	if (pte_present(ptent)) {
> +		folio = vm_normal_folio(walk->vma, addr, ptent);
> +	} else if (!pte_none(ptent)) {
> +		swp_entry_t entry = pte_to_swp_entry(ptent);
> +
> +		/*
> +		 * As KSM pages remain KSM pages until freed, no need to wait
> +		 * here for migration to end.
> +		 */
> +		if (is_migration_entry(entry))
> +			folio = pfn_swap_entry_folio(entry);
> +	}
> +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +	ret = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(ptent);

Staring again, we should really call is_ksm_zero_pte() only if we know 
the folio is present.

It's not super dangerous in the old code (because we would only look at 
present an migration entries), but now you are making it possible to 
call it on even more non-present ptes.

With that handled

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

