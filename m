Return-Path: <linux-kernel+bounces-819891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A704EB7CA10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC071786E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812C2F3C2A;
	Wed, 17 Sep 2025 02:36:35 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E6101F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076595; cv=none; b=TyyuMrvtCWz3oHMmxc5dsoPYrtA+GgzP/C9T3qTmA51XjNkCPZeUliLScz5lQwmBZXb+dyvJISHoStee+cKQ989Ty+HqtvboQ4bZO/xNp8MjzGfyOs8+AT2dAjDlOLKR7tbA1KdIVDqh5+J6jGa9YQjdyZl5g+zxXCH7OJLXeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076595; c=relaxed/simple;
	bh=SmmhcPPu8rUjh9oP/7HG3yfQq7opmUncZheBEIXBnWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR7X8o1AcYdujIu770Web5ouatmnrTBZVaYR6Olt9nfcP1pf9TjMca+zJ+qW9ATiAPmp/T1+0HI2nMx2Jd8AX6EvDLSlluD8pUMaKgKnuSK/dZcioVpUdCr9bfo9n1jFvSIV9ZsOnzNEfPQPamayQuhJFQ7JglK2F2eQyPAdQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cRNDV0vvBzYl0F7;
	Wed, 17 Sep 2025 10:35:54 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:25 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:25 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Wed, 17 Sep 2025 10:36:22 +0800
Message-ID: <20250917023622.516052-2-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250917023622.516052-1-wangzijie1@honor.com>
References: <20250917023622.516052-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)

When we get wrong extent info data, and look up extent_node in rb tree,
it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
return NULL and print some kernel messages in that case.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
v3:
- followed by Jaegeuk's suggestion to print some kernel messages 
---
 fs/f2fs/extent_cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 199c1e7a8..ba0a07bfd 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -604,7 +604,13 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 			p = &(*p)->rb_right;
 			leftmost = false;
 		} else {
+			f2fs_err_ratelimited(sbi, "%s: corrupted extent, type: %d, "
+				"extent node in rb tree [%u, %u, %u], age [%llu, %llu], "
+				"extent node to insert [%u, %u, %u], age [%llu, %llu]",
+				__func__, et->type, en->ei.fofs, en->ei.blk, en->ei.len, en->ei.age,
+				en->ei.last_blocks, ei->fofs, ei->blk, ei->len, ei->age, ei->last_blocks);
 			f2fs_bug_on(sbi, 1);
+			return NULL;
 		}
 	}
 
-- 
2.25.1


