Return-Path: <linux-kernel+bounces-722592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95DAFDCA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7601C23259
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB71D618A;
	Wed,  9 Jul 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGBbYn/y"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411C145A05;
	Wed,  9 Jul 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022862; cv=none; b=kPOuMm0RZhDOl8bXZj99iwiht5/mMYF586Jos6I3/SkNnZLBgXQemndCBYrpxnes9MjfvKbqnr7n0RPaCQoxTHBR37TASIajvd/Fe23hpucXaGJdxBj8ALutZ2QX5PrsHdxleF0ta1JkAa3141GP7T/EayC3ueNKQ36AijYstFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022862; c=relaxed/simple;
	bh=2tx63+KdOTObd6zqvCEY/MQ4uDr7hrKI7nGRHNi+LY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZz5GWmhN/Adewk+OEVmXVPSyMUQQoj3Gfqe7LFTaHdd8+HABHhviQVX3Mr0m4saQwq23kbKXbwPjIKevcSn/idXkHOULExwtCH1lPCD8bkNfkitT1LIF2aXsZWm1p4rhBiXuS5qfJm77zb2yxaFqBKLoEIPIVZqNeS/P3JvzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGBbYn/y; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eb00so4418884276.0;
        Tue, 08 Jul 2025 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022859; x=1752627659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcIKbfhzMN50M5LtwAnXxnGE89hsJ21qEPoFUKJgyP0=;
        b=MGBbYn/yRNSy+r5jGsiUf+m/8oCcgYZ337ekYqpeNNDJex/v3JtlwZ8AocFGTzrMrh
         +DET3Gc/D0RyYX5ZayG2dFw8sk3gv8bDtSB6o91q4hkfG/3jG/cvc0vM0GbF5uuGlYAb
         QRdko2GPCanvsowoHmyfCPCHrC1HN+6rrvYKt5eBmz+PvLUOxFrpNgEmHGsiAdCNIe9o
         fvmPwvk8jf0/SCkLM7+MU33VVKqFgAynrTolAMirsllcdVahFLKDUipoTQAFcrKdnkF+
         3MufzfVkDPQKTlxbZpKYudrGIsEmfUms539fM7n+AOGrLI0W6t2zZ0VExc1KbKWIURqR
         xQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022859; x=1752627659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcIKbfhzMN50M5LtwAnXxnGE89hsJ21qEPoFUKJgyP0=;
        b=qZ1Ncs7XsRlxrV8HtNBb8n7KJrVShmV6/j13qiJnLrSvvh39bqGt2crPyVqZtwHRRx
         H6ext/W9iZb3XNL0q/h5IMqEq2UjCp5cwz7UbSn9yZTjZJzcGEy3rWbakPYUkDXqhDGe
         V9vT0CenOUDsDgfqK2JQN6coRxYnkJSbrOYSbGBlRZxflt2M4Y2ZecmZV0MOkAelGe29
         K2XRQZFS/7c09RWld53gUc328wmU94gyoXcFW6G5zl4pkuwFXud1uz0DwImHUh3vMgfI
         aQ8fiw1xL+YUWVg8Jw8WeGqxPsvPx9rvLqIJ6L83KlHBlCrOWihnruGUCucZCcmkIm/3
         /gPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLLK84Dzt/EwKN+wIIkvDbtSQr5eJsjI5Xlbi5YgqVeCnbAByceW04/F3eH5vF2l05ad6xrQB6kt+b3bWN@vger.kernel.org, AJvYcCXsEnbnf2nIAeoboWiWKiFo0p1wXUoUDmVAhzhtGEo6PVhCPJHRUltAsNfy2tykUl+pQj+Rtjt+URc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVETNz9Kf8lohql/MgTknevkPQutLG8quw7Xy+v+4LNSp6l5sO
	vtDI1JiQvWg2IfOeiU9k4a9fJHzf0hAc/fFR8TsnE/kFsUg7ikozYMC7
X-Gm-Gg: ASbGncvvcKHgTSK3LA68yaGClgf5tTEK7vZfdouPWIwgt3tzzMG8560/XopD3vVSeDp
	57u7BjmHd1aWYkU/v4eGeHYlA2ltaPpxOjnBgzeEMPodWQiOJOCh6idXzVSuO9r9G89SFhRJRsU
	Xta05swnV6RCjwoDqYAgwLR6ZyqBVMgnwKEfguKBTOGaczJ6cgBvCS/hLSjnjMmNcfcQHhJQLuT
	tUmth7ZK/C6yhBCzm7KvCIPupAXjOL8QtHQWawZVGqY4W9w5L7ItkOEcmepd7zvGYF6NBCUIb7l
	kSbQw4M1bM4M9/cxU7y8E7pEgZ8cyaa56qxeu1+FHYLAXzxrQvpWLvQ67fi2+ym4nHX6/dpn4ES
	iqzO4TNk=
X-Google-Smtp-Source: AGHT+IFYbwWbBORRAOQcUqRSE5nM3ImmXuihNVwFJJ1IgG2vxJBWwJ/OTio7E7L6AtKwcW8L80dpZg==
X-Received: by 2002:a05:6902:2e0b:b0:e84:3657:e50 with SMTP id 3f1490d57ef6-e8b6e0cdb96mr1078235276.3.1752022859283;
        Tue, 08 Jul 2025 18:00:59 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:58 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 09/13] mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
Date: Tue,  8 Jul 2025 19:59:39 -0500
Message-ID: <20250709005952.17776-10-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

migrate_{hot,cold} are paddr schemes that are used to migrate hot/cold
data to a specified node. However, these schemes are only available when
doing physical address monitoring. This patch adds an implementation for
them virtual address monitoring as well.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/vaddr.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 46554e49a478..b244ac056416 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -15,6 +15,7 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 
+#include "../internal.h"
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
@@ -610,6 +611,68 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct list_head *migration_list = walk->private;
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
+	if (!folio_isolate_lru(folio))
+		goto put_folio;
+
+	list_add(&folio->lru, migration_list);
+
+put_folio:
+	folio_put(folio);
+unlock:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damos_va_migrate_pmd_entry NULL
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct list_head *migration_list = walk->private;
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
+	if (!folio_isolate_lru(folio))
+		goto out;
+
+	list_add(&folio->lru, migration_list);
+
+out:
+	folio_put(folio);
+	return 0;
+}
+
 /*
  * Functions for the target validity check and cleanup
  */
@@ -653,6 +716,34 @@ static unsigned long damos_madvise(struct damon_target *target,
 }
 #endif	/* CONFIG_ADVISE_SYSCALLS */
 
+static unsigned long damos_va_migrate(struct damon_target *target,
+		struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	LIST_HEAD(folio_list);
+	struct mm_struct *mm;
+	unsigned long applied = 0;
+	struct mm_walk_ops walk_ops = {
+		.pmd_entry = damos_va_migrate_pmd_entry,
+		.pte_entry = damos_va_migrate_pte_entry,
+		.walk_lock = PGWALK_RDLOCK,
+	};
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &folio_list);
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	applied = damon_migrate_pages(&folio_list, s->target_nid);
+	cond_resched();
+
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme, unsigned long *sz_filter_passed)
@@ -675,6 +766,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_MIGRATE_HOT:
+	case DAMOS_MIGRATE_COLD:
+		return damos_va_migrate(t, r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return 0;
 	default:
@@ -695,6 +789,10 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_HOT:
+		return damon_hot_score(context, r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.43.0


