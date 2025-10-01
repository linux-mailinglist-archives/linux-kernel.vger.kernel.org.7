Return-Path: <linux-kernel+bounces-838614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32FBAFBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 245F34E254A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBD12D8DA3;
	Wed,  1 Oct 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTB1GgTx"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E432D73A2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308870; cv=none; b=WPWH1BxnklXdFI1IgmhdesTyTz6qyGGmaFt/XGKCDD53SK2UKQrf88/MWhbK/SIoczTA1/2NHx0/PD2fyYGf34m437Aw3J9jaHxs9XWR7MQR+3sYI6fvosyoSvRuOIdInv5adK67FiULGEp92QbFy2WGef3aeNcXbylMgECHmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308870; c=relaxed/simple;
	bh=dyMe49zFA170p47KCI/KSAWPXyxFOWx7NrxWJCfANO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSVlg9QZlUz3AlXwsTy1S88Tm1ey2/Da1yNU03r9H8d1XTPAnhuaaFs3w75Ci8q1fE/e7HC3dkjeLKufprwpMwMM1RwrOsKJ+J87mNLzxLBL5IR5eB5Sfd71s+05K2xwIHFCkxukxT62YgvTEm4wVznkZvkZLGHWT9a/+M2gcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTB1GgTx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6364eb32535so5217969a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308866; x=1759913666; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jq+NwjNX43C8IcFtydh0hsU++MGHu2pSQ+/Nx3+Uws=;
        b=LTB1GgTxuAVT5B3Ut3Vcdzi7f4l1Gadx+Gu5TSMgOVh856Wv7MCU+YT44Jhb+qljpw
         /2wxXltpCoO9AF5ofaywLE9BIqWdvUCmKTDXDMvQFyKz6aG93IcMrMlOdgsQ3HivxqWh
         WV0TFkazxtV5gh77t9QeIHcuoU88pKrH+ejkDWZUS0rQgQLNL1Wpi+L9Gj41S+8YA0MM
         zXLuYogiP0vcJcia5gjsnxypuUpIX57wsdIEAUGgNybahtcU3oNJd/9Lsmn3KbraR3HJ
         VtnsmcNKxnTZu663omVh7fcoWtQeYR3K2AEXw73szlRcTxerzxjLY92FG4+w+uVK7sHh
         tNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308866; x=1759913666;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jq+NwjNX43C8IcFtydh0hsU++MGHu2pSQ+/Nx3+Uws=;
        b=ECg2I/uREv+1zHpFfq2ToYQskU4uGDslSA+VxyEID18IPwr9Hvqqbuo9fsZWEtYGQj
         LIKE7RqhL+f28VEK8d/C01gNyWQf8Nz5pQnhotrisXZnjHz7rLOBZv3xNm1XE15y9IQJ
         NGz5MrTLlUeyONYQt3ubgXuxun9yP2tduH6QaK4matNx+188HMAppLrrYYaej5iv9TJR
         P8JgWOTgM7YZ2N5u+Tm+7KP6k0HAqL63raJ5apQgsGZUmx51AxN4pRHuep4LA5Zyjuw0
         Abs0tW5fqIQMp9PpfEq7gm0Thza2U1KQsmddFVN2TsBhXKgpaSC9QDaD/ci5VZsaOwv8
         S2sA==
X-Forwarded-Encrypted: i=1; AJvYcCXuukhpEaOW2IKCGl0G+R1DqDBdcDbiHbYfxLa0nXJMnNADKKLOvWBvMQ09ukZS+PTt70LoSqI+ut1g+Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQIMo+enYDz/TDnUnjvEpMgHyGyN4WtWtOi/WBrt/CBeWPQVN
	J1ggBbv7Bx5fVMGNTWA/LXm1XmSof0tIuClKv8SJX+kqjPbW+F+zymnZ
X-Gm-Gg: ASbGncvMd4cCaIAwnORnoI3KTLGulskEdcX7o/MZkNKp44q84sXLq/w928fC4VHRBIM
	SgaiA3wkLKEaynlnvohXN6kMwfdqB8+x7lEeSNV5vB/WteRvbt03NMpMErOesZaKJ21C+EeS+3M
	fxY8LkGMOSGBAtLd7N1+KARepvUf3/W+Q2l4ZdTRrDkv8jX0jYO3mcpZUJ0O0VvJhoJXa4x43pl
	ddZzz/xPI/8vHVRmhnzuqed55wr+k6H7AHxAv6ifzYcrn6AdeoqBryEtWcE7E0JUZW9Y3pZCJuu
	0Ptocoj2bMXogPYuD2RU1SoT4y7ZWfXNvowMW6rLDwrdEuF4QFgjdiqUwsTK7gBUWCBMPAIWSWE
	Yuz2XDHCVb2TdgeVe0XHmQZNoOSs2sCHyTefOXmEjKkaS+/qHpQ==
X-Google-Smtp-Source: AGHT+IEXQ1igMBNuJPp8r1+b1vCKJaIsvxsCFMXTwEOKWVqNJRrL3GS3CWPQfw5QrY0+nNdCEPtJXQ==
X-Received: by 2002:a17:907:9449:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b46e24366cfmr319920566b.8.1759308866250;
        Wed, 01 Oct 2025 01:54:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b40f9d0a652sm457947366b.33.2025.10.01.01.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 01:54:25 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:54:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
	ioworker0@gmail.com, kirill@shutemov.name,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
	ziy@nvidia.com, richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <20251001085425.5iq2mgfom6sqkbbx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251001032251.85888-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001032251.85888-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>Currently, special non-swap entries (like migration, hwpoison, or PTE
>markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>failures deep in the swap-in logic.
>
>hpage_collapse_scan_pmd()
> `- collapse_huge_page()
>     `- __collapse_huge_page_swapin() -> fails!
>
>As David suggested[1], this patch skips any such non-swap entries
>early. If any one is found, the scan is aborted immediately with the
>SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>work.
>
>[1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>[2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>---
>v1 -> v2:
> - Skip all non-present entries except swap entries (per David) thanks!
> - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>
> mm/khugepaged.c | 32 ++++++++++++++++++--------------
> 1 file changed, 18 insertions(+), 14 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 7ab2d1a42df3..d0957648db19 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> 	     _pte++, addr += PAGE_SIZE) {
> 		pte_t pteval = ptep_get(_pte);
>-		if (is_swap_pte(pteval)) {

It looks is_swap_pte() is mis-leading?

>+		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>+			++none_or_zero;
>+			if (!userfaultfd_armed(vma) &&
>+			    (!cc->is_khugepaged ||
>+			     none_or_zero <= khugepaged_max_ptes_none)) {
>+				continue;
>+			} else {
>+				result = SCAN_EXCEED_NONE_PTE;
>+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>+				goto out_unmap;
>+			}
>+		} else if (!pte_present(pteval)) {
>+			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>+				result = SCAN_PTE_NON_PRESENT;
>+				goto out_unmap;
>+			}
>+
> 			++unmapped;
> 			if (!cc->is_khugepaged ||
> 			    unmapped <= khugepaged_max_ptes_swap) {
>@@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> 				 * enabled swap entries.  Please see
> 				 * comment below for pte_uffd_wp().
> 				 */
>-				if (pte_swp_uffd_wp_any(pteval)) {
>+				if (pte_swp_uffd_wp(pteval)) {

I am not sure why we want to change this. There is no description in the
change log.

Would you mind giving some hint on this?

> 					result = SCAN_PTE_UFFD_WP;
> 					goto out_unmap;
> 				}
>@@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> 				goto out_unmap;
> 			}
> 		}
>-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>-			++none_or_zero;
>-			if (!userfaultfd_armed(vma) &&
>-			    (!cc->is_khugepaged ||
>-			     none_or_zero <= khugepaged_max_ptes_none)) {
>-				continue;
>-			} else {
>-				result = SCAN_EXCEED_NONE_PTE;
>-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>-				goto out_unmap;
>-			}
>-		}
> 		if (pte_uffd_wp(pteval)) {
> 			/*
> 			 * Don't collapse the page if any of the small
>-- 
>2.49.0

-- 
Wei Yang
Help you, Help me

