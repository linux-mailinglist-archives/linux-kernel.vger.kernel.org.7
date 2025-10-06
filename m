Return-Path: <linux-kernel+bounces-843419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135DBBF245
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34850189A87C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0622DECD3;
	Mon,  6 Oct 2025 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBxL/+Lq"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0052DCC17
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781003; cv=none; b=WlCJuJwHxyft/59BifG5VrAommHasQJ3VhVL7RyTLWwSeEZrdPMQzEiKbhIPQtOji4n3RV/Fw499FEqZrjjXztJVE5DzMiw/SzsVudkCToPDp5ke6kN/yrhAM9saF/WlB6ZwvT9Z+2kRFrPlCK6rFTFJgTgVBsHsGLrzDVMRh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781003; c=relaxed/simple;
	bh=NLExQZtlq7X/64T+L9WPZw2dv47A0FwtKkMlbNC7OO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9kYTjmh67qNMm8jBrkKH2ZDq+mldXwOro8LxlonS+ZPegvWvdKWGH9SyNdaqHYLwoIdkLQwIwr038MxkabttjSD4Qz1QgBnP+H7So9/t5a3zJcLKzgOoe8Z6ZsThVjXHbuUI8ilQHroeTakoP7B52ClCJ6WtVJKBz02o7KVHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBxL/+Lq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330631e534eso5912078a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759781001; x=1760385801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT3gHG08BkG90c6MiUPgy6uFcKswLyMsm2cO/8LgJ2w=;
        b=NBxL/+LqouzSaDUMB7VaPXVhZPewW9r4ybphkcafpfbQOHozRhjingLomidI3Iw5Dr
         G5AX8sicxlsTjGmqcdbgmRgb60uyPp63xt87i6kOeJdTlYjZKPVLfUiPUbjTyOXd5ucd
         Uk+RkPA5oCakOw3bPHXJI2DFcH0GLOEb9qE4428jc0nKyQYAlDy8qod4KUOGDDJzTGB4
         OQed45Mv7klyCht7xiAiW8M1S6rBWsvR+AatdPslpXRoU+ZUp95qv7EjwAtlzyxOHuBb
         OvLycNQB3aDdMyoeDTQzQKglAnX4PDzAW7FYN2t4BVWITFIM79mnu9C+aK61BhYujZ8D
         F/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781001; x=1760385801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT3gHG08BkG90c6MiUPgy6uFcKswLyMsm2cO/8LgJ2w=;
        b=OyqgpITk0Oh0I2HFIvKtP3r2Y9X9LoZ604sTy7OdvPBAeOA9kkUFACErnv1IOO2okG
         61Du2OhOxeGkR0VRK6xUcshGbAvlrXMriPfRoH29+NRIU3uN2Zc+tF2F+mCaYCx/4T/E
         bkmsxl/TaqcTYGjHOV3rlC7Qj6pli5JK2pILAo/euNF5snHmDfrmejHAGVZuY/wR0g9Z
         pP9wyhClad81qDDlfMthWQngee29UVfqpYRD15bRZh8KubnAf/EwStMoeTfXLsvB/24v
         E/mIRWeLQChEI1HBLGrJ3BUYWq3tN7Rdg48CCjWvLy2pv6h+OalAkuU9t1JeHY5VxkU6
         R2aA==
X-Forwarded-Encrypted: i=1; AJvYcCXIOVg5kVL5ljr61zxc6yeSinHrcRBDSlKZECW+n3JG+p/c9ptURe7z3yuNgUIiIpSks/Q1thNB4K8Xn1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0IScBuZdmeO7jXDIdUyYmbZzrPVnKnxiC4ZBQ3v4BZ75lNPA
	0zBJVIMZFUe9/WPT+PRMV61P/SBfLDIWbObKuzwbEiHM85LI+ANUkOxG
X-Gm-Gg: ASbGnct4Sl1eGgDuU+A2cCvAY4pWWAe0ky4ZlG8VB3FkX1/P0s/NIGFn5frptMk2UHz
	OqE01j0kwVRowZEN+miP6o4E+CULgudCo71H4Hqf0Cy7MlN9YAwP2HVIbY+X5E13kqXIfkwxTDG
	TFppPZj6FcZqeLndf8qr8tJRYA7rvQjHc52xVYi8xcRJy9E9TysY5/yvp+xmnZ68Sh35D9ZDMaX
	0Ahh5jGEaK0/JPOsYgsP2I/JIUkyIWwmNCNIzr0bfbwe4I/NbA02qqAbnFCwK6a0qzDtmq3sZGB
	G1ncSZz6fb9t9h0Yqlrk92ZCcOC4Nc/SioQ4wYLp5iECnQ4jmCjC2t7yZp3es1YKpm7uxGX9cwv
	K2arYpMF3IyVJS1NOqGa/mPiMEJ4g/asye3xGsaFr21LlfIjh9I0Z
X-Google-Smtp-Source: AGHT+IHDTaQdL9Cg+WLyZqqSRaiz6Hdnze5SC5rU4ka3LeHNo2UnGttYWx4/NzTemH9+GPk3hGm4Ew==
X-Received: by 2002:a17:90b:17c3:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-339c27d306fmr16089364a91.34.1759781001066;
        Mon, 06 Oct 2025 13:03:21 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0ba20asm163148a91.4.2025.10.06.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:03:20 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 07 Oct 2025 04:02:36 +0800
Subject: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

This helper was used when swap cache was mixed with swap cache. Now they
are completely separate from each other, access to the swap cache is all
wrapped by the swap_cache_* helpers, which expect the folio's swap entry
as a parameter.

This helper is no longer used, remove the last redundant user and drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/migrate.c |  4 ++--
 mm/swap.h    | 21 ---------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e3065c9edb55..97c931b31940 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -561,7 +561,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
 {
-	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+	XA_STATE(xas, &mapping->i_pages, folio->index);
 	struct swap_cluster_info *ci = NULL;
 	struct zone *oldzone, *newzone;
 	int dirty;
@@ -714,7 +714,7 @@ EXPORT_SYMBOL(folio_migrate_mapping);
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


