Return-Path: <linux-kernel+bounces-722597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF7AFDCBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87AC7B8E17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F622615;
	Wed,  9 Jul 2025 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFRk7t1+"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA511F8747;
	Wed,  9 Jul 2025 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022878; cv=none; b=eOAOCdQLDcXUGuNTy5PXbBc5iQguDTjSLhmQhWky+iD1+6xCKtx7+XidWXjJdW33LuRu16lJ0I589SUIesUpOIvNX6NlFhi2EQFiC5ezwebXvA6Mb9OT3rhKNH7hyAUVkxVhjHugvtvI0Nmv4s6epkS7/ahfPwNvMLIcJouRbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022878; c=relaxed/simple;
	bh=6J+5cIy/RS0xSFqv44VRY5CPmSgMHZJZkpXzMeqwAwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9Y4dmOiC+5MdioYIV6UgZrM8c5k1pRA/1b7XqeRGWE5pyqS5+tIpYlJrynhwwJiqvj3/alkjAtbOEoWVW7esN1R8P6jxNYXsB3r8bEa3OhpBe24FgkP4tG58aJxt4Yd2HbxFng74uojRk7ejkcDMrHjvZLuLv+M+2cJGCX/s+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFRk7t1+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so4346565276.3;
        Tue, 08 Jul 2025 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022875; x=1752627675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwxdkvIH4+jDYN/7Cinl22ra/M1sXM4/dKfSa4ANwTM=;
        b=QFRk7t1+cts5GPrbmFC9mC/Fr9sVI1/4XkUaKpr8vrB1IhqhD7aMC4TowtHkz6ETMU
         tGwazfbVITaxQtVoUZb8KB24sWRoJWxUWOXSGojOcSG5es9K5YuzHbRM/LVpl4laZy27
         CAEaOTfXPsaOLzL8/00OWCa4DMJ8vr2tBNpvqn8gchC5r5kM4r7Rj8hmtJuGSpj2BoKa
         Nl+4EMoUFxgxJkJtUrB/4SIlKPzT31iWYDd68Efw4V4AMCCXoGsGCy7Poeus8dYugog/
         M2qpYePeCmCkMtMQDhknOQ9uJ8FZd1He91DRADZPOPYuQJRzv1SQnWb/kh9EBQQRkIgt
         g9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022875; x=1752627675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwxdkvIH4+jDYN/7Cinl22ra/M1sXM4/dKfSa4ANwTM=;
        b=b/M1IV0QSpcQ0h5RyNzWpyoxbiNhucuPSUObeJmJJ6fw8iC+tUMFjmcrj0JdJ16FkY
         hgaBOkMlo5vaVDaj+hXZCgr408Y54z9ZPw30p21eQOx8TnOaZRrOSeRBTRN455ioOeo4
         v6Olwnjk2aGCO3n18sKBEv2tDrJ7DNW7KvwDhmuAzKsfXZR4TL5Fqtv1c5KzoOwQYFzv
         fNxJQ+pbvli/Gk2nGPCG2qGkC0guaxTysEsWPn51c0uqwIPZajZOSeZzlpIqmP8HCZCf
         HQ/WSx2mKy7ws+o7kZUc9yYF8QTyxRQMJ937Fdq0mOudwaltaUzKUHSglkb1VWAmEJaZ
         zaAw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjYCwRpMPymu/qEzUumhU1dd/iblorWbKbe+OAUMVQNCTqLUyABXPc488qt9+z80c9mUAwC6H8E8=@vger.kernel.org, AJvYcCWJJq28xfpvsTbh8aJ4kzzsf+vX6XG+CqD2bdev8vMl5lTAAilF8jMuiJxU1dDqgbz0lUQJTId82aKzoblM@vger.kernel.org
X-Gm-Message-State: AOJu0YyagqbMuerPHXLDWiDqOvH6uuRaJFalGWIIcTJjC8XIIIsTR7qc
	4y4R3ZzV7yFoCQFG71zVdTu7XHMtK25hfJiUsCkE4X79n0AjE3Eyi637
X-Gm-Gg: ASbGncvaMDoO9I2xGXkSfxQvABy+3i0uNgzRAapD7ZWNvH60mi2oIOxlUGO/VQW7tJp
	0En9W0miAEyufH2WuWG6jS6FcBvgl68ulM6wKEk+2SKQTbPwslCbxqPIv6F3zj6FQK2yEXsDkF2
	oxs7tEqozA4t18SdnB+YAxqZ2rlwW/4muu8vJIJkPqec/Rhcm1+KEXRID8vc2Uwfvy3HCJA3tFE
	mgdT523y2czn+kjncTELiV7ENL4e/U0K+taJBbepLZp/e+4Qr/658oFq+kaZZi4ETMvMK/Yplsm
	t1y0VRZmNxgtDSkYrkLfmFx5KobiTthQLchYB7FZnQofehOgiaJTWpKISRGOn7QSeb0afAI/gZ7
	VWhXJA5Y=
X-Google-Smtp-Source: AGHT+IGxOKv9TT+GJA5HkW+nmvLYwYPGlnDvxe6/6+ea2PSeO270tAsemkQN6HvUwL31Go6xbuev9A==
X-Received: by 2002:a05:6902:4913:b0:e7d:c8eb:92f4 with SMTP id 3f1490d57ef6-e8b6e0eebe3mr1078373276.22.1752022874731;
        Tue, 08 Jul 2025 18:01:14 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:01:14 -0700 (PDT)
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
Subject: [PATCH v4 12/13] mm/damon: Move folio filtering from paddr to ops-common
Date: Tue,  8 Jul 2025 19:59:42 -0500
Message-ID: <20250709005952.17776-13-bijan311@gmail.com>
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

This patch moves damos_pa_filter_match and the functions it calls to
ops-common, renaming it to damos_folio_filter_match. Doing so allows us
to share the filtering logic for the vaddr version of the
migrate_{hot,cold} schemes.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 150 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |   3 +
 mm/damon/paddr.c      | 153 +-----------------------------------------
 3 files changed, 154 insertions(+), 152 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 918158ef3d99..6a9797d1d7ff 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -141,6 +141,156 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 	return DAMOS_MAX_SCORE - hotness;
 }
 
+static bool damon_folio_mkold_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
+{
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte)
+			damon_ptep_mkold(pvmw.pte, vma, addr);
+		else
+			damon_pmdp_mkold(pvmw.pmd, vma, addr);
+	}
+	return true;
+}
+
+void damon_folio_mkold(struct folio *folio)
+{
+	struct rmap_walk_control rwc = {
+		.rmap_one = damon_folio_mkold_one,
+		.anon_lock = folio_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		folio_set_idle(folio);
+		return;
+	}
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return;
+
+	rmap_walk(folio, &rwc);
+
+	if (need_lock)
+		folio_unlock(folio);
+
+}
+
+static bool damon_folio_young_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
+{
+	bool *accessed = arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+	pte_t pte;
+
+	*accessed = false;
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte) {
+			pte = ptep_get(pvmw.pte);
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			*accessed = (pte_present(pte) && pte_young(pte)) ||
+				!folio_test_idle(folio) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+		} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
+				!folio_test_idle(folio) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+#else
+			WARN_ON_ONCE(1);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+		}
+		if (*accessed) {
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+	}
+
+	/* If accessed, stop walking */
+	return *accessed == false;
+}
+
+bool damon_folio_young(struct folio *folio)
+{
+	bool accessed = false;
+	struct rmap_walk_control rwc = {
+		.arg = &accessed,
+		.rmap_one = damon_folio_young_one,
+		.anon_lock = folio_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
+		if (folio_test_idle(folio))
+			return false;
+		else
+			return true;
+	}
+
+	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
+	if (need_lock && !folio_trylock(folio))
+		return false;
+
+	rmap_walk(folio, &rwc);
+
+	if (need_lock)
+		folio_unlock(folio);
+
+	return accessed;
+}
+
+bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio)
+{
+	bool matched = false;
+	struct mem_cgroup *memcg;
+	size_t folio_sz;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ANON:
+		matched = folio_test_anon(folio);
+		break;
+	case DAMOS_FILTER_TYPE_ACTIVE:
+		matched = folio_test_active(folio);
+		break;
+	case DAMOS_FILTER_TYPE_MEMCG:
+		rcu_read_lock();
+		memcg = folio_memcg_check(folio);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
+	case DAMOS_FILTER_TYPE_YOUNG:
+		matched = damon_folio_young(folio);
+		if (matched)
+			damon_folio_mkold(folio);
+		break;
+	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		folio_sz = folio_size(folio);
+		matched = filter->sz_range.min <= folio_sz &&
+			  folio_sz <= filter->sz_range.max;
+		break;
+	case DAMOS_FILTER_TYPE_UNMAPPED:
+		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
 static unsigned int __damon_migrate_folio_list(
 		struct list_head *migrate_folios, struct pglist_data *pgdat,
 		int target_nid)
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 54209a7e70e6..61ad54aaf256 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -11,10 +11,13 @@ struct folio *damon_get_folio(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+void damon_folio_mkold(struct folio *folio);
+bool damon_folio_young(struct folio *folio);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 
+bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 48e3e6fed636..53a55c5114fb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -18,45 +18,6 @@
 #include "../internal.h"
 #include "ops-common.h"
 
-static bool damon_folio_mkold_one(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *arg)
-{
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
-
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma, addr);
-		else
-			damon_pmdp_mkold(pvmw.pmd, vma, addr);
-	}
-	return true;
-}
-
-static void damon_folio_mkold(struct folio *folio)
-{
-	struct rmap_walk_control rwc = {
-		.rmap_one = damon_folio_mkold_one,
-		.anon_lock = folio_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
-		folio_set_idle(folio);
-		return;
-	}
-
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return;
-
-	rmap_walk(folio, &rwc);
-
-	if (need_lock)
-		folio_unlock(folio);
-
-}
-
 static void damon_pa_mkold(unsigned long paddr)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
@@ -86,75 +47,6 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_folio_young_one(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *arg)
-{
-	bool *accessed = arg;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
-	pte_t pte;
-
-	*accessed = false;
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte) {
-			pte = ptep_get(pvmw.pte);
-
-			/*
-			 * PFN swap PTEs, such as device-exclusive ones, that
-			 * actually map pages are "old" from a CPU perspective.
-			 * The MMU notifier takes care of any device aspects.
-			 */
-			*accessed = (pte_present(pte) && pte_young(pte)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-		} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
-				!folio_test_idle(folio) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-#else
-			WARN_ON_ONCE(1);
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
-		}
-		if (*accessed) {
-			page_vma_mapped_walk_done(&pvmw);
-			break;
-		}
-	}
-
-	/* If accessed, stop walking */
-	return *accessed == false;
-}
-
-static bool damon_folio_young(struct folio *folio)
-{
-	bool accessed = false;
-	struct rmap_walk_control rwc = {
-		.arg = &accessed,
-		.rmap_one = damon_folio_young_one,
-		.anon_lock = folio_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
-		if (folio_test_idle(folio))
-			return false;
-		else
-			return true;
-	}
-
-	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
-	if (need_lock && !folio_trylock(folio))
-		return false;
-
-	rmap_walk(folio, &rwc);
-
-	if (need_lock)
-		folio_unlock(folio);
-
-	return accessed;
-}
-
 static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 {
 	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
@@ -205,49 +97,6 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool damos_pa_filter_match(struct damos_filter *filter,
-		struct folio *folio)
-{
-	bool matched = false;
-	struct mem_cgroup *memcg;
-	size_t folio_sz;
-
-	switch (filter->type) {
-	case DAMOS_FILTER_TYPE_ANON:
-		matched = folio_test_anon(folio);
-		break;
-	case DAMOS_FILTER_TYPE_ACTIVE:
-		matched = folio_test_active(folio);
-		break;
-	case DAMOS_FILTER_TYPE_MEMCG:
-		rcu_read_lock();
-		memcg = folio_memcg_check(folio);
-		if (!memcg)
-			matched = false;
-		else
-			matched = filter->memcg_id == mem_cgroup_id(memcg);
-		rcu_read_unlock();
-		break;
-	case DAMOS_FILTER_TYPE_YOUNG:
-		matched = damon_folio_young(folio);
-		if (matched)
-			damon_folio_mkold(folio);
-		break;
-	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
-		folio_sz = folio_size(folio);
-		matched = filter->sz_range.min <= folio_sz &&
-			  folio_sz <= filter->sz_range.max;
-		break;
-	case DAMOS_FILTER_TYPE_UNMAPPED:
-		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
-		break;
-	default:
-		break;
-	}
-
-	return matched == filter->matching;
-}
-
 /*
  * damos_pa_filter_out - Return true if the page should be filtered out.
  */
@@ -259,7 +108,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		return false;
 
 	damos_for_each_ops_filter(filter, scheme) {
-		if (damos_pa_filter_match(filter, folio))
+		if (damos_folio_filter_match(filter, folio))
 			return !filter->allow;
 	}
 	return scheme->ops_filters_default_reject;
-- 
2.43.0


