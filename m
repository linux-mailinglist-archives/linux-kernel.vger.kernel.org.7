Return-Path: <linux-kernel+bounces-851901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7CBD7907
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A551920E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FC3064BD;
	Tue, 14 Oct 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMBrqawU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E822BE037
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423235; cv=none; b=a41zpcRPWrkrW06usZMQgBmPjXfN1ePNHhjuzT5wO6FgoHJS+TJ35TYWiHxOvAakyuWUFd/j0IHNIYUKv4yu1elNPDdSm5LVJLfhcudLC/oWzcauKkUjBBFutYPtnh6Lehcb/jHvEMzdzDipGSDeOLdLAYAQKYcRqY3/ntRcUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423235; c=relaxed/simple;
	bh=PNTKEmXKtFVp+YUrykXB7+qvHmZ2GbnocnQ5aHbHOFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FncLolqeSY8rTx8rwavYAs050/cLfG6uqXXN5FwzYZG1NzCXZbiRy8HvWhEx6bc0EE91sGfAF7nITO++0VXk3Y9ogxbgEBa+fYVumzw6zJql+8XYEfGzmeai/SZakBlAApfwdW9E9HI9bHGJM3vBpBUsCdufG59xM/E7kG7QaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMBrqawU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F3AC4CEE7;
	Tue, 14 Oct 2025 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760423234;
	bh=PNTKEmXKtFVp+YUrykXB7+qvHmZ2GbnocnQ5aHbHOFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMBrqawULRzvYy0wurRKyyANwKU0YOvBSGJ2zy40SVWKz4mRmwYIRlBJ47cMDgggp
	 hwo3RASu8FI70WBUgEJ/78paOSgtC44iIGy44VWTGeXLO/bvBsHz+FIMaM/UrSZBmH
	 TcooA1nviR3eWioycxFliXC0gDmYV+aNQ0+QnWMrjzxsh7MoyEaSnSyPeOFWy4VVFD
	 4C+VTDkXfO9y6DgVxH3f15+ySCUimEJ1yW7aZLgpvRgNM0Sj5WvRvFta+z0S/FKl72
	 d31LFFIOoLNub/DMtJ9dAynQepqgskp7f5WNo4eMiPEsGrt7Z2547HPNzSfXVjbWYE
	 NJNW8RyLUgTJw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: use f2fs_filemap_get_folio() to support fault injection
Date: Tue, 14 Oct 2025 14:27:04 +0800
Message-ID: <20251014062704.1734984-4-chao@kernel.org>
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

Use f2fs_filemap_get_folio() instead of __filemap_get_folio() in:
- f2fs_find_data_folio
- f2fs_write_begin
- f2fs_read_merkle_tree_page

So that, we can trigger fault injection in those places.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c   | 4 ++--
 fs/f2fs/verity.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0279340336be..f993ffed89df 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1273,7 +1273,7 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
 
-	folio = __filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
+	folio = f2fs_filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio))
 		goto read;
 	if (folio_test_uptodate(folio))
@@ -3567,7 +3567,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = __filemap_get_folio(mapping, index,
+	folio = f2fs_filemap_get_folio(mapping, index,
 				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f0ab9a3c7a82..05b935b55216 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -263,7 +263,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
-	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	folio = f2fs_filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-- 
2.49.0


