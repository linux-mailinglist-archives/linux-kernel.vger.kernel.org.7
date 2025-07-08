Return-Path: <linux-kernel+bounces-721458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DADAFC97A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6149D5644AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1D2D9796;
	Tue,  8 Jul 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukEs4Pud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0F2D94BE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973591; cv=none; b=rCosCeTMsllfy6/Vq0V++unV/1HZGYevziI9BU3h/ueJ2RQ0+x/5kEKpK/Dd/mWMEGwygy5uuKkx8kKJ5JJG0ETKFWeP5RmYlwAHWe4rL7EMgZstE5td6On18u812RvdIF/VmxaadMcDqNltqO5kUwczLXx0WWF3Cdr/qM305kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973591; c=relaxed/simple;
	bh=1ZpiPWuba+MuyFl8CusarEXRp/3PVfOFUf7cDpRirOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+Zrqwg4YeBdPUNAp6a9Utd/UKlAWjJxeKAx37ponuyONhwLzc1WY72RCI2z320v3tQELOwkcAn7WlrY9Z9Wg0ukubu5CCQEPHp0CayaNYBl+TELeVURyCmp2xU0i5GgANVkMtKqOL/x7xJG+9Lo6VG9fQ0pZ7KC9e4rqFswP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukEs4Pud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C9C4CEED;
	Tue,  8 Jul 2025 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751973590;
	bh=1ZpiPWuba+MuyFl8CusarEXRp/3PVfOFUf7cDpRirOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ukEs4PudvgW5/lSg561WtTW6pCAAS5xR5dyaceX0xHeRk5D28hJIljeDnYYby8M7k
	 z2WA7t2OfhkGuFok1aCEbvIbNsIayMurgiYjbK0E8JpQKU4tTqYZWfTutaYYvzl9LS
	 W8sAbArHYapVzg2cBucjAQ7AesyIUEof2mdDj6N8F6oL6BZlJ075KGLr7Pb4QmHVja
	 PYmxnGTdCiR+f4+jBUUTK5CPyNUDV+mAGEumafHcRt8LOHM0aU5LNFGotvO+iAJore
	 AmE16a8FuhcpNq4qmQp+w8tn8IQi8lPZLMMROlAua39wCfvKujgPb853xyIuYjQpQv
	 AU4SlYpgXIIkg==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix to add missing tracepoint in erofs_read_folio()
Date: Tue,  8 Jul 2025 19:19:42 +0800
Message-ID: <20250708111942.3120926-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
converts to use iomap interface, it removed trace_erofs_readpage()
tracepoint in the meantime, let's add it back.

Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 534ac359976e..221e0ff1ed0d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -351,6 +351,8 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	trace_erofs_read_folio(folio, true);
+
 	return iomap_read_folio(folio, &erofs_iomap_ops);
 }
 
-- 
2.49.0


