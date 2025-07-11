Return-Path: <linux-kernel+bounces-728095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27956B0239D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A078E5C2C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C32F3C20;
	Fri, 11 Jul 2025 18:28:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5392F2C59
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258485; cv=none; b=PYBelQ7llYAJlvkhjMrwRs5xcXq0TgP5RhFDSN8em9ot5RcdRIq91JaPLW4w0sN7o1L03OmWRSV9Sj+FHkjgEAOPhB34BUJJNuiIIsCp/yg2pW4LvMAXXpL7WYFTDuO21oWq8LTRAEYnu/WJBoXmR6T9Z+5Cs/h/09gtaG2xFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258485; c=relaxed/simple;
	bh=9x9PilFONQWWYbv66+95zCNvRtyXLcqG3l47B6IPVWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMQCBdXUEBgU9ykE88eVB2BV6Nukg1jWf34qTHVT0lLgVC56YE7nfuspHbNUN/2Y9zQQmiTbvAJQr16hrunAbE0AK3AvoOwuL28ccGTYB8l2A+1aWI/nhcTVj0YzJKGtOq54y2X2rrElSfIey4A1eRi4R7HM3/XPrD2exArds8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD592682;
	Fri, 11 Jul 2025 11:27:52 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77063F694;
	Fri, 11 Jul 2025 11:28:01 -0700 (PDT)
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
Subject: [PATCH v3 2/3] cacheinfo: Add arch hook to compress CPU h/w id into 32 bits for cache-id
Date: Fri, 11 Jul 2025 18:27:42 +0000
Message-Id: <20250711182743.30141-3-james.morse@arm.com>
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


