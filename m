Return-Path: <linux-kernel+bounces-606591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F7A8B131
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B85190399D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18A24338F;
	Wed, 16 Apr 2025 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSzqyU7J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0f3mNt9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CD230BC2;
	Wed, 16 Apr 2025 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786326; cv=none; b=Aa+mxQdHdX+o/Mylc5CsFiWfsz4F2jP1fdidWtl0P0T7WPtLgF5Pp77wSvMXcRs5I+ay8BbHK7jcjBYWMEHxRXqnrOkA027P4ioDEZnHsjQ1m9l4GQTDrMgbLB7bkuIwklUnWtVTPkk3vfC5awq+5BY3vzV+SaWM5X2btz2IDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786326; c=relaxed/simple;
	bh=BVeL5E+wiIovIP++GsT3Iv4DUmA8kLvmjIjuAfYvGr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/CvZat9iPaoP6nWKMDyALz8dkjijlYlsc2V2bhG79UwUjfgNO+gqC1KpWCBPxqF2zBFPfhPqCWhZq0o85WQnZm3uja6q7LjkSVhJTNb1Qd4+Eodrq7RqQXBRqQZ3tHmCNlTo53L+2oAIRmwZm3BYbW80iB++6V9nZ/rWysu6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSzqyU7J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0f3mNt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9Dz+yAyc9fDYnwYVG5q7HPwB6iAFMk5UyaO7whOF1g=;
	b=dSzqyU7Js/gBtbCjvuUn4yB/S+tk+Lq/kS84dG40owCbBJGtucl7bK3WkQv81rG+eTwt0n
	Y9Q/2s+3a52LPFRT2ytEu4MiuwGP9v1btTAi3wRBWLFp5TmBCGs92VEnLTTxFiI1Hrfx4G
	Wf+V/NRGiNeadTUVbQTDfrQqDedZneQ5WR1P5fXuwrP/3j9WVza0wlmh2OtuAwGuibmbrc
	OBGwQulWkYVWmre08W1V+dr+tspEMYYnPF8QAiQiEaj1g0/223aRZXikTFXAlc5+T+C+eN
	j4T01GBTWDgbY9oJXJTjUL8PkUPCmoFLy7PH+LHia2UG37dXqX3FJEVb6vqIAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9Dz+yAyc9fDYnwYVG5q7HPwB6iAFMk5UyaO7whOF1g=;
	b=d0f3mNt9IyBaHL1HG9QSlpnAl1Afo9MrWh7uCTBPx1BYjK2AbvPZWpOizlCyQRZmAVBVaD
	hyHARsNnLvB/rXCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 19/22] rv: Add rtapp_pagefault monitor
Date: Wed, 16 Apr 2025 08:51:25 +0200
Message-Id: <69b800de1d7ed2640cbec2cf1dd356529801c839.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Userspace real-time applications may have design flaws that they raise
page faults in real-time threads, and thus have unexpected latencies.

Add an linear temporal logic monitor to detect this scenario.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig                       |  1 +
 kernel/trace/rv/Makefile                      |  1 +
 kernel/trace/rv/monitors/pagefault/Kconfig    | 11 +++
 .../trace/rv/monitors/pagefault/pagefault.c   | 80 +++++++++++++++++++
 .../trace/rv/monitors/pagefault/pagefault.h   | 57 +++++++++++++
 .../rv/monitors/pagefault/pagefault_trace.h   | 14 ++++
 kernel/trace/rv/rv_trace.h                    |  1 +
 tools/verification/models/rtapp/pagefault.ltl |  1 +
 8 files changed, 166 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_trace.h
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 5c407d291661..6f86d8501e87 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -42,6 +42,7 @@ source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
+source "kernel/trace/rv/monitors/pagefault/Kconfig"
 # Add new monitors here
=20
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 9b28c2419995..353ecf939d0e 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_RV_MON_SCPD) +=3D monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) +=3D monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) +=3D monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_RTAPP) +=3D monitors/rtapp/rtapp.o
+obj-$(CONFIG_RV_MON_PAGEFAULT) +=3D monitors/pagefault/pagefault.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig b/kernel/trace/rv/m=
onitors/pagefault/Kconfig
new file mode 100644
index 000000000000..b31dee208459
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_PAGEFAULT
+	depends on RV
+	select RV_LTL_MONITOR
+	depends on RV_MON_RTAPP
+	default y
+	select LTL_MON_EVENTS_ID
+	bool "pagefault monitor"
+	help
+	  Monitor that real-time tasks do not raise page faults
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/=
rv/monitors/pagefault/pagefault.c
new file mode 100644
index 000000000000..47f1f909e72c
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "pagefault"
+
+#include <rv_trace.h>
+#include <trace/events/exceptions.h>
+#include <monitors/rtapp/rtapp.h>
+
+#include "pagefault.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon)
+{
+	ltl_atom_set(mon, LTL_RT, rt_task(task));
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
+{
+	if (task_creation)
+		ltl_atom_set(mon, LTL_PAGEFAULT, false);
+}
+
+static void handle_page_fault(void *data, unsigned long address, struct pt=
_regs *regs,
+			      unsigned long error_code)
+{
+	ltl_atom_pulse(current, LTL_PAGEFAULT, true);
+}
+
+static int enable_pagefault(void)
+{
+	int retval;
+
+	retval =3D ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("pagefault", page_fault_kernel, handle_page_fault);
+	rv_attach_trace_probe("pagefault", page_fault_user, handle_page_fault);
+
+	return 0;
+}
+
+static void disable_pagefault(void)
+{
+	rv_detach_trace_probe("rtapp_pagefault", page_fault_kernel, handle_page_f=
ault);
+	rv_detach_trace_probe("rtapp_pagefault", page_fault_user, handle_page_fau=
lt);
+
+	ltl_monitor_destroy();
+}
+
+static struct rv_monitor rv_pagefault =3D {
+	.name =3D "pagefault",
+	.description =3D "Monitor that RT tasks do not raise page faults",
+	.enable =3D enable_pagefault,
+	.disable =3D disable_pagefault,
+};
+
+static int __init register_pagefault(void)
+{
+	return rv_register_monitor(&rv_pagefault, &rv_rtapp);
+}
+
+static void __exit unregister_pagefault(void)
+{
+	rv_unregister_monitor(&rv_pagefault);
+}
+
+module_init(register_pagefault);
+module_exit(unregister_pagefault);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("pagefault: Monitor that RT tasks do not raise page fau=
lts");
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.h b/kernel/trace/=
rv/monitors/pagefault/pagefault.h
new file mode 100644
index 000000000000..f4535c83f7d1
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/rv.h>
+
+#define MONITOR_NAME pagefault
+
+enum ltl_atom {
+	LTL_PAGEFAULT,
+	LTL_RT,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] =3D {
+		"p",
+		"r",
+	};
+
+	return names[atom];
+}
+
+enum ltl_buchi_state {
+	S0,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
+
+static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
+{
+	bool pagefault =3D test_bit(LTL_PAGEFAULT, mon->atoms);
+	bool val3 =3D !pagefault;
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool val1 =3D !rt;
+	bool val4 =3D val1 || val3;
+
+	if (val4)
+		__set_bit(S0, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsi=
gned long *next)
+{
+	bool pagefault =3D test_bit(LTL_PAGEFAULT, mon->atoms);
+	bool val3 =3D !pagefault;
+	bool rt =3D test_bit(LTL_RT, mon->atoms);
+	bool val1 =3D !rt;
+	bool val4 =3D val1 || val3;
+
+	switch (state) {
+	case S0:
+		if (val4)
+			__set_bit(S0, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h b/kernel/=
trace/rv/monitors/pagefault/pagefault_trace.h
new file mode 100644
index 000000000000..fe1f82597b1a
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_PAGEFAULT
+DEFINE_EVENT(event_ltl_monitor_id, event_pagefault,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *=
next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_ltl_monitor_id, error_pagefault,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_PAGEFAULT */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index f9fb848bae91..02c906c9745b 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -172,6 +172,7 @@ TRACE_EVENT(error_ltl_monitor_id,
=20
 	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
 );
+#include <monitors/pagefault/pagefault_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
diff --git a/tools/verification/models/rtapp/pagefault.ltl b/tools/verifica=
tion/models/rtapp/pagefault.ltl
new file mode 100644
index 000000000000..d7ce62102733
--- /dev/null
+++ b/tools/verification/models/rtapp/pagefault.ltl
@@ -0,0 +1 @@
+RULE =3D always (RT imply not PAGEFAULT)
--=20
2.39.5


