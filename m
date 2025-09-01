Return-Path: <linux-kernel+bounces-794242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C68B3DEDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263E57AB228
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307F30BF63;
	Mon,  1 Sep 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCDc+u3p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EA2E11D2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719717; cv=none; b=UwaxZZiMXquPT0RnyTgQbDuO3+qtVLbw3Jb+kZM7KV5qI2wWZp4OD6BTj2hXmLIT9CH3A9MUpFt1BjeIeuRbdNq+4EVv1IguM2Yr+hrkywdjs/LFj9TnU5kBxJFF6Uu/pfOit5iktRuqs0Oo9gg75+CG1RpbOixrIim2mUdtwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719717; c=relaxed/simple;
	bh=e+qK9+a7xZyQuVUlCWxjHP1cUtCkJzj9fTXTAcEmorw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDGjDGZG+abOWqj/liR2Om1zxMfSsLbjbQcZlheYn8+QQYxpr4Dkv/DYl44JQarbhqWY/Hv9qn2Le6xpbNQZCXVWFLbRRtYqEAda+vxSMwfZd73iUedjZNCpwtJoVIHf6xaDPuzBANdsjdCtzdgajdHOh9PfvQqDgqiyJ3zWA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCDc+u3p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756719714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KOhC6M2vlCj5G3ZVZXROi8iNp3B5G7J3157fBvcjijs=;
	b=cCDc+u3pKzhqCTZJkaE1yy7D7mA9t4oGyIFCyZLzjC0zaG+/XowqcmfhhgcuYPrvmgAPJ+
	00iU5ZrzvbOrW0wXs4sZ7O9hyF3p8rQ1jTkxdwtLFnqPCuudjtbvptOC32TObo9PfsNk4l
	IG4OhbIrB/o2LLSETto1lrryOuQwHDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-2q-GzRmfPOalhMPB9fdC5g-1; Mon, 01 Sep 2025 05:41:53 -0400
X-MC-Unique: 2q-GzRmfPOalhMPB9fdC5g-1
X-Mimecast-MFC-AGG-ID: 2q-GzRmfPOalhMPB9fdC5g_1756719712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b467f5173so40468545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719712; x=1757324512;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOhC6M2vlCj5G3ZVZXROi8iNp3B5G7J3157fBvcjijs=;
        b=UdvR3zbvIvCxiu8DDUuKMdhMipM5M88h1CM6MdO/SZGlERX27m2DdAv+l5kXVA2tQt
         h1u/r/Vc1YUKh91NZQsIWGvBobrBf6WSAhMEwjc7RSe0yULLzFB3hwqp9fDPvbK5s3kM
         dc0fakcZsVunBQdyqpIHLRxmTzX7fI4k5vtWwjmQDpuNFOW98J79IQMM2lpUj9DuSBq2
         ZWur2hCKkvw6w6RWxwJntVt4qc3gKv/zSsXAisWX38Ldz9pehYyil2bUajEC1/0WhJL3
         Iv8Gaz6RemED6VuNvrXOCkgjK7JSkq5vANEgME2/3UchZjRoXGZmOkTEAL0DT9aX/rmp
         3htQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJB4eGYDhEVFiA9yzC9TMz5tQyfSRkb+wbtOr277q44Lsx9cgFmcj55zcoAO7EOdBbOjUwhb/1DGFm++U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnY+3m+GpvphgTsX+Z38TVfpo+KsU5lcePos/JPsygBk4GywZz
	m6vGWMYWg7oRus5p2AWGR+LrFCp/bASnnLZ8ewzvL4SnF/c/yyxx1zNpqJoZrVvp9QwXmMXkmHY
	ztYSFRJv2SRAlpR4qZQVmcZgwjeEtjgJpIuXGAkeUVP9iz9bTSy3VFl/YeEQLXRhFTuNeZX/h6g
	==
X-Gm-Gg: ASbGncuza4iR1OAwWevg+KiUQSgFXpiUU+6i6WZ+tzE6RQLmhH22z0P1qfknDrm7aSt
	+IPY1/8J1WWhEzCC/3JrwtYmXNSny8hAZvMWzKOm32NGxtbvkAGV0SfrosN+yX1oaKLBCUMk+7J
	kVTPk/JbnYK5Fo64zWLD1Dj8iUE2enyaPNBCdi4E2lJ8awjHZwsmhWiaOZFHSpR+k3Dp5FRQyVC
	D1oOneVXXzfeKCWDfVqwiHH9W/wvhdR4dJAlBEGpR3WWZGv3MEVyziSNdHHSizvrGPS7n9Y21FP
	aWFWHvlXitrYGVk0xLcyMDPFRrAsYTr4oZviC5J7OpPqRfEj+LonaDOX9U4fmbP+LklFJJq7ngD
	33mBb3f2rDeBvBUM4b6qq5or5ez4vwFT44ruC7evLK46FvRrVU7q9ExuspAfZUWyhlIo=
X-Received: by 2002:a05:600c:1c9e:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b8f5e554emr9278195e9.14.1756719712307;
        Mon, 01 Sep 2025 02:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH21mM9qsZdllKa5sainOeX2I0Ok+9eY89z/vExhO2b6YLIH4K4CgEd3n946nyWOQulz6xJKw==
X-Received: by 2002:a05:600c:1c9e:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b8f5e554emr9277855e9.14.1756719711889;
        Mon, 01 Sep 2025 02:41:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b838ddbe5sm123272345e9.16.2025.09.01.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:41:51 -0700 (PDT)
Message-ID: <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
Date: Mon, 1 Sep 2025 11:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
 <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
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
In-Reply-To: <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 11:26, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 10:35 AM David Hildenbrand <david@redhat.com> wrote:
>> We usually write complete sentences, and there is nothing wrong with
>> repeating what the subject says.
>>
>> All the time it takes you to argue here would be better used improving
>> your patch descriptions.
> 
> Sure, but first I need to know what is really needed. Reviews on LKML
> are often contradictory, and it's easy to get pushed around from one
> corner to the next.

Yeah, and that sucks and I'm sorry if that happened to you in the past.

If you ever get pushback on (a) splitting patches into reasonable 
logical chunks or (b) writing a short yet concise patch description that 
explains what the patch does and why, feel free to CC me.

> 
> I just posted v4 with longer commit messages. I think that's a lot of
> unnecessary noise that takes a lot of time to read, but oh well, if
> that's what you guys really want...
> 
> (In the days of LLMs, writing is almost free, but reading all that
> redundant or generated garbage text becomes impossible. I think it is
> harmful to have so much redundant text because time spent reading it
> is time wasted. But that's just my opinion.)

There is an important distinction between garbage and a reasonable patch 
description.

-- 
Cheers

David / dhildenb


