Return-Path: <linux-kernel+bounces-788310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDDB382B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7B37B7BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71931E112;
	Wed, 27 Aug 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIOcLw7s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA520F079
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298536; cv=none; b=hQBPNPmixSBdU2aZ6LmkuIE3Ky26DnshJ0j5qxGjYeclWG3R5khBSf73mEdsaR/8DcOYLzXM6q5CvLe94M0SdJQCX4g5c4chbbjfdxMqzsd+aG/XvZvRlOFqfsK1dshdBnapWexBrJJn1M7v1Ba/729AXn+iUnLjVy75Eu19hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298536; c=relaxed/simple;
	bh=lvU0mLs0rVcuWK9+OR9wl+QAJGf+UHnaBrrJlh3mwtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apiGQIS9KS3tEQqjIOv8E0Q1AXTGr2hEQlfSh65OUft8oRjm58tOPquAueAPhazO6a7r8Hwcc/gCVO96BK9yydO5JH52a4f2qC4m/jgQ2doDGNKtRt7lTyh0HPPs6Z+LvmMOfockArf+2pbywAY1F2lN95P/gCSdfUV8fNkIZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIOcLw7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756298532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BekZV8acLe6XPanRTSGME8kaWo7JU8sPojrFX72nbps=;
	b=GIOcLw7sNgMhfm2qbmG9Yap34Y979LL3oJC90WwxNZK57eQJ5MbjsLNOJaFLo9JiyYwPef
	mxeRzohfcsXUqZAreN4VBtz2iZtI+l/q0PzQ5LW5nHXRhdikm40j7TntzSAMhJmiUzjcT/
	1BvP2/L32Svd5ONhSVbv1PkPCoEoNlg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-EzQBZYIMNSSvWnjnNRc_tg-1; Wed, 27 Aug 2025 08:37:37 -0400
X-MC-Unique: EzQBZYIMNSSvWnjnNRc_tg-1
X-Mimecast-MFC-AGG-ID: EzQBZYIMNSSvWnjnNRc_tg_1756298257
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bccebaso184771711cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298257; x=1756903057;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BekZV8acLe6XPanRTSGME8kaWo7JU8sPojrFX72nbps=;
        b=Vygzn9Pt68JcVNjCAvzvZFjTmUvis4YBX1rD8cF+GLZ2vdsa6fbmahrwpn7lWXIjWu
         Dxow6Kx+qlKYqOy3GJoOR2rXwzKWgB9zYUY02g6Xho9WZrpC/fs6eaV5/z/zUGaMkH/d
         a5Exod2Joj9oK0j8F3CfdlxlyqsW/dhULlfenI19vUA9bOSJEiamP1pjV3jDckXXh4Ky
         XLTKY5EVgVu7xdUwFp6huyFEZUdvQ4h9ur/JwGcJR9e6OyHo06L/LgzyTMvQrG0UgW/Z
         ODnM3H73Qwiz2gapkhk6sPlBypICKg+K/brYVYHWnPDfg2+wvBaCMdAto3QndWj2Uvpj
         wtYg==
X-Forwarded-Encrypted: i=1; AJvYcCWF4Cb3OIPTHoHUn1umxKvNCxY6aHtoxA4F2Ps4wP+/J86cKEDZjr6zX+fuMf6ZQR6bXDTW0+AlhJ+Aa6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAEO9GpP0AKQjk8ATos/M83/AbQME38EB0GLJkC8JCa10Yt2Y
	1tf9DaJmaDsAsEyym7Ar9C5WbWQk08OdMqCLzaxL5xs+bvDXKhknxrauwi3oOEW3Ucdb7SwuJwf
	83eHKxxrcXUY/wDcjpmS5mGwfQmdRXBtOjm8sK1zjNUzD9nb8k4YKBpdXXgSfpLPhRk8kDtj2pp
	utyco=
X-Gm-Gg: ASbGnctqiWXyLLVta/YFCjv+FrGlhYTV/t+IOoBRih+a0qQ/J8VNHponYKcm9WmwiF/
	HNU3oYzqwCTX9C1AOhB9T4fVfCyWFzaybb5vQUtTVN6eUVAX5l+TkrihW9P9wAVodXkJ58hs639
	eq0KvVerjFOEh3yFPrL2p1qeGiAPjaIi1U1IkKaaYeHTWs9c/lN12XYVfO/e2x0UuTniM6hgJpM
	LlIojf+x+slkI5UeSIUm2i2k4sWlDwiLMu87Zd4nyj075KM3Y2687T6pUyPlGqcSppUb+Ghwj1K
	lH0oyLNRtLBmTjJUym+JAy1nWFMCLicmr8JrXYFM9jaALt8YH4+EXg1MdoBgUQ==
X-Received: by 2002:a05:622a:4d4b:b0:4b2:8ac4:ef5c with SMTP id d75a77b69052e-4b2aab54f8dmr255688441cf.83.1756298256720;
        Wed, 27 Aug 2025 05:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGCaRz0DFPdm+ggNf6XYwNumadLV8B3S6sxDmsY6ms9bErbv7MeZlbQ0d8SlCK29jOlIm7Qw==
X-Received: by 2002:a05:622a:4d4b:b0:4b2:8ac4:ef5c with SMTP id d75a77b69052e-4b2aab54f8dmr255688031cf.83.1756298256148;
        Wed, 27 Aug 2025 05:37:36 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8de8061sm91568041cf.32.2025.08.27.05.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 05:37:35 -0700 (PDT)
Message-ID: <b276a150-92f3-408c-b146-7408b68ec778@redhat.com>
Date: Wed, 27 Aug 2025 14:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
To: "Li,Rongqing" <lirongqing@baidu.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "osalvador@suse.de" <osalvador@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "giorgitchankvetadze1997@gmail.com" <giorgitchankvetadze1997@gmail.com>
Cc: "Xu,Wenjie(ACG CCN)" <xuwenjie04@baidu.com>
References: <73da268715754133b787f22e016a903c@baidu.com>
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
In-Reply-To: <73da268715754133b787f22e016a903c@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 14:33, Li,Rongqing wrote:
>> Not sure if something like the following could fly:
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c index
>> 1f42186a85ea4..dfb4d717b8a02 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3595,8 +3595,6 @@ static unsigned long __init
>> hugetlb_pages_alloc_boot(struct hstate *h)
>>           unsigned long jiffies_end;
>>
>>           job.thread_fn   = hugetlb_pages_alloc_boot_node;
>> -       job.start       = 0;
>> -       job.size        = h->max_huge_pages;
>>
>>           /*
>>            * job.max_threads is 25% of the available cpu threads by default.
>> @@ -3620,10 +3618,24 @@ static unsigned long __init
>> hugetlb_pages_alloc_boot(struct hstate *h)
>>           }
>>
>>           job.max_threads = hugepage_allocation_threads;
>> -       job.min_chunk   = h->max_huge_pages /
>> hugepage_allocation_threads;
>>
>>           jiffies_start = jiffies;
>> -       padata_do_multithreaded(&job);
>> +       /* TODO: comment why we retry and how it interacts with
>> vmemmap op. */
>> +       while (h->nr_huge_pages != h->max_huge_pages) {
>> +               unsigned long remaining = h->max_huge_pages -
>> + h->nr_huge_pages;
>> +
>> +               job.start       = h->nr_huge_pages;
>> +               job.size        = remaining;
>> +               job.min_chunk   = remaining /
>> hugepage_allocation_threads;
>> +               padata_do_multithreaded(&job);
>> +
>> +               if (hugetlb_vmemmap_optimizable(h))
>> +                       break;
> 
> It should be:
>             if (!hugetlb_vmemmap_optimizable(h))
>                       break;

Very right.

-- 
Cheers

David / dhildenb


