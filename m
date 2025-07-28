Return-Path: <linux-kernel+bounces-747609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4017B135E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD607175166
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6E22FDFA;
	Mon, 28 Jul 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp4Z61Oo"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49522DFA4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689227; cv=none; b=TgDsY52Z7l5upji0lGiKxGezaPu+VALeToqwWzRVc+pK+Sojy9PFN6gTWG/4e4bwwiCIkqRO6fzy++IQEmBMN/AZWTzLiJDnunQNES3x2dulTtHyRKaoamth2rkpWdIJpko6webxlUIBi+eAqCrLM/gyfaOSNB/KGntkjpl+vp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689227; c=relaxed/simple;
	bh=rADwympzNSiInHPgjw5Nne/U8ChKm+M22bcxBCELWkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxW5E4UAOfu3kt4GS7CPLvD47Ha1I8tXSFCNNA/UyYuCzYUIp0cerES+HhtHjwxlSY8OqEAyVXy+5lpzU9e1POFhBgk+hHAtRb5DPviNMiD8onX4+8Wq1CywvN9skjI9lnmEb2edgR1cMh4JCLq1WTwsLs7JpdJJ0x0a+aWjeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp4Z61Oo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24049d16515so1176235ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689225; x=1754294025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuE5xxPZv2QYtOzFC8IOGCR1dUU/2TmA/3KupH+/Iuw=;
        b=lp4Z61Oofd/D6VIFVi6hkAjDfne5sA0GkIUT2l5t9Twlbd1gGhnPVUPAaQj1wdmTtq
         aQCN1T3u2eA+OzSWOFZk6Wa4h3OHet/sAQUnRP6o/+TWqklF+ZNIRierx5i9dHTHu8Sg
         ZtLF9IlEDPeAOrkt4s9Db/IPBBTSmih0vMqI45mGExEfXr+rlLnQMBAu5Lx52+uKeY7r
         VHfJTu8q0uyo5/B41I/YIFN8P9clPtw64y+dGwz2QESohi2cfVibWlyykQpo6IPVCOOV
         NPSnAn5xngGbekeqdAcRiWbneQWvuLrimDBysZ/D6ZqE5KHN6+/GLrZRGihrHPpQ+uII
         NyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689225; x=1754294025;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuE5xxPZv2QYtOzFC8IOGCR1dUU/2TmA/3KupH+/Iuw=;
        b=qjd5Zeu0a8Xe90n+HDf3h6DAaV0k1mbKLAdU2D25Z5Y9m/Gnoc7SkiC18JILfh6Qur
         x2UeMi57ppXlUE15fvqWOdatTYRlS+Q04OnUS/VGocIRxQ2T6Ly0zFz3qLvAJfybuHTK
         ZK2h3lBE7lEGLdpSP2f4GonZM+b/RRUbLyKD5953FZNXEBM6tRbsqtlKSm63KUdZRoqn
         3n7SRpwOjSWZBFmxFr1iayJG4HaWxujyReV0q8IuMPUo6UWGk6BUVnQ1TybUP8iy0vB3
         ERohr9AbUS+hcP4pGPUnoePTcBDhMMMPO3Pttx1Fw78kLQhu6X/sF3bTOZEsD1v4KpD/
         mvWw==
X-Forwarded-Encrypted: i=1; AJvYcCUiEuY1GzXlQ2RhBiJoYHjKZ4TO9GJZkmpA99YYmI0ZjwWwj00g6jzw9xETW+3UyxO033tE2S/sRKv8Fds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4MA727HABgjQZlf4AUaPqWq9gi7Mq9NwGdGrrzxHOfnANdWM
	nIs2vf+SV1dBffNqsxow3m68iZRzK0BSBNPFfkqUIYn86s3kmU5i1Dhx
X-Gm-Gg: ASbGnct3/dCiY/UiL/A5wD6S6twK/y3PttSCNylENrmdsj7WTIqKEaBOE0Scj1piJ9l
	wXKrTmproF5RtMuIijDlOZzJKaq6+Jv9vcwZMr2438JP3qHSwfnlj2biExmkyq4X82KfsGOA20e
	haQ4ZPuPT9PlhcgpqeYArjLrN5v3rWcJxPD4vsYNG43oUhjrO8Cs4yg1ZqkmBC3RAgWqwS+6X+f
	5pd16dxt6o4WN0OVq9vBMbLNqHe/x1a+bdKXeE7TIL7dbcy7beoE0d298yVttCIh64tL7C6E9cB
	NCKX0G6dD3IUmDu6hdpDWL1PQ4+bP1TD1xIBmOArD/Y7EJUqrN1e9JiDduSv8jadyRdygVNZ7Ko
	GQlHjvDssQhFJP3jsiK3AvP5tQJrd4aMCXbWKyuD2P2YYb4c=
X-Google-Smtp-Source: AGHT+IGIxKq71r0WRuuN27uNO+LNm+gc+J/FwAAdMGJYoSQMX2/isJWZP3WNNZMOhjwCc2oEuIYTlg==
X-Received: by 2002:a17:902:f709:b0:23f:df56:c74c with SMTP id d9443c01a7336-23fdf56ca75mr72045305ad.14.1753689224929;
        Mon, 28 Jul 2025 00:53:44 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:44 -0700 (PDT)
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
Subject: [PATCH v6 3/8] mm/shmem, swap: tidy up THP swapin checks
Date: Mon, 28 Jul 2025 15:53:01 +0800
Message-ID: <20250728075306.12704-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Move all THP swapin related checks under CONFIG_TRANSPARENT_HUGEPAGE, so
they will be trimmed off by the compiler if not needed.

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
index da8edb363c75..881d440eeebb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2017,26 +2017,38 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
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
@@ -2320,9 +2332,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
-		int nr_pages = 1 << order;
-		bool fallback_order0 = false;
-
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
@@ -2330,20 +2339,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
2.50.1


