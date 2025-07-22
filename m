Return-Path: <linux-kernel+bounces-740165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2501BB0D0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D846C25C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C6273817;
	Tue, 22 Jul 2025 04:14:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B904C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157670; cv=none; b=qogIAolkFOIdgTkgg8Y0uMkJDGBnM5MtOK5Irfqa6ZS1SSpXR2jtAVRWVKeaIknFsWlK75h3aRQQ0CcUI3laO7oebKIbel86bfjRbrWwmr/l/xbPsaoaMYNG6JoO1+5UmcU8KZJfBlKXcvTSjY4ArqWI1tuJDSlfgvylD9UeX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157670; c=relaxed/simple;
	bh=UNfIDnQBXn4P4O+vzhZSIsUf4m34jpXPCzOngL7KTL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCDB4/rysmN5mb7ZBuDmNGX8iD8Eo/S26gZjZSCGdJC5WoFAQ/vquXRK696xl4kkHeNnliWoMyYsryHRDyGzQbI/OQjhNFfJ4451VRVVPeqrxMp4ZjjCv4gT8KE8l8aC+TxZzHZSZYbyg5WCc05JwMCyLR1LgxqiZbf9oEV0xYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9581595;
	Mon, 21 Jul 2025 21:14:21 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (unknown [10.169.217.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A23E63F66E;
	Mon, 21 Jul 2025 21:14:25 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node mapping to  reduce max_distance
Date: Tue, 22 Jul 2025 04:14:18 +0000
Message-Id: <20250722041418.2024870-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcpu_embed_first_chunk() allocates the first percpu chunk via
pcpu_fc_alloc() and used as-is without being mapped into vmalloc area. On
NUMA systems, this can lead to a sparse CPU->unit mapping, resulting in a
large physical address span (max_distance) and excessive vmalloc space
requirements.

For example, on an arm64 N2 server with 256 CPUs, the memory layout
includes:
[    0.000000] NUMA: NODE_DATA [mem 0x100fffff0b00-0x100fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x500fffff0b00-0x500fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x600fffff0b00-0x600fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x700ffffbcb00-0x700ffffcbfff]

With the following NUMA distance matrix:
node distances:
node   0   1   2   3
  0:  10  16  22  22
  1:  16  10  22  22
  2:  22  22  10  16
  3:  22  22  16  10

In this configuration, pcpu_embed_first_chunk() computes a large
max_distance:
percpu: max_distance=0x5fffbfac0000 too large for vmalloc space 0x7bff70000000

As a result, the allocator falls back to pcpu_page_first_chunk(), which
uses page-by-page allocation with nr_groups = 1, leading to degraded
performance.

This patch introduces a normalized CPU-to-NUMA node mapping to mitigate
the issue. Distances of 10 and 16 are treated as local (LOCAL_DISTANCE),
allowing CPUs from nearby nodes to be grouped together. Consequently,
nr_groups will be 2 and pcpu_fc_alloc() uses the normalized node ID to
allocate memory from a common node.

For example:
- cpu0 belongs to node 0
- cpu64 belongs to node 1
Both CPUs are considered local and will allocate memory from node 0.
This normalization reduces max_distance:
percpu: max_distance=0x500000380000, ~64% of vmalloc space 0x7bff70000000

In addition, add a flag _need_norm_ to indicate the normalization is needed
iff when cpu_to_norm_node_map[] is different from cpu_to_node_map[].

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/base/arch_numa.c | 47 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index c99f2ab105e5..f746d88239e9 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -17,6 +17,8 @@
 #include <asm/sections.h>
 
 static int cpu_to_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
+static int cpu_to_norm_node_map[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
+static bool need_norm;
 
 bool numa_off;
 
@@ -149,9 +151,40 @@ int early_cpu_to_node(int cpu)
 	return cpu_to_node_map[cpu];
 }
 
+int __init early_cpu_to_norm_node(int cpu)
+{
+	return cpu_to_norm_node_map[cpu];
+}
+
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 {
-	return node_distance(early_cpu_to_node(from), early_cpu_to_node(to));
+	int distance = node_distance(early_cpu_to_node(from), early_cpu_to_node(to));
+
+	if (distance > LOCAL_DISTANCE && distance < REMOTE_DISTANCE && !need_norm)
+		need_norm = true;
+
+	return distance;
+}
+
+static int __init pcpu_cpu_norm_distance(unsigned int from, unsigned int to)
+{
+	int distance = pcpu_cpu_distance(from, to);
+
+	if (distance >= REMOTE_DISTANCE)
+		return REMOTE_DISTANCE;
+
+	/*
+	 * If the distance is in the range [LOCAL_DISTANCE, REMOTE_DISTANCE),
+	 * normalize the node map, choose the first local numa node id as its
+	 * normalized node id.
+	 */
+	if (cpu_to_norm_node_map[from] == NUMA_NO_NODE)
+		cpu_to_norm_node_map[from] = cpu_to_node_map[from];
+
+	if (cpu_to_norm_node_map[to] == NUMA_NO_NODE)
+		cpu_to_norm_node_map[to] = cpu_to_norm_node_map[from];
+
+	return LOCAL_DISTANCE;
 }
 
 void __init setup_per_cpu_areas(void)
@@ -169,6 +202,18 @@ void __init setup_per_cpu_areas(void)
 					    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
 					    pcpu_cpu_distance,
 					    early_cpu_to_node);
+
+		if (rc < 0 && need_norm) {
+			/* Try the normalized node distance again */
+			pr_info("PERCPU: %s allocator, trying the normalization mode\n",
+				   pcpu_fc_names[pcpu_chosen_fc]);
+
+			rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+						    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
+						    pcpu_cpu_norm_distance,
+						    early_cpu_to_norm_node);
+		}
+
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
 		if (rc < 0)
 			pr_warn("PERCPU: %s allocator failed (%d), falling back to page size\n",
-- 
2.34.1


