Return-Path: <linux-kernel+bounces-728157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EAFB02401
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419C1540079
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0312F5082;
	Fri, 11 Jul 2025 18:38:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8C2F4A1A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259137; cv=none; b=mCHkt/Vzo/MlPMJMVum1ouOV2kC8Eq4fhxGWPlsvKS4+s9JULm4fvFD5tKOWGt3gYf1VsFeZAKGFdb0o4otICeAJNCxFAhks7UYo+xnEZNVBcufrTLuT39h64rLZk3zl/yMmD1daFF4pmotIgUhuMzqf3RpZx2s3Uxwdhy3L/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259137; c=relaxed/simple;
	bh=T7KCaikQxixGSaxrgEGuIemLsQcW1IZKLPVrwsU447A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAEmayuUPBoRccbowUvr9NLG1jEDE2zI2MiUCRRJTX2dGV0XbFMLeDVBiXPlLUTmmvkOYxPCNXgb3QAWAacKA4iPczrM6rPQSNZ4UEwLUkdVzv31HJf9l1FLjp0ClITByXEX9Ts1AHq5woTKj7i04l14N+x/Xh6ea2RNTbqq1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC47316F8;
	Fri, 11 Jul 2025 11:38:44 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5388D3F694;
	Fri, 11 Jul 2025 11:38:52 -0700 (PDT)
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
Subject: [RFC PATCH 34/36] arm_mpam: Add helper to reset saved mbwu state
Date: Fri, 11 Jul 2025 18:36:46 +0000
Message-Id: <20250711183648.30766-35-james.morse@arm.com>
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

resctrl expects to reset the bandwidth counters when the filesystem
is mounted.

To allow this, add a helper that clears the saved mbwu state. Instead
of cross calling to each CPU that can access the component MSC to
write to the counter, set a flag that causes it to be zero'd on the
the next read. This is easily done by forcing a configuration update.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 49 ++++++++++++++++++++-
 drivers/platform/arm64/mpam/mpam_internal.h |  5 ++-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index ace69ac2d0ee..470a3709670e 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -1142,9 +1142,11 @@ static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
 static void __ris_msmon_read(void *arg)
 {
 	bool nrdy = false;
+	bool config_mismatch;
 	struct mon_read *m = arg;
 	u64 now, overflow_val = 0;
 	struct mon_cfg *ctx = m->ctx;
+	bool reset_on_next_read = false;
 	struct mpam_msc_ris *ris = m->ris;
 	struct msmon_mbwu_state *mbwu_state;
 	struct mpam_props *rprops = &ris->props;
@@ -1159,6 +1161,14 @@ static void __ris_msmon_read(void *arg)
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
 
+	if (m->type == mpam_feat_msmon_mbwu) {
+		mbwu_state = &ris->mbwu_state[ctx->mon];
+		if (mbwu_state) {
+			reset_on_next_read = mbwu_state->reset_on_next_read;
+			mbwu_state->reset_on_next_read = false;
+		}
+	}
+
 	/*
 	 * Read the existing configuration to avoid re-writing the same values.
 	 * This saves waiting for 'nrdy' on subsequent reads.
@@ -1166,7 +1176,10 @@ static void __ris_msmon_read(void *arg)
 	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
 	clean_msmon_ctl_val(&cur_ctl);
 	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
-	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
+	config_mismatch = cur_flt != flt_val ||
+			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
+
+	if (config_mismatch || reset_on_next_read)
 		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
 
 	switch (m->type) {
@@ -1199,7 +1212,6 @@ static void __ris_msmon_read(void *arg)
 		if (nrdy)
 			break;
 
-		mbwu_state = &ris->mbwu_state[ctx->mon];
 		if (!mbwu_state)
 			break;
 
@@ -1301,6 +1313,39 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 	return err;
 }
 
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
+{
+	int idx;
+	struct mpam_msc *msc;
+	struct mpam_vmsc *vmsc;
+	struct mpam_msc_ris *ris;
+
+	if (!mpam_is_enabled())
+		return;
+
+	idx = srcu_read_lock(&mpam_srcu);
+	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
+		if (!mpam_has_feature(mpam_feat_msmon_mbwu, &vmsc->props))
+			continue;
+
+		msc = vmsc->msc;
+		mpam_mon_sel_outer_lock(msc);
+		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
+			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
+				continue;
+
+			if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
+				continue;
+
+			ris->mbwu_state[ctx->mon].correction = 0;
+			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
+			mpam_mon_sel_inner_unlock(msc);
+		}
+		mpam_mon_sel_outer_unlock(msc);
+	}
+	srcu_read_unlock(&mpam_srcu, idx);
+}
+
 static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 4553616f2f67..76b83bda3d37 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -295,10 +295,12 @@ struct mon_cfg {
 
 /*
  * Changes to enabled and cfg are protected by the msc->lock.
- * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
+ * Changes to reset_on_next_read, prev_val and correction are protected by the
+ * msc's mon_sel_lock.
  */
 struct msmon_mbwu_state {
 	bool		enabled;
+	bool		reset_on_next_read;
 	struct mon_cfg	cfg;
 
 	/* The value last read from the hardware. Used to detect overflow. */
@@ -408,6 +410,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
 		    enum mpam_device_features, u64 *val);
+void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx);
 
 int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
 				   cpumask_t *affinity);
-- 
2.39.5


