Return-Path: <linux-kernel+bounces-626954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC0AA496B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F397B9340
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C325E81F;
	Wed, 30 Apr 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9AI9JOt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0D0wsxY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9625A63D;
	Wed, 30 Apr 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010976; cv=none; b=p780xqGmcxvotw+a+CtAaH36kRqm6lqeMQtuWI97dxBH8XRKQqGI8R63sIz8zkcl0IpdIKma3ev3/OW85yZBeBH6J1gVpOzuM4QJPkn2WKHizvA/8zblaKXAKOHP1L+KPQ2s/FQzL2Kj2wH1GqtmMBo8G3Q088qPjKGcVPjhePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010976; c=relaxed/simple;
	bh=hQA6qqGvwzZFtAZxFqekDTt+sSU6wgmodPxkSK4vBIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2cCQfJz+e1zILK3ltcdteHoNGjIR6z3nVMPb7zDcQQkpH8rYKNAoKyq8kdmRRzRJLg9Cfkwetg0edP2DM4DIeMQjqkCd43+CYevLKGyL6j1AcPO4f4LdqAARB2wkR27+ixbWKSzLicQTp71u5zoIBEhVYrYVRkAjU34Fp2EMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9AI9JOt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0D0wsxY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US9+bEe6lsHn+NLLmdFqzC4dUUP/fmwKCds5E1h2XJ0=;
	b=f9AI9JOtMsRGJGoDF0caEPwGRRqDJ4fTw9EDX39DCFdKFM/NKlOvzpy+6oSiUXNiffxgcX
	+5CR+g4hPq07UsfIRxttC07DlZSZ6gfbwVIH5qWwRCAlolhinbOlpA78eda/QEz4KHZN18
	5ZOrdcVt7cu5qzNImYYkCrdQ53RGZCTk0ylgbjCr8l+yStK+FTOKkK7O1Wmxp6aNG8hyqJ
	b01S1w+nckvzvedE348UjKSztThsujAjn5SL9F97oUkbTKU8vRVOoxR+uak3w5EvfhQwtg
	kckuYy7KKFFZwjnVaES53gEc5pxERkgH0B/xSyfwQmBZkXlkAg5cxXlEu4nCHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US9+bEe6lsHn+NLLmdFqzC4dUUP/fmwKCds5E1h2XJ0=;
	b=s0D0wsxYOFQjUK7YTwcefKffdR3/S/EAkmAx1sLWc5Hw2ASFSElZlCPaOVA2vHYCfezuio
	7VjeqTt8xzQcsvDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v6 22/22] rv: Allow to configure the number of per-task monitor
Date: Wed, 30 Apr 2025 13:02:37 +0200
Message-Id: <044759be658d4ec5fdb18246ac9ef07eccce9845.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
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
index 2897aad16883..099b23c14e54 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -74,14 +74,7 @@ struct ltl_monitor {};
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
index 45be0fa7a5cc..560782493292 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1623,12 +1623,10 @@ struct task_struct {
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
index 94689d66a79c..6a521c95a03f 100644
--- a/kernel/trace/rv/monitors/rtapp/Kconfig
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -1,5 +1,6 @@
 config RV_MON_RTAPP
 	depends on RV
+	depends on RV_PER_TASK_MONITORS >=3D 2
 	bool "rtapp monitor"
 	help
 	  Collection of monitors to check for common problems with real-time appl=
ication that cause
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index d493fddf411f..ebd4b4b228bf 100644
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


