Return-Path: <linux-kernel+bounces-837455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB3BAC5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7386B166B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6AC2F39DC;
	Tue, 30 Sep 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxqMD+Op"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A11F03C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225467; cv=none; b=oQNtRx8dxOAVPgmZWkr6NDO1G/hYBxrXuTvlIh7AVwHngn8G4rriDQtCJ+5jrM/B2N1i4DbaKm4TkRKhCwEIGWPaz9LDKWRYNYEu211hIbLf8rhQtFEqSa15xl1osTJ3WasQ5pRtF8yEToMFhpntvmBjqZCosDzj1C5ubpivhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225467; c=relaxed/simple;
	bh=Ci37cR2EaAMuIxCmSp84WE4KVgv4aqVx5FPpQLoomJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R66KYU5esv5QcIKjQsNFHgWFrqHU8ye+FiOS6mJhXXYUEfC+jdcUbtVTzby9ptg99WN9zcvZ8tHigb/lINU/kEwQdjw0ZXSdlwWamzR/i7zXgXDi5C3jlb3EuJalIHu+QLfsAM8xx6P0Iy1hppzhsqZk2vZKLbfNQXOO89g6UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxqMD+Op; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759225463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zTKsiV+MwvU3A+CTYo66BfK7kCyj0E0ejJPRqjGwaM0=;
	b=QxqMD+Oprfw4BtJnfBt3q7dgduxV2IPZIVtbRykd0Vo0/A9vXpuvSW0HdcFx6GGlBIQ6mK
	vtmSmzcUTcBSRVVMGLGBhQlUomk44r8anQ3LiWd4Kzznmcit+iuiUlHtD1BTpta05tKTU0
	5Vp2sK7Ah7il+2YroFI0STqNLJbOXVo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-18WzLGWbOEyNb5rR0CYhcA-1; Tue, 30 Sep 2025 05:44:21 -0400
X-MC-Unique: 18WzLGWbOEyNb5rR0CYhcA-1
X-Mimecast-MFC-AGG-ID: 18WzLGWbOEyNb5rR0CYhcA_1759225460
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso41074305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759225460; x=1759830260;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTKsiV+MwvU3A+CTYo66BfK7kCyj0E0ejJPRqjGwaM0=;
        b=JC6sLEg+6dKZVpS9Nz1LY8gJtcSD2xJTilbQzQ8Zlz4/nq+avtxZKw64KylMVqnB9b
         0npsNpx1z31Qnx09zHVyZCgxEEI6IJpvo8vzWXHrz1lSghO2LEHpiKkkUWjlUpX4W15H
         TVwVKV183rMGQ9l9qLO8VyIZtEZkwum3ZL+MCG5OCjmw8SdV3gD+LuNZs3PAlc2avGPa
         DMaOzq7pTQeETP04fC8KoLN5yrTromxKd67HLLDIV0uZ61uDaOkwv30XAhV/Ge9kHq11
         SKmKOker/BxA2A3fYPOh5rAuj5VayVC5BOZSbqJVsbZ+7NbnZpBbCLIMowaw1Y2uMREX
         FHJw==
X-Gm-Message-State: AOJu0YzT6stN0RkOrGJ7VA2HOqCY95O1Zl/JYO80q4j8ZgJDA5HJ8hwD
	sWpxi+TixRscpGZKH6OnhZvz/w1tN91XeTOr2Wl3dMYdP2gd1MRc1w+ON0OMzTaPAhJcofzrFhi
	xFUmbWqm0m4Q2+cXFsdWEOzRA2lOYUwa5Yzi4DwrN+3yl4Vlf33jtCe5GkChpVhzInQ==
X-Gm-Gg: ASbGncsfXWR+pxb3K8A5qEmWThXGo6tRakEBX7KEhmsAbh53SUjEA90dWBDNE8juzz2
	wXF1qy9zecBklqtDdaDaTnEFTl6jZYK4YpycI7vswbU796UVCVIEzPB9Voy8dlOhn/7jdXG2lhx
	facJUm4mH8NP+pOcfk+VJND4D11AzAgO4jOQ+As4vfdGRS+AsAL820Y/9trMLSEA/CbbgROgo1A
	1Ay/WYX24yeSumdQKUcr6ZT1uQHOeN/sxXB2BNr4+oZAScbprc1a2nuM6ZcmKP5+rYa6PImDfx7
	2Z4tXktZabPjIlsknHoX+8pAPx1b9KSnNRFbX0EJcs4mECvv4lsVHFvJZbS8/+CpZmKB9GpyLTP
	rWqoqC6Z9
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr18059617f8f.29.1759225460258;
        Tue, 30 Sep 2025 02:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+VXBV2ldPpYoazSy8gSggmZyFPsDv2dwFEenIOlqVRHhIY/sSwP8s9VAR+ET95zAfD7AiAw==
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr18059594f8f.29.1759225459801;
        Tue, 30 Sep 2025 02:44:19 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb711sm21683292f8f.11.2025.09.30.02.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:44:19 -0700 (PDT)
Message-ID: <c1cf2254-2449-48b4-b1db-0d92595567df@redhat.com>
Date: Tue, 30 Sep 2025 11:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-12-ankur.a.arora@oracle.com>
 <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com> <87ecrwewn3.fsf@oracle.com>
 <4e061f4f-cd57-4df4-a001-9eba80d1ded9@redhat.com> <877bxnayrc.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <877bxnayrc.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 07:26, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 23.09.25 22:34, Ankur Arora wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 17.09.25 17:24, Ankur Arora wrote:
>>>>> Define clear_user_highpages() which clears pages sequentially using
>>>>> the single page variant.
>>>>> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
>>>>> primitive clear_user_pages().
>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>> ---
>>>>>     include/linux/highmem.h | 18 ++++++++++++++++++
>>>>>     1 file changed, 18 insertions(+)
>>>>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>>>>> index 6234f316468c..ed609987e24d 100644
>>>>> --- a/include/linux/highmem.h
>>>>> +++ b/include/linux/highmem.h
>>>>> @@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>>>>>     }
>>>>>     #endif
>>>>>     +#ifndef clear_user_highpages
>>>>
>>>> Maybe we can add a simple kernel doc that points at the doc of clear_user_pages,
>>>> but makes it clear that this for pages that might reside in highmem.
>>> Didn't add one because clear_user_highpage() didn't have one. Will add
>>> for both.
>>>
>>
>> Doesn't have to be excessive. But even I have to keep reminding myself when to
>> use clear_page(), clear_user_page(), clear_user_highpage() ...
> 
> And now all the multi-page variants. Really motivates the removal of
> the HIGHMEM stuff.

:) I'm afraid it will stick around for a couple of years to come.

-- 
Cheers

David / dhildenb


