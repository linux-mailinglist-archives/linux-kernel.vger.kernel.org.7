Return-Path: <linux-kernel+bounces-867528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA5C02D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F6B4ED5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8234CFA1;
	Thu, 23 Oct 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsSOa7S8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06940242D92
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242524; cv=none; b=AlVmK7Q8Nx4+bg1jqUnkopr+I+FN5G2JtLftA++9ofH5khY9vb9lFu/J6M98ohEf8lX5TEzDZyRTdTAuqpJxv+QNrK89BNvxTsbgCw/kF+2BIXdcjlrgO5+y7bp1SOmionfuAi1iX3a2OpHeJRZQDIkT8EW4cp3iztnwjaj8bTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242524; c=relaxed/simple;
	bh=5vTR2bPJ23RezEJ3rwpHcPhu52XwlEuSRF9mdhd0ZWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7S6i5C7pkzJ5pc95yRsu3wTrvmsnU+W4jKy555BWtLIL4JDbAIMaApRjZ2nM3P7gE7qMW1g24FPki7opkwaerGm38r5cajSI6iDBByQPVK1orRyh9ywcWr47rYwhp1+pdyG0rWkbZGCznltS7+RmH2T9TgImMiCic2RxPXGKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsSOa7S8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so673532b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242519; x=1761847319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8OOEgLIxH1NP/inV/C2VhgTfQW+nHNY1mF4Le01HUg=;
        b=bsSOa7S86OWxqUMaIF5EpX3eU7qO+xbtJu9vL+GjdgBxdU2tP5fUQ42mGtQmdCAMEL
         +a3GtA0Vf/cF4/QWhbtvkwxRMyH4+qDQ9/qsJMnIcG8k4eD+9e+xF3OCwCLxSOn4sP4h
         FP94YAm/Q2HqnKHNLor+de0bU0W9RcWmVYV8h2uwzJCu/NKAbaLIidJqZcv8yhiL3HDZ
         VlgAvhZ2NVqXiXcHCpyVfcEM7j0UnsWB+jxr2uomQ1MuiX0tfUe8B733p4M830qDkfVS
         XLlVNQZkrynTpB1zkycFSC15hyyQjgc8MhqQLQCHeh5iT7LsT7lgvNDRf3vL7QtyZjBE
         J/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242519; x=1761847319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8OOEgLIxH1NP/inV/C2VhgTfQW+nHNY1mF4Le01HUg=;
        b=IdVBl4lgPEKf7Fus97y1DMt7Icrq0Gcwppj16hjGRBISLY2Oxn6lcHkxpgcAL9xAaj
         BzI+zZyFYOI3RVWjwVuGX7xyV53j1ZqnJfnvS/NbcQ13+65ept2db0i/MU8MKQIT3whN
         4vn3u1oK3hk3/SLyCpeEPZzE6v8IF4fPZLrKtEHcWf2wU9TntENUZvYwX4lHO2orJd/b
         sWjMAm1IuRLL1beZJhFiATDBxutkwv5+hV+02jQkJRF20SFz9wZypZWFu1jaf+LJKIoq
         TrHy3+jH0zhXq+H2fxkLHacatB1qtT2ZotKJWdDtqEFS3rpbXicJujghbudTosr93nu7
         OXFw==
X-Forwarded-Encrypted: i=1; AJvYcCUdsVf8EAFVr1NA2B8xv3ttR8HcSL9r6U4SDhFz/bG3aFtwyXS7n7WJvDCsCSwxGWWf8SsAUMqGZNieiko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/QCMPCWdQWIhEwxP+BEcjttGpJwm58kI9C/FDCHCnhrf+Het
	Z6UxeMtDroUf8xsYZzaVVFOAs9D8RpOIc97EhS05j8HaeiTfafmquhfe
X-Gm-Gg: ASbGncv19n1A+qYgwi+ZqoxjgmPSAMSZG05PIRRO49EXlHpZ0eIpULmI2JFL4ROT4lg
	2M3ROBAIQJVN6fngDBBmhN3Y4eDLhXybn74GhJDcTVGEm2G1Ke68nE9cFHJC4rDpZwbjN5EcbE6
	NRiTMh0P5ocDOMxYY/RZA0vZdX7EznLfNC7PtWbc132JznQAgcOMlmjPyytqZu1tz0Nl6+l/YYb
	li/F69p/xVPJUKMFxbTMqaWMlnwj4R0dgkBIjpDCX73k9MHA56ZztJOZvBCa6e8Vkd0Vz+K+ueW
	AtePh0p6E41XZ2SEYhLnGa1FipfRPTYC/E+/utvrVoUKSXmFI5tj6d38yaa8YGnhw8YOAzsDJap
	gIBziOCHhmVv2FmV9EFe8D7VH0fPMxz/op0qz1s4AH/KELJ+rf37EmZGfVPM8vxdDX78v85TRwM
	68B5kat04B69QT+GC7
X-Google-Smtp-Source: AGHT+IGJ4P1IHhrkZ11jp4ofxibE3zNJrn7WkMQs8xkK7LYMPI1X94S1q0ADRNnxQSfN5CffRahrAQ==
X-Received: by 2002:a05:6a21:998f:b0:334:a3fc:7998 with SMTP id adf61e73a8af0-334a85859c2mr32604097637.23.1761242519371;
        Thu, 23 Oct 2025 11:01:59 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:01:56 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 02:00:42 +0800
Subject: [PATCH v2 4/5] mm/migrate, swap: drop usage of folio_index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-4-a709469052e7@tencent.com>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

This helper was used when swap cache was mixed with page cache. Now they
are completely separate from each other, access to the swap cache is all
wrapped by the swap_cache_* helpers, which expect the folio's swap entry
as a parameter.

This helper is no longer used, remove the last redundant user and drop it.

Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/migrate.c |  4 ++--
 mm/swap.h    | 21 ---------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4324fc01bfce..ceee354ef215 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -563,7 +563,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
 {
-	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+	XA_STATE(xas, &mapping->i_pages, folio->index);
 	struct swap_cluster_info *ci = NULL;
 	struct zone *oldzone, *newzone;
 	int dirty;
@@ -716,7 +716,7 @@ EXPORT_SYMBOL(folio_migrate_mapping);
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct folio *dst, struct folio *src)
 {
-	XA_STATE(xas, &mapping->i_pages, folio_index(src));
+	XA_STATE(xas, &mapping->i_pages, src->index);
 	int rc, expected_count = folio_expected_ref_count(src) + 1;
 
 	if (folio_ref_count(src) != expected_count)
diff --git a/mm/swap.h b/mm/swap.h
index 8d8efdf1297a..d034c13d8dd2 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -445,25 +445,4 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	return 0;
 }
 #endif /* CONFIG_SWAP */
-
-/**
- * folio_index - File index of a folio.
- * @folio: The folio.
- *
- * For a folio which is either in the page cache or the swap cache,
- * return its index within the address_space it belongs to.  If you know
- * the folio is definitely in the page cache, you can look at the folio's
- * index directly.
- *
- * Return: The index (offset in units of pages) of a folio in its file.
- */
-static inline pgoff_t folio_index(struct folio *folio)
-{
-#ifdef CONFIG_SWAP
-	if (unlikely(folio_test_swapcache(folio)))
-		return swp_offset(folio->swap);
-#endif
-	return folio->index;
-}
-
 #endif /* _MM_SWAP_H */

-- 
2.51.0


