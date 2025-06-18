Return-Path: <linux-kernel+bounces-691924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE2ADEA80
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E13189E7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB302E763D;
	Wed, 18 Jun 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc57ibY0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845242E54CD
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246820; cv=none; b=dZmLHfWTCdB4XZEnNf+7SO46MsPe2chRl8bl5LAsHN4Tn8JPKs3TDqRJFajyJoNPr90Gy0pb0MmYH6++gpr/e7WQCprAA8qjQZU4XXFwBgop4F5T8plTgQYALOokrnWOntFTRCINKqj8u5p0tPiZ6i0mZVfx2Qc55lmGJIPxIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246820; c=relaxed/simple;
	bh=rJv34prLfR9DztULYI+RpySdv0ciBuTK8+A8GpaylNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6iXqYe7TAdCtL/9eGo3SBDSqG5h28gdN88YhRKh7wsbD1iwer7/2xjgjMGTOKEFc42DMJklNLc3Sarwo5rdyY4wrWDWYE/iKn7mK4iboOrMJlB0MYZYZZAh8R1/u82k+k59wpTDZ2PJ+Y+FMT9RwS0RVRvrL4qiSQApkBK15Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gc57ibY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750246817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xDO9S5s2rEX7oweu/3FQY3ihC5X7U1SC0vT6ArEkZE=;
	b=gc57ibY0ZplX9bLgpUURxYpKH9j8QgKYbZZ5QnuoZE3AaeMgRji3pilBgM80OuCqSU9UTF
	NYsuSK2GHeY/OFAB82uVGw8Rt2IonpzZ3Lv3L9qDvwEnRhtsvXANset6YQoTNsoF3r2eQN
	2ufVwlTKVKlrGAOpKfqJwUGjrqufnoY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-l-P_7EvYOOeaDU_m2i7ioQ-1; Wed, 18 Jun 2025 07:40:16 -0400
X-MC-Unique: l-P_7EvYOOeaDU_m2i7ioQ-1
X-Mimecast-MFC-AGG-ID: l-P_7EvYOOeaDU_m2i7ioQ_1750246815
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d5600a54so57639255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 04:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750246815; x=1750851615;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xDO9S5s2rEX7oweu/3FQY3ihC5X7U1SC0vT6ArEkZE=;
        b=hwy9QrgpjBcko8Tbhz3zGyivpSXzjXcLDfDZW5PHcUDUQvqB46I4k2jLG4etQVCcot
         HvI6CnZYhrX1c1LdKmSHpjYM+VgH0sJe1xNFXSMQGJS7jg2qTDM3xZ3a5G7UTAjpAMvu
         ZcmFIx/TB497lKr6SAAKeCyyfqje64zG1LJf+OL/vzv0EWRZ5ieEII44RccELsTi8w62
         iMluDEIiPPQ6m3uKFe0Ws1QOGV822GIrhp2skQnfP/SW7xFt9rZYlJfJxRAaHkFgzscX
         xUApS6hN/SDCT/1F/TKwOFgMVcOZwLv7SA5yjnhGpxXmMm0PfCFn5QJ2eRwH1Bm24nxA
         Xi4w==
X-Forwarded-Encrypted: i=1; AJvYcCVeEZi91oeYXxvZINcLEV0mg8bNr6WqhOXKb3tNwcJ5XwHkK3jRoOgAU7zyK205smL42RXa6qW/fIFo3dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27LYyG2Z+vmsN3NRSf7vDgzXnbScVvkq+dvjHWKCYp7WVKOEf
	tsBhdWlM8E/0YS3E1nuJbRZ/kI1P4mx8v3bN6zJwx27S/e+K8zQ4u8ms34Bc702U+awiAta0B6H
	iRhIM4xtE//VX39X0wzHcred0Wlr0K7sRnJulOOCyRPLDN/hir3ud/oCVpMqBhJ+YQQ==
X-Gm-Gg: ASbGnctYFFiQ3sC5e+OyWBb731J/z2cwuZP5ZBSC+LlNPdv4BS/pMpg8PEPc1BJbobQ
	aXRsJL9mM3zL2QyJ9UdPh0cJ18/ANa84FxSnjBoce1v2m9tCqyEzbChverapFG/Lqy91tsrtAm0
	FnMbXDOl8p7V+mrl+oTKeheC1pgJ9J5NgywvzIuoKhf+2HVOMQkFvVUwHe+UyI6o9w7dHTAzTrO
	cWD12tR5YdBjMw4S/M+EIw63i/tQwTST7bW4qFGrPl75U0qEMpoDk1V2ceOCoz5bHGJPSn7O4pE
	ffzax4eMBfX7p7ZqqmT1lTW6Ew7cG2bGqzqR+iqq1uziTMn7pD/HJmO+tFRgRXBVvhCC+0ZwHtj
	3QOYUBSGca1iI5n02ITCG+KaZKEQDabYzMNN1LOmEmNYj4Sw=
X-Received: by 2002:a05:600c:1d0d:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-4533ca4658amr168075615e9.2.1750246814716;
        Wed, 18 Jun 2025 04:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQFaxkhFP76Yhxn9ktE3C8a7/XVi0BEU4JLqAjlqNbCFPzncE0STAA5a0na8RvLU5davaKRA==
X-Received: by 2002:a05:600c:1d0d:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-4533ca4658amr168075305e9.2.1750246814341;
        Wed, 18 Jun 2025 04:40:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:2400:4052:3b5:fff9:4ed0? (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1cc5sm209672895e9.16.2025.06.18.04.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 04:40:13 -0700 (PDT)
Message-ID: <9c31da33-8579-414a-9b2a-21d7d8049050@redhat.com>
Date: Wed, 18 Jun 2025 13:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] gup: introduce unpin_user_folio_dirty_locked()
To: Jason Gunthorpe <jgg@ziepe.ca>, lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 peterx@redhat.com
References: <20250617152210.GA1552699@ziepe.ca>
 <20250618062820.8477-1-lizhe.67@bytedance.com>
 <20250618113626.GK1376515@ziepe.ca>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250618113626.GK1376515@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 13:36, Jason Gunthorpe wrote:
> On Wed, Jun 18, 2025 at 02:28:20PM +0800, lizhe.67@bytedance.com wrote:
>> On Tue, 17 Jun 2025 12:22:10 -0300, jgg@ziepe.ca wrote:
>>> +	while (npage) {
>>> +		long nr_pages = 1;
>>> +
>>> +		if (!is_invalid_reserved_pfn(pfn)) {
>>> +			struct page *page = pfn_to_page(pfn);
>>> +			struct folio *folio = page_folio(page);
>>> +			long folio_pages_num = folio_nr_pages(folio);
>>> +
>>> +			/*
>>> +			 * For a folio, it represents a physically
>>> +			 * contiguous set of bytes, and all of its pages
>>> +			 * share the same invalid/reserved state.
>>> +			 *
>>> +			 * Here, our PFNs are contiguous. Therefore, if we
>>> +			 * detect that the current PFN belongs to a large
>>> +			 * folio, we can batch the operations for the next
>>> +			 * nr_pages PFNs.
>>> +			 */
>>> +			if (folio_pages_num > 1)
>>> +				nr_pages = min_t(long, npage,
>>> +					folio_pages_num -
>>> +					folio_page_idx(folio, page));
>>> +
>>> +			unpin_user_folio_dirty_locked(folio, nr_pages,
>>> +					dma->prot & IOMMU_WRITE);
>>
>> Are you suggesting that we should directly call
>> unpin_user_page_range_dirty_lock() here (patch 3/3) instead?
> 
> I'm saying you should not have the word 'folio' inside the VFIO. You
> accumulate a contiguous range of pfns, by only checking the pfn, and
> then call
> 
> unpin_user_page_range_dirty_lock(pfn_to_page(first_pfn)...);
> 
> No need for any of this. vfio should never look at the struct page
> except as the last moment to pass the range.

Hah, agreed, that's actually simpler and there is no need to factor 
anything out.

-- 
Cheers,

David / dhildenb


