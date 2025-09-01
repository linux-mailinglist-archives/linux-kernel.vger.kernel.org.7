Return-Path: <linux-kernel+bounces-794044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E50B3DC14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5831017530B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE252EF677;
	Mon,  1 Sep 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWqc40W+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E23258CCC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714472; cv=none; b=mo/K0kq/hLjTNRxF5cPjmgQI9SpjP+wzzNOJy82cZWjPxK5ajZq2TxzZiXkze6P3t88ShSJm05yUpN755BhJwoBgrXQQpMN4rqyQNNpF0IvuC36UC1oRHApyYOoj7A1QETeBwwne/KOZ0352feDvaifpgPSRA8exEDI+prR0E3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714472; c=relaxed/simple;
	bh=sJanacbN54Y1dHUA0gqNtDR3txG1BrtYfaV3pZxnF6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NICUhaLglcEM7oifSDvSHTu8abGIwKofEbCo01F7G1uCRWjnwmP7Gnbx9NDSwVAZ6wPu4VwYhij6JVG/En8F4enbT/Alojy9OXeG8szj2yvZMk+wzed+DAHpK8kJhMOg0LpH+utxdp7Nn+CV3bP6gu27UhngJpdNxRrXVdetdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWqc40W+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756714470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rt8jifWvTRyr4vsSKdSgOrev+jQ7PqzJ8Xa1YWSeYxs=;
	b=OWqc40W+A5L6JIR3f0bGu6ogAlGU5hZzWnw14vuuQhf/eY69JPNmhQtRHsMq3ndbOJ16Uv
	Lf/macWRUJAH1v8iihb84OOXeBhY17su6asKaUShD5WHR6dgNt/MMi1ZWVBv6QwWaLrjdU
	c8wulKFPz/w3xu2xo3GR9ZmWnh7p/Rc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-2MXLQQ6WMnu8h4I0bfNJBA-1; Mon, 01 Sep 2025 04:14:28 -0400
X-MC-Unique: 2MXLQQ6WMnu8h4I0bfNJBA-1
X-Mimecast-MFC-AGG-ID: 2MXLQQ6WMnu8h4I0bfNJBA_1756714467
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b8f4c2f7cso2794755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714467; x=1757319267;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt8jifWvTRyr4vsSKdSgOrev+jQ7PqzJ8Xa1YWSeYxs=;
        b=JT8Rj0jUlUB1/8iy5NEuZ2TA9SZFou4EFEURNmJv4iXO7VTEGJk0l2Ehij+c1z6OKE
         aXAppufTREyaFOiqmMYOtJZd0iwC6N5I6roFyaUE6Imnt3+k33/bv8pV/HYvWRUOUKMR
         VLkU2lcf1OzrttU30QYYH9FXOmw6eZEZBBZnSXMC4nK89x0k7d/6VpzmAtoDMiK10i7O
         fzENMGqGNpKLU2L9WgLxBZYU7KmtuVZcUKhIYI12wTS87AYrnkyHg3Ml/FFurOYUQslU
         cEdMKrLtXnIsNbNWiR3y56iH5BI6+JSyGQ5oOyomwqMdIyZOxnEhXNgal7BYnBgtRJVT
         /iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGKJb9rcNcHhSwo8ccPkPHMsA7nZ8cWxbGAJbbWxkHRLmrMX1nuwJq2ssRAc51aH957uAwmlpfBSjfvNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSS3rZpkuxtLRJb3GGRt9ihha8U1uVzJfoGD7e2g0ejfF9yhf8
	+ylb+EE5qoabw+N1M8IMN1ruyHgZgD0zx7CZS9YbX9ntJhc9dqmoIU6epeVEcN+lEEY41ofjm+J
	AAq8loB2F9ionDDr1unj0rkw/bnF0aDV04WQPYvTcXuqf9ScM70o7+UaBMfTcHp3eqQ==
X-Gm-Gg: ASbGncuu76hC0duhcc5jRq5MptVKNq7ctJ5JA+0hS3dQ11hgacTTQKjPgPDXQ1Qmmnk
	2PxOZegTSZgsOFRG9HiaM/OV0EXBexMXhChq8cWh3GZet7RX2jEywtyr1ndg7CP+iy9dLdwLj7y
	rvis6GA4prJZoYQTKB1aTvoREVdm6d0CrS2MVtqpIFBA1pdsZa43o8a9G3nHomIaP0plBweILUg
	XG6sykY1GGbbd6t5O2+JlTOepw4XIFUd/r+jzwh9rh2EsQe1ihl9k2oeOkuC56koo9pT0JfZEM1
	qjby7eLuWk7HflXcL7DGq8Gwezc9evR0CHScTgVXvl4rnF5fcqtXjfunlzt7h9IGxpKgfuvyh5K
	WOF4snUCSmy2fWmKe1RLoMpEM+sGM9/AjiAcOOFJXXVsYK8Zjzqh37u47XWPtqWwINLU=
X-Received: by 2002:a05:600c:4515:b0:45b:8078:b31d with SMTP id 5b1f17b1804b1-45b85525d8dmr54604075e9.6.1756714467205;
        Mon, 01 Sep 2025 01:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY2ZV8vKP8gp9rZ4Bt5dPZvE5UAnieGuQUdLK3Xp9alJAsEPpspjx2UaDoV9WaTWqyGGHutg==
X-Received: by 2002:a05:600c:4515:b0:45b:8078:b31d with SMTP id 5b1f17b1804b1-45b85525d8dmr54603735e9.6.1756714466756;
        Mon, 01 Sep 2025 01:14:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9d37sm14332236f8f.49.2025.09.01.01.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:14:25 -0700 (PDT)
Message-ID: <1177bac9-2dd9-4401-b168-2ccae850cadd@redhat.com>
Date: Mon, 1 Sep 2025 10:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: lru_add_drain_all() do local lru_add_drain()
 first
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
 <c50129a4-a07e-869e-604e-3952f8530316@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c50129a4-a07e-869e-604e-3952f8530316@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 11:18, Hugh Dickins wrote:
> No numbers to back this up, but it seemed obvious to me, that if there
> are competing lru_add_drain_all()ers, the work will be minimized if each
> flushes its own local queues before locking and doing cross-CPU drains.
> 

Sounds reasonable

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


