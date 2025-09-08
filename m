Return-Path: <linux-kernel+bounces-804994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3535B482CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6233B7D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD111FDA92;
	Mon,  8 Sep 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rTzwgXpu"
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5A188713
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300949; cv=none; b=nh/Sco9o+LKpvV3y511/AvLW6kWkv1Rmbnz/b5YC/NnNyQEd58sLq75mzDS5IG/UTcKP0r3ryZGENlXvigx7dSj6TyDG9pDDczJ3mL79j5i5vP6IhkHBXReTYxZShKuVEGp/aKsr0+AYWtV1M2RLoV78JZotLa/MKtzIAv6HWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300949; c=relaxed/simple;
	bh=Xu1ylK93WNSaZBtxACzTqgWi2Pr1dvVj42ia55A6zi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4Y2no4tbjYs/bXfbVC1mihjKYydsr78AJ0GpM/vS81ez8BMnfXAUA3JAEKPZsGYaas3m5gjkusgtBmRCs+5/3N2fBwkRIIpBh6BFTQePUGgciPuhtriBqLQuYUZvcTn3zjh+hgdmizrVqhCGPCxSUrfssob6PaLfK8cAs50dPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rTzwgXpu; arc=none smtp.client-ip=47.90.199.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757300929; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EKxx/lX3Bp4VW+ItJ7z/ma4EcEpYpmczHseAhd+atyg=;
	b=rTzwgXpuF6wQ6jCQ7lvKPIPDg2fLAGyHaXZFUNv6JipJz5CzRhPf6kq4goHKupdG6G396MxwFY1fccJMq/gc8djTZubrVpBUka+/G31Ii+LH1DkuMiTb2aWcvS7TKh76uN5y+27oxtSQezDob1jQCW64PVhJ4Z1DFw6mroqTdwc=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQW09W_1757300926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 11:08:47 +0800
Message-ID: <f963d067-f64c-4891-b32f-31449748ace6@linux.alibaba.com>
Date: Mon, 8 Sep 2025 11:08:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-4-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905191357.78298-4-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/6 03:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The allocator will reclaim cached slots while scanning. Currently, it
> will try again if the reclaim found a folio that is already removed from
> the swap cache due to a race. But the following lookup will be using the
> wrong index. It won't cause any OOB issue since the swap cache index is
> truncated upon lookup, but it may lead to reclaiming of an irrelevant
> folio.
> 
> This should not cause a measurable issue, but we should fix it.
> 
> Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/swapfile.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4b8ab2cb49ca..4c63fc62f4cb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>   	 * Offset could point to the middle of a large folio, or folio
>   	 * may no longer point to the expected offset before it's locked.
>   	 */
> -	entry = folio->swap;
> -	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
> +	if (offset < swp_offset(folio->swap) ||
> +	    offset >= swp_offset(folio->swap) + nr_pages) {
>   		folio_unlock(folio);
>   		folio_put(folio);
>   		goto again;
>   	}
> -	offset = swp_offset(entry);
> +	offset = swp_offset(folio->swap);
>   
>   	need_reclaim = ((flags & TTRS_ANYWAY) ||
>   			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||


