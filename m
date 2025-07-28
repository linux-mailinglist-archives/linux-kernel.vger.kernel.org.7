Return-Path: <linux-kernel+bounces-747699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE5B136EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8E3AA48C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7D3398B;
	Mon, 28 Jul 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX9YQp8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB52E36EC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692333; cv=none; b=obwy3pKqSaRtR8E61AOmQk7EjZXtUn/JYvgWemu5CygFAvelMD1FKJZ++UIalpd8mzQqXDkYnhQmp9qOtXbNON4WghlJdSJZPD8sSpKbUue7mWXVd0y0MNGK47DaLe1F78IuiYK4I62FUJBQz6pD2VNlmrBYU+C866tNNoFw4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692333; c=relaxed/simple;
	bh=HJZXsA11lxr8BqYgWr8HoEhcYGee8uuvfqpfw8y1UJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtPmflK4i42jmrX1rrMg3NW2eMRSZabTi1Bhiyass6sMDoewaHfoSfGHKVO+VUItMISISwVrNfnEeV741HZMeQCzH2RccY0yzZSBAy7M974xplBxUDyqJNu0V9pkiKVyRU6/hTOikFJtAN/hPtSY6g2UQ3EihToWYff2M3U6Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX9YQp8d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753692331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xOI/nhsp0FQxSML+6RN9rUzsV1D1LgxO16j6gmYC+9k=;
	b=cX9YQp8d4tDASB7UilIfCtmzCAlddBxCXl7i+PzrwNN4eqZwyKsv1RBtRgrcokecXPrcoX
	akR2FxFOMEEHOfS3/z8ThBMRV28L2HloZwbOS+TYwa8/v5x2EPUBq2WxFxBVwWskO86F3m
	glz7EGwqdFscCA5r3NXwfZ2Rb6jNMQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-_04SKQAPPZ-Mn-nmRLnxVg-1; Mon, 28 Jul 2025 04:45:28 -0400
X-MC-Unique: _04SKQAPPZ-Mn-nmRLnxVg-1
X-Mimecast-MFC-AGG-ID: _04SKQAPPZ-Mn-nmRLnxVg_1753692327
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so26587275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692327; x=1754297127;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOI/nhsp0FQxSML+6RN9rUzsV1D1LgxO16j6gmYC+9k=;
        b=BRiJgLbg/rMD4bfVDpqR+HFPzvrt62nc6N2NoghG+EPPszOAJmv1Om9z1tIn/eiX+E
         oHBx5Kul0iDSfmoKXhgbJ83qWoN79yklRbhgfGgAvA18CwQFbrAR0dgMYS/ovoODBPC5
         9JCjV/QW+Ns234dOEiVJabuiViK/S8EKgWoL07O/eSKBzO3kJlSJe3rNJ+v6t6Vx5R0C
         RUnaEPFb17MNMqrCe2GGtcaVjVlf2/BzZcQbkZHFDs3xfV1iMQgakIxLTDKexqZzJgAZ
         tA+adZ42ZXLBEdrPLzO5GueoGimUA0ifauZi4ZNPiiWLhiV9wTcTOt3eaOYmIHY0ZVZL
         G5VA==
X-Gm-Message-State: AOJu0YyAQgo/6827L2x9F4Sguhmd1Sbh83viqxDgFWCZmRhUEbUy2tbK
	KeZcjDtAeAO0qMUslZ6j2t5XMC0HXcXrhgzQeHibJxYFAzFIaNI1zNv/9AICucHvdk/mfBmru6J
	YEmIXU/TkU1KM9jufdUOcuiXhtjq9G4oeJ2mBdrLMokW4uJRgbMwkanbWZpHS1TYlXw==
X-Gm-Gg: ASbGncsTb495k8kVXq9SsJ4G9v/w2MJVuPbYx9vELGtM5LYGP1ilo0TaKJoUu5eMWP3
	IgNybLD0NUYJ/tJIYHMYZ3fdsAeW8X+b/YeYxESuXN9O4OgyU0qFh5g+p0kWNYo+0N81UBu4FAi
	2NT+QdgUpPvzlKEhSCzg8zQJYL+iZSwJYqwbXh9PEATjiOyqeratZKm2p2LZ+azE0QUxEgAEsMh
	idXkXUF2ZCCIV5c2ng2zw4LrvPxdNxATT3jt4UvOnfOf9fqYBSPd4RtRFeI8u34loJU0YzfTAhF
	ED2+CI3SAKXdXoq40mS4pSDq3VBYoO/U5QfUuwdlumsZRmEi2ji81UumERGcb+eDGSvpKDDS7X7
	Czf/z2hm/GvPXWirDTMvt4u3vDqeAwrJ/bVIxqgluywpugpPsqHKwc+d7cZrQQ5BbCmM=
X-Received: by 2002:a05:600c:c4a5:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-458763179bcmr74260215e9.13.1753692326823;
        Mon, 28 Jul 2025 01:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ytbTFRQr+toJytfGYg9ytmkAf7bGWIT/KNRNPVSHmspPTjkBiFTwTnkeGrsjvDaNVuTIwA==
X-Received: by 2002:a05:600c:c4a5:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-458763179bcmr74259825e9.13.1753692326327;
        Mon, 28 Jul 2025 01:45:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4fa5sm151414405e9.26.2025.07.28.01.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:45:25 -0700 (PDT)
Message-ID: <558720e0-f145-469b-89b8-c8d6ec41da0c@redhat.com>
Date: Mon, 28 Jul 2025 10:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
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
In-Reply-To: <20250728052742.81294-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 07:27, Byungchul Park wrote:
> Changes from v1:
> 	1. Rebase on linux-next.
> 	2. Initialize net_iov->pp = NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> ---8<---
>  From 08b65324282bbe683a2479faef8eb24df249fd18 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 28 Jul 2025 14:07:17 +0900
> Subject: [PATCH v2] mm, page_pool: introduce a new page type for page pool in page type
> 
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> For net_iov, use ->pp to identify if it's pp, with making sure that ->pp
> is NULL for non-pp net_iov.
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---

Nothing jumped at me, so

Acked-by: David Hildenbrand <david@redhat.com>

for the MM bits.

-- 
Cheers,

David / dhildenb


