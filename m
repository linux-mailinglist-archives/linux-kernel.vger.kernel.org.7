Return-Path: <linux-kernel+bounces-828570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C4B94E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0564830BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4512F3C07;
	Tue, 23 Sep 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cngXkU/t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9612EDD5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614676; cv=none; b=N1c6nVSu5+hpRrvLdaQRvQ9OsBPhXcy3k/xoSS1xLBdE7sWWxd1wx8z98EpUoYJzIlhu+yOeplhsUYFLEUNS0uW7tAxfJ8FmD9zE2w3VwaZpizZrRfcOT3QEMxXOnalFJpsZOGgc+rXiEtjzqnVN7wkpRAjlPDebXfmiuIimNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614676; c=relaxed/simple;
	bh=gJ61NuGrBrEUS0Q7teI7f/t0Z+b2dGi1lEXOjfYEC+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKmnopE3tzKsp35t6JZzZDK0fDVp3/9cXv5fAX39+aDuuKWihuHO4HbpfjBjsM6Bpo3d9SrIWeoFvkSQDuwMIDUjwSjX0HrE6w2It/QeluQxGHSyCnsUm8oKu1BHfWpBiFX1zXn3gnpugS1F0C+dNdTQuRpIb8a8j1Qi4rmVJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cngXkU/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758614673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Askvh1O4f5Tsh0uDpTj1jyMFwNHEO9gAWdh5DB6xzag=;
	b=cngXkU/totYZ+UBHRSs2rYJ6g4Q8Znt1IzhKmUUQI0QlRRbWXL+E5A5Nqq2UjTORiKuGgn
	wLsxjuSpwltoVRUrVm03rBzct2uILDnmqtdpe9by8Zv2Oy3SF6nDt1kcbFTQHa83luR7ab
	/JZVQM4cc8SuQ1yt3peAs3Gexq9DVb8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-w5ulN1fONuuqCLYCpEqJEQ-1; Tue, 23 Sep 2025 04:04:31 -0400
X-MC-Unique: w5ulN1fONuuqCLYCpEqJEQ-1
X-Mimecast-MFC-AGG-ID: w5ulN1fONuuqCLYCpEqJEQ_1758614671
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece14b9231so2543743f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614670; x=1759219470;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Askvh1O4f5Tsh0uDpTj1jyMFwNHEO9gAWdh5DB6xzag=;
        b=WIkQFnWyzgQBuvW/mG0Q+z62i2yWZgNK4s9wf1JVSxx2KnR0PGyzMQb6oQ7VtYLNdk
         91hVHEfMdnEyXpSghIKUgPPsZMEyPO2PpVqfQhwftzupYprLwY0zBINCq5jZ1MnhpwS4
         1stgZC7NA1zcF5byx6Nm/1W20KCJlij0op37LyiUw1VT+cI66cXXNqiuPpd6Fbu0jGFt
         de5tzxkQk/ssB7x5ziVvIJq6d+M7UqiO4nkEV2BFnajWp0Kx0DX94gyogPEvgl/Lvb3Z
         guNUtUips4aIAt7ksyFxSyQkc+2D7X687U60J+vSOwNhmfq+jSBKLz/r6fdWyQ/AS5+8
         HD6A==
X-Forwarded-Encrypted: i=1; AJvYcCUnjE55jkNPMgcobA6IsoZoBPWjBbkLHdFMdeNqI/ecPA8Dw/RsoKAARTkWVt7Y06aFull+/FPeQEi/7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY941rC8w5hrte35xR1elYAObgKl36Hubut536jsG95LoNBTjJ
	S0y0VJwNZ69Xd5H3kHJAQvSky2zHTfAliC1aGXGC4cLX2oGJa5CIN4xDkoAgEmX9Pk8ty5cyojy
	br8iVYyA4UPZDdqJf+T1G/CiALctuzbUhEuYt9BsMIZc03+7hZZccfWlGzvUOx0SFHw==
X-Gm-Gg: ASbGnct/SmaamXGCFgQxfZKpFlKFsNWA90Ku8icI/BS7b+l8QJXmOXm2EXsdPn4QdrP
	xTC5xdmrvmEz3E2GBGL6sMti3v3gD9dTMafYC0GFwuVmMsMY2VWxtYcS82qI5mIps6D3XQjWpNM
	L+qLI8dotki1LDYG3eT01exlSLxOk57Q6HBEY7/tlwxY+CU3qlm+9fWg4H/9WvzjA4x70grd8EQ
	QB+BSrINc6OINyvub50P4XsZMc916vCFkTQlLOAE2oFk2NUvR1WrdE2VjyneVXos975+zIDzi33
	qXzulkDeomOx36IYsdZoa7FuFXGTOnARKhWiV/q5d3Fe6jV4GJThFgO+GeyRjxsjSW/M3EM=
X-Received: by 2002:a05:6000:2884:b0:3ee:15c6:9a60 with SMTP id ffacd0b85a97d-405c33a33f0mr1178434f8f.6.1758614670599;
        Tue, 23 Sep 2025 01:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpbmQG7jPygNYBQKqBxj357VhjdBy0/gBciPcLrIjmdT2uOD24mbn8y6yk8XI+xazCBSzTWg==
X-Received: by 2002:a05:6000:2884:b0:3ee:15c6:9a60 with SMTP id ffacd0b85a97d-405c33a33f0mr1178400f8f.6.1758614670123;
        Tue, 23 Sep 2025 01:04:30 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fd57.dip0.t-ipconnect.de. [79.241.253.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd63a2sm22761239f8f.48.2025.09.23.01.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:04:29 -0700 (PDT)
Message-ID: <5ec85b0b-9848-4cee-98f4-37953d504773@redhat.com>
Date: Tue, 23 Sep 2025 10:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] mm: define clear_pages(), clear_user_pages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-11-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917152418.4077386-11-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 17:24, Ankur Arora wrote:
> Define fallback versions of clear_pages(), clear_user_pages().
> 
> In absence of architectural primitives, we just clear pages
> sequentially.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..0cde9b01da5e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3768,6 +3768,44 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>   				unsigned int order) {}
>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>   
> +#ifndef clear_pages
> +/**
> + * clear_pages() - clear a page range using a kernel virtual address.

I'd just call this "clear a page range for kernel-internal use"

> + * @addr: start address
> + * @npages: number of pages
> + *
> + * Assumes that (@addr, +@npages) references a kernel region.

And say here simply that "Use clear_user_pages() instead for clearing a 
page range to be mapped to user space".

> + * Does absolutely no exception handling.
> + */
> +static inline void clear_pages(void *addr, unsigned int npages)
> +{
> +	do {
> +		clear_page(addr);
> +		addr += PAGE_SIZE;
> +	} while (--npages);
> +}
> +#endif
> +
> +#ifndef clear_user_pages
> +/**
> + * clear_user_pages() - clear a page range mapped by the user.

I'd call this then "clear a page range to be mapped to user space"

Because it's usually called before we actually map it and it will 
properly flush the dcache if required.

> + * @addr: kernel mapped address

"start address"

> + * @vaddr: user mapped address

"start address of the user mapping" ?

> + * @pg: start page

Please just call it "page". I know, clear_user_page() has this weird 
page vs. pg thingy, but let's do it better here.

> + * @npages: number of pages
> + *
> + * Assumes that the region (@addr, +@npages) has been validated
> + * already so this does no exception handling.
> + */
> +#define clear_user_pages(addr, vaddr, pg, npages)	\
> +do {							\
> +	clear_user_page(addr, vaddr, pg);		\
> +	addr += PAGE_SIZE;				\
> +	vaddr += PAGE_SIZE;				\
> +	pg++;						\
> +} while (--npages)
> +#endif

Should indent with one tab. Any reason this is not a static inline 
function?

-- 
Cheers

David / dhildenb


