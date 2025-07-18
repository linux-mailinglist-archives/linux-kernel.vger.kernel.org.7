Return-Path: <linux-kernel+bounces-736673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD0B0A052
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC301C242C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C329B8E8;
	Fri, 18 Jul 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="HrCoUWr5"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202931E51F1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833234; cv=none; b=OWcZkgmGJ+Shf6dD/zyejoZ9PaX8gsHj5AKfI2JeViF81mDvCWBq5sKjnU8NSyPIFsigWgz0HhpAWyBOhZ+g4KBvXAOP8c1zw8IBclRtPPYWVrvwbq+YoqNi8Q5o1qfkcZdLMQEl1u64ttzzWAALAyvrkhsfGxU/IAmO0reVOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833234; c=relaxed/simple;
	bh=8E/Ax9Oc8GZJLGxHCmcrammpqq0eH9RKNLQHpaxousY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M5vFo/UYez7BhPsfyuYUnNWkVMaT7hW2vdZ/en6D21BzFxsXUgHtvqnb3iTk4urJ113P5GTBVKFRsM70VzFVZCQbkMR3oeLcg5qmxPCQIdnzZkGTIp54699COPa0kRlfd0Osay9SZIPgvo6JQL1NQIxUOIwsnMnsNhUAl5pcwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=HrCoUWr5; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=1dPaDRa5/OXdXWsPu12v6bsOVEqtCXo6RTkpdY2H+0Y=;
	b=HrCoUWr5JUsa1cB4eMqvHomOn4lNW3NvVE2Ixvxgb5UX8MBzI5tIWFDeHFFhYbUoqHcwr7zXF
	IDYCCziFGt06U8G8IKEdC/bAJtX764gXGLy1dcInAuw5HfppP6d16+PZDb0v4nq8fLTbd5BA8dz
	t0fYntOkaNPJH5gL9IyKKMg=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bk54l5HbBzYl4K7;
	Fri, 18 Jul 2025 18:04:55 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 18:07:09 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 18:07:09 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: avoid redundant clean nat entry move in lru list
Date: Fri, 18 Jul 2025 18:07:05 +0800
Message-ID: <20250718100706.3948806-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

__lookup_nat_cache follows LRU manner to move clean nat entry, when nat
entries are going to be dirty, no need to move them to tail of lru list.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4b3d9070e..b9fbc6bf7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -460,7 +460,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
 
 	f2fs_down_write(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, ni->nid);
+	e = radix_tree_lookup(&nm_i->nat_root, ni->nid);
 	if (!e) {
 		e = __init_nat_entry(nm_i, new, NULL, true);
 		copy_node_info(&e->ni, ni);
@@ -2926,7 +2926,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 
 		raw_ne = nat_in_journal(journal, i);
 
-		ne = __lookup_nat_cache(nm_i, nid);
+		ne = radix_tree_lookup(&nm_i->nat_root, nid);
 		if (!ne) {
 			ne = __alloc_nat_entry(sbi, nid, true);
 			__init_nat_entry(nm_i, ne, &raw_ne, true);
-- 
2.25.1


