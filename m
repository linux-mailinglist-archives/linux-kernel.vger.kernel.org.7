Return-Path: <linux-kernel+bounces-820653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754DB7D582
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906E2188D20E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F6337E95;
	Wed, 17 Sep 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOBQCHTU"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE388337E88
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111704; cv=none; b=dIBNvonwxvwCDqH4iymhE6dhzLJY0GImJYqwmtnZPqlhhfT+4gOqjBN8zCvG+EMrfxNiykE6y9LPDOx/smaZ6548fV+xQMh+A5xrpid9D3wqFmB1NJfGx/Y7H9bo+BgleAP3NbZRYSIYkiaALgk1HLoIQDsexE8pJLrXkNOXzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111704; c=relaxed/simple;
	bh=EWjOKSKmochJ0eJb5ohXFltFrh/14MQw7fngFgx0/yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P6olna4qxnXgWKHTo4lDYrmvnbb6JMUwO8aPumgBTPj7QobCAgEKCiRAtCZsVLLiK5x4LTPK7imjeFTXJSjjbGAh8RhehgZip6rKirKz2qX3kBudz6PW4eofxObQwBe0W8VMRM/bC6hj27CteyJFAB2XOzlsMDP36r32gN6eUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOBQCHTU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ee62dcf-c016-4da1-b93e-ca173654a7af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758111698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTrn1iL20oKG8cn8ZNNfsgW6d/NuD2OtCZO3XSRwbVI=;
	b=VOBQCHTUXuPBeS5z9yVNOlGH8Rrxhzvu662V0VhV9k69ucXL/Ur1IhvSZzkKNXhH4OH5la
	zW53X5Rav8OK8R0vj9MUxsDuYCzqTKn9M/qOIbpcJbgBJ1m3rYmK3cCBDE2OE7SO5K5orD
	IFG4Q8rt795RBfU+yLhwAr5kCYbWzuQ=
Date: Wed, 17 Sep 2025 20:21:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksm: Use a folio inside cmp_and_merge_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 akpm@linux-foundation.org, david@redhat.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>
References: <20250916080533.2385624-1-xialonglong@kylinos.cn>
 <20250916181219.2400258-1-willy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250916181219.2400258-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/9/17 02:11, Matthew Wilcox (Oracle) wrote:
> This removes the last call to page_stable_node(), so delete the
> wrapper.  It also removes a call to trylock_page() and saves a call to
> compound_head(), as well as removing a reference to folio->page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   mm/ksm.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8583fb91ef13..47655ca8f9a5 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1057,11 +1057,6 @@ struct ksm_stable_node *folio_stable_node(const struct folio *folio)
>   	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
>   }
>   
> -static inline struct ksm_stable_node *page_stable_node(struct page *page)
> -{
> -	return folio_stable_node(page_folio(page));
> -}
> -
>   static inline void folio_set_stable_node(struct folio *folio,
>   					 struct ksm_stable_node *stable_node)
>   {
> @@ -2221,6 +2216,7 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
>    */
>   static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
>   {
> +	struct folio *folio = page_folio(page);
>   	struct ksm_rmap_item *tree_rmap_item;
>   	struct page *tree_page = NULL;
>   	struct ksm_stable_node *stable_node;
> @@ -2229,7 +2225,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   	int err;
>   	bool max_page_sharing_bypass = false;
>   
> -	stable_node = page_stable_node(page);
> +	stable_node = folio_stable_node(folio);
>   	if (stable_node) {
>   		if (stable_node->head != &migrate_nodes &&
>   		    get_kpfn_nid(READ_ONCE(stable_node->kpfn)) !=
> @@ -2268,7 +2264,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   
>   	/* Start by searching for the folio in the stable tree */
>   	kfolio = stable_tree_search(page);
> -	if (&kfolio->page == page && rmap_item->head == stable_node) {
> +	if (kfolio == folio && rmap_item->head == stable_node) {
>   		folio_put(kfolio);
>   		return;
>   	}
> @@ -2349,10 +2345,11 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   			 * the page is locked, it is better to skip it and
>   			 * perhaps try again later.
>   			 */
> -			if (!trylock_page(page))
> +			if (!folio_trylock(folio))
>   				return;
>   			split_huge_page(page);
> -			unlock_page(page);
> +			folio = page_folio(page);
> +			folio_unlock(folio);
>   		}
>   	}
>   }

