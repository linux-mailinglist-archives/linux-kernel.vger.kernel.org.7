Return-Path: <linux-kernel+bounces-733625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9048B0771C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28993B56EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F71C8633;
	Wed, 16 Jul 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUMFOOWQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43619AD70
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673046; cv=none; b=dqcji97uPmANyHhC8wFRT8XCxrQ82klQLdb9QnIu81tQAI2+t4rjjFoX4xrVh8aqdp65/ZxmdLebShqP+ulSLUcQOJneWaXmpzFxcXBhHDn3WfaMtSFPNbDnJNRGVoksbs/E61eimBAmZfbKLBZSmslHLxaYBTGsi0Wxh0s1pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673046; c=relaxed/simple;
	bh=9XP5e9QXsyLsbuZmFTT+yFFntXo873Xb+NEDnPwsGXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmG4GYv33vFg6UdDqSZlzzPMmI7HRpxuYIArpWmdQgmMfoPDvHP0veAKGqJj5joSqw3gyD1acD2eNcV/8HtyDTDjtT9glrwsNqJauiOXzhxxHlN573qOTjEdCxUMZW4MQsVI8O0wFTGuSBvSzSxiQl9WDXJ3CRS07qZh9qNEURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUMFOOWQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7LKGE6MRtlacDvpTFQUip7KbS0zC7gWHeW9mkXzYfk4=;
	b=BUMFOOWQE47eqOtzUrcf1+Yb0y1Lt48MkXS6mJ14Q9NhfH09v5g71h1vEZA8E48LFqyXdc
	l1E0IDKJ6B/WrAdZgnNAk8kSBZ3AS0JYSJHTBIcgZuFslNSFPvDTDxUaEXBtr+dAqEVWcB
	LDQDUE+4ltoXPrO96PdXXdbkysc+HJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Egrw84fdNwiTB55wmNo6hA-1; Wed, 16 Jul 2025 09:37:22 -0400
X-MC-Unique: Egrw84fdNwiTB55wmNo6hA-1
X-Mimecast-MFC-AGG-ID: Egrw84fdNwiTB55wmNo6hA_1752673041
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso24978675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673041; x=1753277841;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LKGE6MRtlacDvpTFQUip7KbS0zC7gWHeW9mkXzYfk4=;
        b=PD23N5xvPutWpmbVCF1ZZllBWWp/RLKwZYeFwE07sGFKg97KRcfI/9WFlPBBVfpEh8
         wqzzdrSBYSvY+KGOHINxTlXsnpZQr/qMJsus2LHHFyxraR5N+dM9mc2YObBGCwZZ1Ksz
         gRSMrgLaZIlMfxUoWnwmp4xYfILCVBmRyKsIKdMLc52oHQcXKKyjxH2eW1MNJbBk4xf8
         hKZJvNex8q5xKacKMIbjH5/E9zvQyjF2ZNkP5x7PaNQjIQRY4OnPXiJnLJuaBZGp3eAs
         ZMtH3sk/ygCKDUvN+6lfxwVrg/3OpBDEKW1oCoDC4MDRV+NukZDdG4TfaooHeNRUKswC
         cZjw==
X-Forwarded-Encrypted: i=1; AJvYcCVOlmWGMXxd1Xzisg26nfdX6I5Dt1D/L5s8oLWzmz4E4oHK8mMWY3Edf7hTB4dLQ8hSTC5lNzz2IldIJxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMQ6lZOCRtq6NAZMOTOV70yAZGT9Ax7LL9Xjvo5q6VdXYTu7s
	bhgFG5x9fdEPB13exuQ7dyh3uHjzSfkF+NiKMIlkb+KER2+332JMhb3mJ1d1QMrCYIZJsw7sUgh
	p6yoQ9i5C2zGg2ybcOuGlOMFgMbKIXFY+TRmIfI+oelEaY9Vj0LAmnBd3GO6/mi6R1Q==
X-Gm-Gg: ASbGncvtp1q9TuYQDf25i7CbYyMN5hQ3nsxsid8n4bdy8Tn01TdHWDgoF6y1wjtMc7o
	k18rO6Kpj3r2nS2ewVxKqhfMLx67IIumwqxe2A+Mn6j+AFnBdTUg9kKANkiDGHmYBE0KpdF4AfN
	xeb/hYHQDh7aqP1DLNk3hGvNSc/nXylmr7ULavRvRqfFuW2hgHUjYEozk/LeadjV2vAHK/qJFLX
	itesGBu/DgCiz2dzhsUMGE3PgL1RuyFkBoC8UkAFcbuMFi/o9hlDx5k9hXPR/rhg3Nc5CpT4q7g
	+q24k6qomRHPZLxq1OP7e1VbzlJNl72w3B8zh2vM+fTI3Zk5Y2GFdckKDlxKFm6z1lI34k5U8G3
	ta3kUI1ESOExXnmknsCqMbWHRpyhNW+5wkE0+Sx+16ULoQ3/rHAZtqUY6QCCcqbcncxY=
X-Received: by 2002:a05:600c:64ce:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4562e37c11fmr22929745e9.26.1752673040908;
        Wed, 16 Jul 2025 06:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8G+jGGD7KTcYXzAVinb8gJMEiJSEialmS2L/IJ3Drjm0pmmtKT9hw2fViB68qlc4yPZDgMQ==
X-Received: by 2002:a05:600c:64ce:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4562e37c11fmr22929495e9.26.1752673040475;
        Wed, 16 Jul 2025 06:37:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm21462665e9.12.2025.07.16.06.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:37:20 -0700 (PDT)
Message-ID: <4e098a16-1213-44d1-9585-88f9041fff57@redhat.com>
Date: Wed, 16 Jul 2025 15:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
 <bbbbd8b8b1d0bb2cd2f63dece62ed8d773cdd4d1.1752586090.git.lorenzo.stoakes@oracle.com>
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
In-Reply-To: <bbbbd8b8b1d0bb2cd2f63dece62ed8d773cdd4d1.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 15:37, Lorenzo Stoakes wrote:
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
> be located in mm/madvise.c.
> 
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
> 
> Put a static function in mm/madvise.c instead - can_madvise_modify() - that
> spells out exactly what's happening. Also explicitly check for an anon VMA.
> 
> Also add commentary to explain what's going on.
> 
> Essentially - we disallow discarding of data in mseal()'d mappings in
> instances where the user couldn't otherwise write to that data.
> 
> Shared mappings are always backed, so no discard will actually truly
> discard the data. Read-only anonymous and MAP_PRIVATE file-backed mappings
> are the ones we are interested in.
> 
> We make a change to the logic here to correct a mistake - we must disallow
> discard of read-only MAP_PRIVATE file-backed mappings, which previously we
> were not.
> 
> The justification for this change is to account for the case where:
> 
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.
> 
> If we were to now allow discard of this data, it would mean mseal() would
> not prevent the unrecoverable discarding of data and it was thus violate
> the semantics of sealed VMAs.
> 
> Finally, update the mseal tests, which were asserting previously that a
> read-only MAP_PRIVATE file-backed mapping could be discarded.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


