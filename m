Return-Path: <linux-kernel+bounces-745590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1242B11BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1FA3A4083
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FE2D63E4;
	Fri, 25 Jul 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NU2dym4B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031D2D4B71
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438218; cv=none; b=PqoTsleu8BuKBFY+Xo04MtH2CvAEXK1zI0zR8ejuW1hsJ58tXRUquUnY6smj/kD46hSp1QF3Y9YYLMabRvpERHwINjrV/e+RYO28cTiHAW4BaB+TvjgBEtekTqLqNVB4aQVJn9otKGtSjrrXZpTgPg8ZFgmoc81RjaC3Q6YJAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438218; c=relaxed/simple;
	bh=jOiUJZ+Cufg9zWdLDPR24QUdJjKbRVnvKq4hV+GcOwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2a3CNsU3JaE0wrADkkXPyqtjgxFGAyvhJ9ZzrOf7PNyt+/pwIFup4n9yha+2zbAwd9tuzROYJtFTot0Z9OoAsImy30d/EZQ/8UnbxTs7NpMaaKdagP7GtY+RsybeY24Yh0VS5WZ28DgsL6GWcmOk00kZeaRMIW/luoC+BPjao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NU2dym4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753438214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RCv5vRN+V3N36ln4l/qk+no8mmBtq9CdsJugmAnVBHc=;
	b=NU2dym4B9L9zgRAJ9EG7o063rMkAr3SMOHk++qD6FXaH6ShjWVudGLaJn9U2SDjjwgSSMF
	f2VCRiVl5wBQkdWnEihoH9RMD3E41r5uSOk9boqiQUyYoeJQl4sP8ius8Hv586qVk0dXPq
	3oWDiTVALNBJFVHnJrlbGSUZPyh4OOw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-kdNz_QWXODSCI9sRG35CLg-1; Fri, 25 Jul 2025 06:10:11 -0400
X-MC-Unique: kdNz_QWXODSCI9sRG35CLg-1
X-Mimecast-MFC-AGG-ID: kdNz_QWXODSCI9sRG35CLg_1753438210
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso12007955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438210; x=1754043010;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RCv5vRN+V3N36ln4l/qk+no8mmBtq9CdsJugmAnVBHc=;
        b=otZkYLn0OX0tkiDsaf/A/aBwTvlzj4Ha9U6BODpRerFQTCq0cvlvfIjtN7/AGSy/Bb
         L/NMBqe0DSuM1+EvNnjfEGe05vqsC2hF5F6Z17vWeSJH3n1sjs8Z9TKZUyUQeg3jJapm
         3qKeqV6ONNZL09Y/dh/tVYDCQ3cemNyBSwQDPCcKNcQjv5goC+KR4C4Q5mriDJ0Zywqo
         9JAJSkJ4/FEOcm6ACpSfp5Wrv69xKzPdqjajJw/+t+7HmnAASoyn+cWiZLh1cbjCqYxL
         IflkPPUwoh2FbASjLV6Mg/PppKOrMb/D2S396+rDjIW1luLQFCRFmQlE2UhnyoQVOUET
         GnFw==
X-Forwarded-Encrypted: i=1; AJvYcCXQIE6lWJX+3Rs0lMnnoEB2IZbPeCJ5G+OdcTAYaEGlApdgC/dXESLLiDo/SUn0LJL3WVoRGAj+BiDEm8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2EB5UiqLxsWwODuYftb14DPrr2eFjFOFJDY+5onBnX996EAH
	fFTG0I+2EuUjZSh7WVp7+OV6k2/GOyxnKatIMMPzMYEYy3APBNj/C6xQmfxlh1DnB/jLP2i98Jh
	5J16s6JP2RU8xW3+HJsLUSlSkPrR1dVfGqeDpQe3v9f+T98jNcQwG8GowDoP7QQDLew==
X-Gm-Gg: ASbGncuCrvb/DgvrPsHgxaQy/plugQE9+e/7xw42EQGDarpz84pOA5SzJQxoHRUvJsY
	wgIux9ItS7USWYKZdxJYJ7MA22zVZ4SpyQ52vdq2mJOekmuLaKV5q9Csm3+9X8/IZeegANyBtF8
	j95RpUEE3xJNHs8Va5OMSkldNknDHPHE8H7vlf1+EjXFnNcLs66DHN80dLE9dr3rYsUEPXD/yOg
	SOIMauiY3YjOwv6r4KP6jrrQ+Uc4lpTpn+zM3fSIts8dVThv0XYQU0K3t7mQmPNeCR/3UYiLxaI
	JW2YB+s9sV3KruyRY+/WzB6r/HcZtcfwkafyYCRQu9bpPPaJI8LgPsaKbb8BmGtEhkjiiUenVEw
	OvcBOKwSDmtYpd7d1Qxrizyr8LoMhHeYjfq5TE3HFhk9Uw8UZyCVswVSljNWm5Ld7fh0=
X-Received: by 2002:a05:600c:6088:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-458762f07eemr12140595e9.5.1753438209997;
        Fri, 25 Jul 2025 03:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK7mwDSWg8+ygksCm6dpsZRM8Kza275xhyDlqpfynlyccXvQz3lJi4ZoaZcr76pXUpb8kLzw==
X-Received: by 2002:a05:600c:6088:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-458762f07eemr12140215e9.5.1753438209561;
        Fri, 25 Jul 2025 03:10:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1? (p200300d82f1af4005a9fb1bf4bb399b1.dip0.t-ipconnect.de. [2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcacf0bsm4625237f8f.38.2025.07.25.03.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 03:10:08 -0700 (PDT)
Message-ID: <649565be-eab2-4783-9595-b4263ac50310@redhat.com>
Date: Fri, 25 Jul 2025 12:10:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <4f66d89a-631a-43eb-b4f9-c9a0b44caaae@redhat.com>
 <692f9624-e440-4cf2-8202-861c679ddb73@lucifer.local>
 <0ad414a1-9a57-4050-a7b6-fdea08aebbd1@redhat.com>
 <507a09cf-291c-4886-92e7-9d9cc294a247@lucifer.local>
 <aa839e3a-11f3-49e1-8c3b-a60106c8d165@redhat.com>
 <d055173e-233c-4513-ab40-d7a10a0b81c9@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <d055173e-233c-4513-ab40-d7a10a0b81c9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> So - we explicitly disallow FOLL_FORCE write override for CoW file-backed
>>> mappings.
>>>
>>> Obviously if FOLL_FORCE is not set, then we're ALSO not allowed to get past a
>>> FOLL_WRITE and !VM_WRITE situation.
>>>
>>>>
>>>>>
>>>>> Hmm maybe I'll soften on this anon_vma idea then. Maybe it is a 'cheap fix' to
>>>>> rule out the _usual_ cases.
>>>>
>>>> Yeah, something to evaluate.
>>>
>>> I'm thinking more and more we're probably actually safe with !vma->anon_vma ||
>>> !(vma->vm_flags & VM_MAYWRITE).
>>
>> I think there are possible races, the question is how much you care about
>> them.
> 
> Yes I was just wrong. Please just disregard.
> 
> I mean racing with MADV_POPULATE_WRITE seems a niche thing to worry about, and
> so what if you did, it's writing a... copy of the underlying file-backed folios
> no?

MADV_POPULATE_WRITE does not apply. It's only racing with FOLL_FORCE, 
like debugger access.

Again, a race one probably shouldn't worry about in the context of mseal.

-- 
Cheers,

David / dhildenb


