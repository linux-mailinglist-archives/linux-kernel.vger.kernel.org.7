Return-Path: <linux-kernel+bounces-806710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D27B49AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9828B207EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA42D9EC8;
	Mon,  8 Sep 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsu8tWZi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE226CE07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362650; cv=none; b=oRMdU1M3jX4avoWSlr6UHwdGT3Esu94mRYP1/G+c1zop4QPD1L2TwQ/VJKYBUT2ap5EBmtCxgFcGrMgSO4qwnQP89zODv0KtCGoCIwGlZW9YtnitG0erFTZa56K1slDbgB+rshdmpBVo4mWvfe2XN0Pp+xsXUSyE1sPUeWc2pSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362650; c=relaxed/simple;
	bh=xrsYMX1yBTF+4DH2REGWKM+6iZ9nTT2FnywHIBJ9IfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/vQ6jjIAl042zd6cQbn6veenqxnlXe9KbfBkWdr/FO6ZQ7vA2ZXYy4CghwWRAaXMbMZiz2c/lmrXzqRCtztzH6pZlzF+jQ+S1QKI0+5kZaQ55VBZUEyWQVM+Gj7GGqAgxdxdhYuSPp55ddai59rbHxCOCp+0P4sj84cf3iLO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsu8tWZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757362647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIdc2B3/3kj+ymcwj5i/pUFxxLC6d1gkotCHsH6YjzU=;
	b=gsu8tWZiteZZXWX3NRkAEnGaKOQJ4OL48JTLaKj8TbYPiBlJ29RZ2E91DgysYvFAgbT3mF
	pxmiIm3cyVc9tVFYNeaT3HlMKJIljk/37XkeaUvWIn+eWYGFIGDK5K8/mhi4a+1sbVTrLi
	i7F5GcNodatOkY+j/wR5KRDDjE8sjS8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-anpeJ623PL-_cQZKnQyqCw-1; Mon, 08 Sep 2025 16:17:26 -0400
X-MC-Unique: anpeJ623PL-_cQZKnQyqCw-1
X-Mimecast-MFC-AGG-ID: anpeJ623PL-_cQZKnQyqCw_1757362645
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so26166595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362645; x=1757967445;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIdc2B3/3kj+ymcwj5i/pUFxxLC6d1gkotCHsH6YjzU=;
        b=rYAhM07y0+2Zc298Lzk01qmo2E+/myjePmQ7XRlmIVTjbBDnTlEgI2Wp5K0AGDkOo4
         TJBrHTgXybfDmyskHc9CTGfIMqhOKFHe2h/eGacHWPBp/5M4dZ/ebNFI9prI0+EAx91v
         tGTO3TQKc89e96AL9yeyle4XGkpDTifRHoU6VmJGugz948ETJmJsH0ldfZ8BWpJ+/jOC
         +1RakOZXHQ2SlZmNZgnPNS7ndtBYFRwJJ0ofBav1SLe3DBWDIXfaDwmasIgDOXOJntgG
         ExE7Nvn6KOcXdESdB/3hWYSHmcGaiKHUuILpCXky0ICJdnvReWknL45M3O8/bxAyITpt
         paaw==
X-Forwarded-Encrypted: i=1; AJvYcCXv5qbk6LXeOJO8I8H9h0vKDa2rphSG5eMyaNo6wQ6Ta4Fx0vAN2ehGySBVvwZYJwA9klnRu/3Z40XlO44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOLkCn6XmqwSbbBtOfkuOmAQm/zH+Ffst/iQsJL0ShS/pbyjM
	mATzrBh9/fA/0YHL5ZyQgbkVGc08Nf3904jdmj3q3z9lL8NOEG8inXztIutZs+Lk0f0MA3ckzji
	9jW/SN8//uVs2rDMQCbj3Ne96w7hcUWEnf6MR8r61dz8XMkkyQPH8yUeJ0pNEpffJrQ==
X-Gm-Gg: ASbGncuWf/Kvao7lhQgJpRhnqLrf4gOEA6yI6aDD5jOQUrWDIFF4RResYtnsR0jX5FL
	Cfst32np1yDpuans2H2QcrmqoqYN6c7/uSkSqdf7FifRtE9r65T59Egz1SmcgKbfjA+vO0IH1MY
	7m4bnmyEwR8XlnGUBs7UrFFlZx0dBxnyz35IQwAmLDkh53DpeO7uPghSPPiPP6Z/n+TbIOJMUsH
	pXlAtAeMY8YnHLDXPqutY/RvW73ElYkwTj75MZ5Ra//a3eXA8cZB9FZ7PQk7uqi+TI/wpZJiji0
	gGyl9f23oYdFAIU3Wi9zBcxOCgLx2aA2J2X7QonL4fiXxO5JU0udQQ5txdRaOVmzEV/bwmk=
X-Received: by 2002:a05:600c:1c04:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45dec615a1bmr11841685e9.0.1757362644763;
        Mon, 08 Sep 2025 13:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VTWXL8MTAyDz7RkkeZe8eMmnkRUN5PlJ90kWk1wvnC5CLCcvu1WLdP9XdvnFdls022qPbA==
X-Received: by 2002:a05:600c:1c04:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45dec615a1bmr11841315e9.0.1757362644276;
        Mon, 08 Sep 2025 13:17:24 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45decf817efsm6223815e9.18.2025.09.08.13.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:17:23 -0700 (PDT)
Message-ID: <919ab2ee-6493-4415-a75b-e1a2b08c0d3e@redhat.com>
Date: Mon, 8 Sep 2025 22:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm/gup: check ref_count instead of lru before
 migration
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <47c51c9a-140f-1ea1-b692-c4bae5d1fa58@google.com>
 <e54b1d8c-ad63-4c7a-8b1b-b7c3d76446f2@redhat.com>
 <b008aef2-f69f-e2fb-d4d7-71a42d308529@google.com>
 <1f714ba0-cdda-4122-b6a1-e1e0ea44b1f2@redhat.com>
 <d5333648-7b88-9293-dc1f-e080dff65d1a@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d5333648-7b88-9293-dc1f-e080dff65d1a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 21:57, Hugh Dickins wrote:
> On Mon, 8 Sep 2025, David Hildenbrand wrote:
>> On 08.09.25 12:40, Hugh Dickins wrote:
>>> On Mon, 1 Sep 2025, David Hildenbrand wrote:
>>>> On 31.08.25 11:05, Hugh Dickins wrote:
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index adffe663594d..82aec6443c0a 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -2307,7 +2307,8 @@ static unsigned long
>>>>> collect_longterm_unpinnable_folios(
>>>>>       	continue;
>>>>>       }
>>>>>     -		if (!folio_test_lru(folio) && drain_allow) {
>>>>> +		if (drain_allow && folio_ref_count(folio) !=
>>>>> +				   folio_expected_ref_count(folio) + 1) {
>>>>>        lru_add_drain_all();
>>>>>        drain_allow = false;
>>>>>       }
>>>>
>>>> In general, to the fix idea
>>>>
>>>>   Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>> Thanks, but I'd better not assume that in v2, even though code the same.
>>> Will depend on how you feel about added paragraph in v2 commit message.
>>>
>>>>
>>>> But as raised in reply to patch #1, we have to be a bit careful about
>>>> including private_2 in folio_expected_ref_count() at this point.
>>>>
>>>> If we cannot include it in folio_expected_ref_count(), it's all going to be
>>>> a
>>>> mess until PG_private_2 is removed for good.
>>>>
>>>> So that part still needs to be figured out.
>>>
>>> Here's that added paragraph:
>>>
>>> Note on PG_private_2: ceph and nfs are still using the deprecated
>>> PG_private_2 flag, with the aid of netfs and filemap support functions.
>>> Although it is consistently matched by an increment of folio ref_count,
>>> folio_expected_ref_count() intentionally does not recognize it, and ceph
>>> folio migration currently depends on that for PG_private_2 folios to be
>>> rejected.  New references to the deprecated flag are discouraged, so do
>>> not add it into the collect_longterm_unpinnable_folios() calculation:
>>> but longterm pinning of transiently PG_private_2 ceph and nfs folios
>>> (an uncommon case) may invoke a redundant lru_add_drain_all().
>>
>> Would we also loop forever trying to migrate these folios if they reside on
>> ZONE_MOVABLE? I would assume that is already the case, that migration will
>> always fail due to the raised reference.
> 
> Loop around forever?  That would be unfortunate (but I presume killable).
> But when I looked, it appeared that any failure of migrate_pages() there
> gets reported as -ENOMEM, which would end up as an OOM?  But you know
> mm/gup.c very much better than I do.

Yes, like I expected, we just bail out. __gup_longterm_locked() will not 
retry in that case. It's interesting that any migration failure is 
treated as -ENOMEM, but well, that's certainly material for a completely 
different discussion.

Thanks Hugh!

-- 
Cheers

David / dhildenb


