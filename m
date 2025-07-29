Return-Path: <linux-kernel+bounces-749475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA9AB14ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0377A1CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405E1C5F37;
	Tue, 29 Jul 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b48f0fDC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D441B0420
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797220; cv=none; b=o0kWP3HoljP5e/ZyZUV6wZLl9O3+hMioUxx+NxS//HU+RTGrk7BrFnSHOZA53t/E/y0kESfm0WWBWFtubOu2PKxkERQ/OrimWrn6K15aAhWJ2MounikKemd1/TSvhMCrOYVsYpKbq75I3ktWZC1uqcGlTgTai0qfkUE5h/624fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797220; c=relaxed/simple;
	bh=gn/ZxVTX5/lp0cVWN7QNeZ6XIyfJ/CVMnXdlO6bojic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANGLXM7kiNgZOK+StaHAfVhQpDtgANFnA10ndWynblYREnpmIQwvr1+rINMgZriCZgesLj7kaG9cr1Wmb7b8t1f4VjVp8yBDoo7bCOt2of2iQA73b8+dmctIb5SzlznNWg7l3FqQS6YGUNhr3mrMM2ioaz6ygRPBFdAbG9btj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b48f0fDC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b794a013bcso116278f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797216; x=1754402016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iBOO3HPD83Wia82eo/Lz71fr158dDJN9X6lTtZnvkw=;
        b=b48f0fDCa+6b9nIWG8tzIKcgRxgVVZUFNX00l0RrdEOQTI1nF3OI+EDAXFKbO4YjqD
         h7UDGJrgH9BIDL3jyvS0iQykNS0yZa1bSOai7wtHLeSnlOgOfPWh5alxvxpzywSj8FR5
         VQEL2afp/9nL/wxF2nJhstMti6HdXUXgRayjtpbSb+vcLNef7SttgsaHpGyQJEQLyJq8
         qCVGfS+rvovpfyHyoPSBlpod55BY36icCbQhIUy2B0HzGpgmNtB7K3bj+8BGqHXMB8BJ
         8XeXS6t8I+ucccfjgiL2OPgP/DHnUC9yg4Hht3o7OEeKifshUNRwy2wIEEL9Ga5TEfBI
         UmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797216; x=1754402016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iBOO3HPD83Wia82eo/Lz71fr158dDJN9X6lTtZnvkw=;
        b=L3AxCq3Op/9OLfP2yIzXPkGE76mDaA6ASU4FVwxomuKcIt3mS/8CsGAk2r5GG2mXUA
         20susKVsk08Fn0iG2A9pIkeSINCW+9NMtPtzBdW2YIO4YhprXUeM4t3kQ8DuM8wOa4kw
         locCC1gPgBVvDvzqwoacN+C+LvoXYSO0Nmb418IzoV+IoN8Q8TVOvWFeLw1QyECRaR2K
         RSjZbb+exMm+dP8SUw1tdoj5pMzngQSS+GNDCr7XHR/ny8ODuV0vmtlCSTKDj++JeCgV
         g/Amnk1tmfCTyqCmf7Nse0O3D66DW8tVgZqkawMngI7vA1kLzXmvQGwKgkLRNmHSEK08
         uutw==
X-Forwarded-Encrypted: i=1; AJvYcCVRDcfRvGds336bKDKuTUXuCdki8/vPS3QdzBtnM0Xmq+PHld3MYxxKnQkvdJeqp/iSq+BiA0ZIUnYGtpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5M3Nq4l0dvfEIuigJnn5RuX4PhOLECgfLsYodOIX//lyqK2PG
	40nKIkS3GW2gNLu40Zfs1n+9oBS2+9qWmjei1D0QTAqHTs+49QX0yur910GVd/ej8XQvo6CE
X-Gm-Gg: ASbGncv8GdyXQSeSo8ZNu4jb/NPngAz8G5EcjR7XnXJgoCAbEXaDwg5dCoFywvbRysn
	UhvvijXmGeloeLaBUnMTRpBXL1E3my+cyGIpXaJGPnJ8XIO7WS6togq1x6GHx+PkLfaJXtxs2xL
	+WQiLgBE4ejUfX+2bhnnScGaxU9axqYkpAIseN6T7/JCcVKC+hzRdgtZtkiTNZRV675KbtsqrJy
	BW8s2HfPNS3ve/wW818+LWZESeDWL6VW9l5qDWzSJ3Yqcmv8547WvodkNPXsO7PwdoPl38BFXl+
	JaqcNpxpfbNfINoJjgquzmgd8Gh66QviNdkjm68gi1mTNhMCw/boAByTS8GM1ZDECLt1tuq1Pr6
	S3CrAuqub/ipS7rI=
X-Google-Smtp-Source: AGHT+IEIprs1zggr9FmpwKbpcHvwinjoIgq8TSbS938lrRqegcHD6kkTnyQRwqNGGJHiAYpAFwrfXA==
X-Received: by 2002:a5d:5f93:0:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b77672df06mr9719092f8f.19.1753797215638;
        Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4c::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778ebaca7sm12658402f8f.30.2025.07.29.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	PanJason <pyyjason@gmail.com>
Subject: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 06:53:30 -0700
Message-ID: <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753794408.git.pyyjason@gmail.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PanJason <pyyjason@gmail.com>

This patch adds support for damos_stat in virtual address space.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.
---
 mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..3e319b51cfd4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct folio *folio;
+	spinlock_t *ptl;
+	pmd_t pmde;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
+		goto unlock;
+
+	/* Tell page walk code to not split the PMD */
+	walk->action = ACTION_CONTINUE;
+
+	folio = damon_get_folio(pmd_pfn(pmde));
+	if (!folio)
+		goto unlock;
+
+	if (damon_invalid_damos_folio(folio, s))
+		goto update_last_applied;
+
+	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
+		*sz_filter_passed += folio_size(folio);
+	}
+
+	folio_put(folio);
+update_last_applied:
+	s->last_applied = folio;
+unlock:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damon_va_stat_pmd_entry NULL
+#endif
+
+static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct folio *folio;
+	pte_t ptent;
+
+	ptent = ptep_get(pte);
+	if (pte_none(ptent) || !pte_present(ptent))
+		return 0;
+
+	folio = damon_get_folio(pte_pfn(ptent));
+	if (!folio)
+		return 0;
+
+	if (damon_invalid_damos_folio(folio, s))
+		goto update_last_applied;
+
+	if (!damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL)){
+		*sz_filter_passed += folio_size(folio);
+	}
+
+	folio_put(folio);
+
+update_last_applied:
+	s->last_applied = folio;
+	return 0;
+}
+
+static unsigned long damos_va_stat(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+
+	struct damos_va_stat_private priv;
+	struct mm_struct *mm;
+	struct mm_walk_ops walk_ops = {
+		.pmd_entry = damos_va_stat_pmd_entry,
+		.pte_entry = damos_va_stat_pte_entry,
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	priv.scheme = s;
+	priv.sz_filter_passed = sz_filter_passed;
+
+	if (!damon_scheme_has_filter(s)){
+		return 0;
+	}
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
+	mmap_read_unlock(mm);
+	mmput(mm);
+	pr_debug("Call va_stat: %lu\n", *sz_filter_passed);
+	return 0;
+
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -916,7 +1027,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return 0;
+		return damos_va_stat(t, r, scheme, sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
-- 
2.47.3


