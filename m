Return-Path: <linux-kernel+bounces-741155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC89B0E0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A3E5649BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0C2652AE;
	Tue, 22 Jul 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaROvow2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F935278E7E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198802; cv=none; b=h7S1aUJYbQkKSA0H+5T2zB8gz/gK+hzLp+gfdAEKRSJkb99WJ6b7wny0d1j4eIxpW2MSHFxFAUzmJd/zS/Ipwi/2Z2EZPSCbqklLbfbav3XK5SKcwJ+TsI4mnTofD3EjdIf0kJzVilayxH2jEK8fzbJ0k4aBTzb7XrAtgNxV7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198802; c=relaxed/simple;
	bh=epIEIo7FudljAuaXwgcFKA+1ibb56TwGH7ax9CSaLvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oePd7mLdK0mVDG6SKNarMN+BM4FvBVRmn3tvV6L06+AzG6bph4faidQ/71Es8BjtxfsxjaPmakulQSJLR5tp1LCYmbkrqv5usC2iBnFLwwnp+WklBhi5RKf3LqIGwCdB/sJVz3UwdsWgwa3tnibSQ0gfV+Z4CXYtymKA/33f1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaROvow2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753198800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P6oftsaw/Y8o1NDs+0pBZv6sXSPAX61Y+1sP2c3kKIk=;
	b=DaROvow2FiBQYwt+BJXTuDbNLGsgYfrFKjhsckmq3M59zfx9Pfz0SuE2kFtLruyXd+qHsW
	1B0jjA9fZK0LoJsZX3GMXtWet6nc+bKEXULsev14pymfOh/lOShlrLPs7WhODkp4w8MrLS
	C+oiM7oz/cUadEZpQyrFlfYiaVDEhlw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-gBpTtPZ1MxCKK68wpfo66g-1; Tue, 22 Jul 2025 11:39:57 -0400
X-MC-Unique: gBpTtPZ1MxCKK68wpfo66g-1
X-Mimecast-MFC-AGG-ID: gBpTtPZ1MxCKK68wpfo66g_1753198796
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso28373325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198796; x=1753803596;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6oftsaw/Y8o1NDs+0pBZv6sXSPAX61Y+1sP2c3kKIk=;
        b=oKPVNGMjIX5/N8U5faH+21mXrZH8GVHYVD3jEmCQtBj6VtEevBCpRyKMR6Ni8lXnxr
         6J70gZi9XjTqsTW7e6lKhhhjCihADVzIhYvs3AqMWyQ2ysvuHxHjSiJZflholCZvmHNQ
         ibJbbNp8kfveq1n0MnlntbbEZkwDddLzMsyPM46Hh6MlmecNs53eovS8v8Am+9fKDbAQ
         4F57rp9qMnI4QeJXuEect0H4z+w5yCho3nRV/yq5KSgt2EJyup77RAZtr1RNz0Ltsltq
         7C1h9oIJywKUXzV2oG7z8Sj+S640wjvLD+hvZ8OdxatPU0ZPq1BPlGppFS2sjyw+WblJ
         HIiw==
X-Forwarded-Encrypted: i=1; AJvYcCXql5TPl1eIfTvdUa9L7EOu00TI2KPaewpQ5JAINAuHHokIlJJXPgHAMnGsPIeQH6NeiGa+hDJ7/blFI+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7v0kYf+Cw8F3pRWHxsFTDvKAHZE54Y9zIw4cC26a9N+l+46Pe
	8uVNpAbI1XL7d3vE0EGQH7KXc7Lg83ILrvpyHjJtCeI1066UwZN8S6xjsThHYC2GsVueyYGHs6z
	s1TQP2xLn8NjzLlhcQmPFUFsFh90MPzt8qt2on85ny9Mv6SzpkKPf6XF7w328ph5T6w==
X-Gm-Gg: ASbGnct9tT4GE5gpNOoUBBYfE6f9U4yyCYC81vRQUx8zlcK3ZjAqebAQvZ7uzjTOZ8s
	P96Md1DtoohOqpn1J/i9n/bS5/PkFfN7zh61rjuLFpojjvacx8GBXXBxKHVT9RUfl3ISPlvtpZi
	Yb+0fTk2BIZVFUO6vid1LGl/miHGGJ95Ul58+kxfTJYVejqPZufEiZ30EQbK5YsZu15LRFaAn91
	Y/wn16h+nAYsBqWI7ECYeoESBZ7Xs+hg3Vc9HSvKtcsstxqbZguE0jC4KduvUmy+mpoQ+vk8a/p
	y1ufQwJSzrVGcOCWdeRjUYHKXocQlBRJ7fYnD6Eq1n9rj6X1jrckNVlPUSuAuUsbUaNWhIGjMij
	p28pQ51LIbLJmmylpzd8bSkxKSgiii+xsHk6ylFuqIDNgHAptiAvQNv3RFFKeZdi+cec=
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr196621845e9.26.1753198795552;
        Tue, 22 Jul 2025 08:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrkg4gxbARCuQj3vafGP/BU7uT0jLAHHDQrZ/pOOEsCiRZnt7P6SzdJq8yMA4UuzgS9LM8bQ==
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr196621245e9.26.1753198794985;
        Tue, 22 Jul 2025 08:39:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f9c0sm135998155e9.28.2025.07.22.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:39:54 -0700 (PDT)
Message-ID: <0ab2aebd-a43d-4ef2-a91e-10eae593de67@redhat.com>
Date: Tue, 22 Jul 2025 17:39:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] khugepaged: improve tracepoints for mTHP orders
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-13-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-13-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:32, Nico Pache wrote:
> Add the order to the tracepoints to give better insight into what order
> is being operated at for khugepaged.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

[...]

>   
>   TRACE_EVENT(mm_collapse_huge_page_swapin,
>   
> -	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret),
> +	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret,
> +			int order),


Indentation.

[...]

> +++ b/mm/khugepaged.c
> @@ -711,13 +711,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   	} else {
>   		result = SCAN_SUCCEED;
>   		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -						    referenced, writable, result);
> +						    referenced, writable, result,
> +						    order);
>   		return result;
>   	}
>   out:
>   	release_pte_pages(pte, _pte, compound_pagelist);
>   	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -					    referenced, writable, result);
> +					    referenced, writable, result, order);
>   	return result;
>   }
>   
> @@ -1097,7 +1098,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   
>   	result = SCAN_SUCCEED;
>   out:
> -	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result);
> +	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result,
> +						order);

Dito.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


