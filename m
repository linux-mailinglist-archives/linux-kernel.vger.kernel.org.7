Return-Path: <linux-kernel+bounces-721926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54ABAFCF87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4471BC82BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205232DECB1;
	Tue,  8 Jul 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL+jT6t0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6492E0919
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989343; cv=none; b=logIgDEM9nwtzvpJSGS7L/MoaIWcwTwV5wUe3CE5C+Hguc2lmPHv8ETUvbPGG1QxrgTipNEmRu/7ALk+U7ZUmlRjUznRSkdn+cosPQeHUmCtM/EVBCeWupQKEMJbf7oLIQu3iauuaUCo3VbFz2RSzJqy9DdbiVt+9XyzFbZ8Msk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989343; c=relaxed/simple;
	bh=4PG6A4qdPDJaDK9rSecXFeyWQlvQfmN3rmHwoACWPPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeciW33Q0AAcArReMFwYjm9KllzHAD8vumSzRXPmZlh3LKVjt+8QsqYATWZ+6NwY0dzyQWsYkAW9ZIfKUVDjGoDGmMrU+niwDmc4nXGokqIrOxqr8OQAhRH7fl/ubsQfLpXI1Rlj7NCjLP0PpkjjCHThB56vLbrPwTYZv8ycWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UL+jT6t0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751989340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O1MbuMS/xAVXqVQl4KdN8hBfeBeFym/jGvqVlzXbTwQ=;
	b=UL+jT6t0+WgFzdzSVGg1N9RPvIIgc2B49rvK3Ww+JOxh10a8o1zYMAusU/OVviYBEIHnlo
	VoSG5ydNyZCoLO95it6nd1cX5oMo91tVd92jVbqUZ+FWnUxTc3kAPIsSbv0WovzAxPvkH6
	A7TODHEkR1i6e+Qr+QlO9vUgJKPH0pI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-fpfQOwxzPESzxe1jpVIAlQ-1; Tue, 08 Jul 2025 11:42:19 -0400
X-MC-Unique: fpfQOwxzPESzxe1jpVIAlQ-1
X-Mimecast-MFC-AGG-ID: fpfQOwxzPESzxe1jpVIAlQ_1751989338
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so27162885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989338; x=1752594138;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O1MbuMS/xAVXqVQl4KdN8hBfeBeFym/jGvqVlzXbTwQ=;
        b=bc75KRHXCksRLMJ2xg7PhYR34GLkP02vY4cZNGBV4HpJmvD96QcY/XeqRnKKHd/jY0
         1tl7MNdsL+zquSW9Kwpr4IIxptOSpSfgrcsSt/MMtIWTFPQXIqZCuoiXiaQPVNxQzuAP
         h7y5HsfFDNImyo3kJRVMkIgJJXRJUvvZRd4kO2cUfWSMG6PeMEaW644IM/IBCxcZ57VJ
         wOv/J+AzslgCsCeK455gnKgjVfqJ6pirFKpHBmeayz7Fp7RBVA7AantGBdUe5hCNqY18
         R/Ogy1TPcLc7gZFtfmDFUKVQ9TchD3unBzOSz46brNo4bM25iFw4etskImKfIVWJjvoU
         tH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlAkfLvUz2rJpQsZuelGkUUV3JADvRCC5Er4lEI8/Fo41KtnlcvDn/RHhmk76v6b4W64tpeZSVv1SFvq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSJm9cP4guI/SdmIuH4RrFnmYJtgef6LoKyaqNJ7TXdJCJ2y/
	Cd8S41VqwzIvEsO4O7TIt9PX36V+YIkUQnh+sENaSD4aE+MbCsQUco8/sHs+z6H2iioW5KuME/v
	t7pg6oE9SeMQ15WjwWq79AkeT9QF6ulL2kLQntB83sNMOGVPAQk1k+tyak0eMVuY1jA==
X-Gm-Gg: ASbGncv23Id0VmQ2oOerpt8eHgc7lSUZOO1F3ZtLaCRn+qfy3MZI64Ua3ZsiLtMF3fO
	sWwmh8XYSf/cQ/xmW78VJLsJwfl1++lgRPSCLzU8FWQAlwQ61mtuSc/gcuNG3o4zS1Qt9SNqvIA
	9rBjgBhMzccE6MzcYWox6ZbdjdNquq2yEJ0LS/0SJmd39uhKz59hfvfxh7EkDr0Wi3eMKHAFC9a
	8tQAx5FlrO8rS0fttOD2mkUkFiaXslR+PCcejnI8lPHz0kK6kERugbzyU3LE1Yhza0HXi/8lHcU
	clS/tV2EcGPlp93g1cwamtiOTnjfHhzoZmZxUpEMgdwmimFhgYBFFfISJU3LP42Az5spZJnTEQd
	cKjjpvnpi4YGOvutyj2BjKkKz+cXvKqo9QKUFv0q8f1LR4HCqww==
X-Received: by 2002:a05:600c:4f16:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-454d31e6959mr2743025e9.21.1751989338082;
        Tue, 08 Jul 2025 08:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8HZ/ySqJpRlxvKJLl+IGmRqojZ/l2Gp1cwjot7XvUeM+y9qFyp52qh/IPBupG3LXayXcx5Q==
X-Received: by 2002:a05:600c:4f16:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-454d31e6959mr2742615e9.21.1751989337562;
        Tue, 08 Jul 2025 08:42:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d2754sm25689455e9.24.2025.07.08.08.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:42:17 -0700 (PDT)
Message-ID: <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
Date: Tue, 8 Jul 2025 17:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aG06QBVeBJgluSqP@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.25 17:33, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>> On 01.07.25 02:57, Andrew Morton wrote:
>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>
>>>> When handling non-swap entries in move_pages_pte(), the error handling
>>>> for entries that are NOT migration entries fails to unmap the page table
>>>> entries before jumping to the error handling label.
>>>>
>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>> corrupted.
>>>>
>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>    Call trace:
>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>
>>>> The issue was introduced with the UFFDIO_MOVE feature but became more
>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>> path more commonly executed during userfaultfd operations.
>>>>
>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>> paths before jumping to the error handling label, not just for migration
>>>> entries.
>>>
>>> I don't get it.
>>>
>>>> --- a/mm/userfaultfd.c
>>>> +++ b/mm/userfaultfd.c
>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>   		entry = pte_to_swp_entry(orig_src_pte);
>>>>   		if (non_swap_entry(entry)) {
>>>> +			pte_unmap(src_pte);
>>>> +			pte_unmap(dst_pte);
>>>> +			src_pte = dst_pte = NULL;
>>>>   			if (is_migration_entry(entry)) {
>>>> -				pte_unmap(src_pte);
>>>> -				pte_unmap(dst_pte);
>>>> -				src_pte = dst_pte = NULL;
>>>>   				migration_entry_wait(mm, src_pmd, src_addr);
>>>>   				err = -EAGAIN;
>>>> -			} else
>>>> +			} else {
>>>>   				err = -EFAULT;
>>>> +			}
>>>>   			goto out;
>>>
>>> where we have
>>>
>>> out:
>>> 	...
>>> 	if (dst_pte)
>>> 		pte_unmap(dst_pte);
>>> 	if (src_pte)
>>> 		pte_unmap(src_pte);
>>
>> AI slop?
> 
> Nah, this one is sadly all me :(

Haha, sorry :P

-- 
Cheers,

David / dhildenb


