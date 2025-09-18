Return-Path: <linux-kernel+bounces-823456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDFB86812
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6FC54E3708
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CB2D375C;
	Thu, 18 Sep 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AatbnSqr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456642D7801
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221246; cv=none; b=MTZVhay4M/zuP9M55oVztKAQ+Jrh0p/dQl15baFAFrSHrbqPMvY9WFwFFYfkDgoQMlNgOw/GT+5mAHRmxQRo0WqCC9A0OaD3P/62+QmMrFxSC3ie4krTrjJAk4s/auBIxHSvHKP8AGknzfWY4H0OO4O9t3QEbl8cbr8fdFX57L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221246; c=relaxed/simple;
	bh=kDWoTXtC2Cztan7o1W73YeKQL1XLetHFHlszBgp9hfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHsOeJDEGV4fOsKjYHsn8jou7V2NO58YajE3g6+M3kLUfE77X9cMeCqlCongZ5fSuI/kTxXlfa+59nouYQzC+YRSoKzU8bl8La7jxpNEZji0QQY+df7yB4D8bjsktSaHXdDF6u3chCNujVBSneZmjvL8p+ChyW5TuKu76NN/cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AatbnSqr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758221243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MNQzvgnQbSA8tlqdWTO8IttaK+7+232U4FFvzldgRb8=;
	b=AatbnSqr5Tq0R3uKT62sMjetgeIjbg2tYVyoMykEf0afZ3sFpyfhedkelakPK2TAmueGcD
	wDCOLU5SxiS3vAnD812mJ77iYU7Z3QaxBGC+D80kijF0ky+Cna864UeMvonKBO7ETuneIE
	jTQyqhu+HfiWbosibdt9EA91TOFp2rU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-1dYXDM7lNFuc-c2XuNL-KQ-1; Thu, 18 Sep 2025 14:47:21 -0400
X-MC-Unique: 1dYXDM7lNFuc-c2XuNL-KQ-1
X-Mimecast-MFC-AGG-ID: 1dYXDM7lNFuc-c2XuNL-KQ_1758221241
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de07b831dso6614665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221240; x=1758826040;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNQzvgnQbSA8tlqdWTO8IttaK+7+232U4FFvzldgRb8=;
        b=DhaomJowaT7AdHBi2pHUzhHkHM6LHlRcgNKksCrSGwwGlzVN8aMxoSdPZBXpqea3bA
         +4WI/PHCuwA1U5omcu3IM1Mv8wOWyGctiSnot5q8JxzIQsITTaZL19Ha5osRTjSEdxgP
         Z1F9Nd51ya2NLnXEwwbyZ5ZssQrgufoZvRfAXG3anlwiT5YkfXlev6Vjk3n5fBuKQevb
         Ys1zALm3s5y1E0pSNtC0snJToWHgGGSlJGmKTgLzSjTR32dGlFj11zc5WuSdA5ptIwOZ
         lgUrFNPO4lC87LmLenXVRS+8U473/VOMYQ3mnAzpdBDAV8gY/vgbXW/60tertQ42qvac
         AzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+zbVnO5moEkbeufJWZgLpRRxyeuXQxhEC8txVZea0cg31uyC5sPXfycc2JW4t5vH5eNE+GREm7Ya7tFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvckW/ie7U/vv/LIC9jAR6moOLAh4n1bq9MpZsYVDtrKMBwNOK
	xu9+3k0ufxIXHlUeMDFkPP3R8I15dSInopPSEpxJqilOencjApT2t1AO4Et06nncz3KWOvNfXeI
	IgHDlj21WC1jUigc/i8PiynRDlSjRPqq4B2N60lDeZFGk7KHNz+yfJ63rcS+/iPYS5A==
X-Gm-Gg: ASbGncsXIGDb0hod4TREdBqw7OTiD8s8BflwV059JccHt/QDjUhKNVWZ/mmhW6vXRZq
	gQT1PDKgHPn3US+3NMOASot7VlYzPzvqbYM6kLUSIflrZJHAnDkR6S7fAfv6ErBpt7dAXXSvfAG
	DQM4emgxvABbqKrPdYu+QYSD1SsW+f2LYTKh/68KcTuwBlHtGPgBSiJehEHERcQQZ5TBH6A93Sc
	++ohh76KIIG6UfdUMO3pGHZsvOkQQCd4Q/GgNdRhmsjoOTojKD4lXv9Ddyopn/NaLjU0tPdG/Nk
	tVFC6wTe1xzpxkdJqtrSigPcgLnrKtQoQc8QkFNGY02Eo4ULZ93xfGytsnOcLIH6Wqvx3k70uyM
	j8RB6bxygQDsA+ItPGlleGmf46luk08Xu6sSz9JNiohuZDG8ZxHk21rzLl1aZUWvK/B11
X-Received: by 2002:a05:600c:4593:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-467e75ea97dmr2719715e9.3.1758221240528;
        Thu, 18 Sep 2025 11:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDcj8kHpB0IfY8PipfESjfPatuuZxWzXNEjI5VDUDbjx2iFOuHzJgVkJRxVolHueJd5G4T5w==
X-Received: by 2002:a05:600c:4593:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-467e75ea97dmr2719405e9.3.1758221240087;
        Thu, 18 Sep 2025 11:47:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4750sm4548197f8f.11.2025.09.18.11.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:47:19 -0700 (PDT)
Message-ID: <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
Date: Thu, 18 Sep 2025 20:47:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, kirill@shutemov.name,
 hughd@google.com, mpenttil@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250918050431.36855-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 07:04, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
> lightweight guard regions.
> 
> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
> encountering such a range.
> 
> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
> the special marker in __collapse_huge_page_swapin().
> 
> hpage_collapse_scan_pmd()
>   `- collapse_huge_page()
>       `- __collapse_huge_page_swapin() -> fails!
> 
> khugepaged's behavior is slightly different due to its max_ptes_swap limit
> (default 64). It won't fail as deep, but it will still needlessly scan up
> to 64 swap entries before bailing out.
> 
> IMHO, we can and should detect this much earlier.
> 
> This patch adds a check directly inside the PTE scan loop. If a guard
> marker is found, the scan is aborted immediately with SCAN_PTE_NON_PRESENT,
> avoiding wasted work.
> 
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/khugepaged.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 9ed1af2b5c38..70ebfc7c1f3e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   					result = SCAN_PTE_UFFD_WP;
>   					goto out_unmap;
>   				}
> +				/*
> +				 * Guard PTE markers are installed by
> +				 * MADV_GUARD_INSTALL. Any collapse path must
> +				 * not touch them, so abort the scan immediately
> +				 * if one is found.
> +				 */
> +				if (is_guard_pte_marker(pteval)) {
> +					result = SCAN_PTE_NON_PRESENT;
> +					goto out_unmap;
> +				}

Thinking about it, this is interesting.

Essentially we track any non-swap swap entries towards khugepaged_max_ptes_swap, which is rather weird.

I think we might also run into migration entries here and hwpoison entries?

So what about just generalizing this:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index af5f5c80fe4ed..28f1f4bf0e0a8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1293,7 +1293,24 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
         for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
              _pte++, _address += PAGE_SIZE) {
                 pte_t pteval = ptep_get(_pte);
-               if (is_swap_pte(pteval)) {
+
+               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+                       ++none_or_zero;
+                       if (!userfaultfd_armed(vma) &&
+                           (!cc->is_khugepaged ||
+                            none_or_zero <= khugepaged_max_ptes_none)) {
+                               continue;
+                       } else {
+                               result = SCAN_EXCEED_NONE_PTE;
+                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+                               goto out_unmap;
+                       }
+               } else if (!pte_present(pteval)) {
+                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
+                               result = SCAN_PTE_NON_PRESENT;
+                               goto out_unmap;
+                       }
+
                         ++unmapped;
                         if (!cc->is_khugepaged ||
                             unmapped <= khugepaged_max_ptes_swap) {
@@ -1313,18 +1330,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
                                 goto out_unmap;
                         }
                 }
-               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-                       ++none_or_zero;
-                       if (!userfaultfd_armed(vma) &&
-                           (!cc->is_khugepaged ||
-                            none_or_zero <= khugepaged_max_ptes_none)) {
-                               continue;
-                       } else {
-                               result = SCAN_EXCEED_NONE_PTE;
-                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-                               goto out_unmap;
-                       }
-               }
+
                 if (pte_uffd_wp(pteval)) {
                         /*
                          * Don't collapse the page if any of the small


With that, the function flow looks more similar to __collapse_huge_page_isolate(),
except that we handle swap entries in there now.


And with that in place, couldn't we factor out a huge chunk of both scanning
functions into some helper (passing whether swap entries are allowed or not?).

Yes, I know, refactoring khugepaged, crazy idea.

-- 
Cheers

David / dhildenb


