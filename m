Return-Path: <linux-kernel+bounces-872425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C470C110F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26BEF4FE388
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A932AAB1;
	Mon, 27 Oct 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTxnc5hj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7E31D75F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593087; cv=none; b=TyN4LlMVd8i3huDHJQZ9LGK/wFq9ZMlDNmc9Pc1emeOI3POQIZPjALSBgpb7nlUu4bHKT0WMd7zIr+ztEiaS08eUZKngkuujOmTUYfVQv2G0OqF99JzSo4/pTla8R6GJSmrn91WpJOigIWPPKn2hAPlZ0I6viH4NOJyS1M57HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593087; c=relaxed/simple;
	bh=WUFTzASOIHjMZRhwCqPWHmYTqYQBELZTAce7Q7qRvfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ/7OL3jG2Z21pd+nCC9dYelFvZVBK11+sSEMU6WeT3qJKJdMICpmdk9c5R0MAsyaLGOK03M1AYJPNQh5Ne7lvUTQrRVgs3ctA0tqGJ4uX9OkGqugdvxra84EDiTOGT0+F39McBN/OWupo1eObNBdMDfvcx5fxO4FXyB194LVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTxnc5hj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761593085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e58DvebilYhZuqhMmqG9yr1jzlYsH5UePdTi/B++WBI=;
	b=CTxnc5hj9hYgmyCszJ1lhn+Jm9ZAsmbIg36ZFlkR4NV+FD9SGOoMu83eQsNkZhdli3o+tZ
	9NIPAvCjZxH9hk1HjiixjHOpk3OwSVC7FkHowY77fzT5BM7t2WOoRiAQXPYfNHvpHtebXx
	3NJajJl5idVsQJKw0UowvGNlMtAJc10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Ro12P1wvMzWuEbhL9o1ZUQ-1; Mon, 27 Oct 2025 15:24:43 -0400
X-MC-Unique: Ro12P1wvMzWuEbhL9o1ZUQ-1
X-Mimecast-MFC-AGG-ID: Ro12P1wvMzWuEbhL9o1ZUQ_1761593082
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427a125c925so2535370f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593082; x=1762197882;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e58DvebilYhZuqhMmqG9yr1jzlYsH5UePdTi/B++WBI=;
        b=PbE2FnBEM54Rg9B5k53NmSAj/aqHwZxWdBxXFYgA5ENUxGdeEOla/zweD9+/tl7uZC
         YRynpHkprl4/sQVzEEztKrG4Uvh7Q++B0G/IJeSxmUD3p41jJteCuXjQL2lR2+9U2eOS
         lalhlsla1IjmiPVImPhJ9jHOUKsLsHxBsm2mrRyWWw0NoNr4Yb8ocJwSz02yskr2WqYF
         PMfjKZdTyoMwe2vPXFaCLYx1nqUCsVDwG8fNy7MPxPjoKXd2pb2QNenpWtZ3vHTQCYom
         n3mOWszed+3e6peWPKEsbCIFBmdNWnEAGe/ZbpIgVw8XGT0rvQ/Sfge6QNLH0XhIzAYk
         +7jg==
X-Forwarded-Encrypted: i=1; AJvYcCXClqZYjAUUEToIiWfAciedqYmnb6WaBdWynq96rguCLvus45heP3Jh79gMDk3oeeId7UqJRJSD/qOdaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uo7bRc80FQafsxMcpE1VW61OGddMB1cnvlheFBDds0C6b03+
	lRHqlTnUMhlgKXsO7dD3fDShyI7F5n/UUP/hHOImJETzikBw1pAcmYEgrmzz9TwM4gI8NmlWGvX
	R7euYO/yLhl9A6vYnDeguTA4wO1Y5fuDa/5E++YYoC8RUzRRH1znpr+O+aIHrpt0U1Q==
X-Gm-Gg: ASbGncvqHtbC88gqidwFvoxmdbkY/D1svwBjPJgMUvsvfOvO4TbU64Jx2D/FgSYpwsO
	Y+efI9iLMcVyThmRfpsCMm9VfN4mPa8CIRqEWDHmpMYBQ4v3HTIc8UC07P7/DC97AcuSXb+j/RT
	v+R0x4Vw14o0fSX1Jb9U4LaJEdawr0q2CMgs3bmhFg8m5NmrVusxQ3SGHHIC3rdXnrzsVpacPoW
	g0oCoeG3JqrgEOt0fNV3pis6IOyMuMw/cidvcCLleeSTAodyobVzQP8B3/6JPd/Hw6bVmco+ak6
	l2di76FrmOCDIFQv+cGrKUCTt/GaXsfTnGq/CuMjPE5fistf0hQ/7ERyIHDADxp/YFhONWbtmVy
	9wJSGw5PYnJaWbA6FkQHsDBeU7J2pshWmei3sru5cGVyIdkv1Nok1FOfFSW8qK2t24i7dHLOkyU
	oSV6CnvAN9O2Jb6Pi0KeRb6AoXj3k=
X-Received: by 2002:a05:6000:310e:b0:427:699:a9cf with SMTP id ffacd0b85a97d-429a7e7c2ecmr756556f8f.33.1761593082164;
        Mon, 27 Oct 2025 12:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmYO5y4v58+ZSE63Crr2PZi/3WTpkjLTjdfIsd5tClOy8zlTOiogUy6ohkLE34sEfq/MC1Qg==
X-Received: by 2002:a05:6000:310e:b0:427:699:a9cf with SMTP id ffacd0b85a97d-429a7e7c2ecmr756531f8f.33.1761593081711;
        Mon, 27 Oct 2025 12:24:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7dcsm16467040f8f.11.2025.10.27.12.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:24:41 -0700 (PDT)
Message-ID: <276b70aa-9853-40cc-8e7d-e790166706b5@redhat.com>
Date: Mon, 27 Oct 2025 20:24:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm: Introduce can_pte_batch_count() for PTEs
 batch optimization.
To: Zhang Qilong <zhangqilong3@huawei.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, jannh@google.com,
 pfalcato@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
 <20251027140315.907864-2-zhangqilong3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251027140315.907864-2-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.10.25 15:03, Zhang Qilong wrote:
> Currently, the PTEs batch requires folio access, with the maximum
> quantity limited to the PFNs contained within the folio. However,
> in certain case (such as mremap_folio_pte_batch and mincore_pte_range),
> accessing the folio is unnecessary and expensive.
> 
> For scenarios that do not require folio access, this patch introduces
> can_pte_batch_count(). With contiguous physical addresses and identical
> PTE attribut bits, we can now process more page table entries at once,
> in batch, not just limited to entries mapped within a single folio. On
> the other hand, it avoid the folio access.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   mm/internal.h | 76 +++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 1561fc2ff5b8..92034ca9092d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -233,61 +233,62 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   		pte = pte_wrprotect(pte);
>   	return pte_mkold(pte);
>   }
>   
>   /**
> - * folio_pte_batch_flags - detect a PTE batch for a large folio
> - * @folio: The large folio to detect a PTE batch for.
> + * can_pte_batch_count - detect a PTE batch in range [ptep, to ptep + max_nr)

I really don't like the name.

Maybe it's just pte_batch().

>    * @vma: The VMA. Only relevant with FPB_MERGE_WRITE, otherwise can be NULL.
>    * @ptep: Page table pointer for the first entry.
>    * @ptentp: Pointer to a COPY of the first page table entry whose flags this
>    *	    function updates based on @flags if appropriate.
>    * @max_nr: The maximum number of table entries to consider.
>    * @flags: Flags to modify the PTE batch semantics.
>    *
> - * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> - * pages of the same large folio in a single VMA and a single page table.
> + * This interface is designed for this case that do not require folio access.
> + * If folio consideration is needed, please call folio_pte_batch_flags instead.
> + *
> + * Detect a PTE batch: consecutive (present) PTEs that map consecutive pages
> + * in a single VMA and a single page table.
>    *
>    * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
>    * the accessed bit, writable bit, dirty bit (unless FPB_RESPECT_DIRTY is set)
>    * and soft-dirty bit (unless FPB_RESPECT_SOFT_DIRTY is set).
>    *
> - * @ptep must map any page of the folio. max_nr must be at least one and
> + * @ptep point to the first entry in range, max_nr must be at least one and
>    * must be limited by the caller so scanning cannot exceed a single VMA and
>    * a single page table.
>    *
>    * Depending on the FPB_MERGE_* flags, the pte stored at @ptentp will
>    * be updated: it's crucial that a pointer to a COPY of the first
>    * page table entry, obtained through ptep_get(), is provided as @ptentp.
>    *
> - * This function will be inlined to optimize based on the input parameters;
> - * consider using folio_pte_batch() instead if applicable.
> + * The following folio_pte_batch_flags() deal with PTEs that mapped in a
> + * single folio. However can_pte_batch_count has the capability to handle
> + * PTEs that mapped in consecutive folios. If flags is not set, it will ignore
> + * the accessed, writable and dirty bits. Once the flags is set, the respect
> + * bit(s) will be compared in pte_same(), if the advanced pte_batch_hint()
> + * respect pte bit is different, pte_same() will return false and break. This
> + * ensures the correctness of handling multiple folio PTEs.
> + *
> + * This function will be inlined to optimize based on the input parameters.
>    *
>    * Return: the number of table entries in the batch.
>    */

I recall trouble if we try batching across folios:

commit 7b08b74f3d99f6b801250683c751d391128799ec (tag: mm-hotfixes-stable-2025-05-10-14-23)
Author: Petr Vaněk <arkamar@atlas.cz>
Date:   Fri May 2 23:50:19 2025 +0200

     mm: fix folio_pte_batch() on XEN PV
     
     On XEN PV, folio_pte_batch() can incorrectly batch beyond the end of a
     folio due to a corner case in pte_advance_pfn().  Specifically, when the
     PFN following the folio maps to an invalidated MFN,
     
             expected_pte = pte_advance_pfn(expected_pte, nr);
     
     produces a pte_none().  If the actual next PTE in memory is also
     pte_none(), the pte_same() succeeds,
     
             if (!pte_same(pte, expected_pte))
                     break;
     
     the loop is not broken, and batching continues into unrelated memory.
     
...


-- 
Cheers

David / dhildenb


