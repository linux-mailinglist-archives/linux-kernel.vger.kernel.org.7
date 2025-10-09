Return-Path: <linux-kernel+bounces-847385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C2BCAAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62093C2815
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA0257824;
	Thu,  9 Oct 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFIAxBGM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8A2571A0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037991; cv=none; b=SYRuO6R4KSNKVpB3vWwEBuFhVuKA6KYgIFz+rUhlnkF+XopMxOtZN+omqo2kFNFSal7XEikGvaZeZg5jx9WSFk3tcsqbCLLmPS5hijcW/bRSZnfnzflxvdpIRQdSZcNSx6AmVsofgo6D5MewR+glxtITMApQRCzXhPc/51e07Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037991; c=relaxed/simple;
	bh=7q2YWJYpQaCZUvR/ZTZ8el7P1YcW8PJr6NQTIwA6NmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiqIln/PucaJ8pp5izhVQopI2ZWA8NjUcgPpb8g1rS2hFKok2ycyM2+/2GmV3LsCIcGoA75otjN5xqXckHfxbOAnzoLxBbMjUzu6bndkWfsOctkBdRYj2HJANLR9ahTuiH6Yqz7Ee9LE4obNVQnBD/QMTM/jU8UFZFpnqomzAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFIAxBGM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W2B8vT5pvQD+mfwnpX1+1iKZS8FrGv7Z2N6yCTBVfn4=;
	b=LFIAxBGMV98uHqmE4bFCz+/fZ257RN4zFW4q4RsnSFozIJqvToaylGEf4VRXJguiw6tW9k
	6ZU2X0dlZ9B+wKkjLqsuBWJeMJr3DTp+35q57HD9keJFsEPjqMU92Ims4N3CRxPs/+xYTj
	PWeWGnw3MbS9xv26aKAILOKXCPlkSrg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-fBisJp-KPhqm-vVaaKJUeg-1; Thu, 09 Oct 2025 15:26:26 -0400
X-MC-Unique: fBisJp-KPhqm-vVaaKJUeg-1
X-Mimecast-MFC-AGG-ID: fBisJp-KPhqm-vVaaKJUeg_1760037985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so780250f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037985; x=1760642785;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2B8vT5pvQD+mfwnpX1+1iKZS8FrGv7Z2N6yCTBVfn4=;
        b=bEzI8ix9eqwt9kZQrxIFJ+SQLVXMq+VDNsyJroVdivUsPozEp7YQjOEgK0uD78a+i9
         WBXjrvpOHc4JYxu5o1V9V1aXdVA0ENbAJfg5dK33e2XkA9lgKf4z0VPJmMDwY4s3OqT9
         JGgC+uksc5jvwtjvoF5mbP/plofafI82r18yGlPsQbJckfTApamPMEHjHUL6X4biwCeQ
         zJm94hUesdRA75mNXDgWWbPvQOCGt41/s8uOxfjS7r/5Y+kVjjw4rcrvC2GhRhuYRh12
         yVMgQpl4lsf3hZHkPl6mBJ1+yLW3hLdY6mKn+LAnWQJJeoOSn4vYTo6Ud5uJ5G1Gru93
         x6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlD0GW1efFesacOLo7JiLpBEy9OeSFanQaEACcM698gtSBFddmfexxLUg3o2CqmV6+N0OvZQViD/4E4/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEN3jHa+vG69Ja+RsnJhmkSeAMeOw4w/tv7KFFCW7SPaGQ9a+
	m1WPpUd6EUj6VbIkLn48ychwzZIDk2dYj9tDRzFuJMUxCsEdWhQQSxG8IPZsTRumksthAuCsVw5
	1UX5TX9ZBsadnSTrPo/DKRMJasAWjOdyZdnGJN4Js4PFs/JYdIhQP0zkxPf5gg77T4Q==
X-Gm-Gg: ASbGnctmgFoI60tZ2uZINIA6FId/ltfD+/6OnyG0xJsjFjq9YSwYr7Mcum4yowJ9KgO
	ujpflRHIanR6PGNwav6QiwIIMMBC9jGVIB5eEVfbQ2tLbqAmM5fQbw4kXMBftq02splZt7WYYIj
	rReBm/4DMsvUOlvYbKRaKgP3BF9if8Rh5sMOS7OnW/+ZRGyvgrHtIlts8N/I/whO+q1+PrLw61T
	ifGd/1+N6WKjVNZOGuEwX1j8aqIj3lfjVcZkgNc4zfdHhmwt0yJy/wGLYNDfe9egRSVfyALYdIe
	PqTvksC0NcRtgo6ROO+2aEmJqSlOaocH9FL5T8vdkF1xh6rJdTAHVQxmdYDE+EPi+6cfMPD339o
	AvR96B/I/
X-Received: by 2002:a05:6000:1861:b0:3e7:4fda:fe0c with SMTP id ffacd0b85a97d-42666da6dd4mr5743429f8f.15.1760037985160;
        Thu, 09 Oct 2025 12:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr53Oq5rgi0BWcMZ9Fm+pXJK59Y4s0sHr9nDLiWoMs2OEe75OxVzju/Ffcx6q/sukO2F7BzA==
X-Received: by 2002:a05:6000:1861:b0:3e7:4fda:fe0c with SMTP id ffacd0b85a97d-42666da6dd4mr5743402f8f.15.1760037984752;
        Thu, 09 Oct 2025 12:26:24 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm434778f8f.30.2025.10.09.12.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:26:24 -0700 (PDT)
Message-ID: <646c392c-0a3d-46f6-9d81-c007d6a736da@redhat.com>
Date: Thu, 9 Oct 2025 21:26:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] mm: Introduce pure page table freeing function
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-5-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250919054007.472493-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The pages used for ptdescs are currently freed back to the allocator
> in a single location. They will shortly be freed from a second
> location.
> 
> Create a simple helper that just frees them back to the allocator.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   include/linux/mm.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3db3a5ebefe..668d519edc0f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2884,6 +2884,13 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>   }
>   #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
>   
> +static inline void __pagetable_free(struct ptdesc *pt)
> +{
> +	struct page *page = ptdesc_page(pt);
> +
> +	__free_pages(page, compound_order(page));
> +}
> +
>   /**
>    * pagetable_free - Free pagetables
>    * @pt:	The page table descriptor
> @@ -2893,12 +2900,10 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>    */
>   static inline void pagetable_free(struct ptdesc *pt)
>   {
> -	struct page *page = ptdesc_page(pt);
> -
>   	if (ptdesc_test_kernel(pt))
>   		ptdesc_clear_kernel(pt);
>   
> -	__free_pages(page, compound_order(page));
> +	__pagetable_free(pt);
>   }
>   
>   #if defined(CONFIG_SPLIT_PTE_PTLOCKS)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


