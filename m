Return-Path: <linux-kernel+bounces-753873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B4B18948
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B936AA2B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347D22E402;
	Fri,  1 Aug 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxpgejxq"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2A2222D7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089236; cv=none; b=kIs5yd4jsyCytaBE35ZrSlFvXvIedpufxuoVATOAhhFrhSCizG4Bb8h7A4OfFoov+OO1j2oWUqDXLyJbDsuucKTwQGDf5Fn0LcY3gufzbmHp7/WgkEGy7MitB6YTAxODOjoQX0dw8LXjHhMOhw7ubuEVURwYztj+7z6xMgzU/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089236; c=relaxed/simple;
	bh=aGdRJ4ByNteA2tQEeCjWddN2fTO05i9HAI+NBYdbV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lfy+TBTlOTkM13y7f/AQfm1AE3XnGRBQMlMn3mA43g3kW7OPZ2TjutLDces8rg3+oWk2I5SZL/JrrjY4rH8X1vjab3t1irGAodlDRwDhb/Tg++yyR2JTBR8gwkgzRWkcgXCfSeeRPUOx2DMBn+mTnV9+LB2ezdxNx2oXQtrAVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxpgejxq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so4223643a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754089233; x=1754694033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UIQftffFi5dmDZFojFIrkTA5pAdhvl7y5sSZY3E7b4=;
        b=YxpgejxqAbCoLBflR97UjaPVTGYUbGy5phZQpjewXaJicYPTYpmhzUveM/dbvottBj
         entuHhec4B6glcqlnyjnwwXfCkwOXbBbZWwoZf0qKIo1KfbfZtaRQjvoGBsrP9eyt5VI
         oLfkA71+cwwrsDIsthstGw38tBdV5KYjZBtHZYocIL5b8FpmQJH/bL8s12RPr+uLMprb
         B8SccDEl/jmIzIeH1Aq+kFYEOFDBfwWomq8Zvbn9oAsm6p7Q63d5/O1BIpj+XQzqOmt4
         Tqf2Q7DTHpAZEMlaZgfvW/13W0B/FpkBUVi4Thoupy98xjIr9aThXzKmeeMCz+P97tA+
         OxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089233; x=1754694033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UIQftffFi5dmDZFojFIrkTA5pAdhvl7y5sSZY3E7b4=;
        b=L5bRThncNwqlkTEMSq0cWkGKnrNEy3WRqDJNFkLgtzsAiclZ9UU35H2RInzHSPvR9H
         r7XYofWfAneRoTntcFkpvMZk7nrRgz14qt6I/ExMy8gtQarhTSnUe/ao1v6gaWG+1/63
         brBJqp0PoyFmfXAkZ9xRLqvpK4aITIf3wlwscf2xU27XjCPs5Uvu3QX5VWTkNdPwUAaU
         +mR7MXqUN3iJ8GL3A9m/JY1eMdLwvOGKTaxVHUJbUB5cddMuvQ4xv8uWOshy7CPTeiJS
         p3dOrc5+fFKnl9VGpmjmiNK63Hl2Dw/XPCirLSbd9MhmK3Qu7mQquMFpGY8G53Cq2bdH
         /Oeg==
X-Forwarded-Encrypted: i=1; AJvYcCUtOEajbh+kWmzFmNPrBhtd9t25GGu+UYk+tpHSOl5zjkZFqIhcRwBEQNokOz7Axrw4PBwE9NwTuQG3Q3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHqFI4Yzb1blir+io+qUnnFDFtjoaD7/oqfJhwF2MpVlwjDel
	AT8LWEsHUO42Q17wk1ZMvgdl2sYgTL2LU58MOY48vNX9+QP5Bg3VhNco
X-Gm-Gg: ASbGncso5lttYTV6VI+LWIMXqcqiHDGGvRS+6BNlCXBQvZ1CsdJyxEil/hPliITweb3
	lBGZaaWstrq/vuC+Kh8PxG0sGUFtziFDPV27sd+X1vg9iEvyxfXBFWR39Tlx98p1gcOr7/2pgoF
	UNTX8C8HaasNgZHIGdxWYMi8ZU6SHVX72cMcLSv/2iBHTJr8TZ2+Qhs19g811b6SwWRGWuybt18
	YgKbjlZpAJMiAN1/Y9Ta0A0W5yFMssxQpXR6gnZG8hiLr8KfrCigVuoOQa90VRyypj9nijd1lTf
	0G/NBLGldNPaADOR6mNb9IMFCWy7FDQ980jsRijeorIxeZnymrzXkc7PmWM5KtaxYu+KFjkSFSo
	NMS4OH1S4iGxD83+Ic9l1QaE8Htf5K3euJtc08SC/BywQEsTXyye3UcnV993HVhXW+NDg36hBC7
	T48KBxPA==
X-Google-Smtp-Source: AGHT+IH5K61GDg0ZUw4ARCfYbwftv+OGfOfF0Y0bqBEfg6jRNeqG2wf12EBb3f41tEzQLAjAwRKi6g==
X-Received: by 2002:a05:6402:3553:b0:615:9c3b:17f with SMTP id 4fb4d7f45d1cf-615e6ef235cmr916363a12.15.1754089233322;
        Fri, 01 Aug 2025 16:00:33 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm3279290a12.49.2025.08.01.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:00:32 -0700 (PDT)
From: pyyjason@gmail.com
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v3 2/2] mm/damon: Add damos_stat support for vaddr
Date: Fri,  1 Aug 2025 22:59:51 +0000
Message-ID: <88cc271642476fa6025f3789781dfc8c2f576eab.1754088635.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754088635.git.pyyjason@gmail.com>
References: <cover.1754088635.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yueyang Pan <pyyjason@gmail.com>

This patch adds support for damos_stat in virtual address space.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/vaddr.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..5960d5d36123 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -890,6 +890,107 @@ static unsigned long damos_va_migrate(struct damon_target *target,
 	return applied * PAGE_SIZE;
 }
 
+struct damos_va_stat_private {
+	struct damos *scheme;
+	unsigned long *sz_filter_passed;
+};
+
+static inline bool damos_va_invalid_folio(struct folio *folio,
+		struct damos *s)
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
+		if (damos_va_invalid_folio(folio, s))
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
+		if (damos_va_invalid_folio(folio, s))
+			continue;
+
+		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
+			*sz_filter_passed += folio_size(folio);
+		nr = folio_nr_pages(folio);
+		s->last_applied = folio;
+	}
+	pte_unmap_unlock(start_pte, ptl);
+	return 0;
+}
+
+static unsigned long damos_va_stat(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
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
+	if (!damon_ops_has_filter(s))
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
@@ -916,7 +1017,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return 0;
+		return damos_va_stat(t, r, scheme, sz_filter_passed);
 	default:
 		/*
 		 * DAMOS actions that are not yet supported by 'vaddr'.
-- 
2.43.0


