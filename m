Return-Path: <linux-kernel+bounces-755980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDCB1AE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2648D18A1A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63622DA1C;
	Tue,  5 Aug 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1q+hd5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA521FF2D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375359; cv=none; b=TlF68uMKhZ4hvXz4YhsSEZLo+S4Xb9ToY/pgnW732JiGroyxa0pZzvjM0BunXBoCHuZfNThuWTgsFwtqDVd+G+m81ZbMcBtq+LnIqqo2+nnIX0u5zOBZ+GaSqwjvn9qa7kmYB4fYaIJpUC+RrW/yaRCVK7fg0D8ccouy39fPlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375359; c=relaxed/simple;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5NMAVhKLqH394v5nzDc7Lub3eik+k4YaL4aXLA194VqNw5SOQl8A3FlozPYhm0hES6oxEaCZLIjP1vuqDYEAWj2znRy2xvPMBkH96F2vUg5TworRZVntUj5FpTYop3NuvLtpSy7LC9JnwCjJidX/6EPMkKyrjwuz/gxTvE2Ev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1q+hd5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467CC4CEF4;
	Tue,  5 Aug 2025 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375359;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:From;
	b=J1q+hd5+nkJMEGBGayUV29fS5leHdv+JzlcpcCxaNGvsAXpafOfbwXblVvjrJb93o
	 HACOvTrrKJ5DVTLDCp2f8+uA+YJsqKLJYx3/3+z6jcyL2fJ2Wd4D3AqclkK+twBx9F
	 3860CebAMKDo2epd5KARPSLDrC232RywcsgfiBs0G5GWlywawQW5yoY5Y2ZHMy1qZf
	 hvxBuCv7Zlxa6s7/cH2nikqDFf9mgA8mHSQhA/pmvB5BvZDV82lED0pR9XZ1mzAgwL
	 /LUFspRUk6Sd/7OVfHx2HoQkdhyTTbMEqoI5XORrF1cwuO3wAmAWdHsb9FJr5kAMf5
	 oPE/SRq/47PCQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/3] f2fs: fix to avoid overflow while left shift operation
Date: Tue,  5 Aug 2025 14:29:10 +0800
Message-ID: <20250805062912.3070949-1-chao@kernel.org>
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


