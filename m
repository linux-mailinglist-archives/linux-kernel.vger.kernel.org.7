Return-Path: <linux-kernel+bounces-822194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159DB83436
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8931C20498
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69D2DF703;
	Thu, 18 Sep 2025 07:07:46 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E354764
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179265; cv=none; b=bXDlffYdaDgXSnv4n8vmNMqmhmFlSoBWoTWEiDYO32ZiB4K6hhn8hWJZH0CcXdz01O2x/EoOKiAJqn8z+A7Mqomdo65jGeqK5er1MrMI9Elewm1MTXtidY6wKzJ4Sw+Z8PX+9isRGQwhsEzi6kCVEXY0c/AHHkIX69DVEmkKuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179265; c=relaxed/simple;
	bh=IB+fVjE4xeNwiC8Pc/DdCG+yWmkFoeIwJ49WPsCG8Sk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+EQAKUrB6Pp9zlviF4SQmMzg9Z65h+EUOY3O/flZioZaIrJ2xX3aAWo0En2npbTg2qpuBpLw9z6dfJLVvvO5f/oOlsWnzcpYMrGXe9bkuEnit68tEEYvAsvtconE/jotFH8wYG1mId2Wa4TbJEO9R5/xX4LK7lIzLnQDM8IJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cS5mf5HH7zB72Kv;
	Thu, 18 Sep 2025 14:47:46 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Thu, 18 Sep 2025 14:49:16 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <catalin.marinas@arm.com>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>, <yuxiating@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>
Subject: [PATCH] cpu: fix hard lockup triggered during stress-ng stress testing.
Date: Thu, 18 Sep 2025 14:49:07 +0800
Message-ID: <20250918064907.1832-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.38.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

Context of the Issue:
In an ARM64 environment, the following steps were performed:

1. Repeatedly ran stress-ng to stress the CPU, memory, and I/O.
2. Cyclically executed test case pty06 from the LTP test suite.
3. Added mitigations=off to the GRUB parameters.

After 1–2 hours of stress testing, a hardlockup occurred,
causing a system crash.

Root Cause of the Hardlockup:
Each time stress-ng starts, it invokes the /sys/kernel/debug/clear_warn_once
interface, which clears the values in the memory section from __start_once
to __end_once. This caused functions like pr_info_once() — originally
designed to print only once — to print again every time stress-ng was called.
If the pty06 test case happened to be using the serial module at that same
moment, it would sleep in waiter.list within the __down_common function.

After pr_info_once() completed its output using the serial module,
it invoked the semaphore up() function to wake up the process waiting
in waiter.list. This sequence triggered an A-A deadlock, ultimately
leading to a hardlockup and system crash.

To prevent this, a local variable should be used to control and ensure
the print operation occurs only once.

Hard lockup call stack:

_raw_spin_lock_nested+168
ttwu_queue+180 （rq_lock(rq, &rf); 2nd acquiring the rq->__lock）
try_to_wake_up+548
wake_up_process+32
__up+88
up+100
__up_console_sem+96
console_unlock+696
vprintk_emit+428
vprintk_default+64
vprintk_func+220
printk+104
spectre_v4_enable_task_mitigation+344
__switch_to+100
__schedule+1028 (rq_lock(rq, &rf); 1st acquiring the rq->__lock)
schedule_idle+48
do_idle+388
cpu_startup_entry+44
secondary_start_kernel+352

Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 arch/arm64/kernel/proton-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index edf1783ffc81..f8663157e041 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -424,8 +424,10 @@ static bool spectre_v4_mitigations_off(void)
 	bool ret = cpu_mitigations_off() ||
 		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
 
-	if (ret)
-		pr_info_once("spectre-v4 mitigation disabled by command-line option\n");
+	static atomic_t __printk_once = ATOMIC_INIT(0);
+
+	if (ret && !atomic_cmpxchg(&__printk_once, 0, 1))
+		pr_info("spectre-v4 mitigation disabled by command-line option\n");
 
 	return ret;
 }
-- 
2.33.0


