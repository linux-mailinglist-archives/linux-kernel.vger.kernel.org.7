Return-Path: <linux-kernel+bounces-813424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F3B54531
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61B51CC2676
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74DC2BD034;
	Fri, 12 Sep 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXi/9Yxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E782DC780
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665466; cv=none; b=Lpa//oqYfWNWMNGXGmAL9jqADzjfU00vS2pJt/thccI40kOGLyfEiPxJC1xx5/g8PFei1iAcyd4+fe5mS8fm6DJ9YromDz5H+wjZicc3kaWYieg5yaHWvzUj3F7DUihfBSknNFuSHQ9GDyrhuhzbALbzh0n8zyTsFUXi3hlZRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665466; c=relaxed/simple;
	bh=QYUTLzKNXuRkVAVKRUCJTkFjQsiRVsEtXxp42cMgHR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6sBxGXUOUi+DH3lqhbM1hK5VqGMKDFhts++TFtbZmb1Y4C5v1y6xnBps4BACHjq/hmwvpKAJU9mWjh8EDLvkegyIKlyhSNHbWI4ozebJMW+TAp58EkI3OTyEQp6y4hNHzQmJw2KIN5bjn+A2wt8iyaQzfWF8ydS2187SDWXvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXi/9Yxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757665462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OERP3s+HsoQqm9aRx8/J4R+MRYy1jJD/+709XoPt+H0=;
	b=eXi/9Yxqf27SpUHF/Xh2fBNTdw9XZTp1K8u5uOWsdKNUbX/iTnBY+Svio2p+a1ICmEGIXS
	Uw4iCuTYKF9voqxsa3dKot43sLtQRSZGgobG8WPQ0bkDXNCAkipvjCi0fEYYrmLJ933EZc
	D0qQgwmiwKauSh+WA0UBbmnMxeVB5u0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_Z0l6hnDOQKeqVZ-DKllbw-1; Fri, 12 Sep 2025 04:24:21 -0400
X-MC-Unique: _Z0l6hnDOQKeqVZ-DKllbw-1
X-Mimecast-MFC-AGG-ID: _Z0l6hnDOQKeqVZ-DKllbw_1757665460
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df19a545c2so1239562f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665460; x=1758270260;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OERP3s+HsoQqm9aRx8/J4R+MRYy1jJD/+709XoPt+H0=;
        b=KBnxqrtwx8xKLUbmDP7t6dqP3vC9vVVsCcdoXOuLxbwNnkeBuhYw7OnK5e5VazbQ9c
         dJJ2DPfy0hYjCSRcrdOLs8tAVJV1QGsALtfOmKRIBnXsHzTWt6MOLokPN7t1TUDnXCa9
         qE/6mCPFHlOvt9wbrKydfOuJg9SjqFhUBpZPvCYN8rZbavaMOjDGBnzQ+Fd/Ucl76HTE
         NFn3Iqoc2rbdzvYJzxFTC9UvVDFqLcRkw5b5r+OR4Ij60oncmb1Vs3df30r+q1HQjvWE
         GS7I+XuRcAs/KoJiqode0ESDsHS7F09Sq3laz/6gmGhdJetJIKyCpp2g/EaYb3xFrS7s
         iWeg==
X-Forwarded-Encrypted: i=1; AJvYcCW0bro6J+l863/LzyEUOuMcvFlvus0Lc5mI9dwnVMmEc9w7vgwkNhAnxWD2MTiekjqZbKYsY8rhMWHU+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrE9gpskSkq8mGFlv45ndKBj6a/VrXSmSVqY2KTKhsykZWkRR2
	++XSO2HootEculh/OCsGe6fmu5UQHPx7R0jqSUlBnaeIDQyCp/4gS/TPpxFmoF/dt/WQn2IdYHl
	FwHBkWnObM5gP5URMl/I3wGfyLvnlk2CnsfwpObfCDlVFZs8H3/cFfHRJedT/rdwgQA==
X-Gm-Gg: ASbGncsoq6D6OSf+B1FI+Y9SQ6LBnD7lYK5N+7M88VMrMo+8JaxH5YYMiusgs4OR6ou
	EwAX30WxrxPuA3AHhs0CCs4ux6z/InQIw0X/szOn+ZObyA8DzmN4n5PopS3caaa+P+T0Mq2fZSg
	YtIRGNgKFosK0Kntd79RY6jPDtOUhR99VH8hz9EZmt6jxhpX+DXZhBoawLikdAVuqXQTWEUy6T7
	BYRI0Jp9+K7ntJGMEqrlABbH1vHD3Cg+6Tydlg+dUSPvRvPaBvCoHP31L4pRhr6A6IObLgmkQYa
	cVPWBzrAVskFwd9FlBkx+Eo4JhSNse/329TukX64KfxB9HeWKxtV3BjSwgupUsFL6UBKSuP3n90
	p2plb/O0IMgqcd3JBo0RcUr/K8DScuSczuXkQG+yuLu7aKSDbC8Ftxcq6Alr5Ox66mdg=
X-Received: by 2002:a05:6000:2f86:b0:3e7:621f:3c with SMTP id ffacd0b85a97d-3e765782ef0mr1755969f8f.2.1757665460241;
        Fri, 12 Sep 2025 01:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1YaEccAO71A8DCQ7XHaGqymyxjjI77x/k2QkuVBPeOIbCNkG9xCJ6OZqQ1xCk1Xdximme1g==
X-Received: by 2002:a05:6000:2f86:b0:3e7:621f:3c with SMTP id ffacd0b85a97d-3e765782ef0mr1755940f8f.2.1757665459770;
        Fri, 12 Sep 2025 01:24:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm5526467f8f.39.2025.09.12.01.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:24:19 -0700 (PDT)
Message-ID: <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
Date: Fri, 12 Sep 2025 10:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 05:45, Baolin Wang wrote:
> Currently, we no longer attempt to write back filesystem folios in pageout(),
> and only tmpfs/shmem folios and anonymous swapcache folios can be written back.

Can you point me at the code where that is fenced off?

I can spot a folio_is_file_lru() check before we call it, but the 
description tells me that there are indeed ways we could still pass that 
check for file-lru folios if we are kswapd.

> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
> which means no fs-private private data is used. Therefore, we can remove the
> redundant folio_test_private() checks and related buffer_head release logic.

If that's indeed the case, do we still need the folio_test_private() 
check in is_page_cache_freeable()?

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/vmscan.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f1fc36729ddd..8056fccb9cc4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>   	 * swap_backing_dev_info is bust: it doesn't reflect the
>   	 * congestion state of the swapdevs.  Easy to fix, if needed.
>   	 */
> -	if (!is_page_cache_freeable(folio))
> +	if (!is_page_cache_freeable(folio) || !mapping)
>   		return PAGE_KEEP;
> -	if (!mapping) {
> -		/*
> -		 * Some data journaling orphaned folios can have
> -		 * folio->mapping == NULL while being dirty with clean buffers.
> -		 */
> -		if (folio_test_private(folio)) {
> -			if (try_to_free_buffers(folio)) {
> -				folio_clear_dirty(folio);
> -				pr_info("%s: orphaned folio\n", __func__);
> -				return PAGE_CLEAN;
> -			}
> -		}
> -		return PAGE_KEEP;
> -	}
>   
>   	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
>   		return PAGE_ACTIVATE;


-- 
Cheers

David / dhildenb


