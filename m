Return-Path: <linux-kernel+bounces-884242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE535C2FBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DDAE34D003
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A33101A9;
	Tue,  4 Nov 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xw+/AePo"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B930FC3E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242951; cv=none; b=pTubfXs/SKM6CLKPaNfjwzeFI6brSoiGF/VklARWPx7gzHckbKZ52kdXhxvWbtqae4+Eb+Px5j9FEvVt5NY2HnQTrn5dtOa0Kegv76HmOLtUrGaBtIjunk1NzxXGmBQ0WRz3s8WBIFp8xs0PYWCy8wwKlvNMEAMLgGxmrkQJ/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242951; c=relaxed/simple;
	bh=DDcZE0+BW/R3G5J4jP3uwnZcXOu76HW9eD5SdfvX2uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQhMsaK+l4uD6GJlnoWOWOL+GxszWtSKY1NQ4dwnfe++nGIJ4P+WpWuQ6/XEcG95y/F2MIcpFLnFES3LLsiaGLtX5tJBq+VfB4YEEHGSPaJ+u+skdz2A715oEcvFMrSz8Ae/rRcJUH4aPGUIJe4aO88osjgzJOwKq8Vk0GZ5BWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xw+/AePo; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=h0Cz8r26uiUEfgHyGdbGpMReEJmd9fW3ZKjrNjIlhTI=;
	b=xw+/AePoCAV2kjUx8a71rOuNkh59Pv1Ifc+IRZntxldEiRKLR8neCRtojLlPKyMKkGYl1CBa7
	2IRwRD5wnA4eJGozEH6oxY7gmAQ5ZkRbGWzEl3WSOHF9ERF77hfbS2zpPL0dZFRn55pBSyVk96V
	un6Tsfk7a1WcLmtirwq0L7o=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d111c0MTSz1cyV7;
	Tue,  4 Nov 2025 15:54:12 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id EE1211402C3;
	Tue,  4 Nov 2025 15:55:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:55:46 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	<ptsm@linux.microsoft.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>
Subject: [PATCH 2/3] arm64: topology: Use current freq in governor for idle cpus in cpuinfo_avg_freq
Date: Tue, 4 Nov 2025 15:55:43 +0800
Message-ID: <20251104075544.3243606-3-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251104075544.3243606-1-yubowen8@huawei.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500012.china.huawei.com (7.202.194.97)

The current cpuinfo_avg_freq interface returns an error when all CPUs
under a policy are idle, which is relatively common. To address this, it
is better to use the current frequency stored in the governor. This
implementation is also used on x86 architecture.

Since the current frequency in the governor is the last known frequency,
it should be more user-friendly.

This patch also removes redundant !housekeeping_cpu() check since it is
inherently done when checking jiffies.

Original output when all cpus under a policy are idle:
[root@localhost home]# cat /sys/devices/system/cpu/cpufreq/policy0/
cpuinfo_avg_freq
cat: /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq: Resource
 temporarily unavailable

Output after changes:
[root@localhost home]# cat /sys/devices/system/cpu/cpufreq/policy0
/cpuinfo_avg_freq
1200000

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 arch/arm64/kernel/topology.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index c0dbc27289ea..f1370a4a4df9 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -333,14 +333,13 @@ int arch_freq_get_on_cpu(int cpu)
 				if (!idle_cpu(ref_cpu))
 					break;
 			}
+
+			if (ref_cpu >= nr_cpu_ids) {
+				cpufreq_cpu_put(policy);
+				return cpufreq_quick_get(start_cpu);
+			}
 
 			cpufreq_cpu_put(policy);
-
-			if (ref_cpu >= nr_cpu_ids)
-				/* No alternative to pull info from */
-				return -EAGAIN;
-
-			cpu = ref_cpu;
 		} else {
 			break;
 		}
-- 
2.33.0

