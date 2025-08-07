Return-Path: <linux-kernel+bounces-758819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345CB1D433
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF887A1E84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278123BCF8;
	Thu,  7 Aug 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MvmPxBJp"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BF1B7F4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554838; cv=none; b=A9HszJTGx7RNVDfM5O9B28Ps4COCle6hgmYKYL5JAoGU7fAiPRkTpkAQP0swY5i5CLerUSTIrRcGme4Y/dXAwk2gU1lzcwxuHgBxrNMxYoju92WsYBsdY4Kf7LkyFMPwQ6yRpMxFTjPliKn4/cB4tHPmCq5USVy4cI1RPEQeofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554838; c=relaxed/simple;
	bh=8TsFeLroL/nFwIvnusUWizTayG9cr7P+WI8JLLOd/jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPTE6ME0VDwPh1j8bpoIcriCuabgCtI0abS3sLDH2nB7CD7rqTCZhqS1NApunb+l7pzi1/rp0/58zgTu/bit7N1s61hx9FATeuFf3cR+53jk28uc934JN9k1G9kEiba+UmEew41f6nJIndDo63N0DzYiAqrsTViAIwsLFHwRVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MvmPxBJp; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754554826; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Slt0hp4ov7NR2wbSxNCQhhukVQ0RwOD/sGT8MUG2I6Y=;
	b=MvmPxBJpYq7fXwT0tjKGt6/FdDFIQNNuVqH0Ap5yu8rGsezDxvu1obHfRmhs+FT4HKPvIeGHW4Z5Z1hPoXM4Zk4+0ZcvO02QuMSCKpMcr42oiqHcBjaWLQB3ps9rCLUW6lCMAUu/p1xjEs9YaZHD7HD04Et6nTQBEUOY64QfryY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlDe27._1754554820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 16:20:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix block count report when 48-bit layout is on
Date: Thu,  7 Aug 2025 16:20:19 +0800
Message-ID: <20250807082019.3093539-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect shift order when combining the 48-bit block count.

Fixes: 2e1473d5195f ("erofs: implement 48-bit block addressing for unencoded inodes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e1020aa60771..4ca7ab4e1e82 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -313,8 +313,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
 		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
-		sbi->dif0.blocks = (sbi->dif0.blocks << 32) |
-				le16_to_cpu(dsb->rb.blocks_hi);
+		sbi->dif0.blocks = sbi->dif0.blocks |
+				((u64)le16_to_cpu(dsb->rb.blocks_hi) << 32);
 	} else {
 		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	}
-- 
2.43.5


