Return-Path: <linux-kernel+bounces-754120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB3B18E4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6316E2DE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5197222FAF8;
	Sat,  2 Aug 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gebsI6PL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873122A4E1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135588; cv=none; b=CRm4MeLzSaJMrL0f/XsOF0FnM5A+BJdTkWKQ9Hpcy0rTxB32UMOkxFjf3oZGWg3clGMb5nux3Crus6deXQ71iurNI+ZfJwqsNa0yKhpkezyJeDa3DRoM96xKaOAV8bCtU2/ImCYq8u/g0gxsb6QmJKr5NwYtnxRy33h47etkMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135588; c=relaxed/simple;
	bh=OIhIEnmvXQYdWkNBzBDAuw6VY0qCIErnN1M9pziIRrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR1lc6FvqKHn1XDwqLW+EE19sTi2NIvF9CmKZV50GrunSRfy8ivtXlpAZxEtu+hSPTYvc9UIj3lMnWvBpoBxrI5vhF7KC/CfhxBqcTvUP+cu3OEeUs46xLqJd9XQd6HZxREH/W77N1U/vF4zsO2j77tCXrrhvx1zgPfN6/T1o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gebsI6PL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so3954106a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754135585; x=1754740385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l1QuFgekZN0Ih/n7UkLBKW9hzcvuL72STInIzLZ4ZY=;
        b=gebsI6PLAIjB7sw2LyplE4Y3uLjFi/BB8XKow69bD/vDVJ8KKTO4e8TBPojVk36WZX
         w1vroUq27HHfgweLT17CmQ29tOHYZMqw1Ab1/PeRDrz8NcqPRasv97OGgAKF5oEukGH7
         7Y6LkbYwXwi+YxMwmLPJ0EXA3kWx8v1Z69SXVFJK3hMW32ZeHq8XgOYEpfSjp1lwnCjN
         8H1ArKFFRhe/5jTCAGS0k7bfcJabEF8U55M9nb4ea+GFuVTPtlshM7qv26KcC7gWejsk
         qzwMD3IZd/gkNnTsCGBqqXzECEMrRzUjZTZz0FnUtX17MtdsoTDhxyyY52UA82k/mvh4
         jvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754135585; x=1754740385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l1QuFgekZN0Ih/n7UkLBKW9hzcvuL72STInIzLZ4ZY=;
        b=DdDHy4l3Ua77BmbjxMNON/Vrfm1AHdErlytBHzYXXZdKxsrgy07pLNvxcWhw+GIJMy
         KNLPF98S09GY/ddC6IisM5y3sMhuCYPSh87rxoHyNgX3L//bPzeHtsPFjxPbcxZILVKM
         4SbgQK/A5Zu19OcMJDbNVc+fxFpR0KNoYCRFa3qv0ncEvUEWEpkj11agKKsG6v7bSw4F
         FqzY3PB/lQKNMuKqqQ33x+vD/k0G37bw1dPTGSB7C4ADP3z9NKFVzwY0XeMtULUFKZmr
         Gjf1xMePoE8RMaJR/hMf1uTNT/JvmPO7rkTD/lGd9HzLc7FGHE+GRMybaeGJ6WS9bZOI
         jAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWQeEL62FqpzQoRBdpydohyhhTSDdCmjlxr7YBuCfdcmeNn80r0SFb1qGp3MbQQ2+ABSwvrZdyTMVqBZzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWw2Plcyi8n8HsLcqQCJup+cnDU0ViOO40JENiqCtJK96yqyv0
	tnqYxNT/Cyyrc+NSPoU18VscltL0X4lz75QVECLzBTjxJikT70e70spC
X-Gm-Gg: ASbGncvG/r8j2lo+yXfqpnozyviD7ygjKCNAHenuPkobsUcOJeVlm/0PAX4I1mqy9rU
	dXjL4PjAPk21xoN7wEJ7xMqZtufrcN2GNFSVfjYJWu85mfjroRZ9qIAd+1CTZlpYvSEHkbMwx87
	yQ/XiKZVbxupOj88lPBguTpCk/cAjZw+RnJq0FBYTPaEDCpNOw+trepKUYiiqVVpIu1C0BW9HZL
	jn+NAalx8rGpFDWBHkAo2tMjdQ9WkeYuqsRy8oEBs4Gn384xAt0y/tFDPlqaFIbW87kwYt4ZsfW
	zRNah12Y0QCuwGpD+MGr+ZYQAxd+cP0XTQSmvxwcl9eKxRbmKLkfp9LYAOElw1ia5UEr/rtIgvc
	6/vKKrAlMdtu8G9eDOQMWMPTFfCEdV021DTzBXG7kHoxr/R8OX9ucRd+lTDZyNJkiZTQC9Q8=
X-Google-Smtp-Source: AGHT+IEp2fGxaGZZ5CaBRX0BcTcZyFdhDrJCsMO6vtGysJGYlHpKp+oG0jgs4nIVGThUtInH3wGG+Q==
X-Received: by 2002:a17:907:2d27:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-af9401adbf6mr294558466b.34.1754135584954;
        Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm425028166b.20.2025.08.02.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 04:53:04 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v4 2/2] mm/damon/vaddr: support stat-purpose DAMOS filters
Date: Sat,  2 Aug 2025 11:52:46 +0000
Message-ID: <264a4b5ea202fd73c01b349c9694d8bf9978c441.1754135312.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754135312.git.pyyjason@gmail.com>
References: <cover.1754135312.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends DAMOS_STAT handling of the DAMON operations
sets for virtual address spaces for ops-level DAMOS filters.
It leverages the walk_page_range to walk the page table and gets
the folio from page table. The last folio scanned is stored in
damos->last_applied to prevent double counting.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/vaddr.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 87e825349bdf..66ef9869eafe 100644
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
+	if (!damos_ops_has_filter(s))
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


