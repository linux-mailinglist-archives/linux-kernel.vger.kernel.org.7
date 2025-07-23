Return-Path: <linux-kernel+bounces-741725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC957B0E844
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A7216417E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF44189B84;
	Wed, 23 Jul 2025 01:45:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2612EB10
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235121; cv=none; b=U45mzNk1WPLwqiP8JBrQUvv1Eqf6TgP65PW8PlGiX6xWo+1Z+IemPHY52qETFjHUW8/CjD1ituuKudsqPK2relVToiFYuvm+UMJnHQsGADm9/do3hCCBg895TfE8vqPIUUGWvQy7NENy74duKAV7F3Gpe5YldwvGiWYii87Z1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235121; c=relaxed/simple;
	bh=lOzJSMajRtRi65PeFb8Kp4alg7DUa+8qEI+AqwPjcRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JS5PV+6nelc7GK6Bq3bX0BIyrLW1tegMpa/JpXtHjOGRe9UUZhfYpCdj+Ml49kK6hzJ70ZUXEdS6KVcW1IDgX1/qxQDVVGJkny/SzyZNHmarixgQhQ6cqyO0+jKGBZ9kHxI5FmyLsSvUK32jRXe0L1OY2ZFldqlJheovh3vMlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bmxkf6sLKztSkD;
	Wed, 23 Jul 2025 09:44:10 +0800 (CST)
Received: from dggpemf100017.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BE94180B71;
	Wed, 23 Jul 2025 09:45:15 +0800 (CST)
Received: from huawei.com (10.67.174.191) by dggpemf100017.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Jul
 2025 09:45:14 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <tglx@linutronix.de>, <frederic@kernel.org>, <anna-maria@linutronix.de>,
	<jstultz@google.com>, <peterz@infradead.org>, <namcao@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>,
	<yuanlulu4@huawei.com>, <tanghui20@huawei.com>
Subject: [PATCH] sched/clock: Init generic clock with CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
Date: Wed, 23 Jul 2025 10:03:26 +0800
Message-ID: <20250723020326.622368-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100017.china.huawei.com (7.185.36.74)

The sched_clock_timer is used to prevent the sched clock wrapped, this
timer is initialized in generic_sched_clock_init();

When CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y, generic_sched_clock_init() is
not called and sched_clock_timer is not initialized, causing the
sched clock to wrap.

To fix this issue, call generic_sched_clock_init() in sched_clock_init()
to initialize the sched_clock_timer.

Fixes: 5d2a4e91a541 ("sched/clock: Move sched clock initialization and merge with generic clock")
Reported-by: yuanlulu <yuanlulu4@huawei.com>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index a09655b481402..13e76cfb59f23 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -213,6 +213,7 @@ void __init sched_clock_init(void)
 	 */
 	local_irq_disable();
 	__sched_clock_gtod_offset();
+	generic_sched_clock_init();
 	local_irq_enable();
 
 	static_branch_inc(&sched_clock_running);
-- 
2.18.0.huawei.25


