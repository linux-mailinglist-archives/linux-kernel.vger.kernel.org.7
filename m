Return-Path: <linux-kernel+bounces-600706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD891A86390
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8699B4410CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD42222D6;
	Fri, 11 Apr 2025 16:43:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E32206A8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389819; cv=none; b=XBkFc9e8au7kqOtSis9oyUBfzn2dm85estbm2jHt8sOX+lmC/dj3beSFHOn/pmcWa0dw/GzmBTAPtrtux8B++tNtHiY9aJ1sFIVhO3i3oBWB3syfykht0Dw/VP8TBBOodqu7GXlpHiY8xciy9yyQvGKsdMafeGa6x8t4DFgktlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389819; c=relaxed/simple;
	bh=HdEwY/3aJcKODu8Sye0QSWuJDNw0sYQp5O2f978ge5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VeGTje4FO0WlQacA1ZCc3v1X7gHNGfv0DUFxAOBHaE169vq5uQCB/yREqIkizW89p/rNRtGm43t5EDnZa44ebW1F6PgqK25EcIiEx+u0XC+HxADVMW3TJ2PhM9tBTPPyjlD3eTEdaBhQ/BeKV/BOhbhEq9CdEaAChSISRuOTTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB68219F0;
	Fri, 11 Apr 2025 09:43:36 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C65353F694;
	Fri, 11 Apr 2025 09:43:33 -0700 (PDT)
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
Subject: [PATCH v8 07/21] x86/resctrl: Add end-marker to the resctrl_event_id enum
Date: Fri, 11 Apr 2025 16:42:15 +0000
Message-Id: <20250411164229.23413-8-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250411164229.23413-1-james.morse@arm.com>
References: <20250411164229.23413-1-james.morse@arm.com>
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

Add a 'num_events' define which can be used to size an array. This isn't
a member of the enum to avoid updating switch statements that would
otherwise be missing a case.

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
 include/linux/resctrl_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index f26450b3326b..654323066174 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -51,4 +51,6 @@ enum resctrl_event_id {
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
 };
 
+#define QOS_NUM_EVENTS		(QOS_L3_MBM_LOCAL_EVENT_ID + 1)
+
 #endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.20.1


