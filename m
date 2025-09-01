Return-Path: <linux-kernel+bounces-794963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04061B3EB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84016487C99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B5258EE2;
	Mon,  1 Sep 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGxzqK6S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92332F748
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740958; cv=none; b=Osp5BB4HyLxHQZzg7qyvqtLbG/KghqFlLl6XiGo66zTzhW4tKaAllMwuVmMC2eFb7H2BkFmVxQ2JBoM7ggLZhHHAFMUiLr5ftSbX1N5FR+eh97ZsxFqQ1jxdHhMMtu/mdQfF0PJERgO2qB28Owg2Kq9BIA5HNgL62Lvd7ePyEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740958; c=relaxed/simple;
	bh=635WrvmVKDF09s1dOmOgutX9T5RN2q0gOA26WX4qWhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPf9mi8t94InkYEXWkl2qtEy1vo395oIM41hirhOPN3LBgGKBik+RZChoyFZJLrKmGVfAYC46iV3fZLRiPm3kKzgSgtLIAAA4DROYHZ2cupq+A8l0ljreqlvTCJw0WEo/X4Sfr20thHrss1HsYYun4Ao4seAyIqlCwMLN33PD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGxzqK6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2bItAgGic6pszMCrQXDuDJ/trqhNDQ63firEDd4uIpg=;
	b=AGxzqK6Sk8Eh7Fd2hFIvmrJ0/TUwJuqJ9h5e2xkzL8okdTlniZfdIV2XMTg63IzI1LFpaD
	lvg5FSS1uajaHMc/H14phZBmIz84fld9yPr7Wka8vOqeYBhTyoeJk3JN/GZBRnkRgJ7sem
	EU1LrzWr+qJRNRwvM2cm3KeAZ0JqR14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-kyp6eU6cN5KX-zDpr7EAUg-1; Mon, 01 Sep 2025 11:35:54 -0400
X-MC-Unique: kyp6eU6cN5KX-zDpr7EAUg-1
X-Mimecast-MFC-AGG-ID: kyp6eU6cN5KX-zDpr7EAUg_1756740953
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b869d35e6so11886865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740953; x=1757345753;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bItAgGic6pszMCrQXDuDJ/trqhNDQ63firEDd4uIpg=;
        b=Gk/moBQhjr5+K4a3Es3ns+RX79mr93YNEFTk0g/0c1CRuonssV4OWZQP4IBds2zJmb
         B6S4ZH99DtUjmAnb5jff+sPV4x4xx3xu7S9d4PIf76JNnNhoJTVj3TtovClnSJeJmwWS
         zYgUa7u0Q8fhk4tn4IVWSlAzlrtsZsyhNLZg5aGu8sorsDAVglHg9s8Q0WAZsw+YicbY
         H+BkEpoZ+r1Voz6sHbtAhUesZfxWKs8ycgZMZ+LZQEz+JgSzTm1mf4sMpvh+Tnrejntw
         U4hsBV9BLGtwlfA0WEsRdQOEJmiwjuI/oN1Fy+wrqj6i8Xl0wDl3z80D+AG95hL+Vwpg
         Kz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFzdjQHWJJUULQazH66rw05QwYHRHcAuSd/sgcu0o8AB6xbguWg9HBbt24kIIlVM+te0xJRqjdqUPclEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvSLOiot2+VIWppOpgfIkSviSPo47hXRqEjKiCAjfpOf8qIxp
	s/AJfmUPq68ceUURz7wqtf+DxzxPqtCGeCmQQvqBhMOCnhTPucqFI7nuSoIdoh4SsOFzkZELcGj
	f+WkxoSrl1uigGy6Y8VbLowrToOO8YVRfPZb6ZZHqVpr1aNyVaowbfba66TvH40Qatg==
X-Gm-Gg: ASbGncs9ZKYTa4BaVNqRPdIgL1G9CIEEYHIUKH36MAQ3+d5a+AsBtBiKdxUi2MdkjvQ
	4w9PYfNIofaXNwiHhIVYXXbvinxM83THsYtsm+X9hd/j/8gph9rSW8gKDJ+sJtm8YpB6lJAlgzc
	UVi3xxQqhdxQrbDDUN9eI7pPUG40P3y80BkL8olRVmSnca5TKEAddB5No/FmeGKpif/UUp14m5Q
	bDp03hjimL7YE7W1yWdDE5wwBz2XIl3pffy9dMPJrfATK7lbICdjbbjE5Xp+rnOtGPAUxEHNy+U
	icmJwVG0WAm+gdlVeTcjqpcDqSpMxHMzqpX8tFvHxNucGaAVyBE+3tcjHcXSGGJojDpHbtm49ly
	P00mvLyy7tNAMNsn/3rEgmOWgja0dS1wViZRp+BqBWXWwAYdc7uZczwNkx2W5plNBWcY=
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-45b85525da3mr79300145e9.8.1756740952988;
        Mon, 01 Sep 2025 08:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHavLnql0Xb0EyOZzHHbVUfKOnLFQ8rZYbaTiEbmA9ZWCeXLmTBJuPecePMMvEIIVgKRqEsFQ==
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-45b85525da3mr79299855e9.8.1756740952559;
        Mon, 01 Sep 2025 08:35:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b93fae643sm5496885e9.3.2025.09.01.08.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:35:51 -0700 (PDT)
Message-ID: <3b30e9fd-4035-42f2-a7ca-3a670bb79dd5@redhat.com>
Date: Mon, 1 Sep 2025 17:35:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, kas@kernel.org,
 willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250901074817.73012-1-dev.jain@arm.com>
 <620f01b4-8a6c-4dac-bcdd-7c48f5cd87f2@redhat.com>
 <e52cac79-fe1a-401e-9259-747a4d587bd1@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e52cac79-fe1a-401e-9259-747a4d587bd1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:26, Dev Jain wrote:
> 
> On 01/09/25 2:02 pm, David Hildenbrand wrote:
>> On 01.09.25 09:48, Dev Jain wrote:
>>>
>>> @@ -19,7 +19,7 @@
>>>        EM( SCAN_PTE_NON_PRESENT,    "pte_non_present")        \
>>>        EM( SCAN_PTE_UFFD_WP,        "pte_uffd_wp")            \
>>>        EM( SCAN_PTE_MAPPED_HUGEPAGE, "pte_mapped_hugepage")        \
>>> -    EM( SCAN_PAGE_RO,        "no_writable_page")        \
>>> +    EM( SCAN_PAGE_RO,        "no_writable_page") /* deprecated */    \
>>>        EM( SCAN_LACK_REFERENCED_PAGE, "lack_referenced_page")        \
>>>        EM( SCAN_PAGE_NULL,        "page_null")            \
>>>        EM( SCAN_SCAN_ABORT,        "scan_aborted")            \
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 4ec324a4c1fe..5ef8482597a9 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -39,7 +39,7 @@ enum scan_result {
>>>        SCAN_PTE_NON_PRESENT,
>>>        SCAN_PTE_UFFD_WP,
>>>        SCAN_PTE_MAPPED_HUGEPAGE,
>>> -    SCAN_PAGE_RO,
>>> +    SCAN_PAGE_RO,    /* deprecated */
>>
>> Why can't we remove that completely.
> 
> (I raised this query in the other mail but due to not snipping stuff in
> between,
> 

I saw it but forgot to reply :)

> it may have been glossed over)
> 
> I was wondering whether a userspace script could break which assumes
> scan_page_ro
> 
> metric is there? I played with tracing long time back so I don't remember.

If it's part of a stable abi/api, then it could be a problem indeed.

I don't think trace events are in general not stable abi/api. In 
practice I think some are (e.g., in scheduler).

I assume we can safely drop it, just like we can add new stuff.

After all, if "SCAN_PAGE_RO" never happens anymore, we would never be 
running into the __print_symbolic() with that value.

-- 
Cheers

David / dhildenb


