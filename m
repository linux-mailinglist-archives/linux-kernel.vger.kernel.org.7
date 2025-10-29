Return-Path: <linux-kernel+bounces-875235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B3C187AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9645B1899876
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588E28727B;
	Wed, 29 Oct 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bti381xv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609928688E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719476; cv=none; b=hRwyefZopJN5k6S3Xo/pXeaFxQ4oM0k8d7KU+2XW9Kv/ePUYYJTp7l6hBUoJXEm8WTkshzY17Enw/o5aERNBCdVF9KsdcrHv7I5EbA5uCDZ6Tu8bxLloE7d0K6Mx4dWFxbYcXHjrz8/gSEzhqAe+Gu8CalqvTM+6aUR/l6f9G1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719476; c=relaxed/simple;
	bh=M8TOhzUcxJ8U/jWJFpN3QlqV3yVKYE0f7t0KLLwk1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCDxnFZCDse1IbaruuLICEL5H2cwRka7p0ibRWT5sNoCfgfEqsyZs5OFz0jsJuobTOZu6eOAFP1OSBFmr5CJEgccvB1awy5epclBrejAS/2WmnG2Il5h+ZWIcbwACTZG4X733YUOtmKa05qD8WUZlkZFxjZYmGFPFSopDTKr8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bti381xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C621C4CEF7;
	Wed, 29 Oct 2025 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761719475;
	bh=M8TOhzUcxJ8U/jWJFpN3QlqV3yVKYE0f7t0KLLwk1zg=;
	h=From:To:Cc:Subject:Date:From;
	b=Bti381xv/4CdZbWJhBCghbmdX8DNtsZ2wJ/tic0mR616x3LVPW0gd1uIRjruXeLjw
	 YoKGhuJW0MfvH+ffUUvUTebNhwKuArFNreFi3fNFSKLZw+cu07bpPc8A+lxsX8tzIa
	 dBenIc2el8p7czAzc0YFdj/toVNMSAmjNsdcyck++eqEDLKPFd0DBgaBqZrj/aM2Dd
	 EKkyWG5D8SXAw23/zBR/LfLmCBUwTUdIgoyicqHg+4Nsuepgjcf31uQLdlWdVX4iS9
	 8s4VPMMUZqAzd8/djEW1FsYrUFS7kbddGV+J/x54Ay2yFSD1vclqKr9F3lAhpMD15z
	 j4p5atzaDXtdA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to access i_size w/ i_size_read()
Date: Wed, 29 Oct 2025 14:31:04 +0800
Message-ID: <20251029063105.989253-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It recommends to use i_size_{read,write}() to access and update i_size,
otherwise, we may get wrong tearing value due to high 32-bits value
and low 32-bits value of i_size field are not updated atomically in
32-bits archicture machine.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 include/trace/events/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index edbbd869078f..e1fae78d64a5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -204,7 +204,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 		__entry->pino	= F2FS_I(inode)->i_pino;
 		__entry->mode	= inode->i_mode;
 		__entry->nlink	= inode->i_nlink;
-		__entry->size	= inode->i_size;
+		__entry->size	= i_size_read(inode);
 		__entry->blocks	= inode->i_blocks;
 		__entry->advise	= F2FS_I(inode)->i_advise;
 	),
@@ -353,7 +353,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 	TP_fast_assign(
 		__entry->dev	= dir->i_sb->s_dev;
 		__entry->ino	= dir->i_ino;
-		__entry->size	= dir->i_size;
+		__entry->size	= i_size_read(dir);
 		__entry->blocks	= dir->i_blocks;
 		__assign_str(name);
 	),
@@ -433,7 +433,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->size	= inode->i_size;
+		__entry->size	= i_size_read(inode);
 		__entry->blocks	= inode->i_blocks;
 		__entry->from	= from;
 	),
@@ -1006,7 +1006,7 @@ TRACE_EVENT(f2fs_fallocate,
 		__entry->mode	= mode;
 		__entry->offset	= offset;
 		__entry->len	= len;
-		__entry->size	= inode->i_size;
+		__entry->size	= i_size_read(inode);
 		__entry->blocks = inode->i_blocks;
 		__entry->ret	= ret;
 	),
-- 
2.49.0


