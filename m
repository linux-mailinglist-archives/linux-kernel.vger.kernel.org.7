Return-Path: <linux-kernel+bounces-756060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D82B1AF7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9C47AC7C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23221ADCB;
	Tue,  5 Aug 2025 07:42:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3333234
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379722; cv=none; b=g5f4un8W4d13jQrUYxvJYyjffI+RIz9MU0lehJcDpyQ+1AI0pzuNRmPE5Qi8H7GohHShSFBcSIfSSV9kBxePjdDfFtAV6N1HsIqSfjJQjHn+QnqyT4n8UwyFzPLfUivLqomhj4byILBKeN0AtXIXiuK5R/mQz/OqQLbRWzuhVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379722; c=relaxed/simple;
	bh=Mw9KKyNClNR7sKT0girHqQWvFuvWK8iMfXXQpsxP8pI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sdbbiwzRwn6/Ry7YJvCpWAsFAZgCkUv82xN72d0Lj5CmHD1vQUOFfr4mTDuSzFHfhBAWW4BOn94OSOQFKmJhfZTvfiT9b4tXqNdv/yUQEeYFZQKoCly0UzF/F13rGU+bkCCc+B7cYE+huxHA2OZMBEMhf2IPKPBsRQ9TSy3hHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bx50Z5cf2z2TT3C;
	Tue,  5 Aug 2025 15:39:26 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A3B72140143;
	Tue,  5 Aug 2025 15:41:56 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 15:41:56 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 kwepemq500009.china.huawei.com (7.202.195.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 15:41:55 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
	<bobo.shaobowang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] hrtimers: Force update new CPU's next softirq expiration in CPU offlining
Date: Tue, 5 Aug 2025 16:10:25 +0800
Message-ID: <20250805081025.54235-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

To fix this issue, we remove the 'hrtimer_hres_active' and
'tick_nohz_active' check in retrigger_next_event(). It is not a fast
path so we don't care about rare extra cost.

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
v1 -> v2:
Change the commit subject and also change code as suggested by Frederic
link to v1: https://lore.kernel.org/all/20250708101727.166892-1-wangxiongfeng2@huawei.com/
---
 kernel/time/hrtimer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..e8c479329282 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
 	 * of the next expiring timer is enough. The return from the SMP
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
+	 *
+	 * In periodic low resolution mode, the next softirq expiration
+	 * must also be updated.
 	 */
-	if (!hrtimer_hres_active(base) && !tick_nohz_active)
-		return;
-
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
@@ -2295,11 +2295,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 				     &new_base->clock_base[i]);
 	}
 
-	/*
-	 * The migration might have changed the first expiring softirq
-	 * timer on this CPU. Update it.
-	 */
-	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-- 
2.20.1


