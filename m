Return-Path: <linux-kernel+bounces-805701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C729B48C75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D396C3B0EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6111E1E1C;
	Mon,  8 Sep 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sau7D/qH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BE78F59
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331927; cv=none; b=NJQc1tkwPLUxKDh3BDSqe0TI3Eh92gL5F0dBDdf/o0OFhDXNc5BgxULbUsPU8J89zqABQvqykDPx8JVcvtysGxF3qF44DxGBvwwsO5HVc+4kUNfShzgTbJuAViTcfAuVYk6i6dR719d7DrmTk9ZOi5+frfJ5G1bCtSobm1H00qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331927; c=relaxed/simple;
	bh=tzk0knxRTE8aiRQ9cykMvi0gv3BQ0zIY+t4NmWjCpuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kK08QzDVu6YzrbqkD83m63gtnnldA2X+PAGEMyZvnMqEnGlJz9be2E24dUImUlqgeIIBzBozpie1Jsz18NioS+KnSxUNRWYfomrl2V4YQKtPxd/WKfhQm0vrAcRW2aTUtnTJF9WeYeaTpHZk6c+p64zyps/LwhCDD+3P016VZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sau7D/qH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757331925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=12h3i1q+WWrHAuJ5iIWUvL4KT2SfI+Lf5biZMpfNNBU=;
	b=Sau7D/qHfF45YVgRifDwT327viYGxUdTb7WxuNb/pJgJb7HIBJ0bvbetiCeBtHeNXUtw58
	xtXMVUH3uLA6BB+xTE7FWv2U+D9Ef3PBl3vvzUITgUQb6K7BJ6uOPYO1qVVTwkpEikUYRj
	NECSBxRZiInj78ZfI9f62d2XQ2MjQGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-mmzzD1nsNq-HOy0Jce2mww-1; Mon, 08 Sep 2025 07:45:22 -0400
X-MC-Unique: mmzzD1nsNq-HOy0Jce2mww-1
X-Mimecast-MFC-AGG-ID: mmzzD1nsNq-HOy0Jce2mww_1757331921
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de13167aaso13362865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331921; x=1757936721;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12h3i1q+WWrHAuJ5iIWUvL4KT2SfI+Lf5biZMpfNNBU=;
        b=PklC37Q+Y52UzJjeIq2O29pXgORYibit61iSeMsxBDVRpjJp1ggzveMXwKPoqjksFr
         Hit8lGg76gEgftd5XEiFYr6XKN25Di3pSvDtkgvOcWD1Pr7/ORTIarrPSNDhDnp5UuzE
         njQZDmWaB5EUW/MKjmfRVGqAzWOdxGoDP/q4/jCvmXAKQkJ5Zc+FGp2qTTtYKlDaqjMY
         g1C/JC9beEHvZWE0avH+D0VwQ8Uyi/SwhOnpdStZkABYEEn7m2uOxOVNd/bOkpKy8fRA
         zkq4Ceow/0BK4gY+yMkyYeqg977icoD8kTBT5W95xfybjlXTUBkx5HZmSeNpapRfBHsQ
         tKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVEjeZtpjP5MNtNUlwIa0/KXCaTJPohSCrrBkmKf7CfyTXwGNV8lkBdmyF/u1CFk05lP1PUfvD8d/fnZT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGB76FcQu1gw47hzjAZzFZ7iiGDTxclIIZs32SePiHfLXV6Znp
	YA7uN4y+f3mKJ57JhdKkZymA5R2EO4Tv0dnW7yFghJCFyrLYt67pCF+r9WndE86lSYH6YP54Wr8
	sqiFOnsGkt269kBUIlBOvB+8vkbm8tBijcWvhnLr+IFXWa3lC1zpg4b6xpUq+cRVDsw==
X-Gm-Gg: ASbGncuv6c5UGkOyUyjMaweeQMTBDTCT83quQo6zsInnt2Sh9W6Y1NrO1uPkFcrq83p
	OH1wqENK+C9KArA0akUbcEdOOHdbwr5FYTaxF6S+rubqW9DEY5JyZ4ZjvhfrHSLcD93kfpOkQqN
	laB6fxpHVm7t/9helJxz/EbS7TYySe3g7py+US9ru47+/02AdUAtIobOu03FjYjN+yFTeuHM1I0
	GVPINWi4mXaTq+wQX6mSNWtyNx10JWQpy0/Uuyx6AqcwKTUDf0hBEFj+LXYVK2Oee11wr6FBH4A
	/tKHEp/cexxM/mzpAyztLfqhq4nQJD6MfbWb+pgQ21NicC0QO3F+LS1knXTpZYlHxXwKrXdd6N5
	6abFQFoaUXz+6lIiEmPiPqldhOv4KUfvVRoFsDSPGYL09fQO5X/Vf6PurBqr0rWPj
X-Received: by 2002:a05:600c:5254:b0:45c:b607:ea95 with SMTP id 5b1f17b1804b1-45dddeeebcemr65061555e9.18.1757331921008;
        Mon, 08 Sep 2025 04:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZMDWEcg53mmAIOa8ZxjdF1reUktiTZGkLpalLwMR7JFbLd43vy4hZ2Zk1Uqm7PJJc5QHe/A==
X-Received: by 2002:a05:600c:5254:b0:45c:b607:ea95 with SMTP id 5b1f17b1804b1-45dddeeebcemr65061175e9.18.1757331920496;
        Mon, 08 Sep 2025 04:45:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de229238fsm73104815e9.16.2025.09.08.04.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:45:20 -0700 (PDT)
Message-ID: <22bc228e-4598-4b5d-ab5d-f9f493a4d961@redhat.com>
Date: Mon, 8 Sep 2025 13:45:18 +0200
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
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-4-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-4-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>

Subject: s/cahe/cache/

> 
> The allocator will reclaim cached slots while scanning. Currently, it
> will try again if the reclaim found a folio that is already removed from

s/the reclaim/reclaim/

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


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


