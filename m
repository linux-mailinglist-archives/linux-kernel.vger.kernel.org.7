Return-Path: <linux-kernel+bounces-843089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F5BBE62E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE7F7348D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E92D47EB;
	Mon,  6 Oct 2025 14:46:11 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E42D238B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761970; cv=none; b=g8p6OOza8Ya/kicCIPRUSOF9IAUHx+ae1Z4C6whkSDWjkLcYXpCih5y7TVxhU3gyX26G414cb4mOp6ccKF2wuaCM9J7/rBuabi7Y2UBr4tpMS/mxAJWDgsvALxCe6KxXh5ACAueBnTOU3P0bqaKH4b1cC1VGNAyKMXiZ4s5HyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761970; c=relaxed/simple;
	bh=0Kj1bUsArtK+3VWL9yP8YhDmKf3J+wwRDa8rid9aXjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEky3Eeh/PjVVjC2rLJVdT828aqrMBT2q5aTWxXuR7UOg7WOBenrNJLSPm4s+jC3YEd/vl1YlJxfKT9yxaIK6m4GujGb0W8Eyx4HLq+VKP2W3yBFbiRs7TIIDef9XJ4syqi0IUvbzyCy2NE5LNIGVL831KcMGpkWSxRqmdDmSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e430494ccso29713685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761966; x=1760366766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtaiocTtP0D1d6fsZBlllxYLh2dMPWNbD897f/VONZw=;
        b=N8BKnmLSzXx0VNcu9Af2m8XAm5ZXsmkBY47fvidvOrkxkkAbsV0YN4i5xL2zdl9XF1
         vn2liKYyx41ueF9Tm2+z806RVl0kLrf4aH1gIeSZSGgT1PTZhO66I+Xupms0PfJ6QxN5
         /5oiyUhExSgePSVgC0ikSD4lfgBQ2W7HwpX/Tm6AnwxBt6bitRGxwMWc4gheoH7x+Hf5
         vnXZ1HVnejtG1seCodenpa//4cg4N2RTVmXXMJ58B67meclkVYRjJ//q1DFDwZBXm5b9
         oUAWpuR4MuVc/iMTOzkQO6Ls13z4sobPmPI55fnKM6BntnRs/Xd5SaMVtCYBrhFE2zKO
         rH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVuHSFeiHrdjcEOpDUqN3klZenRs88jH9DPNIlOv1Fp7jd//HtBGd3p61XbkD4zJvHSSyDGJ+HY8h6JHkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpmlo2Nv5Q08woa4lcakYswms5wSnMhDGvJ+g3var9vBcCOrxD
	xLEQtNuAN35Smt/6FaggxrLjSkWpAoHBq9drmhMHOYiFNtfL9E7YSGVo
X-Gm-Gg: ASbGncveQLRtweFrXwYEvbbHY7yWQZAQGLb/QivmDi3uk6Xc7Gb3ybZ94y41akQcnZS
	Ujx6d7QxxpxvktIsrCoVg0AGG6BzVm9haB42FRjEtbb2YooZXXaRlhG1CICJbJcHeDxS4AT4BtJ
	/hznowNDktz5bpAQGRL/LuzT8ULv1Mx0sB8CeOSOEQd2uMZBx3wOyl/ERNaN23kbekLKx2gx+kV
	Qh3kUQ8KwdzsscBou2RCMx4cXz+vtapQBlOYdB72oF9FDD0NxgW5UZbxoP8JjNVkSE9YUfFhDka
	bMNlQlFdDXWpEgDlBwtu8vzevwBrk7Gi0wOJnyMNBfZx09viRAzfNk24+OQIrp7IDZ5imsGjmNA
	F7ZNbtOqOvWsbbaErH3DUQSvWM+j+DC6WHFF/CMyTuI2qtPRBNA==
X-Google-Smtp-Source: AGHT+IF5uSZFkd92taI4AFZxuPXGqPv0vhx+0DNW9NrjZaWgfPJ++05mIEV+P/lyyp+2PlV1EUb0qQ==
X-Received: by 2002:a05:6000:2dc3:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-425671ab145mr8359436f8f.43.1759761965933;
        Mon, 06 Oct 2025 07:46:05 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm21242624f8f.18.2025.10.06.07.46.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Oct 2025 07:46:05 -0700 (PDT)
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
Subject: [PATCH mm-new v2 1/3] mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
Date: Mon,  6 Oct 2025 22:43:36 +0800
Message-ID: <20251006144338.96519-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251006144338.96519-1-lance.yang@linux.dev>
References: <20251006144338.96519-1-lance.yang@linux.dev>
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
index f4f57ba69d72..808523f92c7b 100644
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
@@ -1316,8 +1313,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
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


