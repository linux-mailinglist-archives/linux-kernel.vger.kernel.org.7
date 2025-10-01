Return-Path: <linux-kernel+bounces-838388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E1BAF0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 05:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3310B1941D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 03:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FC2D6623;
	Wed,  1 Oct 2025 03:25:07 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD194223DD1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759289107; cv=none; b=UZnIH4dY9zRAzT2401Q65Py9BT8HC4YYaZEUPdkzJaMdS9LMr7PyjS20J6S/UB0G5alckahpyJxPdOl4/q8GusOe4Y3Sou/XbkNLWQ98DXKVJeVp9cIcgPQUn37u5x/dYWuqsAWPFp27a1AmY0CR2rSpFmFBcHNXtlrmMj+ddtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759289107; c=relaxed/simple;
	bh=Dr/B6xtTWOMKj5bnaH/RzsqdzfSt5NRhxJfFscrnlcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDEBIaQwAUfffuQ65OLlJoxNfbpHpTMP7gnSNM7+xYk49mMGAZgeJ5lC1xyx/6VQ6mNvlUKYBTm1rUsPeLqYyHIhpQZe/L1LJtYekiZ6i5/1aYoSmbN2AZAkGifDUNt9+Lu/sUd9cbGjerUL3m3iyUeCw8O/x98VTCqT2zkBbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so4357777f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759289103; x=1759893903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA57N8DSQvEdDyyKBkxAad4tUYCW8q9ybdMKiaOoC/o=;
        b=tQoO+OWPiApj67bgGH0tMTW8yxALwwR1CLna1kWVPFXKpCXSW4dprX/3GJRi33qfk0
         fLCMsbRYfMMo0KqjFBHb2M2WxkVQk6r0zncxoZcrLhtC6Ml7TCh5+VK4R/r9BlKxo1Sz
         GGHmx++G92405eluHZABu8hIQSvChR3XMSTaNRzJ1qEDHTWVmVvqMO9zhgEpCaUY4nqF
         4GI411kZthDmuZ4t5rINnZiy5aa+pvYYflP5f3ZQZXg2iVYxhX75jUVJnEWjv/5HGtKH
         xUKkCmDjb3a2FleepJHaPoRPME4byzNrqhNZpkPBYTW6cu+ZPV6Jx5BMvTX52gMn1j/h
         ohKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7cJlBclCAlJRUzTmgIDrvr/JpZr2Qsshhk1m2ALKOe7nno8Dwjwdin0Zb5VWnwPlqdCWbVseRW5O9F28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBNdbWHTqG5xuhw7gAeqkxHA91IXlOxeMTZ94QdzGbmqu1nA8
	8wyNkwnATjKvAfBAEQHR8Bp5GO/+ZbKZv/8fniK38NN47Gv7p7XqkMUJ
X-Gm-Gg: ASbGncsa8oF9tPslMRNfsPwc8KEy8fyWiSCevTPOq4C1LP9BfFFLiNIoyrjpXm8DOWn
	SBqsGJNW9A81eRWfm/r82lTuubLlf3aZUaYHMk5t1HyLZHid07QjkqCEJIeB0Qp68ewbJnmJLrI
	ORiPMUGAHPy771x61DPZfGCXUzaP1UoGyi9XUDeYNoFQTI3m0kBMe/OEjumn2csoRavexNRoKwp
	vZC/Mk2zIsjc217uJldKvZ380vD4bkKzwlqSZ6MLRXlitJEki7qZFu5wzUqTNRfrEH7SVQ3SaG6
	xyXm0jAgPSxJRYmo3v9iBjThbv5PQLTKn0EaGLYwgk2CCNeZxHRE4LKHu361ZCjRJTTH38EacLb
	fKWwMiwNBt3xgjoGBmX6unS61sJXLm3O6afsDH9Q=
X-Google-Smtp-Source: AGHT+IFBchqrZzaojHRR/WFRnhqsxmy4IwBajiOP3XpKUmxGFc7GSlwImuIjkfg4UuEYFnWVH5+X+w==
X-Received: by 2002:a05:6000:2388:b0:3e7:4697:297a with SMTP id ffacd0b85a97d-425577f5552mr1219739f8f.24.1759289102832;
        Tue, 30 Sep 2025 20:25:02 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm24993352f8f.3.2025.09.30.20.24.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Sep 2025 20:25:02 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dev.jain@arm.com,
	hughd@google.com,
	ioworker0@gmail.com,
	kirill@shutemov.name,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mpenttil@redhat.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	richard.weiyang@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on non-swap entries
Date: Wed,  1 Oct 2025 11:22:51 +0800
Message-ID: <20251001032251.85888-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Currently, special non-swap entries (like migration, hwpoison, or PTE
markers) are not caught early in hpage_collapse_scan_pmd(), leading to
failures deep in the swap-in logic.

hpage_collapse_scan_pmd()
 `- collapse_huge_page()
     `- __collapse_huge_page_swapin() -> fails!

As David suggested[1], this patch skips any such non-swap entries
early. If any one is found, the scan is aborted immediately with the
SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
work.

[1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
[2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Skip all non-present entries except swap entries (per David) thanks!
 - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/

 mm/khugepaged.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7ab2d1a42df3..d0957648db19 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		} else if (!pte_present(pteval)) {
+			if (non_swap_entry(pte_to_swp_entry(pteval))) {
+				result = SCAN_PTE_NON_PRESENT;
+				goto out_unmap;
+			}
+
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				 * enabled swap entries.  Please see
 				 * comment below for pte_uffd_wp().
 				 */
-				if (pte_swp_uffd_wp_any(pteval)) {
+				if (pte_swp_uffd_wp(pteval)) {
 					result = SCAN_PTE_UFFD_WP;
 					goto out_unmap;
 				}
@@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
-- 
2.49.0


