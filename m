Return-Path: <linux-kernel+bounces-765861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD114B23F28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7817A744B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA32C3252;
	Wed, 13 Aug 2025 03:52:44 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961F2BEFF6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057164; cv=none; b=qMgyzmU4PmSu+gPx3u2lNxg38/jniOuCPHfS8MMWzz3ksOhWm/tXLGAHHd1qABbRK6QwxXcfHrnfHYgB5V0k7QZlkUMIomJr+qM8jbb4OEIsLTjlrN0cN4a2hpuFJnbaRymGazKJUN96jAalGbQ8zAnmGViQ9Q8vW9+lxRnrLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057164; c=relaxed/simple;
	bh=10qd6fSly3ctGc4adVw8duzY13qi9J1PB82YZSHdMOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD4u65osygW8WQpveB1OmzjrPK0WLefQ+Dnv6mY7DV6ZqGeo8lt03OyFjkDU25oJPNyElMR6oknf8W921mPiN99NsWW0s23VFuheqapWk1c9qscidFoveE0KDBqHEYTA7++09cLls4Twmxyezah2lZUcrKoC8ek2q81oQI4XnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c1vVD3dxvz2Cg76;
	Wed, 13 Aug 2025 11:48:20 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 07C2F140109;
	Wed, 13 Aug 2025 11:52:40 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:39 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 14/16] mm/damon/core: convert sz to byte units when updating state
Date: Wed, 13 Aug 2025 13:07:04 +0800
Message-ID: <20250813050706.1564229-15-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: <20250813050706.1564229-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

After introducing ctx->addr_unit, the unit of sz might not
be in bytes. However, sz_applied is returned in bytes after
processing by paddr. To maintain external consistency, sz
is converted to byte units when updating the state.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b162aa1156fc..bc764f9dc5c5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1889,7 +1889,9 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		r->age = 0;
 
 update_stat:
-	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
+	damos_update_stat(s,
+			sz * (c->ops.id == DAMON_OPS_PADDR ? c->addr_unit : 1),
+			sz_applied, sz_ops_filter_passed);
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
-- 
2.34.1


