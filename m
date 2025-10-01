Return-Path: <linux-kernel+bounces-838985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3607BB091E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B2718865A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357A2FC873;
	Wed,  1 Oct 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez26qg66"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93102FC039
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326726; cv=none; b=JJqhglYrfkh84OXq3q8QCaYPvUhB6f0Vemvo5wvq6U00eri6c4GwQ82GKTAeEvPE1Igv4lM1xsYy1JJBe9VfA1qNNF8/bC5JvEkXcl8RLc1qzVQTHIK+8Zm0LZVdqu8qDfXSu/2c+wYxDYAySTb4suXsw6GhTLRGL9UHJ2XOjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326726; c=relaxed/simple;
	bh=bGbHlw2eKIPmYJdXE30mKWDvbuu4jTPqTVve+5FMcg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECoKKPjzVR10XT0cX15M7RgEg3aQgIOtL0v0voqfTLOswPlTvLbRWoie9R3Oy85kjA+zCr3FM67kTvyPalzqBgvwYCgbGIdCE+rypGtmYnSpf+RamsFRVbsLYXnytfu8xJrZJZGX0w0Srsqy2/NP8sJVzxQSJJd/dpF/qoNt+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez26qg66; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so14307443a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759326723; x=1759931523; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTnQz2B97Go8SjHIgN1IQAu6SiGkVevP1PQobrwF0MU=;
        b=Ez26qg66V0LNJga29oLz0SK/AKrXwaZvX/hRUdvs8Co2OfSaouAkS8efITC1dIXZwu
         U6DTV32w0+RlsJLwvOr724q5BUfID+uSp5EJxTQqhsCZTCpLz9mR2xFGSBUrc+FNvm5y
         u57s1wngYKgWYFRaZL4SXY9fmTz0cAj6WZc/yO9iqLCqYZ0/aKdcsH1X5rSKLuxtveud
         q+ePLJawmDRmqpbeE5/uicDS1EXv2j48AhaacbGeqssRCXvHVpzzzBA9m9l1TXZHsrm0
         IIdTHiBqPOBcNwXfGcUs6vxUY88y48s+javhHtuE9wQLg1At2pxmrNRqcnXw3ms2zojT
         Sy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326723; x=1759931523;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTnQz2B97Go8SjHIgN1IQAu6SiGkVevP1PQobrwF0MU=;
        b=od5ahMdDF5WTesUASq1GtEjlGK62lFjdIU69zLE6YhZbZYKiJ9LIjFRBb1s51rqYNo
         qH1L+ntRj9LwZrHhExxba1iZQi4rpYU5c/Y4AHBmm1Gxa9Q3K+cTudxUk1M0bEIsviyv
         Awd49Dp1YFxAdUI+ABjnT9SCel5AJEXYTC2g2k73rsIMiD4rlvy5OnIP9JFePvZI+/lK
         5Q9BSOZvRVEj8iYDX/D1PPRbQCABIIj74PHtVcznVfphPTcVMoO6/wl8n0K4jMsVkpET
         DbDi581Ung81woN00asYCnl9IRtgqfn5M1RX6lVBRsM4sGHWBFEAd2X3mrtBATJSGThj
         jDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHdt2P+vpv/awR9stEmR4lxi5f7zNYPiE4a5FV/GJWCM4TXLwK/RjkhGE9R8IvfhbpTP/ymAWLCv9WTZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qBmv/htQwD/mifv6W95UqPmOEYxTy9JhqpT9Qnof5+gGKLu5
	TA0R1tSxYnsLzmD96PQiE42ZdtuTBb0G+snw4bEINwLbU+Tw4taoV4Ok
X-Gm-Gg: ASbGncvCOvVVwTymckEQJdtnMEHO43dPrb4CTfa8duW74wXWyDdVLa41feZJlVcAvw6
	hbdKzrUfTITI7dgNSP9gVHasHCdnqjfqVy4ZwKAYUyDLrLh6OVFiLs7ZKBqfWs1Gw3BAwH/lTuC
	7PO/71MzZZsTMNCqvTtUtZhJZ5i9/q6M5peckRFoBydbwsbDxo8weNk/Qud1n41YS2BAgWtzGbJ
	mIw5mBE9ofarKi0iUfBPzBBtrvs7Yqw93Igh1+m+54FImClQiLPGN3swKAhLCoFHk0L/z9m8lgd
	3KmZxeFdsrCiuyOHmk+8H40LP3sauCr6+HdkJECbUH4hQtiySdiO5zlLUuKWUU9xCv7Ij7NDW5a
	dRoefaAiiYgM3Q6tnwfINCKEiyq+YSOFm8FvM3+S8rM6nr0EYBw==
X-Google-Smtp-Source: AGHT+IFNRbieOT/gTxdexKZNxiO5EyAejMAeg6/o1NCJvpQm6IlPGrWwds2Gzsok2Sgd/21onM1YkQ==
X-Received: by 2002:a05:6402:270c:b0:61c:7090:c7de with SMTP id 4fb4d7f45d1cf-63678bb6f54mr4184514a12.13.1759326722811;
        Wed, 01 Oct 2025 06:52:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a364fedesm11797486a12.14.2025.10.01.06.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 06:52:02 -0700 (PDT)
Date: Wed, 1 Oct 2025 13:52:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
	ioworker0@gmail.com, kirill@shutemov.name,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
	ziy@nvidia.com
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <20251001135201.fgidcx2w7jnmxinh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 01, 2025 at 06:05:57PM +0800, Lance Yang wrote:
>
>
>On 2025/10/1 16:54, Wei Yang wrote:
>> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>> > From: Lance Yang <lance.yang@linux.dev>
>> > 
>> > Currently, special non-swap entries (like migration, hwpoison, or PTE
>> > markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> > failures deep in the swap-in logic.
>> > 
>> > hpage_collapse_scan_pmd()
>> > `- collapse_huge_page()
>> >      `- __collapse_huge_page_swapin() -> fails!
>> > 
>> > As David suggested[1], this patch skips any such non-swap entries
>> > early. If any one is found, the scan is aborted immediately with the
>> > SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> > work.
>> > 
>> > [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>> > [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>> > 
>> > Suggested-by: David Hildenbrand <david@redhat.com>
>> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> > ---
>> > v1 -> v2:
>> > - Skip all non-present entries except swap entries (per David) thanks!
>> > - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>> > 
>> > mm/khugepaged.c | 32 ++++++++++++++++++--------------
>> > 1 file changed, 18 insertions(+), 14 deletions(-)
>> > 
>> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> > index 7ab2d1a42df3..d0957648db19 100644
>> > --- a/mm/khugepaged.c
>> > +++ b/mm/khugepaged.c
>> > @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> > 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>> > 	     _pte++, addr += PAGE_SIZE) {
>> > 		pte_t pteval = ptep_get(_pte);
>> > -		if (is_swap_pte(pteval)) {
>> 
>> It looks is_swap_pte() is mis-leading?
>
>Hmm.. not to me, IMO. is_swap_pte() just means:
>
>!pte_none(pte) && !pte_present(pte)
>
>> 
>> > +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> > +			++none_or_zero;
>> > +			if (!userfaultfd_armed(vma) &&
>> > +			    (!cc->is_khugepaged ||
>> > +			     none_or_zero <= khugepaged_max_ptes_none)) {
>> > +				continue;
>> > +			} else {
>> > +				result = SCAN_EXCEED_NONE_PTE;
>> > +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> > +				goto out_unmap;
>> > +			}
>> > +		} else if (!pte_present(pteval)) {
>> > +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> > +				result = SCAN_PTE_NON_PRESENT;
>> > +				goto out_unmap;
>> > +			}
>> > +
>> > 			++unmapped;
>> > 			if (!cc->is_khugepaged ||
>> > 			    unmapped <= khugepaged_max_ptes_swap) {
>> > @@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> > 				 * enabled swap entries.  Please see
>> > 				 * comment below for pte_uffd_wp().
>> > 				 */
>> > -				if (pte_swp_uffd_wp_any(pteval)) {
>> > +				if (pte_swp_uffd_wp(pteval)) {
>> 
>> I am not sure why we want to change this. There is no description in the
>> change log.
>> 
>> Would you mind giving some hint on this?
>
>The reason is that pte_swp_uffd_wp_any(pte) is broader than what
>we need :)
>
>static inline bool pte_swp_uffd_wp_any(pte_t pte)
>{
>#ifdef CONFIG_PTE_MARKER_UFFD_WP
>	if (!is_swap_pte(pte))
>		return false;
>
>	if (pte_swp_uffd_wp(pte))
>		return true;
>
>	if (pte_marker_uffd_wp(pte))
>		return true;
>#endif
>	return false;
>}
>
>In the context within hpage_collapse_scan_pmd(), we are already inside
>an is_swap_pte() block, and we have just handled all non-swap entries
>(which would include pte_marker_uffd_wp()).
>
>So we only need to check if the swap entry itself is write-protected
>for userfaultfd ;)
>
>Hope that explains it. I skipped it in the changelog as it's a tiny
>cleanup ...

Thanks, I got it.

Generally, looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

