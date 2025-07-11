Return-Path: <linux-kernel+bounces-728201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FAB02492
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE79A46D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227FE1E1A05;
	Fri, 11 Jul 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeH0a+xl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B91DDA14
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262058; cv=none; b=WzjX0m+hzsCxv+nclkaLYMR0ajo4TFqjemIP4njhW83FGFx+f9ZFxo+4MZCbe3TQ2MthmM+C2mFfnuoOHpK0UuXGI9kzgnW2sIiGT9vqaENmaTvkYDEeof5d/tKCCi3nhJkAhsk3JxAmpifCldxQg/p4SS3ZfVLL2RXvpFL/iFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262058; c=relaxed/simple;
	bh=o8kQUcoIypo+Wb0B73S24QMuadvS6ndUN4Tkfr9maBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI37oETYmg4PlS3dx64RjEQyzeLEzF2ZSsDu4H3N5dKGLOLNydMZedMSgcUiaQpbNkZcxJOgTBykwWRzjtv2rE+xRZHVwtBwSUUuGT1vo5qYHGSuIaXuds0bbMJGqRXaNomW7lAtRkPRBvr4A5l9/PIMldjZnX4+elo2f8KSmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeH0a+xl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752262055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8aVGr02DEmHpwwTwEVg7RrFyhC8NcF8WXoBg7x+eds=;
	b=MeH0a+xlOTzPGYjVQqo4kdmFtMdMZps3o8+72+/BsFqgLJktIFCljzO4IJbuQaJp823RkD
	lkbzIA8gbK/tzjqL1l2XRvGCIOrY+TosDPkhp4WAVXbIhIDLHbrOC6kVRpPz3RlQplxBpS
	hjj5ijFlb5Vo5N10WhPkIT4q+S6g+Xs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-lbxlCWVbNgqPCPsjW0B_NQ-1; Fri, 11 Jul 2025 15:27:34 -0400
X-MC-Unique: lbxlCWVbNgqPCPsjW0B_NQ-1
X-Mimecast-MFC-AGG-ID: lbxlCWVbNgqPCPsjW0B_NQ_1752262052
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45311704d1fso16224155e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262052; x=1752866852;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8aVGr02DEmHpwwTwEVg7RrFyhC8NcF8WXoBg7x+eds=;
        b=umJQJXaC6ZwY0l6l2OsQp9kkzuEKlBMrD97vBSAZI4bWIeSxQFiAHYwHts2fsarEl7
         y1RabXUrzVADAN2K4glIHFRExzGzzeQo2ZFm2ZA4RETUnLClm7fqKI6TWByY1ZRhEhsU
         qpNvklmsRQ/sWphwi25+iGdn4WCRn1Z4oLDUNWx10VkTioi1UN2CoYeP8W9MkhBQDOs0
         qdJ5lZuzdJTd3iJ+qPRdYdPOlK+rDU7hxOrB0+2V3eDIV8lseWgz+y8GPc8hI/o7Efga
         kwva//84UvRnBEPNS/i1lOSdvlONRnBngdoYQXFDHLS49N+YrIXj5yirn5g56ZEKtfQc
         ToPw==
X-Gm-Message-State: AOJu0YwD6UkB9jPhcgBxIK/OuHtupVc7mug/2Gy1Fqq1UiA7z35FTsXL
	aRKJg7xpbhlX3ZRM7tLLyKefQJ37Pd0WTOeIeTBLBMU4613g6r7jKuA75qMpphhHCZI9kHwBzKy
	ow8i6LoQ9Uk7gEbNq8dQd7PSw88k8lnv/TkN9q0lzmjLqQc3UH/Y75bUKwIkVhYZA8Q==
X-Gm-Gg: ASbGnctCL34odBZz0zteDRpVcLiRL50gVrluAsB6EKaVy6ytwIoRXAMTTUE9klF+goi
	aZmmblhFi6VQl1ivcRNQyr3OTZNBFdGzkr8E3JZ+fgHcvras+rBaIt6cyOqWyl9tSBZOKPChAjW
	ur/QHKbCzrZLo2Qvyh7LhcARDjWou+VEny94Wby/DSlamCKmhnPNYwDFOZ+8NK+34H9p2EtSKdL
	4NNYI48HhZ+c8nPQzI9dpOMzhNh5GRM+fmnOpZbjL3gdLM119nlXaM6kdRMuz9gjl6/DdHU4S4x
	6VMYLp1LGhBnkdHS8gbz0yitSOhXtuAq1Lq3naPlfosHcxQFTXZjX7hQI09fRIdOZOOD7O2icKY
	a/pQppPVqNTAcbHDvz6wSZBe4pT1V1QB8hAbuMeRNJq94FFgePDb8GRqTpbsymztmOvo=
X-Received: by 2002:a05:600c:608c:b0:455:f6cd:8719 with SMTP id 5b1f17b1804b1-455f6cd8ac1mr18307655e9.20.1752262052116;
        Fri, 11 Jul 2025 12:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9zy5md3GDRNOHEb1B84FVZsfdNAOdIUjMojXarWTmiKSrtxTj75mCoa58MKlJIOljBIK65w==
X-Received: by 2002:a05:600c:608c:b0:455:f6cd:8719 with SMTP id 5b1f17b1804b1-455f6cd8ac1mr18307385e9.20.1752262051629;
        Fri, 11 Jul 2025 12:27:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c? (p200300d82f0a2e0089cbc7f082f2e43c.dip0.t-ipconnect.de. [2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537932sm55615205e9.20.2025.07.11.12.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:27:30 -0700 (PDT)
Message-ID: <4253b58b-374d-40b4-87d8-f66926d65676@redhat.com>
Date: Fri, 11 Jul 2025 21:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] x86/mm: Simplify clear_page_*
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-11-ankur.a.arora@oracle.com>
 <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com> <874iviprkf.fsf@oracle.com>
 <d258c487-29c5-4e1b-b5ec-911def6c850c@redhat.com> <87tt3imsxn.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87tt3imsxn.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 21:24, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 11.07.25 19:26, Ankur Arora wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>>> clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
>>>>> variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
>>>>> free when using RETHUNK speculative execution mitigations.)
>>>>> Fixup and rename clear_page_orig() to adapt to the changed calling
>>>>> convention.
>>>>> And, add a comment from Dave Hansen detailing various clearing mechanisms
>>>>> used in clear_page().
>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>> ---
>>>>>     arch/x86/include/asm/page_32.h |  6 +++++
>>>>>     arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
>>>>>     arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
>>>>>     3 files changed, 46 insertions(+), 41 deletions(-)
>>>>> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
>>>>> index 0c623706cb7e..a8ff43bb9652 100644
>>>>> --- a/arch/x86/include/asm/page_32.h
>>>>> +++ b/arch/x86/include/asm/page_32.h
>>>>> @@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
>>>>>       #include <linux/string.h>
>>>>>     +/*
>>>>
>>>> /** if this was supposed to be kernel doc (which it looks like it is)
>>>>
>>>>> + * clear_page() - clear kernel page.
>>>>
>>>> "clear a kernel page"
>>>>
>>>> Although I am not sure what a "kernel page" is.
>>>>
>>>> Did you mean "clear a page using a kernel virtual address" ?
>>> Thanks. Yes, this makes way more sense.
>>
>> FWIW, most clear_user_page() will just call clear_page(). The ones that don't,
>> have to deal with the dcache flushing, as the page might have cache alias from
>> another (mm) address space.
>>
>> So clear_page() is just about clearing page content using a kernel virtual
>> address, and clear_user_page() is additionally taking care of any dcache
>> aliases.
> 
> Yeah that's a good point.
> 
> Right now I'm assuming that clear_user_page() and clear_page() are
> effectively identical. Which as you say, isn't true for all the
> architectures that can't disambiguate dcache aliases.
> 
> So maybe I should be adjusting the naming of the helpers a bit?
> 
> Specifically, by calling clear_user_pages() from clear_pages_resched().
> Which on x86 etc can just call clear_pages().

Right, and calling it from folio_zero_user() :)

-- 
Cheers,

David / dhildenb


