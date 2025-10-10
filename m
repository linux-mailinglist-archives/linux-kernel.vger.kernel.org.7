Return-Path: <linux-kernel+bounces-848279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8DBCD449
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D841899D49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36FD2F2601;
	Fri, 10 Oct 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W88mmiYd"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F521579F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102995; cv=none; b=j5Him+AUKb7TOquL3/gfodVM8MSXqPb85znJXg28+h9W+tAEkxe6CP3aZ3DeGC9QlG5H6r4wCy03sfSufEDeWr4aEk6DB3gjnbTBZgIemv2SXipjqbBYmBWA11rluE+MNtXvImKzfJuKTdqk2vygYVyafJgOmKzvV4pmy9ybqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102995; c=relaxed/simple;
	bh=w1Fgc3HCclz3zquQKBtmQfDWKxs0wAwVppHVLqlAGZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg0jcIbwuUT8tNuhXNcHtgveYkUA+ziEjwOM7WinGXefFklRFIoJunExXh7Fr/7dWpPRuABGtwkjuwQLlSIZ9AZGD040WlC1Ev6IVnVC4VLo46km/Li1VPX4mzpTHNJncVQNISrCQJ0NzRdmXfZr6CZP1V2J3kUsDTL3fE/DcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W88mmiYd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so4012554a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760102991; x=1760707791; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug5oFUj5EB8IPBlCRo95a1xL+zEjN6ZeISyw9VBFCCk=;
        b=W88mmiYd6qHbLLXM+ne3Hp0vu6xUaGQkwtv3JGCxNRhJ5AmL7okAeLCP0GC24mBQZA
         1vSXIF9QpFM6E438hrU6bMQxnP9RUcdLT2fKYCMVSgpJ4of7u320IY2kJPKISagp+5ai
         i4YVuci2mxF6Q7UdYStjnECPVaMytDpfI6U3DD8ndRNkejU1/2CeGujOwGzB4u+xD9BV
         IXizk4um4H/VD3/1UzQmPBpWSiBSbtUlikEZFo6ZuqUXhN83X0Hl+xdqHOL67tT3i1HX
         8QRk5InQEbzVFAPo9B3uEbHTOzvU1KNuZIXUI1IZ6E9DVzz+bIbyBd9Ig0p3h00PNET4
         89KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760102991; x=1760707791;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ug5oFUj5EB8IPBlCRo95a1xL+zEjN6ZeISyw9VBFCCk=;
        b=B8j5VUpqjcFuJeTOsEHVXaOhI+WDiyFLp4uIbVCxW1HgGvYtPibcNocVf+mu1gJDDM
         u5m7RvVdVM4X8TTn7d2q4stsAH16PCvzom6VZHD7yJvZRRNjwilBsBWvNbLQSiYcxnG6
         D/nRIpgO0NW2LscxU7iNP3jqz4WcJ2RpdLfe5tpE6P2xG0J9iUwTu/3LEgMIt/YW2Moc
         jVgj5Qj27SKapypO0gB9BT4YaZJtCci0jB76OLQJcd6/RhJD7PuZpbvfzYU7JR5Wh9Z1
         x/Bop5z4CGlEMP/IW8u50bbpmzk8ZGARvLWdeVNIuGoeBy+72zdwzFi0YD2IEaZbUVQD
         ECcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx8b2tyTMzNZl8drdfcjgtd9fMsUFJQk0LLtquKWjun17X4z8BgH8j1+bLJ45ycfwkJMwij0jT7ernnNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFL/V+GUlKIelRL91ibXggS5Ex12ukDp5vuH7Imqi6aruW+dS+
	lpJ2x6yv0yiHjWQTkk8koWQOu3JvkhjF7hyV9A9Sg+TMp4QVlmCYTfT8
X-Gm-Gg: ASbGnct5sFfZAmMNlOQCRl4xYOBJ1RF6naH2IgMjsu6sdNO44GOmYzgAwfLp+R9FoCX
	kdBz7pQwhp4rouDgKhg0almqZ2s6CGQJauoODmjuGohdmqWUgui4p1xQfSW+yK34yGftJnDiAX7
	i4YdaTOBsvlFzpA+35lJlwCakPPbArtB3wKHBl9mqo1Lcc9n9P1z9mmNEp6/KroHC/Pm3ANJ21d
	cMfCc/qMNUjp31bdJFz7kq9/stTb9OgKy35QzOKV3oU/loGXNpg12l72qE9ijrabLCHtlucVnci
	jRO9/w9GNhLNqQgKK/YnaTnN24WSgXrxpUF4QnGXjURKuZPCNJgM9K80wJKJtN2n5e3LEdpn62j
	Q7LazlG7qIjx8NPtfdlV3sL26zLIRqSuYF8oiao/j
X-Google-Smtp-Source: AGHT+IHQoMcu7TJHvzBvarT7XKSM3ouzdFFKivDkPdJXOBygQlFKGONGflmp8270sQLMkzU4rdlviQ==
X-Received: by 2002:a17:907:970f:b0:b41:a3db:a53a with SMTP id a640c23a62f3a-b50a73da0d5mr1228167966b.0.1760102991092;
        Fri, 10 Oct 2025 06:29:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9525bd1sm229030866b.81.2025.10.10.06.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Oct 2025 06:29:50 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:29:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
	richard.weiyang@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Message-ID: <20251010132950.yx6bmvub3a46gcl3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-4-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008043748.45554-4-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 08, 2025 at 12:37:48PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>and __collapse_huge_page_isolate() was almost duplicated.
>
>This patch cleans things up by moving all the common PTE checking logic
>into a new shared helper, thp_collapse_check_pte(). While at it, we use
>vm_normal_folio() instead of vm_normal_page().
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Suggested-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>---
> mm/khugepaged.c | 243 ++++++++++++++++++++++++++----------------------
> 1 file changed, 130 insertions(+), 113 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index b5c0295c3414..7116caae1fa4 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -61,6 +61,12 @@ enum scan_result {
> 	SCAN_PAGE_FILLED,
> };
> 
>+enum pte_check_result {
>+	PTE_CHECK_SUCCEED,
>+	PTE_CHECK_CONTINUE,
>+	PTE_CHECK_FAIL,
>+};
>+
> #define CREATE_TRACE_POINTS
> #include <trace/events/huge_memory.h>
> 
>@@ -533,62 +539,139 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
> 	}
> }
> 
>+/*
>+ * thp_collapse_check_pte - Check if a PTE is suitable for THP collapse
>+ * @pte:           The PTE to check
>+ * @vma:           The VMA the PTE belongs to
>+ * @addr:          The virtual address corresponding to this PTE
>+ * @foliop:        On success, used to return a pointer to the folio
>+ *                 Must be non-NULL
>+ * @none_or_zero:  Counter for none/zero PTEs. Must be non-NULL
>+ * @unmapped:      Counter for swap PTEs. Can be NULL if not scanning swaps
>+ * @shared:        Counter for shared pages. Must be non-NULL
>+ * @scan_result:   Used to return the failure reason (SCAN_*) on a
>+ *                 PTE_CHECK_FAIL return. Must be non-NULL
>+ * @cc:            Collapse control settings
>+ *
>+ * Returns:
>+ *   PTE_CHECK_SUCCEED  - PTE is suitable, proceed with further checks
>+ *   PTE_CHECK_CONTINUE - Skip this PTE and continue scanning
>+ *   PTE_CHECK_FAIL     - Abort collapse scan
>+ */
>+static inline int thp_collapse_check_pte(pte_t pte, struct vm_area_struct *vma,
>+		unsigned long addr, struct folio **foliop, int *none_or_zero,
>+		int *unmapped, int *shared, int *scan_result,
>+		struct collapse_control *cc)
>+{
>+	struct folio *folio = NULL;
>+
>+	if (pte_none(pte) || is_zero_pfn(pte_pfn(pte))) {
>+		(*none_or_zero)++;
>+		if (!userfaultfd_armed(vma) &&
>+		    (!cc->is_khugepaged ||
>+		     *none_or_zero <= khugepaged_max_ptes_none)) {
>+			return PTE_CHECK_CONTINUE;
>+		} else {
>+			*scan_result = SCAN_EXCEED_NONE_PTE;
>+			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>+			return PTE_CHECK_FAIL;
>+		}
>+	} else if (!pte_present(pte)) {
>+		if (!unmapped) {
>+			*scan_result = SCAN_PTE_NON_PRESENT;
>+			return PTE_CHECK_FAIL;
>+		}
>+
>+		if (non_swap_entry(pte_to_swp_entry(pte))) {
>+			*scan_result = SCAN_PTE_NON_PRESENT;
>+			return PTE_CHECK_FAIL;
>+		}
>+
>+		(*unmapped)++;
>+		if (!cc->is_khugepaged ||
>+		    *unmapped <= khugepaged_max_ptes_swap) {
>+			/*
>+			 * Always be strict with uffd-wp enabled swap
>+			 * entries. Please see comment below for
>+			 * pte_uffd_wp().
>+			 */
>+			if (pte_swp_uffd_wp(pte)) {
>+				*scan_result = SCAN_PTE_UFFD_WP;
>+				return PTE_CHECK_FAIL;
>+			}
>+			return PTE_CHECK_CONTINUE;
>+		} else {
>+			*scan_result = SCAN_EXCEED_SWAP_PTE;
>+			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
>+			return PTE_CHECK_FAIL;
>+		}
>+	} else if (pte_uffd_wp(pte)) {
>+		/*
>+		 * Don't collapse the page if any of the small PTEs are
>+		 * armed with uffd write protection. Here we can also mark
>+		 * the new huge pmd as write protected if any of the small
>+		 * ones is marked but that could bring unknown userfault
>+		 * messages that falls outside of the registered range.
>+		 * So, just be simple.
>+		 */
>+		*scan_result = SCAN_PTE_UFFD_WP;
>+		return PTE_CHECK_FAIL;
>+	}
>+
>+	folio = vm_normal_folio(vma, addr, pte);
>+	if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
>+		*scan_result = SCAN_PAGE_NULL;
>+		return PTE_CHECK_FAIL;
>+	}
>+
>+	if (!folio_test_anon(folio)) {
>+		VM_WARN_ON_FOLIO(true, folio);
>+		*scan_result = SCAN_PAGE_ANON;
>+		return PTE_CHECK_FAIL;
>+	}
>+
>+	/*
>+	 * We treat a single page as shared if any part of the THP
>+	 * is shared.
>+	 */
>+	if (folio_maybe_mapped_shared(folio)) {
>+		(*shared)++;
>+		if (cc->is_khugepaged && *shared > khugepaged_max_ptes_shared) {
>+			*scan_result = SCAN_EXCEED_SHARED_PTE;
>+			count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>+			return PTE_CHECK_FAIL;
>+		}
>+	}
>+
>+	*foliop = folio;
>+
>+	return PTE_CHECK_SUCCEED;
>+}
>+

This one looks much better.

While my personal feeling is this is not a complete work to merge the scanning
logic. We still have folio_expected_ref_count() and pte_young() check present
both in __collapse_huge_page_isolate() and huge_collapse_scan_pmd().

-- 
Wei Yang
Help you, Help me

