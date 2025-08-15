Return-Path: <linux-kernel+bounces-770739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FB3B27E72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15891A055A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214C2FD7D6;
	Fri, 15 Aug 2025 10:36:52 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02D2FD1B7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254212; cv=none; b=Eo6O1QLr4ByBUYZmPKXcFAuMguT4buzDTXXI9ZgJCHgF6DjSfOkBtqSLVdzRaGtiWWbGwKJElRszlZliF0OhZQ/QCsAuXj4DpdKr3raBAoAXgKqFGoLlIjgrquQQwkxXboRYYtnEzHXJJiTXz8PvP1aY/5Y0BLwaBvhrq/pwLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254212; c=relaxed/simple;
	bh=p/NnOKuDXNJI14VVVeNKobRW2XTB3qlqFdhESE40MIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtvzvOyJd9gB1NtNbxTIAf1FpMBdv++IzLMKD5HmIAS/0cSCwZw2zsU4p5Vvx+urPdDhZZgC7FmsK9z5kYKZf4ASxLBq9aSblLra6pNMLAFOpkcBWzDkosqzkirGbPvjxvjzKiPQ+MLWyzb++dU2kn0cahREcOvlNFHGR/Pvs00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c3JMZ0cCFzdcD4;
	Fri, 15 Aug 2025 18:32:26 +0800 (CST)
Received: from kwepemo100001.china.huawei.com (unknown [7.202.195.173])
	by mail.maildlp.com (Postfix) with ESMTPS id CEB8E1800B2;
	Fri, 15 Aug 2025 18:36:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemo100001.china.huawei.com
 (7.202.195.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 18:36:35 +0800
From: Yin Tirui <yintirui@huawei.com>
To: <akpm@linux-foundation.org>, <rppt@kernel.org>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <yintirui@huawei.com>, <chenjun102@huawei.com>,
	<wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/numa: fix uninitialized memory nodes causing kernel panic
Date: Fri, 15 Aug 2025 18:30:40 +0800
Message-ID: <20250815103040.511627-1-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100001.china.huawei.com (7.202.195.173)

When the number of CPUs is fewer than the number of memory nodes,
some memory nodes may not be properly initialized because they are
not added to numa_nodes_parsed during memory parsing.

In of_numa_parse_memory_nodes(), after successfully adding a memory
block via numa_add_memblk(), the corresponding node ID should be
marked as parsed. However, the current implementation in numa_add_memblk()
only adds the memory block to numa_meminfo but fails to update
numa_nodes_parsed, leaving some nodes uninitialized.

During boot in a QEMU-emulated ARM64 NUMA environment, the kernel
panics when free_area_init() attempts to access NODE_DATA() for
memory nodes that were uninitialized.

[    0.000000] Call trace:
[    0.000000]  free_area_init+0x620/0x106c (P)
[    0.000000]  bootmem_init+0x110/0x1dc
[    0.000000]  setup_arch+0x278/0x60c
[    0.000000]  start_kernel+0x70/0x748
[    0.000000]  __primary_switched+0x88/0x90

Cc: stable@vger.kernel.org
Fixes: 87482708210f ("mm: introduce numa_memblks")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
---
 mm/numa_memblks.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a..1dfe434e71b5 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -197,7 +197,13 @@ static void __init numa_move_tail_memblk(struct numa_meminfo *dst, int idx,
  */
 int __init numa_add_memblk(int nid, u64 start, u64 end)
 {
-	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
+	int ret;
+
+	ret = numa_add_memblk_to(nid, start, end, &numa_meminfo);
+	if (!ret)
+		node_set(nid, numa_nodes_parsed);
+
+	return ret;
 }
 
 /**
-- 
2.43.0


