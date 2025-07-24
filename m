Return-Path: <linux-kernel+bounces-744641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E6B10F78
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57ACE7B2835
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666112E543A;
	Thu, 24 Jul 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3ICvg8+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C009443
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373778; cv=none; b=Fziwy12LoMb8luJEaXSFXcSqOjedDUJQzr7gEeHKaBRDQTWn6ODpFdoFwYRY6ooRi06CT75pSG+wXlyynWcCMG6y2uunikp9Wf5hF/mPQv0REMRC9pap9f9p2aX2r93LynS1T+YnUUDtZwjqJK+lALutP00CppQIa0kHIXosV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373778; c=relaxed/simple;
	bh=T0zjd7yNPvxWfOPpwR826pzNhfJVxyS0KdPO6rSVGlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQS7HUbhK271qRJGW6Ju70mb6mAtPrw8LTi22IVTE4sGfF5oiQkZsUJeBRSLuxd9gT/KAzIHchr0fv0FcAPLUfza86TKI49pkxW3Cf7h5q7/Ldt4U0Z6zrOnkZOt4NzTcZW5qsQZSTinWb3GP/xbdJOo0f9MsuhRG3IgKiE41cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3ICvg8+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753373776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=di4gWAxFsDjFLqbJUOd8tyFS0ca5NTkMWzqIRwPP148=;
	b=N3ICvg8+aw6QSd2xUG2iKo0NAHHO0S06Q7dfeqyoUpLIZTLj68JBIa0fe99XD/VyrP+5/7
	9m0FMoomacKeRfkIwbgihIu7eUot3C5sz46BQ/2hvb/jSDAQ8vpAFjwVqsGi47RQoHGGch
	ajA6mFDCuqVUMCAc3k6pKIX23JNG0Fs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-lWeaSMgEMKShzIUeRqKj-A-1; Thu, 24 Jul 2025 12:16:14 -0400
X-MC-Unique: lWeaSMgEMKShzIUeRqKj-A-1
X-Mimecast-MFC-AGG-ID: lWeaSMgEMKShzIUeRqKj-A_1753373773
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so535766f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753373773; x=1753978573;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=di4gWAxFsDjFLqbJUOd8tyFS0ca5NTkMWzqIRwPP148=;
        b=lPZ70YDhje42Mg/7cw0Zwk/OVtp36OQeMMA9JNW/SuF0PsVPU9IsY4Pa8HAjNuo6+Y
         o9GK7unCQpfd/Gzlx6ytMvn7cfvdJkZ28Pwn2vtQY47dlWme60x8rB+Id6cF/VHP+1o/
         H40pG/Q0GTW3kvzz6fo3BJK0ZKd1UNKOcKFyYFxKTqc9rv+GKs/KpAWOS9FTp3rB70ja
         SOqXK30wFm0aNxztUFuP1m0Dtiyo5PJ/oOUui/vrGH3LJiK/8PQD5utx5UwPwdYagwre
         wodcU3vifQPi8G+UTA03TztJ2Lt5OudxUREr8M9D4vNHpuarLa4CkJJJJWrQ2BcE0fH2
         aQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/wqSK3Z3Qy6bFQocwWfXVZHGlUhEfrVpTEInZWAVFJpEiY3QofB1R+Q4w9nitkKC7uKOnUH4e7hjoJ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVFvICPniHenvNlVx/mlzbM7ZrBpA/Eh/t/Jdl2eHGkk8HD+a
	qARxfBnUcElvBFcFtlsI+NfL52ZcoCoPSV8XzMLwg+mkHOe90v1S0wwtf15e/1FGPXFQ0VhfZnN
	C3k3kbNHkExuVWwQCFMnibWodDhRpzRsFNQ4aonM7wJMmXdeP8Gvr0kGoL4CVvi2kpw==
X-Gm-Gg: ASbGncuoGANQEF4ChlcQaBqJr31rwQ7eT27CBe2qtcaAC94E/APNE3OfiPE2R9NqKa7
	PUk1/STJqKcZBkVJWALKIflVXObc36J+xPYwpV9UUzVK28l1CNmvo8QpZxom+fQt2HpKfSR5W1C
	CGh2csQ5XTWC+m4MapqwtzQh5kyHGHxzvQOaR7lC/koKJkWV0PCfJq7K4TijRPJ61PWYR1BoJam
	bBEMlC0RDjVrXKKs2+fZegxlit7uZ4aHch9xVPIb5v/tVvNggXPpKQFIRWSWFrvIvE4TzKRdZZd
	oQYiyMSfs0UYNDv+NIJiMdpRBi8aDMHogjQpfFsXajhHhcthwTGqc5BacL+KUBw/eZ0VX18XXil
	AGMNoiOkq+02pmMiEnk2RaPc8wdhOtP5aL0gEv9W1Y1uL5sJ+XHJq+LO1HPC0z43D
X-Received: by 2002:a05:6000:290c:b0:3b4:990b:9ee7 with SMTP id ffacd0b85a97d-3b768cb1b11mr5816992f8f.22.1753373773346;
        Thu, 24 Jul 2025 09:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEguCEVAG7lxnHoKX5dL9PwnXhiPldiban8ysf/Zd3Xyvw6UneOlwrJCPgjQknaAEGwBWPU9Q==
X-Received: by 2002:a05:6000:290c:b0:3b4:990b:9ee7 with SMTP id ffacd0b85a97d-3b768cb1b11mr5816963f8f.22.1753373772881;
        Thu, 24 Jul 2025 09:16:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc7724esm2590591f8f.32.2025.07.24.09.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 09:16:12 -0700 (PDT)
Message-ID: <ee6df343-6500-4443-9af1-4d15040e39c9@redhat.com>
Date: Thu, 24 Jul 2025 18:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove io-mapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
 <199a9d2c-9e50-4740-b29a-6ffe906e7d9d@lucifer.local>
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
In-Reply-To: <199a9d2c-9e50-4740-b29a-6ffe906e7d9d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 17:39, Lorenzo Stoakes wrote:
> Sorry Andrew please ignore this for now, I'll send a v2 later.
> 
> I'm not having a great day here...
> 
> I wrongly assumed that, since this is wholly unused in practice, that nobody
> would refer to it or include the header, but it turns out that's incorrect.

So, do we have to keep all (and keep it in MAINTAINERS) or is it just 
about cleaning up the headers?

-- 
Cheers,

David / dhildenb


