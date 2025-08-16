Return-Path: <linux-kernel+bounces-771783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38230B28B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64E4AA372B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD522CBC0;
	Sat, 16 Aug 2025 07:37:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9E22A7F2;
	Sat, 16 Aug 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329860; cv=none; b=ejSlhobaFkCwgYx8eVTQoWYy5+ZuMPpKn0RtgDD7W0cDx8IZ12+Uz38cWv159JwZC9MNv8+DQf6QiePT2wV76JFLOevcxjDSZxwGqqBLEY0Hggf6vM9Qg7pVv2dxdYvRgBs2xuqwEbRpbv0zT+Gbv1/6Iz+m40dh75lK0SbumSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329860; c=relaxed/simple;
	bh=/dVTk1qYplh5wGby56mcDhozRU+6sHqe0LKLvQKFnso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLpmLL2l9QzPCCPhiDdPjpdg6slSA455RI9zRYjTlYCb5b77xRI1bu95d/IOJryNESDUmwMRwhUVINyyIvYVgvPz2tTAoXt71YxuH0+XoP1mjFdJq3eOJ9e+WMamKtll1q69V1VRBwrQj1DgSeWq3eaEkvR/LFMpr38n/ISJsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c3rQ52gM0zqVTs;
	Sat, 16 Aug 2025 15:36:29 +0800 (CST)
Received: from kwepemo100001.china.huawei.com (unknown [7.202.195.173])
	by mail.maildlp.com (Postfix) with ESMTPS id 09FDD140123;
	Sat, 16 Aug 2025 15:37:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemo100001.china.huawei.com
 (7.202.195.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 15:37:28 +0800
From: Yin Tirui <yintirui@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <dan.j.williams@intel.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <rppt@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <devicetree@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>,
	<yintirui@huawei.com>
Subject: [PATCH v2] of_numa: fix uninitialized memory nodes causing kernel panic
Date: Sat, 16 Aug 2025 15:31:31 +0800
Message-ID: <20250816073131.2674809-1-yintirui@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
Signed-off-by: Yin Tirui <yintirui@huawei.com>

---

v2: Move the changes to the of_numa related. Correct the fixes tag.
---
 drivers/of/of_numa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 230d5f628c1b..cd2dc8e825c9 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
 			r = -EINVAL;
 		}
 
-		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
+		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
 			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
+			if (!r)
+				node_set(nid, numa_nodes_parsed);
+		}
 
 		if (!i || r) {
 			of_node_put(np);
-- 
2.43.0


