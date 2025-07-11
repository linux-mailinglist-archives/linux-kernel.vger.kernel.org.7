Return-Path: <linux-kernel+bounces-728120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F036B023D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278CFB4669A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A602F3C16;
	Fri, 11 Jul 2025 18:37:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC80199FAB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259032; cv=none; b=uggUeU5lqzVf0GH84PKSb3+wgEJJqfysOrUXii8UG99m4jgYlDah4nPFIdWoiBb90As0akMQQ1RhVK+YdaXWf5QZomycrQYAzVm1d5ucZc3ktC63yGcYMmCsB6lq3m5iAfv7ur72HVQ+iF+nXYuOy39+WDSSlX4wlKIHu9trnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259032; c=relaxed/simple;
	bh=9x9PilFONQWWYbv66+95zCNvRtyXLcqG3l47B6IPVWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1gGYipwn6RjsryWpZTI2E+mPLviKEu5B6Wk99PNRXPawkJnl6yHRPu5GmWgOWmdq74zpuaRvg6O2Bmlp0SpVBh8FiQ1vwOGTvQLFvLScfE7ek1+dLCl1J9OrvvpFwsNiRQgT/d/kBd+gCo35PhMh8eBP4MqNEyAGqkFPHPcNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 981FE2247;
	Fri, 11 Jul 2025 11:36:59 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFF863F694;
	Fri, 11 Jul 2025 11:37:06 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>
Subject: [RFC PATCH 02/36] cacheinfo: Add arch hook to compress CPU h/w id into 32 bits for cache-id
Date: Fri, 11 Jul 2025 18:36:14 +0000
Message-Id: <20250711183648.30766-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystems like resctrl use the cache-id exposed via sysfs to identify
groups of CPUs. The value is also used for PCIe cache steering tags. On
DT platforms cache-id is not something that is described in the
device-tree, but instead generated from the smallest CPU h/w id of the
CPUs associated with that cache.

CPU h/w ids may be larger than 32 bits.

Add a hook to allow architectures to compress the value from the devicetree
into 32 bits. Returning the same value is always safe as cache_of_set_id()
will stop if a value larger than 32 bits is seen.

For example, on arm64 the value is the MPIDR affinity register, which only
has 32 bits of affinity data, but spread accross the 64 bit field. An
arch-specific bit swizzle gives a 32 bit value.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/cacheinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 4e2f60c85e74..613410705a47 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -203,6 +203,10 @@ static bool match_cache_node(struct device_node *cpu,
 	return false;
 }
 
+#ifndef arch_compact_of_hwid
+#define arch_compact_of_hwid(_x)	(_x)
+#endif
+
 static void cache_of_set_id(struct cacheinfo *this_leaf,
 			    struct device_node *cache_node)
 {
@@ -212,6 +216,7 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
 	for_each_of_cpu_node(cpu) {
 		u64 id = of_get_cpu_hwid(cpu, 0);
 
+		id = arch_compact_of_hwid(id);
 		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
 			of_node_put(cpu);
 			return;
-- 
2.39.5


