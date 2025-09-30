Return-Path: <linux-kernel+bounces-837201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BDBABADC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE01921948
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77BA298CBC;
	Tue, 30 Sep 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ktymnz/w"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9654296BDC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214405; cv=none; b=X7RCNGxyEFyJH+34UgEgMW5y4qX17Hweilx1+40vbS+aXlLsV11LjP7AS6H5eOyT+RK1WOfIy8cbXoOFaVgZgb3INxueHKU+28bs7Roob96qgn1uXlPNVFMCerzfsdmR8HWLIG1PLeieT+09YK2NFThK0X55qQJKYWwnBVPN2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214405; c=relaxed/simple;
	bh=gVOOT94wC19sbD93lot4jWrHyeldcTBLJ+vlho5zRn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFA4dw9e0Qg5VLSBM98ZdZzDJcNQZ5uFR+0cBJV6fo3A1Lh3YSe1HUVqFJNMv7tl7895GDTWo/G/7egS9yfcaq667djCpDYml3Q9mb+Q6ObobyhQ8Z50kf8PNJJ4swustgprc2KrJ+EO3lKOXu81w7xLPZMOnj/0Y2Kr44Y9NFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ktymnz/w; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+A
	DYZgQxqjML4TSvzcJwM4PJN4DmwLuvNdowvW8LHNg=; b=Ktymnz/wrmiLNEMW4a
	imQFqoYYWuJQhq+stRLqOF6FcuM9my0vSQznURViXuoIa4WiXX4IxjikbqBlFx4+
	kUM6yRAYNBKErj6mNPKJWHXWMfx9lVZdHv1/spXkNXL7xF8QHGcBgv50XFxupI6f
	bFuJgCJcfapB19tbTVkVZ+J/M=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX5V3qetto_xZ6BA--.4290S2;
	Tue, 30 Sep 2025 14:38:35 +0800 (CST)
From: ranxiaokai627@163.com
To: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH] slab: Add allow_spin check to eliminate kmemleak warnings
Date: Tue, 30 Sep 2025 06:38:31 +0000
Message-ID: <20250930063831.782815-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX5V3qetto_xZ6BA--.4290S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrCryUKr4kGFyDAFWrZrb_yoW8XF4fpF
	1rJ345ArZ8Xr1Ykr4YyF92kr1Uua98W3y8JFyxWr1S9a13JwnrKF98trWS9r13AFW0k3WD
	Z3ZYvFW5Xry5taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-UUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiOxLYTGjbcuTiWQAAsj

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

In slab_post_alloc_hook(), kmemleak check is skipped when
gfpflags_allow_spinning() returns false since commit 13d872ade8be
("slab: Introduce kmalloc_nolock() and kfree_nolock().").
Therefore, unconditionally calling kmemleak_not_leak() in
alloc_slab_obj_exts() would trigger the following warning:

kmemleak: Trying to color unknown object at 0xffff8881057f5000 as Grey
Call Trace:
 alloc_slab_obj_exts+0x1b5/0x370
 __alloc_tagging_slab_alloc_hook+0x9f/0x2d0
 __kmalloc_cache_noprof+0x1c4/0x5c0
 __set_page_owner+0x10d/0x1c0
 post_alloc_hook+0x84/0xf0
 get_page_from_freelist+0x73b/0x1380
 __alloc_frozen_pages_noprof+0x110/0x2c0
 alloc_pages_mpol+0x44/0x140
 alloc_slab_page+0xac/0x150
 allocate_slab+0x78/0x3a0
 ___slab_alloc+0x76b/0xed0
 __slab_alloc.constprop.0+0x5a/0xb0

Add the allow_spin check in alloc_slab_obj_exts() to
eliminate the above warning.

Fixes: 13d872ade8be ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 09cbe580842c..a76275f4870a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2145,7 +2145,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		return 0;
 	}
 
-	kmemleak_not_leak(vec);
+	if (allow_spin)
+		kmemleak_not_leak(vec);
 	return 0;
 }
 
-- 
2.25.1


