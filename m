Return-Path: <linux-kernel+bounces-643982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FC0AB3542
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E19717E2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B17270552;
	Mon, 12 May 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NS66fhMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gITnByEl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80226A0BD;
	Mon, 12 May 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047086; cv=none; b=deawExvgd3mAs83eC8pgBiiGeFgb9pfH16mpZQbAKjvV4bK+09hppbkfKOVMOnzIdP95+e6f80OXn3onhUYhR6i4O1CSMebUagihycCDX5BzkwzK9aT2lSZgs9TaajJExBMLNZfj1e8zZjTA745nbJmzgGDB3FNU+L7dZrU9syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047086; c=relaxed/simple;
	bh=2czCiImXsAmZJzn2FQlpUClwLh7GA79Jra4ikQhLWDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YviJtX6Lvnj0u802ULaHbnbkqqh7ZV5RHPM94t2cE+qo5oNeXOpkGeJmsso2lA0uZFONP2H25d1iCF4lMRnhWlEGwJRlFVEZbTUeE250gqpewf8Gl0oxrGEyDKc9crZR71A/0jpV3qNmBFVVXKNFMWO9EEdhbkfo96WktpipMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NS66fhMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gITnByEl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBIKiW056yrZxmMqPozSXv6EvwDpQqjnLuAKDsRWNDI=;
	b=NS66fhMcFNPcnmCZOKSTZoQBJckZTpvFGSKr+o/qbvHDmX9Ry8qyb8lHuLtcfEVictdcWN
	ocACxCCORXBcE/N+gNj3kk5GjuGF0O3LYALWAno22oJIC1Br6rd5RP/f/a9e4smhGi9PpJ
	NBuplr80gH2HzeFD4G0O9w2jptpIZe5bsBqq1eEXv4f2QpW6cWU+tQnZC/tpoQdqoyKU3t
	L2LH91ujF2a9XZW9fIJBpaWTMWY+O8aaeAbY9N5HzQVloJbP/Lt1gblTNoY1Gm6aSAN4de
	EdkQIJLcATcexk/nW+5hPk7rhcd3oxBTDf0SZ8nWrqbKqqBnE97DzIpg3jgvIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBIKiW056yrZxmMqPozSXv6EvwDpQqjnLuAKDsRWNDI=;
	b=gITnByEl1uuEuqS8y0Br7rO0JNV0UZtfh35ywT26FRwHRe7seEUi7wPcPZ1S47EfYFujNo
	c3c6OhXCv3mB6sBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 19/22] rv: Add rtapp_pagefault monitor
Date: Mon, 12 May 2025 12:51:02 +0200
Message-Id: <aabc4f70cd17e3a3928e2312cd47320540fb0fe7.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig                       |  1 +
 kernel/trace/rv/Makefile                      |  1 +
 kernel/trace/rv/monitors/pagefault/Kconfig    | 11 +++
 .../trace/rv/monitors/pagefault/pagefault.c   | 87 +++++++++++++++++++
 .../trace/rv/monitors/pagefault/pagefault.h   | 57 ++++++++++++
 .../rv/monitors/pagefault/pagefault_trace.h   | 14 +++
 kernel/trace/rv/rv_trace.h                    |  1 +
 tools/verification/models/rtapp/pagefault.ltl |  1 +
 8 files changed, 173 insertions(+)
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
index 000000000000..80f6d7ecf5cf
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include <linux/tracepoint.h>
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
+	/*
+	 * This includes "actual" real-time tasks and also PI-boosted tasks. A ta=
sk being PI-boosted
+	 * means it is blocking an "actual" real-task, therefore it should also o=
bey the monitor's
+	 * rule, otherwise the "actual" real-task may be delayed.
+	 */
+	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
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
+	rv_attach_trace_probe("rtapp_pagefault", page_fault_kernel, handle_page_f=
ault);
+	rv_attach_trace_probe("rtapp_pagefault", page_fault_user, handle_page_fau=
lt);
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
index 000000000000..94c0fe4fdaa5
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
+		"pa",
+		"rt",
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
index 12fe926ea853..cfa34af5551b 100644
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


