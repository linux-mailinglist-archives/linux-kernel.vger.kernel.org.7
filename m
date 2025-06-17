Return-Path: <linux-kernel+bounces-690274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB3ADCE14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37ADB7A25FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22D2DE20F;
	Tue, 17 Jun 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKArWCmJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E352E7189
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168039; cv=none; b=J9f9Wna+8bMPldxKXX5x2WHr2wIqVjwV/0HIZySlyL+EhvBOnD08INHnfGLdEQt20sZ57G7eUd8KcFR6aa3aVjoNh+mNBR9bIYMFtj436toAoREmIbX+j5p+U0lp/Dru2iTn1iCW+9Xhl4dLOO7g6k7QH5V+Ku/cax7MOTa7jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168039; c=relaxed/simple;
	bh=3KneNQy+7LnUK6MxYSz93/UV9xWUwtWWCkbCWT0OPEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grCn8isqGSiHunk8QYbz+O6+QQVDCnJuA5t9LSOWBmXW83TXeOvzXdyG8klOmXf17cOWcym3Yr4/seqWZQyNwskbi191fAcM8F2WohyE+5FB0bRtFQvd3vb5+2VleSKK1xoA8GtF3r9dIECVKQIr4d865yTdLVbumwbaiIAzFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKArWCmJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750168034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bp6ENcV0aA4vnCPH9W0BnZj/GXwwIDGb2kBXy/7zwAc=;
	b=WKArWCmJS5Wl35ZZQhw6y34OAZvbDD66dIBFNqukSv3ECL44yXV3nz4gflLEpT8P2+vKUx
	2HqathdYQSvZ493LFKorlm6cnlbO7RS2UAkPaY45Iyg2WLCWIaed2EH2rg4xpRxcUXzoyz
	D34cs6bVNow8DCHmG+dBK/eh6a80q4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-zsK-X74LMH2jFA33BN_Avw-1; Tue, 17 Jun 2025 09:47:13 -0400
X-MC-Unique: zsK-X74LMH2jFA33BN_Avw-1
X-Mimecast-MFC-AGG-ID: zsK-X74LMH2jFA33BN_Avw_1750168031
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d64026baso39674675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 06:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750168031; x=1750772831;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bp6ENcV0aA4vnCPH9W0BnZj/GXwwIDGb2kBXy/7zwAc=;
        b=mrSVeyFSUfuLYMMgmidkTEeBeUJF9SwPtnZDDSCPZq2x9BwmIxlXlX0e/HjaNl6m2m
         AgXM0aUP/seNSkiHIasnd4lfqCTYBLK8hUYkf9vKRnuAr//S1HYmLPd/kRCxdraEhwPo
         pbWNbawe2Zj3yKoq6l2K3WlcbiQvEdjcbXjOq//Oxb9q2fNptylSDWZE1eO/FweWXy8b
         oGEvbo/yzmgDYgUMv+7Gu1I3jzAMI1RtIfXp1ijV39ZxUwh88BwrbmdQ7Qwn4gBQWI+E
         Wcf9lg18jY9m9PipW5e4KbldEBxMY/Lzz35VVA5snGy0o+55XxZA+dxvjjfnZmGba01x
         wxKg==
X-Forwarded-Encrypted: i=1; AJvYcCWJsmtpArGiF52bbISX7Ns4t76sRtczn4l/Pi6Bl/uq5E+HhCF/QJ91aOVNCMY123oNohJjoabTI78u/p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXSllNV3Aet+gSE39rJsy0R/GYA0xWGxDWKNB18HLq828RZeJ
	9ayI88/mfdEJWKxCBj5bHqihZYKQHEBaHLAPtgnV+ViFQZ7JasqlFDm9OUwU2CgiNQ73VnLSm7J
	0zXIlGkwYPlcKlNxmatXLLPZLCOMFRIvDmf2LEYXJSA9Lq8lyHZQNoOlzvi10rPxeIg==
X-Gm-Gg: ASbGncsqY8KLANJwu/00jDL6UeQT02HpvH/WwueC9dEAcUVaTZPT6eMOMRVhBqXRZzo
	ldaohkLVqo1Uvd7VCnFBIkBjWGGmtIakQ5LFu2o8djXL2AyHRnxX1jytq2SWg1uBlNjyxXE0t2t
	YrPnyDLHeUNhSWrexL6ZaHBkgF6lNH13Ej0WAU1hS2e4/K+v0+gmY5sQkQPtLsJQhEa+aOcqDwD
	SQMB5VJUJm33oq6KRq/soVc7ulyePuQvs45RLeXcxsfKzmEIhTI84YHCl234ccCOQDlgNIn+JZ5
	zLGIAyC9BkNMQdWWbNWxAi+vhIZpATlPG/EVaZK/Yi/0pVlgZUWj67S87KS2W0XS9d4swGOml/M
	7X/CeWxvxVWQFc1/b9/g5cBKzhnXSNePNwxKqlNCfJo/jZKA=
X-Received: by 2002:a05:6000:26c9:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3a5723a3b1bmr11136835f8f.28.1750168031154;
        Tue, 17 Jun 2025 06:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVmSmymoptVLD56Q0F0aGhFd2deYP5b/9WMJydaeD500eQ6DyIM+aFL3Ip+nyZDxwm/Dcb8A==
X-Received: by 2002:a05:6000:26c9:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3a5723a3b1bmr11136812f8f.28.1750168030779;
        Tue, 17 Jun 2025 06:47:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2522b1sm174366915e9.25.2025.06.17.06.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 06:47:10 -0700 (PDT)
Message-ID: <ce2af146-499b-4fce-8095-6c5471fdf288@redhat.com>
Date: Tue, 17 Jun 2025 15:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] vfio/type1: optimize vfio_unpin_pages_remote() for
 large folio
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 peterx@redhat.com
References: <b88d58d2-59f8-4007-a6c5-d32ba4972bea@redhat.com>
 <20250617124218.25727-1-lizhe.67@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250617124218.25727-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 14:42, lizhe.67@bytedance.com wrote:
> On Tue, 17 Jun 2025 11:49:43 +0200, david@redhat.com wrote:
>   
>> On 17.06.25 11:47, lizhe.67@bytedance.com wrote:
>>> On Tue, 17 Jun 2025 09:43:56 +0200, david@redhat.com wrote:
>>>    
>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>>> index e952bf8bdfab..d7653f4c10d5 100644
>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>> @@ -801,16 +801,43 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>>>>>            return pinned;
>>>>>     }
>>>>>     
>>>>> +/* Returned number includes the provided current page. */
>>>>> +static inline unsigned long folio_remaining_pages(struct folio *folio,
>>>>> +               struct page *page, unsigned long max_pages)
>>>>> +{
>>>>> +       if (!folio_test_large(folio))
>>>>> +               return 1;
>>>>> +       return min_t(unsigned long, max_pages,
>>>>> +                    folio_nr_pages(folio) - folio_page_idx(folio, page));
>>>>> +}
>>>>
>>>> Note that I think that should go somewhere into mm.h, and also get used
>>>> by GUP. So factoring it out from GUP and then using it here.
>>>
>>> I think I need to separate this out into a distinct patch within the
>>> patchset. Is that correct?
>>
>> Yes, that's what I would do.
> 
> How do you think of this implementation?
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 242b05671502..eb91f99ea973 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2165,6 +2165,23 @@ static inline long folio_nr_pages(const struct folio *folio)
>          return folio_large_nr_pages(folio);
>   }
>   
> +/*
> + * folio_remaining_pages - Counts the number of pages from a given
> + * start page to the end of the folio.
> + *
> + * @folio: Pointer to folio
> + * @start_page: The starting page from which to begin counting.
> + *
> + * Returned number includes the provided start page.
> + *
> + * The caller must ensure that @start_page belongs to @folio.
> + */
> +static inline unsigned long folio_remaining_pages(struct folio *folio,
> +               struct page *start_page)
> +{
> +       return folio_nr_pages(folio) - folio_page_idx(folio, start_page);
> +}
> +
>   /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
>   #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>   #define MAX_FOLIO_NR_PAGES     (1UL << PUD_ORDER)
> diff --git a/mm/gup.c b/mm/gup.c
> index 15debead5f5b..14ae2e3088b4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -242,7 +242,7 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>   
>          if (folio_test_large(folio))
>                  nr = min_t(unsigned int, npages - i,
> -                          folio_nr_pages(folio) - folio_page_idx(folio, next));
> +                          folio_remaining_pages(folio, next));
>   
>          *ntails = nr;
>          return folio;
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b2fc5266e3d2..34e85258060c 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -96,7 +96,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>                                  return page;
>                          }
>   
> -                       skip_pages = folio_nr_pages(folio) - folio_page_idx(folio, page);
> +                       skip_pages = folio_remaining_pages(folio, page);
>                          pfn += skip_pages - 1;
>                          continue;
>                  }
> ---

Guess I would have pulled the "min" in there, but passing something like 
ULONG_MAX for the page_isolation case also looks rather ugly.

-- 
Cheers,

David / dhildenb


