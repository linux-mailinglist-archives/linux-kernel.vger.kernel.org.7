Return-Path: <linux-kernel+bounces-826580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109EB8ED8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6254173143
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AC72613;
	Mon, 22 Sep 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JWXFAQpM"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22473111A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511159; cv=none; b=QrtCeJsVUT+zBNBIpnoSGrdotzTGlrVdzY0lHgVs5IFf/8L/bwyh1cRfKaNstyp1DkOpgaqDH0rdTG139GwFT3ZE6lkiEmGeyf2hpdlGe1QJW2gdFhXbtiQ98Epzdb8PtjQBJXjAKQt6kr/Twnyz+/iDSuhE4V9RrqqGkoXhnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511159; c=relaxed/simple;
	bh=NN7TcVLfwuKbEEKbBUqOTme7y9Thl55C9gCv67aQbP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncfE7QA5+4Ps0lHTi89Gy6Md8nfPC8ipb394PPiU85Ddfn2SNx9EqD5xOGdP3CVrEsYbsXpNt2E+bqA3jSQZYeC4DGTcSdxSviz1Fav3n1OJzcQhAfqxCrznvq9QBY9nouwSQuRyvyguSonwHFMEthshMlCLtQppdsCAvVajDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JWXFAQpM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758511147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z1xv7n2dNrf1sQprqQNalsEEZ9e1L86/2wWKLGMKTYE=;
	b=JWXFAQpMC2t9tmtlU7NDsydDhHNdpI9NN9o7YQRmU2EiyCzcNLnDMnm1gxKRkO75SSeOXfE3UV7cBdfD6o8Qvs4qAkqo4ulpKj3EC3661Zr6CW1cBB9DO6kJZcUv0I5hK4hkqZR8yrHT/wv+mLIZq4dTipoq5LZXFhHvPKk1IEg=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoR4wP2_1758511144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 11:19:05 +0800
Message-ID: <ddb7a9f8-5516-4bf2-8bd7-3761f133bc6b@linux.alibaba.com>
Date: Mon, 22 Sep 2025 11:19:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/5] mm/fault: Try to map the entire file folio in
 finish_fault()
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-5-kirill@shutemov.name>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250919124036.455709-5-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/19 20:40, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The finish_fault() function uses per-page fault for file folios. This
> only occurs for file folios smaller than PMD_SIZE.
> 
> The comment suggests that this approach prevents RSS inflation.
> However, it only prevents RSS accounting. The folio is still mapped to
> the process, and the fact that it is mapped by a single PTE does not
> affect memory pressure. Additionally, the kernel's ability to map
> large folios as PMD if they are large enough does not support this
> argument.
> 
> When possible, map large folios in one shot. This reduces the number of
> minor page faults and allows for TLB coalescing.
> 
> Mapping large folios at once will allow the rmap code to mlock it on
> add, as it will recognize that it is fully mapped and mlocking is safe.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/memory.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..812a7d9f6531 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   
>   	nr_pages = folio_nr_pages(folio);
>   
> -	/*
> -	 * Using per-page fault to maintain the uffd semantics, and same
> -	 * approach also applies to non shmem/tmpfs faults to avoid
> -	 * inflating the RSS of the process.
> -	 */
> -	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> -	    unlikely(needs_fallback)) {
> +	/* Using per-page fault to maintain the uffd semantics */
> +	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
>   		nr_pages = 1;
>   	} else if (nr_pages > 1) {
>   		pgoff_t idx = folio_page_idx(folio, page);


