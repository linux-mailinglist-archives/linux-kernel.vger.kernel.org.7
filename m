Return-Path: <linux-kernel+bounces-649300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF7AB82B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED528C5DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FE28466F;
	Thu, 15 May 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVKZozNq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F829615A
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301550; cv=none; b=DvZ2ZWN13ukin+RqEZ1O54kHCcZK2P83EGDpmspaa7ld/jPR2i+c15MlZwQ2X3bHXwfdds6Y6wTVHLxfgJgOJ1vMYgIpD2Lt7X9kDTGVypfTsoKgVOd307LsuRpPsmbA4huAOiVbOzThFPihMOXqKTwuI+VMUAjfs8m6y6xAB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301550; c=relaxed/simple;
	bh=SaMLanRwRbiuoI6sV8y2cQ0VCP4NMzTzL+AqFQvBHpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdTaQek5oBps8+ODLGIgOrf92KIoci3y6joPPLGmdcqHRVlzGLYhbTU9fkNlU2psRqWZqyrb/8lFwK1ExdcIOLMyNeRknTatTnIfrcLPvYZ3quBq2hRf5Tq6mVoivjUn0j3ZbmlNN1osqgHcaMaynzKSNX/mYNUmF8DKixtGj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVKZozNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747301547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oItitg8Z5dZXMX4qx++KSjKZ15vTx3/yC4NQ+s35qp4=;
	b=MVKZozNqppwRdGwTWS38151eF/fdlpwfg+DuAVQZN+C7APF3t8tH1D6/kFsgCPT7rIS47k
	Ep4nBlPfIOMrbMHTEzGOPMONIpU/NK6t7i2p7PtdymZMG3GbpAigapGRh9m6fQK6TltjVK
	ADzi5z19tN4DU6/seUmeDfW14oO249g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-zQnfFFchPLaOKELJXwszEQ-1; Thu, 15 May 2025 05:32:26 -0400
X-MC-Unique: zQnfFFchPLaOKELJXwszEQ-1
X-Mimecast-MFC-AGG-ID: zQnfFFchPLaOKELJXwszEQ_1747301545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b6cb5606so411788f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747301545; x=1747906345;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oItitg8Z5dZXMX4qx++KSjKZ15vTx3/yC4NQ+s35qp4=;
        b=JQ5JRHAyrX6N1c492Fg4rP9kDvKETlShg6dMVlhvdCWjFt8MI6nW8++UQ1BgTvLim1
         hfr/FsyPomVkycGVvmJU/Btoip2awtWB0LPoQcGkqaF6A7kznHzxEa5GUBsuTHAzsxmJ
         KnLwiyrngmJ9lmGa0aAtfOLgN/hT9a3IQNM/xVJrIktRDBHz/wN669SX8EWGmTpOIrta
         EgrYgZeshhQmcKqlW08s5oaC1HDKY/6ae0QvH/ybff4N9kaiSTuC9bNt8OUIleerX0jx
         a/XHkk5dUEhWPJYsKNJLk1LkhLEnqS7/wvAgK/o/I5rVHixbj+QqTq8bmuA16ZDtIaal
         SRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbC1qng8MXPIm646Jhb3D1ZsDmLyF4u5I7dGfiOEcjioI6ZrlumG1fISUntCF5uj6Cm6J0cPWW1x3rjz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQO0KSQb/bxXTQnkIyOwtw3ip+0yWg9r5NBoSSi2TEqmupM5zO
	46AZBdjhToy2plbShi3FqgsNKtMm0EFUWtCRe7LteOQI3gnpNWanHPKBD8WHBikvLtwW8a/iChM
	zavaRA/0vc2eM6T7OoYYQVEft7ycNaFjOwNIc/FcduUNTfgp6Bv56DkpTm6Fx5g==
X-Gm-Gg: ASbGnctFCxq1N0r/+POiskKwZHFHEM7j8nqGX6uEbvKx9pmeXBogAW7VD973JNBk+ha
	2mzonhKYU8v+Dsm+vv8Sltt9eJCzcjizdbl7zID8K7OAJLdF2PwVl4El20/33Yh1W1shxcyS6eh
	9EuSlafQJUfq+3t8hNEzfdueoHxFTHOcJr52OfnAQzLHoveVJkXgmuR0nuaaEyXPRnL6tz1DET+
	HMdOg/WfLZWNchtLzVUaLyzOmK8bCVkZjpcFJjcm48nXj9k81c3IJvYz6HIdX438q8FMWjihlnB
	ht5Qn9JBn4n/L6iZ4JsSOlZ97n3kzAhkx37stwVN5Ef8EDdszCPDFzJ0b1X7jg6c3XXBm4pnX/B
	1hBdkYkN7xCkvPaC2CjBU9u9bArTfxehXotpDLjA=
X-Received: by 2002:a05:6000:430d:b0:3a0:b9a8:b94c with SMTP id ffacd0b85a97d-3a34994c044mr5395634f8f.50.1747301544826;
        Thu, 15 May 2025 02:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcItxdHzBx5QzO1HhO++1GGOSuhmIUBDGjEXVSFkIcYwc4ODVC6maoVYAxWIGFcYbGfTAGAw==
X-Received: by 2002:a05:6000:430d:b0:3a0:b9a8:b94c with SMTP id ffacd0b85a97d-3a34994c044mr5395607f8f.50.1747301544379;
        Thu, 15 May 2025 02:32:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:8900:884a:b3af:e3c9:ec88? (p200300d82f4a8900884ab3afe3c9ec88.dip0.t-ipconnect.de. [2003:d8:2f4a:8900:884a:b3af:e3c9:ec88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd53sm22111507f8f.1.2025.05.15.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:32:23 -0700 (PDT)
Message-ID: <a005b0c3-861f-4e73-a747-91e0a15c85de@redhat.com>
Date: Thu, 15 May 2025 11:32:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
 <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
 <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
 <91fc96c3-4931-4f07-a0a9-507ac7b5ae6d@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <91fc96c3-4931-4f07-a0a9-507ac7b5ae6d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.05.25 11:27, Dev Jain wrote:
> 
> 
> On 15/05/25 2:23 pm, David Hildenbrand wrote:
>> On 15.05.25 10:47, Dev Jain wrote:
>>>
>>>
>>> On 15/05/25 2:06 pm, David Hildenbrand wrote:
>>>> On 15.05.25 10:22, Dev Jain wrote:
>>>>>
>>>>>
>>>>> On 15/05/25 1:43 pm, David Hildenbrand wrote:
>>>>>> On 15.05.25 08:34, Dev Jain wrote:
>>>>>>> Commit 9c006972c3fe removes the pxd_present() checks because the
>>>>>>> caller
>>>>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
>>>>>>> only
>>>>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd
>>>>>>> through
>>>>>>> pmd_free_pte_page(), wherein the pmd may be none.
>>>>>> The commit states: "The core code already has a check for pXd_none()",
>>>>>> so I assume that assumption was not true in all cases?
>>>>>>
>>>>>> Should that one problematic caller then check for pmd_none() instead?
>>>>>
>>>>>     From what I could gather of Will's commit message, my
>>>>> interpretation is
>>>>> that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
>>>>> These individually check for pxd_present():
>>>>>
>>>>> if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>>>>       return 0;
>>>>>
>>>>> The problem is that vmap_try_huge_pud will also iterate on pte entries.
>>>>> So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
>>>>> may encounter a none pmd and trigger a WARN.
>>>>
>>>> Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
>>>>
>>>> I assume we should either have an explicit pmd_none() check in
>>>> pud_free_pmd_page() before calling pmd_free_pte_page(), or one in
>>>> pmd_free_pte_page().
>>>>
>>>> With your patch, we'd be calling pte_free_kernel() on a NULL pointer,
>>>> which sounds wrong -- unless I am missing something important.
>>>
>>> Ah thanks, you seem to be right. We will be extracting table from a none
>>> pmd. Perhaps we should still bail out for !pxd_present() but without the
>>> warning, which the fix commit used to do.
>>
>> Right. We just make sure that all callers of pmd_free_pte_page() already
>> check for it.
>>
>> I'd just do something like:
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 8fcf59ba39db7..e98dd7af147d5 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1274,10 +1274,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long
>> addr)
>>
>>           pmd = READ_ONCE(*pmdp);
>>
>> -       if (!pmd_table(pmd)) {
>> -               VM_WARN_ON(1);
>> -               return 1;
>> -       }
>> +       VM_WARN_ON(!pmd_present(pmd));
>> +       VM_WARN_ON(!pmd_table(pmd));
> 
> And also return 1?

I'll leave that to Catalin + Will.

I'm not a friend for adding runtime-overhead for soemthing that should 
not happen and be caught early during testing -> VM_WARN_ON_ONCE().

> Also we should BUG_ON(!pmd_present(pmd)) to avoid the null dereference?

Definitely no BUG_ON :)

> 
>>
>>           table = pte_offset_kernel(pmdp, addr);
>>           pmd_clear(pmdp);
>> @@ -1305,7 +1303,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long
>> addr)
>>           next = addr;
>>           end = addr + PUD_SIZE;
>>           do {
>> -               pmd_free_pte_page(pmdp, next);
>> +               if (pmd_present(*pmdp))
>> +                       pmd_free_pte_page(pmdp, next);
> 
> Ah yes, the "caller" of pmd_free_pte_page() is not only
> vmap_try_huge_pmd but this also...my mind has been foggy lately...
> need to solve a math problem or two to sharpen it :)

Haha.

-- 
Cheers,

David / dhildenb


