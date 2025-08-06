Return-Path: <linux-kernel+bounces-757599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F7B1C411
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AC2185069
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5CF28A1FB;
	Wed,  6 Aug 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFsNEfJw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AF632
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475174; cv=none; b=Y6L+BzA0A3XWoOGPZYAhga3uR73U1hplE97gJDftIZp86OFirNWbtBpqq3eWGQ7ZKvKSP4Ra3mwIMfU8aoh+skzB1CISTMDe5pXUiZ7T8kUoe1lQ0edLAnzP5hq4gKvwAtiQgZ4JWxaNDTlv1gsKJxxIFFFQpX7IIHn6kZLPiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475174; c=relaxed/simple;
	bh=rcdcmo7ACBawJsZneZLpPwLVQCgreLjRVXqFgAe0sk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc9zXEnG6zrs5MUeXaU3I/EaJM94Fg82vHIPhsoS7RfVu0N5Rcxr3mEDW5a1twdiTZOZCeKzSVj6uYNpMoafRJMvXvmQ2FHBuE3+z5fDQjcgrH2it9Ta7gGdSbJaKTwpnPrXo9SVqEJnhQMoy5Zzpo+ztQQ/W9cXCgs1RHlsnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFsNEfJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754475171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nKNoeRnJQHE9xlWRNjmXu0K+b82kSOJOZJ1O9/cC1ug=;
	b=LFsNEfJwrFdYgMKmoEoGSQ8/vZOF+QQBzT1ijjx9h+K/taTPgDTJLm30ZbGN5g3Dc8zJ/W
	fc3VesgVAaMAzjKjTTAUlXdZqafzxbsBypU54z6kwDX/Bvmct0BWfDWU3W08YZFR6RbOzr
	7eghnG6UtOvRPkWgfkO+MOO75M4Ro5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-InwS_EFmMSuxD20iiIA5sQ-1; Wed, 06 Aug 2025 06:12:50 -0400
X-MC-Unique: InwS_EFmMSuxD20iiIA5sQ-1
X-Mimecast-MFC-AGG-ID: InwS_EFmMSuxD20iiIA5sQ_1754475169
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so3828080f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754475169; x=1755079969;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKNoeRnJQHE9xlWRNjmXu0K+b82kSOJOZJ1O9/cC1ug=;
        b=cZEf2/tmoZDCZO3vb3aib8gz3FeCXepcfLpYxUwpfBdauRBYRFsfc1EGffwkmBkim1
         dbREqk29YYzQIHDWWFFYejOiWFDrRjeaiOvOI6DFEbjJ6kv9A6XZ0fvPxDI0qokXe1KR
         GZ+dsHcvdFFo9WRHrMAApe72Yh8CfcvEijNNcwvA+ZaSfZDlyAjzBJHOuUTCQgjtoAvM
         txswqcBrfIEcQtlVystmaJM7Fn2kfjcqXBoRgfdfEhbzJTzp7gcDVBJv2ebaqsabyz8l
         QkfdV3eGlRK7UX0ajfAB3hRfeoFkEAAwikyD0GhvGte/+QRU7PKPx2yhxjH9HmrdOTfn
         xpOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoi0SKuuyj0lslgqci1wV3OxFnQN/FEYu+y15y6tcZuzEMe7f08nC7ML14FHE0i3zpiRT4HYkQ39i1gpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYai0rSwBjipz8q4/S/q9O5LTRQEdfQt6mGDXXimdlZP2tTILv
	uMZHzbdTDDivYX/iBcew7CUzG05dV7IDGxDAF3+0rnF/Dhiwqz4IBEOFv3pz1kZ51Tjpnqponp4
	uGWi1je8xVYWdm/C1r9adVs425ZXlDJBvSqxpBdJ/szZnIvryZRRCTARDQ03wNSJBOw==
X-Gm-Gg: ASbGnctYZ3OXwUdwVTmgrAb8yBoaa2NfkAhMUkBJOJeJ6AXlWSCSMtTCnUpdfhpQRW+
	Kq3RlkAH+KInY2+lz/cv1wIsM6rWI1wI6SWE3W9a2UNfnC5d4dRxezLyc/MFzo28/RQFdhe5eGr
	Mxwc3U6UCrBdyHrG+8S65FqH049T1tZs+8wqT6LGqzZs4uCzZlDa6e5ECEb08y27RkQ4asCNpKZ
	xRKODg7+xdgcoclkJCwv39/OgX2ceIDTZVoH38J943GWc+M3Esd8NyK+CPWI1wF8Gp2u+IoQthu
	iCSo2C0Pzs1XJRt26dPVBI1DE+fHhFMNxtZr+JYKp74OIvgF4Ei4h+k0KPh7/MY9JbY3x8GBecT
	SpMcWYcsqFY0wGOIpd22s8VUaJVnM4pfpy3p/QPRbvyu8uINptmUbvsOfxgliOINHlwo=
X-Received: by 2002:a5d:5d0c:0:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b8f41595c0mr1938066f8f.2.1754475169363;
        Wed, 06 Aug 2025 03:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMTciqXottdcIXxB+Q4n4Az73fuhye2kzUIBiQJuGVEgLhsIdk2Fj8My1CS4lJuGy9WxthHg==
X-Received: by 2002:a5d:5d0c:0:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b8f41595c0mr1938017f8f.2.1754475168846;
        Wed, 06 Aug 2025 03:12:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5d0b1afsm38474915e9.26.2025.08.06.03.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:12:48 -0700 (PDT)
Message-ID: <e7a52474-784f-4c7b-b4b5-d8dba30ddd75@redhat.com>
Date: Wed, 6 Aug 2025 12:12:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Dev Jain <dev.jain@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
 <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
 <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
 <1b3d4799-2a57-4f16-973b-82fc7b438862@arm.com>
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
In-Reply-To: <1b3d4799-2a57-4f16-973b-82fc7b438862@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.08.25 12:04, Dev Jain wrote:
> 
> On 06/08/25 3:20 pm, Lorenzo Stoakes wrote:
>> On Wed, Aug 06, 2025 at 03:07:49PM +0530, Dev Jain wrote:
>>>>> You mean in _this_ PTE of the batch right? As we're invoking these
>>>>> on each part
>>>>> of the PTE table.
>>>>>
>>>>> I mean I guess we can simply do:
>>>>>
>>>>>      struct page *first_page = pte_page(ptent);
>>>>>
>>>>> Right?
>>>> Yes, but we should forward the result from vm_normal_page(), which does
>>>> exactly that for you, and increment the page accordingly as required,
>>>> just like with the pte we are processing.
>>> Makes sense, so I guess I will have to change the signature of
>>> prot_numa_skip()
>>>
>>> to pass a double ptr to a page instead of folio and derive the folio in the
>>> caller,
>>>
>>> and pass down both the folio and the page to
>>> set_write_prot_commit_flush_ptes.
>> I already don't love how we psas the folio back from there for very dubious
>> benefit. I really hate the idea of having a struct **page parameter...
>>
>> I wonder if we should just have a quick fixup for hotfix, and refine this more
>> later?
>>
>> I foresee some debate otherwise...
> 
> Yup I would personally prefer that. Although if you would like to see the churn, here
> it is (based on mm-hotfixes-unstable, untested):
> 
> ---
> mm/mprotect.c | 27 ++++++++++++++++-----------
> 1 file changed, 16 insertions(+), 11 deletions(-)
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 78bded7acf79..0735870e89ab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -120,9 +120,10 @@ static int mprotect_folio_pte_batch(struct folio 
> *folio, pte_t *ptep,
> static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> pte_t oldpte, pte_t *pte, int target_node,
> - struct folio **foliop)
> + struct page **pagep)
> {
> struct folio *folio = NULL;
> + struct page *page = NULL;
> bool ret = true;
> bool toptier;
> int nid;
> @@ -131,7 +132,9 @@ static bool prot_numa_skip(struct vm_area_struct 
> *vma, unsigned long addr,
> if (pte_protnone(oldpte))
> goto skip;
> - folio = vm_normal_folio(vma, addr, oldpte);
> + page = vm_normal_page(vma, addr, oldpte);
> + if (page)
> + folio = page_folio(page);

See the draft I just send, where we move that vm_normal_page() into the 
caller.


-- 
Cheers,

David / dhildenb


