Return-Path: <linux-kernel+bounces-851898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB5BD78F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 916014E5AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BB2BFC8F;
	Tue, 14 Oct 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPAacUhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D429E110
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423230; cv=none; b=s+jGhQ+8bbshl+dW6SASOfJ1VgUTNZAkhk0UwxdnBvl/9Tb2ZkqUQeNWe3WsrImRs+ywG/2LlJvE5Wssf7btLtifZXyWMCX1Sf+gzC8NkK4WGjcJ6Crh9d73BFyPJzchyYmfnSAwX3a4ys1WgDd93EZ+VY9ak9pcBJZMPFUCq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423230; c=relaxed/simple;
	bh=5l9A5JJC7HoCgkgNBAkY442qtM7rkd2EIFEaDAIJIMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axeo1FDV7Tg0bQW4o4eFj7aZ9d7pd5UYxFCzggNEaqLHyOojdEdoMxrM9rgybDDivWx9XEiVxdE0LTVXilmhiA8xxE8ljaFIZ4akuE9fQuvySxBFIrUVeStG97rN+QtjesQ7ZKTv/AgCZ+nD/PkSoet0qJAnWuQ89o78XQUplpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPAacUhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05F6C4CEE7;
	Tue, 14 Oct 2025 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760423229;
	bh=5l9A5JJC7HoCgkgNBAkY442qtM7rkd2EIFEaDAIJIMU=;
	h=From:To:Cc:Subject:Date:From;
	b=NPAacUhItq15Y9mwO0PO0P//CUmzJy6k1IhnUl5PjpBvJ8Rb2eiuMo99KULXjHr7m
	 dmdH8LdDwV0m/q15FLtUZ6hwFPIaPOYcpNBKHNZ5MPVY7oYSV/sEk0i83/L3oDB5z5
	 lBalEoK1fTWkzJ7Vl2zQy0TKtPJWzPSYNal8eRvT8NI8RHJOrWuu+EFKatSim34P4b
	 DxKFSaE+QDtyAfjQUXR7u5cd9dkNpdfR6CgrefVF3njgeWgleUTWGBdCE5ODQ+G97O
	 ct85EqRY69qJaLBZUs02BcKTXOE8VFyHrr1/oaJufFnN5K7d1mvmkQl0d9WbcnqX3w
	 laNZniYJxihxg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: clean up w/ bio_add_folio_nofail()
Date: Tue, 14 Oct 2025 14:27:01 +0800
Message-ID: <20251014062704.1734984-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In add_bio_entry(), adding a page to newly allocated bio should never fail,
let's use bio_add_folio_nofail() instead of bio_add_page() & unnecessary
error handling for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..50538c26c1a1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -752,7 +752,7 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 }
 
 static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
-				struct page *page, enum temp_type temp)
+				struct folio *folio, enum temp_type temp)
 {
 	struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 	struct bio_entry *be;
@@ -761,8 +761,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	be->bio = bio;
 	bio_get(bio);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
-		f2fs_bug_on(sbi, 1);
+	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
@@ -904,7 +903,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
 				folio->index, fio, GFP_NOIO);
 
-		add_bio_entry(fio->sbi, bio, &data_folio->page, fio->temp);
+		add_bio_entry(fio->sbi, bio, data_folio, fio->temp);
 	} else {
 		if (add_ipu_page(fio, &bio, &data_folio->page))
 			goto alloc_new;
-- 
2.49.0


