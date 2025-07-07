Return-Path: <linux-kernel+bounces-719084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89829AFA9B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 04:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DAB1897E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 02:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D71B4257;
	Mon,  7 Jul 2025 02:31:46 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5842B9B7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751855505; cv=none; b=lUjV7kTll9gB4q0V6apMt9GYr6A9pcsc0DVACmo9uTJM6M+Nt/yxDZMH5gYfiCMrcJHO+24yUed1rrhU+O04DT8iYETf5XgTZUfd2cQI3zeeDqNfVI8RzCqlSCkSUB5kBh41MJpcrebv13GoOStVvze/mzux5N5GYeu+EI8SXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751855505; c=relaxed/simple;
	bh=zXh13fdB5Fd4WLT2qjKZLj19PnPLt/hMNKXcdkmwZSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6culGpq8BZ0wMSitzsvTyJgvmi081xmQuKXdpxBXbLdnONNLdPrRSsAN77G7vLzJ4m5yf3CW1AwnijoXWZJpvd/I/5jsmBVH73eVxL9cxL4BiULFdN0khcj/ssUKej3euyp1Zj+ApH9fH1Ksg0gG9CB3+a1zVXzjg3haMOarfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-74-686b3189c4f4
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [PATCH v3] samples/damon: support automatic node address detection
Date: Mon,  7 Jul 2025 11:31:34 +0900
Message-ID: <20250707023135.453-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsXC9ZZnoW6XYXaGwc42RYs569ewWTz5/5vV
	4vKuOWwW99b8Z7U4/PUNkwOrx6ZVnWwemz5NYvc4MeM3i8eLzTMZPT5vkgtgjeKySUnNySxL
	LdK3S+DKuP/pNGvBKrGK77v3MTYwnhDqYuTkkBAwkejYsIcRxt7wsYcVxGYT0JA4eOgkM4gt
	IiAo0f94BlCci4NZYC6jxJEz78EahAW8Je7MvAhmswioSrx+fx6sgVfATOLO3sdMEEM1JRou
	3WOCiAtKnJz5hAXEZhaQl2jeOpsZZKiEwF9WiXXL/jNDNEhKHFxxg2UCI+8sJD2zkPQsYGRa
	xSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYbMtq/0TvYPx0IfgQowAHoxIPr0F4VoYQa2JZcWXu
	IUYJDmYlEd42tuwMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJM
	HJxSDYzRb3VrqxikY051/rJPd2etsV4p8ube0XfpZ+xP7ueJu7XPTjB0ZW37xkWOrLP0z1Q/
	8g/OlFEsMoq6FpVf1/bhvP35dQ8ELlrvk1G5m3mOZ4fywhMSTBJynHJffAOW7e8xq58mVDHh
	vOCkrhWbX8yR1Kr+G+9/X5vfb+871jnfHSo6nSdcVVNiKc5INNRiLipOBAAdubppMgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhmiGro9tpmJ1hMH2nssWc9WvYLJ78/81q
	8fnZa2aLw3NPslpc3jWHzeLemv+sFoe/vmFyYPfYtKqTzWPTp0nsHidm/GbxeLF5JqPHt9se
	HotffGDy+LxJLoA9issmJTUnsyy1SN8ugSvj/qfTrAWrxCq+797H2MB4QqiLkZNDQsBEYsPH
	HlYQm01AQ+LgoZPMILaIgKBE/+MZQHEuDmaBuYwSR868ZwRJCAt4S9yZeRHMZhFQlXj9/jxY
	A6+AmcSdvY+ZIIZqSjRcuscEEReUODnzCQuIzSwgL9G8dTbzBEauWUhSs5CkFjAyrWIUycwr
	y03MzDHVK87OqMzLrNBLzs/dxAgMpmW1fybuYPxy2f0QowAHoxIPr0F4VoYQa2JZcWXuIUYJ
	DmYlEd42tuwMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6p
	BsbM5/t3yTtdOB+oIHqmv0Bnmzy30MNDryMaP37kfzGh/YtAvdL+KRmHdqtuKbjzk/Pfqa3V
	krM3twav+GEcGtm5hH+GSuExzq39p9x9J29lZM6bsfGN3bGku+1Zv5vX1Wsdco/l69HrKWuO
	ENv36OruaW3tkTvTk3fPdg0tTS4PZ2M+ciiZa7USS3FGoqEWc1FxIgASYitCIgIAAA==
X-CFilter-Loop: Reflected

This patch adds a new knob `detect_node_addresses`, which determines
whether the physical address range is set manually using the existing
knobs or automatically by the mtier module. When `detect_node_addresses`
set to 'Y', mtier automatically converts node0 and node1 to their
physical addresses. If set to 'N', it uses the existing
'node#_start_addr' and 'node#_end_addr' to define regions as before.

Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
---
V2 -> V3: Removed an unusable comment
V1 -> V2: Removed second patch, added a new knob, and cleand up code
---
 samples/damon/mtier.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index f3220d6e6739..3a6ae78efafe 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -42,8 +42,33 @@ static bool enable __read_mostly;
 module_param_cb(enable, &enable_param_ops, &enable, 0600);
 MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
 
+static bool detect_node_addresses __read_mostly;
+module_param(detect_node_addresses, bool, 0600);
+
 static struct damon_ctx *ctxs[2];
 
+struct region_range {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static int nid_to_phys(int target_node, struct region_range *range)
+{
+
+	if (!node_online(target_node)) {
+		pr_err("NUMA node %d is not online\n", target_node);
+		return -EINVAL;
+	}
+
+	unsigned long start_pfn = node_start_pfn(target_node);
+	unsigned long end_pfn   = node_end_pfn(target_node);
+
+	range->start = PFN_PHYS(start_pfn);
+	range->end  = PFN_PHYS(end_pfn);
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 {
 	struct damon_ctx *ctx;
@@ -53,6 +78,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
+	struct region_range addr;
+	int ret;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -82,9 +109,17 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	region = damon_new_region(
-			promote ? node1_start_addr : node0_start_addr,
-			promote ? node1_end_addr : node0_end_addr);
+
+	if (detect_node_addresses) {
+		ret = promote ? nid_to_phys(1, &addr) : nid_to_phys(0, &addr);
+		if (ret)
+			goto free_out;
+	} else {
+		addr.start = promote ? node1_start_addr : node0_start_addr;
+		addr.end = promote ? node1_end_addr : node0_end_addr;
+	}
+
+	region = damon_new_region(addr.start, addr.end);
 	if (!region)
 		goto free_out;
 	damon_add_region(region, target);

base-commit: db16fe88cdf83a1e7fdf75de282025b6ad61d08f
-- 
2.34.1


