Return-Path: <linux-kernel+bounces-733663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3DB07790
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F344D7AA0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F021ADCC;
	Wed, 16 Jul 2025 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaIxmHA9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590D21A458
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674625; cv=none; b=rwcpbuHIUmCqOwjgjtcE8s15wSMifXfowfgKR1noxTfXyi+C3HYWnUP+aV1T4fspnoIUS1syZhjGPy9cM2HyQ1XAQuqgVZiIWx7j1IL+nePSJB4QtGVfFovZf6FGrDgjwMo0twvuJBNYUBVrGMa5Qpf+JkOYhGy7H3BYXuaXR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674625; c=relaxed/simple;
	bh=sXNYf8jKYN0j47CCXRie214M7GiYRmA2mfhk8b1asfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERk33m8BKJhJ3AFLGiafGhQs9fjnAF4sx4VGdLv+7SUIau5D+zsaHjYPZQFg7cS1RW2Qqrin/ejy8ZHuBzEsN5xbHafLl6HKHJILKuIuo+66C/530l7N7lyPaYYw5tgquFdzKKdAUyCQtVQORxg1giHeQcvJrImWR8BAqzniFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaIxmHA9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HKL/ioqMRL+OVZUNMLvu4+x8icxMSgPzuG9e7wSgWIg=;
	b=FaIxmHA9un+n6q2WH/fjcOLU+9YY5I4vkmpOMFccO62o7nyagi3CAPKMf1O0kLksRUplKA
	O4KCD+oQeN6tiPgaAblcyKwBIAvuAalDCADTixTiu0pGVbfU/0YzzmgI+dO2dJqSJ06esx
	IDfWlcxg3ySb/FkKJRMgIVe6DK/sl2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-8RPzpZ_6Ob6w9_gQvpMs6w-1; Wed, 16 Jul 2025 10:03:39 -0400
X-MC-Unique: 8RPzpZ_6Ob6w9_gQvpMs6w-1
X-Mimecast-MFC-AGG-ID: 8RPzpZ_6Ob6w9_gQvpMs6w_1752674618
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso3829231f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674618; x=1753279418;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HKL/ioqMRL+OVZUNMLvu4+x8icxMSgPzuG9e7wSgWIg=;
        b=n3uloYx8XWf/gnW0zJNgaYHePLsbQEGWjU94dLBNkdkt+A511PIz6cNnNhHdH0tm0e
         E8OetSCAlIGb31C6Ds2B7xjNxUwGQSV/WdOphgiUohlJ3dQ/lWt3f4djVOQAydcj5tHd
         djToCRPcQk6TyEenRhzf+Jf7Bp8nKCSii9vMjlC2PO+s9o8p4TYlpgrGvsZNhiCsbkPZ
         wNnic1dAro1jOTtnfxxOzmbx9R+kd1Z64WZPB2AIxACI7YdXgx/Pv2zIvsR88k+2AUe/
         542YRS13aepJYqXQj4RsMjNXK4wrvzPzNfPI6N2utopXc9R6EnUEGEqiaJeokVhGcodQ
         rtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPbtx4FTPMDv4RJJxK5MYMAmOOa1+pPwKzAwvNWp+GQI3O+KqTq1KrhTSuAy1gaMlCr6Spgr+/WsV7SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8Ly6DGAEyYvET9y+YAUlUky/B1i4MzL6T1Bb5L4FvR3gYpAM
	+f8+hsk9QH0z7nclCPUAOOYyqA/Jlcayb3EXKykOREyAImX4amaxtVCy/NevZX7wdbYQ8w2AA4O
	z5u6emG//BB8OvivwPdHbZGHuSgx1dtbGKPsl3kr/gRL6wmRBJmidJwdYbK03AYcIOQ==
X-Gm-Gg: ASbGncsRHBeQ9WSSofHARcvEU+IxOm/sCiNII1/yjE9gdh8K3QnQd7+SkOVhL3V2L+j
	BdZlBh01E/E6HCatROjOPmO0RdRplVmnNUxuUSiOlp1wXxXsQV9re8yevRP66a0Lh3L/YQGdYjg
	hfxsm85PcDKob9DRxI77tmsZj3Xa+oU0gnt1YYnmCbZTJEtn8JjPe1K7gLHTNDcRPqdRloACHaT
	qfsIk0Xg7R2FzN5vGTkwYo6gIU/ni8Icfy+bmHBv+bEfo4XKG8v1YXM7TURvVijw+T5nY6m1bnC
	GlZx2RFGdAKFgl9V6y3tRR23YD1mrska6f4DP0ghKy75lLNvUxLyieJ1Fa/7MLhvXfn3CJHctoA
	sGmtk70fBUB47asOkyPjzGxJRNdnOPm+JE4hhbUV3aXSrmaUl5mPsAwZEc/52jEy3UMw=
X-Received: by 2002:a05:6000:2882:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b60e4b8693mr2515200f8f.11.1752674617430;
        Wed, 16 Jul 2025 07:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7KJZbS3pdZOSz3nC1L0zpBMMFme0idl7aovGYW3kMKKv80JSc2vBIoa7ahtKy0zFGkndhXg==
X-Received: by 2002:a05:6000:2882:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b60e4b8693mr2515114f8f.11.1752674616749;
        Wed, 16 Jul 2025 07:03:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm22135135e9.10.2025.07.16.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:03:36 -0700 (PDT)
Message-ID: <82cd57c2-d72f-423a-8dbc-d9b64d1d469b@redhat.com>
Date: Wed, 16 Jul 2025 16:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/14] khugepaged: introduce collapse_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-7-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-7-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> To add mTHP support we use this scan to instead record chunks of utilized
> sections of the PMD.
> 
> collapse_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the anon PMD. A minimum collapse order of 2 is used as this is
> the lowest order supported by anon memory.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> When attempting to collapse an order that has its order set to "always"
> lets always collapse to that order in a greedy manner without
> considering the number of bits set.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Any reason this should not be squashed into the actual mTHP collapse patch?

In particular

a) The locking changes look weird without the bigger context

b) The compiler complains about unused functions

> ---
>   include/linux/khugepaged.h |  4 ++
>   mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ff6120463745..0f957711a117 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef _LINUX_KHUGEPAGED_H
>   #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
> +#define KHUGEPAGED_MIN_MTHP_NR	(1<<KHUGEPAGED_MIN_MTHP_ORDER)

"1 << "

> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>   
>   extern unsigned int khugepaged_max_ptes_none __read_mostly;
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee54e3c1db4e..59b2431ca616 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
>   static struct kmem_cache *mm_slot_cache __ro_after_init;
>   
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>   struct collapse_control {
>   	bool is_khugepaged;
>   
> @@ -102,6 +107,18 @@ struct collapse_control {
>   
>   	/* nodemask for allocation fallback */
>   	nodemask_t alloc_nmask;
> +
> +	/*
> +	 * bitmap used to collapse mTHP sizes.
> +	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> +	 */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>   };
>   
>   /**
> @@ -838,10 +855,6 @@ static void khugepaged_alloc_sleep(void)
>   	remove_wait_queue(&khugepaged_wait, &wait);
>   }
>   
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>   static bool collapse_scan_abort(int nid, struct collapse_control *cc)
>   {
>   	int i;
> @@ -1115,7 +1128,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>   
>   static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)

Indent broken.

>   {
>   	LIST_HEAD(compound_pagelist);
>   	pmd_t *pmd, _pmd;
> @@ -1134,8 +1148,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * The allocation can take potentially a long time if it involves
>   	 * sync compaction, and we do not need to hold the mmap_lock during
>   	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>   	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>   
>   	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
> @@ -1272,12 +1290,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   out_up_write:
>   	mmap_write_unlock(mm);
>   out_nolock:
> +	*mmap_locked = false;
>   	if (folio)
>   		folio_put(folio);
>   	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>   	return result;
>   }
>   
> +/* Recursive function to consume the bitmap */
> +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +			int referenced, int unmapped, struct collapse_control *cc,
> +			bool *mmap_locked, unsigned long enabled_orders)
> +{
> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +	bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1 << (state.order);
> +		// Skip mTHP orders that are not enabled


/* */

Same applies to the other instances.

-- 
Cheers,

David / dhildenb


