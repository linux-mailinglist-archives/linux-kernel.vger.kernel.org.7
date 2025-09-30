Return-Path: <linux-kernel+bounces-838097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454DBAE6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A266416A854
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BC823C4F9;
	Tue, 30 Sep 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giHKvvdR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230761D63D8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259955; cv=none; b=PUYQwIQeqB2F6+bc/1tGG7B9hDoJoQX+tgrjsN2YOIwz2eU12GD/HoEAKGK+f55vZHayiTHe/OxhMqyh3Qg9kDdgn7CBxyc5ogXPzKa1LyEcD7zWk2hvW/qkJTNdaDm1egWaSzX4VcIPazaGxRfe5UeN2xetfw3df266SXRXT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259955; c=relaxed/simple;
	bh=/AwSqfy4sn1JBt8ZIrXmdLXhTzQ2iQ1+Z18ZsR59xNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdFLo3Mf7AH7LTyKZO+94f5Aa3N+5z9q1KmVbgFIdYtOeos+DuWn55Znr9LDllwoycXT/S9MH0HzKS1vWxaqQ0GVYUB9qj30hWMZSo6cYo0BovEE6XdYmS1VAEWRxMJHJqQZxNDjilMyrU57oAK9mPgtwcHS7mlfFesFgPs0ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giHKvvdR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759259953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9S15aSoS7gkBTjCjjR9TOKEu4LpldkUvJi552O85UYc=;
	b=giHKvvdRx2BpHKM6tO7Da03G1Yg57B1MapnQPwYvnLmOrUeM7ero+JGiuK5uALxl2bkeJD
	kmAsEJV9YSDHRJKX4+Zfcf+6Ry7PUlXFL3QkN87G8/+XCrQtScEsHNqwDKIAsIl8N5vH5M
	hPz0PNyeHmNXCcr+jqEYQliuCaKciYM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-lZ0aFpZ6PreLAL1sdO1tRw-1; Tue, 30 Sep 2025 15:19:10 -0400
X-MC-Unique: lZ0aFpZ6PreLAL1sdO1tRw-1
X-Mimecast-MFC-AGG-ID: lZ0aFpZ6PreLAL1sdO1tRw_1759259949
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso3503419f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259949; x=1759864749;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S15aSoS7gkBTjCjjR9TOKEu4LpldkUvJi552O85UYc=;
        b=jzfzN92h/g2wYBu8x7i1eqINo7/4QDKY6hiXb6VO9suo2fNfIh/Fo087d8xO/bdHMZ
         leHgawrxl2NVOn5ypqL9z3NIh3X7bTwgQ41vKaL+CfqKWz2GJ5BO6PZpJV0uKuFl0c3Y
         EN/FVUUbc6eXhhOuVz+j/s8s7wlVYRw6wqSydMVqCi6ZnDeV2F66nABxDEICT+dDKARN
         5NCd+X3ZgNztXahuccuYNrZimHH93PoB/1NtgdinRoezz5OtTCrwfR16t4rk658fEDNX
         TK/vXBaVh45n1jqVTfvCetco0AVvRZX/lDjF5+lKoBJ0GZBXUcjMhKSao+8z5ZDeR6wX
         hB8A==
X-Forwarded-Encrypted: i=1; AJvYcCV/y+TA0wB0nxCOWnzSCLrIEIbrJqv6OTVbzkmZQLDcKXa5ebJHo7cm6+Mb57e38bjBbAuOXnwjf/S9uFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1X4X/TE3Hc8uUYCeCBkviOaz50YKPLhNo8XeQLXPjte2vf6l
	5MLvNoP5CIGfX70RKnEh5WrlmiV8wGynvm8lwGXkFEyAN5LwqImY/5oZgC9+t7/V+4Xze/ZBHeN
	gpLAJKxJV+x9iK1ljXoo4mDuvyqXpMq8bcMbIgHmlUftwt38Ienvn8qYUvYgQMA79Rg==
X-Gm-Gg: ASbGncsv+Cx64caOxx0Bfa6jTyfti8S6LPH/MRg4pRNfSCpdt1GRK7inqzOY77iE5Dk
	uc2rcnJJ/w63p+9g5yFMWs2UZHnXCBcmJBr3dV/lPpzTWlG+ljqR5HyBvNy9vFxZT97v7EvtSam
	JJ+LS2qigJrld39dpLiqv4MWe2ncEBzIMy8JcOIPf7udU1RQQOTjgVvXV5gVnoWdsEaVyP1wk20
	XpYm7QRF6WcMVPmnF/CBIHr5LJ4qmfhU+XuPFFi3uhMXvj+gYjcn31X6X4oM/nCY7rjT39hX425
	416S85yISoHBddDcIUo/legw8Uvf0XuhJHY8+P0CSuRhnZ5yMGFDnZ9aGMidboDcUsZ6U1oEFrb
	CZsDfi2L0
X-Received: by 2002:a05:6000:26c9:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-42557824f3fmr600616f8f.31.1759259949381;
        Tue, 30 Sep 2025 12:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIexoXYU6ONRc806amryD6k14OdusrcewNSLQr7eqoen+PTzSqFwWHXHCoKf9b54de3MzLEA==
X-Received: by 2002:a05:6000:26c9:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-42557824f3fmr600595f8f.31.1759259948819;
        Tue, 30 Sep 2025 12:19:08 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc72b0aeesm24420207f8f.49.2025.09.30.12.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 12:19:08 -0700 (PDT)
Message-ID: <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
Date: Tue, 30 Sep 2025 21:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 James Houghton <jthoughton@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com> <aNwmE11LirPtEuGW@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNwmE11LirPtEuGW@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.25 20:48, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
>>> +/* VMA userfaultfd operations */
>>> +struct vm_uffd_ops {
>>> +	/**
>>> +	 * @uffd_features: features supported in bitmask.
>>> +	 *
>>> +	 * When the ops is defined, the driver must set non-zero features
>>> +	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
>>> +	 *
>>> +	 * NOTE: VM_UFFD_MISSING is still only supported under mm/ so far.
>>> +	 */
>>> +	unsigned long uffd_features;
>>
>> This variable name is a bit confusing , because it's all about vma flags,
>> not uffd features. Just reading the variable, I would rather connect it to
>> things like UFFD_FEATURE_WP_UNPOPULATED.
>>
>> As currently used for VM flags, maybe you should call this
>>
>> 	unsigned long uffd_vm_flags;
>>
>> or sth like that.
> 
> Indeed it's slightly confusing.  However uffd_vm_flags is confusing in
> another way, where it seems to imply some flags similar to vm_flags that is
> prone to change.
> 
> How about uffd_vm_flags_supported / uffd_modes_supported?

The former would make things clearer when we are at least not talking 
about uffd features.

> 
>>
>> I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
>> are rather unsuited for this case here (e.g., different feature flags for
>> hugetlb support/shmem support etc).
>>
>> But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
>> the supported ioctls?
>>
>> _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
>> _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
>> _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> 
> Yes we can deduce that, but it'll be unclear then when one stares at a
> bunch of ioctls and cannot easily digest the modes the memory type
> supports.  Here, the modes should be the most straightforward way to
> describe the capability of a memory type.

I rather dislike the current split approach between vm-flags and ioctls.

I briefly thought about abstracting it for internal purposes further and 
just have some internal backend ("memory type") flags.

UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> 
> If hugetlbfs supported ZEROPAGE, then we can deduce the ioctls the other
> way round, and we can drop the uffd_ioctls.  However we need the ioctls now
> for hugetlbfs to make everything generic.

POISON is not a VM_ flag, so that wouldn't work completely, right?

As a side note, hugetlbfs support for ZEROPAGE should be fairly easy: 
similar to shmem support, simply allocate a zeroed hugetlb folio.

> 
> Do you mind I still keep it as-is?

I would prefer if we find a way to not have this dependency between both 
feature/ioctl thingies. It just looks rather odd.

But let's hear if there are other opinions.

-- 
Cheers

David / dhildenb


