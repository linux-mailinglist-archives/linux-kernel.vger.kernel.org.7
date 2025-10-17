Return-Path: <linux-kernel+bounces-857540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5CEBE7107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF1F1897795
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812226CE32;
	Fri, 17 Oct 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYr1TFWO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2126B0B3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688687; cv=none; b=d9biMQfdifAJWRQf0gUa34T+T5olM+iDRKOylPXDLUh4oKZunh6gwMQL7fkAGUTJfDqMRskQAqI58LvrfbOAd1asEsf2o0a6eQmQ0ZHq3/zqGbUB7CD0umCfR+OIwNBATx6wvOUHRNKm3fYedJ7LW3WO5EgQcr98kKf9ATNCGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688687; c=relaxed/simple;
	bh=E8z6p+TaM7HdLmCjJopAYyW7L8IPatj6HbVfLkQ+fdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVd8NcmBkWOu7pbSV6NpdLKElxu41Ni2d6CSW3mO4qdBlG0zXb+82o4e28WcfZkR7aJaQaEnz75+aQzL4HOi4ZnI782PiTqpiKbH8YDrwLIvVxbvvmpKn337w9ljvb4ac4HNZlvniRIe0vGuJ1O/hMOXHfGkqF2H1dUfzRQtjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYr1TFWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760688684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jIfah+DAlEvXgjhi6Yuk+QGMNGhgMkvImu+g/AK8D6k=;
	b=MYr1TFWOJfO6Vqx6SY2QBJxQ6mWFB1iGH9MarofAWE7+fIccFFyTi2zD0lvdvYGi9HScI5
	HwuiefF4sRQg6cYo/dLI4SfWOGvA58xPykXRT0O1Pi3YufBp5Z5mU2JnlwSTcsOiQedztm
	hD5NCbYsj/RuSCmsSa8VmhBVst6WhiU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-JG5fMU63NKyoLIC7p_7jfg-1; Fri, 17 Oct 2025 04:11:22 -0400
X-MC-Unique: JG5fMU63NKyoLIC7p_7jfg-1
X-Mimecast-MFC-AGG-ID: JG5fMU63NKyoLIC7p_7jfg_1760688682
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42700160169so915597f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688681; x=1761293481;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIfah+DAlEvXgjhi6Yuk+QGMNGhgMkvImu+g/AK8D6k=;
        b=EIvFN0PNTVPFRM5+lVAshaIZetqyrgJ7fRVsz0rCs/ZauT7NTuh0AYVfbtoeKWlIFV
         UcHTAFsDcV7hIbIYcKVPxPU4TaESV0VBWGi0yf1Iu7qRaQf3mlyEt63jRA0vW5L++FBU
         BdA4XupA64v+7NUZuz6cKMm7YEnVuqPga8frYV9So88/NzjJ9Yvph9MfMlJHpHzkOY9+
         vHoqniT8UT/JT8xESodk4lktZb9VtFBEiYd1MAA7UBKikL8XMKUHZ6XmE/bhh+jkq59N
         gs964e+2/I/OTMOE9qZSuStMlQEE/Uj2zJU7VzdzAiXRaU441+xTXIk1L7klMWnvTlne
         7Vww==
X-Forwarded-Encrypted: i=1; AJvYcCVx8VQNZBlDHpdTT+nAu7XOaj3+czbS2gFAz733fxW8opVOlvuT17sIQCZ5amYr81pF9dZ6Q5iKVi6/QyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyte5fzDdEyDNqE1Tggj2EETXJI4XegdhAGji9GXivsQXfpCOEG
	JoJE6GH8eCJ969cSpg+xpcMce6KXeFTYrO4iIH2mWwban1ORv9cjkxTeR8QL2KUjwquuMfCTJ6W
	fKJIo4NjsPBCQS+fCH/nLqwcciDl6ErwR1rtUp4GuBYCK2dPz4KyunCHQrnY5ZWYnRQ==
X-Gm-Gg: ASbGnctZzexld9Jgr4vDeTwYE8VSLv3uHn+osyqSf10usq+lJKKR5WPMAgAP6kCA2Qd
	Ly1ZQ2pg17k+g4RuqLT4W3a/IENaZa0ammSDnocoNsHj/K4Arudc14IbqE2tcFLI2M+SgkntBK2
	X5j/57/Rst+jn2EIVIPbZkKIhZUh32C21OhDJ6DxLZI4SQlka2+GviXFunpaHTiuk8J+F24W9Ad
	v0AWouexg93+Qz7hTNQrQCPjUlH7GnRpfeGzQKTRNfRL6iKSxafQJZ0m3FYzSMcFpLSatBEdOSw
	1Z6rBu2ZxCrTXK7Asw4eX/EZFUz/shpt6EqaWtb7TIaXmxmWZeM7tB53BYnlpLCb0kt6+lT3xOS
	E7W2u5mKzQD9xiNDji363bIYMX4UXF1+WLz26a4/puAqqhM3NqbDUV5CmZWK/EfFlw1rRT4Y+ZZ
	ZgJZKVW/8aE3jeXx83+EB3aAKGLRU=
X-Received: by 2002:a5d:5d0a:0:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-42704d98e81mr1969213f8f.35.1760688681568;
        Fri, 17 Oct 2025 01:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Cf7VNT+2WeB9mtccilKeaUe8M81gPubmwyVKHVTEOMjRsMb6naQEgT4+IDSbNebxQTfcaQ==
X-Received: by 2002:a5d:5d0a:0:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-42704d98e81mr1969188f8f.35.1760688681150;
        Fri, 17 Oct 2025 01:11:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4270539be85sm4087942f8f.7.2025.10.17.01.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:11:20 -0700 (PDT)
Message-ID: <1674efca-6d4e-4247-8b1c-b6816360d8bb@redhat.com>
Date: Fri, 17 Oct 2025 10:11:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
To: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
 <20251017012724.4bo5oj2g6tdmp2fv@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251017012724.4bo5oj2g6tdmp2fv@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 03:27, Wei Yang wrote:
> On Thu, Oct 16, 2025 at 11:47:06AM +0530, Dev Jain wrote:
>>
>> On 16/10/25 9:06 am, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> A non-present entry, like a swap PTE, contains completely different data
>>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>>> non-present entry, it will spit out a junk PFN.
>>>
>>> What if that junk PFN happens to match the zeropage's PFN by sheer
>>> chance? While really unlikely, this would be really bad if it did.
>>>
>>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>>> in khugepaged.c are properly guarded by a pte_present() check.
>>>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>    mm/khugepaged.c | 13 ++++++++-----
>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index d635d821f611..0341c3d13e9e 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>>    		pte_t pteval = ptep_get(_pte);
>>>    		unsigned long pfn;
>>> -		if (pte_none(pteval))
>>> +		if (!pte_present(pteval))
>>>    			continue;
>>>    		pfn = pte_pfn(pteval);
>>>    		if (is_zero_pfn(pfn))
>>> @@ -690,9 +690,10 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>>    	     address += nr_ptes * PAGE_SIZE) {
>>>    		nr_ptes = 1;
>>>    		pteval = ptep_get(_pte);
>>> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>> +		if (pte_none(pteval) ||
>>> +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>>    			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>> -			if (is_zero_pfn(pte_pfn(pteval))) {
>>> +			if (!pte_none(pteval)) {
>>
>> Could save a level of indentation by saying
>> if (pte_none(pteval))
>>     continue;
>>
> 
> Vote for this :-)

I suspect there will be a v2, correct?

-- 
Cheers

David / dhildenb


