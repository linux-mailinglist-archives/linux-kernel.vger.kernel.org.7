Return-Path: <linux-kernel+bounces-804975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE55B48289
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DF4189B924
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F799183CC3;
	Mon,  8 Sep 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wUvIXf5n"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531FEACD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297799; cv=none; b=sBJYicrCtmtiABxeDwiSH3zttiEXrQsIPHJavCLI/96gBTVTtQ7Pb/G4rSq/lNCswESm6zc/w/XKduk/Q47fpRCEqBQrlrSqNUIgc+/xBDlmQmLa6xB0rbOgro8twwB1sJgcYXaiWcAEMjUorsO8Y29vG5Ha+B90CClJLC5bVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297799; c=relaxed/simple;
	bh=cbebP3iamLLelzq/LH5SdLX7gKEz2bJRaCNkdg94v5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL7FEQcR2J1gtvvJkY5lHXCaqija0aK23sPk2qPFgZR0pUiH6jcl9b3t29AgpUY+M2Gf6ayA+p/yHDq3P/BSqOaR5YEAcVXpeeMC8HSd2uVS1ATJ5ki0wQOk6SMZWKNono5GFVsyTGEp13djmjAhc8vIHK7CKIo3ih/yQlp+AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wUvIXf5n; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757297788; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fSRS+R1XjsTFSUxoGD2Q9a4ybrs4HDjecpHqO6RVh1k=;
	b=wUvIXf5nuETDaTveafAgCXqmQuumqXnvGyeV4zUaBg8Ext0T38qi9I47ppJbWWUqikaJmec0UfwPvwoND9JOa7WkwJpkd6f8T9BujnZbjuxYvYufv3Sji85VUlx3oGu3dZGBW4TvMdZ2Stf5PeLzrUtZfk5ghbPZNsc/z7dpt6k=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQBVtb_1757297786 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 10:16:27 +0800
Message-ID: <d86ea841-b18e-4f6f-902e-0763492f5aeb@linux.alibaba.com>
Date: Mon, 8 Sep 2025 10:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>
References: <20250905141137.3529867-1-david@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/5 22:11, David Hildenbrand wrote:
> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
> 
> However, assume we have max_ptes_none = 511 (default).
> 
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).
> 
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
> 
> So let's remove that early exit.
> 
> Do we want to CC stable? Hm, not sure. Probably not urgent.
> 
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
> 
> Easy to reproduce:
> 
> 1) Allocate some THPs filled with 0s
> 
> <prog.c>
>   #include <string.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <sys/mman.h>
> 
>   const size_t size = 1024*1024*1024;
> 
>   int main(void)
>   {
>           size_t offs;
>           char *area;
> 
>           area = mmap(0, size, PROT_READ | PROT_WRITE,
>                       MAP_ANON | MAP_PRIVATE, -1, 0);
>           if (area == MAP_FAILED) {
>                   printf("mmap failed\n");
>                   exit(-1);
>           }
>           madvise(area, size, MADV_HUGEPAGE);
> 
>           for (offs = 0; offs < size; offs += getpagesize())
>                   area[offs] = 0;
>           pause();
>   }
> <\prog.c>
> 
> 2) Trigger the shrinker
> 
> E.g., memory pressure through memhog
> 
> 3) Observe that THPs are not getting reclaimed
> 
> $ cat /proc/`pgrep prog`/smaps_rollup
> 
> Would list ~1GiB of AnonHugePages. With this fix, they would get
> reclaimed as expected.
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Thanks for sorting this out. Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/huge_memory.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd74189..aa3ed7a86435b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>   	void *kaddr;
>   	int i;
>   
> -	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
> -		return false;
> -
>   	for (i = 0; i < folio_nr_pages(folio); i++) {
>   		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>   		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {


