Return-Path: <linux-kernel+bounces-816836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A8B578D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35207B1606
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966AE3002C7;
	Mon, 15 Sep 2025 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO9Eef93"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAA2FABFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936748; cv=none; b=ap8Ov+qOkXTqswPBgT6OTHjnRxleNg/kyB4V6eZI46KgSdIMo2Zr24OR3gwTAIDeP52GwOtLBiK40zp3H7itvBS6LqtHI6esGSlQdxmjKsiZ3l2zSWCfXn4iD2V8kOB5XUmxRLSgEcmDMNg8zo98f+GXm3lKuYs6jtnUzB2K3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936748; c=relaxed/simple;
	bh=UpQ/kxG95xnFQz5rlrXuv79Yt7TcBnt2uUAyoU32Xyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDlmtmxMni3dCuREEOg/DByWCzC2o5ntfntqZxY2Kuj05ZCCq/+64MKQemCx84mFVjoHmnuZmjXAd7BRhn7nWd1wXRlevBKN8y0t7FU1p8uoxvUtArbaJGxEdD2vtqQxSwU25eHofA8evQO5Of3E/NagQ1jpLAIf5FqVqv6KmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO9Eef93; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757936746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Ng7yCw1wP5MZtSwh7Wi4NlfzosbrOaxU97IITYT9yU=;
	b=PO9Eef93l6e7At5hMF2Z8nkLDG+u8uIMXmkT3rwQtddr2TBj1bEcT8aYAo6/CBt1SC2l+3
	CmHTNXSB0+m/BAJLJY5LVtyDEOZxmmKl2sBY8v8pxFWO01WGQA3C+jC/Cv7duKPGChnYmi
	AaBE8wXurVDkigjSRxc7NdfiEyNvGfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-EPgP4ndVPbqrXYu31Y1qIw-1; Mon, 15 Sep 2025 07:45:44 -0400
X-MC-Unique: EPgP4ndVPbqrXYu31Y1qIw-1
X-Mimecast-MFC-AGG-ID: EPgP4ndVPbqrXYu31Y1qIw_1757936744
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b467f5173so27775515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936744; x=1758541544;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ng7yCw1wP5MZtSwh7Wi4NlfzosbrOaxU97IITYT9yU=;
        b=SHZ6TPh6CDDGR9VW5o/aJ5tHIKwGB7HDTR3FPxmOpL2sCqXLTXqkiP2+U9sqRp6FIh
         Eq//QOGL40/9sjGcrx5Q2YxXC0HN/6weRwXSyq/B9qAfz9pmUeCMSyPDiAlVOcPwKN1O
         /UjYZ2eq/zyhqnb2cScLJDh4UD1TPFHq2IU4SVFfh4siWUGfmH3mG7AgmMYVwUD4QT43
         2Ywz82XDjuXJvVXWm/9/6zyn64ajIjIGCrKXGG4EFl6e7B38bEEGnz9/P9JxrrOxVcl4
         4WuZvk8dkewe6E6JPf0tnZX1WAlMo7nIG64825URjsKWk4YYdQ2vJqMepGoAYvERd5gy
         Lf9g==
X-Forwarded-Encrypted: i=1; AJvYcCWGqBWBwvZCpR9Cebfspkcit6o2kPSDTRda2P/hiu9gV3Z6XJOKBwv54teB+KKWW21s3M66//ZlocfmDIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdcd9Bmw0cObnkV8la0sBvkyiYREyaBX/+sn0eCv93g/6rh4zd
	Fa527i/A+Wxz+SfX0kFDN2eQyIBWx/vZCT5CDQDel66AD6ncZ48tEmC+z2WRA8VO+3f2OFR4ZKA
	0s0dgAt4D0ijYjU2XZGboJkw0DjmeMBSF2OTJxGRpasyDDhzvqEIB+YpOigwB241dCA==
X-Gm-Gg: ASbGncv5Yzh3Gi1uW9LXSr+qyIlZKDyYZK6vSdOiOb1qSrqe33xLuu+zRamJdJ3SMzQ
	LI+Fm3wzADlBqY1SdnLic4ILOv/3ig4n0cUZSpniFH9SiJo2jQXvcLNBY6/9zH3kjI9VgY9XOPY
	LNVTm6R4r3b+cmwVphPGzuLSsYHXLsQn2DVDpu2zk60dGJcZcKSGelPqIZy+3R8eoFOfCI+Bl02
	RDaO4+NJjR/8cgJodYAmBDTQlpwWiJMbGxv+i4iHjLuk16n+1v0AH1yNO80tKglSqsOpJ8m3DYq
	7ywyf5nCA8Xjzsxfffq4c4M53e+rSvOTaOH5gg4BCjRfWCp6oVYZ5Hy1/nYI4uy9wZfZ7xXN2Ek
	worpyRBo8ytzGVYnVt+I19bD8bFdG2s2eCzgC+cf6iAYxBd9Ty1wGx3E4Taql5cxOYPI=
X-Received: by 2002:a7b:c04b:0:b0:45b:81b4:1917 with SMTP id 5b1f17b1804b1-45f211d5d6fmr95730605e9.10.1757936743684;
        Mon, 15 Sep 2025 04:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHWeQtRmvajOk6PjvNrrZnGwcCmKaM8guZ/XD7rSJpezG2pi0yt91kJg016WDbZLNw0/ir1A==
X-Received: by 2002:a7b:c04b:0:b0:45b:81b4:1917 with SMTP id 5b1f17b1804b1-45f211d5d6fmr95729955e9.10.1757936743224;
        Mon, 15 Sep 2025 04:45:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017c0643sm172762125e9.23.2025.09.15.04.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:45:42 -0700 (PDT)
Message-ID: <6ec80746-2945-485f-930e-8cc34446f9e3@redhat.com>
Date: Mon, 15 Sep 2025 13:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
 <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
 <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
 <e450009a-56c9-4820-bd0c-da1d782d3962@redhat.com>
 <2757fb07-78bf-4a39-8c60-8ca8be200994@lucifer.local>
 <a48c8d89-da30-4a7d-96f6-e5e17757b818@redhat.com>
 <e0580a44-2afc-4f3e-8d3e-d4fe9b2eeb21@lucifer.local>
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
In-Reply-To: <e0580a44-2afc-4f3e-8d3e-d4fe9b2eeb21@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 13:35, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 01:29:22PM +0200, David Hildenbrand wrote:
>> On 15.09.25 13:23, Lorenzo Stoakes wrote:
>>> On Mon, Sep 15, 2025 at 01:14:32PM +0200, David Hildenbrand wrote:
>>>> On 15.09.25 13:02, Lorenzo Stoakes wrote:
>>>>> On Mon, Sep 15, 2025 at 12:52:03PM +0200, David Hildenbrand wrote:
>>>>>> On 15.09.25 12:43, Lorenzo Stoakes wrote:
>>>>>>> On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> 0 -> ~100% used (~0% none)
>>>>>>>> 1 -> ~50% used (~50% none)
>>>>>>>> 2 -> ~25% used (~75% none)
>>>>>>>> 3 -> ~12.5% used (~87.5% none)
>>>>>>>> 4 -> ~11.25% used (~88,75% none)
>>>>>>>> ...
>>>>>>>> 10 -> ~0% used (~100% none)
>>>>>>>
>>>>>>> Oh and shouldn't this be inverted?
>>>>>>>
>>>>>>> 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
>>>>>>> 10 eagerness = we aren't eager to eat up none PTE entries at all?
>>>>>>>
>>>>>>> Or am I being dumb here?
>>>>>>
>>>>>> Good question.
>>>>>>
>>>>>> For swappiness it's: 0 -> no swap (conservative)
>>>>>>
>>>>>> So intuitively I assumed: 0 -> no pte_none (conservative)
>>>>>>
>>>>>> You're the native speaker, so you tell me :)
>>>>>
>>>>> To me this is about 'eagerness to consume empty PTE entries' so 10 is more
>>>>> eager, 0 is not eager at all, i.e. inversion of what you suggest :)
>>>>
>>>> Just so we are on the same page: it is about "eagerness to collapse", right?
>>>>
>>>> Wouldn't a 0 mean "I am not eager, I will not waste any memory, I am very
>>>> careful and bail out on any pte_none" vs. 10 meaning "I am very eager, I
>>>> will collapse no matter what I find in the page table, waste as much memory
>>>> as I want"?
>>>
>>> Yeah, this is my understanding of your scale, or is my understanding also
>>> inverted? :)
>>>
>>> Right now it's:
>>>
>>> eagerness max_ptes_none
>>>
>>> 0 -> 511
>>> ...
>>> 10 -> 0
>>>
>>> Right?
>>
>> Just so we are on the same page, this is what I had:
>>
>> 0 -> ~100% used (~0% none)
>>
>> So "0" -> 0 pte_none or 512 used.
>>
>> (note the used vs. none)
> 
> OK right so we're talking about the same thing, I guess?
> 
> I was confused partly becuase of the scale, becuase weren't people setting
> this parameter to low values in practice?
> 
> And now we make it so we have equivalent of:
> 
> 0 -> 0
> 1 -> 256
> 2 -> 384

Ah, there is the problem, that's not what I had in mind.

0 -> ~100% used (~0% none)
...
8 -> ~87,5% used (~12.5% none)
9 -> ~75% used (~25% none)
9 -> ~50% used (~50% none)
10 -> ~0% used (~100% none)

Hopefully I didn't mess it up again.

-- 
Cheers

David / dhildenb


