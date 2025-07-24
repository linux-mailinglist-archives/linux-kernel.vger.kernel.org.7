Return-Path: <linux-kernel+bounces-744758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7ADB1108F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56261C2822B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F132EBB98;
	Thu, 24 Jul 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agjxWxcD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF962EB5D1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379850; cv=none; b=Uiq182F/5oo4Pfq8Hf2LkhB0pNsx2va4VYXSRp48RJiVvbUOa1UBIpfH0l0vQ3k9R3jEE+Ryy4AM72nN/AdREfQ9isM3mO66rttdCVWZQ55cehn7QUqfHCzUa4Al2TwjyybdaSBX5V+D550Z9q8KfMInYiwiFRAGtpoUOaHdKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379850; c=relaxed/simple;
	bh=hiC/MtLyH7pIkS662+wgGRCtjpXCbtrdBY8jKRwVKsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EthuDgHaVuPMZIEhgdPhTXOw+YngtbqtPYv4qTd5ZTaYiPoycxGnvD6ta9RGJkIympfaP94hReeSGvhdvcRQeMrBwAgAFCG/OsQVm2A7yXt1kF32wlTxEWeY3tneEu0zrbqSvk4UJJE3WU/au05aWkc6n3DqEzkuBOryZMq3eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agjxWxcD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753379847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wRK9xapkpxiG3ok3o7+uMUAIEIufkkbPdChBgAqvuRU=;
	b=agjxWxcDZPl9bCXAieIoa24SH9T9omtK7KHP/jpMKE9cLSeG5kgswsK0bHjMrysD7boPy9
	5lnaSqW2JVjOX1QnWk0ACDJ9BYJaW1y8YodBDfRhg+l4dwv8J/ryJGpNIriBQ9pAh1w1v8
	ebBtsZXASFxBwwZHx0TQcYK9t6WrgTw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-96WwWDdVME6wJ2RjhxPZmA-1; Thu, 24 Jul 2025 13:57:26 -0400
X-MC-Unique: 96WwWDdVME6wJ2RjhxPZmA-1
X-Mimecast-MFC-AGG-ID: 96WwWDdVME6wJ2RjhxPZmA_1753379845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso9073995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379845; x=1753984645;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wRK9xapkpxiG3ok3o7+uMUAIEIufkkbPdChBgAqvuRU=;
        b=shIyoyPTACWUg2g4tSbaHVKWhiEejrwEyxAlqlQjbjeaKX598a/UA9OWTz5sn4NcU8
         VL3fHHC0xyzV+ZD1TfC+UWc7naNFWu8uMqYYjHJ0h3ULUn6/rIaDDVJJySKO568eaZEO
         JYmu1vdNBElXO6lFVqfg2viR5gCjaA+CFisven6DmEMh5e9kOaW7ndsLgWmuQhts1Bpk
         glca1M2ktyxACT4fxkbZuTFQnRQk8ISDF7Uz06f4JWmSTK18LO2vMCmeSKGgmxCuSVZB
         T01oeRphkSJZTK5mGB0YErFyBGw2l3kNk4K+c9fCpkgIWAHqgCWpfkoQbjfncDFSCdqb
         Wy0w==
X-Forwarded-Encrypted: i=1; AJvYcCU0fz+sa1SSLf9iA6K9qiz3Ck6TLi04eDbeI2z1fh+pdQ/cDIJlHxdMu69vlYyhYlKa/5rucrZ14xgJ6hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivkOuCNx700DR6qveoSQcjwpCYjwJpW4KxSHvhdSueWvDMj6t
	Uk9OMCracAtzvjcKkGWsxX4wYNZW4SzOrgTwCYU76h7MeFI4+5Y1ePQdWHcVv05Q4TJcc897+Pa
	LzE3iX0iJFJ10n7jh/pdNGIceh3sv+LPWdaRRMuvLYbOVC7d+uyown0cIjiL82i3dmA==
X-Gm-Gg: ASbGncsbcTx1SxZkye8N/rvyrwwZNpoIEkvtPSKERRXUu07d4wXSEQAOiOO42MRP96q
	8wGcNA+70YE6AScMZRY1D1mdrmZBFdkIWI6t6tJpZWV0TQB5CiOy9pEH1wq7E3a1F35R/WwMXIh
	M3QyPUhG9dN3s/4h77TU/cai/5aFMOJhgY9ZKnvCk4UfiIXmpJtl4nUSUsuTqvRS/r3fl/H6v5E
	QcnEU57NfsiTSQj6Uz+7BSq2nSBt0C3svhRshwYfopSN4YlU7vh1xBqbOJeAKIoVR6PSxe9cqXt
	Q3QSodVwp5MoP3/0L2nliV1OVXrYDGlgENBVdWgiL0tOay5UfPJLF2Oo1XNOoJJjqvtYpi2xqgT
	2N1y6w5hVx3nXJwSX0LVFofraFe7op74s9UuXC9vflk2AG9toKgbauoiiXkLDWBgKsI4=
X-Received: by 2002:a05:600c:4746:b0:456:d1c:ef38 with SMTP id 5b1f17b1804b1-45868d65ee7mr64291515e9.24.1753379844704;
        Thu, 24 Jul 2025 10:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfjOdTZiPpdFAYtJlwTpGspMWGFs2Qa3+f5r9W+Fx2Z2Mo43vNq9jgGwIN7O1JQ1Gg1XRvg==
X-Received: by 2002:a05:600c:4746:b0:456:d1c:ef38 with SMTP id 5b1f17b1804b1-45868d65ee7mr64291235e9.24.1753379844177;
        Thu, 24 Jul 2025 10:57:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705ce685sm26933245e9.30.2025.07.24.10.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:57:23 -0700 (PDT)
Message-ID: <0a70058f-e2fa-4f83-ace5-f58df589ac46@redhat.com>
Date: Thu, 24 Jul 2025 19:57:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] khugepaged: Optimize
 __collapse_huge_page_copy_succeeded() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724052301.23844-1-dev.jain@arm.com>
 <20250724052301.23844-3-dev.jain@arm.com>
 <83c00fa9-37a3-4024-b3d1-20e7749b06c9@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <83c00fa9-37a3-4024-b3d1-20e7749b06c9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +			if (folio_test_large(src)) {
>> +				unsigned int max_nr_ptes = (end - address) >> PAGE_SHIFT;
>> +
>> +				nr_ptes = folio_pte_batch(src, _pte, pteval, max_nr_ptes);
>> +			} else {
>>   				release_pte_folio(src);
>> +			}
>> +
>>   			/*
>>   			 * ptl mostly unnecessary, but preempt has to
>>   			 * be disabled to update the per-cpu stats
>>   			 * inside folio_remove_rmap_pte().
>>   			 */
>>   			spin_lock(ptl);
>> -			ptep_clear(vma->vm_mm, address, _pte);
>> -			folio_remove_rmap_pte(src, src_page, vma);
>> +			clear_ptes(vma->vm_mm, address, _pte, nr_ptes);
>> +			folio_remove_rmap_ptes(src, src_page, nr_ptes, vma);
>>   			spin_unlock(ptl);
>> -			free_folio_and_swap_cache(src);
>> +			free_swap_cache(src);
>> +			folio_put_refs(src, nr_ptes);
> 
> Hm one thing here though is the free_folio_and_swap_cache() does:
> 
>          free_swap_cache(folio);
>          if (!is_huge_zero_folio(folio))
>                  folio_put(folio);
> 
> Whereas here you unconditionally reduce the reference count. Might this
> cause issues with the shrinker version of the huge zero folio?
> 
> Should this be:
> 
>                          if (!is_huge_zero_folio(src))
>                                  folio_put_refs(src, nr_ptes);
> 
> Or do we otherwise avoid issues with this?

(resending my reply)

The huge zero folio is never PTE-mapped.

-- 
Cheers,

David / dhildenb


