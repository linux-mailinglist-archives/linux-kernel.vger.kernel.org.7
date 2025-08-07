Return-Path: <linux-kernel+bounces-758545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2DEB1D0AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845901AA349B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CA278156;
	Thu,  7 Aug 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QP4t7ZGq"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B326B2AC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531134; cv=none; b=VzL0CYUUKlqdqoZJSaOTqxx8+sQMTtD/4nfAtd9CTYqvC9siSt9ousmx+QzIfBVwfvVn68EUqmENPQ3I1Wpt24qs6mKgTjJq267ZrqehNKdsS8VkvnwkRB3xfcZpHiKEyMH0klNjs+YgiFL6bfxc0q7LMoQLllVGbrBH5jPzhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531134; c=relaxed/simple;
	bh=QBZ+QExF2IQaP6/YZb4gORsOYwd34GE+7HN7nommpfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEhbU5vG+wQt33UkZF12UXzZxpEiXdyJJqso9hMfARKlRiKm5h75sUi9O6Eiyo4IhqB8UKNq16+8vAMOF7xT2KtvyWeeXNqL152oGv34FAut6kooOqlnKJox81UypjbAaiszCPMr7yw62bYpC0JP6e2JrTgGNFfOK4URrDZkVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QP4t7ZGq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70739d1f07bso7249806d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531129; x=1755135929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNpjHXepLLwpraPv0r0ol85rEMD4xKPLfeNr8R2KnmQ=;
        b=QP4t7ZGqaRM1MHTTNknkdldlXtejuPccqDZgcTi0Oj1uJw57mam6ERDL8a+U+yLRq7
         lclxE4IA4RUmg3X57ecRhcfJgjV7UTqs4pxUvaiD4Yk/9wDKzZt1SoNPy/uFYpxpwsRn
         k78+AAgCN/OYJ1ajfkRqyR3mGBoXovK09H6LY3ev2c+3HIIKrfcLQ+5242CHXHpCrLbA
         93FFvOS+z1oimaHkt9lM/FgEQ1CqKF7o7F23ozTFyvvWPZKuJ3t+PQzLT/kFmBxm6f9r
         5CFvRjv1XjFuTiZaTHcc7baTqkrIvTIr40QZsWp0dktZ2N9AJCuKGHdBYRIEK8T8Y5O3
         fkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531129; x=1755135929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNpjHXepLLwpraPv0r0ol85rEMD4xKPLfeNr8R2KnmQ=;
        b=YQad1Q624EpJZb7wnt/xlYquWBMEGu2EEcypVZ8Z7ecKApbGz0dfGOAAvcn0uG/oce
         5HZgWcmw/AlCJ7Nis4gn2k7uTQbnztXaIZ+aPfkeKbFHNaLBSFYMil5q3npEwtRq06Az
         pqqRiCW2o54Th7mASE7VM7gxa04L22to3jw/uF05qVeUvrD3BVIFjEt/dSbieCv3/uB9
         5T29gbaydVmWewpt5ZSILByhOWprs7gUIifTyVUJXx5B4U2NWAjPcUVhlWdSbHzIm9U1
         98j2LOSAMkeVeDUcbISFvFsVvQhXgOt2FVtWXlPuJEXY2HMUnieTFMBW58FGeQ0P+bkz
         an/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaLFufw2yYXpu5waHhdltTrMZ236UZltd9xLj13ROEBMoBVRW9Ikfz8admFhTRtnRnerMe+CDdNx4Dk7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpJut0FYJmAbWDL2ZNgVDy6o/9u5Ik4opPifJtFKd1lhImUja
	WaPS1l1/8nWamk2lu6Ez0Vk3XpwKUgANTgpyojbuK78hAunE5nr8YpKy+7BGodKcDs8=
X-Gm-Gg: ASbGncshRfhO1JRWU4C+WSi6WQsHxvSKXTYM+yoUhedBVUVyn7yHOtHilHRv0xNz+bn
	54DhMPxaqvLxCiaBesCvzCTmN5mnNS3V2XJUN0gpQnPJQIuYZbp34OQTlzJnYadzbe50uZ8g1kw
	PW45DBCmffRy1fik7rF8iJR8smmyPY3M3Q6sF2/g7Tr+xjvHWvKeS40TcY2V+z8Jb+G3e6bDISg
	b0cukqdoatXgT+sH19FTH6GDI1wGtUdi47DX+PATFwA+c8JHPEZxMZ4QdYAYLoPW8sBlssV8kUB
	qs1j/6mKvbzHFDxK625t5ImRSZtzMqNvOZhg8o/T4dcnDEZ0DufRT/J78F+eEngDjddVn78dWV6
	Du5CqlTTpE9c3qgHtpuzYvi1/OiHB/oLigZfoMDEO7bml2igQTV9TKCCgrW1Xq+MNvz11BnwPUJ
	MmE9LNVcfUz+4V8oHbSVilDVo=
X-Google-Smtp-Source: AGHT+IE5gyxbiCqCqrXVqnuWA1mkhz9OocyomyZ6jSXE5mTuz1p3dbFY4IvWv4kGZUKx4DkAznRCTg==
X-Received: by 2002:a05:6214:76d:b0:707:6977:aa77 with SMTP id 6a1803df08f44-7097969f103mr61593626d6.33.1754531128252;
        Wed, 06 Aug 2025 18:45:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:27 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 28/30] mm: shmem: export some functions to internal.h
Date: Thu,  7 Aug 2025 01:44:34 +0000
Message-ID: <20250807014442.3829950-29-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_acct_blocks(), shmem_recalc_inode(), and
shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
functionality will also be used in the future by Live Update
Orchestrator (LUO) to recreate memfd files after a live update.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h |  6 ++++++
 mm/shmem.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..5cf487ee6f83 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1566,6 +1566,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp);
+int shmem_inode_acct_blocks(struct inode *inode, long pages);
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/shmem.c b/mm/shmem.c
index ef57e2649a41..eea2e8ca205f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -219,7 +219,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static int shmem_inode_acct_blocks(struct inode *inode, long pages)
+int shmem_inode_acct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -435,7 +435,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  *
  * Return: true if swapped was incremented from 0, for shmem_writeout().
  */
-static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	bool first_swapped = false;
@@ -898,9 +898,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
-static int shmem_add_to_page_cache(struct folio *folio,
-				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp)
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	unsigned long nr = folio_nr_pages(folio);
-- 
2.50.1.565.gc32cd1483b-goog


