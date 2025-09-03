Return-Path: <linux-kernel+bounces-797990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8469B4181E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785401691F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC432E7BDA;
	Wed,  3 Sep 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzSD886z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D32D8DBD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887222; cv=none; b=irjQ/3RTvOluX/tBjsQOBd6w+mL4zShqRfxmkcniPTFV/dxDOdZTZ7z/TAe5ZjnYWk8sGM/Rf+OhMnfrG3LlpMnNfHQOfAvck1T8apAYG2jiJXZnPxANq4AubXfG4B5mf+0sFqFnRcK+JN8qKgTFqWdvrrVv41L57hrvnQ08JRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887222; c=relaxed/simple;
	bh=1EZ620hwokL/moW7R2uQ6sse0e1i48ft0Dl7T5PyA90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMyoPBOD27NzpkMfxLyHruKPKNBbQpyt9n96o+f1C80qdrtobXqKKjyjqRUGqQQj+ENpD70dQmvuIOU7M1JEgJVNxTXM+Qb19hHzpVvmd5EOO6/cOr6L6orCQFbCaOxKJWxg0raChr4fUb/vOsN4OmGQQcsW3bARbrmasonmx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzSD886z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5T13e6DDVQ5mlidba2ps1Pa0u8cV/VpPy+cX77T2t/U=;
	b=PzSD886zfZfEptt5NJfHbuxNxP2MggGZXyb1o9coxXdLO8euBGMWBgu2WrNWD5przs42CI
	AxEMeA50AspM6FOz5lRcfJXritEajy1+WrvhwHPnPwx+mZQdGoKtVYWQxIq3XJFWPnPcrh
	72apnMbdsF++ZUu2gdjkqR4Xxbw5vS8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-fMb-m0YUOH-xokoshkT9Hw-1; Wed, 03 Sep 2025 04:13:39 -0400
X-MC-Unique: fMb-m0YUOH-xokoshkT9Hw-1
X-Mimecast-MFC-AGG-ID: fMb-m0YUOH-xokoshkT9Hw_1756887218
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7c01a6d3so34531265e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887218; x=1757492018;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5T13e6DDVQ5mlidba2ps1Pa0u8cV/VpPy+cX77T2t/U=;
        b=KjBvu+XYuFMSgsGmYBDFADasndNOAaVz7+WvuI/mCz+3KEmeEOofMvS1YaHiwukkL2
         vqfSEtHMtnl5JoY9JeBfwefp3gn03xp+yaN2+V/shxrS0pexlocjyZoSveWZS3fFcnkS
         A2S/3OGCvB2/9UGSvRE8+sG0tjITIdCVaJvaI7VFFsWGK8zd8IQEEniQ+gLI5FHDDZ2A
         lTb7jG1vcoL97D+7HJW/ejttaz5M1Vzwe4aplMR31t8llFiS3+Tlj8G5iobSlsydL4Qs
         PrOJeectVmzJaXFI62OWVbdkZvPVzXROdXBjssh/eqvlGlwHo0gwHpEVQW+mZ+iRM09v
         X2nw==
X-Forwarded-Encrypted: i=1; AJvYcCXZOKomuI/vH8TqkYDM9WCThgfjOn01vW1wO31m6NYtL5KNw4pUjAr+dfGztc0UbtuOL73iZgfTZQ1h+V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfOLn/NBAYVF9U8Ysa4x0wx1fXBmSFydn984XkYHtHY0xjSCz
	2iKmkiWJwgo5UzSVJOmjgPV3DFxFcmJisQFrd+HQNE2c3K6W4WphUiSazUfGGnCVS0w01A/18zh
	rIOmWuRSvQo38UGEgC/6jd31iabF2n8VSAf2h928bijvj1tuKzN+jx7NsLyTImWBLZQ==
X-Gm-Gg: ASbGncsBhukdQuUc2jGZG4y+aM2jofSbTaejrOMjX0jLWk18AI0DVF17Z6GFRbi8zhR
	DxV2YOR1LlKxmnV5VdPUawFt/YSxrZlSfDcQJIW+AhALjXzqPLQLSUfEAgggB1794k9JMqpsWHf
	kEKHcVRxoZPsMsqD3SsyhZNneK9Mc+sRrxWK9YMM9BRM3eDP9vcHJVn4gBCzRpx8FlVfMPbt6kD
	XluV8lqoc/F1eGOGAu5edt3Nd5+PQ8ulApHBiQ9RybmOIArAtfuG32RQ/u16M2sTS6cDxx4vsV9
	RLEJNcSBI54oJJPISH+bdatWq3SyYZ6teJq9iQzdl/rOT67EUujgHHCwzMxz4e003GCDW3a1LZW
	tBjVvb10fqQ6KOFJ7Ixq7MhyGuAP+xA4Up6UsF1StUW1FFWDy7hR9yMWoC2xAiJeT4MA=
X-Received: by 2002:a05:600c:4816:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45b8555e01emr72709685e9.13.1756887217699;
        Wed, 03 Sep 2025 01:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEypdG3WMnPu1Akg1ScMhfh0zsYVs5yyCGaHvvaGEjUQUmSxY1wD4AvNm+x1sllQB+cOt5EMA==
X-Received: by 2002:a05:600c:4816:b0:459:d3d0:650e with SMTP id 5b1f17b1804b1-45b8555e01emr72709435e9.13.1756887217245;
        Wed, 03 Sep 2025 01:13:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm313894595e9.14.2025.09.03.01.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:13:36 -0700 (PDT)
Message-ID: <759bff7a-3918-41ac-a184-8c07ec414bb2@redhat.com>
Date: Wed, 3 Sep 2025 10:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
To: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, kas@kernel.org, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903080839.wuivg2u7smyuxo5e@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 10:08, Wei Yang wrote:
> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>> Currently khugepaged does not collapse a region which does not have a
>> single writable page. This is wasteful since non-writable VMAs mapped by
>> the application won't benefit from THP collapse. Therefore, remove this
>> restriction and allow khugepaged to collapse a VMA with arbitrary
>> protections.
>>
>> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
>> non-writable VMA, and this restriction is nowhere to be found on the
>> manpage - the restriction itself sounds wrong to me since the user knows
>> the protection of the memory it has mapped, so collapsing read-only
>> memory via madvise() should be a choice of the user which shouldn't
>> be overriden by the kernel.
>>
>> On an arm64 machine, an average of 5% improvement is seen on some mmtests
>> benchmarks, particularly hackbench, with a maximum improvement of 12%.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
> [...]
>> mm/khugepaged.c | 9 ++-------
>> 1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 4ec324a4c1fe..a0f1df2a7ae6 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>> 			writable = true;
>> 	}
>>
>> -	if (unlikely(!writable)) {
>> -		result = SCAN_PAGE_RO;
>> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
> 
> Would this cause more memory usage in system?
> 
> For example, one application would fork itself many times. It executable area
> is read only, so all of them share one copy in memory.
> 
> Now we may collapse the range and create one copy for each process.
> 
> Ok, we have max_ptes_shared, while if some ptes are none, could it still do
> collapse?

The max_ptes_shared check should handle that, so I don't immediately see 
a problem with that.

When I thought about the "why is this writable check there" in the past, 
I thought that maybe it was "smarter" to use THP where people are 
actually using that memory for writing (writing heap etc).

But I can understand that some pure r/o users exists that can benefit as 
well.

-- 
Cheers

David / dhildenb


