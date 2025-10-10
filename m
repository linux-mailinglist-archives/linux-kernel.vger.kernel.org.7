Return-Path: <linux-kernel+bounces-848252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A26BCD02D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53FD1A61112
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0F1F03D2;
	Fri, 10 Oct 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSKQkQy8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608B1C5F27
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101424; cv=none; b=qgCLNFKYMInFbk8fOkPOdhg72yXAe+i5MaesLpJtUzZaFPA1iw9GLO8UZWmOlSoxlWfHVv3xOLIz1BLbxveyu9AW2LgBaMZMMNr+mECz1Mw1B9XUV890naB/N7Gs5d5/SE5mXZWiTtd3U9q3iLNUGXsKc0O1cQCG7lvBNLMuN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101424; c=relaxed/simple;
	bh=Ci4uMy3frjQ6gWLNHL5OI/mlqEk0ybgRF+hJuNHgY4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nBKdQbrRs+E/MI7t9INMXnIi+6gJHDnO8hpV99+IMgafS8r/WFf5OoijLEu/i+OfMr1FBXrF0Lx3vjCKuZlGgZyNotE5fOv/bWgGKs0bWaKCD66WAlIVn17hCX1C3HEpITsg8uoLZox2HNkxa2yPJ80zWMkh6RPKw0pkcBhYu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSKQkQy8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760101421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kLnJfjYIG2+S7xMFcE+UUjhAp4kmavKfu1V0DmDwxRU=;
	b=bSKQkQy8D74KL6JykZauZIKD2s2vVaqkboU0znaSU2XluFTk3KRtMdn8AZ4DJnlZAHmBF9
	v6jnfg3wSdjzmKEEd8pM8f3hTcqqjNi0FjbzRYCXHABg9QojtXBSZbIwGtWci6JQ3mAVvX
	5MNeuKPylP6PERJPxoVgCOuROJ/+YAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-8V1H9On-PlyB_qDypdd4fg-1; Fri, 10 Oct 2025 09:03:40 -0400
X-MC-Unique: 8V1H9On-PlyB_qDypdd4fg-1
X-Mimecast-MFC-AGG-ID: 8V1H9On-PlyB_qDypdd4fg_1760101419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so10529175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101419; x=1760706219;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLnJfjYIG2+S7xMFcE+UUjhAp4kmavKfu1V0DmDwxRU=;
        b=O1BI778DKGLLBIGvvlZtFzTKMgn+9OvORhByJ4Q7mVIcWOl5iWghwSNXhaLhFLKP3y
         kK0vRo7X+FBCZhewO15aQsfW+L2vlmoFy0vCKhhal9diQ/yblq7jhAzeqtP85QRRtKlr
         6EQIsC3I2eqct3JBQ9beTtCLfFXwtdkNTjQj6zo3DVICWkqkQ5WC50FknkTk5i0S+Ob/
         WjicMzIRMh2LjR0Jazt20LVF8WpKRVpBtP9nYNhChA8Y6YQPJ8mp+55V/TBXtEerw+Hc
         enoC2B6TXTZ/50jSZ9323bROByIjFywcBmQ+V1aGDbVtlKDTuvEbPlC7qwafBGhZ9hZb
         UGUA==
X-Gm-Message-State: AOJu0YwHdjg36Dkbd48T+kr/SUTDyuQoE5MbNApAQzyhlYNVRRcmvhzF
	x878WHcogEMoPj3FcOPnJJY2npU87t8ufcY9vubktT0873eEHzM0meISQujzNNIT0xOhdrO0JrC
	SqWDvWGeK6MetFAAE6MvPWtqIYmNH01aaAzdko5GdEnkxMFzczMUZna6OymGQoR6bLQ==
X-Gm-Gg: ASbGncthCgYUNfO6O7TV6SY0TOMLEzZNPXQPStzR43U00zmJOQNA2DXDjtjvV7tJPal
	BpG85FM+iEkeZu8TamCfHjsnzDLn+pgpmpBCPK51raUDBOk1vGaOLP9rsqrOweZP3B7O+jwk3up
	RLICB5b/NnAtXPJZkFPVS7IwPHQ9wNcnSGPxQRck0F/Znc7KGRw7ao0TblX7HkP+pPmv3H+BIhE
	ev6epcF+xnz02aIbQJjYPmIlg0Mn/FB/1cfGG/d9UDhz67lViKC+YU5wHXhiPvHcMWzxGKQuL/M
	R88fejE8DsCTK3J+9X5k8Viqz3TP5S2yML0cSrfJcX6ihn0fEHnpbveXUp9EnHxPBLtvHh9HBzQ
	53VA=
X-Received: by 2002:a05:600c:6487:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-46fa9a94548mr76553785e9.3.1760101418868;
        Fri, 10 Oct 2025 06:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1vPYT1e4Pl84EaZh3h4YINuvf3XpFlxQHnIAmrK+VMen6bKH4v9WgR8srSEe4ly5NpDoHJw==
X-Received: by 2002:a05:600c:6487:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-46fa9a94548mr76553295e9.3.1760101418297;
        Fri, 10 Oct 2025 06:03:38 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm58327435e9.6.2025.10.10.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 06:03:37 -0700 (PDT)
Message-ID: <5a98e3a4-287b-414f-801a-8054ece14662@redhat.com>
Date: Fri, 10 Oct 2025 15:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] mm: define clear_pages(), clear_user_pages()
From: David Hildenbrand <david@redhat.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-11-ankur.a.arora@oracle.com>
 <5ec85b0b-9848-4cee-98f4-37953d504773@redhat.com> <87y0q4ewzf.fsf@oracle.com>
 <6743ead5-4d61-4274-a24f-13a8a8265aee@redhat.com> <87frcbayt2.fsf@oracle.com>
 <1b4e3a1a-eeff-4d48-9b1b-d20af1d94be2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1b4e3a1a-eeff-4d48-9b1b-d20af1d94be2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.25 12:37, David Hildenbrand wrote:
> On 25.09.25 07:25, Ankur Arora wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 23.09.25 22:26, Ankur Arora wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 17.09.25 17:24, Ankur Arora wrote:
>>>>>> Define fallback versions of clear_pages(), clear_user_pages().
>>>>>> In absence of architectural primitives, we just clear pages
>>>>>> sequentially.
>>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>>> ---
>>>>>>      include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
>>>>>>      1 file changed, 38 insertions(+)
>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>> index 1ae97a0b8ec7..0cde9b01da5e 100644
>>>>>> --- a/include/linux/mm.h
>>>>>> +++ b/include/linux/mm.h
>>>>>> @@ -3768,6 +3768,44 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>>>>>>      				unsigned int order) {}
>>>>>>      #endif	/* CONFIG_DEBUG_PAGEALLOC */
>>>>>>      +#ifndef clear_pages
>>>>>> +/**
>>>>>> + * clear_pages() - clear a page range using a kernel virtual address.
>>>>>
>>>>> I'd just call this "clear a page range for kernel-internal use"
>>>>>
>>>>>> + * @addr: start address
>>>>>> + * @npages: number of pages
>>>>>> + *
>>>>>> + * Assumes that (@addr, +@npages) references a kernel region.
>>>>>
>>>>> And say here simply that "Use clear_user_pages() instead for clearing a page
>>>>> range to be mapped to user space".
>>>> So, comments that actually speak to the use instead of technically
>>>> correct but unhelpful generalities :). Thanks, good lesson.
>>>>
>>>>>> + * Does absolutely no exception handling.
>>>>>> + */
>>>>>> +static inline void clear_pages(void *addr, unsigned int npages)
>>>>>> +{
>>>>>> +	do {
>>>>>> +		clear_page(addr);
>>>>>> +		addr += PAGE_SIZE;
>>>>>> +	} while (--npages);
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>> +#ifndef clear_user_pages
>>>>>> +/**
>>>>>> + * clear_user_pages() - clear a page range mapped by the user.
>>>>>
>>>>> I'd call this then "clear a page range to be mapped to user space"
>>>>>
>>>>> Because it's usually called before we actually map it and it will properly flush
>>>>> the dcache if required.
>>>> Makes sense.
>>>>
>>>>>> + * @addr: kernel mapped address
>>>>>
>>>>> "start address"
>>>>>
>>>>>> + * @vaddr: user mapped address
>>>>>
>>>>> "start address of the user mapping" ?
>>>>>
>>>>>> + * @pg: start page
>>>>>
>>>>> Please just call it "page". I know, clear_user_page() has this weird page vs. pg
>>>>> thingy, but let's do it better here.
>>>>>
>>>>>> + * @npages: number of pages
>>>>>> + *
>>>>>> + * Assumes that the region (@addr, +@npages) has been validated
>>>>>> + * already so this does no exception handling.
>>>>>> + */
>>>>>> +#define clear_user_pages(addr, vaddr, pg, npages)	\
>>>>>> +do {							\
>>>>>> +	clear_user_page(addr, vaddr, pg);		\
>>>>>> +	addr += PAGE_SIZE;				\
>>>>>> +	vaddr += PAGE_SIZE;				\
>>>>>> +	pg++;						\
>>>>>> +} while (--npages)
>>>>>> +#endif
>>>>>
>>>>> Should indent with one tab.
>>>> Will do. Also acking to the ones above.
>>>>
>>>>> Any reason this is not a static inline function?
>>>> Alas yes. Most architecture code defines clear_user_page() as a macro
>>>> where, if they need a to flush the dcache or otherwise do something
>>>> special, they need access to some external primitive. And this primitive
>>>> which might not be visible in contexts that we include this header.
>>>> For instance this one on sparc:
>>>>      https://lore.kernel.org/lkml/202509030338.DlQJTxIk-lkp@intel.com/
>>>> Defining as a macro to get around that. But maybe there's a better
>>>> way?
>>>
>>> Can we just move it to mm/utils.c and not have it be an inline function?
>>
>> Thanks. Yeah, that's a good place for it.
> 
> So, I'm looking into this and I think we should fixup the arch if possible.
> 
> I now have
> 
> commit 0f90e18abec6b6080af9ee5583cbba28d483a87d (HEAD)
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Oct 10 06:09:51 2025 -0400
> 
>       treewide: provide a generic clear_user_page() variant
> 
>       Let's drop all variants that effectively map to clear_page() and
>       provide it in a generic variant instead.
> 
>       We'll use __HAVE_ARCH_CLEAR_USER_PAGE, similar to
>       __HAVE_ARCH_COPY_USER_HIGHPAGE, to indicate whether an architecture
>       provides it's own variant.
> 
>       Maybe at some point these should be CONFIG_ options.
> 
>       Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> To get started. Did you only run into the issue with sparc or was there
> another one problematic?
> 

Okay, m68k is nasty as well. Change of plans, let's keep a 
clear_user_pages() variant in mm/utils.c when the arch has special 
clear_user_page() needs.

-- 
Cheers

David / dhildenb


