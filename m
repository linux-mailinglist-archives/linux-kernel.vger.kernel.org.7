Return-Path: <linux-kernel+bounces-801400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F2B4449A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37BDC4E5F20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997AB308F07;
	Thu,  4 Sep 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptx0ldxM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E82135D7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007733; cv=none; b=ofuDQKg6nhbxDXLkolfq0cz1FQ0OKLo+xsHK05rtq7tj1iIsQHeGgxHP9HyFwI30cgpXDDc98raCzyD/Np6V21VMhZrkVtNZAET8drsH3Yn2D7bZ7jDZvB/tNkE26m1V53ND4BTOfNl0v6M/2yB+xLp31YCG0ShoRC5njwd92zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007733; c=relaxed/simple;
	bh=YBLqifw/BVRoi3wbhVwBK9rjcZq2l4LNyNSyEQBYhKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R9OBmj0slACBVisSmhFBPgFvQTIeeLaet0grNyqn6bELpaN/HYnbn/lC211TQg4169vN2UFgCLbB132ESzmEek4OC3jIgYdA1BOJGUYuhpcCUpQ25l+L78u4OT8Fzzhj9/GL4rqa+QgHAhDcj691k4Ne4+eFgSAwZT31C2gyqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ptx0ldxM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757007725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f3N6crPoAdBKvfRXAZf0tsFM2t5csRFa36K9pgtReHE=;
	b=Ptx0ldxMX57qxRCcl8bgkyYuR0+eMrgwUrqqq7OcR1IfjebK9UClEQZujvnWq/WvRJrytQ
	S+dXfc7cCxhNK/60Xeqqf6ZbHQfoapXKt25KUlTbMiieSkgS1vsG2T/ehjLM+h2DTYu3FT
	Ua9DQ3TEozF7Yos0EbKtnNWmFpUyT8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-sDHyH6o6O_yOPUxyyopsqA-1; Thu, 04 Sep 2025 13:42:05 -0400
X-MC-Unique: sDHyH6o6O_yOPUxyyopsqA-1
X-Mimecast-MFC-AGG-ID: sDHyH6o6O_yOPUxyyopsqA_1757007718
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so15705225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007718; x=1757612518;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3N6crPoAdBKvfRXAZf0tsFM2t5csRFa36K9pgtReHE=;
        b=bXdMV9Y8ueKhtUFgnoFWH4hAZXwFvp02lHzOPdH8R3pVpZo5Cv+EtCHYL0LoaD3C2Q
         XAu0GPhRlTsfKKB8R8FgExEclKNbDYWbZRh2SBc0SVFT30SrzTcoucbZqvqC4vS+6RuT
         tzWJ19ahfHI2bwVO1rimDdAE6+QY3V8NUp/M3/OcCpH26dMfjMtaK62+g1neS/6d/kWB
         Vr9MwUzTD2hlZhEUqXbJze9O73B96DYuBtqb2F31tSjheiF/INmdmBn3sOSYdOIbgPp1
         leIedjluIvMdfQZ25+X9QMiZl+wG/dloHygEr+Vwf8rfdunaF9zRdnuI7iugL2Yxe6Bm
         D9qg==
X-Forwarded-Encrypted: i=1; AJvYcCUCKu8jX7Jp17uL8F5KjK7DQPw8MdYb8G0NrU/jiVYicwWfpWc8konG4gTipGKb3C9dX0b2cNGRVvxYSD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cfFu661SWMDBt9AC2cCnRUt0hdMmvm08ez7avto66mhj6HM7
	zyY2/G6y2TYIxpHYt1MN1/YYo5PYQ2oMPgBv1pAShhm9ZeoSqu/QYU7hZb9mBuIPjEwBwIweO1O
	ab1J0uI4NKzkOTjmzIQluGX5XUALDgYJ019RHWGuCNIxx2hQNiSRBVBI1Badldy3gxA==
X-Gm-Gg: ASbGncvFGmVcERvcAnJbAEzqBCAwbfnTmk3qP9WYcLZLwynRyAnJqlXDmkWfyKQimA8
	XtqKKQg2jn7k6oIouCYcfq6rFZQaD9pn8V31H5hAjcZA1/f/qMW1/o3yv/8ttcQQ37njbmPH5jP
	pbcM63jw5VuI4vPnoPAQYrT218aFvahIy6BDSlO1H/wYy4/sa7/MTh3TCsZMxHSAGhgUx0/vA7g
	sE0RjsM38hDavApaGm7xGGMEILHbBJfT+LMVb8pvQrPXCMUuwGmZh1aTrznb0QBb3VR7engrVz/
	0bWUEKrxJ2A6g/0o+2ZM8r02jtwultZZwb8R5S1Tl6MfCpleBXyhg9W4jKr9iS2YBClbwnTLN83
	v6NqqFGRPAZB5dVTzbNzlo3/RHx93aQCJpOER9s4mOK4Vx1qGFiQdwPBVsIT3X43G
X-Received: by 2002:a05:6000:40da:b0:3d1:8458:cfcc with SMTP id ffacd0b85a97d-3e303ac3113mr462786f8f.25.1757007718530;
        Thu, 04 Sep 2025 10:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhWxQ1e1FnlVyPFce58Z4egeuSg2pUvGK0fSYueuygdNQHvj/viR3FYzF08UC1nbW9K9KX5w==
X-Received: by 2002:a05:6000:40da:b0:3d1:8458:cfcc with SMTP id ffacd0b85a97d-3e303ac3113mr462756f8f.25.1757007718024;
        Thu, 04 Sep 2025 10:41:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm27988583f8f.5.2025.09.04.10.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:41:57 -0700 (PDT)
Message-ID: <84aad392-3bff-4f98-b612-5e9a046edb36@redhat.com>
Date: Thu, 4 Sep 2025 19:41:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, kernel-team@android.com, android-mm@google.com,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local>
 <43ryds7hzhs5bpaxznco7fppmakdb4f46agwtsc5erudqfoz2x@7y4jgbtft7jj>
 <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
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
In-Reply-To: <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 19:33, Lorenzo Stoakes wrote:
> On Thu, Sep 04, 2025 at 01:22:51PM -0400, Liam R. Howlett wrote:
>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>> index e618a706aff5..793fad58302c 100644
>>>> --- a/mm/mremap.c
>>>> +++ b/mm/mremap.c
>>>> @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>>>>   	 * We'd prefer to avoid failure later on in do_munmap:
>>>>   	 * which may split one vma into three before unmapping.
>>>>   	 */
>>>> -	if (current->mm->map_count >= sysctl_max_map_count - 3)
>>>> +	if (exceeds_max_map_count(current->mm, 4))
>>>>   		return -ENOMEM;
>>>
>>> In my version this would be:
>>>
>>> 	if (map_count_capacity(current->mm) < 4)
>>> 		return -ENOMEM;
>>>
>>
>> Someone could write map_count_capacity(current->mm) <= 4 and reintroduce
>> what this is trying to solve.  And with the way it is written in this
>> patch, someone could pass in the wrong number.
> 
> Right, but I think 'capacity' is pretty clear here, if the caller does something
> silly then that's on them...
> 
>>
>> I'm not sure this is worth doing.  There are places we allow the count
>> to go higher.
> 
> ...But yeah, it's kinda borderline as to how useful this is.
> 
> I _do_ however like the 'put map count in one place statically' rather than
> having a global, so a minimal version of this could be to just have a helper
> function that gets the sysctl_max_map_count, e.g.:
> 
> if (current->mm->mmap_count >= max_map_count() - 3)

I enjoy seeing sysctl_max_map_count hidden. But map_count_capacity() is 
even more readable, so I like it.

I don't complete like the "capacity" term, but I cannot think of 
something better right now. Maybe something around "free" or 
"remaining", not sure.

I also don't completely like "map_count" (I know, I know, we call it 
like that in structures), because it reminds me of the mapcount ... 
talking somehow about "vmas" would be quite clear.

Anyhow, just as an inspiration my 2 cents ...

-- 
Cheers

David / dhildenb


