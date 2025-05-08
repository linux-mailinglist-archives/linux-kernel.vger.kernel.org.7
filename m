Return-Path: <linux-kernel+bounces-640154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1ACAB0145
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866A93AF157
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FBE2882C0;
	Thu,  8 May 2025 17:20:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A6286D5C
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724803; cv=none; b=EBEMazxcGER722RE6FdAVRjfxca9/6mnd1HVSQ3SXUPRiAdXzBTPqxUzKN0yJVEbfVWoa7JoVNoql8aMdinGnpO2UbpMeord4R2X3Q0HXfzC3/1fAx9LlfZ++/O/KCd1zMzbFaL+n5wDlssRgob24itSbrqnWA6Xl/F0r2FZUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724803; c=relaxed/simple;
	bh=Aanz5Yoo/xkEHKjcxrScO+5FyvT72xZW5khgA0cU/Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPyt5w/dWk9p6kfmHXSsnyCKJ/v/w0NlpNRmIdLP73wjoc7zsPVuWf7uFvRcPVcWt8cvnsawXFC0redZw26k9DDZVaKBwv9vzh+R/b8wH5BHSgcNDgqf8yu8hf7cX46PopFLmVVMcZ+nekZZ0/S4eklxbJSQj18HKS7STA81gLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47FB6244C;
	Thu,  8 May 2025 10:19:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694843F58B;
	Thu,  8 May 2025 10:19:57 -0700 (PDT)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v10 11/30] x86/resctrl: Add end-marker to the resctrl_event_id enum
Date: Thu,  8 May 2025 17:18:39 +0000
Message-Id: <20250508171858.9197-12-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250508171858.9197-1-james.morse@arm.com>
References: <20250508171858.9197-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl_event_id enum gives names to the counter event numbers on x86.
These are used directly by resctrl.

To allow the MPAM driver to keep an array of these the size of the enum
needs to be known.

Add a 'num_events' enum entry which can be used to size an array.
This is added to the enum to reduce conflicts with another series,
which in turn requires get_arch_mbm_state() to have a default case.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v8:
 * Move the last marker into the enum and add a default case.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 9 ++++-----
 include/linux/resctrl_types.h         | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 73e3fe4f4c87..4962ae4bc596 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -260,12 +260,11 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *hw_do
 		return &hw_dom->arch_mbm_total[rmid];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
 		return &hw_dom->arch_mbm_local[rmid];
+	default:
+		/* Never expect to get here */
+		WARN_ON_ONCE(1);
+		return NULL;
 	}
-
-	/* Never expect to get here */
-	WARN_ON_ONCE(1);
-
-	return NULL;
 }
 
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index f26450b3326b..69bf740130ac 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -49,6 +49,9 @@ enum resctrl_event_id {
 	QOS_L3_OCCUP_EVENT_ID		= 0x01,
 	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+
+	/* Must be the last */
+	QOS_NUM_EVENTS,
 };
 
 #endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.39.5


