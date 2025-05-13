Return-Path: <linux-kernel+bounces-646315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E694AB5AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDE4688CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0BF2BFC94;
	Tue, 13 May 2025 17:17:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A252BFC83
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156625; cv=none; b=GpLTkzu15PDag7yU83efe0TzCDikvVVdHA2gCQldoaou2I6t/1lLRtRCTpPbce4smoPK/E2GocLX1till7rO5SPnV8UGhPQtrNQW0ZRQ67rpndQ+yVEn/SEiKwdtgzd2ESTF8+bA5ifwDIM5tFtf553nyoLhF256NoJVhAQIL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156625; c=relaxed/simple;
	bh=G81gxAfIts5Zfp6FmLvKU8oH3SDzlV65iw95ZKcgRLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bR5YcyH/9kLmaqZe1PGbYFQ3MRH6NvVMUXC3K+A5j6NIRrFZpGwi5X+Frj4c99QSPmpGcsSui1CPsMEmqTgxRQf6Ic25PpTxxaUK3DXQdacmvmzbPv1MKUcjwoH28vpa7L/+VQWFPpdZVGjIOgKHXEGe1Y2YkBSNU/aZ2VECTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 010CE2944;
	Tue, 13 May 2025 10:16:52 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 767D13F63F;
	Tue, 13 May 2025 10:16:59 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
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
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v11 10/30] x86/resctrl: Move is_mba_sc() out of core.c
Date: Tue, 13 May 2025 17:15:27 +0000
Message-Id: <20250513171547.15194-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250513171547.15194-1-james.morse@arm.com>
References: <20250513171547.15194-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_mba_sc() is defined in core.c, but has no callers there. It does
not access any architecture private structures.

Move this to rdtgroup.c where the majority of callers are. This makes
the move of the filesystem code to /fs/ cleaner.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 ---------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 31538c65d9a2..58d7c6accdf2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -164,21 +164,6 @@ static inline void cache_alloc_hsw_probe(void)
 	rdt_alloc_capable = true;
 }
 
-bool is_mba_sc(struct rdt_resource *r)
-{
-	if (!r)
-		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	/*
-	 * The software controller support is only applicable to MBA resource.
-	 * Make sure to check for resource type.
-	 */
-	if (r->rid != RDT_RESOURCE_MBA)
-		return false;
-
-	return r->membw.mba_sc;
-}
-
 /*
  * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
  * exposed to user interface and the h/w understandable delay values.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cfd846cc861e..e2999f668593 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1535,6 +1535,21 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	return size;
 }
 
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid != RDT_RESOURCE_MBA)
+		return false;
+
+	return r->membw.mba_sc;
+}
+
 /*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *
-- 
2.39.5


