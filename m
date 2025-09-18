Return-Path: <linux-kernel+bounces-816068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F259DB56F05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A61899747
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462225F96B;
	Mon, 15 Sep 2025 03:53:04 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84F86344
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908383; cv=none; b=BHwbsih0fQFcRwuhvdPPBuwno9TqyFQFENqR9YKi1gL1/bffuUC56LO9Q7zuK+tuOYLBvftDVxnuaRaLkFvV+XzZ5gcfh3p5YnSLM1DAJtfUSh4YK1Nn/wkLNisTmhZOygdm82Xejx9aI7eXFTRBsHba0txkzC7zYvVoHLbqUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908383; c=relaxed/simple;
	bh=bYpcEkME0oYi9OeSyzVA4vVI4CAbs36pc4dREOnrn3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=astg15PM9dObRFrkSIiL7RryWprU+FYlV6IqBt67E/lRZ1yPBKDLu5afWPcrpyGLaScPa21eZrKQ9q043X64s7Asa/xwkVLCQg4yNCmLHq36ChvMqQwd0HbG6pyILvZsJoFS9asbSZBEE0ROotMrpXagCGzDmmxy/sGpoecLGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cQB1h0NxbzYl56X;
	Mon, 15 Sep 2025 11:52:24 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Sep
 2025 11:52:53 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Sep
 2025 11:52:52 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Mon, 15 Sep 2025 11:52:46 +0800
Message-ID: <20250915035246.98055-2-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915035246.98055-1-wangzijie1@honor.com>
References: <20250915035246.98055-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

When we get wrong extent info data, and look up extent_node in rb tree,
it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
return NULL.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/f2fs/extent_cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 199c1e7a8..6ed6f3d1d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 			leftmost = false;
 		} else {
 			f2fs_bug_on(sbi, 1);
+			return NULL;
 		}
 	}
 
-- 
2.25.1


