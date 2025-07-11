Return-Path: <linux-kernel+bounces-728149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873CB023F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE551CC471D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC782F948F;
	Fri, 11 Jul 2025 18:38:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316142F948B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259114; cv=none; b=mP5aJVnUb15lnjKcfNKfEUXXHekMY9FxLmXyrkjqfxtSrogqvZmYStPB6R3V9KQf2byGwqv8kdbdRQPMrSHS3Q1Ki2BN5lJsFRMBH5HPI78grJjYngz3raSYv9g/yAiPET3HK0pXm5r3bCea2jJjW8OMpj3FJaLkghgm5iBrYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259114; c=relaxed/simple;
	bh=P8tZJuAuXataesN+zSuI7koiu4X/wP+6e/DFUGrBVWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/efKhlqV8/jCFBVo8KIXFo9kPL3hKnaBeTQ9HW1mbD0DZQJr+xnaP55GRMyKvTyN4tCOQaOMkrRQ5gQ0xSreS9GVBHryuAVBIpjCJsooRmfB+IqYPX8AAd7anjkZsd0cygaz24WZR8ThpOlcGC3f6sZZQSRus5ybucEnMoBZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E856016F8;
	Fri, 11 Jul 2025 11:38:21 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64D233F694;
	Fri, 11 Jul 2025 11:38:29 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and restored during cpu online
Date: Fri, 11 Jul 2025 18:36:39 +0000
Message-Id: <20250711183648.30766-28-james.morse@arm.com>
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

When CPUs come online the original configuration should be restored.
Once the maximum partid is known, allocate an configuration array for
each component, and reprogram each RIS configuration from this.

The MPAM spec describes how multiple controls can interact. To prevent
this happening by accident, always reset controls that don't have a
valid configuration. This allows the same helper to be used for
configuration and reset.

CC: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 236 ++++++++++++++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |  26 ++-
 2 files changed, 234 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index bb3695eb84e9..f3ecfda265d2 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -374,12 +374,16 @@ static void mpam_class_destroy(struct mpam_class *class)
 	add_to_garbage(class);
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp);
+
 static void mpam_comp_destroy(struct mpam_component *comp)
 {
 	struct mpam_class *class = comp->class;
 
 	lockdep_assert_held(&mpam_list_lock);
 
+	__destroy_component_cfg(comp);
+
 	list_del_rcu(&comp->class_list);
 	add_to_garbage(comp);
 
@@ -909,51 +913,90 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 		__mpam_write_reg(msc, reg, bm);
 }
 
-static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
+/* Called via IPI. Call while holding an SRCU reference */
+static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
+				      struct mpam_config *cfg)
 {
 	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
 
-	mpam_assert_srcu_read_lock_held();
-
 	mutex_lock(&msc->part_sel_lock);
 	__mpam_part_sel(ris->ris_idx, partid, msc);
 
-	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
-		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
+	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
+		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
+			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
+		else
+			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
+					      rprops->cpbm_wd);
+	}
 
-	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
-		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
+	if (mpam_has_feature(mpam_feat_mbw_part, rprops)) {
+		if (mpam_has_feature(mpam_feat_mbw_part, cfg))
+			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
+		else
+			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
+					      rprops->mbw_pbm_bits);
+	}
 
 	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
 		mpam_write_partsel_reg(msc, MBW_MIN, 0);
 
-	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
-		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
+	if (mpam_has_feature(mpam_feat_mbw_max, rprops)) {
+		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
+			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
+		else
+			mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
+	}
 
 	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
 		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
 	mutex_unlock(&msc->part_sel_lock);
 }
 
+struct reprogram_ris {
+	struct mpam_msc_ris *ris;
+	struct mpam_config *cfg;
+};
+
+/* Call with MSC lock held */
+static int mpam_reprogram_ris(void *_arg)
+{
+	u16 partid, partid_max;
+	struct reprogram_ris *arg = _arg;
+	struct mpam_msc_ris *ris = arg->ris;
+	struct mpam_config *cfg = arg->cfg;
+
+	if (ris->in_reset_state)
+		return 0;
+
+	spin_lock(&partid_max_lock);
+	partid_max = mpam_partid_max;
+	spin_unlock(&partid_max_lock);
+	for (partid = 0; partid <= partid_max; partid++)
+		mpam_reprogram_ris_partid(ris, partid, cfg);
+
+	return 0;
+}
+
 /*
  * Called via smp_call_on_cpu() to prevent migration, while still being
  * pre-emptible.
  */
 static int mpam_reset_ris(void *arg)
 {
-	u16 partid, partid_max;
 	struct mpam_msc_ris *ris = arg;
+	struct reprogram_ris reprogram_arg;
+	struct mpam_config empty_cfg = { 0 };
 
 	if (ris->in_reset_state)
 		return 0;
 
-	spin_lock(&partid_max_lock);
-	partid_max = mpam_partid_max;
-	spin_unlock(&partid_max_lock);
-	for (partid = 0; partid < partid_max; partid++)
-		mpam_reset_ris_partid(ris, partid);
+	reprogram_arg.ris = ris;
+	reprogram_arg.cfg = &empty_cfg;
+
+	mpam_reprogram_ris(&reprogram_arg);
 
 	return 0;
 }
@@ -984,13 +1027,11 @@ static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
 
 static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 {
-	int idx;
 	struct mpam_msc_ris *ris;
 
 	mpam_assert_srcu_read_lock_held();
 
 	mpam_mon_sel_outer_lock(msc);
-	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
 		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
@@ -1000,10 +1041,38 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 		 */
 		ris->in_reset_state = online;
 	}
-	srcu_read_unlock(&mpam_srcu, idx);
 	mpam_mon_sel_outer_unlock(msc);
 }
 
+static void mpam_reprogram_msc(struct mpam_msc *msc)
+{
+	int idx;
+	u16 partid;
+	bool reset;
+	struct mpam_config *cfg;
+	struct mpam_msc_ris *ris;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(ris, &msc->ris, msc_list) {
+		if (!mpam_is_enabled() && !ris->in_reset_state) {
+			mpam_touch_msc(msc, &mpam_reset_ris, ris);
+			ris->in_reset_state = true;
+			continue;
+		}
+
+		reset = true;
+		for (partid = 0; partid <= mpam_partid_max; partid++) {
+			cfg = &ris->vmsc->comp->cfg[partid];
+			if (cfg->features)
+				reset = false;
+
+			mpam_reprogram_ris_partid(ris, partid, cfg);
+		}
+		ris->in_reset_state = reset;
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
 static void _enable_percpu_irq(void *_irq)
 {
 	int *irq = _irq;
@@ -1025,7 +1094,7 @@ static int mpam_cpu_online(unsigned int cpu)
 			_enable_percpu_irq(&msc->reenable_error_ppi);
 
 		if (atomic_fetch_inc(&msc->online_refs) == 0)
-			mpam_reset_msc(msc, true);
+			mpam_reprogram_msc(msc);
 	}
 	srcu_read_unlock(&mpam_srcu, idx);
 
@@ -1806,6 +1875,43 @@ static void mpam_unregister_irqs(void)
 	cpus_read_unlock();
 }
 
+static void __destroy_component_cfg(struct mpam_component *comp)
+{
+	add_to_garbage(comp->cfg);
+}
+
+static int __allocate_component_cfg(struct mpam_component *comp)
+{
+	if (comp->cfg)
+		return 0;
+
+	comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);
+	if (!comp->cfg)
+		return -ENOMEM;
+	init_garbage(comp->cfg);
+
+	return 0;
+}
+
+static int mpam_allocate_config(void)
+{
+	int err = 0;
+	struct mpam_class *class;
+	struct mpam_component *comp;
+
+	lockdep_assert_held(&mpam_list_lock);
+
+	list_for_each_entry(class, &mpam_classes, classes_list) {
+		list_for_each_entry(comp, &class->components, class_list) {
+			err = __allocate_component_cfg(comp);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void mpam_enable_once(void)
 {
 	int err;
@@ -1817,12 +1923,21 @@ static void mpam_enable_once(void)
 	 */
 	cpus_read_lock();
 	mutex_lock(&mpam_list_lock);
-	mpam_enable_merge_features(&mpam_classes);
+	do {
+		mpam_enable_merge_features(&mpam_classes);
 
-	err = mpam_register_irqs();
-	if (err)
-		pr_warn("Failed to register irqs: %d\n", err);
+		err = mpam_allocate_config();
+		if (err) {
+			pr_err("Failed to allocate configuration arrays.\n");
+			break;
+		}
 
+		err = mpam_register_irqs();
+		if (err) {
+			pr_warn("Failed to register irqs: %d\n", err);
+			break;
+		}
+	} while (0);
 	mutex_unlock(&mpam_list_lock);
 	cpus_read_unlock();
 
@@ -1861,6 +1976,8 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
 	might_sleep();
 	lockdep_assert_cpus_held();
 
+	memset(comp->cfg, 0, (mpam_partid_max * sizeof(*comp->cfg)));
+
 	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
 		msc = vmsc->msc;
@@ -1963,6 +2080,79 @@ void mpam_enable(struct work_struct *work)
 		mpam_enable_once();
 }
 
+struct mpam_write_config_arg {
+	struct mpam_msc_ris *ris;
+	struct mpam_component *comp;
+	u16 partid;
+};
+
+static int __write_config(void *arg)
+{
+	struct mpam_write_config_arg *c = arg;
+
+	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
+
+	return 0;
+}
+
+#define maybe_update_config(cfg, feature, newcfg, member, changes) do { \
+	if (mpam_has_feature(feature, newcfg) &&			\
+	    (newcfg)->member != (cfg)->member) {			\
+		(cfg)->member = (newcfg)->member;			\
+		cfg->features |= (1 << feature);			\
+									\
+		(changes) |= (1 << feature);				\
+	}								\
+} while (0)
+
+static mpam_features_t mpam_update_config(struct mpam_config *cfg,
+					  const struct mpam_config *newcfg)
+{
+	mpam_features_t changes = 0;
+
+	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, changes);
+
+	return changes;
+}
+
+/* TODO: split into write_config/sync_config */
+/* TODO: add config_dirty bitmap to drive sync_config */
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg)
+{
+	struct mpam_write_config_arg arg;
+	struct mpam_msc_ris *ris;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc *msc;
+	int idx;
+
+	lockdep_assert_cpus_held();
+
+	/* Don't pass in the current config! */
+	WARN_ON_ONCE(&comp->cfg[partid] == cfg);
+
+	if (!mpam_update_config(&comp->cfg[partid], cfg))
+		return 0;
+
+	arg.comp = comp;
+	arg.partid = partid;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
+		msc = vmsc->msc;
+
+		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
+			arg.ris = ris;
+			mpam_touch_msc(msc, __write_config, &arg);
+		}
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+
+	return 0;
+}
+
 /*
  * MSC that are hidden under caches are not created as platform devices
  * as there is no cache driver. Caches are also special-cased in
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 1a24424b48df..029ec89f56f2 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -190,11 +190,7 @@ struct mpam_props {
 	u16			num_mbwu_mon;
 };
 
-static inline bool mpam_has_feature(enum mpam_device_features feat,
-				    struct mpam_props *props)
-{
-	return (1 << feat) & props->features;
-}
+#define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
 
 static inline void mpam_set_feature(enum mpam_device_features feat,
 				    struct mpam_props *props)
@@ -225,6 +221,17 @@ struct mpam_class {
 	struct mpam_garbage	garbage;
 };
 
+struct mpam_config {
+	/* Which configuration values are valid. 0 is used for reset */
+	mpam_features_t		features;
+
+	u32	cpbm;
+	u32	mbw_pbm;
+	u16	mbw_max;
+
+	struct mpam_garbage	garbage;
+};
+
 struct mpam_component {
 	u32			comp_id;
 
@@ -233,6 +240,12 @@ struct mpam_component {
 
 	cpumask_t		affinity;
 
+	/*
+	 * Array of configuration values, indexed by partid.
+	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
+	 */
+	struct mpam_config	*cfg;
+
 	/* member of mpam_class:components */
 	struct list_head	class_list;
 
@@ -297,6 +310,9 @@ extern u8 mpam_pmg_max;
 void mpam_enable(struct work_struct *work);
 void mpam_disable(struct work_struct *work);
 
+int mpam_apply_config(struct mpam_component *comp, u16 partid,
+		      struct mpam_config *cfg);
+
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
 
-- 
2.39.5


