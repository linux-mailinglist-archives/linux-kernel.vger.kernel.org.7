Return-Path: <linux-kernel+bounces-757414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9FB1C1E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5671866AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C3220F3F;
	Wed,  6 Aug 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt1Gu2e3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4D22068D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467938; cv=none; b=hkJi1jnwRZ83o2AJMazU7Gbryq//JOOdoygOx3NRDxrAuuk4ohADDECHsrapSQHNMld+Zm6p1XTpBuWheSYCdNcx4jhsuef0KgPURrUM0f4GE01fKTYeqN3XAcd3wiEdQVH1fSbgE2A7DSVOitt5YQcmwOUQ0Rx2eyhbMK6C/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467938; c=relaxed/simple;
	bh=pXlZ+ZS7qZBpmMt0W+AHQaQ5Rs0iCjCcsEwaFqKdnWg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjVar+SN0lA9D0ii54JWTeBl+qtXn98fCE0HMj6HtSoad17fB34SRp5k9zYXcJ+mC+W0sX3bYEHrayWqOyMmO+NwU6twM5ySzh791BWLzrrSSa7lFqAGow81si/bzI9rH2GlDZJjGfSjc2QbIGTWcqbajFrw5U6Uk9E8G1rJkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt1Gu2e3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754467934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LJG3wYSvSlXvCnaQDCgCePQqDG4nXAVM9wa1z/+Aqlo=;
	b=Yt1Gu2e3KsqOXGznkBHHfenX3vQruQmB5VIozUa3CxJpOR+pAEX7o/rUEoqOUdIchkaAeW
	RJaA4SLi9GAJLodlbPVIHPbCObcC1pYd1Els3jTHOxY/+YcX6poSHmrzIo/rnGjGwxLKc3
	RrT2IiCs7frSIYZq4If8Gok9URxU+fA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-zzhGlRaFPDOlpZhjotSEtA-1; Wed, 06 Aug 2025 04:12:13 -0400
X-MC-Unique: zzhGlRaFPDOlpZhjotSEtA-1
X-Mimecast-MFC-AGG-ID: zzhGlRaFPDOlpZhjotSEtA_1754467932
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b20f50da27so276697f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467932; x=1755072732;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJG3wYSvSlXvCnaQDCgCePQqDG4nXAVM9wa1z/+Aqlo=;
        b=eVlMCL2Pz4xiVkIWj/wKe+1NURrlAfJTltxiNayS8c0VebPl1hzSbkEkGb/X1qneXs
         bn2F0vmTIFpwyD9KGjnUDvIjA9+MfVWGsGb3wV8yzRKn2rRA6V+HZJvj4ToGxfPQgvxg
         SIntoP2Jh16LMVSGzbNP6KGZVxUVR6OvIKV4ext/ubX7WBlLRko7dlDHFWdoa6NsjuVH
         WDFsDyDQN3hx7OLGxJgbqQXJXncy9tW07Ac0UdoGVrlyS5gDykO+CSGk1M2Nlv8t7GMQ
         pg5x1ZFA53FF4YivLIsuuq5oa/JwCGZxB7wd53qqZ6PgOX11CRiCl/99JEs6xb1bV51Z
         vVWg==
X-Forwarded-Encrypted: i=1; AJvYcCXBYzsOeEnH0kSrsP6JowFrlsyjk8PvDm+Hh/p+HkGP5J4RhUV5v50T1w51o/0syRUfHai4zDmN4kbJavQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqLkB1QZak60l/1BIiP0M0P/7xqYIO7aU6hO5qDTqim/7blkc
	s2c6KssQiRCbkTlWTuuGWFrBdZ30v5EBGztRhv3+xiAk41HEH6rLlhbzXJ+I2SHjerSrsfA3SQP
	vbN+1eIkUPCrcy63vC4xno8biECBucOi3PDLXtVC2LEHqHi0qRyP3PCx45P3zASfdhg==
X-Gm-Gg: ASbGnctZGbUE+LkOvl1yQQjCJZH41cJ9DgUwFoqUJfAKGFkz8qy7RQ2t8O64WB/8tUy
	+WzKU/1ngpxe4kSOnza3mHMsgC4SRYWk5R+e936guBebfdmJPbn7Commo2UEbR4tvGuqF3eq/fX
	h02Vf3fineQ6AglIZ60pd2dsM/QSD4/pat5oqL5V28xFpH3L4g62P/I6gK7ODDz2GmD1Sht2QZA
	f1gTbSwwFiYuo+K1iMCoIZaG/OiOU6z7SFRTtHv2jb+FObQMXGM+ddV5ur/ZK6KB3wFlaklARUr
	0P6Sbre8Ckv4ZXRSvzLXDpgvxkJ/d4dZu0yS2KMRvkUhiroWviGhI//jrzC1BSB5XVlEA00=
X-Received: by 2002:a05:6000:2889:b0:3a5:6860:f47f with SMTP id ffacd0b85a97d-3b8f42fa34emr1593738f8f.6.1754467932076;
        Wed, 06 Aug 2025 01:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKqlH9qPq4EYJ7DsrXzD/F4elKrKiroEMO96TCcGGkd1PfpFl+JeUaY8/zJkLpUl4Kxe+HfQ==
X-Received: by 2002:a05:6000:2889:b0:3a5:6860:f47f with SMTP id ffacd0b85a97d-3b8f42fa34emr1593673f8f.6.1754467931399;
        Wed, 06 Aug 2025 01:12:11 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0ffa9.dip0.t-ipconnect.de. [79.224.255.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm22075898f8f.67.2025.08.06.01.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:12:10 -0700 (PDT)
Message-ID: <b586b398-c726-41a7-86a4-61ec4aeff407@redhat.com>
Date: Wed, 6 Aug 2025 10:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
From: David Hildenbrand <david@redhat.com>
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 10:08, David Hildenbrand wrote:
> On 18.07.25 11:02, Dev Jain wrote:
>> Use folio_pte_batch to batch process a large folio. Note that, PTE
>> batching here will save a few function calls, and this strategy in certain
>> cases (not this one) batches atomic operations in general, so we have
>> a performance win for all arches. This patch paves the way for patch 7
>> which will help us elide the TLBI per contig block on arm64.
>>
>> The correctness of this patch lies on the correctness of setting the
>> new ptes based upon information only from the first pte of the batch
>> (which may also have accumulated a/d bits via modify_prot_start_ptes()).
>>
>> Observe that the flag combination we pass to mprotect_folio_pte_batch()
>> guarantees that the batch is uniform w.r.t the soft-dirty bit and the
>> writable bit. Therefore, the only bits which may differ are the a/d bits.
>> So we only need to worry about code which is concerned about the a/d bits
>> of the PTEs.
>>
>> Setting extra a/d bits on the new ptes where previously they were not set,
>> is fine - setting access bit when it was not set is not an incorrectness
>> problem but will only possibly delay the reclaim of the page mapped by
>> the pte (which is in fact intended because the kernel just operated on this
>> region via mprotect()!). Setting dirty bit when it was not set is again
>> not an incorrectness problem but will only possibly force an unnecessary
>> writeback.
>>
>> So now we need to reason whether something can go wrong via
>> can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
>> and userfaultfd_pte_wp cases are solved due to uniformity in the
>> corresponding bits guaranteed by the flag combination. The ptes all
>> belong to the same VMA (since callers guarantee that [start, end) will
>> lie within the VMA) therefore the conditional based on the VMA is also
>> safe to batch around.
>>
>> Since the dirty bit on the PTE really is just an indication that the folio
>> got written to - even if the PTE is not actually dirty but one of the PTEs
>> in the batch is, the wp-fault optimization can be made. Therefore, it is
>> safe to batch around pte_dirty() in can_change_shared_pte_writable()
>> (in fact this is better since without batching, it may happen that
>> some ptes aren't changed to writable just because they are not dirty,
>> even though the other ptes mapping the same large folio are dirty).
>>
>> To batch around the PageAnonExclusive case, we must check the corresponding
>> condition for every single page. Therefore, from the large folio batch,
>> we process sub batches of ptes mapping pages with the same
>> PageAnonExclusive condition, and process that sub batch, then determine
>> and process the next sub batch, and so on. Note that this does not cause
>> any extra overhead; if suppose the size of the folio batch is 512, then
>> the sub batch processing in total will take 512 iterations, which is the
>> same as what we would have done before.
>>
>> For pte_needs_flush():
>>
>> ppc does not care about the a/d bits.
>>
>> For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
>> get cleared; since we can only have extra a/d bits due to batching,
>> we will only have an extra flush, not a case where we elide a flush due
>> to batching when we shouldn't have.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> 
> I wanted to review this, but looks like it's already upstream and I
> suspect it's buggy (see the upstream report I cc'ed you on)
> 
> [...]
> 
>> +
>> +/*
>> + * This function is a result of trying our very best to retain the
>> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
>> + * if the vma is a private vma, and we cannot determine whether to change
>> + * the pte to writable just from the vma and the pte, we then need to look
>> + * at the actual page pointed to by the pte. Unfortunately, if we have a
>> + * batch of ptes pointing to consecutive pages of the same anon large folio,
>> + * the anon-exclusivity (or the negation) of the first page does not guarantee
>> + * the anon-exclusivity (or the negation) of the other pages corresponding to
>> + * the pte batch; hence in this case it is incorrect to decide to change or
>> + * not change the ptes to writable just by using information from the first
>> + * pte of the batch. Therefore, we must individually check all pages and
>> + * retrieve sub-batches.
>> + */
>> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
>> +		struct folio *folio, unsigned long addr, pte_t *ptep,
>> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>> +{
>> +	struct page *first_page = folio_page(folio, 0);
> 
> Who says that we have the first page of the folio mapped into the first
> PTE of the batch?

For the record, I *hate* that we moved from vm_normal_folio() to 
vm_normal_page(). Please undo that and forward the proper mapped page.

-- 
Cheers,

David / dhildenb


