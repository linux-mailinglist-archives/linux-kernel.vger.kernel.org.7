Return-Path: <linux-kernel+bounces-612017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AAA94971
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 21:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B28A188E99C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF71DD9AC;
	Sun, 20 Apr 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhGGabv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800411DED5C;
	Sun, 20 Apr 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178046; cv=none; b=F0cj87PgMA7zlK+H/bogKrGbv5iaJy08AxORGl04r6WdQ+1PvJijUviukG+D2t7jvjQmWdJluvji5VXXrLkmwj8JvEyerZ1Iyi3Q6Jk42S8783j6qoMyb7r73/dp51SwkQoh19Cak7UoPKgV1wgEcBpetYnpInOMZA6/A9k+6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178046; c=relaxed/simple;
	bh=edQP+KhuArJze7tr3pDlMhuWrs27WlBNlib9Ik5OOrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW/1W8JU892FoDc0fKTj4pylOqgktkY4fVUYZYEQCQ8zZzEiGKsDIEdPd/n0wDQbdBJA4C3hLDVooyEQwiYLq8tYIuVvgcdd7c6IvXHQpYy2QTVw2kUn/oFeqh9MckqX6tIKmHFGAXviE2J/Qvg04e79cS5fGvyt89q/bnX8mKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhGGabv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FE0C4CEE9;
	Sun, 20 Apr 2025 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178045;
	bh=edQP+KhuArJze7tr3pDlMhuWrs27WlBNlib9Ik5OOrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhGGabv2M2JUAiqhb4gaJbHZgrumRy5ZbjCF1j5VoSRJm2Y0zt5bvDcDCYMd1IPef
	 J5/pZeuxMtxo3EZ4YuLqOyARZC0jQKfUlk1Msh5b10JDMw1MS///7VbAX+bYE/fUdC
	 wvSfjyJQUMOgz/ODgJ1YUPHubIVktA6ig5cSySmvqp4SPW4y6/VpXtzH3waeBrLGbV
	 uJu6DsEu1MlsEx5TIang2rIGG8AMtFbjbve62ci8QcA8wJOnWzJTJXebizCsK9rRxo
	 PacxSgFv0P6jAEJdvaU8txIcwEFmFzlrtN7wJ4rmxCqo1JKDe8MdwEnws4S8f1G8t/
	 ubUD6m20BXi3Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/7] samples/damon: implement a DAMON module for memory tiering
Date: Sun, 20 Apr 2025 12:40:30 -0700
Message-Id: <20250420194030.75838-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sample DAMON module that shows how self-tuned DAMON-based
memory tiering can be written.  It is a sample since the purpose is to
give an idea about how it can be implemented and perform, rather than be
used on general production setups.  Especially, it supports only two
tiers memory setup having only one CPU-attached NUMA node.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/Kconfig  |  13 ++++
 samples/damon/Makefile |   1 +
 samples/damon/mtier.c  | 167 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 samples/damon/mtier.c

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index 564c49ed69a2..cbf96fd8a8bf 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -27,4 +27,17 @@ config SAMPLE_DAMON_PRCL
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_MTIER
+	bool "DAMON sample module for memory tiering"
+	depends on DAMON && DAMON_PADDR
+	help
+	  Thps builds DAMON sample module for memory tierign.
+
+	  The module assumes the system is constructed with two NUMA nodes,
+	  which seems as local and remote nodes to all CPUs.  For example,
+	  node0 is for DDR5 DRAMs connected via DIMM, while node1 is for DDR4
+	  DRAMs connected via CXL.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index 7f155143f237..72f68cbf422a 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
 obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
+obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
new file mode 100644
index 000000000000..3390b7d30c26
--- /dev/null
+++ b/samples/damon/mtier.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * memory tiering: migrate cold pages in node 0 and hot pages in node 1 to node
+ * 1 and node 0, respectively.  Adjust the hotness/coldness threshold aiming
+ * resulting 99.6 % node 0 utilization ratio.
+ */
+
+#define pr_fmt(fmt) "damon_sample_mtier: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static unsigned long node0_start_addr __read_mostly;
+module_param(node0_start_addr, ulong, 0600);
+
+static unsigned long node0_end_addr __read_mostly;
+module_param(node0_end_addr, ulong, 0600);
+
+static unsigned long node1_start_addr __read_mostly;
+module_param(node1_start_addr, ulong, 0600);
+
+static unsigned long node1_end_addr __read_mostly;
+module_param(node1_end_addr, ulong, 0600);
+
+static int damon_sample_mtier_enable_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enable_param_ops = {
+	.set = damon_sample_mtier_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enable __read_mostly;
+module_param_cb(enable, &enable_param_ops, &enable, 0600);
+MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
+
+static struct damon_ctx *ctxs[2];
+
+static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *target;
+	struct damon_region *region;
+	struct damos *scheme;
+	struct damos_quota_goal *quota_goal;
+	struct damos_filter *filter;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return NULL;
+	/*
+	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
+	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
+	 */
+	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
+		.access_bp = 400, .aggrs = 3,
+		.min_sample_us = 5000, .max_sample_us = 10000000,
+	};
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+		goto free_out;
+
+	target = damon_new_target();
+	if (!target)
+		goto free_out;
+	damon_add_target(ctx, target);
+	region = damon_new_region(
+			promote ? node1_start_addr : node0_start_addr,
+			promote ? node1_end_addr : node0_end_addr);
+	if (!region)
+		goto free_out;
+	damon_add_region(region, target);
+
+	scheme = damon_new_scheme(
+			/* access pattern */
+			&(struct damos_access_pattern) {
+				.min_sz_region = PAGE_SIZE,
+				.max_sz_region = ULONG_MAX,
+				.min_nr_accesses = promote ? 1 : 0,
+				.max_nr_accesses = promote ? UINT_MAX : 0,
+				.min_age_region = 0,
+				.max_age_region = UINT_MAX},
+			/* action */
+			promote ? DAMOS_MIGRATE_HOT : DAMOS_MIGRATE_COLD,
+			1000000,	/* apply interval (1s) */
+			&(struct damos_quota){
+				/* 200 MiB per sec by most */
+				.reset_interval = 1000,
+				.sz = 200 * 1024 * 1024,
+				/* ignore size of region when prioritizing */
+				.weight_sz = 0,
+				.weight_nr_accesses = 100,
+				.weight_age = 100,
+			},
+			&(struct damos_watermarks){},
+			promote ? 0 : 1);	/* migrate target node id */
+	if (!scheme)
+		goto free_out;
+	damon_set_schemes(ctx, &scheme, 1);
+	quota_goal = damos_new_quota_goal(
+			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
+			DAMOS_QUOTA_NODE_MEM_FREE_BP,
+			promote ? 9970 : 50);
+	if (!quota_goal)
+		goto free_out;
+	quota_goal->nid = 0;
+	damos_add_quota_goal(&scheme->quota, quota_goal);
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, promote);
+	if (!filter)
+		goto free_out;
+	damos_add_filter(scheme, filter);
+	return ctx;
+free_out:
+	damon_destroy_ctx(ctx);
+	return NULL;
+}
+
+static int damon_sample_mtier_start(void)
+{
+	struct damon_ctx *ctx;
+
+	ctx = damon_sample_mtier_build_ctx(true);
+	if (!ctx)
+		return -ENOMEM;
+	ctxs[0] = ctx;
+	ctx = damon_sample_mtier_build_ctx(false);
+	if (!ctx) {
+		damon_destroy_ctx(ctxs[0]);
+		return -ENOMEM;
+	}
+	ctxs[1] = ctx;
+	return damon_start(ctxs, 2, true);
+}
+
+static void damon_sample_mtier_stop(void)
+{
+	damon_stop(ctxs, 2);
+	damon_destroy_ctx(ctxs[0]);
+	damon_destroy_ctx(ctxs[1]);
+}
+
+static int damon_sample_mtier_enable_store(
+		const char *val, const struct kernel_param *kp)
+{
+	bool enabled = enable;
+	int err;
+
+	err = kstrtobool(val, &enable);
+	if (err)
+		return err;
+
+	if (enable == enabled)
+		return 0;
+
+	if (enable)
+		return damon_sample_mtier_start();
+	damon_sample_mtier_stop();
+	return 0;
+}
+
+static int __init damon_sample_mtier_init(void)
+{
+	return 0;
+}
+
+module_init(damon_sample_mtier_init);
-- 
2.39.5

