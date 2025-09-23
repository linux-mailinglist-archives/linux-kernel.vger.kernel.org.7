Return-Path: <linux-kernel+bounces-828576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F03B94EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E18179309
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2B3161B3;
	Tue, 23 Sep 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGjCSpbh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0930FC3D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614820; cv=none; b=sbTSs+OIZS82FcyIqfgX8d1fLtn46f8sfWBOWXt4xR1I4R0Na6Zn/c5lb2Y7xvISPPv4X5kR22+jz3Rvuh+2/ivPxcuUPfX8Yw8kut+mmacLSqTHLYUbMWL2cY7TjNU/93XUpegvyRkTFEqv5eyJehRXbdrgJqaXlBLmoNnld5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614820; c=relaxed/simple;
	bh=XlQx6Kp/k0h15deU0Ulv+/urrT25u/w6CQ6929wizH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGfz+DnwQ7dErQl61LWME2X4TjFotyYQIVXzOYpKBQ1qwR0fViXyNRxQCu6CceRHh7bm2G9V1A0ZxM+YQxyPH64JMhH2WRZB5aaV7qCiCbdJmKZUEoWW85L96wObuItp7bBnshtkBibLqMx+SGosVvXHpB0iKBB2O1LhULcvRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGjCSpbh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758614817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oC5YbJTUl5o3B/drvPPjgzi8/zGrudS5oO2LRTa23v4=;
	b=DGjCSpbhzeyU+fZyxJMCLmzXjgLegXP7IvnuHGfAvC8OBJRTv0bPJ4eEqARXqoLjBYGP1x
	SrSNaJaoCZSiRkxY6DHMw4nNDId2V3gNykBENm3hW+FqXDmtwtPFPC1KiR/mX84NMVoDLk
	Ge92OBIxnXt5YI6a83O0aTfASQ7/+eg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-9VxJi6O6OjK9nPlg1s3r6g-1; Tue, 23 Sep 2025 04:06:56 -0400
X-MC-Unique: 9VxJi6O6OjK9nPlg1s3r6g-1
X-Mimecast-MFC-AGG-ID: 9VxJi6O6OjK9nPlg1s3r6g_1758614815
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso30909425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614815; x=1759219615;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC5YbJTUl5o3B/drvPPjgzi8/zGrudS5oO2LRTa23v4=;
        b=T+gamj6VfiUd5CwfuWO+ZF1LAH9AT1C+MfIV+ig1OBA5IglPLlaKiVQCaYF5W75OWg
         ktcm57iIu6X6H0hyUmTXlbVlz8m7PvyNiLV7dEjUKxsbT/3m17dZGDMO3M3A3raG9MZI
         ry0Fqs47HSty0vcqFmPipp3oUAsXy5W6c6p1j6A8AHRRCmrlt3Nbfu1IhC5wYGwQRSHx
         bFKTTNJ1Qsm4XuNfV6VjFRrCJTtaUJqDtEppWIJ9oiza3zLrMqB0eQj2dRSHUHNKk6Y1
         +pdsdtwRKODL9u2LuZf4UzUaycwWEuK+Ktu7+Nout93mdt7Gxzyk+ZAGu3ONoHjX9br+
         fxVw==
X-Forwarded-Encrypted: i=1; AJvYcCWqGl+LB0IakCa8b1eWoaaevEEeMnJI1t5w+OswHePSi35pRdn8nCPUGqUfH31QeWK0fhhKK+wEA941n9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOsCGaCKKcFUt1r2GUq+jYkO5MZY6tnv1uR0rKaTqHhFfprez
	1GrPCgfJEqEzDyIBlu1Yg3VBD2A4NhS0ilzX6r8RLXKpJnfZkW4Uc+DNYObfjW2u8vamUJoI6ns
	425d/qv5OqEEYY3T0Eje+AFCZloZ3vX/PRTC6CgrTfOObvz9qvwMyVwqyU72eKPg0Eg==
X-Gm-Gg: ASbGncuL020XL+NlRZ16eK0237owdHYhOg7tJ81s3a7bDjGavtq3sDJv9wuU+unMoYH
	xsj6s8pisT5W3MFzASOHVJgkoYxTUuioRdFwo8OL+pGFCwSfRfP7CLZs3qTAESYLhFr5uTW0sui
	FahIoNGd7eFpc4Rpzt221quCNEXQer0yY/QEIxcpwr3Wu8nlUMTmMcoTQCYU/WbvfFQw00Kj7lM
	Aa6rAS6zVTHL7AHi7qmZB7Ndth5yx/PKGOXlI3esmi2P9uZdmIKod7dZzg2iyUlPgYN+vligwnl
	UYzOOUI4psJWky8EMBUujoM7Yq1ZqHyRhMUQr0EyM+7dmrQjmxPh+uJdGA6Pre8GEHLn8D4=
X-Received: by 2002:a05:600c:8b35:b0:46e:19f8:88d3 with SMTP id 5b1f17b1804b1-46e1daacc3emr13705935e9.22.1758614814728;
        Tue, 23 Sep 2025 01:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpV5l2qp0v75m1A9iNXqDVbwnvdopxtyZaLoVTR/ccyKImNZPFhi4VTpOcRMLz+xHn9ktuqw==
X-Received: by 2002:a05:600c:8b35:b0:46e:19f8:88d3 with SMTP id 5b1f17b1804b1-46e1daacc3emr13705635e9.22.1758614814281;
        Tue, 23 Sep 2025 01:06:54 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fd57.dip0.t-ipconnect.de. [79.241.253.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e20a3a3a3sm9448595e9.19.2025.09.23.01.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:06:53 -0700 (PDT)
Message-ID: <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com>
Date: Tue, 23 Sep 2025 10:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-12-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917152418.4077386-12-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 17:24, Ankur Arora wrote:
> Define clear_user_highpages() which clears pages sequentially using
> the single page variant.
> 
> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
> primitive clear_user_pages().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   include/linux/highmem.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6234f316468c..ed609987e24d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   }
>   #endif
>   
> +#ifndef clear_user_highpages

Maybe we can add a simple kernel doc that points at the doc of clear_user_pages,
but makes it clear that this for pages that might reside in highmem.

> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
> +					unsigned int npages)
> +{
> +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
> +		clear_user_pages(base, vaddr, page, npages);

Single line should work

		clear_user_pages(page_address(page), vaddr, page, npages);

> +		return;
> +	}
> +
> +	do {
> +		clear_user_highpage(page, vaddr);
> +		vaddr += PAGE_SIZE;
> +		page++;
> +	} while (--npages);
> +}
> +#endif
> +
>   #ifndef vma_alloc_zeroed_movable_folio
>   /**
>    * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.


-- 
Cheers

David / dhildenb


