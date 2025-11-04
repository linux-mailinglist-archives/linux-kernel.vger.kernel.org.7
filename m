Return-Path: <linux-kernel+bounces-884244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CCC2FBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB493B0A23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CD30FF2F;
	Tue,  4 Nov 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uw1k6Ufc"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D630FF06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242952; cv=none; b=ASImKpE/t9N07bJQt0LUXBv2wVwxUB8AzWOilIZuI+bC0K5Isu12wWnjlbjEtPt05pEZdVLzwdFy6gNeDPIg2aJk0oxVEJFpzn8OYQDIVZybHW2xuOZAqpSS6PlBbHKg0n/ZV2kE7nr/Rdtil6z6V+Mh6+KyfcaA2/ytKbUVJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242952; c=relaxed/simple;
	bh=GXyfCYePFPYrVDG2hlmggVwu4LLFR9AXyvTD7zhjKgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqHZvaElkxWC1IIAR2alcMKF5sVqLXmYyj9h1p9KFAdeQVjZGnJT+qnYzUwlPESnKj8vVlcUxfqLz+CpkLHRLdp7C3lK+YNaLgIXrbvwvpryWs6aaPeZzLkxYwsSKmRmPHof6WXw8p4dtrD+WKGRSMauNLroiJmIyYFZZCzD0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uw1k6Ufc; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uOZYkNr7I7kzYLHzotIZXC0+std2hhngeKFpxYz3X8A=;
	b=uw1k6UfcxwHujPA5dNgdzZMMlP2fBu1GS9CVCNRspIRcsl0LRiHurN/5lWPiON3Ry49oQqsoW
	6yyKFnf5QB84WsYvaJNk4dUIdrTcfvrY3lsQkoEhbwapwmblu+taf1bjkiITZ11l6IoLyzpSon6
	yJk83TiqcB9NXNQ4LF5W3KI=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d111c27Yvz1prKB;
	Tue,  4 Nov 2025 15:54:12 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 73392180493;
	Tue,  4 Nov 2025 15:55:47 +0800 (CST)
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
Subject: [PATCH 3/3] arm64: topology: Remove redundant housekeeping_cpu() checks in arch_freq_get_on_cpu
Date: Tue, 4 Nov 2025 15:55:44 +0800
Message-ID: <20251104075544.3243606-4-yubowen8@huawei.com>
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

This patch removes redundant !housekeeping_cpu() check since it is
inherently done when checking jiffies.

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 arch/arm64/kernel/topology.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f1370a4a4df9..6981ef3019d3 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -310,20 +310,13 @@ int arch_freq_get_on_cpu(int cpu)
 		 * (and thus freq scale), if available, for given policy: this boils
 		 * down to identifying an active cpu within the same freq domain, if any.
 		 */
-		if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
-		    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
+		if (time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
 			struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 			int ref_cpu;
 
 			if (!policy)
 				return -EINVAL;
 
-			if (!cpumask_intersects(policy->related_cpus,
-						housekeeping_cpumask(HK_TYPE_TICK))) {
-				cpufreq_cpu_put(policy);
-				return -EOPNOTSUPP;
-			}
-
 			for_each_cpu_wrap(ref_cpu, policy->cpus, cpu + 1) {
 				if (ref_cpu == start_cpu) {
 					/* Prevent verifying same CPU twice */
-- 
2.33.0


