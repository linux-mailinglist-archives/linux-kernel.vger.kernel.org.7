Return-Path: <linux-kernel+bounces-728137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA14B023EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F195C654A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76452F5C45;
	Fri, 11 Jul 2025 18:38:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FD2F5C43
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259085; cv=none; b=Xy4RIfftZo2on0UcFkH26Q3AyyQ5gPyqmqWfND9SbuKuGb2GOwHsQaeeFy1r9nW3ON9gn/B9suwBLXNoND59PumWRnzXis5L6dW26ORm9x/dxNRFib8LjO7NLo9WLVVS0mvKNEYDJBhdo28LGzLoIhaEYmv/dRNwPC0er1J71w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259085; c=relaxed/simple;
	bh=dylE9M6mX1qa3r1GLkwNOqdLg2/wO4l4fezuGCcMhN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lsy8fTa8qa6MH0PuPoCb6TFmxhlNqSgd2iVx5blGX8GltHrOaCaAYAn+HSN7ATwxNPCrXhyISlpGl8pW6gVEmi/Sqb9gIH0MIEOhO5W33jB0/EXWsLWX+rMf7I2emjdRlfsl8CP5pQ27HJ4ru2hWQzNBMnHIzs739RYsWoXMLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8001F16F8;
	Fri, 11 Jul 2025 11:37:52 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1970D3F694;
	Fri, 11 Jul 2025 11:37:59 -0700 (PDT)
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
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 18/36] arm_mpam: Probe MSCs to find the supported partid/pmg values
Date: Fri, 11 Jul 2025 18:36:30 +0000
Message-Id: <20250711183648.30766-19-james.morse@arm.com>
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

CPUs can generate traffic with a range of PARTID and PMG values,
but each MSC may have its own maximum size for these fields.
Before MPAM can be used, the driver needs to probe each RIS on
each MSC, to find the system-wide smallest value that can be used.

While doing this, RIS entries that firmware didn't describe are create
under MPAM_CLASS_UNKNOWN.

While we're here, implement the mpam_register_requestor() call
for the arch code. Future callers of this will tell us about the
SMMU and ITS.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 172 +++++++++++++++++++-
 drivers/platform/arm64/mpam/mpam_internal.h |   6 +
 include/linux/arm_mpam.h                    |  14 ++
 3 files changed, 185 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 89434ae3efa6..8646fb85ad09 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/arm_mpam.h>
+#include <linux/bitfield.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -44,6 +45,15 @@ static u32 mpam_num_msc;
 static int mpam_cpuhp_state;
 static DEFINE_MUTEX(mpam_cpuhp_state_lock);
 
+/*
+ * The smallest common values for any CPU or MSC in the system.
+ * Generating traffic outside this range will result in screaming interrupts.
+ */
+u16 mpam_partid_max;
+u8 mpam_pmg_max;
+static bool partid_max_init, partid_max_published;
+static DEFINE_SPINLOCK(partid_max_lock);
+
 /*
  * mpam is enabled once all devices have been probed from CPU online callbacks,
  * scheduled via this work_struct. If access to an MSC depends on a CPU that
@@ -106,6 +116,74 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
 
 #define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
 
+static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
+
+	writel_relaxed(val, msc->mapped_hwpage + reg);
+}
+
+static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
+{
+	lockdep_assert_held_once(&msc->part_sel_lock);
+	__mpam_write_reg(msc, reg, val);
+}
+#define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
+
+static u64 mpam_msc_read_idr(struct mpam_msc *msc)
+{
+	u64 idr_high = 0, idr_low;
+
+	lockdep_assert_held(&msc->part_sel_lock);
+
+	idr_low = mpam_read_partsel_reg(msc, IDR);
+	if (FIELD_GET(MPAMF_IDR_HAS_EXT, idr_low))
+		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
+
+	return (idr_high << 32) | idr_low;
+}
+
+static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
+{
+	lockdep_assert_held(&msc->part_sel_lock);
+
+	mpam_write_partsel_reg(msc, PART_SEL, partsel);
+}
+
+static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
+{
+	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
+		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
+
+	__mpam_part_sel_raw(partsel, msc);
+}
+
+int mpam_register_requestor(u16 partid_max, u8 pmg_max)
+{
+	int err = 0;
+
+	lockdep_assert_irqs_enabled();
+
+	spin_lock(&partid_max_lock);
+	if (!partid_max_init) {
+		mpam_partid_max = partid_max;
+		mpam_pmg_max = pmg_max;
+		partid_max_init = true;
+	} else if (!partid_max_published) {
+		mpam_partid_max = min(mpam_partid_max, partid_max);
+		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
+	} else {
+		/* New requestors can't lower the values */
+		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
+			err = -EBUSY;
+	}
+	spin_unlock(&partid_max_lock);
+
+	return err;
+}
+EXPORT_SYMBOL(mpam_register_requestor);
+
 #define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
 
 static struct mpam_vmsc *
@@ -522,6 +600,7 @@ static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
 	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
 	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
 	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
+	list_add_rcu(&ris->msc_list, &msc->ris);
 
 	return 0;
 }
@@ -541,10 +620,37 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 	return err;
 }
 
+static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
+						   u8 ris_idx)
+{
+	int err;
+	struct mpam_msc_ris *ris, *found = ERR_PTR(-ENOENT);
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	if (!test_bit(ris_idx, msc->ris_idxs)) {
+		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
+					     0, 0, GFP_ATOMIC);
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	list_for_each_entry(ris, &msc->ris, msc_list) {
+		if (ris->ris_idx == ris_idx) {
+			found = ris;
+			break;
+		}
+	}
+
+	return found;
+}
+
 static int mpam_msc_hw_probe(struct mpam_msc *msc)
 {
 	u64 idr;
-	int err;
+	u16 partid_max;
+	u8 ris_idx, pmg_max;
+	struct mpam_msc_ris *ris;
 
 	lockdep_assert_held(&msc->probe_lock);
 
@@ -553,14 +659,42 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
 		pr_err_once("%s does not match MPAM architecture v1.0\n",
 			    dev_name(&msc->pdev->dev));
-		err = -EIO;
-	} else {
-		msc->probed = true;
-		err = 0;
+		mutex_unlock(&msc->part_sel_lock);
+		return -EIO;
 	}
+
+	idr = mpam_msc_read_idr(msc);
 	mutex_unlock(&msc->part_sel_lock);
+	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
 
-	return err;
+	/* Use these values so partid/pmg always starts with a valid value */
+	msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
+	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
+
+	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
+		mutex_lock(&msc->part_sel_lock);
+		__mpam_part_sel(ris_idx, 0, msc);
+		idr = mpam_msc_read_idr(msc);
+		mutex_unlock(&msc->part_sel_lock);
+
+		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
+		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
+		msc->partid_max = min(msc->partid_max, partid_max);
+		msc->pmg_max = min(msc->pmg_max, pmg_max);
+
+		ris = mpam_get_or_create_ris(msc, ris_idx);
+		if (IS_ERR(ris))
+			return PTR_ERR(ris);
+	}
+
+	spin_lock(&partid_max_lock);
+	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
+	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
+	spin_unlock(&partid_max_lock);
+
+	msc->probed = true;
+
+	return 0;
 }
 
 static int mpam_cpu_online(unsigned int cpu)
@@ -907,9 +1041,18 @@ static void mpam_enable_once(void)
 	mpam_cpuhp_state = 0;
 	mutex_unlock(&mpam_cpuhp_state_lock);
 
+	/*
+	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
+	 * longer change.
+	 */
+	spin_lock(&partid_max_lock);
+	partid_max_published = true;
+	spin_unlock(&partid_max_lock);
+
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
 
-	pr_info("MPAM enabled\n");
+	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
+	       mpam_partid_max + 1, mpam_pmg_max + 1);
 }
 
 /*
@@ -959,11 +1102,25 @@ static void mpam_dt_create_foundling_msc(void)
 
 static int __init mpam_msc_driver_init(void)
 {
+	bool mpam_not_available = false;
+
 	if (!system_supports_mpam())
 		return -EOPNOTSUPP;
 
 	init_srcu_struct(&mpam_srcu);
 
+	/*
+	 * If the MPAM CPU interface is not implemented, or reserved by
+	 * firmware, there is no point touching the rest of the hardware.
+	 */
+	spin_lock(&partid_max_lock);
+	if (!partid_max_init || (!mpam_partid_max && !mpam_pmg_max))
+		mpam_not_available = true;
+	spin_unlock(&partid_max_lock);
+
+	if (mpam_not_available)
+		return 0;
+
 	if (!acpi_disabled)
 		fw_num_msc = acpi_mpam_count_msc();
 	else
@@ -979,4 +1136,5 @@ static int __init mpam_msc_driver_init(void)
 
 	return platform_driver_register(&mpam_msc_driver);
 }
+/* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
 subsys_initcall(mpam_msc_driver_init);
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index f56e69ff8397..eb5cc6775d54 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -50,6 +50,8 @@ struct mpam_msc {
 	 */
 	struct mutex		probe_lock;
 	bool			probed;
+	u16			partid_max;
+	u8			pmg_max;
 	unsigned long		ris_idxs[128 / BITS_PER_LONG];
 	u32			ris_max;
 
@@ -148,6 +150,10 @@ struct mpam_msc_ris {
 extern struct srcu_struct mpam_srcu;
 extern struct list_head mpam_classes;
 
+/* System wide partid/pmg values */
+extern u16 mpam_partid_max;
+extern u8 mpam_pmg_max;
+
 /* Scheduled work callback to enable mpam once all MSC have been probed */
 void mpam_enable(struct work_struct *work);
 
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index 406a77be68cb..8af93794c7a2 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -39,4 +39,18 @@ static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
 int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 		    enum mpam_class_types type, u8 class_id, int component_id);
 
+/**
+ * mpam_register_requestor() - Register a requestor with the MPAM driver
+ * @partid_max:		The maximum PARTID value the requestor can generate.
+ * @pmg_max:		The maximum PMG value the requestor can generate.
+ *
+ * Registers a requestor with the MPAM driver to ensure the chosen system-wide
+ * minimum PARTID and PMG values will allow the requestors features to be used.
+ *
+ * Returns an error if the registration is too late, and a larger PARTID/PMG
+ * value has been advertised to user-space. In this case the requestor should
+ * not use its MPAM features. Returns 0 on success.
+ */
+int mpam_register_requestor(u16 partid_max, u8 pmg_max);
+
 #endif /* __LINUX_ARM_MPAM_H */
-- 
2.39.5


