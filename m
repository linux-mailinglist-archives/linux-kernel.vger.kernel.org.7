Return-Path: <linux-kernel+bounces-721302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BFAFC758
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D4F7AAA0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB922DA15;
	Tue,  8 Jul 2025 09:47:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD81FBEBE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968049; cv=none; b=bBtP8sM1m2U2hPhW5z9M+8Vp0YTC9d+QrWZyRQChK/m/0j+z22Fi54Jq2abYZ77suj5DDsgQ0B/g05e0v3DVrecW7UYIm9vW5yb1b+iroj14Nb7ujqJhNZ2gROZF3ZplGXv5PAh1HXhwvTTX7sXS42IcjXwVOYhZzpvhmCPIYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968049; c=relaxed/simple;
	bh=DnZtSf9aYrjCDZuXcZQDe7NU3Wzww+S/7+tXrjYEDTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lo2u+gxmSv3W6wkY8aJUmf3onQzWsnOB/zRCTg0MYjFKR3gEdSLri8QB06m+F4Mu6rZjLXNc7oA2fenq1o0CRHhvHN4yEc9iSFiS24pjcta8YGnTYSYub/c609jqb2+rbVxMySSYvhxVKKqPpxc47QIvnFQnVFYZRh/YwCdHYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bbx6y2q74z2FbNr;
	Tue,  8 Jul 2025 17:45:30 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EF7FB1400D4;
	Tue,  8 Jul 2025 17:47:23 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 17:47:23 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 kwepemq500009.china.huawei.com (7.202.195.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 17:47:23 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
	<bobo.shaobowang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] hrtimers: Update new CPU's next event in hrtimers_cpu_dying()
Date: Tue, 8 Jul 2025 18:17:27 +0800
Message-ID: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500009.china.huawei.com (7.202.195.53)

When testing softirq based hrtimers on an ARM32 board, with high
resolution mode and nohz are both inactive, softirq based hrtimers
failed to trigger when moved away from an offline CPU. The flowpath
is as follows.

CPU0				CPU1
				softirq based hrtimers are queued
				offline CPU1
				move hrtimers to CPU0 in hrtimers_cpu_dying()
				send IPI to CPU0 to retrigger next event
'softirq_expires_next' is KTIME_MAX
call retrigger_next_event()
highres and nohz is inactive,just return
'softirq_expires_next' is not updated
hrtimer softirq is never triggered

Some softirq based hrtimers are queued on CPU1. Then we offline CPU1.
hrtimers_cpu_dying() moves hrtimers from CPU1 to CPU0, and then it send
a IPI to CPU0 to let CPU0 call retrigger_next_event(). But high
resolution mode and nohz are both inactive. So retrigger_next_event()
just returned. 'softirq_expires_next' is never updated and remains
KTIME_MAX. So hrtimer softirq is never raised.

To fix this issue, we call hrtimer_update_next_event() in
hrtimers_cpu_dying() to update 'softirq_expires_next' for the new CPU.
It also update hardirq hrtimer's next event, but it should have no bad
effect.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 kernel/time/hrtimer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..ff97eb36c116 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2298,8 +2298,11 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	/*
 	 * The migration might have changed the first expiring softirq
 	 * timer on this CPU. Update it.
+	 * We also need to update 'softirq_expires_next' here, because it will
+	 * not be updated in retrigger_next_event() if high resolution mode
+	 * and nohz are both inactive.
 	 */
-	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+	hrtimer_update_next_event(new_base);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-- 
2.20.1


