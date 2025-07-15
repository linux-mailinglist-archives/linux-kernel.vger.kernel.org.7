Return-Path: <linux-kernel+bounces-732582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09228B06917
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217BF3A8402
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5562C1591;
	Tue, 15 Jul 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSm61V45"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DE2BE64E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617346; cv=none; b=ueMulzm2l3fulRJWSRdvuxwrZCfIbxraX9hvtjwPyB9GlynSq/ehA/6WIS5r8k6Cd8lMnuMqcZ6delwI0MD7V1nkaje0i+IcswidK4Jiy7E7o34ojNoYMdXZ/ugftHUFolJ8Dh1TmVCyYe8VY2PwzABGTah05t9o5ViRydpNI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617346; c=relaxed/simple;
	bh=Nb8gk/LTLVK+qM67b0UT/iqcm3zaGNjqGXWiBlwlxKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVbc6aISCkLMaNn8bxSnLq8x07/gEQRItwttx2bbqt/GwPA/8o8C5isQCKFwQskxEuJNNnHrn4mFaG7fXq5DE1U+41rYrhY3JxABC1QxWrmkKlNFvBy3fcwLM4uRrPx+muSTg1oaqJobuKekeURdYRWYXCtl19FO1c1Sl8wbz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSm61V45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752617343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxa7GMOF7VFXqx0T9kmP+domxPXINMeG49ExJ1EeWjI=;
	b=HSm61V45T7VGz4vGIqX/oTWiRZbqp/fN1Tva1Ow0vSf1Rwtz1kGoSEiBsTaEzfm8FFhMgK
	w/EuKY7r1Ca9HKcUM1SlO0ytHVY7VBJ6nYzobIDTqvH4TEXh9tNBBz8SFD1S+8fST8EPZz
	frr9OvPK+dPxiVvfJBdTXjHm0CRmceo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-MFBTHYZyPZ217f9ZoRmTEg-1; Tue, 15 Jul 2025 18:09:01 -0400
X-MC-Unique: MFBTHYZyPZ217f9ZoRmTEg-1
X-Mimecast-MFC-AGG-ID: MFBTHYZyPZ217f9ZoRmTEg_1752617340
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso22459255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617340; x=1753222140;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxa7GMOF7VFXqx0T9kmP+domxPXINMeG49ExJ1EeWjI=;
        b=rnu1BXzzU6SUprF2PkYI7vwMs0YNmoa7DWnHuCHt5+kwtK2yWDzbIX7kexlUjQl8yd
         XQn0EEjUIadGrT1/kZ5pzdoetoveX5BuEeoY8FIIV5rmL8Sk1WMTH8Im/YjvDTvJI8RD
         xl/T1oUnOhyRu5hND4YXmf5kNlEqQWsqBgRePjFTvpzwS6rjfODgJVArofTMKH1hYYFF
         SMCN8Z5FrYqZELR4+n8pdiiZueA9f5PoBAVdi5lQDjLO3nzE3lTU9hiVwnx3bEy+/Jf2
         dj/e3Ef29yavkbgB5qogHYB28Nv5VH4dIUvlKSiitbgl6ACImYQXnokT0iWEJD2f31BL
         khcA==
X-Forwarded-Encrypted: i=1; AJvYcCURlAZdKJP6b/loafiwqXJq6m0DZpjC1/u5n4kbqKRmLEb+6lsYqAL/20bhRuyKPQ1kq58wk8xL9+H6qu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYhjDaugtly3hazpRB/0owb5OTOv694qZ9TE2lyc6PeolsrSl
	NqWRiunhJzMtMSAWywS+C+GaNdI/XX/AlV3L2yatB5ZEmu41wUwVQQCRhLtlUhxDff+O4D7opAW
	qH3s2h7Zib+lsGkbv4yI2YX1EsveZe++X0AHV4UvZRRiv2wS7b3oZ6P4ciZnDiYfnjw==
X-Gm-Gg: ASbGncvKBTVfW04YIKUWHk/o61TX57y0mnc8Wwsi7eN9xbkai80qljnyCwvOIZVUkse
	9q61WJ6qdEe4otqLxs58/4iyZRTum6nsqcMY45+YHEceO3C/Kxr4xw9yDHkCmZU3WAHe7dNSIVo
	pUpybj3pDGWdCm2ypRRm/jI2eTleHSq/YBanIPUsDL77NSluORtmduLT3OtiPF9YzeuMx4KmcJA
	ZSKd39+LGluCsQyQLxZqwmWqVkH5OmcKXRlB+7UbJLn71VG5W+nIfgsi9VSxoqpTuRHkD4wDaWl
	S1WKfEsDPvAs3TXlvtL0KMHN+HkVCcIiRJ05Q0Ew9zVnlutpiPgVxud7D9bdIM0OXuekDHDyneh
	Ke2tCPgo0Q7OvlrIOF6DnPdNpIcc6qbIOsNBCRztdnkAPAUWPrDfNqEArWLtFgFdpORs=
X-Received: by 2002:a05:600c:3555:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-4562e0370c6mr4631075e9.24.1752617340260;
        Tue, 15 Jul 2025 15:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgTCeHwxhDXyhTXS9WtOn3LM+nLm6DlKLBuErn6V/bphHUjO/N4l7tzta3dyerQor9iy1xnw==
X-Received: by 2002:a05:600c:3555:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-4562e0370c6mr4630775e9.24.1752617339744;
        Tue, 15 Jul 2025 15:08:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e82cf22sm2342345e9.26.2025.07.15.15.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:08:59 -0700 (PDT)
Message-ID: <d6413d17-c530-4553-9eca-dec8dce37e7e@redhat.com>
Date: Wed, 16 Jul 2025 00:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250710005926.1159009-14-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 02:59, Ankur Arora wrote:
> folio_zero_user() is constrained to clear in a page-at-a-time
> fashion because it supports CONFIG_HIGHMEM which means that kernel
> mappings for pages in a folio are not guaranteed to be contiguous.
> 
> We don't have this problem when running under configurations with
> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
> longer page-extents.
> This is expected to be faster because the processor can now optimize
> the clearing based on the knowledge of the extent.
> 
> However, clearing in larger chunks can have two other problems:
> 
>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>     (larger folios don't have any expectation of cache locality).
> 
>   - preemption latency when clearing large folios.
> 
> Handle the first by splitting the clearing in three parts: the
> faulting page and its immediate locality, its left and right
> regions; the local neighbourhood is cleared last.
> 
> The second problem is relevant only when running under cooperative
> preemption models. Limit the worst case preemption latency by clearing
> in architecture specified ARCH_CLEAR_PAGE_EXTENT units.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   mm/memory.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..c52806270375 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7034,6 +7034,7 @@ static inline int process_huge_page(
>   	return 0;
>   }
>   
> +#ifndef CONFIG_CLEAR_PAGE_EXTENT
>   static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>   				unsigned int nr_pages)
>   {
> @@ -7058,7 +7059,10 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
>   /**
>    * folio_zero_user - Zero a folio which will be mapped to userspace.
>    * @folio: The folio to zero.
> - * @addr_hint: The address will be accessed or the base address if uncelar.
> + * @addr_hint: The address accessed by the user or the base address.
> + *
> + * folio_zero_user() uses clear_gigantic_page() or process_huge_page() to
> + * do page-at-a-time zeroing because it needs to handle CONFIG_HIGHMEM.
>    */
>   void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>   {
> @@ -7070,6 +7074,86 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>   		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>   }
>   
> +#else /* CONFIG_CLEAR_PAGE_EXTENT */
> +
> +static void clear_pages_resched(void *addr, int npages)
> +{
> +	int i, remaining;
> +
> +	if (preempt_model_preemptible()) {
> +		clear_pages(addr, npages);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
> +			    ARCH_CLEAR_PAGE_EXTENT);
> +		cond_resched();
> +	}
> +
> +	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
> +
> +	if (remaining)
> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
> +			    remaining);
> +out:
> +	cond_resched();
> +}
> +
> +/*
> + * folio_zero_user - Zero a folio which will be mapped to userspace.
> + * @folio: The folio to zero.
> + * @addr_hint: The address accessed by the user or the base address.
> + *
> + * Uses architectural support for clear_pages() to zero page extents
> + * instead of clearing page-at-a-time.
> + *
> + * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
> + * pages in the immediate locality of the faulting page, and its left, right
> + * regions; the local neighbourhood cleared last in order to keep cache
> + * lines of the target region hot.
> + *
> + * For larger folios we assume that there is no expectation of cache locality
> + * and just do a straight zero.
> + */
> +void folio_zero_user(struct folio *folio, unsigned long addr_hint)
> +{
> +	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
> +	const long fault_idx = (addr_hint - base_addr) / PAGE_SIZE;
> +	const struct range pg = DEFINE_RANGE(0, folio_nr_pages(folio) - 1);
> +	const int width = 2; /* number of pages cleared last on either side */
> +	struct range r[3];
> +	int i;
> +
> +	if (folio_nr_pages(folio) > MAX_ORDER_NR_PAGES) {
> +		clear_pages_resched(page_address(folio_page(folio, 0)), folio_nr_pages(folio));
> +		return;
> +	}
> +
> +	/*
> +	 * Faulting page and its immediate neighbourhood. Cleared at the end to
> +	 * ensure it sticks around in the cache.
> +	 */
> +	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
> +			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
> +
> +	/* Region to the left of the fault */
> +	r[1] = DEFINE_RANGE(pg.start,
> +			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
> +
> +	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
> +	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
> +			    pg.end);
> +
> +	for (i = 0; i <= 2; i++) {
> +		int npages = range_len(&r[i]);
> +
> +		if (npages > 0)
> +			clear_pages_resched(page_address(folio_page(folio, r[i].start)), npages);
> +	}
> +}
> +#endif /* CONFIG_CLEAR_PAGE_EXTENT */
> +
>   static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
>   				   unsigned long addr_hint,
>   				   struct vm_area_struct *vma,

So, folio_zero_user() is only compiled with THP | HUGETLB already.

What we should probably do is scrap the whole new kconfig option and
do something like this in here:

diff --git a/mm/memory.c b/mm/memory.c
index 3dd6c57e6511e..64b6bd3e7657a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7009,19 +7009,53 @@ static inline int process_huge_page(
  	return 0;
  }
  
-static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
-				unsigned int nr_pages)
+#ifdef CONFIG_ARCH_HAS_CLEAR_PAGES
+static void clear_user_highpages_resched(struct page *page,
+		unsigned int nr_pages, unsigned long addr)
+{
+	void *addr = page_address(page);
+	int i, remaining;
+
+	/*
+	 * CONFIG_ARCH_HAS_CLEAR_PAGES is not expected to be set on systems
+	 * with HIGHMEM, so we can safely use clear_pages().
+	 */
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHMEM));
+
+	if (preempt_model_preemptible()) {
+		clear_pages(addr, npages);
+		goto out;
+	}
+
+	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
+		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
+			    ARCH_CLEAR_PAGE_EXTENT);
+		cond_resched();
+	}
+
+	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
+
+	if (remaining)
+		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
+			    remaining);
+out:
+	cond_resched();
+}
+#else
+static void clear_user_highpages_resched(struct page *page,
+		unsigned int nr_pages, unsigned long addr)
  {
-	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
  	int i;
  
  	might_sleep();
  	for (i = 0; i < nr_pages; i++) {
  		cond_resched();
-		clear_user_highpage(folio_page(folio, i), addr + i * PAGE_SIZE);
+		clear_user_highpage(nth_page(page, i), addr + i * PAGE_SIZE);
  	}
  }
  
+#endif /* CONFIG_ARCH_HAS_CLEAR_PAGES */
+
  static int clear_subpage(unsigned long addr, int idx, void *arg)
  {
  	struct folio *folio = arg;
@@ -7030,19 +7064,76 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
  	return 0;
  }
  
-/**
+static void folio_zero_user_huge(struct folio *folio, unsigned long addr_hint)
+{
+	const unsigned int nr_pages = folio_nr_pages(folio);
+	const unsigned long addr = ALIGN_DOWN(addr_hint, nr_pages * PAGE_SIZE);
+	const long fault_idx = (addr_hint - addr) / PAGE_SIZE;
+	const struct range pg = DEFINE_RANGE(0, nr_pages - 1);
+	const int width = 2; /* number of pages cleared last on either side */
+	struct range r[3];
+	int i;
+
+	/*
+	 * Without an optimized clear_user_highpages_resched(), we'll perform
+	 * some extra magic dance around the faulting address.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_CLEAR_PAGES)) {
+		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
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
+			clear_user_highpages_resched(cur_page, cur_nr_pages, cur_addr);
+	}
+}
+
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
  
-	if (unlikely(nr_pages > MAX_ORDER_NR_PAGES))
-		clear_gigantic_page(folio, addr_hint, nr_pages);
-	else
-		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
+	if (unlikely(nr_pages >= MAX_ORDER_NR_PAGES)) {
+		clear_user_highpages_resched(folio_page(folio, 0), nr_pages, addr);
+		return;
+	}
+	folio_zero_user_huge(folio, addr_hint);
  }
  
  static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
-- 
2.50.1



Note that this probably completely broken in various ways, just to give you
an idea.

*maybe* we could change clear_user_highpages_resched to something like
folio_zero_user_range(), consuming a folio + idx instead of a page. That might
or might not be better here.

-- 
Cheers,

David / dhildenb


