Return-Path: <linux-kernel+bounces-650089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B6AB8D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2136C1BC7631
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE325C82D;
	Thu, 15 May 2025 17:00:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220B253F22
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328418; cv=none; b=eDKsRjYQcFW1IEaWBA3xK0TpPj0tcdci9bls5dSkptzlmMBtQ7qhioX/C7Ou5Mvoo6aJhQZ/E2LSfunZdbdKM5533CDZ3nBmZNhF5tATaWvdjLpWMZK1NSV6arwachPu3J9XdHuh52h87HN2rH6LLbnq7sgDIpKq5TzcNLrmAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328418; c=relaxed/simple;
	bh=zLR2jJ5l7Aze102ucRl/xxChAZL7lSK1qCqYzBmBT/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5pdWOoV2lr2q4BSAYh7coReA21HyEwBXQg1lhc2yjQ2ZRYAzVxLtnawM0f29UOkWj6hXsCEMw6GIKoQwEZFwVsMQHnLhISIURrlDBNg30rPXhEmKYLQvtc7lUZBeC2nutcq/6Xuoujw5FUDiuEG44oC0VheN0wTqH07zfUM+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A8502659;
	Thu, 15 May 2025 10:00:04 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B083F63F;
	Thu, 15 May 2025 10:00:12 -0700 (PDT)
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
Subject: [PATCH v12 17/25] x86/resctrl: Move enum resctrl_event_id to resctrl.h
Date: Thu, 15 May 2025 16:58:47 +0000
Message-Id: <20250515165855.31452-18-james.morse@arm.com>
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

resctrl_types.h contains common types and constants to enable architectures
to use these types in their definitions within asm/resctrl.h

enum resctrl_event_id was placed in resctrl_types.h for
resctrl_arch_get_cdp_enabled() and resctrl_arch_set_cdp_enabled(), but
these two functions are no longer inlined by any architecture.

Move enum resctrl_event_id to resctrl.h

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v9:
 * Replaced commit message with Reinette's version.

Changes since v8:
 * This patch is new.
---
 include/linux/resctrl.h       | 10 ++++++++++
 include/linux/resctrl_types.h | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b9d1f2916e9c..5ef972cbf56b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -48,6 +48,16 @@ int proc_resctrl_show(struct seq_file *m,
 	for_each_rdt_resource((r))					      \
 		if ((r)->mon_capable)
 
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a66e7936943e..a25fb9c4070d 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,16 +34,6 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 /*
  * Event IDs, the values match those used to program IA32_QM_EVTSEL before
  * reading IA32_QM_CTR on RDT systems.
-- 
2.39.5


