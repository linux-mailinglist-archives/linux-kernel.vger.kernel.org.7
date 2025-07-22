Return-Path: <linux-kernel+bounces-741141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1EB0E08D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C45609F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D5278161;
	Tue, 22 Jul 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLxkrMWh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45C27816B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198454; cv=none; b=UCQ1PXXQHXNnXJRgqVnQljktR5ggqgqRY+szPyWgk2iDNDVeyadHHPoHd8Qc91QYJtrmYY9bnh27x9t46dANdH59wLb5ptoS+FeLLjgv+03bQpJN+LfequsOYoKvqUdhPEkqXr1PRK9KTKjWRHpHaR7nKysBvu1CUtW98WBH2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198454; c=relaxed/simple;
	bh=pkz5UP3m8f6W8kRL0bugCRdfz0G/63qBOgpGTQ9em+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nygd6C/xogKif0qzR29QCSuxtdv+nnr3BsqaKtAd0Wy603x8Gh6dKidkmA7O6eBKewkQXfojV2j8re78mWmXc43Njk9p2FDSIrphua7S2hy66V0wgzvkx8xcIBzgClMM3UgLYPnu27vepDufCLB0Q6PZjOSEWlL7m3UwF8q3gSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLxkrMWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753198452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NFJzlzQIrZrtr5g5RWp1FU4rUmvP4NLit2nxv1lBD8w=;
	b=JLxkrMWh6w/6bjGWpTWMMR2ViWGIjMT+SZR07BIXm5hytwZuUYz1ScKG8vAsCKkw+xdroo
	eWFUSf+0mYxbmZxC28AbbYTQX8eVPyuLV7xyfJZ9jPLXTjYk9LBmrHhtsfZqreAvzKCyP6
	qJyDyz0b3m1+ikoQZ85lo7J+ZjEEnko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-wOdiL9r8NJ67oIhhdF_82Q-1; Tue, 22 Jul 2025 11:34:10 -0400
X-MC-Unique: wOdiL9r8NJ67oIhhdF_82Q-1
X-Mimecast-MFC-AGG-ID: wOdiL9r8NJ67oIhhdF_82Q_1753198449
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2614253f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198449; x=1753803249;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NFJzlzQIrZrtr5g5RWp1FU4rUmvP4NLit2nxv1lBD8w=;
        b=umv+9t5VlLR/h+XN7r9XNL2c+WKPefsm177Gog43j47KNeSAYkOH2gA7V3Y8r5MZBn
         d9D3A/vPthewuRL7OFUM9Ng5vByhyqhbeOM862dbTmW3D5xrdgP94thRMT6nz2cTQEg+
         bpMvpW75GyC3ziEAWs9vvkarcexzvdX8jvWYi9Uy5Efg10SbiTeUAGjELOTtm4oy2c0V
         K7yHWI9q6ynxITzPLOVaU8ZKQodhTtBEyhCa231eUCs6mEeSweQKUvLNzps32T5/+fHP
         Ho5BqdDEvV17PbqA6JHxGhajU3dH0rJtn3AaLx1DHxizYDLW+oi0z1C4NfsZmzKsm+zp
         okqA==
X-Forwarded-Encrypted: i=1; AJvYcCXnTZpE9/g0x87RZr+dB2PIh2pX+SVZXYpJ5N8GzYoPuLMLdGPk7En35UPR5Wr87MElHUf54kjKjyGe+Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFeLu9dFuurgEDCiktTvqtXGLugiZtnuFSVz0c8/3dRlu2LW+
	pY0Sbg1haX1RltsZOmVB/+2d8+e6lJw30H+4FKx6LTnYtbPr8xcErPFSBogUuOOD264P2czvmtg
	+I4rwc58QdjIkGJKqqTlcwZqDe0sro73OcF4fJ6gZTLbg8j2vWbjneMmW0wknvnLcIg==
X-Gm-Gg: ASbGncsSAOeTJlt0mOPiV6uO2mvLTCn7rym2KKCMRqDprlb8a/+324xvUcqSY5oakCJ
	NjyTKnkzfX9F9OtNhohfMEbR1Y0WGIHy04E1zq3zrTOhjdMGUmy2eH+h7krPYGXRf9LVmfuHB1L
	UjOAy376er7MJn0il1a+bsVBrP/6B2hCMtcY4zc5BzMvoPAqW1bXmImua8TQDIwJ58qOoH3/twI
	tXtejrAqKQaCqpBqVOCU4mHj8Uw9PvhOrQetmT7SX3lqgU90SDWM0hB/bsJ6ik6WqQ/wkCRCELo
	fW+BnVHtoMAdFIgKBJw2hz365nBtCr5bGVTkS286w9jKVFuW42N1YtfLWQqQYbfP8SUPc0cl/rW
	142iW01DPT86Zs7lKExi9AooiNGOVeqgUKDm1V3jMmxR3+iEMw0EPHtDdHkftbwo/JW4=
X-Received: by 2002:a05:6000:18a4:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3b60dd643f2mr16706205f8f.6.1753198449290;
        Tue, 22 Jul 2025 08:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6zAHly2HfsHo0ZiS36DMz5VnskMV4roAjV49lglrClLRujakCNo+BgOMzFbCL+20f0T3bJw==
X-Received: by 2002:a05:6000:18a4:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3b60dd643f2mr16706173f8f.6.1753198448759;
        Tue, 22 Jul 2025 08:34:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25678sm13586321f8f.12.2025.07.22.08.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:34:08 -0700 (PDT)
Message-ID: <5c46c13a-d558-475d-88ef-44b9ed8519f0@redhat.com>
Date: Tue, 22 Jul 2025 17:34:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in
 __folio_split.
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
References: <20250718183720.4054515-1-ziy@nvidia.com>
 <20250718183720.4054515-5-ziy@nvidia.com>
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
In-Reply-To: <20250718183720.4054515-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 20:37, Zi Yan wrote:
> These VM_BUG* can be handled gracefully without crashing kernel.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/huge_memory.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d36f7bdaeb38..d98283164eda 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3601,8 +3601,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   	pgoff_t end;
>   	bool is_hzp;
>   
> -	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>   
>   	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>   		return -EINVAL;
> @@ -3766,7 +3766,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		}
>   
>   		if (folio_test_swapcache(folio)) {
> -			VM_BUG_ON(mapping);
> +			if (mapping) {
> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
> +				ret = -EINVAL;
> +				goto fail;
> +			}
>   
>   			swap_cache = swap_address_space(folio->swap);
>   			xa_lock(&swap_cache->i_pages);


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


