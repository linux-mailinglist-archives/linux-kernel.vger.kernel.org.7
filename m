Return-Path: <linux-kernel+bounces-828588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02366B94F20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E906D1903DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482D314A7C;
	Tue, 23 Sep 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsBL3Q2S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0E26D4DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615266; cv=none; b=FIUh8knyjCbQkwyoCabFdFBvqSK3msKBt8IwOqtGfSZzJKEvyAx00jATCG1QEZrsq8CICiJHlooVfw6s4u3Tylu3nNvD0SgO2E6nvjXY2cofdSG5AEPDLOmMgdsJ/hlWPAqzPVXspR/vBtZ9/2xgCtWK8iUAw++F9C1rDQLhr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615266; c=relaxed/simple;
	bh=lsKljlqT7kDTfzNBiRFbA9TkMSj1tmbpCH6Kq2jFe/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBWNA/+UR01brdaN/Een7woG2huFR1qZv9seLO0FFKqSze26jk0u+6lwfLB85S+aRmj0T6XzhnieD6TXY3d0MhRs2EpLk/2eJSm1A7XNXdd0HbahOEN8fxffAOP3M6JO14Yz0Yh2dtZYDlZPA6Gm3lyn0R8NqQxKuZKE5GjOSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsBL3Q2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758615263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eyzu1dlx6+kRG0E/HaIaqepYdoWq+jcAQ8sNrE2lYVs=;
	b=BsBL3Q2ST8SGunQxdoEzNTvm/sDlP8MshJuzN0g3nFxjQlO5j5p9RMlHcpFzfpeH1NupSb
	P8qVesCbdbglL3zR4Zn55qHMX1B0+GAGenqxAt+muoSe9XXb89ek8eMGWInQKzBBqqS+iu
	ctOmDM8sChI8/DQl0Im1xDfM4Oc8L4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-4RCuhzCjOEmO4M70CmSaZg-1; Tue, 23 Sep 2025 04:14:22 -0400
X-MC-Unique: 4RCuhzCjOEmO4M70CmSaZg-1
X-Mimecast-MFC-AGG-ID: 4RCuhzCjOEmO4M70CmSaZg_1758615261
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1b906bf3so11665055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615261; x=1759220061;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyzu1dlx6+kRG0E/HaIaqepYdoWq+jcAQ8sNrE2lYVs=;
        b=X7pMnjCY6zSWOULX4m4HipJ4nUszg9i0Pl90wpurJJIOUvujGaOU/tmVuwuXH0vT2S
         JzjMIUsVlWU/5yoW24Ale5rbw+0gIL1fGrc1A4ZT0LBHj0/PdQRoHIRgON3y5/INa0Rx
         RfnK4fUyXmY8TPG1gSP8MYRaFI5fmH5IzQJmhCWqd8PKnInjdyfhSbKSmvJd6fJU92ZD
         ny0uod9Zgs1ZxHUBh7HFEQhNRldc7fiy7c6aFgPJ3PuIeNSbrbhOj+RT8EzbLNfAUUS6
         Dd5dDhWTC8OTZL3KnCMUZ/KiYM+4EHVvYJA97NYwMIznjZc11P+RXqfW5pCyYGvvvhcT
         QicA==
X-Gm-Message-State: AOJu0Yxny4JtQbijCrPBEhY7+cAfoyFZZWSZGPTkdacPjM4qjG/HnzSA
	jud0h6Kk7nAAR0hRxzVc0S6rmo5XzBW6wrWcg3uMPMcfD6WpuHpz1YU8nHHMkqJoGL0lOJEiHfw
	Oc5l/0zjluoVDgcmNbGKN1eOZtyEuQttEzinVyqYdjlWaNza5Rx9w8FeQI71gPxXDCg==
X-Gm-Gg: ASbGnctsnohCTJ8CZzU7KmMIjpYPQHEi2ivJhjaQWeYhOYS2cjyrSsaR0M1YifLOls9
	lYdqeAPxsiB+jdVHy+YXf0N6FK/MCeLD75pUq9J1mFCVAwfd1VZKdJp1uMoT0PQxFU5gghpf1gt
	VhJJ3r4BUSJAYxm9AgJo+tKIkRsBN57aLL6DiLh5Fnyb3iPhsemavmZvr0/hBWjEnuHCuyF8h8T
	frNHBcArDbybmlUCaTkcE1D84q97yq5E5E0AFnxLtsFdxSBueQsc//1TTVhc9lrvIxPXYTW6C/5
	4nVmUFvt047yxqK4RxNaNGnNMRlgiUXN60SbiEx0wkc3FIQ7GJvvotTm3399SEZfSyzsIbH4I5z
	kfxwb8fp3JOL742qlO1lhFc8mLqiK2Nngwlr3zTMtNGlNmI3QZblULy45aFmDaC5PeQ==
X-Received: by 2002:a05:600c:1395:b0:45f:27fb:8017 with SMTP id 5b1f17b1804b1-46e1d978957mr16716515e9.5.1758615260645;
        Tue, 23 Sep 2025 01:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZfMFYPJ6RFT/ih4jtnBu0Q+zWpM8gZCvkxnvk/Mc89Vf/8acIYF+vfUh4O1kBEqqLojGJQ==
X-Received: by 2002:a05:600c:1395:b0:45f:27fb:8017 with SMTP id 5b1f17b1804b1-46e1d978957mr16716035e9.5.1758615260156;
        Tue, 23 Sep 2025 01:14:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm232993015e9.17.2025.09.23.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:14:19 -0700 (PDT)
Message-ID: <cbe123da-b433-4c91-8cb1-7b19826939b2@redhat.com>
Date: Tue, 23 Sep 2025 10:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
To: Andrew Morton <akpm@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, tglx@linutronix.de, willy@infradead.org,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-14-ankur.a.arora@oracle.com>
 <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 23:44, Andrew Morton wrote:
> On Wed, 17 Sep 2025 08:24:15 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
>> Change folio_zero_user() to clear contiguous page ranges instead of
>> clearing using the current page-at-a-time approach. Exposing the largest
>> feasible length can be useful in enabling processors to optimize based
>> on extent.
> 
> This patch is something which MM developers might care to take a closer
> look at.

I took a look at various revisions of this series, I'm only lagging 
behind on reviewing the latest series :)

> 
>> However, clearing in large chunks can have two problems:
>>
>>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>     (larger folios don't have any expectation of cache locality).
>>
>>   - preemption latency when clearing large folios.
>>
>> Handle the first by splitting the clearing in three parts: the
>> faulting page and its immediate locality, its left and right
>> regions; with the local neighbourhood cleared last.
> 
> Has this optimization been shown to be beneficial?
> 
> If so, are you able to share some measurements?
> 
> If not, maybe it should be removed?
> 
>> ...
>>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7021,40 +7021,80 @@ static inline int process_huge_page(
>>   	return 0;
>>   }
>>   
>> -static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>> -				unsigned int nr_pages)
>> +/*
>> + * Clear contiguous pages chunking them up when running under
>> + * non-preemptible models.
>> + */
>> +static void clear_contig_highpages(struct page *page, unsigned long addr,
>> +				   unsigned int npages)
> 
> Called "_highpages" because it wraps clear_user_highpages().  It really
> should be called clear_contig_user_highpages() ;)  (Not serious)

You have a point there, though :)

Fortunately this is only an internal helper.

-- 
Cheers

David / dhildenb


