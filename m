Return-Path: <linux-kernel+bounces-803255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9034B45CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75FD04E13E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD42F7ABA;
	Fri,  5 Sep 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9kEhlQ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF190CA5E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086571; cv=none; b=az1XEFPo6E4nvgSKaYA1RQSV6YTfFpUYeeNwRf/melpyviTY7UrlLvrVgqA2zQt+4HNieaIy2wPO4eOWXwERpLWzRTOeNcdA+XL2PsJbdcOLSihZXHezRdpKGIYOmK5puCJafPxLluw6VroJZDVSDWR4kGSVxzCW0qbSwn3qe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086571; c=relaxed/simple;
	bh=+HDacU3EEaVdzBWAK9nyoiF1fUnST5mquHRlsvVcQl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmTILzlf3Nu1Ty6pFlg9WvY1fkmFE23Q1E1QerX5fx+HxfRrAf/o5Le3ISxfW29P29tdy9t0iFliX7mDLH7gzGSWa5Z8+FmHQm7YgYygJ0rHU8hwlTvG6HAxmM5Xr2YOmLfzalA0yRZG5F/hquFSD0HkrDfVhnSCCJkbBrpFz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9kEhlQ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757086568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t+1Bqq+FnslisdW0YRe0dxNCffyMt+IzohJvV6m4RhE=;
	b=i9kEhlQ5DHrvted0g1iiAsRE8FRaFVhu7yvIi6OivByRulHAjPM983FjhuosYrUq19RDKd
	ypx9b085jvqgUdHCgGGWMzM9Yk0flur5svVRDtodnyLypyT9990B62vRBUwOyqyx1RVkhk
	4MpbdHcsI3+MTBxP5pu9ACnyvzctN7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-hIGyN0XJPk6ymmmE2k80gQ-1; Fri, 05 Sep 2025 11:36:05 -0400
X-MC-Unique: hIGyN0XJPk6ymmmE2k80gQ-1
X-Mimecast-MFC-AGG-ID: hIGyN0XJPk6ymmmE2k80gQ_1757086564
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so12978345e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086564; x=1757691364;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+1Bqq+FnslisdW0YRe0dxNCffyMt+IzohJvV6m4RhE=;
        b=VuYEhUNPi3/cRb8y0sjelwu9Q4n1gv0UHMzNvKkFsCjliXA1yE36gExaWDYZvGba/t
         7btpwKTX/FjDlhvborHktCj5qQbpi29bLjWfi3fCOufngXXBhypmh4kd2cLKpBv553DQ
         dm1KDXPvOufK3hgBgLEOHpfXUc4vh8DPJ/EvQrZcGBC9AZTNxgXE7EcENJnGdm7t+4+7
         h9gVpVlebnX3hgKY4Bod/CgfXm5iVxkO7i3M6L3qs2yM2L1doHnTyDroF7WIofNA9qy+
         XX2JaOOhAqvo2OBoTvU+RZKiIwZ0ZLg7jsNG4m2q8K+9CLlj1qzc88Okiz72OR+OQ2G8
         EPoA==
X-Gm-Message-State: AOJu0Yw+pJMknwwYappC4smfpMC6lGGgRiTCzn8l3Oq0QY0NFO2Rqh8I
	HKXoFdRFW5mFOjLBLsZyXq23Bi6YMfDzSYGHJSHL7O8YqEaL0icK/3UvKuwXdrsf3E7tnnuM4rg
	DXrHQpJA+ECnVXxtyAZlMl+u29OFvQzMcOTYKV+2KAgYk8EAPxpfWkfrLfQzvKjPBzw==
X-Gm-Gg: ASbGncsFoBv3MwNO0WDvp5b+KIJEz9f+NfbLd1Phr1O3pGQl46uK7SiYYnvF1R6Gz0J
	cVO5/exW5VoUzR+lGIE0MZuECXg9Rv1KCt8od9VJp9FpXxvccRxTP+I/K8jmq9Y9qXgDDFyWMt9
	Bj/CMg60077Eesd+9iTYxmlVNoe63J7CmESHnr0NDG9qu10fFJujJ+wcDS7bPHuTZf5rDYRTeDy
	c0dKBO2YVDBOb8+q5avLk3pHjcrS9bM9cF01EnUjOWomcMVfJHi5KlbUBMYbZfSIvVsJ1zyzTcE
	0QIX9UBBOb6WTagadCFdH9/16sul3lXxHk2zvdA4DRPcXrh7tqnd51fCXeL3FYXRZSVNGHLnpz+
	TbU1Hl5FEMG/jqiTFlxQoIXF6lKNfSNOVf5V1r5+uBNo2d6tInoIU0sTt
X-Received: by 2002:a05:6000:2dca:b0:3e1:6a9f:38c with SMTP id ffacd0b85a97d-3e16a9f0881mr4572183f8f.49.1757086563872;
        Fri, 05 Sep 2025 08:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPlMc8QhnvcGKMFuw3VSmRdAqDXHHYXYoy8CclQh9OSK0B+Zxf4DNSi509b0SGeITY1Jg8gw==
X-Received: by 2002:a05:6000:2dca:b0:3e1:6a9f:38c with SMTP id ffacd0b85a97d-3e16a9f0881mr4572156f8f.49.1757086563428;
        Fri, 05 Sep 2025 08:36:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcb1497sm43961335e9.1.2025.09.05.08.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:36:02 -0700 (PDT)
Message-ID: <ebb2a888-a111-4c27-925e-58bfa8e07852@redhat.com>
Date: Fri, 5 Sep 2025 17:36:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>
References: <20250905141137.3529867-1-david@redhat.com>
 <0cd87ad4-206c-4367-b7e8-9c1ccddc15c7@lucifer.local>
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
In-Reply-To: <0cd87ad4-206c-4367-b7e8-9c1ccddc15c7@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 17:30, Lorenzo Stoakes wrote:
> On Fri, Sep 05, 2025 at 04:11:37PM +0200, David Hildenbrand wrote:
>> We added an early exit in thp_underused(), probably to avoid scanning
>> pages when there is no chance for success.
>>
>> However, assume we have max_ptes_none = 511 (default).
>>
>> Nothing should stop us from freeing all pages part of a THP that
> 
> Freeing 'all pages which are part of a THP' rather?

I'm German, I don't know what I'm doing. :D

> 
>> is completely zero (512) and khugepaged will for sure not try to
> 
> that is -> that are?

the THP is zero?

> 
>> instantiate a THP in that case (512 shared zeropages).
> 
> But if you write faulted they're not the zero page? And how are they shared? I
> mean be being dumb here.

The shrinker will replace zeroed pages by the shared zeropages.

> 
>>
>> This can just trivially happen if someone writes a single 0 byte into a
>> PMD area, or of course, when data ends up being zero later.
>>
>> So let's remove that early exit.
>>
>> Do we want to CC stable? Hm, not sure. Probably not urgent.
> 
> Surely this is worth having?

Alrighty, let me cc stable.

> 
>>
>> Note that, as default, the THP shrinker is active
>> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
>> THPs are added to the deferred split lists. However, with the
>> max_ptes_none default we would never scan them. We would not do that. If
> 
> Nit but 'we would not do that' is kinda duplicative here :)

Yeah, fixed it already while rewriting: this was meant to be "would now".


Thanks!


-- 
Cheers

David / dhildenb


