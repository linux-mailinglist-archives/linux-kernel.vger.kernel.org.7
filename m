Return-Path: <linux-kernel+bounces-724240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E3AFF055
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62215485A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A6245000;
	Wed,  9 Jul 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUfX1Tg7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q92SZTtn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EF23E342;
	Wed,  9 Jul 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083806; cv=none; b=rIth/bGZS2dw1AmoMYe8dmMePDoTsOiP/48kEOSPo7fs+RfCuKAzVvPkwjM8Wa3eyYfi7Ay9c8aRPUciEcdIXWwproQ2vCWcix8ZlU8yqDJwlVVTBv7wJJx/HE9GAcEuzfv9Own6nDZkL+RgSbCM5OxLu/jOrSzl0hC52LiSdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083806; c=relaxed/simple;
	bh=Wgc5TeCxTSHrIluk/Zchk1qeFdkcI5CAnbfWjST87wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMbYkOeJF7KYkSbS5yXxuLjZDPSuJxVvGCh1PcAGqiJOxXs3ubbVxLQHutJGgwnPS0bX3aIIUJrFT3avuWqWtuTnP91I40fDum/2Sqh6Raw8/XXwT6PkdoVA6ZKPuSK26uF4kdaV5RMkDg8kyWNuPwpSq5+PzWEcouJG3EGRNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUfX1Tg7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q92SZTtn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJJiizdaOD7bLY57+4l2vOqWNZK0dHtbValv5ybO8Ck=;
	b=FUfX1Tg75+UDVC+tk2h7pdUSG5kj0KVvzb6DwsTvVgrlTvZkUYYZdr3merSsjQGhqoxnsI
	MzRvyVUzx7B8Mv6nnAVz3ciiNmENAIyY9Gfx616lJA6DGzaKIh2TPWqQfQYo221IVM1TYN
	lReUbVY/7pA+kFvHj5tRzx/PtvEzo65qXrB6yyTZh7rM0P02NmBApGTVCoIEMws6+B8Tsn
	TkD8IYVMkFzBUpv7yYDdU3+w0cMr8aBVroEI1Sk6JfWEMe98pLP748x00vl6QlWRj6V38G
	TjQS+9js0uIVl5qDpIDmmsR1cvU4wIZ4ZjzbLEqWaMEWiz7rrDx3DBpQIyEogQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJJiizdaOD7bLY57+4l2vOqWNZK0dHtbValv5ybO8Ck=;
	b=Q92SZTtnDHq3RvlmT51Y2NQoVsOxglNbLpXYNeoIz7M3VSoGTB/o5FhbPPtUeLOXPwjrJK
	F2lx+HIL0ck2s8DA==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v12 12/12] rv: Allow to configure the number of per-task monitor
Date: Wed,  9 Jul 2025 19:56:29 +0200
Message-Id: <32e15f10a6d897ad940ea21d5a51057db395efea.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that there are 2 monitors for real-time applications, users may want to
enable both of them simultaneously. Make the number of per-task monitor
configurable. Default it to 2 for now.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h                     | 9 +--------
 include/linux/sched.h                  | 8 +++-----
 kernel/trace/rv/Kconfig                | 9 +++++++++
 kernel/trace/rv/monitors/rtapp/Kconfig | 1 +
 kernel/trace/rv/rv.c                   | 8 ++++----
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 1d5579f9b75a..97baf58d88b2 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -75,14 +75,7 @@ struct ltl_monitor {};
=20
 #endif /* CONFIG_RV_LTL_MONITOR */
=20
-/*
- * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
- * If we find justification for more monitors, we can think about
- * adding more or developing a dynamic method. So far, none of
- * these are justified.
- */
-#define RV_PER_TASK_MONITORS		1
-#define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
+#define RV_PER_TASK_MONITOR_INIT	(CONFIG_RV_PER_TASK_MONITORS)
=20
 union rv_task_monitor {
 	struct da_monitor	da_mon;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..fabd7fe1a07a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1642,12 +1642,10 @@ struct task_struct {
=20
 #ifdef CONFIG_RV
 	/*
-	 * Per-task RV monitor. Nowadays fixed in RV_PER_TASK_MONITORS.
-	 * If we find justification for more monitors, we can think
-	 * about adding more or developing a dynamic method. So far,
-	 * none of these are justified.
+	 * Per-task RV monitor, fixed in CONFIG_RV_PER_TASK_MONITORS.
+	 * If memory becomes a concern, we can think about a dynamic method.
 	 */
-	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
+	union rv_task_monitor		rv[CONFIG_RV_PER_TASK_MONITORS];
 #endif
=20
 #ifdef CONFIG_USER_EVENTS
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 942d57575e67..c11bf7e61ebf 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -32,6 +32,15 @@ menuconfig RV
 	  For further information, see:
 	    Documentation/trace/rv/runtime-verification.rst
=20
+config RV_PER_TASK_MONITORS
+	int "Maximum number of per-task monitor"
+	depends on RV
+	range 1 8
+	default 2
+	help
+	  This option configures the maximum number of per-task RV monitors that =
can run
+	  simultaneously.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monit=
ors/rtapp/Kconfig
index b7415c3570bb..1ce9370a9ba8 100644
--- a/kernel/trace/rv/monitors/rtapp/Kconfig
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -1,5 +1,6 @@
 config RV_MON_RTAPP
 	depends on RV
+	depends on RV_PER_TASK_MONITORS >=3D 2
 	bool "rtapp monitor"
 	help
 	  Collection of monitors to check for common problems with real-time
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e25d65fe432a..108429d16ec1 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -165,7 +165,7 @@ struct dentry *get_monitors_root(void)
 LIST_HEAD(rv_monitors_list);
=20
 static int task_monitor_count;
-static bool task_monitor_slots[RV_PER_TASK_MONITORS];
+static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
=20
 int rv_get_task_monitor_slot(void)
 {
@@ -173,12 +173,12 @@ int rv_get_task_monitor_slot(void)
=20
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (task_monitor_count =3D=3D RV_PER_TASK_MONITORS)
+	if (task_monitor_count =3D=3D CONFIG_RV_PER_TASK_MONITORS)
 		return -EBUSY;
=20
 	task_monitor_count++;
=20
-	for (i =3D 0; i < RV_PER_TASK_MONITORS; i++) {
+	for (i =3D 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
 		if (task_monitor_slots[i] =3D=3D false) {
 			task_monitor_slots[i] =3D true;
 			return i;
@@ -194,7 +194,7 @@ void rv_put_task_monitor_slot(int slot)
 {
 	lockdep_assert_held(&rv_interface_lock);
=20
-	if (slot < 0 || slot >=3D RV_PER_TASK_MONITORS) {
+	if (slot < 0 || slot >=3D CONFIG_RV_PER_TASK_MONITORS) {
 		WARN_ONCE(1, "RV releasing an invalid slot!: %d\n", slot);
 		return;
 	}
--=20
2.39.5


