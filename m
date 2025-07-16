Return-Path: <linux-kernel+bounces-733072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A764B06FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5B34E733B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7428A402;
	Wed, 16 Jul 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnu4b2N7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A862459E5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653044; cv=none; b=QiZ1sQAB9astPKwBSuQ5sIiGdgBNUpf0So38HlC9E7wRcAByC747RGXRSujg6eZWKIDb/MnHJ7WuWsuiFlaAWbwkKl5A+fFZcITPU5rNEFrd62mjHA49bj/sXOBIxGCzhOmaFL9xYI/oPEE/Dr/30uUQ9Y/GmDJYlGXoRqFki54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653044; c=relaxed/simple;
	bh=vE5ESiWubWZe9NDRJz9v/Tg3hvFxCCljCJxl1eysK4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbiiEJstX5d1G4wmZmlwImE9g2gUgbBaSxcZOrEoQ2YTtLrOw/sq1EMq02SQupp7OFwBzF1/knu2mbSsqHWW/uTEZ6BVo4StVXC2tg2y/GBUIugERGXJmwjrxexbXYjsI7h1MjiNtGyL6IALLe1YvOP2FJXH0h0RKNZ9RcT7Kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dnu4b2N7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752653041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=851XL3aft8TGiZsR94ORULOuagFeL0V3mQOANhLNmA4=;
	b=Dnu4b2N7GMTWRXkYmctipP3SwpJu20byZWOxRI6llzJlcAZ/3bvYozrGC/1bAxMOM1YDur
	LNZe92d8cWBwooYmnD+EHjNMCIU/fsr8E3BTNPgJOXbJMCoznyZ+vRrjFOX2jh2vFR1yFU
	kXa51UCWn4+4RoOrE7gAQ5pYvjrxUAk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-pCiVhhiGOPS8rolKJw-Sww-1; Wed, 16 Jul 2025 04:03:59 -0400
X-MC-Unique: pCiVhhiGOPS8rolKJw-Sww-1
X-Mimecast-MFC-AGG-ID: pCiVhhiGOPS8rolKJw-Sww_1752653038
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456175dba68so24447805e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653038; x=1753257838;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=851XL3aft8TGiZsR94ORULOuagFeL0V3mQOANhLNmA4=;
        b=lIRIGR434ehV5uLCX7XOpQ62obiGTc0OK205mwPn7UAShFpzE2n8PaeS4WxcTJcgx1
         uF0pEm04OokO9YG8tFs6zcRKZVxuvmJwR7cwx8MQwXOM6/69Op3lSihxznQW7ubvLERa
         mvAcnrCdM+1vwS0nHDEEgfjNIJaWmu9kSR6XkmFZXH1qul/FV4Qelkx6tDUwu6gBnXbP
         m7QMSBZ3nTqeuI2MQNFsF8Uw/bPsEAkwfajWAarPLyaAK9ocMukrGPyT92AMZOVRWJ44
         h/QUXFlwCZ5QZNitJ0IrW8i7oZMUPVuxu7p2eJj6cLYcZ7kbNGY8TrjzQ7ZgvvQMZW21
         Q7rQ==
X-Gm-Message-State: AOJu0YwAJmDTuvS7n+RexGbbCl7gM0u01MtLxSHRSj0wib6RZdofiBUX
	z1gyLWh4Dh2RlU1nBRfbXRFxBsEScp0/aSb/Y1fQ9h6l4EEZcqxFddkU+WFvJLF1hwf4k5UNkwC
	sXjHQC0SXXYIYA+oqUf0qjhhodkIGP5Xv9W75BLN8D5IJ3sgJCWCMQc/I93DExc0jsA==
X-Gm-Gg: ASbGncunhOgthyPEpQx3VtVTxJ9hirVl3mvGUttdP8IymuYnXXSP91yKYXTnt4Iu0FR
	VyZjfXXxfOCmH307jYtN+rR8i1XIYGSdf9WNl8nhZ7H4f3n19LgbJV259PbOebeePCVAEAiy8fC
	XVHmARedb8I6YZd0+sH2uhf2u+uQjlmqWNQZI0jamXih4pwtUyKVSY6oq7673yG0ZMy0RpZpzHH
	ESa8OaFwqBSIV7qp86DyPHDVRnQn9xdf+/xLG4Eadd+uesxuFSOUny+NYsF7q0wrNc7Tlk7AKel
	2LzmDT3t53E3wrsJ41ikKC1twjlTuBaxSHY+7CfK8RQy6v60pUUkLmaZcjbtaCmRDOcx3KEcPPo
	EBq6MhndnO9E1Gc5ITRdA2pvIb+Tbo2T6cnM/h368+c6rImzDJZReEzqvqvrSBX3Zbzg=
X-Received: by 2002:a05:600c:3f09:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-4562e32e292mr16194865e9.3.1752653038190;
        Wed, 16 Jul 2025 01:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkKL4nxmV1Lcj2I1V4yty5DWzRH60iNK2uYmfl9myl0rm6VUxxn6tUDnd+KzR9rieDyOGNiA==
X-Received: by 2002:a05:600c:3f09:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-4562e32e292mr16194275e9.3.1752653037564;
        Wed, 16 Jul 2025 01:03:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c308sm12802295e9.30.2025.07.16.01.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:03:56 -0700 (PDT)
Message-ID: <213a4333-24de-4216-8d9a-b70ac52c4263@redhat.com>
Date: Wed, 16 Jul 2025 10:03:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
 <d6413d17-c530-4553-9eca-dec8dce37e7e@redhat.com> <878qkohleu.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <878qkohleu.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 05:19, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 10.07.25 02:59, Ankur Arora wrote:
>>> folio_zero_user() is constrained to clear in a page-at-a-time
>>> fashion because it supports CONFIG_HIGHMEM which means that kernel
>>> mappings for pages in a folio are not guaranteed to be contiguous.
>>> We don't have this problem when running under configurations with
>>> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
>>> longer page-extents.
>>> This is expected to be faster because the processor can now optimize
>>> the clearing based on the knowledge of the extent.
>>> However, clearing in larger chunks can have two other problems:
>>>    - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>>      (larger folios don't have any expectation of cache locality).
>>>    - preemption latency when clearing large folios.
>>> Handle the first by splitting the clearing in three parts: the
>>> faulting page and its immediate locality, its left and right
>>> regions; the local neighbourhood is cleared last.
>>> The second problem is relevant only when running under cooperative
>>> preemption models. Limit the worst case preemption latency by clearing
>>> in architecture specified ARCH_CLEAR_PAGE_EXTENT units.
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    mm/memory.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 85 insertions(+), 1 deletion(-)
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index b0cda5aab398..c52806270375 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -7034,6 +7034,7 @@ static inline int process_huge_page(
>>>    	return 0;
>>>    }
>>>    +#ifndef CONFIG_CLEAR_PAGE_EXTENT
>>>    static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>>>    				unsigned int nr_pages)
>>>    {
>>> @@ -7058,7 +7059,10 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
>>>    /**
>>>     * folio_zero_user - Zero a folio which will be mapped to userspace.
>>>     * @folio: The folio to zero.
>>> - * @addr_hint: The address will be accessed or the base address if uncelar.
>>> + * @addr_hint: The address accessed by the user or the base address.
>>> + *
>>> + * folio_zero_user() uses clear_gigantic_page() or process_huge_page() to
>>> + * do page-at-a-time zeroing because it needs to handle CONFIG_HIGHMEM.
>>>     */
>>>    void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>>    {
>>> @@ -7070,6 +7074,86 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>>    		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>>>    }
>>>    +#else /* CONFIG_CLEAR_PAGE_EXTENT */
>>> +
>>> +static void clear_pages_resched(void *addr, int npages)
>>> +{
>>> +	int i, remaining;
>>> +
>>> +	if (preempt_model_preemptible()) {
>>> +		clear_pages(addr, npages);
>>> +		goto out;
>>> +	}
>>> +
>>> +	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
>>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
>>> +			    ARCH_CLEAR_PAGE_EXTENT);
>>> +		cond_resched();
>>> +	}
>>> +
>>> +	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
>>> +
>>> +	if (remaining)
>>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
>>> +			    remaining);
>>> +out:
>>> +	cond_resched();
>>> +}
>>> +
>>> +/*
>>> + * folio_zero_user - Zero a folio which will be mapped to userspace.
>>> + * @folio: The folio to zero.
>>> + * @addr_hint: The address accessed by the user or the base address.
>>> + *
>>> + * Uses architectural support for clear_pages() to zero page extents
>>> + * instead of clearing page-at-a-time.
>>> + *
>>> + * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
>>> + * pages in the immediate locality of the faulting page, and its left, right
>>> + * regions; the local neighbourhood cleared last in order to keep cache
>>> + * lines of the target region hot.
>>> + *
>>> + * For larger folios we assume that there is no expectation of cache locality
>>> + * and just do a straight zero.
>>> + */
>>> +void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>> +{
>>> +	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
>>> +	const long fault_idx = (addr_hint - base_addr) / PAGE_SIZE;
>>> +	const struct range pg = DEFINE_RANGE(0, folio_nr_pages(folio) - 1);
>>> +	const int width = 2; /* number of pages cleared last on either side */
>>> +	struct range r[3];
>>> +	int i;
>>> +
>>> +	if (folio_nr_pages(folio) > MAX_ORDER_NR_PAGES) {
>>> +		clear_pages_resched(page_address(folio_page(folio, 0)), folio_nr_pages(folio));
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Faulting page and its immediate neighbourhood. Cleared at the end to
>>> +	 * ensure it sticks around in the cache.
>>> +	 */
>>> +	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
>>> +			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
>>> +
>>> +	/* Region to the left of the fault */
>>> +	r[1] = DEFINE_RANGE(pg.start,
>>> +			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
>>> +
>>> +	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
>>> +	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
>>> +			    pg.end);
>>> +
>>> +	for (i = 0; i <= 2; i++) {
>>> +		int npages = range_len(&r[i]);
>>> +
>>> +		if (npages > 0)
>>> +			clear_pages_resched(page_address(folio_page(folio, r[i].start)), npages);
>>> +	}
>>> +}
>>> +#endif /* CONFIG_CLEAR_PAGE_EXTENT */
>>> +
>>>    static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
>>>    				   unsigned long addr_hint,
>>>    				   struct vm_area_struct *vma,
>>
>> So, folio_zero_user() is only compiled with THP | HUGETLB already.
>>
>> What we should probably do is scrap the whole new kconfig option and
>> do something like this in here:
> 
> So, in principle I don't disagree and unifying both of these is cleaner
> than introducing a whole new option.

Yes, after playing with the code, a new config option just for that is not
what we want.

> 
> However that still leaves this code having to contort around CONFIG_HIGHMEM
> which is probably even less frequently used than THP | HUGETLB.

Not sure I understand your question correctly, but thp+hugetlb are compatible with
32bit and highmem.

There are plans of removing highmem support, but that's a different story :)

I think as long as these configs exist, we should just support them, although
performance is a secondary concern.

> 
> Maybe we should get rid of ARCH_HAS_CLEAR_PAGES completely and everyone
> with !HIGHMEM either use a generic version of clear_pages() which loops
> and calls clear_page() or some architectural override.
> 
> And, then we can do a similar transformation with copy_pages() (and
> copy_user_large_folio()).
> 
> At that point, process_huge_page() is used only for !HIGHMEM configs

I assume you meant HIGHMEM

> configs which likely have relatively small caches and so that leaves
> it probably over-engineered.

I don't think we need to jump through hoops to optimize performance on
highmem, yes.

> 
> The thing that gives me pause is that non-x86 might perform worse
> when they switch away from the left-right zeroing approach in
> process_huge_page() to a generic clear_pages().

Right. Or they perform better. Hard to know.

> 
> So, maybe allowing architectures to opt in by having to define
> ARCH_HAS_CLEAR_PAGES would allow doing this in a more measured fashion.

One tricky thing is dealing with architectures where clear_user_highpage()
does cachemanagement.

So the more I think about it, I wonder if we really should just design it
all around clear_user_highpages and clear_user_pages, and have only a
single clearing algorithm.

Essentially, something like the following, just that we need a generic
clear_user_pages that iterates over clear_user_page.

Then, x86_64 could simply implement clear_user_pages by routing it to your
clear_pages, and define CLEAR_PAGES_RESCHED_NR (although I wonder if we can
do better here).



diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6234f316468c9..031e19c56765b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -264,6 +264,14 @@ static inline void tag_clear_highpage(struct page *page)
  #ifdef CONFIG_HIGHMEM
  void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
  		unsigned start2, unsigned end2);
+static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
+		unsigned int nr_pages)
+{
+	unsigned int i;
+
+	for (i = 0; i <= nr_pages; i++)
+		clear_user_highpage(nth_page(page, i), vaddr + i * PAGE_SIZE);
+}
  #else
  static inline void zero_user_segments(struct page *page,
  		unsigned start1, unsigned end1,
@@ -284,6 +292,7 @@ static inline void zero_user_segments(struct page *page,
  	for (i = 0; i < compound_nr(page); i++)
  		flush_dcache_page(page + i);
  }
+#define clear_user_highpages clear_user_pages
  #endif
  
  static inline void zero_user_segment(struct page *page,
diff --git a/mm/memory.c b/mm/memory.c
index 3dd6c57e6511e..8aebf6e0765d8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7009,40 +7009,92 @@ static inline int process_huge_page(
  	return 0;
  }
  
-static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
-				unsigned int nr_pages)
+#ifndef CLEAR_PAGES_RESCHED_NR
+#define CLEAR_PAGES_RESCHED_NR		1
+#endif /* CLEAR_PAGES_RESCHED_NR */
+
+static void clear_user_highpages_resched(struct page *page, unsigned long addr,
+		unsigned int nr_pages)
  {
-	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
-	int i;
+	unsigned int i, remaining;
  
-	might_sleep();
-	for (i = 0; i < nr_pages; i++) {
+	if (preempt_model_preemptible()) {
+		clear_user_highpages(page, addr, nr_pages);
+		goto out;
+	}
+
+	for (i = 0; i < nr_pages / CLEAR_PAGES_RESCHED_NR; i++) {
+		clear_user_highpages(nth_page(page, i * CLEAR_PAGES_RESCHED_NR),
+				     addr + i * CLEAR_PAGES_RESCHED_NR * PAGE_SIZE,
+				     CLEAR_PAGES_RESCHED_NR);
-		clear_user_highpage(folio_page(folio, i), addr + i * PAGE_SIZE);
  		cond_resched();
  	}
-}
  
-static int clear_subpage(unsigned long addr, int idx, void *arg)
-{
-	struct folio *folio = arg;
+	remaining = nr_pages % CLEAR_PAGES_RESCHED_NR;
  
-	clear_user_highpage(folio_page(folio, idx), addr);
-	return 0;
+	if (remaining)
+		clear_user_highpages(nth_page(page, i * CLEAR_PAGES_RESCHED_NR),
+				     addr + i * CLEAR_PAGES_RESCHED_NR * PAGE_SHIFT,
+				     remaining);
+out:
+	cond_resched();
  }
  
-/**
+/*
   * folio_zero_user - Zero a folio which will be mapped to userspace.
   * @folio: The folio to zero.
- * @addr_hint: The address will be accessed or the base address if uncelar.
+ * @addr_hint: The address accessed by the user or the base address.
+ *
+ * Uses architectural support for clear_pages() to zero page extents
+ * instead of clearing page-at-a-time.
+ *
+ * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
+ * pages in the immediate locality of the faulting page, and its left, right
+ * regions; the local neighbourhood cleared last in order to keep cache
+ * lines of the target region hot.
+ *
+ * For larger folios we assume that there is no expectation of cache locality
+ * and just do a straight zero.
   */
  void folio_zero_user(struct folio *folio, unsigned long addr_hint)
  {
-	unsigned int nr_pages = folio_nr_pages(folio);
+	const unsigned int nr_pages = folio_nr_pages(folio);
+	const unsigned long addr = ALIGN_DOWN(addr_hint, nr_pages * PAGE_SIZE);
+	const long fault_idx = (addr_hint - addr) / PAGE_SIZE;
+	const struct range pg = DEFINE_RANGE(0, nr_pages - 1);
+	const int width = 2; /* number of pages cleared last on either side */
+	struct range r[3];
+	int i;
+
+	if (unlikely(nr_pages >= MAX_ORDER_NR_PAGES)) {
+		clear_user_highpages_resched(folio_page(folio, 0), addr, nr_pages);
+		return;
+	}
+
+	/*
+	 * Faulting page and its immediate neighbourhood. Cleared at the end to
+	 * ensure it sticks around in the cache.
+	 */
+	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
+			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
+
+	/* Region to the left of the fault */
+	r[1] = DEFINE_RANGE(pg.start,
+			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
+
+	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
+	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
+			    pg.end);
+
+	for (i = 0; i <= 2; i++) {
+		unsigned int cur_nr_pages = range_len(&r[i]);
+		struct page *cur_page = folio_page(folio, r[i].start);
+		unsigned long cur_addr = addr + folio_page_idx(folio, cur_page) * PAGE_SIZE;
+
+		if (cur_nr_pages > 0)
+			clear_user_highpages_resched(cur_page, cur_addr, cur_nr_pages);
+	}
  
-	if (unlikely(nr_pages > MAX_ORDER_NR_PAGES))
-		clear_gigantic_page(folio, addr_hint, nr_pages);
-	else
-		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
  }
  
  static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
-- 
2.50.1


On highmem we'd simply process individual pages, who cares.

On !highmem, we'd use the optimized clear_user_pages -> clear_pages implementation
if available. Otherwise, we clear individual pages.

Yes, we'd lose the left-right pattern.

If really important we could somehow let the architecture opt in and do the call
to the existing process function.


-- 
Cheers,

David / dhildenb


