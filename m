Return-Path: <linux-kernel+bounces-845035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7CBC354D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2747B351161
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BC22BEC2E;
	Wed,  8 Oct 2025 04:40:13 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2267081E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898412; cv=none; b=HC1J+MdRgp6dYeGqHpqUKBl/1ql97xgtwatxRDY7umo5wOwBlIurgIKYAMBqpEmDtWLV922tolCehOqZbr/ke9bZnJdVYGtOj2z70pBQ/+5PKMMocWYFFf3qaEffOEnwGITdSRbShhLaTzfLujm9w5F2p2FqmeESQUjR3uitGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898412; c=relaxed/simple;
	bh=Pqucpul+5RJtUtZoACgpdoHCzTgMciFNbTy5krsKgDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdPwdzkFWF5TBwEIWjRPKh6tHbRnRl8M/yDVRP8PIKKrHtvGFVkEctAxZyk66c3jKkjdangz1wVwv/Wp3buDFfRGMROGCLkpuP0AW12q/ZmClOg2C9Or9Kk2baADYtq3baEZ6ihZdjiKWQhbC6T1bJ/L+tlIRfBkBCRIVu9rI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee1381b835so5944873f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898408; x=1760503208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1vidbU4o/R9Ye6BnVqcmKpIlA05IhBIAjHHRerQXS0=;
        b=vufwmL60Islqfl4aTFd2Ygb35gcOBL1A/1lwT4dIwVG9gC+NII18eWwcFP0S97YUZa
         M4XMX/KLUGTgc+xUcg5gHQKi6o0JHWIHkzZqqhJnWDe2AEAty8bne0yQfhgneFAsFTb9
         RwZkBB1LJuF65dV6PxYV98Q4wGR44tihDQF5Rte7PpoGnUX6ZgM/+AWxoYJITLgXpNkW
         k7QqWQXaQ7DS40Y7nFVDMM9w17OCsXa0LZdpN50TjARxZXH8Ol4FGNOPmvG+Jd+CIIO3
         2JUIZWqTXtmgywzxGxtyOA07/WjUMq2H6HUVb9KwKi5E6WcUkXxKo+wStnI0NljaW7Oj
         ionQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUOX9mgD4eA1R89fGz0blb5ndTMdXmrjJnqrDqo2FA/xmec71IK4HHpBEuI3dTGmUzmz/qAVhMIs+KcIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQk7xM2jMboXf1CFhLb6DndxwwSONoBdz0APmDAnjCHfsB8Unt
	SSnwGdZx2A4uu2Uqf1HX10eXVty4H8hvo6IQ+usEYloYu99Ank9HJJJd
X-Gm-Gg: ASbGncuU2ZBZspBR5zECYZjo0eQby6tFNO3DFH5eyFTkKUIY+0u8UaTF21LcwhzUExL
	H3WFGUFeour04AlmRPVnpjpOeStZyvC7hbASRnwHQwYWSWU922528Xq4VzlZH6JM/t9UPzCT+H0
	hPVjDQHieO07t0BgrSUTftSl6McHaFIcjSt5LtCv1sxr9DKYOvn3YrAIC4twev+q/nn9gzNeTU+
	J6Ric0iQH0vsJ/XnrC3bPjuZ7Tt1VHBsPXO7b4xOnpn1qaXJ+S60TltfOoduXdtk5h+zvRJ2qYA
	qHW5WfYlwgL2tL1dMJYnkT6DdoD+Fep4ga0pQi0Y/xf5PwjLeBKZJZPTw7w1uFNE1Z2VCTFjdNB
	lhGNUf+QDnl5+M7JhcO7YNwVggs3d1FsNCTGzpqQ=
X-Google-Smtp-Source: AGHT+IHOpwHZ85+agtOAF2qCT7IEMETz9GhbzRlWnNeqadDo/gCzv+K2+p7rO5lMYvUpSyxh4Ub+DQ==
X-Received: by 2002:a05:6000:2890:b0:3ea:f4a1:f063 with SMTP id ffacd0b85a97d-4267b3394cdmr964670f8f.55.1759898408068;
        Tue, 07 Oct 2025 21:40:08 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c49sm28159164f8f.3.2025.10.07.21.40.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 21:40:07 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v3 1/3] mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
Date: Wed,  8 Oct 2025 12:37:46 +0800
Message-ID: <20251008043748.45554-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008043748.45554-1-lance.yang@linux.dev>
References: <20251008043748.45554-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

As pointed out by Dev, the PTE checks for disjoint conditions in the
scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
and pte_uffd_wp are mutually exclusive.

This patch refactors the loops in both __collapse_huge_page_isolate() and
hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
instead of separate if blocks. While at it, the redundant pte_present()
check before is_zero_pfn() is also removed.

Also, this is a preparatory step to make it easier to merge the
almost-duplicated scanning logic in these two functions, as suggested
by David.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Dev Jain <dev.jain@arm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index bec3e268dc76..e3e27223137a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -548,8 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (pte_none(pteval) || (pte_present(pteval) &&
-				is_zero_pfn(pte_pfn(pteval)))) {
+		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
@@ -560,12 +559,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 				goto out;
 			}
-		}
-		if (!pte_present(pteval)) {
+		} else if (!pte_present(pteval)) {
 			result = SCAN_PTE_NON_PRESENT;
 			goto out;
-		}
-		if (pte_uffd_wp(pteval)) {
+		} else if (pte_uffd_wp(pteval)) {
 			result = SCAN_PTE_UFFD_WP;
 			goto out;
 		}
@@ -1321,8 +1318,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				goto out_unmap;
 			}
-		}
-		if (pte_uffd_wp(pteval)) {
+		} else if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
 			 * PTEs are armed with uffd write protection.
-- 
2.49.0


