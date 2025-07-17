Return-Path: <linux-kernel+bounces-734876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7FCB08782
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2970F4A65CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86727991C;
	Thu, 17 Jul 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mQEr2T5l"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E6277CA0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739403; cv=none; b=CA4GJtYDVVTubtdqjCmodxwcrxwtT8KoXRzW5ZKiHTGT+NRH9z7IMHddc3wZm5erCZdxgdAuMnxKfDTRJF6fKuLiXQPmRuRAF1nZCtG279+3VZcsVrHod1AcjiBZnBE4AEtp/aqqv/b1mzji/dGBiRysK+LTiEqkR/Q6Q9wZDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739403; c=relaxed/simple;
	bh=VmMkPlsgXMXWs8Jl3pJMvLk/cZ4DuM6SPpw9RKhgyTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcGt1f6oXlzaApSp+155QQqWsgTrw4/Q5lnzsIn3sUqQaudB97ezIjo1bMicvt5M7BqtHCGFEOTvXOA5WB69RgY+AZ+WqrB7u/sseB4tVtYNF+NVd7GbxB9euXgcDt/wwo8zd2CDONcZNNDQDPFn2DlkqhES/pguo++08+bWSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mQEr2T5l; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752739398; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UX7hFbh/TK6YVLzfx5QtF9bfxIcBhjU5F7WclYEe4sE=;
	b=mQEr2T5l51qJF/dAwbwO4/txadQtPkgY+eoRc5BdtIzip4XCa7/vd8KLYnprDzpFZyboUpG8/ndn4U7xvjHtv1gCo7rf4uOhoVugqpyRbYEC7HG+kJ4WjpkwXgWyZkVuJjj53JFeU+xXx9b+Zm5mnuuJKFdVzwHaGLFnJWMZLiY=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wj7QQKs_1752739396 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 16:03:17 +0800
Message-ID: <9ba7c5bd-cb7f-498a-b829-43d26993bc73@linux.alibaba.com>
Date: Thu, 17 Jul 2025 16:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/huge_memory: use folio_expected_ref_count() to
 calculate ref_count.
To: Zi Yan <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-3-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250714171823.3626213-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/15 01:18, Zi Yan wrote:
> Instead of open coding the ref_count calculation, use
> folio_expected_ref_count().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

Looks more readable. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/huge_memory.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a7ee731f974f..31b5c4e61a57 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3735,6 +3735,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>   		struct address_space *swap_cache = NULL;
>   		struct lruvec *lruvec;
> +		int expected_refs;
>   
>   		if (folio_order(folio) > 1 &&
>   		    !list_empty(&folio->_deferred_list)) {
> @@ -3805,11 +3806,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		     new_folio = next) {
>   			next = folio_next(new_folio);
>   
> -			folio_ref_unfreeze(
> -				new_folio,
> -				1 + ((mapping || swap_cache) ?
> -					     folio_nr_pages(new_folio) :
> -					     0));
> +			expected_refs = folio_expected_ref_count(new_folio) + 1;
> +			folio_ref_unfreeze(new_folio, expected_refs);
>   
>   			lru_add_split_folio(folio, new_folio, lruvec, list);
>   
> @@ -3839,8 +3837,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		 * Otherwise, a parallel folio_try_get() can grab origin_folio
>   		 * and its caller can see stale page cache entries.
>   		 */
> -		folio_ref_unfreeze(folio, 1 +
> -			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
> +		expected_refs = folio_expected_ref_count(folio) + 1;
> +		folio_ref_unfreeze(folio, expected_refs);
>   
>   		unlock_page_lruvec(lruvec);
>   


