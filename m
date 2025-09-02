Return-Path: <linux-kernel+bounces-797288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810DB40E70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B65E485B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229832E8B91;
	Tue,  2 Sep 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTx1Sgt4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CEA2E6CA0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844208; cv=none; b=qwlUJRCs4rfiC61vtwpK/xkNxclxnNrei5eYZ6ydzKZDlRiHIAKlxMR03EOVDhyPXelpR/tPOICzz9G8elfZzHBIKvgY3pUZFeGMlK+9F65lTrn7cgq7nUm3uUJBvA1AG80M0XM1hHuyqdKC24DIMoufJXgkT9EOUcyfjFTlkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844208; c=relaxed/simple;
	bh=ROXs1Hlp+4jL2bmJspkZrEGB89wbIrMi7bYvFBujmnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKFxK4q4FyTuUBd403aWB+2CHBd2ul7UUE7CZ22Rg0YFMItKT83JC10mbhQEUzXaC+Wlhse9c7JfnIULadsHh+mWla2MTi6ygC1IvTAsTEKAFPBCDzayNLJc0y5pknUks7O2X1uFEkVUFdc/7pvMXSKCeF06ScP50kvCtRQb3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTx1Sgt4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756844205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=moCSkIRbJKOTPrlGJxHnzsTIsOlS9Ui0Q813Wpu9jNY=;
	b=aTx1Sgt4gPAWcsBgDGlFmQwl0eI9FhmbTq05fc5vfZ2J219yp2ZXFOTzxvmgt45/DXH3O+
	CQ59hSgIM2u03IgDUWNiBE/wyPhOD92gaacvzsZs3WJpR4BBR0LvLpDBDuxt0958ChPls4
	D9QGTRE2RgG8bxRG4Vim05YDWmE+VvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-RXYE2xoUOweAvYAOet_ECQ-1; Tue, 02 Sep 2025 16:16:44 -0400
X-MC-Unique: RXYE2xoUOweAvYAOet_ECQ-1
X-Mimecast-MFC-AGG-ID: RXYE2xoUOweAvYAOet_ECQ_1756844203
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9c1b74d0so5536915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844203; x=1757449003;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moCSkIRbJKOTPrlGJxHnzsTIsOlS9Ui0Q813Wpu9jNY=;
        b=P9I37ZVloCxwZgfNJadYoo9SP2hCV2Wiw0eaOQTtatX4erjkKWoFMVTxZmrUAYQY4f
         HCro7whsVl6tHJXo1jUyjiqIaa3fWE8txVTq/ooThj1YS26liHK0zWH3ZwqnrDHZGw6J
         GXJ+Q8bcDACEVmOb1MaxeUeh4/A5c6SYHmNLPAZxLW/ldJtI7BgYpSA49NL00uVNwrUG
         7MtOOV9CTJRHefD/mrZOw2r921z4h2nk8AMOIVXcA6IemoOIQ7LVIuCwECBybydnA2PD
         o6uctoEYDd5PUXPxx59OY85kMBZyTADVPoy816yWmaGTJudEKqQvkiXsoMYpc5e6gUdO
         Dy5g==
X-Forwarded-Encrypted: i=1; AJvYcCXCPFdYDYhqMbegd/Jh9vtyPLHmv9/0AfUvzQTFWUfJ2FJDvwA4mLsVAIExlFoNOVTTlBhvMfmEi0+bTOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+D/rJxGh/CVRrFtx7pgTLIiTqhaogK/17wWLEAT8TGMqGIIBX
	fNVtrF0qFJBkHfUJfkGXS4hv6XUeZVR46mNXoX96waITglq4EFx5SFELYw9ezDQi31kTZx6om89
	nepwmc4tU/9Lm9bEJjmjB0nj6hpx1kEK3VZdq2LsEl+dwIFeScQCkOBxN/q2JdLtykjz8wotmlQ
	==
X-Gm-Gg: ASbGncv+qSUxz3Et77hNYy78uR//uDtw9wgFQOBUUR1TRqfJdxQ3ITvNm/XjBPpvGPS
	MnVQnqk1czt9lMLrgbG8RLg9GnaFpY+xAGcbvaejEty9hE57tmj60GyEdc3bxAkvmczv9ksZ3wR
	U6o1ceXqifrANJm5AG45C6ghin4jkjgofS/c1AoDueqL4l8I06944esMEpxOKEGxMaRlvrX9YRc
	DpETbRmWS7hTzF1yfbgm1GWhHmrttbIg3OIslbz9SvxdEToJi0WJIzR4b40dLq4gbOnf4oht8Fu
	3+q0wtecSTs7Uyv57Xe84pSQfR+6TphXdYWSC9H6y7ro3+RknQ0DyYL/F3ScZlGvyEJ2aPTd+lO
	cdB6mnmxe6ZIPzKRmhQ+LHqtPqXbETomVByE6driqCYrM6lCCEBVBqiYwoI/2bKtFaWc=
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c1 with SMTP id 5b1f17b1804b1-45b88321bf8mr98213385e9.12.1756844203255;
        Tue, 02 Sep 2025 13:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+ddkAwvHhUuDPpLEBDSnfyG/LNzI9bvDVvc79AySZ+2YyJ0o9p378EsY7AzMcoSpYVEgtyA==
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c1 with SMTP id 5b1f17b1804b1-45b88321bf8mr98213215e9.12.1756844202821;
        Tue, 02 Sep 2025 13:16:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm20804803f8f.43.2025.09.02.13.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:16:42 -0700 (PDT)
Message-ID: <643f5482-cd34-4534-8cd8-69f32482bc27@redhat.com>
Date: Tue, 2 Sep 2025 22:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
 <20250902080816.3715913-12-ankur.a.arora@oracle.com>
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
In-Reply-To: <20250902080816.3715913-12-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:08, Ankur Arora wrote:
> Define fallback versions of clear_pages(), clear_user_pages().
> 
> In absence of architectural primitives, these just do straight clearing
> sequentially.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   include/linux/mm.h | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..b8c3f265b497 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3768,6 +3768,38 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>   				unsigned int order) {}
>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>   
> +#ifndef ARCH_PAGE_CONTIG_NR
> +#define PAGE_CONTIG_NR	1
> +#else
> +#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
> +#endif
> +

These likely don't belong into this aptch :)

> +#ifndef clear_pages
> +/*

/**

for proper kernel doc

> + * clear_pages() - clear kernel page range.
> + * @addr: start address of page range
> + * @npages: number of pages
> + *
> + * Assumes that (@addr, +@npages) references a kernel region.
> + * Like clear_page(), this does absolutely no exception handling.
> + */
> +static inline void clear_pages(void *addr, unsigned int npages)
> +{
> +	for (int i = 0; i < npages; i++)
> +		clear_page(addr + i * PAGE_SIZE);

If we know that we will clear at least one page (which we can document)

do {
	clear_page(addr);
	addr += PAGE_SIZE;
} while (--npages);

Similarly for the case below.

> +}
> +#endif
> +
> +#ifndef clear_user_pages

Can we add kernel doc here as well?

> +static inline void clear_user_pages(void *addr, unsigned long vaddr,
> +				    struct page *pg, unsigned int npages)
> +{
> +	for (int i = 0; i < npages; i++)
> +		clear_user_page(addr + i * PAGE_SIZE,
> +				vaddr + i * PAGE_SIZE, pg + i);
> +}
> +#endif
> +
>   #ifdef __HAVE_ARCH_GATE_AREA
>   extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
>   extern int in_gate_area_no_mm(unsigned long addr);


-- 
Cheers

David / dhildenb


