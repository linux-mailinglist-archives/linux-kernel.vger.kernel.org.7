Return-Path: <linux-kernel+bounces-751107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FA8B16552
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A4D1AA340C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3057C2E0916;
	Wed, 30 Jul 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEmL3cF6"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961022DC34F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896006; cv=none; b=nAMHFbcad8wtYq+iwHYE8S+7S86dFCOxwMp6d49IDx60szXhM/cpmtVU5KP+e3r0rbKpj+XIH7mSalC9Q4ZrJBF+kF0gwbI4NJoYjAh/SYpD4Hj+BAseTlWbkrQqvhmXM+QzxL9vPYmhb+JserxjJNCXSSG85eG6xXw36svCH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896006; c=relaxed/simple;
	bh=GdobNqCOO20Whsgzozafpby6KJFetdejZjlrCnc5zdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOfMZyqupF13A6YpFR/MNmDstq7y/DOrd34tLA/bi0LIfUsx94avX2nKoFPSwW79gEezG/Ybc6KuRYuwUDtYAZaPeM4nqNo1j2uHI0l2wfNsYgwbymIPrLoBeYSXmNkbBKZZjquOMS82tlGWNuNdoF3ntyQFVwx9YQvSocyBxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEmL3cF6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b783ea502eso986475f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753896002; x=1754500802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m56piLiCUsf4x2+WWsFp57PljOix1hfz8SW0ckD+2q4=;
        b=WEmL3cF6IyFyUS9XD2q5QiYuzw9W8/ltoiQkI4fByXZy/Q91CYkrYveAY/o7twQVxw
         KLN9bZVKaLdqdzJTsef6fIbjkZ/ocLHg0b5mkZS3brW9G8OHaN2yqmPxJuqJFQMA/MQ6
         t1XPhFtdkkXMcvA4eFpvlIdrx9rB+6pLAPh9zmUeHkRBHzilze2qOOBrhdPIQAlXunoR
         6rvrHXMZ67BZG3LXq+8F3BO3RDJv1Vg0QJWHEcgxCskVS95aC+w2X02hbKGV7miZOxqR
         S1iYf4QiEJ1Trj5G1U3zsh+Mu74FtFwykEKaiE7DNHxPnKOys6hraWpAe5vpdCCSyNqI
         2r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896002; x=1754500802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m56piLiCUsf4x2+WWsFp57PljOix1hfz8SW0ckD+2q4=;
        b=GVfvBYzu4mkPH2EQI2mn3xNcloeIFeUJ98NwGG6E6s+vo4xbjFW+J5PLENdb/WQNKm
         R3dftE699f7aq832rGaeuwFxSgEAZ/HmJe3G3fdEyXxXMgHgSvR/WC+9C8tdTrRlPlwG
         isOB8+IxvDfyWgVO/+RuA9pYP2WH9Cq+bE65sJ6BTUxOEojsMTWfjF3BIAW8lTd9KLVB
         N0+k2QyPerHVfxoOJPtt0e0fH/j5I04LqXiA4eXfQmOwvErWRFh+JEq1LlZVViSZB7JQ
         7j6U2Av0W2lV+o5ft3VoHFJDqzG1T7EonpvW9n1ezAsPwhBk+eKLQD13iu028csJnk9p
         gvyg==
X-Forwarded-Encrypted: i=1; AJvYcCUPL+/iM3Qwg01e7wy0PtVMtCf2qe97vFkdbUkE3uNT2PHjRljDY/jquoiuC+xwnM7W7HKn2oxEcnxZfrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0QHhzPhBMC1ih8voMadN5w6cuAzFe4q7MKimxW7g7u/DebVH
	w3m7NHkTUIgeqKFwoBks33fZSnx6pKiMUsE5znWPXOvMVQO9hQc+X9G6
X-Gm-Gg: ASbGncvtnfrMqlLZ9SvfzrIBmAF9g8IyOpbdGgM2/tBTR2AaxAHEB0vCoV4I7Ta3W2/
	mOawCEp/uUFhFPTRK8EeXjtwWEjXO8JXNsARxY+a/J7QLGmB2V/Y1wD7Cshyeyk9zM4bgrZEmm4
	HhcjTEnDi6iq5sbG+Xwh3L70kebyGCOVamRKZyOiG9m5iFjRRBxh0X2T7nO3mdHiFCQZE7KZwoW
	q/x5Yl7jl12eBYmqZrNRGntQu2dtTt+OI0Sqw1cGaLHbXV8JrWSLqFPLN/XUBDp9pksN1WcR1G/
	vhmOLLdjzo5KW0ItIM3sEGxbNXFaAgdFZpKcnGVQPP6NbinBdXqOC6zNiMp1JICZFFH9ajZ78kR
	hGASHo+eNCPyEjjg=
X-Google-Smtp-Source: AGHT+IGCdHpb01HVcfRvMatDM7O3m0xWJobij7p29QqoVPfMGp10ngvKQXKEPQiuMocwu72i1Rx6hw==
X-Received: by 2002:a05:6000:2311:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b78e72803dmr7193414f8f.27.1753896001745;
        Wed, 30 Jul 2025 10:20:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377ae2sm33277545e9.12.2025.07.30.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:20:01 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 10:19:56 -0700
Message-ID: <c05b1b4f66758c0154e4d037adcb15c43917f38b.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753895066.git.pyyjason@gmail.com>
References: <cover.1753895066.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for damos_stat in virtual address space.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/vaddr.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..6ed919e817e2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,109 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+static inline bool damon_va_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	return !folio || folio == s->last_applied;
+}
+
+static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damos_va_stat_private *priv = walk->private;
+	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
+	struct vm_area_struct *vma = walk->vma;
+	struct folio *folio;
+	spinlock_t *ptl;
+	pte_t *start_pte, *pte, ptent;
+	int nr;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_trans_huge(*pmd)) {
+		pmd_t pmde;
+
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+		pmde = pmdp_get(pmd);
+		if (!pmd_present(pmde))
+			goto huge_unlock;
+
+		folio = vm_normal_folio_pmd(vma, addr, pmde);
+
+		if (damon_va_invalid_damos_folio(folio, s))
+			goto huge_unlock;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
+			*sz_filter_passed += folio_size(folio);
+		s->last_applied = folio;
+
+huge_unlock:
+		spin_unlock(ptl);
+		return 0;
+	}
+#endif
+	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
+
+	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		nr = 1;
+		ptent = ptep_get(pte);
+
+		if (pte_none(ptent) || !pte_present(ptent))
+			continue;
+
+		folio = vm_normal_folio(vma, addr, ptent);
+
+		if (damon_va_invalid_damos_folio(folio, s))
+			continue;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
+			*sz_filter_passed += folio_size(folio);
+		nr = folio_nr_pages(folio);
+		s->last_applied = folio;
+	}
+
+	pte_unmap_unlock(start_pte, ptl);
+
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
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	priv.scheme = s;
+	priv.sz_filter_passed = sz_filter_passed;
+
+	if (!damon_scheme_has_filter(s))
+		return 0;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
+	mmap_read_unlock(mm);
+	mmput(mm);
+	return 0;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -916,7 +1019,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
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


