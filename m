Return-Path: <linux-kernel+bounces-847906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED34BCBFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49EBE4EFE37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5024DD13;
	Fri, 10 Oct 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtUab8bh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E125A350
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082900; cv=none; b=rDI1ln+2pQ97Qg10wJLsx9Km4pzgknWXzYjz/xlZquPBGY46QbDYq6FLKexlht90pc3TW45a+7XzI2CQORoby499R8eVnbSa0tE0pUAMZRVtXK4OHHs042kQ4DdBCJTJrj2dEsBW8AEZq198aeCGQgJY0cG0q2O8ME2JyxXEUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082900; c=relaxed/simple;
	bh=0VorPrLkyHUVrjuMfLD9PMg+6va8lFyrxWCZ5eKOo6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aESLCTp4ti1pzvttmVIxXXLpyxBDwsm3w4PpbZDcJ+0QdsJhqhgui2fWEBoUa60R5Kx6Kfvew52yRPaqzwSpkHZ0a78qEs66IGiJl9PNitSMun8lcfqkOtsfzbpwC/L3zwh5UO4EN6bvQVjoET9I/X2IAMvcXWi7yScfN5ao0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtUab8bh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760082897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+pjFKpPGhPGCb6BNB3UehKfe41+RfPzqJkeretXuck=;
	b=DtUab8bhf8tK91VdWbE7Nq5fBW6qLMGWK1MB3we4NEmxi60ABd11FKSjYyj1uKfodqYXm2
	pq0bV9GOnBVZUfhjU24lUtcGdDCg3wd9UKGkcujb5tXu4bxYLY+3CvDfE4semfcYJI9nhk
	4hCvdDh5D4Yx+X3XtOYPASvVn0ssczY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-hXyw1TEbO3KTrORYYcPyrg-1; Fri, 10 Oct 2025 03:54:55 -0400
X-MC-Unique: hXyw1TEbO3KTrORYYcPyrg-1
X-Mimecast-MFC-AGG-ID: hXyw1TEbO3KTrORYYcPyrg_1760082895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so1260836f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082894; x=1760687694;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+pjFKpPGhPGCb6BNB3UehKfe41+RfPzqJkeretXuck=;
        b=HwJWXnYkUuvjD+Zctg/Mxp+JJyBMbG5NuJhyK+hva89YZW12SS2lrXAL23wSkyegq/
         Z5ZHtstaOHjnxkB2QPMNzB+ugScvu0yuWyGINNVM41S9bgpF3QgA5VAT6Cdo/SAfHlLD
         eqgfHd4WeEufipSYYmMH2PFfOX+rG5dxMJvKXrpt76DPu0047PSSHUnu5NEdHA8bDrzo
         mQLWOlthfTueAWRlLzwF/90y77Dl8nEgh76Hmt8CPubHWqWIp4nhTE696fWM/6FLO5t4
         WAVt+7ItzJ3fMFak10wbhnMU4sh4orY8612VV7pungJL92Oi2TWwgKOP3ZNrDYI/TLdL
         45hg==
X-Forwarded-Encrypted: i=1; AJvYcCXMEI9PvIL4jN8zdNAhw+W642W9vDZ13zfCyLAzj8d996QM5U2WyK83gD1ZNZmYJkBlrZB4e2XUdk6N6ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVfKGBHKeLiqk80K1nyepazdS3zn9aKHIoxhtqjV7vnGsGcph
	JxF/ohyG1PJOh9Vmcp/JAzce0Cgsr8j6QfLq4rdKxd8XpY2zPoH1ByuDM7SbSVsYT7xz3gMVufO
	qqCHW5N5+egQAhoG4cK7NFN5z2001mZPGqYgb7TAROBBEwuAWiJWiARGvxtPb/SB1IQ==
X-Gm-Gg: ASbGncuICiwKUvppwoJ3BKIT6q7+4y+pb0YkAY/a0Fqrit+MnEzzb2WwqluUSBNjke3
	tISH/MhX0fUTwyFY6Voaeb/XUBehKJfYKA2IVosvJza6zvpVTqsZg8quwG2EjnsIwXoqyfiv7bq
	JKSPshnqR4oej/PG9snZm98P0ngQ2AtyLSI4vF2QSrN0dZirJYqdhQxPmK/ADwXDXdMD3kH2wyf
	Rt6NvaWBaraessZ+9F/EzAeilqwG9LOkqvz5/m5J07Z//3qv5cpKv9wtWO15RgBe6wE1dqN0iVO
	V/Qll42QtJkfVUlvhr4kLe4esYYKYarweAf4OexihNdPsOXiShkn/YuXL9jnBNZIAjyl6AUteuc
	4Ib8=
X-Received: by 2002:a05:6000:26c2:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-4266e7beb57mr6225760f8f.23.1760082894485;
        Fri, 10 Oct 2025 00:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTTPZj7hzRMoj+OIEk2jkUAprMdCN7KGM1KZIMXJPUWlJSecGQKX1yuYPKejz1THVQLE0NVA==
X-Received: by 2002:a05:6000:26c2:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-4266e7beb57mr6225728f8f.23.1760082893829;
        Fri, 10 Oct 2025 00:54:53 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm35213505e9.1.2025.10.10.00.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:54:53 -0700 (PDT)
Message-ID: <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com>
Date: Fri, 10 Oct 2025 09:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
 Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
 <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
 <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
 <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
 <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
 <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com>
 <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
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
In-Reply-To: <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.25 11:59, Yafang Shao wrote:
> On Thu, Oct 9, 2025 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.10.25 15:11, Yafang Shao wrote:
>>> On Wed, Oct 8, 2025 at 8:07 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.10.25 13:27, Zi Yan wrote:
>>>>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
>>>>>
>>>>>> On Wed, Oct 8, 2025 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 08.10.25 10:18, Yafang Shao wrote:
>>>>>>>> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>>>>>>>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>>>>>>>>> +                                     enum tva_type type,
>>>>>>>>>>> +                                     unsigned long orders)
>>>>>>>>>>> +{
>>>>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>>>>>>>>> +       int bpf_order;
>>>>>>>>>>> +
>>>>>>>>>>> +       /* No BPF program is attached */
>>>>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>>>>>>>>> +                     &transparent_hugepage_flags))
>>>>>>>>>>> +               return orders;
>>>>>>>>>>> +
>>>>>>>>>>> +       rcu_read_lock();
>>>>>>>>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>>>>>>>>> +               goto out;
>>>>>>>>>>> +
>>>>>>>>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>>>>>>>>> +       orders &= BIT(bpf_order);
>>>>>>>>>>> +
>>>>>>>>>>> +out:
>>>>>>>>>>> +       rcu_read_unlock();
>>>>>>>>>>> +       return orders;
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> I thought I explained it earlier.
>>>>>>>>>> Nack to a single global prog approach.
>>>>>>>>>
>>>>>>>>> I agree. We should have the option to either specify a policy globally,
>>>>>>>>> or more refined for cgroups/processes.
>>>>>>>>>
>>>>>>>>> It's an interesting question if a program would ever want to ship its
>>>>>>>>> own policy: I can see use cases for that.
>>>>>>>>>
>>>>>>>>> So I agree that we should make it more flexible right from the start.
>>>>>>>>
>>>>>>>> To achieve per-process granularity, the struct-ops must be embedded
>>>>>>>> within the mm_struct as follows:
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>>>> +struct bpf_mm_ops {
>>>>>>>> +#ifdef CONFIG_BPF_THP
>>>>>>>> +       struct bpf_thp_ops bpf_thp;
>>>>>>>> +#endif
>>>>>>>> +};
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * Opaque type representing current mm_struct flag state. Must be accessed via
>>>>>>>>       * mm_flags_xxx() helper functions.
>>>>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
>>>>>>>>      #ifdef CONFIG_MM_ID
>>>>>>>>                     mm_id_t mm_id;
>>>>>>>>      #endif /* CONFIG_MM_ID */
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>>>> +               struct bpf_mm_ops bpf_mm;
>>>>>>>> +#endif
>>>>>>>>             } __randomize_layout;
>>>>>>>>
>>>>>>>> We should be aware that this will involve extensive changes in mm/.
>>>>>>>
>>>>>>> That's what we do on linux-mm :)
>>>>>>>
>>>>>>> It would be great to use Alexei's feedback/experience to come up with
>>>>>>> something that is flexible for various use cases.
>>>>>>
>>>>>> I'm still not entirely convinced that allowing individual processes or
>>>>>> cgroups to run independent progs is a valid use case. However, since
>>>>>> we have a consensus that this is the right direction, I will proceed
>>>>>> with this approach.
>>>>>>
>>>>>>>
>>>>>>> So I think this is likely the right direction.
>>>>>>>
>>>>>>> It would be great to evaluate which scenarios we could unlock with this
>>>>>>> (global vs. per-process vs. per-cgroup) approach, and how
>>>>>>> extensive/involved the changes will be.
>>>>>>
>>>>>> 1. Global Approach
>>>>>>       - Pros:
>>>>>>         Simple;
>>>>>>         Can manage different THP policies for different cgroups or processes.
>>>>>>      - Cons:
>>>>>>         Does not allow individual processes to run their own BPF programs.
>>>>>>
>>>>>> 2. Per-Process Approach
>>>>>>        - Pros:
>>>>>>          Enables each process to run its own BPF program.
>>>>>>        - Cons:
>>>>>>          Introduces significant complexity, as it requires handling the
>>>>>> BPF program's lifecycle (creation, destruction, inheritance) within
>>>>>> every mm_struct.
>>>>>>
>>>>>> 3. Per-Cgroup Approach
>>>>>>        - Pros:
>>>>>>           Allows individual cgroups to run their own BPF programs.
>>>>>>           Less complex than the per-process model, as it can leverage the
>>>>>> existing cgroup operations structure.
>>>>>>        - Cons:
>>>>>>           Creates a dependency on the cgroup subsystem.
>>>>>>           might not be easy to control at the per-process level.
>>>>>
>>>>> Another issue is that how and who to deal with hierarchical cgroup, where one
>>>>> cgroup is a parent of another. Should bpf program to do that or mm code
>>>>> to do that? I remember hierarchical cgroup is the main reason THP control
>>>>> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
>>>>> get the same rejection from cgroup folks?
>>>>
>>>> Valid point.
>>>>
>>>> I do wonder if that problem was already encountered elsewhere with bpf
>>>> and if there is already a solution.
>>>
>>> Our standard is to run only one instance of a BPF program type
>>> system-wide to avoid conflicts. For example, we can't have both
>>> systemd and a container runtime running bpf-thp simultaneously.
>>
>> Right, it's a good question how to combine policies, or "who wins".
> 
>  From my perspective, the ideal approach is to have one BPF-THP
> instance per mm_struct. This allows for separate managers in different
> domains, such as systemd managing BPF-THP for system processes and
> containerd for container processes, while ensuring that any single
> process is managed by only one BPF-THP.

I came to the same conclusion. At least it's a valid start.

Maybe we would later want a global fallback BPF-THP prog if none was 
enabled for a specific MM.

But I would expect to start with a per MM way of doing it, it gives you 
way more flexibility in the long run.

-- 
Cheers

David / dhildenb


