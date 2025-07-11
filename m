Return-Path: <linux-kernel+bounces-728096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED3B0239E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1525A45F21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A82F2C59;
	Fri, 11 Jul 2025 18:28:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904F2F2735
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258486; cv=none; b=DHzSp6lNbSkwNECOll9PhjklxOpRMs/QErB7pIYoD3QJ2mPRbwSZpYGCqU6jK3icXaVLYI+Z1CdL/ZmOU3XKhKzc9r0irP439H/lS9dr8OYZPK3Jor3GaGP4hE4RY+G49J/c4MYDn1S8GAf/2+NblZs874Y7CfZPtLF354e37Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258486; c=relaxed/simple;
	bh=HhO0vZzQeCk5EqLreeMWz0xGjraCaocXoe2rSjgbtL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0jCMscn6mMmHXep9PVLhudmu1IROLSFGTvhVO67Q3QkP7Df1pflWQdYW++M0p4cUMy/U1VzUjQjzxuXH0Mprz1A2CD39DjthrBlvzGWGzZGbBBbYMcFnU4N2xqpRHERLI/Vqy5/GqbJnn/c9s2mXpvqzgB1JCWj+PwdoPKLHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A95F16F8;
	Fri, 11 Jul 2025 11:27:54 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C1B3F694;
	Fri, 11 Jul 2025 11:28:03 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: cacheinfo: Provide helper to compress MPIDR value into u32
Date: Fri, 11 Jul 2025 18:27:43 +0000
Message-Id: <20250711182743.30141-4-james.morse@arm.com>
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
device-tree, but instead generated from the smallest MPIDR of the CPUs
associated with that cache. The cache-id exposed to user-space has
historically been 32 bits.

MPIDR values may be larger than 32 bits.

MPIDR only has 32 bits worth of affinity data, but the aff3 field lives
above 32bits. The corresponding lower bits are masked out by
MPIDR_HWID_BITMASK and contain an SMT flag and Uni-Processor flag.

Swizzzle the aff3 field into the bottom 32 bits and using that.

In case more affinity fields are added in the future, the upper RES0
area should be checked. Returning a value greater than 32 bits from
this helper will cause the caller to give up on allocating cache-ids.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
Changes since v1:
 * Removal of unrelated changes.
 * Added a comment about how the RES0 bit safety net works.
---
 arch/arm64/include/asm/cache.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 99cd6546e72e..09963004ceea 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -87,6 +87,23 @@ int cache_line_size(void);
 
 #define dma_get_cache_alignment	cache_line_size
 
+/* Compress a u64 MPIDR value into 32 bits. */
+static inline u64 arch_compact_of_hwid(u64 id)
+{
+	u64 aff3 = MPIDR_AFFINITY_LEVEL(id, 3);
+
+	/*
+	 * These bits are expected to be RES0. If not, return a value with
+	 * the upper 32 bits set to force the caller to give up on 32 bit
+	 * cache ids.
+	 */
+	if (FIELD_GET(GENMASK_ULL(63, 40), id))
+		return id;
+
+	return (aff3 << 24) | FIELD_GET(GENMASK_ULL(23, 0), id);
+}
+#define arch_compact_of_hwid	arch_compact_of_hwid
+
 /*
  * Read the effective value of CTR_EL0.
  *
-- 
2.39.5


