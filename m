Return-Path: <linux-kernel+bounces-834894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDEBA5C86
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB2B32355D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E72D6409;
	Sat, 27 Sep 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezmJ2YR3"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2B283FF0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965677; cv=none; b=RrgX9JcFP2zpz73QVSOuYmqidvTh7Zd6qCBWrr9rcLRhst3LHQsAlDJ438IJnBaJslY3519uhSK2CvbXa/oHbggkdQgy6ILH1b7THSNpFaQ2wJtFa1g32ZLlP8Tj9BrrMyZfXf1MJ4JIQWSMscj/tXqESwxAwqPbeZN1LUHFl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965677; c=relaxed/simple;
	bh=jeb7rl8zg8+aLisYBGAEs6PF7PVnxQDpgkZhyf+GheQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACsSaiOhnLJN7PedZ4/F8FC+nMR/hSo96y5dpAF9/8gx0iBEVQ3pbr2RsmIcZpHHOqS+RpysRoZJ73aqYIAcuy0RxUJZjS92aO9jk6vgPBMez6Yqi1wlPaHKjNdPwQiIaCWwrULomuLH+zY/VIWgM6WUsKmqpmfqHljyuNQFmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezmJ2YR3; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7761b83fd01so2998824b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758965675; x=1759570475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZJQF2ToM0j3zM/VBm9sOhu/IhOrSi3JVR1qNSXG+Bg=;
        b=ezmJ2YR3FNeFCg1Ly2uFPDgWsDlIG2WagiO2e9RTBKc2VVUrExds8ZPRhCp1a3za3T
         065LABfEYfePowwreoxW+Xl1aVe42sqzqWUQ+T8dqFqi7KEyLF3toFbgv0SqrjHFyMFp
         VcJgHbYC8ZHI7eUtz5x7+0L+7BKjAOVGEhJ6jbx8pNYwvACOZQNn3GR7+XscSNDnC5rG
         Hc/9yDXmvUhjQ41nw7Asgsw+K54aT9B71PDEUMa41Pn4GRoZxiUa42ZWjdi4I+WEMGWi
         s0X1KWe6YbYbZiceus798SNrOlsmKwAetnP94igdKnzk3Nthb2aXNzkMzjiyAW8TRXAx
         vGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965675; x=1759570475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZJQF2ToM0j3zM/VBm9sOhu/IhOrSi3JVR1qNSXG+Bg=;
        b=gbbgL0rTXKwVNqJUOe5NSdgSpwGj7GwguD60IW0XuoVRn0RzjX/tCbK27WngG8G0g8
         eIOshOVepjtXLCjdmuZ6qZdCZKGYwwLlSnRdyjGo9Rq+cnZLeOE/boYhR8WJTKQO/CsA
         yrx/SH+19efv9i3UHiKleBD2dywdMxaqQxxwsj8IgM0pt0W0arzDkt6l5bkoHBWBGZkI
         07+2pnQ3CbzjdMfG5+FwvB5kyRUjXifGgTooJsuqGQYxuL/RXnfLKTftkngsLUoZHUeN
         yL3TN+lOBTahLGoVMn80HiOEbM81ugRLbU10TTDehrZfvedz0axiSTTcUyBDqaiDE7XE
         2VXg==
X-Gm-Message-State: AOJu0YzIs4SCNzSVJQDQTivv3yzkN6pDoosL2GmOUfHPwLAgwVqlinJf
	VZTQO4lxWctB3cy0vid/VLMOMGdJQcUv40R6Jb6EuWLAVfB6p7QihqjzSNeCsQoT
X-Gm-Gg: ASbGncsBrnNF4X2UWHvzpfm3adtiuW/CuKJ0IOvweaBMvQ5SQxLsKnuOtdbj3PTHizj
	HGtva7Vi6j1PseH/ssORDIvO9QZc35yBOoND9u5l822TUl6DMdHLL4PhJzzmkbvX2Ndv0olAPPA
	4OC4gV7FP+STi96qssAPOKiqFo1yA82/8h5YCCq6mMT1TKtjibibaJDlTmybLa/cG30hb6UHKKM
	HsPAzTM7lMqUp+9hOmippGAJn5zuAzdDzTCkAHB2zwclJx9h0BRmrRE1g1bIX7wMRJrBimlLw0s
	R0/8JcMITCgI2wkfRy07pGsB1Dzl4ji2wWEluuGGSltEBOtTnNhReLV6+KU2hyji5bTCQOyfgzV
	7oi8fIBidsPbDIt7Hjs9dtRmy89B+RJ55H2gpiVqcWKcDVk2hurE=
X-Google-Smtp-Source: AGHT+IGduf7RatFexr+1b6X7DcBE+qP3/53rkiM5C9YHS72zBqIBvMbbzdx9UD3QSc1k/PHhj29lDQ==
X-Received: by 2002:a05:6a00:1152:b0:77f:d23:a1f3 with SMTP id d2e1a72fcca58-780fcdc70afmr10904702b3a.6.1758965675079;
        Sat, 27 Sep 2025 02:34:35 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1867sm6420816b3a.35.2025.09.27.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:34:34 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] timer: Fix some typos in timer module
Date: Sat, 27 Sep 2025 17:34:10 +0800
Message-Id: <20250927093411.1509275-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in timer module, as below:

  presicion ==> precision
  gobal ==> global
  exectued ==> executed
  refere ==> refer
  avarage ==> average

Just fix it.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 include/linux/delay.h         | 8 ++++----
 kernel/time/posix-timers.c    | 2 +-
 kernel/time/timer_migration.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 89866bab100d..46412c00033a 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ void usleep_range_state(unsigned long min, unsigned long max,
  * @min:	Minimum time in microseconds to sleep
  * @max:	Maximum time in microseconds to sleep
  *
- * For basic information please refere to usleep_range_state().
+ * For basic information please refer to usleep_range_state().
  *
  * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
  */
@@ -82,10 +82,10 @@ static inline void usleep_range(unsigned long min, unsigned long max)
  * @min:	Minimum time in microseconds to sleep
  * @max:	Maximum time in microseconds to sleep
  *
- * For basic information please refere to usleep_range_state().
+ * For basic information please refer to usleep_range_state().
  *
  * The sleeping task has the state TASK_IDLE during the sleep to prevent
- * contribution to the load avarage.
+ * contribution to the load average.
  */
 static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
@@ -96,7 +96,7 @@ static inline void usleep_range_idle(unsigned long min, unsigned long max)
  * ssleep - wrapper for seconds around msleep
  * @seconds:	Requested sleep duration in seconds
  *
- * Please refere to msleep() for detailed information.
+ * Please refer to msleep() for detailed information.
  */
 static inline void ssleep(unsigned int seconds)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index aa3120104a51..36dbb8146517 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1242,7 +1242,7 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
  *    sys_clock_settime(). The kernel internal timekeeping is always using
  *    nanoseconds precision independent of the clocksource device which is
  *    used to read the time from. The resolution of that device only
- *    affects the presicion of the time returned by sys_clock_gettime().
+ *    affects the precision of the time returned by sys_clock_gettime().
  *
  * Returns:
  *	0		Success. @tp contains the resolution
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..d4f4398dec50 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -708,7 +708,7 @@ void tmigr_cpu_activate(void)
 /*
  * Returns true, if there is nothing to be propagated to the next level
  *
- * @data->firstexp is set to expiry of first gobal event of the (top level of
+ * @data->firstexp is set to expiry of first global event of the (top level of
  * the) hierarchy, but only when hierarchy is completely idle.
  *
  * The child and group states need to be read under the lock, to prevent a race
@@ -1621,7 +1621,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   created group (parent).
 	 *
 	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
+	 *   executed in hotplug prepare callback. This is executed by an
 	 *   already connected and !idle CPU. Even if all other CPUs go idle,
 	 *   the CPU executing the setup will be responsible up to current top
 	 *   level group. And the next time it goes inactive, it will release
-- 
2.34.1


