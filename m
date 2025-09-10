Return-Path: <linux-kernel+bounces-809866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28156B512F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37DA3A32CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAC3164A6;
	Wed, 10 Sep 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GR9sGTCN"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0243019CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497423; cv=none; b=NuiC2xpW3UlNQMGlCTI78UERkDMZHD+4J+c0qGOr6kebC24tFMn99k/lnIIy7SGQo1wvCVwMCEw5qughLpOdjWogRo3ITqdaFL8LRGcsPSfiRuCmVUBDGpATcAZcPsld3dn6L95zzVuWztH5Uu4QBKR6CClzI1Auv9UIKabe4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497423; c=relaxed/simple;
	bh=9dQ/wuvhkUBz7PvlJlj4Z4OrXdId1HfDnjn+JRPto6Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CX0r6pYj3hiFYg49ZNDLpblHUCutpV+y3bIyuP8fCelGT2HTlCtXTJfHIvhlvE4p+U4AfBdDalC+/muzOugB2v1JWWB5ejZvRzsukd2A8HnQVOrsvRx+ZBHwnqMWy/cfu3Mp0puhZ6BaXEuOaCSs7XRtgyr8GEaKR2GXE60Yq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GR9sGTCN; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757497410; bh=wPQQkuqmYZXOeOjxNXyy26AM8VrCT4zRqXtjNnhPomw=;
	h=From:To:Cc:Subject:Date;
	b=GR9sGTCNL6tjUFDipLhNltFfFP5EIfw9v7omTd/V+8V2K8z9Aje7fFnCiD/hBwBi/
	 /1/pL4sXHtD+vnhKSQ6b3a9p9ZN1bpy1MlfvKTd3yXQ638i6KsIqem1gcyEeKHmmIi
	 6T6VxMXOtbYnsQPPN2LbaHqEBZRrurNQ+bc5GatA=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 944A82F0; Wed, 10 Sep 2025 17:37:04 +0800
X-QQ-mid: xmsmtpt1757497024tsb24bg27
Message-ID: <tencent_943DD74006B627A4CC01A3DE6AD98A769207@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5hhD4Y0Bb+F24FaLjnkYrWj101uFxfzaFhZQI62DQkts2Un1MBJ
	 gB/XcTaWJCQfKB3p73F3N3IjPM+v1f0wneMWk/IiaiQ23qY0H+tk6EwiXgwsNzDdu7zUkaTuM25a
	 QOb57Hf7i+3dgugWaq8TUt4jJAvodQzUCGRs/JLaS9UXjpO80zqVJpJ3+Rf3E2m5mMT+X84LLxrU
	 1AGAA1hyx48Ulwi3O6WEStqpVIWLoBQcug80cg4MU3WIoOQySR1G8WxXXnDJI2tVSMEruccKiJ5H
	 34zNjBpJ1RJgNbiw7/R4jj90mISfv0yZDtUwDvCFw5gOzSqdaRRP+FUg53lRU5ZoEr77igZtedIj
	 Fnc0dFVJNRRp7Ss6V/S50zv6H1g8q3loNQmAs9LyIqQsNR97Ilqv9k2+kF/w21e5qEH8rGoHWoLm
	 bYZmS34/RyMZVbgueFhMOPY2A4nhQ+nWndhYqlnJ6ayn4j1WOMai4Sa0EqpYOHCoWkixxJI66cAh
	 m3jkuTR1Fc4hIwI7WQYt8uCBBYIxnjrGS1LzG7fuiwYPQIoIjVEB6Tk7xsHuYpIZRAcgGn0dVfsL
	 MADlMOC3+Y++qqtKMdBqi+acfY2RLic9kKFiQQseP2SDsnKNLuwdNb3PlAHmpvR1dTpoByw7Cflw
	 XBB+uBLTxKBeg5PdiW/5YFzA9m6AVmGBnn9sOrEey952We6hbomUhIySLVr62JGAS0z5uGJN8Bon
	 3ANrH1cy2aF5F/bZfAJHhGwuQargoM5V/gq8h58WbxDkhHAskhtA4t00ZjhpPHqAuFKXMwL8eQJP
	 yvITBlumih1Gfwk5kiyHeIIY+reSHJHIdeEf8b8ZWqBmd4NdaElfknlnzzF9X8e3ssBQyaeeF1xT
	 QYFwR2KFSS0mU4b+iE1G6vBE0uWXM/0hKMXpN367i9tw3e469SbhZKNrQd/nBisFgaUbqRGDCTve
	 4sLDgDxk9GHYRyiVF9UsQMmL2yfOmrrnZEKEk4LRl0QAjWpm7hZ6E9N/kPi/HmrJ8eACwr60TVhV
	 SGskym3XoyEsvB01dhOgeGLdcPF8yDcO/RGzaJyu+10xHZCjH/jcdomnNrNQs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Haofeng Li <920484857@qq.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] kernel/time: Fix spelling mistakes in comments
Date: Wed, 10 Sep 2025 17:37:03 +0800
X-OQ-MSGID: <20250910093703.1408210-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

Correct several typos found in comments across various files in the
kernel/time directory:

- s/syncrhonized/synchronized/ in alarmtimer.c
- s/unspecifed/unspecified/ in clocksource.c
- s/we/be/ in hrtimer.c
- s/succesful/successful/ in posix-timers.c

No functional changes are introduced by these corrections.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 kernel/time/alarmtimer.c   | 2 +-
 kernel/time/clocksource.c  | 2 +-
 kernel/time/hrtimer.c      | 2 +-
 kernel/time/posix-timers.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 577f0e6842d4..069d93bfb0c7 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -35,7 +35,7 @@
 
 /**
  * struct alarm_base - Alarm timer bases
- * @lock:		Lock for syncrhonized access to the base
+ * @lock:		Lock for synchronized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
  * @get_timespec:	Function to read the namespace time correlating to the base
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0aef0e349e49..b5530c517aea 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -144,7 +144,7 @@ static u64 suspend_start;
  * Default for maximum permissible skew when cs->uncertainty_margin is
  * not specified, and the lower bound even when cs->uncertainty_margin
  * is specified.  This is also the default that is used when registering
- * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * clocks with unspecified cs->uncertainty_margin, so this macro is used
  * even in CONFIG_CLOCKSOURCE_WATCHDOG=n kernels.
  */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8cc52c..37e6a5593dbd 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -208,7 +208,7 @@ static bool hrtimer_suitable_target(struct hrtimer *timer, struct hrtimer_clock_
 	/*
 	 * The offline local CPU can't be the default target if the
 	 * next remote target event is after this timer. Keep the
-	 * elected new base. An IPI will we issued to reprogram
+	 * elected new base. An IPI will be issued to reprogram
 	 * it as a last resort.
 	 */
 	if (!hrtimer_base_is_online(this_cpu_base))
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8b582174b1f9..fd311728153b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -535,7 +535,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		goto out;
 	}
 	/*
-	 * After succesful copy out, the timer ID is visible to user space
+	 * After successful copy out, the timer ID is visible to user space
 	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
-- 
2.25.1


