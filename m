Return-Path: <linux-kernel+bounces-832294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE1B9ED5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5858C2A836D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228F2F068F;
	Thu, 25 Sep 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT70b7C1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056814658D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797856; cv=none; b=pN8TM13/W08LXacbJv/WY6pRu8SGJCTTg6shHsm58b3qdBPleybkZMSY9EBXkWvImcrAi+7+ILGxJaMXsDpNQvODz7Kqx17hPEsNABb2zl36bu86ItADq/a5RM4wK2FQqzG28Biv2NRN8Iwqdd1cKTMK2hMEisKrvfdW6uvmPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797856; c=relaxed/simple;
	bh=UR3J5J+A57U2d3f5k2r/w3jb82R6WZLuk2SyQC+tN0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOOoy/JznfJLdHJ5rswQPIamfS25SHlkNMiI4gLiDlzwCTQl9+zM0M5pDqK8uYldSSyt5YYTB4ht3VXeeDxdrfXkfsq0CaAjbcMbA03eHGwixAi0luVItf3uX2g3DfVYRcwtlSm0Vs4b3DcCEbREqAAiXUc+MCw8ujzhGFwP+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eT70b7C1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758797853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0DYqCFSuCSIJ86o5nMb5XOn3j7sQzEpNp3r66bySLEU=;
	b=eT70b7C19cIIViknzdjOKsJwqcdtzvtjYZbdIVJyoe9UGuSIbXAobY//wFX9LchhWjDnpi
	x54RrHKLofllDVUvo/R0s8KgY2TjwRKDFnMxxQyVbp8jD8omb5e5UNkiJZiwk4vBvXkQxx
	EBRzhthFFfLmeEc696OxA+N5ldiPozU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-cblq8iyvPcSC1WRCQQkIFg-1; Thu, 25 Sep 2025 06:57:30 -0400
X-MC-Unique: cblq8iyvPcSC1WRCQQkIFg-1
X-Mimecast-MFC-AGG-ID: cblq8iyvPcSC1WRCQQkIFg_1758797849
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso4801475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797849; x=1759402649;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DYqCFSuCSIJ86o5nMb5XOn3j7sQzEpNp3r66bySLEU=;
        b=GcGAnSEreVfVf1D9rRkLd7hv/Z87vwvcxgrXdvvUS9Uhv2AlxrZ/WtTT89T/aPd+W4
         Na2jJKh2G6b1ij7PEeR4LdV1ZEMO4fYFNMZdsPKEk5ldyaWwutsR6bJ3B1kMGsWOdXVM
         NM/WJFAGCKIsKp0tQB6EwAwzVHjJh25vsL2BiG4dQh1ZYg8PQEYiZgxbmSJf0z5el+Qy
         F7FrbB2F9HmJwob9lZxhXyUjpUDZ+HMquFyMnsGqVW3U8levgGgaL3rjPkKOp6LhFK0D
         TZdylbAydDBo2/wi+/rm/5hBhgF4m8Z5EPRM6uNfVkALabt01egirJjcF3Z12CWcdsXj
         yfYA==
X-Forwarded-Encrypted: i=1; AJvYcCV54oH1vp5vpA355D8jb4ebKkkl2zd2Q5fJjQEayaQ3JO9z5kMkvMkRvCemirvPjDatx7aR4FLuzx/C2ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzDyw93RMu+lBJwrLN6YwKve+V/MdBpPZ6knNGVjUYG06zYzQ
	m2G5aioM6cHxJjlMNpAtHrArtCNA8M92rS5zffkc8Jxq1FbznMYp9jmSrgVdESQGb6VC3J0umvR
	qOhWadpB6AJImJfOqlB3xhSrpwQNlGObYAzgMZkJRsTCG9kNVD58nBehz4JHVLTaqKg==
X-Gm-Gg: ASbGnctYULxASWu1+tTF601eCNca/aIPeVL4y+/rR4kUqiiL2H6SNjkiwNOoY92IdFA
	ZCY7bOwyhQJf9AqKT1ZLPkwEGacQOclNB/2Fu9AOe6y23pkuLA4+nIYg1I/G3edQsP6BEgTAwOu
	gesIECftyKIKMLA1ddoAXGn6dEeeqBJL7mcqEjp+KpOwimEq8UDZEHcKm9AVRMPMD4E4QkVa+nr
	qo+7pmP22FvVXtcfhEQYSnYi7dOhMxCld2jqSRp7XZd3TMsm8y3MWJ0N7lbNWuqjR2bA0WHQORM
	8LAFNcMStS1r0A17xUTFvwkHF7Rkf1+uYyRsGGEKAvFUg9dat5YHfkgmhu6rt04ZIP5UX+Zc8l5
	kuPGrbkThg18JDRgnVybgODpH3zSN4WANMezF1n6xlZdQv/5VEGuH2GMIRI6vgHOVtnZH
X-Received: by 2002:a05:600c:4f0e:b0:46e:1aed:5d4d with SMTP id 5b1f17b1804b1-46e3299eefamr35424325e9.4.1758797848864;
        Thu, 25 Sep 2025 03:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfukPcY+om6jUefJHcDfs4SKfKvCwZQIFFSmlxwA+B+iUL77hVfMVdeVh9JpgCh4NypDIokQ==
X-Received: by 2002:a05:600c:4f0e:b0:46e:1aed:5d4d with SMTP id 5b1f17b1804b1-46e3299eefamr35423995e9.4.1758797848412;
        Thu, 25 Sep 2025 03:57:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32b5504csm16667385e9.0.2025.09.25.03.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:57:27 -0700 (PDT)
Message-ID: <17a11d85-9e27-4d9d-8109-302ef9cfb8ec@redhat.com>
Date: Thu, 25 Sep 2025 12:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
References: <20250925085429.41607-1-dev.jain@arm.com>
 <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
 <45e08ee0-c85e-469e-a3eb-4ca2e8b7ec0c@arm.com>
 <462bb4e3-7a38-4155-9f95-52fbb4b6d464@redhat.com>
 <26ca0d6b-5fd4-42f9-b985-936d9a72d307@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <26ca0d6b-5fd4-42f9-b985-936d9a72d307@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 12:50, Dev Jain wrote:
> 
> On 25/09/25 4:07 pm, David Hildenbrand wrote:
>> On 25.09.25 12:33, Dev Jain wrote:
>>>
>>> On 25/09/25 2:46 pm, David Hildenbrand wrote:
>>>> On 25.09.25 10:54, Dev Jain wrote:
>>>>> At wp-fault time, when we find that a folio is exclusively mapped, we
>>>>> move
>>>>> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
>>>>> reduces. This is currently done for small folios (base pages) and
>>>>> PMD-mapped THPs. Do this for mTHP too.
>>>>
>>>> I deliberately didn't add this back then because I was not able to
>>>> convince myself easily that it is ok in all corner cases. So this
>>>> needs some thought.
>>>
>>> Thanks for your detailed reply.
>>>
>>>
>>>>
>>>>
>>>> We know that the folio is exclusively mapped to a single MM and that
>>>> there are no unexpected references from others (GUP pins, whatsoever).
>>>>
>>>> But a large folio might be
>>>>
>>>> (a) mapped into multiple VMAs (e.g., partial mprotect()) in the same MM
>>>
>>> I think we have the same problem then for PMD-THPs? I see that
>>> vma_adjust_trans_huge() only does a PMD split and not folio split.
>>
>> Sure, we can end up in this reuse function here for any large anon
>> folio, including PMD ones after a PMD->PTE remapping.
> 
> Ah alright, I was thinking that something may go wrong through
> folio_move_anon_rmap() in do_huge_pmd_wp_page, but

Right, there we have sine VMA and single PTL.

-- 
Cheers

David / dhildenb


