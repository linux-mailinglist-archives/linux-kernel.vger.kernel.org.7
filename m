Return-Path: <linux-kernel+bounces-895387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B622AC4D9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7821891259
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF635771E;
	Tue, 11 Nov 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y+W9Co0N"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D0268C40
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863487; cv=none; b=DR4tkBAnA685fb2KIAy0COcnrVj/YQUSKkElsxAOjcW8kcITb7MBeevWHYlULgOqktW/IsShmKJvRkKF2sz50TkYpD33wxJcD4nkTJt6CZoKIwQzsSb0yRwz8Ewy+lQ+P8tgHNyWK1wwK/BjABScUusxbpGpTHjRUkqi9/uxp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863487; c=relaxed/simple;
	bh=UAhRmV15QunRhpM2A5V5RndXcaXJhWMMQ5ffJNFXUYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+RSTaUoOiav577yfUgy8XQuq6Jmasu10o+LskKrPQABbTDzieT6C+8zxA7L3544B0LanhHWo0LvYcGF3AA9NV9ulIfx0JACTBkaAMawbLO351EGIjvucmS8SQ1xdcqsmT9tzseIrFD+P+NEMagP/jfGURIEq5fp9RJX0OwTg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y+W9Co0N; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gf
	ANCpYyQtu2FJq3xTseeaI1UO6gnRjQwEJ6h27gj5c=; b=Y+W9Co0N1od1BE3IoA
	b0g2sOOT20rNm3KOj3xlnP9vsv7uiu+3Gt5SQqYjl3OaStwUy2/n4cWC61wLKdkk
	BkjdefiKRM/BKQ9mSgtZpMomAn6/dDqzfdHckrzjKR1aHkLM0QbGcM5/z+hpvnps
	wDPCrm80jlGlLZCixSkrSc0e8=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3P4RcKRNpN6BPDg--.37327S2;
	Tue, 11 Nov 2025 20:17:33 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] f2fs: simplify list initialization in f2fs_recover_fsync_data()
Date: Tue, 11 Nov 2025 20:17:28 +0800
Message-Id: <20251111121728.29433-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3P4RcKRNpN6BPDg--.37327S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF45KFWUJF1kXF4Uuw4UArb_yoW8Gr1Upr
	98JF4kKr4UCr18WFWktF45CrZ5ta4UZ3sFy39akan3G3ZxtrsYgF93tFyUXF15J348u3ZF
	qF4vkF15ZF17Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpUDAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwR2AS2kTKV0JIAAA3w

From: Baolin Liu <liubaolin@kylinos.cn>

In f2fs_recover_fsync_data(),use LIST_HEAD() to declare and
initialize the list_head in one step instead of using
INIT_LIST_HEAD() separately.

No functional change.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/f2fs/recovery.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 215e442db72c..3d85d15a4f8b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -869,8 +869,9 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 
 int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 {
-	struct list_head inode_list, tmp_inode_list;
-	struct list_head dir_list;
+	LIST_HEAD(inode_list);
+	LIST_HEAD(tmp_inode_list);
+	LIST_HEAD(dir_list);
 	int err;
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
@@ -882,10 +883,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "recover fsync data on readonly fs");
 
-	INIT_LIST_HEAD(&inode_list);
-	INIT_LIST_HEAD(&tmp_inode_list);
-	INIT_LIST_HEAD(&dir_list);
-
 	/* prevent checkpoint */
 	f2fs_down_write(&sbi->cp_global_sem);
 
-- 
2.39.2


