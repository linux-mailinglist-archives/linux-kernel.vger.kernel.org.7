Return-Path: <linux-kernel+bounces-798392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5B41D37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AE1BA34CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C32FB63A;
	Wed,  3 Sep 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4rp4fGi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703422E8B8F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899720; cv=none; b=HB76PSHoYHDy7tE4eHKRZEOotNigHEYeHt6PXN1GdUu+G14Us/Pxk2Gz8BJ4sN6XycoBZvSkXCy3/XnQlQ5YTCNunLJs44QyvFESgK/0bU/+hnNMuND7znzqMBxVH+x5XyYeoCR+aFT+gkMmkyhV0wUjdUCRQa4atwDlyqFjQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899720; c=relaxed/simple;
	bh=AttjftpIlWTMjrmdF9wMYjBnAYiIrsYBLJ8og7M5z+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9h/AcHVSZZCujAwK1qlNhoz+VcBEZ26xK6hFhODY0jpwa09t784adxcEqYRI6dLE3fgKThRSbTt6KI/NN+9JCJSZQFNWJvg2Niixk1l92fchEag8GoEhvVLO3NzoBnBmLLVLZ1y+Ia39vPHcJXyvsr+g+OUpYkrOjhSKESM6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4rp4fGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756899717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4KMh+msjlWjAAiN7LUASBzCncpFiuu1P0ADJ3l6og1A=;
	b=Z4rp4fGiZuA/oTfOfYoOqXgVeRrnwYYLnaSsUOVxQ+TVPN86bJV6nlqNwqeW7skWClZO/+
	vYtmdOOTarYQVibVqH17KOm3ZklOvlwj4h/KTuw5ZBJJ2aTnroSXOPDjQ8E9/GP19KkXsK
	DMoObhO6cSFKHDGofVXvrEpeHCtTNKE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-mEZtBBQGMRCwxPh9fxlGlQ-1; Wed, 03 Sep 2025 07:41:56 -0400
X-MC-Unique: mEZtBBQGMRCwxPh9fxlGlQ-1
X-Mimecast-MFC-AGG-ID: mEZtBBQGMRCwxPh9fxlGlQ_1756899715
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb612d362so3301685e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899715; x=1757504515;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KMh+msjlWjAAiN7LUASBzCncpFiuu1P0ADJ3l6og1A=;
        b=tlJqB3928XFM9uk8XlJd999XcyJoXQu8cGbmm7zspyeaBf4s6dl2Oq/4MAIBPQxAyv
         CSs0AXMwnKlB85ozYttG/n7NYi+e4Dxqy/3MqRdvitmEM/62WETjJGZEFZRyJBwMDZrt
         Qh4Imis0yMTDFIAifo80/zljzb5hdMjmRL/z/INZNc+KRpdyPoGnWfbxFL+W+ZoinnxC
         /yXoYNlns76/3DR/LR+mdlKuxhGgKzLU6KZDCkZfYSJsbijnKSBk0g+xyNrv/gP2xfNV
         Vyg8Jhb6TQ+b0KIknM5JXaCEvKUny6t5IHmyZ2m+hYJoCTxjclvicEqYOsby8N1fdTxx
         s1mA==
X-Forwarded-Encrypted: i=1; AJvYcCXOgORhl4isTAt3rt/TphzIp4TxhxI3/lgswIrcUeDETnXjuWAIi5QbDCXlq1VeC9/TW5tV7pkv3zB2J04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSlXtTPVNEqknP072xrd7shHyhiY/xNeY3c0DImpYygL6BsQK
	RQ4pZNjB9RRyTkZo4KPMOpVB02t76aswq5Rj5658T+p0U64FIgREhuTbe6ipArQuVtOTKxSzvGi
	o2hXBEQZrMi7+Szp9Rn/CrRZGZDkNE1wOp4t4D2XrVK3mKx/ucsK5TV6C+9kQQtKUQg==
X-Gm-Gg: ASbGncv2Y2zk0jaqtZIHvo1flKfl3nAMbyFfRuy5lxHrMJ6aNFbavwFevBRqatYEUaG
	rRo1hs+FC9TKssc23ZAsrHTOGRpQoCwuVl5FSyBUrFEVTb9RgcBR8IIs/5v4PDolHC92a1hHcNu
	v/xR5N2tZygnTtLZJUlxkcBsl0nrAh3D5fhndQ9klkKDCNIeuIrCYHU1RFhF7D5QiUJar9ec9pg
	QugUehqZDANSeI37OqI9WKyqnPiQxgsmuwTapzt+QzPEoJERJiMQGDmnSK2/mXfxt8q1lAwto9N
	IWd9rMiKFDxhwK+OXmGVCgrrQgoSttnsQ/PfShvQzCnpnW/vUcvtuR5o7UpvaAPA6TlJj1w2hDw
	SBoXYa0YwaJSdEiDA4slJpb5NK15EhfeMh3dFLQR50SiL/eV8xtBIlQn3s8RIv0w2fZU=
X-Received: by 2002:a05:600c:45c5:b0:45b:6743:2242 with SMTP id 5b1f17b1804b1-45b85589b3dmr118701005e9.22.1756899714894;
        Wed, 03 Sep 2025 04:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqUsv0e978RuPQhn9L5U2SWoNAaH42axVs7ma0k0ctki4Md+nreA0VWitzkHEepAHW3hF2Dg==
X-Received: by 2002:a05:600c:45c5:b0:45b:6743:2242 with SMTP id 5b1f17b1804b1-45b85589b3dmr118700785e9.22.1756899714411;
        Wed, 03 Sep 2025 04:41:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm60339495e9.6.2025.09.03.04.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:41:53 -0700 (PDT)
Message-ID: <c492b99e-b6fb-4da8-8055-1e93c6141a12@redhat.com>
Date: Wed, 3 Sep 2025 13:41:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
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
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-7-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822192023.13477-7-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Introduce basic swap table infrastructures, which are now just a
> fixed-sized flat array inside each swap cluster, with access wrappers.
> 
> Each cluster contains a swap table of 512 entries. Each table entry is
> an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE),
> a folio type (pointer), or NULL.
> 
> In this first step, it only supports storing a folio or shadow, and it
> is a drop-in replacement for the current swap cache. Convert all swap
> cache users to use the new sets of APIs. Chris Li has been suggesting
> using a new infrastructure for swap cache for better performance, and
> that idea combined well with the swap table as the new backing
> structure. Now the lock contention range is reduced to 2M clusters,
> which is much smaller than the 64M address_space. And we can also drop
> the multiple address_space design.
> 
> All the internal works are done with swap_cache_get_* helpers. Swap
> cache lookup is still lock-less like before, and the helper's contexts
> are same with original swap cache helpers. They still require a pin
> on the swap device to prevent the backing data from being freed.
> 
> Swap cache updates are now protected by the swap cluster lock
> instead of the Xarray lock. This is mostly handled internally, but new
> __swap_cache_* helpers require the caller to lock the cluster. So, a
> few new cluster access and locking helpers are also introduced.
> 
> A fully cluster-based unified swap table can be implemented on top
> of this to take care of all count tracking and synchronization work,
> with dynamic allocation. It should reduce the memory usage while
> making the performance even better.
> 
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

[...]

> @@ -4504,7 +4504,7 @@ static void filemap_cachestat(struct address_space *mapping,
>   				 * invalidation, so there might not be
>   				 * a shadow in the swapcache (yet).
>   				 */
> -				shadow = get_shadow_from_swap_cache(swp);
> +				shadow = swap_cache_get_shadow(swp);
>   				if (!shadow)
>   					goto resched;
>   			}

This looks like a cleanup that can be performed separately upfront to 
make this patch smaller.

Same applies to delete_from_swap_cache->swap_cache_del_folio

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47cd3bb649..209580d395a1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3721,7 +3721,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   	/* Prevent deferred_split_scan() touching ->_refcount */
>   	spin_lock(&ds_queue->split_queue_lock);
>   	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> -		struct address_space *swap_cache = NULL;
> +		struct swap_cluster_info *swp_ci = NULL;

I'm wondering if we could also perform this change upfront, so we can ...


>   		struct lruvec *lruvec;
>   		int expected_refs;
>   
> @@ -3765,8 +3765,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   				goto fail;
>   			}
>   
> -			swap_cache = swap_address_space(folio->swap);
> -			xa_lock(&swap_cache->i_pages);
> +			swp_ci = swap_cluster_lock_by_folio(folio);

... perform these cleanups outside of the main patch. Just a thought.


Because this patch is rather big and touches quite some code (hard to 
review)

-- 
Cheers

David / dhildenb


