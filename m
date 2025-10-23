Return-Path: <linux-kernel+bounces-867360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C81C02650
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05ADD4F7254
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F8259CB9;
	Thu, 23 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW9p5SZ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3D20C023
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236169; cv=none; b=rp3j05OUWnssyQYDnx9rhddTP6FP5p6bTxOntNKaOzplopvmRk26I5mQ15PA8oUnl94tumpjzD3SzAfGG8i1nUcva2ILLThcl1ru50aPHWCTj3Dbjguntfdu92bqstxytm/mEEBlw9a+Ka/goRAqDqsXe/bw98rZbAXZgPMQXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236169; c=relaxed/simple;
	bh=4HHE1j1g63Gm8p3KR4LspqWQ1i6IE8nwZ6aSeWWsy9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKYiYvXmb4Gh5LkywChSNFT+LQoiiKfMXnsJZvveloJc9w43/hem/hgNKNbiEXrsQYAjth1xg3YFz+s1ut8LLuHLn125cfevjgg67jV0i9s0vOJTTF5Kj0Lsl/XXqW/Ihv+C50Qa5/bM+odkQrB2IhwvCFDRTnue1s8I7EATyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW9p5SZ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761236165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JF8+qm2b7jZrTE48PPY/DK3wP+sibwHsCL/pU7PiDjM=;
	b=SW9p5SZ1DkunhlaLOVnaq8z/wpuB5pQz9/SemQ8OR4HzRXK1Rldbr74Nm4ArQ8S6nFx1tw
	e2nvI4OlgPVd5KSi+bsGtTnZ8yrzumGR27oSqsEisw5LOB4sEdKwPfrt9xwOllWu8fbiZS
	KKl59iqAYN1Y6q5B6SJmfcZPtgVzcOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-ah84QavwNmmaUfZf0rmXJg-1; Thu, 23 Oct 2025 12:16:03 -0400
X-MC-Unique: ah84QavwNmmaUfZf0rmXJg-1
X-Mimecast-MFC-AGG-ID: ah84QavwNmmaUfZf0rmXJg_1761236163
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so14476915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236163; x=1761840963;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JF8+qm2b7jZrTE48PPY/DK3wP+sibwHsCL/pU7PiDjM=;
        b=LdY+tIzau4wrMrD9h5qtGhTn7viDgF4A+yZjvMq4ZHT8e91RqTAuQov9ZUuv+HERA2
         eU5XKvB8DbFyJW4rZ3v61iQ18TIk4gUg+NV8GFOiY0bFVd9gN5wN2YITBmaLwhVLg1HM
         5pwp1hu9nf5xBkOHIBP+ikEdv5NbQ1r4M7GBIlbXY3fFdC2N78OHln/793t02H33H/tb
         ywhVICfmluePammI451xe29smenp4E+MuplReZaB2UJaUVmRxWqoYBimXe2YGl1zfIoD
         RUaLU0sseisz/DI9VXRqJEwawzYKPZcoWYpCJyKoU1T6/tdsNTjDOwf5vtzRuyrwEsPI
         Mdsg==
X-Forwarded-Encrypted: i=1; AJvYcCW794aNn70u4SVvfmvrmKxVDUCmUUS/WkKAupwe/eWQwYckX79o3aGlrsHP/mb+PvgUV6ZGOk+OafA57Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLpJrqMDwFgaSpW+EsVK1wNa4wOdFCPlj/BW9eV+rQeuGWcCd
	ixEzXSQhkFa/CKW9NDCOqr6VsDpCAp8uru3sLdyDUie0bMXE+dEzpqljmqmMRwP/5Y3ESiEw3od
	JFO9NTijmMLBPVMapHG/vMOTchRQ9Yqmz3Z94+bK7HrQOCwFvGKiSNIFDACTEUR49Fg==
X-Gm-Gg: ASbGncv6ejTeVDKzIRcTGwDZF52CVqXfsWmnfDpPWF+RYnkc5XrhgSkgTdnEnV10k1T
	XFqv5VYgtA+IxmAi29dQYWmpWQGJWDq6TnOsUX2le3elKTR8HzKfPcF7nUNOarl0RBPFWf4D/vp
	r+ty98RGu1BwhDhC7+v1oX6uLt1nm4oMf0HSvwxaJPRPqYwuGHPgyY6Tgouw4C21/ktJCaAzG6Q
	7ylyjxrPI2mKcE2JRLsSQWJgpPYNKfq/YnuZ9ItHssRA6ytYZKH37Zs0WqDXPrqimyHYiqjwo6Q
	XwMCW0faWk5k86tIX3m6WStWuGLIkkicPlnrkBYCl8xZPqc5i+RFTPKj6BUgw12X5KVFQRng7/+
	p1qemjjnwhYevZDejl9ueg0FFBlkjvwVkaTAOYwMKnJDfEU0+vxo03CvPqTCEsKdq5Ohq6mkY9f
	sAAF8j5mlfuaCdLxVwlMxusCWjnq8=
X-Received: by 2002:a05:600c:190f:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-471178705b0mr189600935e9.6.1761236162671;
        Thu, 23 Oct 2025 09:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxwA3SATV0YOnZsaSJoH7DQG6AfDDy7Cc5CBBqZ0685TqgbVdTbAExPm3EWf90r/qAD3W5w==
X-Received: by 2002:a05:600c:190f:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-471178705b0mr189600715e9.6.1761236162256;
        Thu, 23 Oct 2025 09:16:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm107646305e9.3.2025.10.23.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:16:01 -0700 (PDT)
Message-ID: <c6b60121-61ed-493b-baa5-3d55db68435a@redhat.com>
Date: Thu, 23 Oct 2025 18:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Long long Xia <xialonglong2025@163.com>, linmiaohe@huawei.com,
 lance.yang@linux.dev
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <7e533422-1707-4fea-9350-0e832cf24a83@redhat.com>
 <122ef241-787d-4e8c-82cf-01ff318293a6@163.com>
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
In-Reply-To: <122ef241-787d-4e8c-82cf-01ff318293a6@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.10.25 16:00, Long long Xia wrote:
> Thanks for the reply.
> 
> I do some simple tests.
> I hope these findings are helpful for the community's review.
> 
> 1.Test VM
> Configuration
> Hardware: x86_64 QEMU VM, 1 vCPU, 256MB RAM per guest
> Kernel: 6.6.89
> 
> Testcase1: Single VM and enable KSM
> 
> - VM Memory Usage:
>     * RSS Total  = 275028 KB (268 MB)
>     * RSS Anon   = 253656 KB (247 MB)
>     * RSS File   = 21372 KB (20 MB)
>     * RSS Shmem  = 0 KB (0 MB)
> 
> a.Traverse the stable tree
> b. pages on the chain
> 2 chains detected
> Chain #1: 51 duplicates, 12,956 pages (~51 MB)
> Chain #2: 15 duplicates, 3,822 pages (~15 MB)
> Average: 8,389 pages per chain
> Sum: 16778 pages (64.6% of ksm_pages_sharing + ksm_pages_shared)
> c. pages on the chain
> Non-chain pages: 9,209 pages
> d.chain_count = 2, not_chain_count = 4200
> e.
> /sys/kernel/mm/ksm/ksm_pages_sharing = 21721
> /sys/kernel/mm/ksm/ksm_pages_shared = 4266
> /sys/kernel/mm/ksm/ksm_pages_unshared = 38098
> 
> 
> Testcase2: 10 VMs and enable KSM
> a.Traverse the stable tree
> b.Pages on the chain
> 8 chains detected
> Chain #1: 458 duplicates, 117,012 pages (~457 MB)
> Chain #2: 150 duplicates, 38,231 pages (~149 MB)
> Chain #3: 10 duplicates, 2,320 pages (~9 MB)
> Chain #4: 8 duplicates, 1,814 pages (~7 MB)
> Chain #5-8: 4, 3, 3, 2 duplicates (920, 720, 600, 260 pages)

Thanks, so I assume the top candidates is mostly zeropages and stuff 
like that.

Makes sense to me then, it would be great to add that as motivation to 
the cover letter!

-- 
Cheers

David / dhildenb


