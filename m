Return-Path: <linux-kernel+bounces-728094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E636BB0239C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4ECA44A40
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B72F3C00;
	Fri, 11 Jul 2025 18:28:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434B2F2735
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258483; cv=none; b=dfNjGtHBm3CNkxwocFu3r8hKcNnoFtDccx0BPtCaZ5t5q1PEuoGPYbESSPD/+/LjRZIK/DmsHkTjm99fjnaruSs2WL/GZ3IZ4pmYrZF4wIQhuhJ7XJXvxKkkmDy2+98LGBnd+UZ0mUSvppxPexnEPCL6M7+DspHHWk7bmjR4Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258483; c=relaxed/simple;
	bh=y6aD52A/GXoakeVI754gL5ggJpeMARSE2Wq/EOMb1y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6tqR1vYUTlyMS/SBPVGBs/a5JmlR+eX7Utm2rFZ4Zs+b/q67X45Hx1qAXmhQmrxxKUB9IeJCHftX5ztuQzihYrknMFEWKH4fh6OY4OhxjrAhXIbZEmlu+7RTWWB2WUyaUKyQ9fuMOzPbUzd1oGztBPrDsHt8xx7E7l+TTw8usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65942247;
	Fri, 11 Jul 2025 11:27:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCF1C3F694;
	Fri, 11 Jul 2025 11:27:59 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	sudeep.holla@arm.com,
	Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 1/3] cacheinfo: Set cache 'id' based on DT data
Date: Fri, 11 Jul 2025 18:27:41 +0000
Message-Id: <20250711182743.30141-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711182743.30141-1-james.morse@arm.com>
References: <20250711182743.30141-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

Use the minimum CPU h/w id of the CPUs associated with the cache for the
cache 'id'. This will provide a stable id value for a given system. As
we need to check all possible CPUs, we can't use the shared_cpu_map
which is just online CPUs. As there's not a cache to CPUs mapping in DT,
we have to walk all CPU nodes and then walk cache levels.

The cache_id exposed to user-space has historically been 32 bits, and
is too late to change. This value is parsed into a u32 by user-space
libraries such as libvirt:
https://github.com/libvirt/libvirt/blob/master/src/util/virresctrl.c#L1588

Give up on assigning cache-id's if a CPU h/w id greater than 32 bits
is found.

match_cache_node() does not make use of the __free() cleanup helpers
because of_find_next_cache_node(prev) does not drop a reference to prev,
and its too easy to accidentally drop the reference on cpu, which belongs
to for_each_of_cpu_node().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
[ ben: converted to use the __free cleanup idiom ]
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
[ morse: Add checks to give up if a value larger than 32 bits is seen. ]
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
Use as a 32bit value has also been seen in DPDK patches here:
http://inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vithanage@arm.com/

Changes since v2:
 * Removed broken use of cleanup in the match helper

Changes since v1:
 * Remove the second loop in favour of a helper.
---
 drivers/base/cacheinfo.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cf0d455209d7..4e2f60c85e74 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cacheinfo.h>
 #include <linux/compiler.h>
@@ -183,6 +184,49 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
 	return of_property_read_bool(np, "cache-unified");
 }
 
+static bool match_cache_node(struct device_node *cpu,
+			     const struct device_node *cache_node)
+{
+	struct device_node *prev, *cache = of_find_next_cache_node(cpu);
+
+	while (cache) {
+		if (cache == cache_node) {
+			of_node_put(cache);
+			return true;
+		}
+
+		prev = cache;
+		cache = of_find_next_cache_node(cache);
+		of_node_put(prev);
+	}
+
+	return false;
+}
+
+static void cache_of_set_id(struct cacheinfo *this_leaf,
+			    struct device_node *cache_node)
+{
+	struct device_node *cpu;
+	u32 min_id = ~0;
+
+	for_each_of_cpu_node(cpu) {
+		u64 id = of_get_cpu_hwid(cpu, 0);
+
+		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
+			of_node_put(cpu);
+			return;
+		}
+
+		if (match_cache_node(cpu, cache_node))
+			min_id = min(min_id, id);
+	}
+
+	if (min_id != ~0) {
+		this_leaf->id = min_id;
+		this_leaf->attributes |= CACHE_ID;
+	}
+}
+
 static void cache_of_set_props(struct cacheinfo *this_leaf,
 			       struct device_node *np)
 {
@@ -198,6 +242,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 	cache_get_line_size(this_leaf, np);
 	cache_nr_sets(this_leaf, np);
 	cache_associativity(this_leaf);
+	cache_of_set_id(this_leaf, np);
 }
 
 static int cache_setup_of_node(unsigned int cpu)
-- 
2.39.5


