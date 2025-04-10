Return-Path: <linux-kernel+bounces-598840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815AA84BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29A8188F6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040A72836AA;
	Thu, 10 Apr 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IGIVYTYS"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129391EE00B;
	Thu, 10 Apr 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307529; cv=none; b=KHdocrlLaerDYi3IoY/yCyeAo/CfinB6AzGs4Gf5dx+YhtaMi+TXSRN5pbe2yzV1lVopxmYTx4KxR8mmaLL+Pusw9oRk1brq6vy3tDeTy4GWgyYAr3lypZSDE72dzmqreT5ZNUYrEzAPtfb/+62dFMtWcbgcf0nX9V8tnHLS05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307529; c=relaxed/simple;
	bh=BUdrhwfVnJRG3xjzZpa0fpfWEdsIoPPINFDA6smKiNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VMAN1/SWgI6jcW415WYjApX6IwdNjxP8orC6KliHtpbj1yPTIC6sB5BNAbC5reJ/sIUgHtc0G2q0iMgA9faSAHeFCz2SL3pks7hzEvMNzUWKsCMaTv9P6EH/aWOAbVIEVpOQSXlv5v25LAi6s5D/PN672tTtqqPhfmwUh5eJl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IGIVYTYS; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1744307520;
	bh=BUdrhwfVnJRG3xjzZpa0fpfWEdsIoPPINFDA6smKiNw=;
	h=From:To:Cc:Subject:Date:From;
	b=IGIVYTYSnmA5rklHg3THyp19gT9yq7i7t4NHWtMWjOq++tboMU64i+tJKWuue1okI
	 1n6Coua8vEcs1p8FQXj9NcrQGtZXBqPn2NKGOPYT140aFeIT5DRjSEiTv7wMSswlMH
	 aa4CPlrx63ncgo4d51yoJ46FsGwPjRG+DwtNw/Leo4fzPbqVThR0HYSqSE8QZjk5iX
	 moKXCgiT8lrG/dDQKzoKicReNsFrSDJ+H797RDhLIjcCk03UPQv6wTntwQwZ8Gvz1l
	 A9NFIOWlSnfupTmUDkENFeJxqgqU5TdxBVCO2XcEQqETp3qwgUSxGnsAIQ6/PG4UuO
	 89gYOZzNBf/Rw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZYS7L1xQtzl2d;
	Thu, 10 Apr 2025 13:51:58 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Sweet Tea Dorminy <sweettea@google.com>,
	Christoph Lameter <cl@linux.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v3] Introduce Hierarchical Per-CPU Counters
Date: Thu, 10 Apr 2025 13:51:49 -0400
Message-Id: <20250410175149.1206995-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Motivation

The purpose of this hierarchical split-counter scheme is to:

- Minimize contention when incrementing and decrementing counters,
- Provide fast access to a sum approximation,
- Provide a sum approximation with an acceptable accuracy level when
  scaling to many-core systems.
- Provide approximate and precise comparison of two counters, and
  between a counter and a value.

It aims at fixing the per-mm RSS tracking which has become too
inaccurate for OOM killer purposes on large many-core systems [1].

* Design

The hierarchical per-CPU counters propagate a sum approximation through
a N-way tree. When reaching the batch size, the carry is propagated
through a binary tree which consists of logN(nr_cpu_ids) levels. The
batch size for each level is twice the batch size of the prior level.

Example propagation diagram with 8 cpus through a binary tree:

Level 0:  0    1    2    3    4    5    6    7
          |   /     |   /     |   /     |   /
          |  /      |  /      |  /      |  /
          | /       | /       | /       | /
Level 1:  0         1         2         3
          |       /           |       /
          |    /              |    /
          | /                 | /
Level 2:  0                   1
          |               /
          |         /
          |   /
Level 3:  0

For a binary tree, the maximum inaccuracy is bound by:
   batch_size * log2(nr_cpus) * nr_cpus
which evolves with O(n*log(n)) as the number of CPUs increases.

For a N-way tree, the maximum inaccuracy can be pre-calculated
based on the the N-arity of each level and the batch size.

Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
Changes since v2:
- Introduce N-way tree to reduce tree depth on larger systems.

Changes since v1:
- Remove percpu_counter_tree_precise_sum_unbiased from public header,
  make this function static,
- Introduce precise and approximate comparisons between two counters,
- Reorder the struct percpu_counter_tree fields,
- Introduce approx_sum field, which points to the approximate sum
  for the percpu_counter_tree_approximate_sum() fast path.
---
 include/linux/percpu_counter_tree.h | 108 ++++++++
 lib/Makefile                        |   1 +
 lib/percpu_counter_tree.c           | 393 ++++++++++++++++++++++++++++
 3 files changed, 502 insertions(+)
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

diff --git a/include/linux/percpu_counter_tree.h b/include/linux/percpu_counter_tree.h
new file mode 100644
index 000000000000..7bdbb3ffa10c
--- /dev/null
+++ b/include/linux/percpu_counter_tree.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/* SPDX-FileCopyrightText: 2025 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> */
+
+#ifndef _PERCPU_COUNTER_TREE_H
+#define _PERCPU_COUNTER_TREE_H
+
+#include <linux/cleanup.h>
+#include <linux/preempt.h>
+#include <linux/atomic.h>
+#include <linux/percpu.h>
+
+struct percpu_counter_tree_level_item {
+	atomic_t count;
+} ____cacheline_aligned_in_smp;
+
+struct percpu_counter_tree {
+	/* Fast-path fields. */
+	unsigned int __percpu *level0;
+	unsigned int level0_bit_mask;
+	union {
+		unsigned int *i;
+		atomic_t *a;
+	} approx_sum;
+	int bias;			/* bias for counter_set */
+
+	/* Slow-path fields. */
+	struct percpu_counter_tree_level_item *items;
+	unsigned int batch_size;
+	unsigned int inaccuracy;	/* approximation imprecise within ± inaccuracy */
+};
+
+int percpu_counter_tree_init(struct percpu_counter_tree *counter, unsigned int batch_size);
+void percpu_counter_tree_destroy(struct percpu_counter_tree *counter);
+void percpu_counter_tree_add_slowpath(struct percpu_counter_tree *counter, int inc);
+int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter);
+int percpu_counter_tree_approximate_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
+int percpu_counter_tree_approximate_compare_value(struct percpu_counter_tree *counter, int v);
+int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
+int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v);
+void percpu_counter_tree_set_bias(struct percpu_counter_tree *counter, int bias);
+void percpu_counter_tree_set(struct percpu_counter_tree *counter, int v);
+unsigned int percpu_counter_tree_inaccuracy(struct percpu_counter_tree *counter);
+
+/* Fast paths */
+
+static inline
+int percpu_counter_tree_carry(int orig, int res, int inc, unsigned int bit_mask)
+{
+	if (inc < 0) {
+		inc = -(-inc & ~(bit_mask - 1));
+		/*
+		 * xor bit_mask: underflow.
+		 *
+		 * If inc has bit set, decrement an additional bit if
+		 * there is _no_ bit transition between orig and res.
+		 * Else, inc has bit cleared, decrement an additional
+		 * bit if there is a bit transition between orig and
+		 * res.
+		 */
+		if ((inc ^ orig ^ res) & bit_mask)
+			inc -= bit_mask;
+	} else {
+		inc &= ~(bit_mask - 1);
+		/*
+		 * xor bit_mask: overflow.
+		 *
+		 * If inc has bit set, increment an additional bit if
+		 * there is _no_ bit transition between orig and res.
+		 * Else, inc has bit cleared, increment an additional
+		 * bit if there is a bit transition between orig and
+		 * res.
+		 */
+		if ((inc ^ orig ^ res) & bit_mask)
+			inc += bit_mask;
+	}
+	return inc;
+}
+
+static inline
+void percpu_counter_tree_add(struct percpu_counter_tree *counter, int inc)
+{
+	unsigned int bit_mask = counter->level0_bit_mask, orig, res;
+
+	if (!inc)
+		return;
+	/* Make sure the fast and slow paths use the same cpu number. */
+	guard(migrate)();
+	res = this_cpu_add_return(*counter->level0, inc);
+	orig = res - inc;
+	inc = percpu_counter_tree_carry(orig, res, inc, bit_mask);
+	if (!inc)
+		return;
+	percpu_counter_tree_add_slowpath(counter, inc);
+}
+
+static inline
+int percpu_counter_tree_approximate_sum(struct percpu_counter_tree *counter)
+{
+	unsigned int v;
+
+	if (!counter->level0_bit_mask)
+		v = READ_ONCE(*counter->approx_sum.i);
+	else
+		v = atomic_read(counter->approx_sum.a);
+	return (int) (v + (unsigned int)READ_ONCE(counter->bias));
+}
+
+#endif  /* _PERCPU_COUNTER_TREE_H */
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..d803a3a63288 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -201,6 +201,7 @@ obj-$(CONFIG_TEXTSEARCH_KMP) += ts_kmp.o
 obj-$(CONFIG_TEXTSEARCH_BM) += ts_bm.o
 obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
 obj-$(CONFIG_SMP) += percpu_counter.o
+obj-$(CONFIG_SMP) += percpu_counter_tree.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
diff --git a/lib/percpu_counter_tree.c b/lib/percpu_counter_tree.c
new file mode 100644
index 000000000000..928df7ac601e
--- /dev/null
+++ b/lib/percpu_counter_tree.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-FileCopyrightText: 2025 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+
+/*
+ * Split Counters With Tree Approximation Propagation
+ *
+ * * Propagation diagram when reaching batch size thresholds (± batch size):
+ *
+ * Example diagram for 8 CPUs:
+ *
+ * log2(8) = 3 levels
+ *
+ * At each level, each pair propagates its values to the next level when
+ * reaching the batch size thresholds.
+ *
+ * Counters at levels 0, 1, 2 can be kept on a single byte (±128 range),
+ * although it may be relevant to keep them on 32-bit counters for
+ * simplicity. (complexity vs memory footprint tradeoff)
+ *
+ * Counter at level 3 can be kept on a 32-bit counter.
+ *
+ * Level 0:  0    1    2    3    4    5    6    7
+ *           |   /     |   /     |   /     |   /
+ *           |  /      |  /      |  /      |  /
+ *           | /       | /       | /       | /
+ * Level 1:  0         1         2         3
+ *           |       /           |       /
+ *           |    /              |    /
+ *           | /                 | /
+ * Level 2:  0                   1
+ *           |               /
+ *           |         /
+ *           |   /
+ * Level 3:  0
+ *
+ * * Approximation inaccuracy:
+ *
+ * BATCH(level N): Level N batch size.
+ *
+ * Example for BATCH(level 0) = 32.
+ *
+ * BATCH(level 0) =  32
+ * BATCH(level 1) =  64
+ * BATCH(level 2) = 128
+ * BATCH(level N) = BATCH(level 0) * 2^N
+ *
+ *            per-counter     global
+ *            inaccuracy      inaccuracy
+ * Level 0:   [ -32 ..  +31]  ±256  (8 * 32)
+ * Level 1:   [ -64 ..  +63]  ±256  (4 * 64)
+ * Level 2:   [-128 .. +127]  ±256  (2 * 128)
+ * Total:      ------         ±768  (log2(nr_cpu_ids) * BATCH(level 0) * nr_cpu_ids)
+ *
+ * -----
+ *
+ * Approximate Sum Carry Propagation
+ *
+ * Let's define a number of counter bits for each level, e.g.:
+ *
+ * log2(BATCH(level 0)) = log2(32) = 5
+ *
+ *               nr_bit        value_mask                      range
+ * Level 0:      5 bits        v                             0 ..  +31
+ * Level 1:      1 bit        (v & ~((1UL << 5) - 1))        0 ..  +63
+ * Level 2:      1 bit        (v & ~((1UL << 6) - 1))        0 .. +127
+ * Level 3:     25 bits       (v & ~((1UL << 7) - 1))        0 .. 2^32-1
+ *
+ * Note: Use a full 32-bit per-cpu counter at level 0 to allow precise sum.
+ *
+ * Note: Use cacheline aligned counters at levels above 0 to prevent false sharing.
+ *       If memory footprint is an issue, a specialized allocator could be used
+ *       to eliminate padding.
+ *
+ * Example with expanded values:
+ *
+ * counter_add(counter, inc):
+ *
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = percpu_add_return(counter @ Level 0, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b00011111);  // Clear used bits
+ *                 // xor bit 5: underflow
+ *                 if ((inc ^ orig ^ res) & 0b00100000)
+ *                         inc -= 0b00100000;
+ *         } else {
+ *                 inc &= ~0b00011111;           // Clear used bits
+ *                 // xor bit 5: overflow
+ *                 if ((inc ^ orig ^ res) & 0b00100000)
+ *                         inc += 0b00100000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = atomic_add_return(counter @ Level 1, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b00111111);  // Clear used bits
+ *                 // xor bit 6: underflow
+ *                 if ((inc ^ orig ^ res) & 0b01000000)
+ *                         inc -= 0b01000000;
+ *         } else {
+ *                 inc &= ~0b00111111;           // Clear used bits
+ *                 // xor bit 6: overflow
+ *                 if ((inc ^ orig ^ res) & 0b01000000)
+ *                         inc += 0b01000000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         res = atomic_add_return(counter @ Level 2, inc);
+ *         orig = res - inc;
+ *         if (inc < 0) {
+ *                 inc = -(-inc & ~0b01111111);  // Clear used bits
+ *                 // xor bit 7: underflow
+ *                 if ((inc ^ orig ^ res) & 0b10000000)
+ *                         inc -= 0b10000000;
+ *         } else {
+ *                 inc &= ~0b01111111;           // Clear used bits
+ *                 // xor bit 7: overflow
+ *                 if ((inc ^ orig ^ res) & 0b10000000)
+ *                         inc += 0b10000000;
+ *         }
+ *         if (!inc)
+ *                 return;
+ *
+ *         atomic_add(counter @ Level 3, inc);
+ */
+
+#include <linux/percpu_counter_tree.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/atomic.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/math.h>
+
+#define MAX_NR_LEVELS 5
+
+struct counter_config {
+	unsigned int nr_items;
+	unsigned char nr_levels;
+	unsigned char n_arity_order[MAX_NR_LEVELS];
+};
+
+/*
+ * nr_items is the number of items in the tree for levels 1 to and
+ * including the final level (approximate sum). It excludes the level 0
+ * per-cpu counters.
+ */
+static const struct counter_config per_nr_cpu_order_config[] = {
+	[0] =	{ .nr_items = 1,	.nr_levels = 0,		.n_arity_order = { 0 } },
+	[1] =	{ .nr_items = 3,	.nr_levels = 1,		.n_arity_order = { 1 } },
+	[2] =	{ .nr_items = 3,	.nr_levels = 2,		.n_arity_order = { 1, 1 } },
+	[3] =	{ .nr_items = 7,	.nr_levels = 3,		.n_arity_order = { 1, 1, 1 } },
+	[4] =	{ .nr_items = 7,	.nr_levels = 3,		.n_arity_order = { 2, 1, 1 } },
+	[5] =	{ .nr_items = 11,	.nr_levels = 3,		.n_arity_order = { 2, 2, 1 } },
+	[6] =	{ .nr_items = 21,	.nr_levels = 3,		.n_arity_order = { 2, 2, 2 } },
+	[7] =	{ .nr_items = 21,	.nr_levels = 3,		.n_arity_order = { 3, 2, 2 } },
+	[8] =	{ .nr_items = 37,	.nr_levels = 3,		.n_arity_order = { 3, 3, 2 } },
+	[9] =	{ .nr_items = 73,	.nr_levels = 3,		.n_arity_order = { 3, 3, 3 } },
+	[10] =	{ .nr_items = 149,	.nr_levels = 4,		.n_arity_order = { 3, 3, 2, 2 } },
+	[11] =	{ .nr_items = 293,	.nr_levels = 4,		.n_arity_order = { 3, 3, 3, 2 } },
+	[12] =	{ .nr_items = 585,	.nr_levels = 4,		.n_arity_order = { 3, 3, 3, 3 } },
+	[13] =	{ .nr_items = 1173,	.nr_levels = 5,		.n_arity_order = { 3, 3, 3, 2, 2 } },
+	[14] =	{ .nr_items = 2341,	.nr_levels = 5,		.n_arity_order = { 3, 3, 3, 3, 2 } },
+	[15] =	{ .nr_items = 4681,	.nr_levels = 5,		.n_arity_order = { 3, 3, 3, 3, 3 } },
+	[16] =	{ .nr_items = 4681,	.nr_levels = 5,		.n_arity_order = { 4, 3, 3, 3, 3 } },
+	[17] =	{ .nr_items = 8777,	.nr_levels = 5,		.n_arity_order = { 4, 4, 3, 3, 3 } },
+	[18] =	{ .nr_items = 17481,	.nr_levels = 5,		.n_arity_order = { 4, 4, 4, 3, 3 } },
+	[19] =	{ .nr_items = 34953,	.nr_levels = 5,		.n_arity_order = { 4, 4, 4, 4, 3 } },
+	[20] =	{ .nr_items = 69905,	.nr_levels = 5,		.n_arity_order = { 4, 4, 4, 4, 4 } },
+};
+
+static const struct counter_config *counter_config;
+static unsigned int nr_cpus_order, inaccuracy_multiplier;
+
+int percpu_counter_tree_init(struct percpu_counter_tree *counter, unsigned int batch_size)
+{
+	/* Batch size must be power of 2 */
+	if (!batch_size || (batch_size & (batch_size - 1)))
+		return -EINVAL;
+	counter->batch_size = batch_size;
+	counter->bias = 0;
+	counter->level0 = alloc_percpu(unsigned int);
+	if (!counter->level0)
+		return -ENOMEM;
+	if (!nr_cpus_order) {
+		counter->items = NULL;
+		counter->approx_sum.i = per_cpu_ptr(counter->level0, 0);
+		counter->level0_bit_mask = 0;
+	} else {
+		counter->items = kzalloc(counter_config->nr_items *
+					 sizeof(struct percpu_counter_tree_level_item),
+					 GFP_KERNEL);
+		if (!counter->items) {
+			free_percpu(counter->level0);
+			return -ENOMEM;
+		}
+		counter->approx_sum.a = &counter->items[counter_config->nr_items - 1].count;
+		counter->level0_bit_mask = 1UL << get_count_order(batch_size);
+	}
+	counter->inaccuracy = batch_size * inaccuracy_multiplier;
+	return 0;
+}
+
+void percpu_counter_tree_destroy(struct percpu_counter_tree *counter)
+{
+	free_percpu(counter->level0);
+	kfree(counter->items);
+}
+
+/* Called with migration disabled. */
+void percpu_counter_tree_add_slowpath(struct percpu_counter_tree *counter, int inc)
+{
+	unsigned int level_items, nr_levels = counter_config->nr_levels,
+		     level, n_arity_order, bit_mask;
+	struct percpu_counter_tree_level_item *item = counter->items;
+	unsigned int cpu = smp_processor_id();
+
+	WARN_ON_ONCE(!nr_cpus_order);	/* Should never be called for 1 cpu. */
+
+	n_arity_order = counter_config->n_arity_order[0];
+	bit_mask = counter->level0_bit_mask << n_arity_order;
+	level_items = 1U << (nr_cpus_order - n_arity_order);
+
+	for (level = 1; level < nr_levels; level++) {
+		atomic_t *count = &item[cpu & (level_items - 1)].count;
+		unsigned int orig, res;
+
+		res = atomic_add_return_relaxed(inc, count);
+		orig = res - inc;
+		inc = percpu_counter_tree_carry(orig, res, inc, bit_mask);
+		if (!inc)
+			return;
+		item += level_items;
+		n_arity_order = counter_config->n_arity_order[level];
+		level_items >>= n_arity_order;
+		bit_mask <<= n_arity_order;
+	}
+	atomic_add(inc, counter->approx_sum.a);
+}
+
+/*
+ * Precise sum. Perform the sum of all per-cpu counters.
+ */
+static int percpu_counter_tree_precise_sum_unbiased(struct percpu_counter_tree *counter)
+{
+	unsigned int sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum += *per_cpu_ptr(counter->level0, cpu);
+	return (int) sum;
+}
+
+int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter)
+{
+	return percpu_counter_tree_precise_sum_unbiased(counter) + READ_ONCE(counter->bias);
+}
+
+/*
+ * Do an approximate comparison of two counters.
+ * Return 0 if counters do not differ by more than the sum of their
+ * respective inaccuracy ranges,
+ * Return -1 if counter @a less than counter @b,
+ * Return 1 if counter @a is greater than counter @b.
+ */
+int percpu_counter_tree_approximate_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b)
+{
+	int count_a = percpu_counter_tree_approximate_sum(a),
+	    count_b = percpu_counter_tree_approximate_sum(b);
+
+	if (abs(count_a - count_b) <= (a->inaccuracy + b->inaccuracy))
+		return 0;
+	if (count_a < count_b)
+		return -1;
+	return 1;
+}
+
+/*
+ * Do an approximate comparison of a counter against a given value.
+ * Return 0 if the value is within the inaccuracy range of the counter,
+ * Return -1 if the value less than counter,
+ * Return 1 if the value is greater than counter.
+ */
+int percpu_counter_tree_approximate_compare_value(struct percpu_counter_tree *counter, int v)
+{
+	int count = percpu_counter_tree_approximate_sum(counter);
+
+	if (abs(v - count) <= counter->inaccuracy)
+		return 0;
+	if (count < v)
+		return -1;
+	return 1;
+}
+
+/*
+ * Do a precise comparison of two counters.
+ * Return 0 if the counters are equal,
+ * Return -1 if counter @a less than counter @b,
+ * Return 1 if counter @a is greater than counter @b.
+ */
+int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b)
+{
+	int count_a = percpu_counter_tree_approximate_sum(a),
+	    count_b = percpu_counter_tree_approximate_sum(b);
+
+	if (abs(count_a - count_b) <= (a->inaccuracy + b->inaccuracy)) {
+		if (b->inaccuracy < a->inaccuracy) {
+			count_a = percpu_counter_tree_precise_sum(a);
+			if (abs(count_a - count_b) <= b->inaccuracy)
+				count_b = percpu_counter_tree_precise_sum(b);
+		} else {
+			count_b = percpu_counter_tree_precise_sum(b);
+			if (abs(count_a - count_b) <= a->inaccuracy)
+				count_a = percpu_counter_tree_precise_sum(a);
+		}
+	}
+	if (count_a > count_b)
+		return -1;
+	if (count_a > count_b)
+		return 1;
+	return 0;
+}
+
+/*
+ * Do a precise comparision of a counter against a given value.
+ * Return 0 if the value is equal to the counter,
+ * Return -1 if the value less than counter,
+ * Return 1 if the value is greater than counter.
+ */
+int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v)
+{
+	int count = percpu_counter_tree_approximate_sum(counter);
+
+	if (abs(v - count) <= counter->inaccuracy)
+		count = percpu_counter_tree_precise_sum(counter);
+	if (count < v)
+		return -1;
+	if (count > v)
+		return 1;
+	return 0;
+}
+
+void percpu_counter_tree_set_bias(struct percpu_counter_tree *counter, int bias)
+{
+	WRITE_ONCE(counter->bias, bias);
+}
+
+void percpu_counter_tree_set(struct percpu_counter_tree *counter, int v)
+{
+	percpu_counter_tree_set_bias(counter,
+				     v - percpu_counter_tree_precise_sum_unbiased(counter));
+}
+
+unsigned int percpu_counter_tree_inaccuracy(struct percpu_counter_tree *counter)
+{
+	return counter->inaccuracy;
+}
+
+static unsigned int __init calculate_inaccuracy_multiplier(void)
+{
+	unsigned int nr_levels = counter_config->nr_levels, level;
+	unsigned int level_items = 1U << nr_cpus_order;
+	unsigned int inaccuracy = 0, batch_size = 1;
+
+	for (level = 0; level < nr_levels; level++) {
+		unsigned int n_arity_order = counter_config->n_arity_order[level];
+
+		inaccuracy += batch_size * level_items;
+		batch_size <<= n_arity_order;
+		level_items >>= n_arity_order;
+	}
+	return inaccuracy;
+}
+
+static int __init percpu_counter_startup(void)
+{
+
+	nr_cpus_order = get_count_order(nr_cpu_ids);
+	if (WARN_ON_ONCE(nr_cpus_order >= ARRAY_SIZE(per_nr_cpu_order_config))) {
+		printk(KERN_ERR "Unsupported number of CPUs (%u)\n", nr_cpu_ids);
+		return -1;
+	}
+	counter_config = &per_nr_cpu_order_config[nr_cpus_order];
+	inaccuracy_multiplier = calculate_inaccuracy_multiplier();
+	return 0;
+}
+module_init(percpu_counter_startup);
-- 
2.39.5


