Return-Path: <linux-kernel+bounces-816416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F815B573A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50C83BDD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4D2F361A;
	Mon, 15 Sep 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS103I9D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E352F28FC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926315; cv=none; b=R1FRKChhu5vG+DTj/CLa5fuiYii8X44pO9BvcLKk51hccEsw/TBUbj5KRhsCN3I9xjQcV8/1dhkWwPuHe9Sq1s0TtSdpvo3ZCit/9pgOlrGtht/Z9w5buApDMfLwKJumjykGTfl7JlbH5NNA3ATHpjNgLRpLmL5wgZRQoK8ATDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926315; c=relaxed/simple;
	bh=K9DnZbwwc+Qgw1EQWLXUQAXITJLMxq0U4dFMNLyDULU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlOch5a7TxAoXKHKmV+eiJxrqyOxin9jKLsUTuGyH1EGXTajuG0t7KsWM/HX102nZIzdjsBRLteGC3zrnwqBbVvs4sEum1jvTVFFwRFB0wAh9/sspWUQ3pQjiP/HaXtx2sKcJoLus3cqO1P7Srm982pqmkVdiU9rX3INXStAFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS103I9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757926312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LbC9+HlZ3wYD+Tu6w1/ck3ndJOKoJRqAyUbt5dHckC0=;
	b=BS103I9Do1L0NOrk6dUqyu74hxs2cc2O227FEF0hFkgdXe3FqBgm8xTFZ/6ChaDjqMrYWm
	ovCSQJm/NiskersB6Hc9ydNSm26G7UvOZ/4qsdFgdIEeTw8njv49P8KOnnaN6DIT1Ei+yw
	Z9Wr4tuJqi4tS4AgSe9b/a3rWPbBpTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-fkRNgqKIP1aSUouMPozx0Q-1; Mon, 15 Sep 2025 04:51:51 -0400
X-MC-Unique: fkRNgqKIP1aSUouMPozx0Q-1
X-Mimecast-MFC-AGG-ID: fkRNgqKIP1aSUouMPozx0Q_1757926310
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so30947425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926310; x=1758531110;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbC9+HlZ3wYD+Tu6w1/ck3ndJOKoJRqAyUbt5dHckC0=;
        b=f51E8ABubDmB0QliClI3LsDh6YT8cHf61qn5ZETGb/ogkH0lgzRxMKfTdQFKMU0K4x
         +5vRNI3RJUACwSTGXZjFRapkVYneHEUm5hSQhvofO6RkhM7/FFo57HxI0637JOo2sOPb
         uMwMgstw+xpQJ7QUG4rlpq3aaGLqM9CnL6gMsto7jKL2nVnaaXYSjurlVl1u4HPgkywB
         WUAiw+4MK9YsVfAlVKSUiBxvtI4n8peHbwpuQ+QM/K/TX8dCx9+3Ss6kveEhdUovnGyY
         V0GW5RPBg4cL/4eMVowy/JRVjXevHf9I8/kD6XWCkig0PRa1ComqmmFNecmFq4BbVNbI
         E4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU1vQxbW3FyM534FmgqdeFt7zh6W1LWSTxrYG+LfIW+unZiBjgKfdrUbrfZwYbXuiqQX4IqgzN1X7IKL2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BIpCCTIGpoRQDdES2nXq0Kn9YQmWoH68tbvbKFUuEYISgN/x
	MytM4ES1Q4koAl8U3igBhkWvgUA8azkVs6B3+tvagxp5RadFTiLwD9YeQoHnVQ1gFrLivQ+x6aC
	LzE8oqN1mKv1qNKAmVCqieJhj7Xu38WhngQJMf0aG9+4EXT9uwU+JS4Igw4tpa7cnzw==
X-Gm-Gg: ASbGncveJ0oRN7hztuE8twwpOYN8/e+BUnOD5LLWnnd5tIUp7vdUQjV7BId5nWmu8oH
	7aZCev34BRjHtTJ3nhXmSatArJan2H0/qFmIvoJvGkCJX8h+pkmfrlLAQImXlmEA1c+Nt3GSsj+
	okIMQgudMT/hzz5D80sc6HSlRRCDXbB4YvtTrV8QLXMC2GSbhcA2NJQZQs8nZJWydW40CmhAJVC
	E5cq8FpPYF4v9DWBqXFgsbc/bpgiGA3qHhhuVVontFLoWix8UMc4IIwuOC1JTOtyGEDvuIeJMpD
	YRufi2L5Pd2DQjY9jGDt1u3cuwko7DTLE2jvTnCOp/iIKLOVtBGRpsBel0NWSRhyoWCR97lUpkl
	0u7JN4LP3OhVzbaJK97gjWCdLA/MaFyqsfVKva+qWvR/XenN7t3gV0e1eKvPOVxLQ+90=
X-Received: by 2002:a05:600c:6288:b0:45d:d1b0:5fa2 with SMTP id 5b1f17b1804b1-45f211f9fb6mr91702945e9.19.1757926310274;
        Mon, 15 Sep 2025 01:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmehtCyxOr2v1ulJFD/llco5pkU8tfM63kgUUYxmqAqnpUwXE75+yd18OdpEGn1aaibMJcKg==
X-Received: by 2002:a05:600c:6288:b0:45d:d1b0:5fa2 with SMTP id 5b1f17b1804b1-45f211f9fb6mr91702725e9.19.1757926309820;
        Mon, 15 Sep 2025 01:51:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2ff61f2bsm6962095e9.12.2025.09.15.01.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:51:49 -0700 (PDT)
Message-ID: <fb322901-28d6-4f0f-8bc0-bcce165ca250@redhat.com>
Date: Mon, 15 Sep 2025 10:51:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Dev Jain <dev.jain@arm.com>, Usama Arif <usamaarif642@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
 <20e7f812-c1e7-455f-a523-08fc99024adb@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20e7f812-c1e7-455f-a523-08fc99024adb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.09.25 16:04, Dev Jain wrote:
>>> ---
>>>    mm/huge_memory.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 26cedfcd74189..aa3ed7a86435b 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>>>    	void *kaddr;
>>>    	int i;
>>>    
>>> -	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>>> -		return false;
>>> -
>> I do agree with your usecase, but I am really worried about the amount of
>> work and cpu time the THP shrinker will consume when max_ptes_none is 511
>> (I dont have any numbers to back up my worry :)), and its less likely that
>> we will have these completely zeroed out THPs (again no numbers to back up
>> this statement). We have the huge_zero_folio as well which is installed on read.
> 

FWIW, I am still hesitant on this patch because I think the whole 
deferred split lists + interaction with the shrinker should be cleaned 
up along this patch.

> How about just doing a memcmp() between huge_zero_folio and folio? We know
> exactly how this folio looks like, in case of max_ptes_none == 511, if it
> is to be eligible for shrinking.

I wouldn't really want to optimize for this case, especially given that

(a) I want to remove all direct dependencies on max_ptes_none and any 
special values.

(b) The huge zero folio is not always around

(c) The kmap local prevents us from doing that (in particular on 32bit).


-- 
Cheers

David / dhildenb


