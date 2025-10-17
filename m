Return-Path: <linux-kernel+bounces-858513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25690BEB05D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5E0C4F1681
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B230100F;
	Fri, 17 Oct 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rv8QTDEA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E22FFDC6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721035; cv=none; b=d8iaY3Nuect6Eu149ee0Qlr7YyE+wmMv76VDXuc37/ASvWvgBjZ2IIBpYPX2PHIb3nKp9KExvEHX7Jd+dDlhkC+FqFqkH6vb3Ohm0maXm47p1iWxaafkLGXU6t2dzj3B44RGUcdtMcN3oz+l02lckFU6D8czyfHCEaImZWwAjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721035; c=relaxed/simple;
	bh=EbgvQowcTpT0CFVtPsor1bVGvj7CjZAAIwTNi5v6oWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVXsNKYeanaqw9otz0KYbpsdN9O94HyIH5D3uWB27y3J2QJxGHycL2JzAEZE64s4dND95T+D/8AwVspomSopMzmrVcsiOj54Hv3bCvrZCWdA61hmASmiIsdEmgfasizd562cKXMqH1g/Q7JAnM3Ouz6PT0wCk/e9NUk7ch33ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rv8QTDEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760721033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UK8HD9G+Kwd4HVQdRALdCmHeg5SXgo45lh6yR0QBxjc=;
	b=Rv8QTDEARbHiihYFUaFieuSEoJnFDs1ZaLPYJg0Y+Ie95TZsut4CKS6T6CBzt0raRV8qlF
	F3B0y5WVyZH89Nw/8hoHCZ6Fsii5q3RKgkdKtfq8m/AdpRjCQFaBxqxENw7Wl3HNMTya7x
	R+DD949YRzL7gtp/vzSu/gDQ8hZaRBU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-CTHSA4FQOR-nZFyCBfmkog-1; Fri, 17 Oct 2025 13:10:31 -0400
X-MC-Unique: CTHSA4FQOR-nZFyCBfmkog-1
X-Mimecast-MFC-AGG-ID: CTHSA4FQOR-nZFyCBfmkog_1760721030
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso13705675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721030; x=1761325830;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK8HD9G+Kwd4HVQdRALdCmHeg5SXgo45lh6yR0QBxjc=;
        b=Cfgju/H8bgNXIfmlgeEog5craYB5A06LzUZF+cm3LDKtGpYLZb882uHT3pudlcPFr4
         yHbmG9eKG/yVdIjs6fK+EMy49igXh/5Zs7bPjO0L5QzliZ2Z4fGnLoLomXOnTn8eBx+x
         d4A/K9XNKINF9WMWs8QllFMFJQhitp6f2Jq+Sg2oveSko5zMLlUqAbpB/dWquQ8gHO/L
         Km6WdrND+blAYFHAq9hnRrRgU+6xDzdyD/lh4Z9OYyIceIBFP3nDCiPSwksW3VhB9qLb
         oYLhsbRESsz3SVeH87HQlIYEkxAbJY4GfrFD65zJQMvyTPhcW9FecyMpLvtM9B9Wi2mD
         qtUw==
X-Forwarded-Encrypted: i=1; AJvYcCUXrXAaNe3vgu3RgadWS98P6OrgLNXhQ8PPtTx1VacewrRNXpB+wYnnzB9uwg6W1NX7cwHfn1CkpQIDNBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKu6nbY+2u1+YwvJaxu28TmnWxapsUIIXHaHuxi4geZLFBHnV
	5P0ms/Hzm64j7BpxISsSpGZ+zD/1iv3wNR9byK9dn80wDFAW8n3zOlchbYtdUYuYLi8QOB91M/Q
	KYUD99guU+1P1FA0/7xmqgFBz5qCG4OhzhD+0sXX9oG7UY42oKo4KV74EcCNKzcyRUQ==
X-Gm-Gg: ASbGncuX887p/WxiO98Js/aiaBn3YMZEOzISa4qroEI3FQEel2+jztpxziMT0V5d0mI
	rGPUvFKuGV+WxufyriM117TClrgySbsGQBR67dQ+PTpo6NPQCPyUymlaLrIb8Z3JsXhGtSULH3k
	ns7Xn12bRvAaqv3tN0sNWL1HieBJilgJ4Qn0JqDrngnUGU1kNP5JgAjPzuj3p3GxzgyKiN1KWH1
	W9axEH21bMChMudRe5Mg9qrAYAjvcsDpn5xaPrsjIjV0munUMq6Us4s5KS89umzDzwzeQrJCsT3
	oUOYEjpkW7qy6ZpK7YiX5laBQoiy+YB1aUovhDxHDqvcEAgOhgW/ivnpqhh7efXCIuVcNgPAKv+
	FSiYmkx2jRSdxlV2cPrK6gEfg96mVwdHBnbLGDcuUtYTImaU4bDd14aW1B17PkJLHsKUSgMmrYE
	/aHzvOa5q40+CanX2/QlEAsYs0mpw=
X-Received: by 2002:a05:600c:294b:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-47109b5f8f4mr47517225e9.20.1760721030370;
        Fri, 17 Oct 2025 10:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvb0y9fCRtWnytuEMED2PPHaBvVSeuDvOip/abNeYWVJN8mhS8t8p9uAnDfOHyvUkNRDsLQw==
X-Received: by 2002:a05:600c:294b:b0:46f:b42e:e363 with SMTP id 5b1f17b1804b1-47109b5f8f4mr47516765e9.20.1760721029880;
        Fri, 17 Oct 2025 10:10:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715520dd65sm3981765e9.15.2025.10.17.10.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:10:29 -0700 (PDT)
Message-ID: <d1a6c65c-6518-4227-8ec3-f2af4f7724ad@redhat.com>
Date: Fri, 17 Oct 2025 19:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: Fix stale IOTLB entries for kernel address space
To: Baolu Lu <baolu.lu@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 syzbot ci <syzbot+cid009622971eb4566@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, apopple@nvidia.com, bp@alien8.de,
 dave.hansen@linux.intel.com, iommu@lists.linux.dev, jannh@google.com,
 jean-philippe@linaro.org, jgg@nvidia.com, joro@8bytes.org,
 kevin.tian@intel.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, luto@kernel.org,
 mhocko@kernel.org, mingo@redhat.com, peterz@infradead.org,
 robin.murphy@arm.com, rppt@kernel.org, security@kernel.org,
 stable@vger.kernel.org, tglx@linutronix.de, urezki@gmail.com,
 vasant.hegde@amd.com, vbabka@suse.cz, will@kernel.org, willy@infradead.org,
 x86@kernel.org, yi1.lai@intel.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <68eeb99e.050a0220.91a22.0220.GAE@google.com>
 <89146527-3f41-4f1e-8511-0d06e169c09e@intel.com>
 <8cdb459f-f7d1-4ca0-a6a0-5c83d5092cd8@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8cdb459f-f7d1-4ca0-a6a0-5c83d5092cd8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 10:00, Baolu Lu wrote:
> On 10/16/25 00:25, Dave Hansen wrote:
>> Here's the part that confuses me:
>>
>> On 10/14/25 13:59, syzbot ci wrote:
>>> page last free pid 5965 tgid 5964 stack trace:
>>>    reset_page_owner include/linux/page_owner.h:25 [inline]
>>>    free_pages_prepare mm/page_alloc.c:1394 [inline]
>>>    __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
>>>    pmd_free_pte_page+0xa1/0xc0 arch/x86/mm/pgtable.c:783
>>>    vmap_try_huge_pmd mm/vmalloc.c:158 [inline]
>> ...
>>
>> So, vmap_try_huge_pmd() did a pmd_free_pte_page(). Yet, somehow, the PMD
>> stuck around so that it *could* be used after being freed. It _looks_
>> like pmd_free_pte_page() freed the page, returned 0, and made
>> vmap_try_huge_pmd() return early, skipping the pmd pmd_set_huge().
>>
>> But I don't know how that could possibly happen.
> 
> The reported issue is only related to this patch:
> 
> - [PATCH v6 3/7] x86/mm: Use 'ptdesc' when freeing PMD pages
> 
> It appears that the pmd_ptdesc() helper can't be used directly here in
> this patch. pmd_ptdesc() retrieves the page table page that the PMD
> entry resides in:
> 
> static inline struct page *pmd_pgtable_page(pmd_t *pmd)
> {
>           unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
>           return virt_to_page((void *)((unsigned long) pmd & mask));
> }
> 
> static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
> {
>           return page_ptdesc(pmd_pgtable_page(pmd));
> }
> 
> while, in this patch, we need the page descriptor that a pmd entry
> points to.

Ah. But that's just pointing at a leaf page table, right?

-- 
Cheers

David / dhildenb


