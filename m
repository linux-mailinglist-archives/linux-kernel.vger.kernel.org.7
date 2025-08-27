Return-Path: <linux-kernel+bounces-788327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2341B382DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D675E44DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153D9335BBB;
	Wed, 27 Aug 2025 12:51:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608D1A0711
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299091; cv=none; b=uZG5LjHV/0EkYJ4kPmlSwpNyglp9q3A1JCJwft1p/8tFUaNftbJwh9IntgQCg3XNu0XkKbnLO4dj7RhCqMLUkJ+K9rRVuHAwgafXPt+Gm3DtqF1Qb33agEWMXwk16Fibh4P8qQ4jvJ7hAMtirzONa+FBbxC71YXPqIBs3igJX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299091; c=relaxed/simple;
	bh=yn4FXu3iy4O7Ql52fLI1NEmcBVcFi7JOFNu4QpkWIFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YuPN5hle+svsObE3FPIQcpOB2zuCtgYC3hwO8p2G12Hc4gLkqwoGtDiWwpyo8Uh2vCMY1sBBoMn4NEkKoYeNPO4+BqMAPbPN5x+BuwVqTFQwGSEjhVg6rWMLt+t4oICpWmjA7IyqXh65yjEbBa1Bs4TjHdMc5mcBZ809RvvTUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cBks83S3wzqVXQ;
	Wed, 27 Aug 2025 20:50:20 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B6201800B1;
	Wed, 27 Aug 2025 20:51:18 +0800 (CST)
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 20:51:17 +0800
Received: from huawei.com (10.67.174.57) by kwepemn500008.china.huawei.com
 (7.202.194.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 20:51:17 +0800
From: Xia Fukun <xiafukun@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <mgorman@suse.de>, <riel@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH] sched/fair: Fix division-by-zero error in task_scan_max()
Date: Wed, 27 Aug 2025 12:34:27 +0000
Message-ID: <20250827123427.1229183-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn500008.china.huawei.com (7.202.194.149)

The error can be reproduced by following these steps:
First, set sysctl_numa_balancing_scan_size to 0:

echo 0 > /sys/kernel/debug/sched/numa_balancing/scan_size_mb

Then trigger the clone system call, for example, by using
pthread_create to create a new thread.

	Oops: divide error: 0000 [#1] SMP NOPTI
	CPU: 11 UID: 0 PID: 1 Comm: systemd Tainted: G S 6.17.0xfk_v2 #6
	Tainted: [S]=CPU_OUT_OF_SPEC
	Hardware name: SuperCloud R5210 G12/X12DPi-N6, BIOS 1.1c 08/30/2021
	RIP: 0010:task_scan_max+0x24/0x190
	RSP: 0018:ff56485a001ebc98 EFLAGS: 00010246
	...
	Call Trace:
	<TASK>
	init_numa_balancing+0xdb/0x1e0
	__sched_fork+0x110/0x180
	sched_fork+0xd/0x170
	copy_process+0x821/0x1aa0
	kernel_clone+0xbc/0x400
	__do_sys_clone3+0xde/0x120
	do_syscall_64+0xa4/0x260
	entry_SYSCALL_64_after_hwframe+0x77/0x7f

This patch fixes the issue by ensuring that the relevant value in
task_scan_max() is at least 1.

Fixes: 598f0ec0bc99 ("sched/numa: Set the scan rate proportional to the memory usage of the task being scanned")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..ea962e3bcb13 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1496,6 +1496,7 @@ static unsigned int task_nr_scan_windows(struct task_struct *p)
 	 * on resident pages
 	 */
 	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
+	nr_scan_pages = max_t(unsigned long, nr_scan_pages, 1UL << (20 - PAGE_SHIFT));
 	rss = get_mm_rss(p->mm);
 	if (!rss)
 		rss = nr_scan_pages;
@@ -1510,6 +1511,7 @@ static unsigned int task_nr_scan_windows(struct task_struct *p)
 static unsigned int task_scan_min(struct task_struct *p)
 {
 	unsigned int scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
+	scan_size = max_t(unsigned int, scan_size, 1);
 	unsigned int scan, floor;
 	unsigned int windows = 1;
 
-- 
2.34.1


