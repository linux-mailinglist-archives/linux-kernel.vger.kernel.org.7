Return-Path: <linux-kernel+bounces-650091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A3AB8D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B019E4FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C60255E40;
	Thu, 15 May 2025 17:00:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12234255E34
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328425; cv=none; b=W8ocQxnf5nM08Zowq6MsJOClSy5/h/t4LF9M2StARC8MXspNuh+Mjrc6Xojq1NFRTuJ7EMM6YmL36Q5HelwJt2LoxeAN7oOCLVXnFz0KCwstoqVIS/1Rt58I1aqJjh01wu8zx2GYWn2F5ai8WNqLUISp0X1AxFL4QHUJ2C16t34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328425; c=relaxed/simple;
	bh=V1+OOYM4WhW9BwqjO0gABY2KtCsMRpjmC8CJ+YZwYHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtkxTwWvkaZLxy5Prv0IF1euaq/ttDgXrP2l2qNiHtajcO086nDsgrnL0ZcJlGDYv8h2VHxnznsgzohWlC52URn39+ozyzFJvfSnDL10f9OROOt+YhRERie129wbXPwjld7uvq0vXt1ruW1DuAFZ1ql5ux5nejlkSZwxFBokwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE0A266C;
	Thu, 15 May 2025 10:00:11 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3702F3F63F;
	Thu, 15 May 2025 10:00:20 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v12 19/25] x86/resctrl: Move pseudo lock prototypes to include/linux/resctrl.h
Date: Thu, 15 May 2025 16:58:49 +0000
Message-Id: <20250515165855.31452-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250515165855.31452-1-james.morse@arm.com>
References: <20250515165855.31452-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl pseudo-lock feature allows an architecture to allocate data
into particular cache portions, which are then treated as reserved to
avoid that data ever being evicted. Setting this up is deeply architecture
specific as it involves disabling prefetchers etc. It is not possible
to support this kind of feature on arm64. Risc-V is assumed to be the
same.

The prototypes for the architecture code were added to x86's asm/resctrl.h,
with other architectures able to provide stubs for their architecture. This
forces other architectures to provide identical stubs.

Move the prototypes and stubs to linux/resctrl.h, and switch between them
using the existing Kconfig symbol.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
I'm assuming risc-v's hardware prefetcher controls are restricted to the
higehst privilege level, and that this isn't where linux runs.

Changes since v9:
 * Typo fix in commit message.

Changse since v8:
 * This patch is new.
---
 arch/x86/include/asm/resctrl.h |  5 -----
 include/linux/resctrl.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index a2e20fe90a2c..ad497ab196d1 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -205,11 +205,6 @@ static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
 					     enum resctrl_event_id evtid,
 					     void *ctx) { }
 
-u64 resctrl_arch_get_prefetch_disable_bits(void);
-int resctrl_arch_pseudo_lock_fn(void *_plr);
-int resctrl_arch_measure_cycles_lat_fn(void *_plr);
-int resctrl_arch_measure_l2_residency(void *_plr);
-int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5ef972cbf56b..9ba771f2ddea 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -534,4 +534,17 @@ extern unsigned int resctrl_rmid_realloc_limit;
 int resctrl_init(void);
 void resctrl_exit(void);
 
+#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
+u64 resctrl_arch_get_prefetch_disable_bits(void);
+int resctrl_arch_pseudo_lock_fn(void *_plr);
+int resctrl_arch_measure_cycles_lat_fn(void *_plr);
+int resctrl_arch_measure_l2_residency(void *_plr);
+int resctrl_arch_measure_l3_residency(void *_plr);
+#else
+static inline u64 resctrl_arch_get_prefetch_disable_bits(void) { return 0; }
+static inline int resctrl_arch_pseudo_lock_fn(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_cycles_lat_fn(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l2_residency(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l3_residency(void *_plr) { return 0; }
+#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
 #endif /* _RESCTRL_H */
-- 
2.39.5


