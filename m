Return-Path: <linux-kernel+bounces-754602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABEB199F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8192C3B7A78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22951F4634;
	Mon,  4 Aug 2025 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTSx3zh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D789199252
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271830; cv=none; b=IIRXhRSRZVpM3CYtsecD/pRRqSBrnAg5tLUCgq7Tz2Dh688F1egAXTzWYIni26vg4iSzyarbAjXwz0sbjlgHJPGQQKuxUdW4f3OMDI28kl16njF7QZ2eiOzM3/7jJ/n73UFV9tUZ5GwzUbv8746k5fezFhtOwa2m6Avn/T1owH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271830; c=relaxed/simple;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OavN5nuVIqigoy95aYe7bEs2UzihLsVyGPVNJKck4zDCgzqyeeNpFuy7MedZSEryXGzdSPl8bBfpp8tWyNLXKbMHzlvCJwOo7V25ZCTFdrx9PQfQ7ZajNreugxGR17b3X3e0nFQtV0CZvsVfAiujudC7DiZS0YIgyoJ+nxWKg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTSx3zh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF72C4CEF8;
	Mon,  4 Aug 2025 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754271829;
	bh=nibfP85OrtQzeUHNPYnVq5ZQtUssf0yOK2wCjiWDsmE=;
	h=From:To:Cc:Subject:Date:From;
	b=iTSx3zh+gqf/MThibBenMuDDY61d02mzxXv15NFvfCjb41Dy525Sanmacot6ViukC
	 H7YeVoPFALoZ49tP9dLou0gI8k+L9L9E9jAJY+X7NAYCL48NEjw3x/iuDLR0sERqmS
	 ue6IMYDGhwLl0y8oIysX6MTKiCZihRRDrKXB9VwjN0sVFPdX/GanoMJV+6eJTms+YQ
	 ZOH2aQxso4VEU3NhRqtIATB+uhpfVAfzsRPBG9y1T0CC38pfNZ7fAyCnDucur8TwQ0
	 uCka/5mbpAS0qp5Ay8FplWM2mPz+seqAtfgACW1Seb3Odhqti4+/26PELhWt7+j8If
	 04Dis7gDocDxA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/3] f2fs: fix to avoid overflow while left shift operation
Date: Mon,  4 Aug 2025 09:43:37 +0800
Message-ID: <20250804014340.2537172-1-chao@kernel.org>
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


