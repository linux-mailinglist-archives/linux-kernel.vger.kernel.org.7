Return-Path: <linux-kernel+bounces-770868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682FDB27FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF93118940E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01123002C3;
	Fri, 15 Aug 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc9oz8D9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71131684B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259981; cv=none; b=JG1j8fTDyyelDBnnxoFKBukvvvXpHlKUIA/QVZV/olkG+WO9y9RRACK6PGR3/tayki9dcdI92W3thl0qba5Ry2qXe8UmiEtO9uU2JtdfeD6mQQuYX1Bk1kKvY2McpwXmWz9tSCWjR7lIEU00SVoWxSjUgLSJZE2DdpV9MdtCW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259981; c=relaxed/simple;
	bh=lAZrZ10vUj5/vYVcA/v0I6AyMKFBMkW98ptVorYqJjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4J+VH5oCk4YSSgETb9oG1M0TFrM6mdxr4qtgagdUrJGIWAOaHPT8V9uVVJUGsXRf58IwumBfO2s53iq2t1JFS92XDXURrb7kU0mRBDPNTiWeVxM5iVD2MH5TpnFMK1lQ82p6ZLA3k3JQaLTcEXFLaR9Bhb2vfPHEZ8pMVtYx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc9oz8D9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f5b692so22774775ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755259979; x=1755864779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr2T/PlowsNaBGSDWx2tOzD0LdjEtAvHJO/VwvUy1TQ=;
        b=mc9oz8D9rWdlnXhRovVUEUQItKhfDXtH40j+1EpmgMUUO4Sf+I+osQP248suXDooE5
         ePodftIUXK3KwITyHj4AmHmzwCAJyeS8aCDHNOuiETFr1p1iH6RNvPFJ+23eYZ11hpXP
         R9fjv/BTkX0kOs83C91U5Ech9X/Nt6W9XBlmZLJFXewPzWRJrOmTNLonuOE9oTbIggQk
         gPf329fRAwxjYz2XQMFAlaAdOClEUY2wUY91LmqtFCk/UK3m+pxp/OOQEU431GPSiZfB
         ghttOhkwjGA38nlaE/GMFXjbo2MHSXUmGxm5jnyziCV5puZUc8ZUIGLQGe9kJzAchew2
         iHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259979; x=1755864779;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr2T/PlowsNaBGSDWx2tOzD0LdjEtAvHJO/VwvUy1TQ=;
        b=kfzAf16xwRI+V9/ctybxGPDiGD4xnN5x8XsKoeMOV8TUHblFjSfnf9OhD02SNYHRxU
         rRQg2cgdYICKLe9NFwNtc+Uizbvks0puV4H+YTL+dfoFXeVHwhiwIIRHcGjVClo+8WYA
         WhOCcQXeAd3qiX/fMM6QdvhWcYDoJbebFLSlhRahNzt5D/IVaXKfy0dWjBTL3O/OOPUi
         YLO0WybZGW3EoGv8CxM3H6+1OBOX77ztdBGojJdBYfBWxJrHfrawMaQNS85LPH29eZ9G
         PRGKq5mdFvK1xOBkhhxE+ZtsDcZS/VDHIiRlgh8oh7NJnK4zexscUXy69VYXbsno3R5g
         hQdw==
X-Forwarded-Encrypted: i=1; AJvYcCV798a+NJ2W5lTg+RQnBkZGr61truf5lyGlacEpa9YqLhTHyxuXhjO3jqwHKFLQLv645QlVQE/FXRZX/tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTsKynKTeWb7BWh3zO/Htk7WSyWRA4O3yJYToAF1XxAKjkToW
	kkyyXpmPsYUOS8gB2Ctxwdk5TrH7EBsEBwynV2Sq4ILJTVE5mvjhsGmdlwwH+2tEA1g=
X-Gm-Gg: ASbGncv/VwDPkTM1WytsJaXdi5B+53DSkUAMmepwJtBqc8Wd8lSTdRVLTDASNVezxS5
	8YLMoJnn5wWeF05u+5eay8vVGMZZh+/5HyZYO/JAbSQL7D0t7A776uWkZck3x6CUHg/0Y8sUwBQ
	Nn0qc5eD3+SzPeFlf1LXX0LkHCiqi5F7DT+2SkXQuYHLfbECKkMwUCmVPvVqAv1Tnlx2/4DRoPx
	uuF/plOEvtRBuNO/VDMJADACkSGOiJnGnKcSlXaSbi5mHf3lavqeAMcWwHtyMv+ubSEoHJDbASh
	i3cLuCCS4n/THMtuyHY74HarlCPYXzEdhP9lVMTrRo0+F/VZ+xiaMHYgS8SPAFCd1DQDqRa5cMJ
	jE7rIzcKCBA/46k7D+wrZrm/AUeEgEBIP7UPJvTwcbF0=
X-Google-Smtp-Source: AGHT+IFjTqLHBoX4djgJecMaacmADP/j4ypwrNwz8xnCbsplMONYA7NKn4JfOt92v+1JWrG/JCU98A==
X-Received: by 2002:a17:902:ced2:b0:242:cf0b:66cd with SMTP id d9443c01a7336-2446d8f0a20mr30878675ad.34.1755259979059;
        Fri, 15 Aug 2025 05:12:59 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5769a9sm12765655ad.151.2025.08.15.05.12.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 05:12:58 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/page-writeback: drop usage of folio_index
Date: Fri, 15 Aug 2025 20:12:52 +0800
Message-ID: <20250815121252.41315-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap cache.
The remaining three caller in page-writeback are for page cache tag
marking. Swap cache space doesn't use tag (explicitly sets
mapping_set_no_writeback_tags), so use folio->index here directly.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/page-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..30c06889425f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2739,8 +2739,8 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 	if (folio->mapping) {	/* Race with truncate? */
 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
 		folio_account_dirtied(folio, mapping);
-		__xa_set_mark(&mapping->i_pages, folio_index(folio),
-				PAGECACHE_TAG_DIRTY);
+		__xa_set_mark(&mapping->i_pages, folio->index,
+			      PAGECACHE_TAG_DIRTY);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
@@ -3019,7 +3019,7 @@ bool __folio_end_writeback(struct folio *folio)
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
-		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
+		__xa_clear_mark(&mapping->i_pages, folio->index,
 					PAGECACHE_TAG_WRITEBACK);
 		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 			struct bdi_writeback *wb = inode_to_wb(inode);
@@ -3056,7 +3056,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
-		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+		XA_STATE(xas, &mapping->i_pages, folio->index);
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
-- 
2.50.1


