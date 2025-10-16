Return-Path: <linux-kernel+bounces-856052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB1BE2EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570691A642BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B501341ACE;
	Thu, 16 Oct 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuTasb8Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AD33CE9B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611624; cv=none; b=hD4p+v+BV+kJwjn45YiKLZSrKsQcXnkfVwMSdy6b29Wm261vNQXjirUVQRHHwaqRuLUZBZKjFBVy0Q/9N0Q4EL9O2ZDEP7M8tcGQ5tfUdWisLT9Fy4XxTHNhXE1nSMxtItG8k8FvJG18yR6LCpPo7n3fpKAIzv+7gKu0BU7mnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611624; c=relaxed/simple;
	bh=a5BbmQEbWc8yZ4ZNc6ZCQ4vjuI1iaJYdkMNyGW0QmU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NibUwqRmuiPRBdScddcT2IfxHRnSSLWgWNhcHwfPTnB8AhhX/6bduqX7ZoyJlyhxFPtumwPRp3NsqHmgiSE0AtgcznDxYusXwvykTTBPhLAePOrF0Gq4LT68zAmfWOT/80Koy6kZxtTy+Fx0xF6BnZwizPCcMVfR24b1a625omM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuTasb8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760611620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PWC1fBf3NN4ANTq+x7IzYDPSJqt6PESsXElpj8+2ZTI=;
	b=TuTasb8ZzDAF0hIjcvb9DNbX5DUpgnVlahqExJwqoUFui31Y3t0J2tQmewy07JOgX8DdRf
	tsQV2+K1AA3eLyfKrybAe2HYCKVKjLfkHwY7Cgbn5Y2vxWmwUBjac3X/2wMv7iYJoV+7gc
	GJv9nnIbRq6lOm9JHVjVqygVm+7lk00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-2NbW9JvmNG2Y58U1KurFng-1; Thu, 16 Oct 2025 06:46:58 -0400
X-MC-Unique: 2NbW9JvmNG2Y58U1KurFng-1
X-Mimecast-MFC-AGG-ID: 2NbW9JvmNG2Y58U1KurFng_1760611618
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso217145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611617; x=1761216417;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWC1fBf3NN4ANTq+x7IzYDPSJqt6PESsXElpj8+2ZTI=;
        b=qbvOYDxa3fwYjd4MNAB5UHIdHvGCX3EnPjCa0UrmconPUQGNEuDFVXlOkHxZ8GBeXM
         Ess/K4zwK6SwTalmikDLPBTfESAt6hWwtM/yRaRmnZyTV2WJXD1hIo7ctzWtgzEa8wBs
         IjGbMsfGfC0KJxINbnN3q6LzlqbqjzBFqx1tEAmOhiXQVXHoKqHWMx4v0Cqmz7sCiO7G
         PraiXvdnK+oJosYhgBmeUJVrOARH73wReH2FEawmg9dOtUF2+8RSM/1mGsykAfgvrljM
         Yfxqmov29asWoyyVqJdAsJs62cHs1C0WDWjnYT6vmVfModEVYKtroWp5YVXpMuUK82v9
         dIdA==
X-Forwarded-Encrypted: i=1; AJvYcCV71kF0fIshm3o7unibpD2rf0Lm23xsGUWLOdEhZK4mMIPwZiIk+kJbju9/YAQo5od44iDevsJy/EnQ6rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwmXzv1dQZxqDhfGDE5Gkv+h9F79TGY79uKS7I76yXRcAwfE/
	zXfW9jo5iCM6y4E5FJOsF4h4nwjuO2QA8OyMvrpCrrYWbwxiF3qOyoGoF2eP0oYA64FbHglQlHE
	Bi6B9S7qGt+HzgTkfiGjOKutIqgVxiHH2sZprIzr6XoXWQqmtt5c3KLcttLuvwStrZA==
X-Gm-Gg: ASbGnctXV9zspabcjdpUjyxcNrUo7P7GlDfwtIhInp1WppUnF51+4setrL91cdmB2+B
	TNDQ0OSvbi17BBchkoHCGe0UoK59HH6Wn/EfEsIPbtVlrtt7UIxtZMkKed5jdcIR4LTqhJHf1MI
	6rHLxVXVMbqyRFJi9XQo2w/vsMyATSCo+K7lV4C0+HGqQmSSaITCQ3C/pVJ8D+sX4tvjD45lmOv
	iT1pewQ3NiayVVJMZfT3j1hwaq7Htin2NwXurDOD36LhWsnEnDmg5/Za+GsYADgH6vERet5mNPt
	IjPYJsQYs/m/pQFwy+qaLSCoRkbdyyoMFytFbbvk+UtxOgSGM0QMyCQpJxLH3tOvfI7bhS3f52X
	oCqZrBM2Ty3jWyr/ovBEa7W0nF7tLVNBRZ9BsryQTwq+G3pwJJsy5JxfAIYS/Ya+sNIN2o3w9is
	6Vt/UNHVn/JaEMCYpId0dU7Od2hBI=
X-Received: by 2002:a05:600c:64ce:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-47109b2838emr22729075e9.14.1760611617504;
        Thu, 16 Oct 2025 03:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeVBgV9jTy2rMK7hSPUVLMGqdGDRZexkRhARKgF/fANx4xtmRQVfCaL0Mp8w2hsw9kLHDcCw==
X-Received: by 2002:a05:600c:64ce:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-47109b2838emr22728865e9.14.1760611617023;
        Thu, 16 Oct 2025 03:46:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm18829355e9.12.2025.10.16.03.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 03:46:56 -0700 (PDT)
Message-ID: <7e533422-1707-4fea-9350-0e832cf24a83@redhat.com>
Date: Thu, 16 Oct 2025 12:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Longlong Xia <xialonglong2025@163.com>, linmiaohe@huawei.com,
 lance.yang@linux.dev
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016101813.484565-1-xialonglong2025@163.com>
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
In-Reply-To: <20251016101813.484565-1-xialonglong2025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 12:18, Longlong Xia wrote:
> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
> be overly aggressive when KSM has multiple duplicate pages in
> a chain where other duplicates are still healthy.
> 
> This patch introduces a recovery mechanism that attempts to
> migrate mappings from the failing KSM page to a newly
> allocated KSM page or another healthy duplicate already
> present in the same chain, before falling back to the
> process-killing procedure.
> 
> The recovery process works as follows:
> 1. Identify if the failing KSM page belongs to a stable node chain.
> 2. Locate a healthy duplicate KSM page within the same chain.
> 3. For each process mapping the failing page:
>     a. Attempt to allocate a new KSM page copy from healthy duplicate
>        KSM page. If successful, migrate the mapping to this new KSM page.
>     b. If allocation fails, migrate the mapping to the existing healthy
>        duplicate KSM page.
> 4. If all migrations succeed, remove the failing KSM page from the chain.
> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>     error) does the kernel fall back to killing the affected processes.
> 
> The original idea came from Naoya Horiguchi.
> https://lore.kernel.org/all/20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp/
> 
> I test it with einj in physical machine x86_64 CPU Intel(R) Xeon(R) Gold 6430.
> 
> test shell script
> modprobe einj 2>/dev/null
> echo 0x10 > /sys/kernel/debug/apei/einj/error_type
> echo $ADDRESS > /sys/kernel/debug/apei/einj/param1
> echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
> echo 1 > /sys/kernel/debug/apei/einj/error_inject
> 
> FIRST WAY: allocate a new KSM page copy from healthy duplicate
> 1. alloc 1024 page with same content and enable KSM to merge
> after merge (same phy_addr only print once)
> virtual addr = 0x71582be00000  phy_addr =0x124802000
> virtual addr = 0x71582bf2c000  phy_addr =0x124902000
> virtual addr = 0x71582c026000  phy_addr =0x125402000
> virtual addr = 0x71582c120000  phy_addr =0x125502000
> 
> 
> 2. echo 0x124802000 > /sys/kernel/debug/apei/einj/param1
> virtual addr = 0x71582be00000  phy_addr =0x1363b1000 (new allocated)
> virtual addr = 0x71582bf2c000  phy_addr =0x124902000
> virtual addr = 0x71582c026000  phy_addr =0x125402000
> virtual addr = 0x71582c120000  phy_addr =0x125502000
> 
> 
> 3. echo 0x124902000 > /sys/kernel/debug/apei/einj/param1
> virtual addr = 0x71582be00000  phy_addr =0x1363b1000
> virtual addr = 0x71582bf2c000  phy_addr =0x13099a000 (new allocated)
> virtual addr = 0x71582c026000  phy_addr =0x125402000
> virtual addr = 0x71582c120000  phy_addr =0x125502000
> 
> kernel-log:
> mce: [Hardware Error]: Machine check events logged
> ksm: recovery successful, no need to kill processes
> Memory failure: 0x124802: recovery action for dirty LRU page: Recovered
> Memory failure: 0x124802: recovery action for already poisoned page: Failed
> ksm: recovery successful, no need to kill processes
> Memory failure: 0x124902: recovery action for dirty LRU page: Recovered
> Memory failure: 0x124902: recovery action for already poisoned page: Failed
> 
> 
> SECOND WAY: Migrate the mapping to the existing healthy duplicate KSM page
> 1. alloc 1024 page with same content and enable KSM to merge
> after merge (same phy_addr only print once)
> virtual addr = 0x79a172000000  phy_addr =0x141802000
> virtual addr = 0x79a17212c000  phy_addr =0x141902000
> virtual addr = 0x79a172226000  phy_addr =0x13cc02000
> virtual addr = 0x79a172320000  phy_addr =0x13cd02000
> 
> 2 echo 0x141802000 > /sys/kernel/debug/apei/einj/param1
> a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
> b.virtual addr = 0x79a17212c000  phy_addr =0x141902000
> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
> d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a)
> 
> 3.echo 0x141902000 > /sys/kernel/debug/apei/einj/param1
> a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
> b.virtual addr = 0x79a172032000  phy_addr =0x13cd02000 (share with a)
> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
> d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a)
> 
> 4. echo 0x13cd02000 > /sys/kernel/debug/apei/einj/param1
> a.virtual addr = 0x79a172000000  phy_addr =0x13cc02000
> b.virtual addr = 0x79a172032000  phy_addr =0x13cc02000 (share with a)
> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000 (share with a)
> d.virtual addr = 0x79a172320000  phy_addr =0x13cc02000 (share with a)
> 
> 5. echo 0x13cc02000 > /sys/kernel/debug/apei/einj/param1
> Bus error (core dumped)
> 
> kernel-log:
> mce: [Hardware Error]: Machine check events logged
> ksm: recovery successful, no need to kill processes
> Memory failure: 0x141802: recovery action for dirty LRU page: Recovered
> Memory failure: 0x141802: recovery action for already poisoned page: Failed
> ksm: recovery successful, no need to kill processes
> Memory failure: 0x141902: recovery action for dirty LRU page: Recovered
> Memory failure: 0x141902: recovery action for already poisoned page: Failed
> ksm: recovery successful, no need to kill processes
> Memory failure: 0x13cd02: recovery action for dirty LRU page: Recovered
> Memory failure: 0x13cd02: recovery action for already poisoned page: Failed
> Memory failure: 0x13cc02: recovery action for dirty LRU page: Recovered
> Memory failure: 0x13cc02: recovery action for already poisoned page: Failed
> MCE: Killing ksm_addr:5221 due to hardware memory corruption fault at 79a172000000
> 
> ZERO PAGE TEST:
> when I test in physical machine x86_64 CPU Intel(R) Xeon(R) Gold 6430
> [shell]# ./einj.sh 0x193f908000
> ./einj.sh: line 25: echo: write error: Address already in use
> 
> when I test in qemu-x86_64.
> Injecting memory failure at pfn 0x3a9d0c
> Memory failure: 0x3a9d0c: unhandlable page.
> Memory failure: 0x3a9d0c: recovery action for get hwpoison page: Ignored
> 
> It seems return early before enter this patch's functions.
> 
> Thanks for review and comments!
> 
> Changes in v2:
> 
> - Implemented a two-tier recovery strategy: preferring newly allocated
>    pages over existing duplicates to avoid concentrating mappings on a
>    single page suggested by David Hildenbrand

I also asked how relevant this is in practice [1]

"
But how realistic do we consider that in practice? We need quite a bunch
of processes to dedup the same page to end up getting duplicates in the
chain IIRC.

So isn't this rather an improvement only for less likely scenarios in
practice?
"

In particular for your test "alloc 1024 page with same content".

It certainly adds complexity, so we should clarify if this is really 
worth it.

[1] 
https://lore.kernel.org/all/8c4d8ebe-885e-40f0-a10e-7290067c7b96@redhat.com/

-- 
Cheers

David / dhildenb


