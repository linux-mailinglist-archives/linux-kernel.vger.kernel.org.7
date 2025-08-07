Return-Path: <linux-kernel+bounces-759425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B578B1DD63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA1F7AD34C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5E273806;
	Thu,  7 Aug 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eboI3kMP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F4262FEC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593859; cv=none; b=cGgCpb8h/+DNJhHC/8FEfd0Qyb8lqacBqCxm+j0/H8LGwZ5g+4CsWGtpU3CqbnwAscm7u4lVIvdW9nrseBP6USGshv0mH714HmOO3GexKaC4LsqGaXIFU0nTRL016JD8MlA2uaoMGiT9FNCZ/WP0WBtDEDCeGgtaWaXOPE7oE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593859; c=relaxed/simple;
	bh=xyUQycHeuwY0wQKeDMoDXcwsO38ofdQm601Kde4POtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVPq/pLwtL9T3uQHUbZdgb53yKIYNb3lBnyh8hF8FuZsv58UFm88V7XMl93MyymIp0cuB6g4tQHtf5us1pqbO9k5D+NmONydfQapQG3tBGiujILsC6K2Icmy2+9v9HA1Mf7QzbN0Shc/3tR5VY8iF70ucE8hyllOchSh/6vLonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eboI3kMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754593857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a6eH69LxmXMYsaPkPvzCN+AdEuwzJKY4+tn/p+ORHaU=;
	b=eboI3kMPpp/Ts7mDAD6unbdUPQLdDQkpyHVMtDXL2V7gnyTGhkwOYwcvH/UmXgat/hd+O4
	GIYmEKcxd9msG3zZJ4HCwojTqRuBWcdQrd/Sg5Rp+CWBdEgUtMO2aZb+qMhLsl5Dg8cbzc
	RkGSN0hqeWnVgEk3b3LF/Zza9zerRF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-AvTV7sPzODmsKNVXKORUGg-1; Thu, 07 Aug 2025 15:10:55 -0400
X-MC-Unique: AvTV7sPzODmsKNVXKORUGg-1
X-Mimecast-MFC-AGG-ID: AvTV7sPzODmsKNVXKORUGg_1754593855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e6c564fdso6034295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754593854; x=1755198654;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a6eH69LxmXMYsaPkPvzCN+AdEuwzJKY4+tn/p+ORHaU=;
        b=GbSq2LRJa6zHDaO53LO9rO228iy0uzHWT6wssdTNx7SQzJEzRvxKHriKkW0l/0o+YK
         wXmKU5UgFyYYRCVFzSbIAV36jbvdEL//jw35Y9KjmVEGSc3rmzZtseIARDjXGq8NyBDX
         Bky6uDni9s+nT0zwVhW78YH0VGrS3EQMwLTBIMCNebhXfeUEbD/3WDn6qfSX79qLga5j
         rXBKkzPIQKRtkmmQX7hprSFS5LQyDFZ18ouQwLVaVZjJpeajS71wB2cppNsX5EleeIEE
         M03wafnTFPs+9X+WWXgVPcWrP+SHOeHgvQBQKSbzjuILBqpqE6qcwN6Ofs2K43XbiuMT
         MQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhX8WdZaPEQMGj8Y/xEjlGitz233XylN/oo3ugLqaaWnNZ7wZJYa4R9Bb0nVz195K8AviP0FBD8X2Md/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6z2a9MoZ5FI4ZOPdsVy/0AAPxAU1HF3fAj1dMSQ2YA2TGSvW
	lMsM5BJnJpUL/Fl25OWQ5lh8ggw3TUd4K6cG/XxSIAHLGrPP1bt0iqTsEVBBGs2CpYms27sUbRb
	13Nmo/UBycYwjMJd+CFXS2mchoqeIDy2tVHz55tepn7dkr5dK8kZhobYNJ4gLFov3Ug==
X-Gm-Gg: ASbGncvP6ccKkpKq0p8yslcjeVcnFsC+hS8YFfecbDgHBmD7SYgLPdeym59sOZVh9SM
	dylLVoktTIDFN64Hk8lOVRbL4Z2a7cjF7tcU5Ou1+q66+vsEpUxuOt8qnUp2rb93GalG0eOoTq3
	c03QyjiBDKnlSiO+sxb1iV5PMJUYDblL51ajTvd9MHEHnUu7OC2tSmoJizwwNDzwKtpQsxmPDA/
	4mcwrswfOFUxxn896Z2LoaaNgvL/Wd7F9Qm8aBPOFbTZSCTACQUZmfbxrHzuLeuITP3e5sO7eqm
	diSh9tcZ1u6Rj+0Hy37RHruCVmyPctfJpyYmmlnoIp5cVCj/NsJa5LThV2qa1LG/+sjopzdZK0g
	ymcfG0Ob9Os4I3y8pXK0OQkLSQsmN6E1dVNDXMHsJyfCjVxx0zAR7Y19Jcul5B+DvvLc=
X-Received: by 2002:a05:600c:45c7:b0:458:c002:6888 with SMTP id 5b1f17b1804b1-459f4fc0ee2mr580235e9.32.1754593854640;
        Thu, 07 Aug 2025 12:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfskDxx2ZKvsf//OfNBtDtOmUppN3tfOBPkKr36e+s4etTTUVcYCSpV3IOuXQkGCW8CKEmQw==
X-Received: by 2002:a05:600c:45c7:b0:458:c002:6888 with SMTP id 5b1f17b1804b1-459f4fc0ee2mr580035e9.32.1754593854168;
        Thu, 07 Aug 2025 12:10:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de91ea4csm158838245e9.10.2025.08.07.12.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:10:53 -0700 (PDT)
Message-ID: <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
Date: Thu, 7 Aug 2025 21:10:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 20:58, Lorenzo Stoakes wrote:
> It was discovered in the attached report that commit f822a9a81a31 ("mm:
> optimize mremap() by PTE batching") introduced a significant performance
> regression on a number of metrics on x86-64, most notably
> stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression in
> number of mremap() calls per second.
> 
> I was able to reproduce this locally on an intel x86-64 raptor lake system,
> noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
> 3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
> 2,131 or 2.6%) - a 43.3% regression.
> 
> During testing I was able to determine that there was no meaningful
> difference in efforts to optimise the folio_pte_batch() operation, nor
> checking folio_test_large().
> 
> This is within expectation, as a regression this large is likely to
> indicate we are accessing memory that is not yet in a cache line (and
> perhaps may even cause a main memory fetch).
> 
> The expectation by those discussing this from the start was that
> vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
> culprit due to having to retrieve memory from the vmemmap (which mremap()
> page table moves does not otherwise do, meaning this is inevitably cold
> memory).
> 
> I was able to definitively determine that this theory is indeed correct and
> the cause of the issue.
> 
> The solution is to restore part of an approach previously discarded on
> review, that is to invoke pte_batch_hint() which explicitly determines,
> through reference to the PTE alone (thus no vmemmap lookup), what the PTE
> batch size may be.
> 
> On platforms other than arm64 this is currently hardcoded to return 1, so
> this naturally resolves the issue for x86-64, and for arm64 introduces
> little to no overhead as the pte cache line will be hot.
> 
> With this patch applied, we move from 81,503 realloc calls/sec to
> 138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
> accounting for the variance in the original result, this is broadly
> restoring performance to its prior state.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.com
> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/mremap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 677a4d744df9..9afa8cd524f5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -179,6 +179,10 @@ static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr
>   	if (max_nr == 1)
>   		return 1;
> 
> +	/* Avoid expensive folio lookup if we stand no chance of benefit. */
> +	if (pte_batch_hint(ptep, pte) == 1)
> +		return 1;
> +
>   	folio = vm_normal_folio(vma, addr, pte);
>   	if (!folio || !folio_test_large(folio))
 >   		return 1;

Acked-by: David Hildenbrand <david@redhat.com>

Wondering whether we could then just use the patch hint instead of going 
via the folio.

IOW,

return pte_batch_hint(ptep, pte);


Not sure if that was discussed at some point before we went into the 
direction of using folios. But there really doesn't seem to be anything 
gained for other architectures here (as raised by Jann).

-- 
Cheers,

David / dhildenb


