Return-Path: <linux-kernel+bounces-796576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D6B402B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A2D1889C07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8A30F552;
	Tue,  2 Sep 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ/u55W7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C8305E0D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819119; cv=none; b=ccd7Sa4y5krbUjcZ6pIwWegduUFNe86nXSWbDnqM1yBQek0j7ucPF98kb7OSCrXUp4X1JhRk1/VNfRBkNUEdnFtbe+7renY7GeE/JqBg1/wEVEUpNAQOlY/g8PH/eEmvxwX8QWxVYzqF51m/Ne6KsVgkDltVNUrMGSigqoCG9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819119; c=relaxed/simple;
	bh=rlzxU01MXxWgny4CSQYAy+OzIA3rutuvmJnBnRFqcSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xph/eWsK3k02E20r5OpmhyZIRNuAJqkKzY0Re4LLgbO/3g51WhSHjsToxnw5aOq5hhSZ+llRmwMQ7zJvKH9/t2liTNGnEqhawNuFegn1HxeasrOvH/jy9/yQKEMvlBRCvc2pwB++jphaNIlZ/HjfGfn9QUq3pEJ6vV+tqM6CwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQ/u55W7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tauw0lGXDfZgbslYqi4AXR3FVuYc5diqrD24hdNXLOs=;
	b=RQ/u55W7erY3JvScMV0bMlBQzNVA8pRW9GDnA8PoyMceI28WLOQKicxANZsQk+pfBFXaM6
	/DSNcgCDkYDiVZhtjpFgPT4HojmwG4MOEYaxDjk5QkgQ/vaoQwIgt6h4/YsRYMQg7cQShJ
	3j0jE630mNR+A4/YeluU7mJPzmmAZzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-x917bBekNJOCwa3IzHtW5Q-1; Tue, 02 Sep 2025 09:18:35 -0400
X-MC-Unique: x917bBekNJOCwa3IzHtW5Q-1
X-Mimecast-MFC-AGG-ID: x917bBekNJOCwa3IzHtW5Q_1756819114
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3d1fe9ecd9dso2443252f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819114; x=1757423914;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tauw0lGXDfZgbslYqi4AXR3FVuYc5diqrD24hdNXLOs=;
        b=nBxy6M3xpBiJxGxXVl2VQju7aaXbor1X4P8cMNZOB+nWghvAV3ZATT7Tt27sBqYGpu
         FL9WqAhRAB5yZu4GApuV7+kmV/1eLr/B2tX2ngsyMM/QFFM25OapWxwDxmRZRxomiyQQ
         F9UvTpDlImCtk4vjcSctYM+JMnvVU/ofjqNCtKBck+AbQsW/qjqcL7sdH5IiH9BGgiis
         5qgz7RW3LAri2bYI07/GQivAR7LAGO0VBWQIPvTrznDRUU6aUhfGQBSI0RgBu2DLRdfo
         5W1fRVlgD/tVqMkjP3IX9R4X1TQtWQjVQ8BIEkXQA3Kbxf2/N3VB8i1PGo12ybZY3ebB
         Mq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrDhz1GCfzBLryvwP4OeB92n2Od2jZ3irEdNKsJbV0C7gbfCdn3ATkgV7XSBKQS9xbSPIbhEZ8eBsCMoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjtHo796Ggx6fZlAk8wmDN35zJWXKISEnXvvzz7guWN193aVI
	glPd5h9qV4WYJj747uXYjPYcqM1cEa1ABiW4MLjGJ1+/Mil99PFJimn5EBoQ1tEXsM+XSULeUkH
	XyFEQ8kTgJqnML7CoTKOHHv5gXorKZDIgcBdgG5PWF/IBO6eeKqoN2HfeIFxOf1ZjCGZhWEOMSw
	==
X-Gm-Gg: ASbGncstqJzsNP7d0oEwtyocw5MobapZ0WquBARsbQdPhOmbNIPd9q2PrW6DtI0gh+X
	W0EswXVX/LTn/DTYcgSUHvHRues08oYZ+RU9Mmv20evcMZcVXR1JLdDJl83SJm8Wy++cWuf6xGo
	S1ecQepCG1w4HY5p01c8mRnTd0obsbl+WmjCNEuh59k/zTWeu5gmHkvrjAv+3zVeciyczIS7FGB
	qE2pb2jq7JXbIOn7p1u20OQqtQVbpr6w8I9Fv5Niz+lVBu2YSiKBenGPEnYSriCut1mOUYU2gjq
	Fc+8dJvIotQEkDVL1cUnz0bS0wi679ICYSQb4VbVj9voCyGkRwHwLz+6dQuI62PRJnb8AyMMMCs
	7kNbDHp6m3r/MNDGSxW58HKNOYXgInMCBKu1v5ANMNaJCOb+i2ryaghRj4Bf4aIqkqOg=
X-Received: by 2002:a5d:64e9:0:b0:3cb:46fc:8ea8 with SMTP id ffacd0b85a97d-3d1dc5a23a7mr7455988f8f.3.1756819113901;
        Tue, 02 Sep 2025 06:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI1e4lWU+SGZynM55On7nh2fJP5EUS3ZCAumq/CVhgP9Ba7RNCmp3gmALPbTrmLTQCfRpFfw==
X-Received: by 2002:a5d:64e9:0:b0:3cb:46fc:8ea8 with SMTP id ffacd0b85a97d-3d1dc5a23a7mr7455964f8f.3.1756819113501;
        Tue, 02 Sep 2025 06:18:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87abc740sm132002265e9.7.2025.09.02.06.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:18:32 -0700 (PDT)
Message-ID: <8ff181dc-b9c3-4416-88c3-58cc26b174b1@redhat.com>
Date: Tue, 2 Sep 2025 15:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>,
 Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-2-ryncsn@gmail.com>
 <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
 <CACePvbVQGbyO=csbLG-0uP8gwY3JkS73nHCBb8Eq7xNwD=N=9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CACePvbVQGbyO=csbLG-0uP8gwY3JkS73nHCBb8Eq7xNwD=N=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.25 14:32, Chris Li wrote:
> On Tue, Sep 2, 2025 at 3:07 AM David Hildenbrand <david@redhat.com> wrote:
>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>> index 99513b74b5d8..ff9eb761a103 100644
>>> --- a/mm/swap_state.c
>>> +++ b/mm/swap_state.c
>>> @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
>>>        printk("Total swap = %lukB\n", K(total_swap_pages));
>>>    }
>>>
>>> +/*
>>
>> While at it, proper kerneldoc?
> 
> Agree, add the kerneldoc while we are at it. Those are important API
> to interact with the swap table.
> 
> BTW, I already submitted a design doc for swap table to Kairui, which
> will show up as the first patch in the V2 series

Nice!

-- 
Cheers

David / dhildenb


