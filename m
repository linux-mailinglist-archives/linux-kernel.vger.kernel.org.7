Return-Path: <linux-kernel+bounces-753939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D0B18A64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414AD1C27758
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977A7260D;
	Sat,  2 Aug 2025 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWU7vWbi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DED139E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101119; cv=none; b=QBzD7j2sHeV9+sx56T42WaMx2sxKfBQnDKmTMIk0PRK8BLgPu3YYIb5n4qcxwG4p+impfxFDpdArTvg42YQ0hI0OYOjhRsQoCbJgt6qM2jFOtTyn4WRRt07nf5/Swc0Xhnw7ooZWMy6+PTVS9H80h8SRc833Lp3HgA/AE52POBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101119; c=relaxed/simple;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtkDuw5G6CYdM271wjxUMHrwUilsdPeYsPR5BA/MK2OXjtXdFSVse81gJZU3sqUj9uiYY4TRAA6MKCKxhjJ6ItNvAGp13clf8aKKOasht0dOf3QiMjhEtlL7LmtJES4oS5GN0K6YSnKUBp3Qu+RizNVoxRPdr6QuEILE9kzTCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWU7vWbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E1C4CEE7;
	Sat,  2 Aug 2025 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754101118;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:From;
	b=bWU7vWbimIMVndFC530TTgufAznJTWo+RTd6VsHaXB5mUuDa8fFH9Ozg14b9l9QMk
	 bOOldw1HYVehhVtm/iyEOQJt+AqgfhtnaGgq9TCWe7uOdjF+3bpDp4O49jviccgUQ0
	 vj0O6h4+iy5i2f5IgHGuu+aWOuTWhWxgj2Kt2jGWkB0AVL5Bq2CZsEDmIq3Ex+hjBo
	 IdzqXTll8CW+WEXjkcNOwbch3Ko1YT2oLlVa2UD9fuSOtsddEtFAKeNNuMXiLmQScu
	 yekkwBLGksZJCuTAwoMSUJJ+MzB+WOIHsU3HjSLyziRrCnbLGTuorlfL+lf4HAlI5Z
	 tGxTEKGLZ3gZg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: fix to avoid overflow while left shift operation
Date: Sat,  2 Aug 2025 10:18:30 +0800
Message-ID: <20250802021832.1882302-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should cast type of folio->index from pgoff_t to loff_t to avoid overflow
while left shift operation.

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5c1f47e45dab..6cd8902849cf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1245,7 +1245,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 
 		for (i = cluster_size - 1; i >= 0; i--) {
 			struct folio *folio = page_folio(rpages[i]);
-			loff_t start = folio->index << PAGE_SHIFT;
+			loff_t start = (loff_t)folio->index << PAGE_SHIFT;
 
 			if (from <= start) {
 				folio_zero_segment(folio, 0, folio_size(folio));
-- 
2.49.0


