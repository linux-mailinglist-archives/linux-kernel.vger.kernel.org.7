Return-Path: <linux-kernel+bounces-839909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9571BB2B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2BF188D136
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19AE2C026D;
	Thu,  2 Oct 2025 07:35:15 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D93AC1C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390515; cv=none; b=bfgM2+kPd5ORNKmqjSMVPJyUZrB9qUwVtzu2PRfPNuy9wGHPoxH+KbR9IuwF5qBeF1DQ1M5x30NZ4BPMlEdvR45VCltUJEOfuw3374+WGPo2Q8mjW6r7VLh+xhh6mbaYN7XjTpTiYRkP8l/63I7cTGDL23kuhMZKzR4v4K7YUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390515; c=relaxed/simple;
	bh=hpOQoDd/rDbG65uJbBFqF8tifmj75MN2LZv9tHWBIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppOghqFD+tm1R939I9eOKLJxfR6gShuMdQuub7cqWwkTeXrSJmSpJ41TXcqkv9mnbgvQxtJTi13oZsgTtedZ5fkUWrQQBiH6Xt7mDnHyGyj/aA2N+Jv/x+ZPI1JTUihgoUAWZrvsIkuBQ7qVXNlgzsEnbUx227ykC8wMyUGdXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so3793865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390512; x=1759995312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRXzbaSJvEeEuAD//MreCCVgmlc+Vr7UAiNsZmiYS+g=;
        b=hDtuOS6TfdIpSkK0NRxHLmjWYVJQXejaMcjyzC9LGLHch6mtXBPalfNsALpt7xTbbd
         RGXc7smpwT0jn2QYO3i0o4WaUQXQ1X5uwr7xefmz894HRqlchlfT7Qk0qwvK5nSKQZcX
         HQYxn0tF0x0EqUXjS4MbefpDiPDkwQLkp98gkQE+USEHO5p7kNAWIH3xAGgua6LcsN67
         S700Ik6ukv7D0vTLxm3VCAzj3uDlUI6TRB90r5dDIrA0ModZ3kzawa1kmX1qqcx/ln3p
         c57Z5BylWxh5dWsDhRNXztAJo1FMwe0nYO1/FnQ9F2TPB4hQ7eJ0jwP//MPSJhU2WuXE
         /prQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsTkp/rSzOnASZ30mAtb0L+XV8fyZAcBzt5jMB12EIWupPsDdpNstyxtuRFbHOw1INVEqOznoDsorHBrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycay195sN71uL/IL5I8AziP5ESe5FsiOIfFyzPo8apEPitVTI8
	vo0mkoB2s5baCRMDrG/N5hTJRyXDLIZyaRA1vZ/fVyiEgbHrE+etVlqD
X-Gm-Gg: ASbGnctrm+ujvfVanWd/pYzAPJFrJK7L8H5+BiapP7IZv3rq8Hxq6E2Vi4Ey7h9QYzs
	tKZpsVMP46qTRnSwSDdsa0IEp7XcpqH0sfmXAwInkHjKgIIF0Hb85QjH2tD0BUEfzDhUkQPpBf1
	GCS2n5rzF0LyBsgreGxLqDxOU9N2FMkSS2lKvNICNP9LI+XI4iaRkBjTADf5uKlQVoL7uGAdB4h
	GwKjLGKkQD7nBtShMpxqXiun1KohdJAZhTw1ODbZxsticAScxIM50NcpFGB6BDgnW9DsEKxA5/f
	gF8gkc2lBmE7y+8bdsVXIHkiOf6NTCD1E/pqInpOXslhwen0ObbFb7vQzmG/RM7QDkjlQYytg4i
	V28wax0yNC5KoXgSWJtVTwKSDwr9zgZ9HzPXJ6R4=
X-Google-Smtp-Source: AGHT+IG2jlLDIgDG0wBkYWool7Xk9VaM4c6zOW54Z9lnjZVwUFDfiLKSLmpYXXdi82tG9D7HIgWkzg==
X-Received: by 2002:a05:600c:64ce:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-46e61262498mr50328435e9.7.1759390511979;
        Thu, 02 Oct 2025 00:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6a692af6sm17856135e9.21.2025.10.02.00.35.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Oct 2025 00:35:11 -0700 (PDT)
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
Subject: [PATCH mm-new 1/2] mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
Date: Thu,  2 Oct 2025 15:32:54 +0800
Message-ID: <20251002073255.14867-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251002073255.14867-1-lance.yang@linux.dev>
References: <20251002073255.14867-1-lance.yang@linux.dev>
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
instead of separate if blocks.

Also, this is a preparatory step to make it easier to merge the
almost-duplicated scanning logic in these two functions, as suggested
by David.

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


