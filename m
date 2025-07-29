Return-Path: <linux-kernel+bounces-749402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8181B14DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E12917891A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A4E291C03;
	Tue, 29 Jul 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFGy++Nf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218771F4CB6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792949; cv=none; b=nQhdc/fQem606NbSB5NLInxw546hvTIzbevaLbRKu6lpbBDu4dzVrJUHNEbJYXwFF4RnMl9osio4EOToYvPBJGbdQuECtOAGmgo9A89RJjfWgNq/Pb0hcOEWGWMMJSSEob5Xhi+ebaeIbllJB1MzineNPlhFq5BnPt5kSnK1tug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792949; c=relaxed/simple;
	bh=GHobarEG38jjDZ7Z1ngI9HqlG0MKeFyMD25JJrgm5Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXEYOeT6KTWFDkhxMZVP8TrnkvyLnL3cz9NHI+OqNxnzGVYWx771zljiAUCMhVMw2Z3ab0RgrrOGbRlJdgl4taeC01M/t5+Ib2V3GRWugqYwJOnYpDQCwiUXv/8n9sJFbrP2cyPsfZRwkSjSZDitvx0V3yQH+LueA3zrwoz9ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFGy++Nf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753792947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WcjMQQjDSdSwY1RX+LoRs6QbfJmy/6ykYqRqkN1o+H0=;
	b=IFGy++NfF2ckXOMUUOyQC73pF/U59wKxzvwa9D2qsDsl5stlRkLTyjjM8JQ1GwsMMPmLTd
	qhNTIcDVWhij8UuwwLyZ9V2H6uq1PCCYXo3+hNaGbZw6iJ5hWt5FbUwfhAX5JKq5dzV6SJ
	8VrLvh79BdO3Y1Ok4a5F4evumT9Kouk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-rnbxf8vPNv6J5IXo21386w-1; Tue, 29 Jul 2025 08:42:25 -0400
X-MC-Unique: rnbxf8vPNv6J5IXo21386w-1
X-Mimecast-MFC-AGG-ID: rnbxf8vPNv6J5IXo21386w_1753792944
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so42488235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792944; x=1754397744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcjMQQjDSdSwY1RX+LoRs6QbfJmy/6ykYqRqkN1o+H0=;
        b=vA7RpgUK3/mCU3hgINFVT0sXdvaxwSahdMxkf8uhlYwJ/fHQZO38SRHnWPmF7Jyde1
         /QgGixPdgpV8WT0oR/lJrrqeE6VBKJ9XnqHcVtehR3NqX3xdXuJk7DNf4VzOE7biDB0m
         iAZH2vkVwelHq3fm/ruPLmgc+hWlEoCUL6h8kpKi47yXsOi+KBlO9y9zR/e7Fo9yeX+k
         Vd8sxCfxCP0+n/EoieeDTKoYAbnLbw4IBQjBSJa1y6UQjR+gq/hFdQsZITf8hHu8Yzh1
         GnMfEmtUFgLgDfp57HdxqrSOJSxIBpqKMF2GtLq5vlCCbN/1jBly0sq6AJuGWBH83prV
         vgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyG0+YpLUfIlekEGfCERaklMv/pSBkGlIY16Wyr0gqH+4ua8c3X+2F45jukfIWRUblvbmvuVCoU4c31Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCw2IlBdraR3mhIkYAND+DI0eAeQs9u1QLhxShrlQ8JuMkvW+6
	rZ2FWcK86UrFYyXwd6wtc25vn35TUrDUFGfrd9owbk0ZiwTCfzM3n36SS8tBdpfXwUFVQMupfzg
	80QUrjNZGheFfieydi41Y0EDXKqA/Z7SswQVWaQZl1AqV9BZSz/t6uQTYqLz+QsKbOg==
X-Gm-Gg: ASbGnctxRwSByvBmO+gn7+zYv0ThUhe61gAtQc0SDu1VpwrAaHJg0Vofdqtp91BcvIy
	zfaErYCq1E+AiV/CtxvnxUbGXCrQQg+/0KPZ0OubSZNPKXXXvLL0tUkrbKp+tkiYhwZHZRjJQlr
	FCNQJELLBP3FSO9KNZcYdrk3cTPAVwElvqsS5pUQ+Qh2Cjes8lX+4bwEvN/yAUmuoHDbLlisPQj
	rYTV4WEjswaAs+3Qom2+WWbh2at2TKIJLB1m3cjtcHxlMrYzaPowBBBxNC+R+5B5n+XL3YMgiRm
	t5rrN1+/01KhijaSLJBY2Z+s7g5/UDEYvLKA1cjQTW5PG5/3arFidbUwE/jsnk8P2kZQIJdu
X-Received: by 2002:a05:600c:620b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45889b30dacmr54719335e9.12.1753792944289;
        Tue, 29 Jul 2025 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVzcw4B170O0ATQTmJ3dfpRn+oQ1lRRT7YNXe6J7L7+9l30GTFb5RPpD1eQ1esmhnAOVPqvw==
X-Received: by 2002:a05:600c:620b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45889b30dacmr54718925e9.12.1753792943716;
        Tue, 29 Jul 2025 05:42:23 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f338sm190876065e9.13.2025.07.29.05.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 05:42:23 -0700 (PDT)
Message-ID: <d66fceb0-4672-4803-b9c9-6b769ff847da@redhat.com>
Date: Tue, 29 Jul 2025 14:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: "akash.tyagi" <akash.tyagi@mediatek.com>, ziy@nvidia.com,
 surenb@google.com
Cc: akpm@linux-foundation.org, vbabka@suse.cz, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
 chinwen.chang@mediatek.com
References: <E70C1648-DDAB-4027-AB07-1C19B10C6AEF@nvidia.com>
 <20250729123028.1224786-1-akash.tyagi@mediatek.com>
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
In-Reply-To: <20250729123028.1224786-1-akash.tyagi@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.25 14:30, akash.tyagi wrote:
> On Fri, 25 Jul 2025 at 10:27, Zi Yan <ziy@nvidia.com> wrote:
>> But there is this known problem that CMA can fail temporarily due to
>> short-term pinnings. See the "reliable CMA" work (don't remember the exact name).
>> I think you mean Guaranteed CMA[1].
>>
>> [1] https://lore.kernel.org/linux-mm/CAJuCfpEWVEqsivd7oTvp4foEho_HaD1XNP8KTeKWzG_X2skfGQ@mail.gmail.com/
>>
>> Best Regards,
>> Yan, Zi
> 
> 
> Hi,
> 
> Yes, the issue I described is actually related to Guaranteed CMA[1].
> 
> I have rewritten our problem statement to address concerns more specifically related to the Android common kernels.
> 
> Problem statement:
> Android Common kernels usually have an out-of-tree patch to prevent file-backed page allocated from CMA.
> It allows some allocations which have lower chance of being pinned to use CMA to improve CMA utilization controlled by a flag __GFP_CMA.
> https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.org/
> 
> 
> Additionally, android kernels create cma pcp list for pages less than PAGE_ALLOC_COSTLY_ORDER, but not for THP pages.

I'm afraid you have to fix this in the android kernels.

-- 
Cheers,

David / dhildenb


