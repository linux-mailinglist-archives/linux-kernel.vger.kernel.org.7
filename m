Return-Path: <linux-kernel+bounces-794034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC461B3DBDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14623A3B55
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02FD2D663B;
	Mon,  1 Sep 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4wg+NKo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9C1A5BBF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713956; cv=none; b=KdkHxsbL7u8FvFLv5xDiKg2vsibDUwP/lZkKrmp/2UFrjKK2Q3rBcZIbn71O1Ds2kPDSgZnwYJDaxLfboe/pcrhE/1LIXkEoVpddpm1TRObU7O09WTXU0V+zHL0bnO0rIlcWDThaQ5b3mkHzSLKme8wePwQrklK+9ADT6nWczWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713956; c=relaxed/simple;
	bh=pTDn/oE5/8q5Vzoq1u54BPMNMp86qkrNxTfmsSOjNfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtvEyjRnsCE5U4jZgHKQJHiggRkQB8BO5P9dREVFIhFJEPzPG2o+bwaCf6bufgNfn9Qr+ohdhukVXfFQMEwNSIKHVniO1Aupk9KoukK5tbndw2WG2TMqFONa/P+8E2dJ1X3nTGNrIyF+ybnmm38Rx38JhJt3qV4uVz/i+wt8E6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4wg+NKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756713954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m6Q0PjFvhv0lbIlS6wSpELNOmrbahmb2W78rqQSaNd8=;
	b=B4wg+NKoekLaXgaUL6Pz/HDSkwA1uJAPjUS0Dz65qlqTrtgLKUumL8TULbo8ZnCtqfADAh
	heHs6wK0Naoe26BLhNj0BSq7aJPWwegQlh1q6b5yz85B2U5JD/iHj025iHzR2yMXgHBDLc
	r6smeF/WomIg/q+iUZG9a7HTlcgg74w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-O6khncMVOE-1QizDXLyZRw-1; Mon, 01 Sep 2025 04:05:53 -0400
X-MC-Unique: O6khncMVOE-1QizDXLyZRw-1
X-Mimecast-MFC-AGG-ID: O6khncMVOE-1QizDXLyZRw_1756713952
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ce059e3b83so1582683f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713952; x=1757318752;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6Q0PjFvhv0lbIlS6wSpELNOmrbahmb2W78rqQSaNd8=;
        b=JnaBS5Ru3e2o0RyQQ7XIhEiYIZTZBX6EW3x5PDPalQewteKIVUHCXFCjZgmNqd7WTW
         9a9cXMRXIMdvRqAAdJUpo5yT/OE40WMH1YEysbcCErue2cwQGyBfK6g+7NCJMPgNcQE6
         gegYeLjJHFvtdbGnd/uinQEi8tmQQTxsZ4u2l6INVp6KIJxvO7R0WoF7Z28k9V3s/brv
         D/1bEKfPkCckmNhiRUS7wTkKUCrla2myKOZgSPSnSCxWM7Y8poweO5oFifRFLNAq0gVb
         HU3t+5gJAYsea/xI5FhvN9MQQB1UGdKdQjWdkx+nxvTzwDtUX1P8qDUzN8aO2QfJqlJi
         6xMg==
X-Forwarded-Encrypted: i=1; AJvYcCWvbvos5jKxBMP5H+2++pD4w3+2yPOSzyCOOt7Pn2F0q4QPaZN++VIpUfZmA74nfkLT78Ca1bj8OzhOuR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrc47g/JAY4j7iFq2E5faaiqiziR07gXnXGZ5Nce/HnxYtoAJP
	C646Nsb3C0AMb3VynQEUwk8wldLB4Del6LXLphk6c7Ca/GCVPxZW2MBllAyD9bsk2CwD06eTgp7
	wVQz5Kl3SIJCa1tpf/x1RMOMfssu/4/iBeRs3fpXbYRQto0M6nfvVncawJS/pk/VpDg==
X-Gm-Gg: ASbGncu++zpwmls4Bh+aQcqDomq2m6ufHS33BbWhHZCA52yvd9TstcpgBJRKDvbNHa7
	GMDZJkcEnpyebJIMIYyxBYTA+9QTlT0kcWYmmrZZytN8ceJCxrEHyfTrkbPn3Ik6+WzVlRjkUGJ
	WLTv9OL67Ldkgnz10C0uVjg7ZnMBjI6XO/3MgvtfW+NNeLrgRE/o5tURA6mFtGkgh/1ugIeH1Ve
	Y8c1eS9Bav4dtgtSL6wxCgBAU1g2tUk/To5A/cJk4Xegj5ReY+7XWdN+XPjPZsfZlp2vcdbJwm9
	ooZ1MafKKwT82a7jNqn+UXWSMJEOAkDmARIuNmsnrs0ZIxoPI4adcuxrefR39fa2DTV5CcoPlRf
	MqwUwx3JbZuLmS5PwcVncOxRWUlvdsnxOd4HHYLQQiPoMWDaLzRUYkK0ET5kljIRktCE=
X-Received: by 2002:a05:6000:23c4:b0:3cd:14be:6937 with SMTP id ffacd0b85a97d-3d1dfa19a58mr3646969f8f.36.1756713951651;
        Mon, 01 Sep 2025 01:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcHfPInp2BDxJOllzL02W3FmjrmeT2s65+VAuK62AhF4Rnxj7e61tootb2p5GHc9847at8ng==
X-Received: by 2002:a05:6000:23c4:b0:3cd:14be:6937 with SMTP id ffacd0b85a97d-3d1dfa19a58mr3646946f8f.36.1756713951224;
        Mon, 01 Sep 2025 01:05:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm150508665e9.22.2025.09.01.01.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:05:50 -0700 (PDT)
Message-ID: <e3922760-b074-4d5a-bf4a-9d7cf7f5f914@redhat.com>
Date: Mon, 1 Sep 2025 10:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
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
 <165ccfdb-16b5-ac11-0d66-2984293590c8@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <165ccfdb-16b5-ac11-0d66-2984293590c8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 11:08, Hugh Dickins wrote:
> In many cases, if collect_longterm_unpinnable_folios() does need to
> drain the LRU cache to release a reference, the cache in question is
> on this same CPU, and much more efficiently drained by a preliminary
> local lru_add_drain(), than the later cross-CPU lru_add_drain_all().
> 
> Marked for stable, to counter the increase in lru_add_drain_all()s
> from "mm/gup: check ref_count instead of lru before migration".
> Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
> optimize longterm pin_user_pages() for large folio") first.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>   mm/gup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 82aec6443c0a..9f7c87f504a9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>   	struct folio *folio;
>   	long i = 0;
>   
> +	lru_add_drain();
> +
>   	for (folio = pofs_get_folio(pofs, i); folio;
>   	     folio = pofs_next_folio(folio, pofs, &i)) {
>   

Do we really want to drain all the time we enter 
collect_longterm_unpinnable_folios(), or only if we detect an actual 
problem? (unexpected reference?)

-- 
Cheers

David / dhildenb


