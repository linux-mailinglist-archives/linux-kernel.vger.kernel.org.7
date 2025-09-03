Return-Path: <linux-kernel+bounces-798129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EDB419D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AA21BA0EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B562E229E;
	Wed,  3 Sep 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZg+m0hB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBE255E26
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891338; cv=none; b=dT6J9nIkJxt55Wz8zpssD1fkCtyXVvWtTOMu8S6AstWRyGL5Y8romR+oSeoHnRF0DrI/93ghEJRsDvxCY10skxMFwziuS2zxMmg3Ggk2eZUZm22cbq7Z6pMRaI8moKBUJ2uWseeyxCG4SrRPoqDhpsjkUUaOzAuYShbrx+7L96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891338; c=relaxed/simple;
	bh=Ri4qSvGCgEoNOkX8g+sKEytig3BO3cjBCMPocMeM5Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKSPmW0qhYmw+Bd5LvDa4wwzV8mhQ6u0urjm43bIHxJ3oTL2/lnwH/JdxGJOP6n7fRR6DV+fin8V6xpNgVrFdA3DPdOLynznRfv/gnwvJdK7JCcA7EnfzTPKbVs5bPwW1quOF0WIvm1aiyYz1CBaSj1eP/4ZlFadZJkrHGnYdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZg+m0hB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756891335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0FPh5XZdEAd+Tv8vDi5Fj27lr8KTz0TZ6Jk5W1QXK8=;
	b=DZg+m0hBQsBT+CUHYBetRPREc/MlooJg6xKnmCCU3L1807W4NrQqUvPEKm1ziXKFqBwB9Q
	hX0q8t+yrAn8jD3fYEUxBpd/X5HkqBIQcXWNr0D1+6+weN4V//0rBZ1E7NTCsX8z6wtjd7
	aYSB4kU3uRP/52pBdzPIMA+j8Bd6cMw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-0mXAut1MM5msi3P1RN0Xmw-1; Wed, 03 Sep 2025 05:22:13 -0400
X-MC-Unique: 0mXAut1MM5msi3P1RN0Xmw-1
X-Mimecast-MFC-AGG-ID: 0mXAut1MM5msi3P1RN0Xmw_1756891332
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so9974525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891332; x=1757496132;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0FPh5XZdEAd+Tv8vDi5Fj27lr8KTz0TZ6Jk5W1QXK8=;
        b=KMAyxJ9/5vUNBnGymxnE6PVQoTMFWl4qnXm3yp1aFRlwraZgFa3rOBSjxSA+UIcDv6
         4rxU1yHD1htCzJmXH+X4rWVZwDHr8kC8BpEOYZeE+Osot8PD25iOJmBVCEvZnNwSTF9U
         Xb12OK2y99UtOpFypfYtvkTbXcbZ/xGp59rqAfea9wsFQZ0bqY5plEW+2lz4KRP/+dRD
         7NXJVWLC5VkqiOOKHQiIJ8WGFiT2wEwSYVpqQ/YP9qCPqKcNu7wmLT98NOR534lDmd6O
         9oQLkPQtiQ16Ct2e3Ih0Ciw7vvMn0RnLfMJur+RrhnJvUulSg28s3j2bUX6bN/8d0+Go
         KttQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNH70uEeRBFiv/OrrMPP3qU76RyLUf/n5QlfxNdItAEzHtLBmHEO4Nj9qeDkOPljuBOhwkrCKX+I6rvjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jWyKIrpW3wXQd0VRet4yyhm4S3Z5wuCv3yj3JNbrtQxO/pWx
	BksnAIolrisoEETPmO1FhdocJ6+AzLBhAahcTSzbj9Osu8ZBoSZOJZXq4VWbp4GSA9ZfKlrf5Mn
	3lBUtjFynQprmZ9U1/CSTwubr6CYhv9VtGu1F3U+BnjI5zVLhXxc8mmLtRxUTUifmxA==
X-Gm-Gg: ASbGnct9gnnyBO+fGmipioNr6kZL2OQLwSNrvssb4orkb+CV4CeaaXtixtNRsxkjTGc
	s0OsZypCWrfzJvmqq39yFWsKNXGAHAT5ka+riMn1Dg8C0QH85VH77sBd2JnoBlXmndp+OIMdmb+
	fjNlNeV83pHRhTjR8UGYPasfVazOb4YTTyFbWCF8DxN2Zl6SvQPN8a8bc4z5oL/qMmxUaPlXqqC
	BO8h+ZQW0xfWFb1mOayI+cj57PWjFvrhHi0UczXSkJcgW6qfvRe0379AwcU3cvNdfSNmrgteXZl
	gvgwdLY95ftgX3AYG2oZqzHbSqnI4Jdcq69/xym/+wINJxIcykGlwApeGc/nIn4IQfI2ME5KicO
	xiz5veY9KjItzGQAVNn0YB8pBnsnOrY4rPQUZcm/1GvjiR1yny418zVnKHiOoHIc64b0=
X-Received: by 2002:a05:600c:46c5:b0:45b:8477:de1a with SMTP id 5b1f17b1804b1-45b8553f190mr114776425e9.7.1756891332349;
        Wed, 03 Sep 2025 02:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyTITMyA6nVzMKbQzFQh0ovQa5Cva0N2A6qZKj+3NSqQ+k4TdT5orYCpErVlCrii0lBjSVnA==
X-Received: by 2002:a05:600c:46c5:b0:45b:8477:de1a with SMTP id 5b1f17b1804b1-45b8553f190mr114776085e9.7.1756891331912;
        Wed, 03 Sep 2025 02:22:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm231483255e9.19.2025.09.03.02.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:22:11 -0700 (PDT)
Message-ID: <99f8cb5e-828a-444c-b207-2a12e13a45f5@redhat.com>
Date: Wed, 3 Sep 2025 11:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
To: Dev Jain <dev.jain@arm.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, kas@kernel.org, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
 <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
 <3bd9ff5d-de8a-469f-a7b0-41c192b23993@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3bd9ff5d-de8a-469f-a7b0-41c192b23993@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.09.25 11:18, Dev Jain wrote:
> 
> On 03/09/25 2:45 pm, Dev Jain wrote:
>>
>> On 03/09/25 1:38 pm, Wei Yang wrote:
>>> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>>>> Currently khugepaged does not collapse a region which does not have a
>>>> single writable page. This is wasteful since non-writable VMAs
>>>> mapped by
>>>> the application won't benefit from THP collapse. Therefore, remove this
>>>> restriction and allow khugepaged to collapse a VMA with arbitrary
>>>> protections.
>>>>
>>>> Along with this, currently MADV_COLLAPSE does not perform a collapse
>>>> on a
>>>> non-writable VMA, and this restriction is nowhere to be found on the
>>>> manpage - the restriction itself sounds wrong to me since the user
>>>> knows
>>>> the protection of the memory it has mapped, so collapsing read-only
>>>> memory via madvise() should be a choice of the user which shouldn't
>>>> be overriden by the kernel.
>>>>
>>>> On an arm64 machine, an average of 5% improvement is seen on some
>>>> mmtests
>>>> benchmarks, particularly hackbench, with a maximum improvement of 12%.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>> [...]
>>>> mm/khugepaged.c | 9 ++-------
>>>> 1 file changed, 2 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 4ec324a4c1fe..a0f1df2a7ae6 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct
>>>> vm_area_struct *vma,
>>>>              writable = true;
>>>>      }
>>>>
>>>> -    if (unlikely(!writable)) {
>>>> -        result = SCAN_PAGE_RO;
>>>> -    } else if (unlikely(cc->is_khugepaged && !referenced)) {
>>> Would this cause more memory usage in system?
>>>
>>> For example, one application would fork itself many times. It
>>> executable area
>>> is read only, so all of them share one copy in memory.
>>>
>>> Now we may collapse the range and create one copy for each process.
>>>
>>> Ok, we have max_ptes_shared, while if some ptes are none, could it
>>> still do
>>> collapse?
>>>
>>> Maybe this is not realistic, just curious.
>>
>> Misunderstood your concern - you mean to say that a parent forks and
>> the children
>> VMAs are read-only pointing to the pages which were mapped by parent.
>> Hmm.
> 
> I meant to say, writable VMAs with wrprotected ptes. Maybe after this
> patch, people
> 
> can finally make some real use of the max_ptes_shared tunable :)

I hope not, because it should be burned with fire, lol :)

-- 
Cheers

David / dhildenb


