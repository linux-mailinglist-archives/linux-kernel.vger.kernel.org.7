Return-Path: <linux-kernel+bounces-855770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D96BE2415
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558673AE7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799930DEA4;
	Thu, 16 Oct 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL2khYwU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E930F7E6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605151; cv=none; b=pSb71UZWXZlUxoZrQwZDtFleKZLAhGrIkdH3JIl1cwkpdKP64hQ4Yd3cneAKCiWZ7TEFp4VYfNEomf31TYTqfkOlGukWAyBxvdas8BBW5E4a8K3AebDWT8woGInWgr+xZrrZyOM67TNSc6RU0qrXRtcJH1l3xUIYM0ZdVJXDWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605151; c=relaxed/simple;
	bh=wTTMP8IisgqaWWW9B7IRAmdZEatuHUTw0oMizMHdEGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1TmI++PBV1F+jGUWpw6UyB6wy6BUVYmZ5YaB3unJMwREnPj0S3r7/JqkzpGqf0zRFo8hdJP/NHG40zEHEe5LK+rjNhl/RQAq9P1TQuzuENrOkNqFunL++SFQ8qjirxIFpr4UxGpM4PweRIEgfqU96eX2X7awQLoLXaIDeJpL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL2khYwU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760605147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kapyuiv8tsDIKt44CfN5IZYLsxk7UX5m2+M0d9ZIPEg=;
	b=NL2khYwUeELqGQUu+1p6YjzXxtR/6GjeotOfiGrVUhZtePLQ8T4odvRilzfU0LyCcL6rZx
	HWu/4xp/4w7cLe1FZHNIc7+flpdv4m5Bgtq66h1p99C7R40lHPQHn1jqMczVu8DLMHiLmC
	N5MFGXyHGPltRV5ngbELFp2z8Qzo2Xo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-iDcQoEtDP3-JUknUVDeIGA-1; Thu, 16 Oct 2025 04:59:06 -0400
X-MC-Unique: iDcQoEtDP3-JUknUVDeIGA-1
X-Mimecast-MFC-AGG-ID: iDcQoEtDP3-JUknUVDeIGA_1760605145
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso2315105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605145; x=1761209945;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kapyuiv8tsDIKt44CfN5IZYLsxk7UX5m2+M0d9ZIPEg=;
        b=VQ8U8z0XoUKRHal771XJxFDsxh0bQQoZvvMyYzmy/MuRZZS8BXViC2+mPlr+uyauVE
         n5dDKCVaqP7NzQsmq1wyRhCm2K7pdFMZ5MuwGekq/n3vwqNXcuTNpmsGE/LIXyo6kXCu
         3d+25PZ+tdHPZpzv6+V6z5vG7ZgpYrs6VLAC13Er9qiZcQ6mKJdWI0HVR5HbpyLqJYBi
         4kInus3vIyCREEvUxlVpdacFTEJDeGLhoSz9Nl2ow4qBsNbsO9NUWGphlb06lD340k4g
         6sXKj/mWCvuY9c0rbkEAGfAVHM4n4doEIVgWw3XVaWaWNEin6Hn0i83r2sqdceWdqyIT
         Y2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX5wPVNpRiuOrt7fEgLVZYszN1hFk4P/1erRPrDa8GBLEJOwjYHxcUIJ89yNyUIoysCTKia/81dxDAHKFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8R7k45OPqdnXEfSKy+/IKgiQPLZGBZBVsSxnfSk8t+dQ7Tskj
	Xyx77j+cbRaVkHn5ARl9DLWCW/fqAqV7sTfYu3j3BYMtk9yRWakHcScCCY0q51gi8kIOAFpjOE1
	nvm6M48wNcyXLsN3XcXiZ+Nz+4dl+cPo1OTtd+OzXtLuFQkxCAReKE06VucNkVC5+GA==
X-Gm-Gg: ASbGnctEgejuyAKWg8mBLGVIBDfbHtnZsvLVqW6efA8X7UiVTre6aCbe5etSM95q5qt
	BxWfYtjQDfl4bw+4QwgwTLLsAVBQh7pJfm+GPseOmyG2fE+1ApF0wiKDgOh/BRw3J5qJhct/3kJ
	rX1hJcMkqesDU4o6gvuq4jcKVDI0xv1K8Vn07kdY07ijaYDQZ+ebQ4HqvaXwFjYo1yZPV7VyvTi
	+zIUDXOsJ8Dhh29NtyvbhUfKC5zTD96b8JXsWcYc0xr9b6eG16p2Nanx0WK/JKUSTavFFizOBGI
	3nq0Q99uQakQx2S9g6Z0NQSH2AMgh1pTvrw8tsX96hJ7+z0nmNhwIgvaaGAkKNljZxjNKhBE6iM
	p0tTaSA2qUFSL9h3Zz27ivYvDG1LHqvPzJZ9MDQ9+Glo5lWjbC7f9Tx0b1brtv4o7QzxX7Khrn5
	ftqy+MNMUGPs2UPf4Nb/3HvF5FtZk=
X-Received: by 2002:a05:600c:c4b8:b0:471:a98:998d with SMTP id 5b1f17b1804b1-4710a989a70mr15406225e9.12.1760605144896;
        Thu, 16 Oct 2025 01:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0u7pM/I5UH2Tdmf79ws175Qz9y0o5UXmeZBEsLNdrgt2fV/TSg5wXNlsc+YKlMr/W4eYM/g==
X-Received: by 2002:a05:600c:c4b8:b0:471:a98:998d with SMTP id 5b1f17b1804b1-4710a989a70mr15406125e9.12.1760605144496;
        Thu, 16 Oct 2025 01:59:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82b8sm13134415e9.15.2025.10.16.01.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:59:03 -0700 (PDT)
Message-ID: <1f7c3b59-3276-4f6e-946b-5f6ac9807e93@redhat.com>
Date: Thu, 16 Oct 2025 10:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge
 pmd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-2-ying.huang@linux.alibaba.com>
 <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
 <87ldlcpnbx.fsf@DESKTOP-5N7EMDA>
 <d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local>
 <87bjm7lh4u.fsf@DESKTOP-5N7EMDA>
 <3fc642be-b8f3-4fcb-b13c-3359cd52e921@lucifer.local>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <3fc642be-b8f3-4fcb-b13c-3359cd52e921@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 10:25, Lorenzo Stoakes wrote:
> On Thu, Oct 16, 2025 at 10:22:57AM +0800, Huang, Ying wrote:
>> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>>
>>> On Wed, Oct 15, 2025 at 04:43:14PM +0800, Huang, Ying wrote:
>>> OK this is great, let's put it all in the kdoc for the new shared spurious
>>> faulting function! :) and additionally add it to the commit message.
>>
>> Sure.  Will do it in the next version.
> 
> Thanks!
> 
>>
>> [snip]
>>
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index 32e8457ad535..341622ec80e4 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>>>>   #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>>>>>>   #endif
>>>>>>
>>>>>> +#ifndef flush_tlb_fix_spurious_fault_pmd
>>>>>> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, ptep) do { } while (0)
>>>>>> +#endif
>>>>>
>>>>> flush_tlb_fix_spurious_fault(), when the arch doesn't declare it, defaults to
>>>>> flush_tlb_page() - why do we just do nothing in this case here?
>>>>
>>>> Because all architectures do nothing for the spurious PMD page fault
>>>> fixing until the [2/2] of this series.  Where, we make it necessary to
>>>> flush the local TLB for spurious PMD page fault fixing on arm64
>>>> architecture.
>>>>
>>>> If we follow the design of flush_tlb_fix_spurious_fault(), we need to
>>>> change all architecture implementation to do nothing in this patch to
>>>> keep the current behavior.  I don't think that it's a good idea.  Do
>>>> you agree?
>>>
>>> Yeah probably we should keep the same behaviour as before, which is
>>> obviously, prior to this series, we did nothing.
>>>
>>> I guess in the PTE case we _always_ want to flush the TLB, whereas in the
>>> PMD case we otherwise don't have any need to at the point at which the
>>> spurious flush is performed.
>>>
>>> But from your explanation above re: the stale TLB entry this _only_ needs
>>> to be done for architectures which might encounter this problem rather than
>>> needing a TLB flush in general.
>>>
>>> Given we're generalising the code and one case always flushes the TLB and
>>> the other doesn't maybe it's worth putting a comment in the generalised
>>> function mentioning this?
>>
>> I'm not sure whether it's a good idea to document architecture behaviors
>> in the general code.  The behavior may be changed architecture by
>> architecture in the future.
> 
> Right, but we are unconditionaly doing a TLB flush in the PTE case but not PMD
> so let's document that to be clear :)

Agreed! That's a big benefit of merging the code, it sticks out what is 
not common already.

-- 
Cheers

David / dhildenb


