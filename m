Return-Path: <linux-kernel+bounces-728146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CEFB023F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A9EB61543
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DD2F49F7;
	Fri, 11 Jul 2025 18:38:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E22F85FA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259108; cv=none; b=epcUutY/6IPpb4o9Qka37wyGnNoa5s536+oDvcoxkyT9J1PPXxgwL5ZxOIGLwK7T5GA+vGQLwwo2waKPXoJmpLw/C+FH9M0d7n1Nrnex/jlGPTaf6oghp92bQD9JgVc+GJa1EFafyH9fPoVHWJA7VMnNw6oOdtfLCRlVNF6zneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259108; c=relaxed/simple;
	bh=6/tJUbwmGdyneumNks9BkhVkH+D8jUmcAg+IKaUvvaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASy7BSXg8EyRV0mjLXlOfzIstJIpNhZSy4+W1T0lbX4yhglfVlSLBTXQQ/W/4u0SksvCF0qBjkOmoHRji3wjE3ZofFQdHxgcgGpJOTKTH4CwOI0Q8MmHYXnFI+2VFvPpDfgFMsE+K7fRsTU2ihLGLdH2kxlp28a18ZIcrBjd3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE9B2247;
	Fri, 11 Jul 2025 11:38:15 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D742E3F694;
	Fri, 11 Jul 2025 11:38:22 -0700 (PDT)
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
Subject: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
Date: Fri, 11 Jul 2025 18:36:37 +0000
Message-Id: <20250711183648.30766-26-james.morse@arm.com>
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

Register and enable error IRQs. All the MPAM error interrupts indicate a
software bug, e.g. out of range partid. If the error interrupt is ever
signalled, attempt to disable MPAM.

Only the irq handler accesses the ESR register, so no locking is needed.
The work to disable MPAM after an error needs to happen at process
context, use a threaded interrupt.

There is no support for percpu threaded interrupts, for now schedule
the work to be done from the irq handler.

Enabling the IRQs in the MSC may involve cross calling to a CPU that
can access the MSC.

CC: Rohit Mathew <rohit.mathew@arm.com>
Tested-by: Rohit Mathew <rohit.mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 304 +++++++++++++++++++-
 drivers/platform/arm64/mpam/mpam_internal.h |   9 +-
 2 files changed, 307 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 145535cd4732..af19cc25d16e 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -14,6 +14,9 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
@@ -62,6 +65,12 @@ static DEFINE_SPINLOCK(partid_max_lock);
  */
 static DECLARE_WORK(mpam_enable_work, &mpam_enable);
 
+/*
+ * All mpam error interrupts indicate a software bug. On receipt, disable the
+ * driver.
+ */
+static DECLARE_WORK(mpam_broken_work, &mpam_disable);
+
 /*
  * An MSC is a physical container for controls and monitors, each identified by
  * their RIS index. These share a base-address, interrupts and some MMIO
@@ -159,6 +168,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc *msc)
 	return (idr_high << 32) | idr_low;
 }
 
+static void mpam_msc_zero_esr(struct mpam_msc *msc)
+{
+	__mpam_write_reg(msc, MPAMF_ESR, 0);
+	if (msc->has_extd_esr)
+		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
+}
+
+static u64 mpam_msc_read_esr(struct mpam_msc *msc)
+{
+	u64 esr_high = 0, esr_low;
+
+	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
+	if (msc->has_extd_esr)
+		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
+
+	return (esr_high << 32) | esr_low;
+}
+
 static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
 {
 	lockdep_assert_held(&msc->part_sel_lock);
@@ -405,12 +432,12 @@ static void mpam_msc_destroy(struct mpam_msc *msc)
 
 	lockdep_assert_held(&mpam_list_lock);
 
-	list_del_rcu(&msc->glbl_list);
-	platform_set_drvdata(pdev, NULL);
-
 	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
 		mpam_ris_destroy(ris);
 
+	list_del_rcu(&msc->glbl_list);
+	platform_set_drvdata(pdev, NULL);
+
 	add_to_garbage(msc);
 	msc->garbage.pdev = pdev;
 }
@@ -828,6 +855,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
 		msc->partid_max = min(msc->partid_max, partid_max);
 		msc->pmg_max = min(msc->pmg_max, pmg_max);
+		msc->has_extd_esr = FIELD_GET(MPAMF_IDR_HAS_EXT_ESR, idr);
 
 		ris = mpam_get_or_create_ris(msc, ris_idx);
 		if (IS_ERR(ris))
@@ -974,6 +1002,13 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	mpam_mon_sel_outer_unlock(msc);
 }
 
+static void _enable_percpu_irq(void *_irq)
+{
+	int *irq = _irq;
+
+	enable_percpu_irq(*irq, IRQ_TYPE_NONE);
+}
+
 static int mpam_cpu_online(unsigned int cpu)
 {
 	int idx;
@@ -984,6 +1019,9 @@ static int mpam_cpu_online(unsigned int cpu)
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
 			continue;
 
+		if (msc->reenable_error_ppi)
+			_enable_percpu_irq(&msc->reenable_error_ppi);
+
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
 			mpam_reset_msc(msc, true);
 	}
@@ -1032,6 +1070,9 @@ static int mpam_cpu_offline(unsigned int cpu)
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
 			continue;
 
+		if (msc->reenable_error_ppi)
+			disable_percpu_irq(msc->reenable_error_ppi);
+
 		if (atomic_dec_and_test(&msc->online_refs))
 			mpam_reset_msc(msc, false);
 	}
@@ -1058,6 +1099,51 @@ static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
 	mutex_unlock(&mpam_cpuhp_state_lock);
 }
 
+static int __setup_ppi(struct mpam_msc *msc)
+{
+	int cpu;
+
+	msc->error_dev_id = alloc_percpu_gfp(struct mpam_msc *, GFP_KERNEL);
+	if (!msc->error_dev_id)
+		return -ENOMEM;
+
+	for_each_cpu(cpu, &msc->accessibility) {
+		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
+
+		if (empty) {
+			pr_err_once("%s shares PPI with %s!\n",
+				    dev_name(&msc->pdev->dev),
+				    dev_name(&empty->pdev->dev));
+			return -EBUSY;
+		}
+		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
+	}
+
+	return 0;
+}
+
+static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
+{
+	int irq;
+
+	irq = platform_get_irq_byname_optional(msc->pdev, "error");
+	if (irq <= 0)
+		return 0;
+
+	/* Allocate and initialise the percpu device pointer for PPI */
+	if (irq_is_percpu(irq))
+		return __setup_ppi(msc);
+
+	/* sanity check: shared interrupts can be routed anywhere? */
+	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
+		pr_err_once("msc:%u is a private resource with a shared error interrupt",
+			    msc->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mpam_dt_count_msc(void)
 {
 	int count = 0;
@@ -1266,6 +1352,10 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
 			break;
 		}
 
+		err = mpam_msc_setup_error_irq(msc);
+		if (err)
+			break;
+
 		if (device_property_read_u32(&pdev->dev, "pcc-channel",
 					     &msc->pcc_subspace_id))
 			msc->iface = MPAM_IFACE_MMIO;
@@ -1548,11 +1638,193 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
 	}
 }
 
+static char *mpam_errcode_names[16] = {
+	[0] = "No error",
+	[1] = "PARTID_SEL_Range",
+	[2] = "Req_PARTID_Range",
+	[3] = "MSMONCFG_ID_RANGE",
+	[4] = "Req_PMG_Range",
+	[5] = "Monitor_Range",
+	[6] = "intPARTID_Range",
+	[7] = "Unexpected_INTERNAL",
+	[8] = "Undefined_RIS_PART_SEL",
+	[9] = "RIS_No_Control",
+	[10] = "Undefined_RIS_MON_SEL",
+	[11] = "RIS_No_Monitor",
+	[12 ... 15] = "Reserved"
+};
+
+static int mpam_enable_msc_ecr(void *_msc)
+{
+	struct mpam_msc *msc = _msc;
+
+	__mpam_write_reg(msc, MPAMF_ECR, 1);
+
+	return 0;
+}
+
+static int mpam_disable_msc_ecr(void *_msc)
+{
+	struct mpam_msc *msc = _msc;
+
+	__mpam_write_reg(msc, MPAMF_ECR, 0);
+
+	return 0;
+}
+
+static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
+{
+	u64 reg;
+	u16 partid;
+	u8 errcode, pmg, ris;
+
+	if (WARN_ON_ONCE(!msc) ||
+	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &msc->accessibility)))
+		return IRQ_NONE;
+
+	reg = mpam_msc_read_esr(msc);
+
+	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
+	if (!errcode)
+		return IRQ_NONE;
+
+	/* Clear level triggered irq */
+	mpam_msc_zero_esr(msc);
+
+	partid = FIELD_GET(MPAMF_ESR_PARTID_OR_MON, reg);
+	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
+	ris = FIELD_GET(MPAMF_ESR_PMG, reg);
+
+	pr_err("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
+	       msc->id, mpam_errcode_names[errcode], partid, pmg, ris);
+
+	if (irq_is_percpu(irq)) {
+		mpam_disable_msc_ecr(msc);
+		schedule_work(&mpam_broken_work);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
+{
+	struct mpam_msc *msc = *(struct mpam_msc **)dev_id;
+
+	return __mpam_irq_handler(irq, msc);
+}
+
+static irqreturn_t mpam_spi_handler(int irq, void *dev_id)
+{
+	struct mpam_msc *msc = dev_id;
+
+	return __mpam_irq_handler(irq, msc);
+}
+
+static irqreturn_t mpam_disable_thread(int irq, void *dev_id);
+
+static int mpam_register_irqs(void)
+{
+	int err, irq, idx;
+	struct mpam_msc *msc;
+
+	lockdep_assert_cpus_held();
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
+		irq = platform_get_irq_byname_optional(msc->pdev, "error");
+		if (irq <= 0)
+			continue;
+
+		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
+		/* We anticipate sharing the interrupt with other MSCs */
+		if (irq_is_percpu(irq)) {
+			err = request_percpu_irq(irq, &mpam_ppi_handler,
+						 "mpam:msc:error",
+						 msc->error_dev_id);
+			if (err)
+				return err;
+
+			msc->reenable_error_ppi = irq;
+			smp_call_function_many(&msc->accessibility,
+					       &_enable_percpu_irq, &irq,
+					       true);
+		} else {
+			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
+							&mpam_spi_handler,
+							&mpam_disable_thread,
+							IRQF_SHARED,
+							"mpam:msc:error", msc);
+			if (err)
+				return err;
+		}
+
+		msc->error_irq_requested = true;
+		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
+		msc->error_irq_hw_enabled = true;
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+
+	return 0;
+}
+
+static void mpam_unregister_irqs(void)
+{
+	int irq, idx;
+	struct mpam_msc *msc;
+
+	cpus_read_lock();
+	/* take the lock as free_irq() can sleep */
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
+		irq = platform_get_irq_byname_optional(msc->pdev, "error");
+		if (irq <= 0)
+			continue;
+
+		if (msc->error_irq_hw_enabled) {
+			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
+			msc->error_irq_hw_enabled = false;
+		}
+
+		if (msc->error_irq_requested) {
+			if (irq_is_percpu(irq)) {
+				msc->reenable_error_ppi = 0;
+				free_percpu_irq(irq, msc->error_dev_id);
+			} else {
+				devm_free_irq(&msc->pdev->dev, irq, msc);
+			}
+			msc->error_irq_requested = false;
+		}
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+	cpus_read_unlock();
+}
+
 static void mpam_enable_once(void)
 {
+	int err;
+
+	/*
+	 * If all the MSC have been probed, enabling the IRQs happens next.
+	 * That involves cross-calling to a CPU that can reach the MSC, and
+	 * the locks must be taken in this order:
+	 */
+	cpus_read_lock();
 	mutex_lock(&mpam_list_lock);
 	mpam_enable_merge_features(&mpam_classes);
+
+	err = mpam_register_irqs();
+	if (err)
+		pr_warn("Failed to register irqs: %d\n", err);
+
 	mutex_unlock(&mpam_list_lock);
+	cpus_read_unlock();
+
+	if (err) {
+		schedule_work(&mpam_broken_work);
+		return;
+	}
 
 	mutex_lock(&mpam_cpuhp_state_lock);
 	cpuhp_remove_state(mpam_cpuhp_state);
@@ -1621,16 +1893,39 @@ static void mpam_reset_class(struct mpam_class *class)
  * All of MPAMs errors indicate a software bug, restore any modified
  * controls to their reset values.
  */
-void mpam_disable(void)
+static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
 {
 	int idx;
 	struct mpam_class *class;
+	struct mpam_msc *msc, *tmp;
+
+	mutex_lock(&mpam_cpuhp_state_lock);
+	if (mpam_cpuhp_state) {
+		cpuhp_remove_state(mpam_cpuhp_state);
+		mpam_cpuhp_state = 0;
+	}
+	mutex_unlock(&mpam_cpuhp_state_lock);
+
+	mpam_unregister_irqs();
 
 	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
 				 srcu_read_lock_held(&mpam_srcu))
 		mpam_reset_class(class);
 	srcu_read_unlock(&mpam_srcu, idx);
+
+	mutex_lock(&mpam_list_lock);
+	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, glbl_list)
+		mpam_msc_destroy(msc);
+	mutex_unlock(&mpam_list_lock);
+	mpam_free_garbage();
+
+	return IRQ_HANDLED;
+}
+
+void mpam_disable(struct work_struct *ignored)
+{
+	mpam_disable_thread(0, NULL);
 }
 
 /*
@@ -1644,7 +1939,6 @@ void mpam_enable(struct work_struct *work)
 	struct mpam_msc *msc;
 	bool all_devices_probed = true;
 
-	/* Have we probed all the hw devices? */
 	mutex_lock(&mpam_list_lock);
 	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
 		mutex_lock(&msc->probe_lock);
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index de05eece0a31..e1c6a2676b54 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -44,6 +44,11 @@ struct mpam_msc {
 	struct pcc_mbox_chan	*pcc_chan;
 	u32			nrdy_usec;
 	cpumask_t		accessibility;
+	bool			has_extd_esr;
+
+	int				reenable_error_ppi;
+	struct mpam_msc * __percpu	*error_dev_id;
+
 	atomic_t		online_refs;
 
 	/*
@@ -52,6 +57,8 @@ struct mpam_msc {
 	 */
 	struct mutex		probe_lock;
 	bool			probed;
+	bool			error_irq_requested;
+	bool			error_irq_hw_enabled;
 	u16			partid_max;
 	u8			pmg_max;
 	unsigned long		ris_idxs[128 / BITS_PER_LONG];
@@ -280,7 +287,7 @@ extern u8 mpam_pmg_max;
 
 /* Scheduled work callback to enable mpam once all MSC have been probed */
 void mpam_enable(struct work_struct *work);
-void mpam_disable(void);
+void mpam_disable(struct work_struct *work);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.39.5


