Return-Path: <linux-kernel+bounces-757524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE02B1C32C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F34E14C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140828A706;
	Wed,  6 Aug 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhRK1rSF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DE28A414
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472116; cv=none; b=EAyqzmFh8FLjd7I9TivCXnqQ1IWh9IMwZyfPvPPgwNcQ+3df4R9phQNif/KKNTAuYeJ3714NkuQZkOVe+fy8NfCxiQOUWXzTAdsMAKSr6Q/lZ7MOWkx2wHiubKiJcRTJv3yQ/jsKV25d/5MSC/+KLD+Pn4rGDQWDOK/CtwptD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472116; c=relaxed/simple;
	bh=IMxgbdTOa6GQZFs2H1lf63enJk0PKTAWbVe3WMvL/bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNIA7EoapfG0Jg79WXu8vdweqMHwF8NjydJwy9/77amiyHU5xp6CkvGRFlUVWBfW3QehmMEXxhybrayMAQENFKuhCU5CKnrSKkO9OMCh/TqgqHT0hDZLRtVPcrr9k2eNcBAeT6a1P2nemFkps8Lgw58jNBmTPIQ59XDBwDzYCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhRK1rSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754472112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TLnz3o9ocsbKZkd4mi2GHRZKQa/a0FBBbJaZGX0Q0vc=;
	b=UhRK1rSFrrjewONLEXQhU2hrzWymISGhk7r+KJMt+IptbJo1gbxyKX90q/d34OB7AnCfs1
	Pa18C7F+/kKoM+X42sRyyvPRZfTKRzAsRrDVLxyOuW5cP03FCKz2FbU6UTw7dmwDKSntSS
	UbCPjtxcAE5gtNJ4xV0LDsrodSxU2Ts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-49MUYPIONFGdsTdbxOpDfg-1; Wed, 06 Aug 2025 05:21:51 -0400
X-MC-Unique: 49MUYPIONFGdsTdbxOpDfg-1
X-Mimecast-MFC-AGG-ID: 49MUYPIONFGdsTdbxOpDfg_1754472110
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458bf93f729so19462025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472110; x=1755076910;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLnz3o9ocsbKZkd4mi2GHRZKQa/a0FBBbJaZGX0Q0vc=;
        b=rRmPcG6S1JEnVJGWjOFxjj6RS4hk6iXs2EVCEbMBqfn8re6D4tOJs/l9oGtTzI+rca
         efnHqzH2G7cg9SAa4WhPIWemiXekxz5pTSLtMjbESaHoihPCjfhpXbF3KqGKvwWKrvmJ
         a+m0x0EqdLBhbZ8fAC/qZ8UM5BATgQ4YF+6u+iTQz7YA9nTf3F71C2+DZXRpeWfs4Ghx
         it4J8Z6SdOaCJGswWHHSQNSikKuBMB1cCgv1BGQ6ZQFojLP/LoEn1fgX1GlRjo7CTJJx
         uaIQP8P0bOb0pLjDi73sSsHzclmwUZTY0WQcs+8j56tFVxLiGCmPTW5Ll5Ujuae3nUCN
         BsWA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMCF7KXQg1a9Nru1+4VamNmL6Wyq7jFh3yJCA7Js8rOwSj9Z2OuWq0FSfzVRbGRAdIrVJvuuA+P/24eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPWYLECpRq0ME2yVMrMselvPj9AjfGE6w617kj2OGpzkb7uHQ
	VF6HZNZXX7zD7J6J1pkzi8ZV6YJOVr53PfUC0+K5py/V8mD3ZDCFH6Mgs0WP4MPOSZ6fzVPUx5+
	5dv5xwtYflDKSVBVpnKYIyQbyxN/TnE+Myw4K0vQTdimKZGlEXN5p9wDjtZbTTKk2LQ==
X-Gm-Gg: ASbGnct8QI+NjXJJKsNyFbhLgyOahLHGf97sxvhXnDoeQ1Vn9kkLLKZWHiXelaVmF7+
	Dm0uGyvHFrVho8reV0UlDvK8O56upCNY103HOS1dn1vAGJVw2o72C3oFOAyWkJqGDx9CHJfIY0z
	iFeXlxogBNm5zrvTJiWBPVotOUSUOlPBzdZOQ/MaBOvHfjk0kANQnjEdQKJtnV/E/UDbRj8QTX/
	mPV+knvZb9uKfSYm8rE8L9m8n7j6s9AfooA0hzgA9Yh2+r/mAsviTGADiQTsScTJrTQg2VwTnHg
	81ygEYz1jd/5OCkP7rRBP7fnrn6yMxAlmXL2QtRhVKxc1q68Egwuvh8jTPXYORttYWEQtAzLziW
	TNI04T8BifbCnKpzZDhpY7nz6WMs40uDM3p/DPc6Cn1jO6gPXFBbPQVL2O9grEPeddXE=
X-Received: by 2002:a05:600c:1c14:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-459eb99e605mr326365e9.0.1754472110313;
        Wed, 06 Aug 2025 02:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkbPszpIki01VcMNi4ikQjySykp+PQiRvKbqALptq2NByD+y+1DiNLmRqKUdKH+LjkIWGPA==
X-Received: by 2002:a05:600c:1c14:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-459eb99e605mr325895e9.0.1754472109803;
        Wed, 06 Aug 2025 02:21:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm109716695e9.2.2025.08.06.02.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:21:49 -0700 (PDT)
Message-ID: <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
Date: Wed, 6 Aug 2025 11:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 11:12, Lorenzo Stoakes wrote:
> On Wed, Aug 06, 2025 at 10:08:33AM +0200, David Hildenbrand wrote:
>> On 18.07.25 11:02, Dev Jain wrote:
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>
>>
>> I wanted to review this, but looks like it's already upstream and I suspect
>> it's buggy (see the upstream report I cc'ed you on)
>>
>> [...]
>>
>>> +
>>> +/*
>>> + * This function is a result of trying our very best to retain the
>>> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
>>> + * if the vma is a private vma, and we cannot determine whether to change
>>> + * the pte to writable just from the vma and the pte, we then need to look
>>> + * at the actual page pointed to by the pte. Unfortunately, if we have a
>>> + * batch of ptes pointing to consecutive pages of the same anon large folio,
>>> + * the anon-exclusivity (or the negation) of the first page does not guarantee
>>> + * the anon-exclusivity (or the negation) of the other pages corresponding to
>>> + * the pte batch; hence in this case it is incorrect to decide to change or
>>> + * not change the ptes to writable just by using information from the first
>>> + * pte of the batch. Therefore, we must individually check all pages and
>>> + * retrieve sub-batches.
>>> + */
>>> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
>>> +		struct folio *folio, unsigned long addr, pte_t *ptep,
>>> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>>> +{
>>> +	struct page *first_page = folio_page(folio, 0);
>>
>> Who says that we have the first page of the folio mapped into the first PTE
>> of the batch?
> 
> Yikes, missed this sorry. Got too tied up in alogrithm here.
> 
> You mean in _this_ PTE of the batch right? As we're invoking these on each part
> of the PTE table.
> 
> I mean I guess we can simply do:
> 
> 	struct page *first_page = pte_page(ptent);
> 
> Right?

Yes, but we should forward the result from vm_normal_page(), which does
exactly that for you, and increment the page accordingly as required,
just like with the pte we are processing.

...

>>
>>> +			else
>>> +				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
>>> +					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
>>
>> Semi-broken intendation.
> 
> Because of else then 2 lines after?

prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
		       nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);

Is what I would have expected.


I think a smart man once said, that if you need more than one line per statement in
an if/else clause, a set of {} can aid readability. But I don't particularly care :)

-- 
Cheers,

David / dhildenb


