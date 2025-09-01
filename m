Return-Path: <linux-kernel+bounces-794043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C7B3DC11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4628C1750BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB52EF677;
	Mon,  1 Sep 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLPEkaqU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29302F0660
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714439; cv=none; b=BUDsvkD7CEDHCCGouH3VGAVFg/lp5cy6gXDkywxDsP7G6FkaJxcjbKHJXlVddoc8UOGx2wWg+f8n/onBlO853s0k8muw8PjRFXTZVXYsxxQge85E4UiF1+7lZRwBAcH9jpQ0jUJK14ed5N+dLKbNOm4CS9XtTEXFloSVQMh+7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714439; c=relaxed/simple;
	bh=BAfTn9p3P1YUWNaataF7IvbHJ59bst86dTPIPjA4Zok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNQkspe65pfH6nEQpP771kG6cZWrjVXiUBGrxAC+zAxqTI8zcDZ8exJSKpqMQZNsrvI2fPduZYlhR7ITrkfwmt+FYHvvqNLVJlUWT6UQ8IsX/4U0E7EcNz4IYgTmpJxb0KXf/CD1Gm//awpnR01OL5H0SdgNTORJFPdq4DZyedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLPEkaqU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756714436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X5b17MvTYOYiz7nd1INMHbVaUmIAu2Q8XQbX6U7l4O8=;
	b=iLPEkaqU+lnlcBlif7vaRBKvByFc3ID2s0l2DWV+RKKDR8KJl4pq3OQVZzhzvE5s+SDGob
	r5kXrrv48t70V96IL2zwLZm3PpayrxNt0SRSoU0RS5R2mtfMMBYTcdvAMYBIugXMLtjnT0
	gy7Uc5ULCWZTkHLf0cPpAhGdK7sLzWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-9F2CfdySP2WQk90yexiviw-1; Mon, 01 Sep 2025 04:13:55 -0400
X-MC-Unique: 9F2CfdySP2WQk90yexiviw-1
X-Mimecast-MFC-AGG-ID: 9F2CfdySP2WQk90yexiviw_1756714434
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ce059e3b83so1586079f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714434; x=1757319234;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5b17MvTYOYiz7nd1INMHbVaUmIAu2Q8XQbX6U7l4O8=;
        b=C40tUKv2Q2G+EbixSmrtWE8T/9tVLMjtCYvpHadFnE/S6X5eYXKmUneBI/pVwedmRw
         76JfmA+FJ957xSIYwL83gak7qXkw409W1G6an7SlbkvNQypuJIirzcqcAjT8JecokBpc
         qH3FgWdHhSzM9KLp83j+Rgp64mRuNx6T6a6agNIuJ+1q00j8kAPfFiAG1YtI55VeUE/s
         S/4+nvvTiO9L7VtbMx/CubO0wkgpu2xpM8dh4HKdMEcA4esWVX0qMDm7n0pD9uEz7piI
         jR3kaJ9Vl82ihl98C6sjDfsyM+lmSBSeDDKw/4kSiFLhOdv7blmVdIHiI+KzZ+JOrHO/
         gFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuo4/ZvrxcftVZVUhfc9QPNVhNNEiU/RZqkUyY3SKo6nLpbO6Vqi0L58K5ZE+fFoQco+RaeXN6Iq5Z2zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0r+4DqLOWd+B7ZSPQa0aJaM5Bthc0Mad3Nknh2aYSB+zccSW3
	d3gyUvfagJ3/FI4AXzHHtwsk5FMK3k3O4b4HjMTiPIxI6GWEcqNoDeWYkGuLdExzpXDFX/3ribN
	whFE2ITxPhszzj1eMK2UsywMR9VtX8bHJcnSg3aaU8pEKg7YudJK/vcUNcVR3KYS3wA==
X-Gm-Gg: ASbGncu/EUQ6k2ykEfB0k8ort4qTW0ealNnL7uZEhj6kkfYphxxIx/Tu3vngsB4kF3+
	KzfXWwpDXS43wAWPA3Ejb54D47Ubh7kkOg3RxJuZKzBq2NZ8VDibn1FBVuGAf33SxO7awMS0XwO
	wE0dbwnvbznZUeYke1wrBRn8LmHCecSZdM/s0Jy5sy77s2KnAPGJKE+cY/xsUixRHfP+hSP4vB7
	ryG8/g6sBcN8axLo4FAYtoTtiHLtXa/2QneOhx8nvHgJWXeFuA8kC0FxcPGnVJjM1NW5pkVeqhW
	YMGjkfU28u+wshZooSdEyGkqxU6EfgrGGQyCSPlQl0iHgUQ9HBlfDQsDbWMpMkQnx8VsmiIhQaR
	TiYvi2MEoBIrPKDXTgWvhH7AoMRyaUD2lgy3CELwX/U+1tDtXBsa+ZNEV+S1E5czUt0k=
X-Received: by 2002:a05:6000:25c1:b0:3c9:469d:c087 with SMTP id ffacd0b85a97d-3d1de4b9a49mr6221191f8f.25.1756714433516;
        Mon, 01 Sep 2025 01:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO8tCu8gSVb6DBj+dyA9n9YoVsr5U3h2wTWJqo6mymjQ9wdVl2hktM0AWeXUSMDIMj92bqIA==
X-Received: by 2002:a05:6000:25c1:b0:3c9:469d:c087 with SMTP id ffacd0b85a97d-3d1de4b9a49mr6221145f8f.25.1756714432896;
        Mon, 01 Sep 2025 01:13:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66bbcf19sm137207905e9.4.2025.09.01.01.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:13:52 -0700 (PDT)
Message-ID: <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com>
Date: Mon, 1 Sep 2025 10:13:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm: folio_may_be_cached() unless folio_test_large()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 11:16, Hugh Dickins wrote:
> mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
> a large folio is added: so collect_longterm_unpinnable_folios() just
> wastes effort when calling lru_add_drain_all() on a large folio.
> 
> But although there is good reason not to batch up PMD-sized folios,
> we might well benefit from batching a small number of low-order mTHPs
> (though unclear how that "small number" limitation will be implemented).
> 
> So ask if folio_may_be_cached() rather than !folio_test_large(), to
> insulate those particular checks from future change.  Name preferred
> to "folio_is_batchable" because large folios can well be put on a batch:
> it's just the per-CPU LRU caches, drained much later, which need care.
> 
> Marked for stable, to counter the increase in lru_add_drain_all()s
> from "mm/gup: check ref_count instead of lru before migration".
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>   include/linux/swap.h | 10 ++++++++++
>   mm/gup.c             |  5 +++--
>   mm/mlock.c           |  6 +++---
>   mm/swap.c            |  2 +-
>   4 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2fe6ed2cc3fd..b49a61c32238 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
>   void mark_page_accessed(struct page *);
>   void folio_mark_accessed(struct folio *);
>   

Two smaller things:

(1) We have other "folio_maybe_*" functions, so this one should likely
     better start with that as well.

(2) With things like fscache in mind, the function can be a bit
     misleading.

So I wonder if (a) we should just add kerneldoc to document it clearly 
(lru cache, mlock cache?) and (b) maybe call it 
folio_may_be_lru_cached(). Not sure if we can find a better abstraction 
for these two caches.

Thinking again, "maybe_cached" might be a bit misleading because it 
implements a very very very bad heuristic for small folios.

Maybe it's more like "supports being cached".

folio_lru_caching_supported()

Something like that, maybe? (again, unclear about lru/mlock cache 
abstraction)


-- 
Cheers

David / dhildenb


