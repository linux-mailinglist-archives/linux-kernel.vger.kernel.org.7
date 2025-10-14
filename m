Return-Path: <linux-kernel+bounces-852827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026EBDA042
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6850126E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8D2DFA24;
	Tue, 14 Oct 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Raq/QHBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623E1C84AB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452334; cv=none; b=ErjtMggbFfmfnGch6jb3fqdbtGu8H6w6yTy+cbky3Q55fTRo96Jq4vw+TToFZclTb+LzQdjyZFDziWasEONSUp/0Qu46bQrBL7Ny1A5GEA3QkiG5p39URPYg57Fo/o6K0yfan2TJoXly2XFgXP7HHyyE+Y+3851ftl9oM4RWOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452334; c=relaxed/simple;
	bh=UHj4BYjmwgl1TfUfEvvdjaYehEQ1qd053rV/AxAaxew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRxk+I1ety2hY2Ez+fvTwS5d+7p9tXg31/05jsPi/XJBtkMTlvRtSf+nff/J/BM9eVsL9hzcVELW7YjNhyNY9WTPcVCmzYzQTMVI++42hA8lnSIMoPQ0Tn6qX3zmkqC2wHRhM6Jo8oG0mB15E93lmMqvdSoKm1cPAJhc+QeVIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Raq/QHBu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760452332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EsuB7d4keB9P93gdg54bs2Rc0IBaRzmgviQMlBJwkiE=;
	b=Raq/QHBuB0VYWNIUPjqXEbohaVm7dWFoUeXZIvWdose4D3UihVQZIw36KpBFvKMmPV9W7A
	Gfa95d9Wr5RjiVqqCnzXbu4rOIx5NIIIHEqWp0u8KCuVtgpNV7g3PDXV4MtqpCPNuiWSPD
	jbTq0W0N/LYfElXXyplccGZKgtisvVQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-_I6HY3N2MtmOd_pOaysVaw-1; Tue, 14 Oct 2025 10:32:07 -0400
X-MC-Unique: _I6HY3N2MtmOd_pOaysVaw-1
X-Mimecast-MFC-AGG-ID: _I6HY3N2MtmOd_pOaysVaw_1760452326
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46eee58d405so30542995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452326; x=1761057126;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsuB7d4keB9P93gdg54bs2Rc0IBaRzmgviQMlBJwkiE=;
        b=eIwUwxtlENF+KULXJLY8YOGSJ8mYAHGYGu62T2esYCDed5821YUHJFgmFveleASkF9
         CNY95eql6Q2LE4UUm2y9al9v1770ZyFggWK3P1SpbdzlNw2v4vAYpWFHsa8LhGWbrj93
         uu4qHCGI7eIFyG1fiX8oXlf2nZ4fyUffJnqSCjhiGRk9oozQTsMyruRahpVigBjBeokw
         X58Mgb926s4ttDw4rVYbReYB0xrbGuwUa7Oq0oHRFrF61oNPtqh6QLiDgFujsMf1TGKT
         J9PUzUl2gbnbK9VTFzlyjg/QrsU5WPBEufz4DxY6fhVAOC/RY+gsOc6zB/cTVKKrQRYV
         7aMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP/cIb4AWSaVFGUJVgYbjWDZfj3IwCFG1kFqlFZEHWqR3uMhLZ4SdC8v5fGq7+hwyN1rrbZQjOKlHLPN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogrfNWtpJ//eky5Q2WREcIN1Tiy2laxVDt0FUGcaoEtuVIo+o
	BFvZAFE8AY98BmHBjtKs8CgE77BDRm2h8FjGqUw/wnuH+bQETn/AayqPc8fmlT+MOZL3tijoXzP
	KRHOsTVHHLMz1eToA2nAZU+BOFu9KafAIJJF26ubQMsuZ8NFNK+KHRJz8q9mqwNsnng==
X-Gm-Gg: ASbGncvneDl+8nSgAuHBCs0EdbcwwsjnCw0/oK1q+KiGxXLC2bP+0BMTrxYAiKvVbE2
	fnl/ezzTyfBsxNFc9xX8E5AsbvY+F1hONUCQzFA7BqbbnnBcpRw0L2OEzLCnCQbgoUxSx4DBZjW
	8wmDioQzqDoH7Q7epXPzEtfmLNpU6PoN2h53ijzzD63Lh/LEhCgdeufBRF136VW7gwkJ0zhqbMR
	RLr5jRf/IeAI9IawGK+pyBeoANFbriMp9LUAZpM8yomLbFU/3WHEEqVxi98ZDY+DNvbT/bIWyTc
	5Y/fp2c1/yhV8FEySQ7noP95Mg90jZomcX84L3/6Knm4LJeUpHBAPBu7NOxnCJzx1rt8NI9YmQ=
	=
X-Received: by 2002:a05:600c:c162:b0:46e:47cc:a17e with SMTP id 5b1f17b1804b1-46fa9a8f4c8mr168715595e9.1.1760452326371;
        Tue, 14 Oct 2025 07:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrIgLdLfNz2VgFZaLseNZ6VpfJuRiNBSJYOThRdlNG1uVssvmSs1Jcpfz9qzUg6qfgsS6X1w==
X-Received: by 2002:a05:600c:c162:b0:46e:47cc:a17e with SMTP id 5b1f17b1804b1-46fa9a8f4c8mr168715295e9.1.1760452325989;
        Tue, 14 Oct 2025 07:32:05 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583335sm23444468f8f.18.2025.10.14.07.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:32:05 -0700 (PDT)
Message-ID: <6f448506-677f-4e0c-aa9c-d5da061e57ee@redhat.com>
Date: Tue, 14 Oct 2025 16:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
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
In-Reply-To: <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> static inline int pte_protnone(pte_t pte)
> {
> 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
> 		== _PAGE_PROTNONE;
> }
> 
> static inline int pte_present(pte_t a)
> {
> 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
> }
> ```
> 
> On x86, pte_present() returns true for a protnone pte. And I'd assume
> other archs behave similarly ...

Applies to all architecture. prot-none entries must be present, 
otherwise we'd have a lot of other issues :)

-- 
Cheers

David / dhildenb


