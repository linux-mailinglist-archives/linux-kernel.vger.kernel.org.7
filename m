Return-Path: <linux-kernel+bounces-728147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9CB02412
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F75DB61800
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA12F8C4B;
	Fri, 11 Jul 2025 18:38:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58852F49FA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259111; cv=none; b=gtBIbCw0XREXMyHLI2a2IzrQ1nPONuL0KOBHF57zsv9B2mbdYi87CS8biYCnidmMTThEoecZC+QsbowhS3HGYBE6YW9qDl5kauYYyWVy4bjpctasXDirHdrl1d39AY8hVYWl3UuPteLiDtmBRQCgcXTZbZdN0JpdurJPBMR6/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259111; c=relaxed/simple;
	bh=q97PZtbM4ygrgsVnhhxFQuHbo3mfWKupqRaJsYR2dNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FY+vCj7/41baidrWybzrkfjgI3puFGETz6U2Jc/3zlBjyYZ+Ct/TQ4ZTYgypEsbSFHt0YzrctIsaTAcnqqhVQe76UWfoGWqNjK/+Zxmg6eKgl6bS3CsLk/gByZmuhi/ML2Jj9YSEn7rdOKulx8Vwr05ngj8IS8brVc4rDcEq4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92C0116F8;
	Fri, 11 Jul 2025 11:38:18 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A2553F694;
	Fri, 11 Jul 2025 11:38:25 -0700 (PDT)
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
Subject: [RFC PATCH 26/36] arm_mpam: Use a static key to indicate when mpam is enabled
Date: Fri, 11 Jul 2025 18:36:38 +0000
Message-Id: <20250711183648.30766-27-james.morse@arm.com>
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

Once all the MSC have been probed, the system wide usable number of
PARTID is known and the configuration arrays can be allocated.

After this point, checking all the MSC have been probed is pointless,
and the cpuhp callbacks should restore the configuration, instead of
just resetting the MSC.

Add a static key to enable this behaviour. This will also allow MPAM
to be disabled in repsonse to an error, and the architecture code to
enable/disable the context switch of the MPAM system registers.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c  | 8 ++++++++
 drivers/platform/arm64/mpam/mpam_internal.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index af19cc25d16e..bb3695eb84e9 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -33,6 +33,8 @@
 
 #include "mpam_internal.h"
 
+DEFINE_STATIC_KEY_FALSE(mpam_enabled); /* TODO: move to arch code */
+
 /*
  * mpam_list_lock protects the SRCU lists when writing. Once the
  * mpam_enabled key is enabled these lists are read-only,
@@ -1037,6 +1039,9 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
 	struct mpam_msc *msc;
 	bool new_device_probed = false;
 
+	if (mpam_is_enabled())
+		return 0;
+
 	mutex_lock(&mpam_list_lock);
 	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
 		if (!cpumask_test_cpu(cpu, &msc->accessibility))
@@ -1839,6 +1844,7 @@ static void mpam_enable_once(void)
 	partid_max_published = true;
 	spin_unlock(&partid_max_lock);
 
+	static_branch_enable(&mpam_enabled);
 	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
 
 	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
@@ -1906,6 +1912,8 @@ static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
 	}
 	mutex_unlock(&mpam_cpuhp_state_lock);
 
+	static_branch_disable(&mpam_enabled);
+
 	mpam_unregister_irqs();
 
 	idx = srcu_read_lock(&mpam_srcu);
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index e1c6a2676b54..1a24424b48df 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -8,6 +8,7 @@
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/jump_label.h>
 #include <linux/llist.h>
 #include <linux/mailbox_client.h>
 #include <linux/mutex.h>
@@ -15,6 +16,13 @@
 #include <linux/sizes.h>
 #include <linux/srcu.h>
 
+DECLARE_STATIC_KEY_FALSE(mpam_enabled);
+
+static inline bool mpam_is_enabled(void)
+{
+	return static_branch_likely(&mpam_enabled);
+}
+
 /*
  * Structures protected by SRCU may not be freed for a surprising amount of
  * time (especially if perf is running). To ensure the MPAM error interrupt can
-- 
2.39.5


