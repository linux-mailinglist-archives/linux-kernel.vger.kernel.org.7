Return-Path: <linux-kernel+bounces-860730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 751CBBF0CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538194E85D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC66257839;
	Mon, 20 Oct 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFU6d0dU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF72248F66
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959287; cv=none; b=uXRFxZdoUUODt7XbmO4PL+vmmW4Lb8V7fg9AoQIoFe4v5Z5p2GsAkMoyhDmXlEG//OR6ZUClSR/ukTVvhW1Co4Nz3KjAgeN4M2kIClk8lRgxY6Fo76LGzaw6Ocr2n9mIACo9PFY57Z9Fl598028TKG/SS9o5FsxBI1mJ8qQ7Thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959287; c=relaxed/simple;
	bh=Iwg7Y2KaFujNHPdqNCE5PaMhSPC8qsW+umVOivpqaPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym35FR4k0a74Ty4vv49OFbuqLL+yemXqBWveUDAntoY6nZiTRMtyoRKvk2q+6jU7CYJc+YB6dAAbdJ9Hx7A8sGqYeUdabtjmvnhP8JEYWalP9ZazLxuAQNg0IZNOoNQ6YBNsntG56uihwal7ojN6gyoabwBjBmOZ5JW2DUywIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFU6d0dU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760959284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wds31+AksH+mUEETdlpxxIX8Pxrsqa257DLCv4vc6Ho=;
	b=dFU6d0dU1XJBhbHlrLZNc+mgylPOplvLkxsyP7CZR49q2+ocoiPF6gSH3QF3jwrWTtyPpJ
	L3GBzNMUamJc6dzQskeMdqfW1No/EDUqLsZs0REF1I5tNqP0rGiEonRtBUDlXdVR4VCswU
	DharXc5L3NIK2vEJpXM3t9EARa6v+nI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-4ivFHEMPM2qcWMd9ZcVL8g-1; Mon, 20 Oct 2025 07:21:23 -0400
X-MC-Unique: 4ivFHEMPM2qcWMd9ZcVL8g-1
X-Mimecast-MFC-AGG-ID: 4ivFHEMPM2qcWMd9ZcVL8g_1760959282
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2ef8e0133fso512957666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959282; x=1761564082;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wds31+AksH+mUEETdlpxxIX8Pxrsqa257DLCv4vc6Ho=;
        b=m9qIoJ/Lqz75S824WagYVwOhD9FQofag6ipsbmXnPvyMBe7k8iDLkoB6eishkaEkwo
         38S/VYVPljMALLoR8ejS5s4SwuDMYVXI7trjn9mB7Nqm9tkVsp+4FvOtmvvfJ4p4MFkW
         zkTSOW5Ldeg33zwOObU2bidEt78lcXIRDgW6RMDZepisClmsBjftB4XbvLpQpKZXICgp
         ZlPkfbemYgjFCiAhoUbbL61Szh11YAMHGDJyJR2y6Y0AYjPvab5+G0xYiPcQvguEL+MI
         +LEcJEuERuMbgtXgbLE1KI9sa57HsS9WvT84Do0qjm16cUQoTnGv+qfvYQ5hnB7O6gmZ
         Ogqg==
X-Forwarded-Encrypted: i=1; AJvYcCWtn1xrq7ab+chHpjLLPYfmF7/1JifpQ3ICVckV05PXCnJmYCB9eZXdjFmdVO98gq6ksUvpWPZ8MSFZYCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqUVk6qK/tiKFyUE0pa5XTQlXCGS/sCiSbM78n5iZsCXTsfN0
	TvpDKkB2+1h9VZEzbV7mrEI0Rb3irhkeRVEZhDO8CPBwhR6RnHtGk1JPBE7+C7mXdNPzt8t8OHV
	rjk0a/TXfi4t6Lnpw2g/7lur9N+UzHQfCyuXtF7N4SQX13ZBRLYqAIVUR3NPvD3SmUw==
X-Gm-Gg: ASbGnct2xk+18SLf80PAKZ9SVcLC2DUKuW6GfLfqKSvZ666SW8ARpjX7uHG7puDTYee
	mazcw2fsCEoDTAbP6AjAxET5jQ8V0EH3txhnkhT8yqYp4i1s1kRurtFpBzrNusnQQA/PyuEbtcu
	1Qrgy+nNTLfS90vXTlBjjOZOkSCoCot5FxFgbYRfOf3aPgA/yDJBrGPmEFFJ7GcOj4j8/6fQt1r
	9rb9p0Bnlds98htpLFE5XIyT3kw7VIKN2tXpb/ldnQ1kaaxB/LE2iRtPTZWa/8IA685VCVDc83O
	gGIM90b1DtNyyhO3lc1O3GWD5FaNMlTTHUuIPuT10+geoH2TB4rwNX4EusDCBi0ElpGDcliZ4Z3
	d5yZaiPj6JQ4Pc7TkDb6DPwBaKxGH3wXUt0WMM2TWukxXEJcyIokpT8xeVc6h88o/UVMkNLyUUx
	DVuQYexG0/Xzfw041DO+qYil4MNFI=
X-Received: by 2002:a17:907:3d87:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b647570a3d9mr1429913266b.59.1760959282342;
        Mon, 20 Oct 2025 04:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHenN8DPdLH1YrbWHC6rMNNYQJQeC9HIGErbh2OG0rtzdQbt9zFEPDmXchMbuVkF7mvdkShoQ==
X-Received: by 2002:a17:907:3d87:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b647570a3d9mr1429909466b.59.1760959281697;
        Mon, 20 Oct 2025 04:21:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83976a2sm748432166b.32.2025.10.20.04.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:21:21 -0700 (PDT)
Message-ID: <dfb9fd83-3fe1-4596-bc94-c3f9c3c916ce@redhat.com>
Date: Mon, 20 Oct 2025 13:21:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
To: Vlastimil Babka <vbabka@suse.cz>, Jiri Slaby <jirislaby@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org>
 <3e798b9e-4915-404f-9197-ed3c32587141@kernel.org>
 <85707316-3f2b-4e29-b821-a32f9097244e@kernel.org>
 <635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com>
 <3b97b754-890a-46c6-b892-a0324d529a3d@kernel.org>
 <a95df2f2-5ecc-4d28-9bcc-1f9b457b04a5@redhat.com>
 <48a24efa-a326-4cca-ab28-50c6251bf03a@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <48a24efa-a326-4cca-ab28-50c6251bf03a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 12:31, Vlastimil Babka wrote:
> On 10/20/25 11:13, David Hildenbrand wrote:
>> On 20.10.25 11:08, Jiri Slaby wrote:
>>> On 20. 10. 25, 11:02, David Hildenbrand wrote:
>>>> Regarding the metadata overhead, in 2015 Linus wrote in that thread:
>>>>
>>>> "Long ago, allocating a page using kmalloc() was a bad idea, because
>>>> there was overhead for it in the allocation and the code.
>>>>
>>>> These days, kmalloc() not only doesn't have the allocation overhead,
>>>> but may actually scale better too, thanks to percpu caches etc."
>>>>
>>>> What's that status of that 10 years later?
>>>
>>> AFAI skimmed through the code, for allocations > 2 pages
>>> (KMALLOC_MAX_CACHE_SIZE) -- if size is a constant -- slub resorts to
>>> alloc_pages().
>>>
>>> For smaller ones (1 and 2 pages), there is a very little overhead in
>>> struct slab -- mm people, please correct me if I am wrong.
>>
>> If it's really only "struct slab", then there is currently no overhead.
>> Once it is decoupled from "struct page", there would be some.
> 
> Yes, but there's potentially better scalability and more debugging
> possibilities as benefits.

Agreed.

> 
>> IIUC, I'm surprised that larger allocations wouldn't currently end up in
>> PageSlab() pages.
> Can you elaborate why surprised?

Primarily because I think it's a bit inconsistent. I would have assumed 
that whatever came out of kmalloc() could be identified as such.

One of the benefits of PageSlab() is that we can better sanity check 
that these pages will not get mapped into user space by accident: see 
page_has_type() check in validate_page_before_insert().

But given that ___kmalloc_large_node() today also allocates frozen 
pages, validate_page_before_insert() would similarly bail out if it 
stumbles over the !folio_ref_count(folio).

-- 
Cheers

David / dhildenb


