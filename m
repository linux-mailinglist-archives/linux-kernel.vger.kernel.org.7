Return-Path: <linux-kernel+bounces-728142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D7B023EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD77B1CC40B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052642F6FBE;
	Fri, 11 Jul 2025 18:38:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B22F6FB9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259101; cv=none; b=NDW1yjnJzlVJbxZlojtPP9zuWqowKjJ49ZJ9vL4cY4vh0OD1fm5PdgIl7RobcmkA2ZXw6WHbgT6fIowmp5DWdIpNRddpyQTq3CKcHj6Zt23OoJVLu3lJklrl2gquY0X2k2HPdlFb00PDehS0ImMZGVgoUtD9KCeRfwqkWMWFC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259101; c=relaxed/simple;
	bh=ae7rIy3JoICyj2MmJqmJ81fNbEkgiMNmrye3snv4jPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhGPWcu/52lNwJfRj7uC6XkcfnPgFm1Wd3svJmheggkhXtAL5uZScN/ztU0Lwz6tebRiEAQcWHe6OJvSoe1sqHsoslrptMPFJLz9F1d5oPfJjkMW8TCvwu6NhzwsumJjkjmuZcWLiFr4yKTbVdczV7wG/6nzMvRXwgkQ7uiHdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D27AC2247;
	Fri, 11 Jul 2025 11:38:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1A43F694;
	Fri, 11 Jul 2025 11:38:16 -0700 (PDT)
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
Subject: [RFC PATCH 23/36] arm_mpam: Add a helper to touch an MSC from any CPU
Date: Fri, 11 Jul 2025 18:36:35 +0000
Message-Id: <20250711183648.30766-24-james.morse@arm.com>
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

Resetting RIS entries from the cpuhp callback is easy as the
callback occurs on the correct CPU. This won't be true for any other
caller that wants to reset or configure an MSC.

Add a helper that schedules the provided function if necessary.
Prevent the cpuhp callbacks from changing the MSC state by taking the
cpuhp lock.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 37 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index d014dbe0ab96..2e32e54cc081 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -907,20 +907,51 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
 	mutex_unlock(&msc->part_sel_lock);
 }
 
-static void mpam_reset_ris(struct mpam_msc_ris *ris)
+/*
+ * Called via smp_call_on_cpu() to prevent migration, while still being
+ * pre-emptible.
+ */
+static int mpam_reset_ris(void *arg)
 {
 	u16 partid, partid_max;
+	struct mpam_msc_ris *ris = arg;
 
 	mpam_assert_srcu_read_lock_held();
 
 	if (ris->in_reset_state)
-		return;
+		return 0;
 
 	spin_lock(&partid_max_lock);
 	partid_max = mpam_partid_max;
 	spin_unlock(&partid_max_lock);
 	for (partid = 0; partid < partid_max; partid++)
 		mpam_reset_ris_partid(ris, partid);
+
+	return 0;
+}
+
+/*
+ * Get the preferred CPU for this MSC. If it is accessible from this CPU,
+ * this CPU is preferred. This can be preempted/migrated, it will only result
+ * in more work.
+ */
+static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
+{
+	int cpu = raw_smp_processor_id();
+
+	if (cpumask_test_cpu(cpu, &msc->accessibility))
+		return cpu;
+
+	return cpumask_first_and(&msc->accessibility, cpu_online_mask);
+}
+
+static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
+{
+	lockdep_assert_irqs_enabled();
+	lockdep_assert_cpus_held();
+	mpam_assert_srcu_read_lock_held();
+
+	return smp_call_on_cpu(mpam_get_msc_preferred_cpu(msc), fn, arg, true);
 }
 
 static void mpam_reset_msc(struct mpam_msc *msc, bool online)
@@ -933,7 +964,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
 	mpam_mon_sel_outer_lock(msc);
 	idx = srcu_read_lock(&mpam_srcu);
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
-		mpam_reset_ris(ris);
+		mpam_touch_msc(msc, &mpam_reset_ris, ris);
 
 		/*
 		 * Set in_reset_state when coming online. The reset state
-- 
2.39.5


