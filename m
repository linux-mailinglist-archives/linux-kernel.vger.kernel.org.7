Return-Path: <linux-kernel+bounces-724857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26BAFF7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E067B37F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06810284B59;
	Thu, 10 Jul 2025 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkOj9PKR"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE284696
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118667; cv=none; b=JkpZr/zaW2zHkqVx9k+AVqJod+d8ZNP2J/0CCg+UJ7bki8Tp8lyX5wqMOZhDXEmzHr24SnUSnUHwffMd0ncF0/hphuHBKyGeXDshvVZ0z86KqjhnVAKlQhXioq7DilQ7eEyF7qT4HVIwhRiddK7A5duoIFxIzV4j9DvwI8hcbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118667; c=relaxed/simple;
	bh=1dCMBlZYD7wMrYLMl8NGAabEsAtIuvO5ttJMwXWQAG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWVkYYdi+JYMPE3M/ngiZwQ4d4c04L3xlrF4CPBeftLV11Q11v9FgGoNDl5EzB+r4pAlEcVe7GJjgzpqUtVbzo3Aa4wVef8b/4+sArKqo1EJ12Y+X1FiTs6KEHSQcJFEZFs5aVMMQy6CnYK8SeEXk+pTN4QtCisKpfFR+v/8HWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkOj9PKR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so440825a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752118665; x=1752723465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9uQDZMSoLo04nYJSt1eoke5Qxicz761lSMKdLpc5Nw=;
        b=BkOj9PKR2UQOgaWyfa14MFKhPSLVlfDwIfs9N5K5zHK6B6+F8NNhEYehPDBe4vB+/r
         jqQdjFQf2CWNLrNnxBlnWlZkZpqfItI9rTbVenx47cKghAFgABB3m0yHTF0waynKztUW
         Ohs5uIZ62pDGPMfA2Q8gHWHQLXQD3B+V36eyjvSjN+f7vTog6cyblqejalgDRVDVHv/l
         YupvmCIoBraPWJVceaQ8nxkQJE7LqTVwrLLHVEjQ+ArSE0WMcl0LkgTEUAJVPih6F0Ht
         3h/pKnlwo642SwkjQVLRr4fIexlHNuvIdqUkeA8MdxkIKjykkueVq8HcoNqmghoO2oYF
         rapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118665; x=1752723465;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9uQDZMSoLo04nYJSt1eoke5Qxicz761lSMKdLpc5Nw=;
        b=hwQ83vEMNsMtP7mpTSWXdAcu/IHaYBDU34NMkEzjpGuFRWIkXWwZQm+qmzHN15A8/M
         XtHovkYUEaSVV54D7OpqNveTjUi8exhs8LXoudah22Voj9XizzsZBTxeJeee7VRi7aqu
         CYIK4Vh16R7Iq8A2x2W/qTPdB3o4uHx1Q36onOOkhRJ2rd9sN37rlxu1taWkND/+28R6
         lJd3knnTXQDDaCXq4qRiUOr8bglLmmLUqlB/RVtPBFAbX4S+8V9q/1rYKdLg6QjFbguh
         OjQx0VDwf7hLEDeIeLrDylxLNHBR4u29WAUtlW0tNTGSrRnL2CZVSDIjCBrKXZ0s/XQ5
         pnqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcKttwy/tzX+YzfaH6fTl2f9wlpMOk8bmgNgbHhet22UnB0RdwFjLm2zoNOmyu3axblD+As2VsYUznwdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPEqT4157/SPANTXntdxiD+SCk1HKyx4JBmNgzpidG5AkfgZl
	a2tOi+o38eKKdNu/UaxD/C32dvcHEGAcYuDleEafrR1vMP8Ke6FBvwES
X-Gm-Gg: ASbGnctFg0xWzbWKlaPiXyV5agBfuqYDkovAH5Ao0dryiCdvpdTyKxmkyEs6SARILpT
	V+0vetyAz4so31kEoTsUzdIznhzTafFt+ZEy6HEMOB0iILiXtY/DOHgJlne8zgRGUWEK286/Fv8
	26tNhJ60NAVU4d8Dryi+fA2sw3ZjGr8qkr2fkUBVxoKRH6ZhxzFH7wXd7NKui9jJw/C6VP29RvQ
	9MhZYHrgJlIuDQ5ELOkbQ08MwwH8MQWEI/ab4i1wuLV5ypxwQ4eQJublBY015HvIF4vIuS2BNIw
	yOlg6i2GWelxLNrC4DIeXzoSWlya7dTtLqInafGtEyI0yNXp7zeLm0nYcDNU1d1qgRp2Stk0dBl
	QUxtFq0v13Hk=
X-Google-Smtp-Source: AGHT+IEHC3Eha4I792pKQPxkmiPL3iEbJLksc3wQUkP0zzrkb6DMFrqYCIKr7K2zai39OVzBjU82Zg==
X-Received: by 2002:a17:90b:17cf:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31c2fdb9d5amr7391461a91.21.1752118664930;
        Wed, 09 Jul 2025 20:37:44 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm3716320a91.13.2025.07.09.20.37.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Jul 2025 20:37:44 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v5 3/8] mm/shmem, swap: tidy up THP swapin checks
Date: Thu, 10 Jul 2025 11:37:01 +0800
Message-ID: <20250710033706.71042-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710033706.71042-1-ryncsn@gmail.com>
References: <20250710033706.71042-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Move all THP swapin related checks under CONFIG_TRANSPARENT_HUGEPAGE,
so they will be trimmed off by the compiler if not needed.

And add a WARN if shmem sees a order > 0 entry when
CONFIG_TRANSPARENT_HUGEPAGE is disabled, that should never happen unless
things went very wrong.

There should be no observable feature change except the new added WARN.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 85ecc6709b5f..d8c872ab3570 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1980,26 +1980,38 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		swp_entry_t entry, int order, gfp_t gfp)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	int nr_pages = 1 << order;
 	struct folio *new;
 	void *shadow;
-	int nr_pages;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
 	 * limit chance of success with further cpuset and node constraints.
 	 */
 	gfp &= ~GFP_CONSTRAINT_MASK;
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && order > 0) {
-		gfp_t huge_gfp = vma_thp_gfp_mask(vma);
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		if (WARN_ON_ONCE(order))
+			return ERR_PTR(-EINVAL);
+	} else if (order) {
+		/*
+		 * If uffd is active for the vma, we need per-page fault
+		 * fidelity to maintain the uffd semantics, then fallback
+		 * to swapin order-0 folio, as well as for zswap case.
+		 * Any existing sub folio in the swap cache also blocks
+		 * mTHP swapin.
+		 */
+		if ((vma && unlikely(userfaultfd_armed(vma))) ||
+		     !zswap_never_enabled() ||
+		     non_swapcache_batch(entry, nr_pages) != nr_pages)
+			return ERR_PTR(-EINVAL);
 
-		gfp = limit_gfp_mask(huge_gfp, gfp);
+		gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
 	}
 
 	new = shmem_alloc_folio(gfp, order, info, index);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 
-	nr_pages = folio_nr_pages(new);
 	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
 					   gfp, entry)) {
 		folio_put(new);
@@ -2283,9 +2295,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
-		int nr_pages = 1 << order;
-		bool fallback_order0 = false;
-
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
@@ -2293,20 +2302,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 
-		/*
-		 * If uffd is active for the vma, we need per-page fault
-		 * fidelity to maintain the uffd semantics, then fallback
-		 * to swapin order-0 folio, as well as for zswap case.
-		 * Any existing sub folio in the swap cache also blocks
-		 * mTHP swapin.
-		 */
-		if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma))) ||
-				  !zswap_never_enabled() ||
-				  non_swapcache_batch(swap, nr_pages) != nr_pages))
-			fallback_order0 = true;
-
 		/* Skip swapcache for synchronous device. */
-		if (!fallback_order0 && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
 			if (!IS_ERR(folio)) {
 				skip_swapcache = true;
-- 
2.50.0


