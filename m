Return-Path: <linux-kernel+bounces-836542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBFBA9F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BA3A8921
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D7030C0FC;
	Mon, 29 Sep 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZl6iC67"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247D2EB5AF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162374; cv=none; b=GvBPYwbsTYrudtgJqIZriU+F7O1BC0TD4KXG+L2nJscmnuVrMi+A9xUCavNRcobHYgc5vFeY2gnrboYNnwn8pEvn8ATdWRGU/DNPKmd5S1ln7zwsFNSAuDPf2MCbRh0eCq9kBNuuyhORD7Un2x2OwzYuWqHkwGQyIiEukathP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162374; c=relaxed/simple;
	bh=9id54hbA2TioezpUxWXNp+g5Tj1D8olk5IdAUaRVnyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6EepZZaDoKPxoHcuCdbZsQgkaSMQ7JCjpK/MXZmlLoK0TyugxM7HOro2xgHXIZKF+kzjH60+ZcTn4YlYiV+ytMrxG3fsNU3U76PAcksgwKfbmxVRBNn5xC1XJd+NVxR5j3GyONvCOtXTf/Ai7tsLwZiFLCZOlMP8BT5IYw0EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZl6iC67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759162371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OzvElMudVSfvbJETPxHv1iAKDOnPfrzp7voXLszfl/0=;
	b=CZl6iC67LGPwuaqx90P88zejKIxlKK6vxE+A0bSfNpcVYc6VJanKmjK7cu8IakRS4sRbdt
	dXUaNPbG/xFKleyOiE1i3HlqjcgNjEX/Z0P+OCEdF9t2E1k2MFpaqdBvi/NwWywF1m48BY
	JvO2CvX5jlzYRXeXN+b1l8C4vjzzOkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-uNWlRqPRN9SfBDBh2JpoJw-1; Mon, 29 Sep 2025 12:12:48 -0400
X-MC-Unique: uNWlRqPRN9SfBDBh2JpoJw-1
X-Mimecast-MFC-AGG-ID: uNWlRqPRN9SfBDBh2JpoJw_1759162367
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e509374dcso7985685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162367; x=1759767167;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzvElMudVSfvbJETPxHv1iAKDOnPfrzp7voXLszfl/0=;
        b=gpu8KThUIfUWvaNZOOGzZQ9/A7xzqzI1C8qXUeKfCJcM754nBZBtQDMqgc3k8cVfRP
         Ht+cahHU0X9uiQn1S7NSH4JFmZYcRpJW39LFbUoW+ctpYZ25kXQUMLnvLVNVCNfOIx0c
         ePWFshLNKIN0YxYTtPlUGTeOQUfRrJbvW+1AIybye5ynRxonZxHacGvdDuflefByOz4E
         0+oTqPkFbPUpD0iMZBf+KUBAeTj7eMYbFPktrXhhjZ2799Fw7LMzTOQZGGLYUSvgkMdd
         rM3+wG8eZ4j9bGk0nPhFw9mjvWOCzZ3isfcptnBVihDKT7TpKOWyESFvdYOF4zutEwIy
         LBLA==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ39Q8hu1aEicJrvTCfK+WjeUjTbbAI28HtAZ+QSToTHfwLsW23LYlcTTqaHkSLs6TnjrCMQGLClxrBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18e+aByAhIWL0rHvZYq4ZQ5YeeVI1jUZUTNh/aEZ7t4zSdoz9
	JJhOoxGdziS1i6goXV93aAUBP5yqfbV3/oLlMQRaYyT5fawp4+TBRLSVCq0UCBxm+1MveYtOdVg
	F/06yULURDaeEmji22N6O7XFNlcNUiBtYbtK7mZpq4q60/IaR30M1MjD03KrBhcTPYw==
X-Gm-Gg: ASbGncuBCb7Bm2lRDOdLCm5O7CMQw6pYz89RoG9QrROCuJiuN8i1EjIcasAnGZig8Vo
	xkcl+a2IkwIY+epdan9RaOntUwA2/To/n8sqiQxUK1rvoFmXSuraa183a3Vu9aedY/BqYdNlHwW
	9UJf6RbaryJpF6DpumKOuUwd8oiSyMQMjto1y+DctjV7KCVZJyeKy6Hm+b85cFQVYJhnDP9uzBQ
	qxppliQI9Lw1WOp9AHEl/43HVX6AhZzCBDqM4nTSyzxB78ejwZfAujJYGgWcywLwxx7kCGGjFx2
	IwDZR7kOkF/R36ul8Pdunfjkxcl1pZ0/c+5OHmkSLrMALQNGVZSXpOz/n9P6PCfb4hB/7LpRQA6
	m35w=
X-Received: by 2002:a05:600c:c04b:20b0:46e:4cd3:7d54 with SMTP id 5b1f17b1804b1-46e4cd3808cmr49439565e9.18.1759162366870;
        Mon, 29 Sep 2025 09:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1GaUJvPE9CIRgzTsnjb5wMg+CWX4smf8zPGHwXWsu5AFuVLyV5tu3ni+AZ0lmEZbiWGdluw==
X-Received: by 2002:a05:600c:c04b:20b0:46e:4cd3:7d54 with SMTP id 5b1f17b1804b1-46e4cd3808cmr49439145e9.18.1759162366448;
        Mon, 29 Sep 2025 09:12:46 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm18806375f8f.56.2025.09.29.09.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:12:45 -0700 (PDT)
Message-ID: <ea6aafea-59ea-4df4-b5e3-796cca047c76@redhat.com>
Date: Mon, 29 Sep 2025 18:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "Chen, Farrah" <farrah.chen@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Zaborowski <andrew.zaborowski@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com>
 <SA1PR11MB71303A772356C994DB932077891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <SA1PR11MB71303A772356C994DB932077891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.09.25 15:52, Zhuo, Qiuxu wrote:
> Hi David,
> 
>> From: David Hildenbrand <david@redhat.com>
>> [...]
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2351,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
>>>    		 * otherwise it may race with THP split.
>>>    		 * And the flag can't be set in get_hwpoison_page() since
>>>    		 * it is called by soft offline too and it is just called
>>> -		 * for !MF_COUNT_INCREASED.  So here seems to be the best
>>> -		 * place.
>>> +		 * for !MF_COUNT_INCREASED.
>>> +		 * It also tells split_huge_page() to not bother using
>>> +		 * the shared zeropage -- the all-zeros check would
>>> +		 * consume the poison.  So here seems to be the best place.
>>>    		 *
>>>    		 * Don't need care about the above error handling paths for
>>>    		 * get_hwpoison_page() since they handle either free page
>>
>> Hm, I wonder if we should actually check in
>> try_to_map_unused_to_zeropage() whether the page has the hwpoison flag
>> set. Nothing wrong with scanning non-affected pages.
>>
> 
> Good point about continuing to scan non-affected pages for possible zeropage mapping.
> 
>> In thp_underused() we should just skip the folio entirely I guess, so keep it
>> simple.
>>
>> So what about something like this:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c index
>> 9c38a95e9f091..d4109fd7fa1f2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4121,6 +4121,9 @@ static bool thp_underused(struct folio *folio)
>>           if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>>                   return false;
>>
>> +       folio_contain_hwpoisoned_page(folio)
> 
> Typo here 😊?

Yes! :) As always, completely uncompiled.

> 
> if (folio_contain_hwpoisoned_page(folio))
> 
>> +               return false;
>> +
>>           for (i = 0; i < folio_nr_pages(folio); i++) {
>>                   kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>>                   if (!memchr_inv(kaddr, 0, PAGE_SIZE)) { diff --git a/mm/migrate.c
>> b/mm/migrate.c index 9e5ef39ce73af..393fc2ffc96e5 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -305,8 +305,9 @@ static bool try_to_map_unused_to_zeropage(struct
>> page_vma_mapped_walk *pvmw,
>>           pte_t newpte;
>>           void *addr;
>>
>> -       if (PageCompound(page))
>> +       if (PageCompound(page) || PageHWPoison(page))
>>                   return false;
>> +
>>           VM_BUG_ON_PAGE(!PageAnon(page), page);
>>           VM_BUG_ON_PAGE(!PageLocked(page), page);
>>           VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>>
> 
> I tested this diff and it works well.
> If there are no objections, I'll use this diff for v2.

Sounds good, thanks!

-- 
Cheers

David / dhildenb


