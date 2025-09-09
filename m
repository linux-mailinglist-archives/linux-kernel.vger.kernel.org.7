Return-Path: <linux-kernel+bounces-807893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B2DB4AACD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466AC188CE39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C72D73A7;
	Tue,  9 Sep 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tOPCy29R"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149E318157
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414088; cv=none; b=lfnO+S7NVnLkMIZJLqxioWiGEW5mc6sI7HoQQiDpPboMtyBIaWUoh/Uy9QunrkFNO9EvLmeGRhUrJ7ZjgzSxClkLcjjJvbET0k3L6R+LqxLJPyVBatAZ2hot/7VeCilZkjnN7bCA61ONf60ZNSZC5t6fKW35bJ8DZrLnyYCkmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414088; c=relaxed/simple;
	bh=RhWr9qXEMvY74IqDuTBXERLkwAA7wGTEToSqwVO5DMc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qIu1f5rAYxvZ1caK1J9kcpNSjjefR6nq9UDdy906g8oUZmjlNsRmyc1aRqC+lcuzv+ndE2de3AXLC0C8zKKZMlgyD+jAxD/afNDoa3RCixf6Oe8lU3w9nIHZmfncyyYRY4VQaaxk2asYsJY6aRwzxW34sMnF8WuPAKJ/jWLp5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tOPCy29R; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757413776; bh=O5E372ezwLowZ72oK6ALkS+eRhUxVrptDG7ThKoSsUw=;
	h=From:To:Cc:Subject:Date;
	b=tOPCy29R3jZnPeW3PhmBCF0DaQ/UlR4FBfMCDE9T9jiSIQ4NrtDZzLSIBhWLEsOLx
	 eyL9GmzDhd2tRSdOTx30DyGHba2jX5aHfe455uPTNbtSk+cnBDNddUPFB6Zl7GZcql
	 PE9pKaQIuDUPQL9pMoIDkznUnhUDfcMZ8mWFA7Vo=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5CCA842E; Tue, 09 Sep 2025 18:23:12 +0800
X-QQ-mid: xmsmtpt1757413392tj13oupva
Message-ID: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeFPRYFqonbYhhmWe0egK5Fn4MVdfjMO3m1n5bGU+FPzRbjmtiWs
	 HewNcJzScRtwavDjYIYcZbipN5SybM3U8CMiB1NMbM9+9OEZO5/186ziLL0+n05j11BHA/+AhDcE
	 dGsWJ0LY+uxQxS/dYjNXuo3IqxEwbRqVmtQL6+LHLCu5GcK2ACUHJpH57xBy+RsMhmO5huysIZC3
	 +PHwRANASuhKKsBNVxXoVUsDuZpk8IKk20hwFoGPyXIuBBDT0ZbWsCOih+YHH0B8DA2NlJCQKCi+
	 zmn5bqPWM5Px2gftf4MJCQMjtW1ZcsNcHjISczBJ2WaXjUIT1yZxvE/Xj4TQyLOugpwAw9R1plC9
	 aBPSdQ3NBvHOUksabWNZTzZ/pvoH8MRhq3CLaDP+fzxrbyt82wY8/+FZbBJHGXVCf6taeMosOhyr
	 axQY4/If1nmAGswf1I5ftj20aZdswGf0jAgGrI0Za+DYSytlN17H8v/UaEGWewZAh3gK42N3dudN
	 P7LT342bEiFpy7dAQu2rHQ1/VxOb4Vz9UOZ48Ib2hPpPvMLvfxusYuc8vnYbpb0i+C0ojTV6tAFw
	 dHFBc8Lucz0C9rsdAy+yfTVzZT5XjqpkbuL3omuGYJ37JZVyciwYOczaFKiD4mSI3ugOJ9f0apIY
	 T19F0bMRgHESUbldrrTL4mxM75CqiW0qGmOFohMqISk96LS7uvzCxhmBBwGjWo+JO/f/HG7x1uf7
	 tQndltp7P61ZeWnQbse6uH8rBeS1utq0dnr7F80YN+mYwHa/Ju33h3f25JgA+LDHh3tYwbsaQI9J
	 xlVmJQqc2RtWwjgdFYqXpAO2F/fnHjbO/Aoi95g8Wuo8dDN7GqQ9/rYgOxHsKcGqhFsU/Hn5YTKO
	 pAddZJDxkfV7zXuDIAxzB4s+5PbXJpcwS7pdM4zxf+Q2S/XyJNGmGuXvSklgT5KFbx0UQrdeyciB
	 A5ZlEqZyhBmt/mP7UCbVa+8tK7D/UMCJnpW3dzaLvaIQA4AEfGDMbSYznAHRZQuLtWxioVHMeQzG
	 spUOTcQqBjAUqOF/71/b4CYfF+aWfRxcby3D9hd4fgSrliMisFGNgxwie9DWc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Haofeng Li <920484857@qq.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] timekeeping: Move debug sleep time accounting outside spinlock
Date: Tue,  9 Sep 2025 18:23:09 +0800
X-OQ-MSGID: <20250909102309.1151885-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

The function tk_debug_account_sleep_time() was called inside a spinlock
in __timekeeping_inject_sleeptime(), which could lead to potential
deadlocks, particularly when CONFIG_DEBUG_PM_SLEEP is enabled.

To prevent this, move the call to tk_debug_account_sleep_time() outside
the raw spinlock. Additionally, add a check to ensure it is only called
with a valid time delta, avoiding unnecessary debug accounting when the
time value is zero or invalid.

The same change is applied to timekeeping_inject_sleeptime64() and
timekeeping_resume() to maintain consistency and improve stability across
the timekeeping subsystem.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 kernel/time/timekeeping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b6974fce800c..3c6eb5220149 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1865,7 +1865,6 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 	tk_xtime_add(tk, delta);
 	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
-	tk_debug_account_sleep_time(delta);
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
@@ -1926,6 +1925,9 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
 
+	if (timespec64_valid_strict(delta))
+		tk_debug_account_sleep_time(delta);
+
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
 }
@@ -1986,7 +1988,8 @@ void timekeeping_resume(void)
 	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
-	touch_softlockup_watchdog();
+	if (inject_sleeptime && timespec64_valid_strict(&ts_delta))
+		tk_debug_account_sleep_time(&ts_delta);
 
 	/* Resume the clockevent device(s) and hrtimers */
 	tick_resume();
-- 
2.25.1


