Return-Path: <linux-kernel+bounces-797954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C10B4179F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D7173453
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D502EB854;
	Wed,  3 Sep 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRmilK5p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9172E9721
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886433; cv=none; b=gMgmaZWZ8z5Ca7r7xM3E5rhRvzzZMyQZ9NbuftJ160zP9qj3xXfuME773+NZnTddQOuaEKQdIjuM/JGOPTokojuoWQhZUuB7G6fIOwXS7LCqSLxv9qs1+5R9GyG3Srctc2fxDB5YXND9+L7vZQZMcIhfXIjGeENgC/dZNZxedSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886433; c=relaxed/simple;
	bh=xYNaEt7CUTKOxVLYF1M1ryGT9g17ddUywJZeiTfyHqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCcM/cNb5J6/+mqwyBQyLmmSZLLcF1rphZa8k1NvVGiewOFUwhroHanI44j2KrwEQUU76ax58lzQl6JytdSpENzQZJxxz8grWj43OvSJMhBvvL5e+f0heSFa9KUPmj6Ci0hdrtRESEZ5bcr7RkNFDCK2YDkfsy3hRasMC7fmm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRmilK5p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756886428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oBh6cegRU5vIqxeNtdbA8Z6LWKwX6vsH3YnVQj1SefE=;
	b=TRmilK5pbesTQIDviOb8g1hJEyZbIuM0y5sX/mf9PZYXhID1ByeVRJLg4s+PldetVqAaWp
	kzWlvOVXFuvPk/8/PL/XSx/VGR2nJa4qRX8zf0DhNkxdpjtxz31ib1pGA7nZ7UUar7SCbQ
	uZibjKo8Re8G88PugioNG7IVV3MynV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-zk9h0l2fPDqWu6FLWlIjLw-1; Wed, 03 Sep 2025 04:00:27 -0400
X-MC-Unique: zk9h0l2fPDqWu6FLWlIjLw-1
X-Mimecast-MFC-AGG-ID: zk9h0l2fPDqWu6FLWlIjLw_1756886427
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9c1b74d0so7476205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886426; x=1757491226;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBh6cegRU5vIqxeNtdbA8Z6LWKwX6vsH3YnVQj1SefE=;
        b=CzwHbA0768rWJ1nYGhRjQgCHD4GbpnqO5ce3hs3vYwcgMlP2QhTiaMxbQmuc8BO4qu
         /dhoYMtCAwzAiBiaaw0wBhDUpsX5m4Zxy4T/+2Sz7QylwK8W2QP8dFCSbfRq+JPLTvS+
         fFKOHckq26RJsA9kNFb82Qg6FzvCetpOoXp1TRJhAbKIwTbbVIqQSSH5tz+a1kF2iNNZ
         9DKIC/0JqftshIstJV28FEn1g/Rbk1miR2P/a5AVUZaZgYkfaRg9KUOoL6gAvggj4hQ5
         LnEiKCTTzQizjI4JT8wB2G/EBEuItq2/QxmBC9cQMnXUyvSKdLCUwL1z3KZeQ8rjYx1a
         Q+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwNmmIyUhq/h4WO3R2GLc0feMqHQZOcAKIi/K5zh5Hm13Drm7p1FVZy49DTCiKRlPnM/jxupvEjpV/gwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOIJFMnLpI9SVxTyR0zcg4iK/TXY1Tkfy8APomve6du1+nuzq
	0nh8zY9F5gFovdI0leOgrsK+ZwgIJoUTS/z2qa55C7WlJXtai8KbTG2hnrXqrORgpBGfjZalABB
	0yNbW8MSzXEmRjjU6H25MID19HFLfcMo4pAHsJx0MWb90VJJ3/G4WlUHRHtP6JLjN6Q==
X-Gm-Gg: ASbGncuYRPwA9T/DaHvLgw1SmN076trLn5p2hl5zRT6PC9UQ/HY88n4Nz2c4V+YecFp
	NtFK3a3mNiGvw7Ph56fWTppxX7vO1o2npZy5rDqp6Y/bXDHJAaIYzRBz5KebFvnaV5zFpVIX9GA
	kYbTUouRwRS697F+pFyzaCQrweEVDaAzf3W9lG/hx4Y679MYaUEWUW3TYj2Degisi1+QQdWxQ3/
	WHH4PkVH9ChdD5XqZUI9Hn6SVVeK2wJK8cGiIBXcAqrZ3ta2Zr7e2/ZPupvrEVa6EljrQjzWoB/
	uWjqa2V8X1KaTApF9ITeJGYp1NOpNjwg8vMvpBcWaXMNxppvlblg8WVEvt7clW1Qkh8mXIW/JJE
	W5wLfdychzBiGGvBQDuF+6u8Ia0YRKzzha1TEtxh2Gwl6X4JYnkfND4h4SFb4OO2TlFQ=
X-Received: by 2002:a05:600c:470a:b0:45b:8b34:34a5 with SMTP id 5b1f17b1804b1-45b8b343742mr91308145e9.23.1756886425030;
        Wed, 03 Sep 2025 01:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvBov+2sCYC8kUy1LMz0NKTPJSNfIKJ0Y4Pc9pD6sJfPp+mtZCtKL911g00Hjd0GsxF29PUw==
X-Received: by 2002:a05:600c:470a:b0:45b:8b34:34a5 with SMTP id 5b1f17b1804b1-45b8b343742mr91306835e9.23.1756886422976;
        Wed, 03 Sep 2025 01:00:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm310327755e9.4.2025.09.03.01.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:00:22 -0700 (PDT)
Message-ID: <734e09b6-9100-449f-aa77-75a18b634db2@redhat.com>
Date: Wed, 3 Sep 2025 10:00:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
 <20250822192023.13477-2-ryncsn@gmail.com>
 <e22b8472-6d20-49b4-b49b-78f79f126294@redhat.com>
 <CAMgjq7Bqffjm3dTZ+bHALisCkw7ASao_1h4ZZVM6kd14YdKzmA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7Bqffjm3dTZ+bHALisCkw7ASao_1h4ZZVM6kd14YdKzmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.25 19:13, Kairui Song wrote:
> On Tue, Sep 2, 2025 at 6:13 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.08.25 21:20, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> Always use swap_cache_get_folio for swap cache folio look up. The reason
>>> we are not using it in all places is that it also updates the readahead
>>> info, and some callsites want to avoid that.
>>>
>>> So decouple readahead update with swap cache lookup into a standalone
>>> helper, let the caller call the readahead update helper if that's
>>> needed. And convert all swap cache lookups to use swap_cache_get_folio.
>>>
>>> After this commit, there are only three special cases for accessing swap
>>> cache space now: huge memory splitting, migration and shmem replacing,
>>> because they need to lock the Xarray. Following commits will wrap their
>>> accesses to the swap cache too with special helpers.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>
>>
>>
>>> +void swap_update_readahead(struct folio *folio,
>>> +                        struct vm_area_struct *vma,
>>> +                        unsigned long addr)
>>>    {
>>
>> Oh, one thing. Regarding recent const-correctness discussions, "folio"
>> should probably be const here.
>>
> 
> Not here, swap_update_readahead does folio_test_clear_readahead so...
> 

Ah, makes sense!

> I'll try add const to other places where I see the folio is const,
> thanks for the info!


Thanks!


-- 
Cheers

David / dhildenb


