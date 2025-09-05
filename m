Return-Path: <linux-kernel+bounces-803192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DEBB45BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DC16F506
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEC220696;
	Fri,  5 Sep 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP1l2uuT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A71EFF80
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084677; cv=none; b=RznQgSarLkI9m4cTa3vRhFnG5NOvCG8TTLA3mAbCtyqzMpY9HJiRwsV7V4mE0lxH6TJnmTSYDs2oJP++VX0h7BQJwJwpFK202wTUSSuqv8m2F1RtYQY+61X6ruJGYdS49qt/MZaAGrjQDAMy6dOc9cHl7nx/aDUgsfdnzBz2HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084677; c=relaxed/simple;
	bh=89VsXm1onGKwXsW6MSJtYexfhRkXIMai0JToOVDyq8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC4xugfrww6vCmRvKa2En3UPsbcVUPWQndFbfMQ67IfpoTz+F78bIiuOTyPxtMwI4bdWKgZpefVIfP+vCD1d1+uRjoEgMVBK5BjUGfVuSqMrK//qtc2rMDNjkcMtK9Jjlem7NM3PpHTq8ZZ0rojSH5n+aakFJkVKo1Mpf6vgPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP1l2uuT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757084675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PMnPF99NXruBPX41y4ErkZbUcg5msJq/UQbSen7bhTY=;
	b=VP1l2uuTbW9qgvwKwyTH5fDP9O/uQEi/6MrdiROTPuy+zT63uhdljtP2Ac/lV4GFOTztCb
	BiiMLZQTccgD4ZtUEKHTPvCjkTdHubBr8tAB/PdhN10pXnJvTWG5mcWeAcXqpiF7KBG8mm
	etHmY+5S93PJdb3ZyyMPHL9II+FUhhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-SOXT-mwdPTif7083XnLURA-1; Fri, 05 Sep 2025 11:04:33 -0400
X-MC-Unique: SOXT-mwdPTif7083XnLURA-1
X-Mimecast-MFC-AGG-ID: SOXT-mwdPTif7083XnLURA_1757084672
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b9ca27a11so15131625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084672; x=1757689472;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMnPF99NXruBPX41y4ErkZbUcg5msJq/UQbSen7bhTY=;
        b=cbxoGhzjbzvtdznRB82vQ89+VnkTgxSFGtedWEsC+tQxutcoi4ZDFSUx5c6YQbON87
         cFqMlgADFgZ58EFGV9O6vbfRiIX3o7ogKs6c6c7vrft1coVsEusKjbXdWaccw5b4/Ukb
         f0y3msKtr3umnsYLmITMrrMIXvMoPwgxB4a1nZ8pJy/dIUE4KtC2vJgUTayib1KQUrbG
         ElHQdEaMfaYuwvJdw3UrrnuWVpOVcboj3xgBPryDYFQK/BUWP83Uot5+kFfPW22T5C3v
         drwVyk/cOYcSQUDL6Yubv+leL1I+n3ZRqdtdEp4Ea72Pq7PRsOywnO0xYRRirZiXTXrT
         seXw==
X-Forwarded-Encrypted: i=1; AJvYcCV2TV8Acxy96EjSv1lxPFNdkwvyvekZz0113NLhc3RIVJKp5SsFU2G4Oat4OoxxUY12y1dKRCuEvmQZJYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPa2BOF8hg4np+hejwNAN4PSx0jvBrPmT50mZlAGB0PQ4oYJF
	EB3KY9csxLFX1WhgqCyjynskIQaHrMqlVPZIAojqvtZ/iJG9CUt/O9EGhLuzuwHV+aLd4+Tr7a+
	788I1HXX24bIAD9Cevg9RjvMHsQAY+MV5MlaUjGZyM8D795pSgPs618BOtIWS+T33WA==
X-Gm-Gg: ASbGncsHew22lSRpFAwAzr/Rr+RpunzbFK7YfiYH+a8ifiVF1vfhMzrxN7+RCg1iXMw
	J1w5cDDMo0vOSh9iV9o8EpMNZTT3xQTAkvH2UMPR4OvumdgqVmJ2D9Ilj4HI738PMGm/a+inpj+
	EeAsqWxc3/YDNhpq8BZ8N65KTcisJ6dyPj2mvlp+HDFq0wwspE/WGl24KYSzwsXjxY8lbKR9vPj
	tetklYpEeGVmjGeOeM3/gPbCmmWzVAm8agE79QlMhtPfpHrvruxEdrlollV9HeF3p0qKD1gNgEP
	B1wkajDGt0mGVT/7MP/IvrGPhTRKp26ebBxEbMHGDl18ulcVx75IsVD8mmH3pfX4lbUDSx0nNpb
	NyR7PA3c2Jq0MY4VUlsVKVpJxRRTFtylb0MIFO5UQdWMjwc3Kig813I+s
X-Received: by 2002:a05:600c:5251:b0:45b:9c97:af8d with SMTP id 5b1f17b1804b1-45dd5b2f7b4mr40271245e9.4.1757084672391;
        Fri, 05 Sep 2025 08:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyTPaDcucOBP/kSmYHv9UTJktIXdM1NsbPCLy4BjRCaedanRNd2ruqH6gwNaw9hHMFpc7wLg==
X-Received: by 2002:a05:600c:5251:b0:45b:9c97:af8d with SMTP id 5b1f17b1804b1-45dd5b2f7b4mr40270835e9.4.1757084671852;
        Fri, 05 Sep 2025 08:04:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd5098292sm51762955e9.1.2025.09.05.08.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:04:31 -0700 (PDT)
Message-ID: <3737e6e5-9569-464c-8cd0-1ec9888be04b@redhat.com>
Date: Fri, 5 Sep 2025 17:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
 <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
 <8b9ee2fe-91ef-4475-905c-cf0943ada720@gmail.com>
 <b56b43c1-d49d-4302-a171-9b00bf9cfa54@redhat.com>
 <8461f6df-a958-4c34-9429-d6696848a145@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8461f6df-a958-4c34-9429-d6696848a145@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 17:01, Usama Arif wrote:
> 
> 
> On 05/09/2025 15:58, David Hildenbrand wrote:
>> On 05.09.25 16:53, Usama Arif wrote:
>>>
>>>
>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>> [...]
>>>>
>>>>>
>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>> so that its considered for splitting.
>>>>
>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>
>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>
>>> Yes, I do this as well, i.e. have a low value from the start.
>>>
>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>
>> I don't really see why we should do that.
>>
>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>
>> Without more magic around our THP toggles (we want less) :)
>>
>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>
> 
> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)

BTW, I was also wondering if we should just always add all THP to the 
deferred split list, and make the split toggle just affect whether we 
process them or not (scan or not).

I mean, as a default we add all of them to the list already right now, 
even though nothing would ever get reclaimed as default.

What's your take?

-- 
Cheers

David / dhildenb


