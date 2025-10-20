Return-Path: <linux-kernel+bounces-860412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96BBF013A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568883B8143
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C262EDD45;
	Mon, 20 Oct 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egq8D6Hr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4122ECE9D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950940; cv=none; b=al0o4cIFUii+E3eteyO3nLiFYJVPEAwuzI5WnQdOy4lFNYP3dMhnE6EKUkYgh2fp4ecp3pfQkAtzzjo1xhiDmmlzKIQ0AjTzzyjaO3+NmeY8iL7LN6CULfZWvZ/oCXONQr2XYA2fzcebTS+uE+eaatEyE9BRv2ch4wMLeSRtmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950940; c=relaxed/simple;
	bh=duk16NvzE/e5Q3uFal86NfJO7o6aGeQdHoqgBaAqYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7pThN5XOALrACnAXca4WriB817t692nEYJ5F79K8xK8Jk/lxYCszLjs53MPb07uU4H7CK7Y3HjPgO0IlrJ80z7OJfH82v6scniK5kHQ9Kq47sPZpZ8Fl+KozEG3Vm0DYXGTldA1+E+pDmOYS1lq8tF2syT3S3f+UOpnr8/G0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Egq8D6Hr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760950937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QuekmEGKIc9oAsv4aXr2IF/RaPwPqPMIddn561w2cJ4=;
	b=Egq8D6Hrvi5ZErD0YQhAge1mTxIC53C+UQV7AC9NXJj8PwQx8S6oIRzXJuKAdz4iHbWQgA
	T70wZjgX/Jmf9Irmkz5b1KFkP77goQuQaRN/HqhT/LoyQxYdZtIgrmMm8Zxe13Ms6KM59l
	XdTgapZ3oq6Lch2K+Yr83vuVSHA3+V8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-6GI5PxJyMpmmPsZwemjj-w-1; Mon, 20 Oct 2025 05:02:15 -0400
X-MC-Unique: 6GI5PxJyMpmmPsZwemjj-w-1
X-Mimecast-MFC-AGG-ID: 6GI5PxJyMpmmPsZwemjj-w_1760950934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47107fcb257so63383995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760950934; x=1761555734;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuekmEGKIc9oAsv4aXr2IF/RaPwPqPMIddn561w2cJ4=;
        b=jAtmf2Zw1xoscbTYd1xYZGtkyyUdbAkyxNBRpLvRcxVq2kX4uPgaHS7IumLguWffHA
         xLDukyagJUrcshisier7utDzRjLe523yAaQ8euY2I1xv0qrcbWWE5sNJJhF8rIiBMyBo
         x1VfMiQP3kPOgb+pmnjDoiYGhqw5KDIIULizTkcsvepx6cIjmfm45uABUApoV+Nibi6y
         bwfMEyzK/HSCRRz/BvE0Dv/3Ah4tMJORJKBQid9syNbxNkVvUMv7NVs8fPZ3jJY0F62A
         fvyCT9Qgx4fgwI3XNxzh3oHvBPklztztvD8h0oJJeZQbE/VHDM2GNLmTAev2mCzds5cv
         pwBA==
X-Forwarded-Encrypted: i=1; AJvYcCVTYxk59tZP7RLNcPxg7PcWHHGmy1PNbUq0gl4vUJky6vUIAClhIQvA2ADHN+2a+N/7uhWLRkhdVs2lVWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypn1GKbqSXVluFfFtAho8PW89jzG+2bRGcWf25I7hbArmP5FiG
	iH81qsGJwI4XBaIEJrUX6NWH80yBxDInAXNYklvX8jRcFOf+S/eh4fomKEvYDkm1Nh8ssfps9gn
	1gNfglgBE+hGWkiY2LAZKw99oPevfLUZ1CyTYRhTOL91SaQinAChxJnFIXvx8K8U2PA==
X-Gm-Gg: ASbGncs/7hzWSdqJWoHZQeUcMOwv29rnCDKEUw1FXV9iiulN3+sS8Xd9n2CnumY21gD
	rvPcrs8eERFOji1DXSJR3Ss19ccz/P29LqSjMm8zJhXJG4CTjJ3cR56W1Pp1HMDCz058bbERCpX
	zIqV6VHu+lgPHbzukWbvb3H6XUL5YO5UZDrpYvyxe6pUGauf2F+p8/3oFQbIsUNeSbGdEaRyi4B
	4z6Z4sjNq806eM1tW9eycG8ahpVL8sCse1gycHH0Dw/6b4bgPacRrzzAQjXgP1cuFn3jrHCIsN3
	dLhLDWhVVhRSAZ3PDU0YBlbBMMXoyBZAczU0dr+cJJXDNy5VC5hnIojqoCYB7QcK2JSBF1CJxEm
	RBKrurSyClPhBRWRYBsiu1kn7I4prytl2X1ELOf6RVHlApoBsJo7R3+yv4YCD5aZMAd09IU9W2H
	Zmi3m8uqOB7OGbPAfvqlWA2KkYhow=
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-47117903f96mr96029325e9.25.1760950934400;
        Mon, 20 Oct 2025 02:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1DonHpb64xG1WbeBu2Y+NhpauxghOKViVl2XfaV+Qeidr8X4r3P3iJaCt5aZBDZmdVQeU6A==
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-47117903f96mr96028945e9.25.1760950933865;
        Mon, 20 Oct 2025 02:02:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711c487dfesm202712265e9.17.2025.10.20.02.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:02:13 -0700 (PDT)
Message-ID: <635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com>
Date: Mon, 20 Oct 2025 11:02:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
To: Jiri Slaby <jirislaby@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org>
 <3e798b9e-4915-404f-9197-ed3c32587141@kernel.org>
 <85707316-3f2b-4e29-b821-a32f9097244e@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <85707316-3f2b-4e29-b821-a32f9097244e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.10.25 09:06, Jiri Slaby wrote:
> On 20. 10. 25, 8:58, Jiri Slaby wrote:
>> On 19. 10. 25, 2:30, Matthew Wilcox wrote:
>>> On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
>>>> Vast majority of allocations that use get_free_pages() and its
>>>> derivatives
>>>> cast the returned unsigned long to a pointer and then cast it back to
>>>> unsigned long when freeing the memory.
>>>>
>>>> These castings are useless and only obfuscate the code.
>>>>
>>>> Make get_free_pages() and friends return 'void *' and free_pages()
>>>> accept
>>>> 'void *' as its address parameter.
>>>
>>> No.  Linus has rejected this change before.  I can't find it now, it was
>>> a long time ago.  Most of them shouldn't be using get_free_pages() at
>>> all, they should be using kmalloc().
>>
>> I'd be interested in the refusal thread (what was the rejection exactly
>> about). In a need of whole pages, why would I want to alloc more for
>> metadata (using k*alloc)? Or what am I missing?
> 
> OK, AI yielded:
> https://lkml.iu.edu/1512.2/03853.html
> and an LWN summary:
> https://lwn.net/Articles/669015/

Right, the interesting stuff starts here I think:

https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/T/#u

Personally, I was always confused why we are even using "unsigned long" 
in the first place.

Regarding the metadata overhead, in 2015 Linus wrote in that thread:

"Long ago, allocating a page using kmalloc() was a bad idea, because
there was overhead for it in the allocation and the code.

These days, kmalloc() not only doesn't have the allocation overhead,
but may actually scale better too, thanks to percpu caches etc."

What's that status of that 10 years later?

-- 
Cheers

David / dhildenb


