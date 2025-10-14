Return-Path: <linux-kernel+bounces-851900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AABD78FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992981920E23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C902C3261;
	Tue, 14 Oct 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soXLsB1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AC2C15BE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423232; cv=none; b=kV4evSlnEO0Pc0LnswczGNubFmIq+DE4IYQjD6jYqGUtPZYmiCJyONpLAFRCYfWJGE6gmFdKf+1A3O7d6aqS34k5ZkBjB1UIu2ze414d/3/I2y65ZydLB/0EVZwBt4AbTCFW4ezpQyIuaDmasl+CXg/3WC+YxcwXqQCdl4IImhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423232; c=relaxed/simple;
	bh=mhmcwvYdTGSyFXiE7H2iuIIiTE95XA+Y91wY01ZQRvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o780ZnEDDIJgh2V6fGCVCaQK73VZij80Umrx2hKp2LINvwC9P6xPSMnJ7zZMjtde9dycAGvYZiSVDagqTOuhiwa8pohknkbG287EKOD+hHgI7Kq+XLxNoUy5rJM7knVBOkJ0pJQep6cNFEw7K8G+UPBENqAGCe3gpIqJyF5WFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soXLsB1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DEC4CEF9;
	Tue, 14 Oct 2025 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760423231;
	bh=mhmcwvYdTGSyFXiE7H2iuIIiTE95XA+Y91wY01ZQRvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soXLsB1tl41Hle0k9/FSjI9UiCsWF3ZNjDb9GgRidAGq/eGChNysISzzcXy3kIvvt
	 ewsAoF8UsEqlfb0Cv5bF5wRgkRJPYc+HpEbsMQIqlna8r7unae48Z5x3L4co20Zs18
	 GzJ5qAhNJNVJ8H/1jJQMpQ4MTT1oZRN4GHrULyV6XW4DHyZJPrrlP6shAWo1wwmRzM
	 S1Ge3ui8POkL0Uw1OGKXy/YMHX8WRsgl0gOIalqkFMjXYujjJDAmR0HKSQ+UYc67yR
	 cGpCf+b1YjYqxac3dIG+PRe4fWCEBvvQcQFo2nsD0qpyYa/MKE6W5YqBhpJHiLvKgL
	 XwFOgTQikNsgQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: convert add_ipu_page() to use folio
Date: Tue, 14 Oct 2025 14:27:02 +0800
Message-ID: <20251014062704.1734984-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
In-Reply-To: <20251014062704.1734984-1-chao@kernel.org>
References: <20251014062704.1734984-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 50538c26c1a1..0279340336be 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -775,7 +775,7 @@ static void del_bio_entry(struct bio_entry *be)
 }
 
 static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
-							struct page *page)
+							struct folio *folio)
 {
 	struct folio *fio_folio = fio->folio;
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -801,8 +801,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 			if (f2fs_crypt_mergeable_bio(*bio,
 					fio_folio->mapping->host,
 					fio_folio->index, fio) &&
-			    bio_add_page(*bio, page, PAGE_SIZE, 0) ==
-					PAGE_SIZE) {
+			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
 				ret = 0;
 				break;
 			}
@@ -905,7 +904,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 		add_bio_entry(fio->sbi, bio, data_folio, fio->temp);
 	} else {
-		if (add_ipu_page(fio, &bio, &data_folio->page))
+		if (add_ipu_page(fio, &bio, data_folio))
 			goto alloc_new;
 	}
 
-- 
2.49.0


