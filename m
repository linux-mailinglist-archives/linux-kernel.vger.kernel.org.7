Return-Path: <linux-kernel+bounces-881379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7DC281AF
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB02D1A21F70
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483923BCE3;
	Sat,  1 Nov 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a5AW46dE"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939782F9DBC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011859; cv=none; b=F0t6DGATzNejblNYfclVJFTpw/2y1FUb6crnTvzE0XmIOnXmnAN+db8jyjz3QBl5Rtic/IpfaOLcjA+cQ/BISm0xqt2WT+qTQJZMkPH26Y3/FJShUG9rrNgaUsK4yY9jgUMeyji5NwIERblAy+KlgnGV2ElumktfHZqJYrAdPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011859; c=relaxed/simple;
	bh=g5rD55j0ewpWZwtP4iDepKmEh3GBb5aXjxdfchIjUts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO5Oiv77L3j0QUPFJQYVLAzP7bC3OMEYd8qkr/gDOYk+EA+9HTw7JzoszZh6sQUGkFlMci5u5J1Wpx3AX5kJo+wh5jbVBf/eefYwalCBiRyVHvHehPUUzChOOFfs9ObXnz+Z82T1Vl23+jOApTQ+zYgXRriFQaMfmX9rlnX/qAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a5AW46dE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29524c38f4fso22196795ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011857; x=1762616657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw3xX0lWv0Z5caNa0HF905Jm6Ibav/ckH29ZGZIeYG0=;
        b=a5AW46dE9IHdzZ2nYC0qH8ODDdmsqR+6Y5n1zCnveKYYe1S4+O+NJQ91GXTDd3DkzC
         u5hB9wAed6gSMZiOSOp4e8Ju8rTJRgIiJCuXOiDWJqQSH87GlHDXYEYUmkTGLF9KZYsh
         gA/aPg6FPvHDnw+9sNdeUHxmWE2ItUUxwcMR8DwxOxmn4Qbn84HetDuyrjmjcxAJxm/N
         YwyjI6Ar9E6xl3s84Ci5K3PiCqslGb5LILN70/vAa1sWFkBaxIDVdYvidGF6y8A0CQLg
         MgFw421qgdy4wvIiRyznOGfC/CdnubBuGEM0uT+EOGSvmrBC+OihDvMmaxNrrN/hjQTI
         x9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011857; x=1762616657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw3xX0lWv0Z5caNa0HF905Jm6Ibav/ckH29ZGZIeYG0=;
        b=tRRPP8KoYmKJ5h1dgc09TJx2yf4E3dGBKdAnNoOGOVXYWk0e6Dg13LSJluRczdDxo4
         eoWvVQz7lBxwcjWEGaQ69IIL1G4GU/VrOhWHfCO8gU3DtQ3gcTDIleMUqxusiIAO3kDX
         Qmvv83s7kN++xY8/kK5P9L/l5OMddlN023XUPHjusDEUuC8SDJHO9tNzlM3QHQVA/Nrk
         By0MQbZuA8npzRvy1STgaXh0t6ILXhQ9NxZ1JHhKuwtiEuSPi78Adgit2AjdVLn7Myvd
         yDacb1Hv57eYG2H6JC8hrTIa6Dz5hZyynzIjGLfZGGf5KcDDqnKX1asADzGLkXPVXO8M
         i1wg==
X-Forwarded-Encrypted: i=1; AJvYcCXTPbCU5CSE4VMFuS0ug7AR2Jc2fO7HZ4XZfOCeDLwmk4ioWx9rclhATwGFD1p3ATQxqORgxP3TJ691/Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzog9waXygI22NtK/csYtlnz6E8FkkdLUtcNNquuNBcjy/23ITq
	dZJtnG7Xi2esCImX4noxOC0mHxwmu2aCuQxdkAeN5thFRQUNXRWM6ttrqbQT9QvG71c=
X-Gm-Gg: ASbGncs38qczYrrE9QIfxUv2ZwvMfiV8BmegZXcYszzCmd8tjgJgEeDH8omuikmvddk
	B4K6elJw92bx3WRNJE3O1vRObDOkux0FNhgwinQI0pgGjD2o+6HUWchxxE2BCV245u1N8BKh+fp
	6EYUGlKGNfV75EBeIp5Wr/iZbmvEI8QFNGCqnOd1WsTMzsI8IBYWsIhfaIYi9oZ3wO7ZbNwUw+O
	5PSw8xTCBgQqro9ePVJ/65oa+buZ5u1Nob2po4Z6fHVcAWyLC1YO/dZ2mna189OiyXtbkeER/ZJ
	fMDcRZy8c73M9gyg/grD31nM4ywTzFTKXcq+7vCqGCee3eRSMOW24vLZz2N7HVzHnEq5YjEu5PA
	ooM/AHGwGAYILQEMgZknxC+YK0WTObHOk/G/h+sjqSbEHhN2VZYTZvybkN+tOPMCnzS0qseuLXH
	EaTuIxhbUtuwWswehWc+pMiZ/vuya+62o=
X-Google-Smtp-Source: AGHT+IFFWL85T9HhS0difffMIWTRJBYYSad8o6w2jHo37Nk+CHybhhZtaAfAEVq3uYrHD502FqqzfA==
X-Received: by 2002:a17:902:ea0d:b0:295:7bbd:52fa with SMTP id d9443c01a7336-2957bbd5b0dmr6783025ad.56.1762011856866;
        Sat, 01 Nov 2025 08:44:16 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:44:16 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 09/12] rvtrace: Add perf driver for tracing using perf tool
Date: Sat,  1 Nov 2025 21:12:42 +0530
Message-ID: <20251101154245.162492-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101154245.162492-1-apatel@ventanamicro.com>
References: <20251101154245.162492-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Add perf driver for RISC-V tracing similar to ARM Coresight and Hisilicon
PTT drivers. The driver adds 'rvtrace' event descriptor which can be used
by the perf tool to record the RISC-V trace data.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/Kconfig        |   1 +
 drivers/hwtracing/rvtrace/Makefile       |   2 +-
 drivers/hwtracing/rvtrace/rvtrace-core.c |   8 +
 drivers/hwtracing/rvtrace/rvtrace-perf.c | 343 +++++++++++++++++++++++
 include/linux/rvtrace.h                  |   3 +
 5 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-perf.c

diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
index 0577f9acb858..ba11acf1117d 100644
--- a/drivers/hwtracing/rvtrace/Kconfig
+++ b/drivers/hwtracing/rvtrace/Kconfig
@@ -4,6 +4,7 @@ menuconfig RVTRACE
 	tristate "RISC-V Trace Support"
 	depends on RISCV
 	depends on OF
+	select PERF_EVENTS
 	default RISCV
 	help
 	  This framework provides a kernel interface for the RISC-V trace
diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
index 122e575da9fb..07403f4d94e3 100644
--- a/drivers/hwtracing/rvtrace/Makefile
+++ b/drivers/hwtracing/rvtrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RVTRACE) += rvtrace.o
-rvtrace-y := rvtrace-core.o rvtrace-platform.o
+rvtrace-y := rvtrace-core.o rvtrace-platform.o rvtrace-perf.o
 obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
 obj-$(CONFIG_RVTRACE_RAMSINK) += rvtrace-ramsink.o
diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
index b955e5f3b048..bbe39aaf930d 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -777,11 +777,19 @@ static int __init rvtrace_init(void)
 		return ret;
 	}
 
+	ret = rvtrace_perf_init();
+	if (ret) {
+		platform_driver_unregister(&rvtrace_platform_driver);
+		bus_unregister(&rvtrace_bustype);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __exit rvtrace_exit(void)
 {
+	rvtrace_perf_exit();
 	platform_driver_unregister(&rvtrace_platform_driver);
 	bus_unregister(&rvtrace_bustype);
 }
diff --git a/drivers/hwtracing/rvtrace/rvtrace-perf.c b/drivers/hwtracing/rvtrace/rvtrace-perf.c
new file mode 100644
index 000000000000..2d3039f8b681
--- /dev/null
+++ b/drivers/hwtracing/rvtrace/rvtrace-perf.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2025 Ventanamicro Limited. All rights reserved.
+ * Author: Mayuresh Chitale <mchitale@venanamicro.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/perf_event.h>
+#include <linux/vmalloc.h>
+#include <linux/percpu-defs.h>
+#include <linux/slab.h>
+#include <linux/stringhash.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <linux/rvtrace.h>
+
+#define RVTRACE_PMU_NAME "rvtrace"
+#define RVTRACE_BUF_LEN (4 * 1024 * 1024)
+
+static struct pmu rvtrace_pmu;
+static DEFINE_SPINLOCK(perf_buf_lock);
+
+/**
+ * struct rvtrace_event_data - RISC-V trace specific perf event data
+ * @work:		Handle to free allocated memory outside IRQ context.
+ * @mask:		Hold the CPU(s) this event was set for.
+ * @aux_hwid_done:	Whether a CPU has emitted the TraceID packet or not.
+ * @path:		An array of path, each slot for one CPU.
+ * @buf:		Aux buffer / pages allocated by perf framework.
+ */
+struct rvtrace_event_data {
+	struct work_struct work;
+	cpumask_t mask;
+	cpumask_t aux_hwid_done;
+	struct rvtrace_path * __percpu *path;
+	struct rvtrace_perf_auxbuf buf;
+};
+
+struct rvtrace_ctxt {
+	struct perf_output_handle handle;
+	struct rvtrace_event_data *event_data;
+};
+
+static DEFINE_PER_CPU(struct rvtrace_ctxt, rvtrace_ctxt);
+
+static void *alloc_event_data(int cpu)
+{
+	struct rvtrace_event_data *event_data;
+	cpumask_t *mask;
+
+	event_data = kzalloc(sizeof(*event_data), GFP_KERNEL);
+	if (!event_data)
+		return NULL;
+
+	/* Update mask as per selected CPUs */
+	mask = &event_data->mask;
+	if (cpu != -1)
+		cpumask_set_cpu(cpu, mask);
+	else
+		cpumask_copy(mask, cpu_present_mask);
+
+	event_data->path = alloc_percpu(struct rvtrace_path *);
+	return event_data;
+}
+
+static void rvtrace_free_aux(void *data)
+{
+	struct rvtrace_event_data *event_data = data;
+
+	schedule_work(&event_data->work);
+}
+
+static struct rvtrace_path **rvtrace_event_cpu_path_ptr(struct rvtrace_event_data *data,
+							int cpu)
+{
+	return per_cpu_ptr(data->path, cpu);
+}
+
+static void free_event_data(struct work_struct *work)
+{
+	struct rvtrace_event_data *event_data;
+	struct rvtrace_path *path;
+	cpumask_t *mask;
+	int cpu;
+
+	event_data = container_of(work, struct rvtrace_event_data, work);
+	mask = &event_data->mask;
+	for_each_cpu(cpu, mask) {
+		path = *rvtrace_event_cpu_path_ptr(event_data, cpu);
+		rvtrace_destroy_path(path);
+	}
+	free_percpu(event_data->path);
+	kfree(event_data);
+}
+
+static void *rvtrace_setup_aux(struct perf_event *event, void **pages,
+			       int nr_pages, bool overwrite)
+{
+	struct rvtrace_event_data *event_data = NULL;
+	struct page **pagelist;
+	int cpu = event->cpu, i;
+	cpumask_t *mask;
+
+	event_data = alloc_event_data(cpu);
+	if (!event_data)
+		return NULL;
+
+	INIT_WORK(&event_data->work, free_event_data);
+	mask = &event_data->mask;
+	/*
+	 * Create the path for each CPU in the mask. In case of any failure skip the CPU
+	 */
+	for_each_cpu(cpu, mask) {
+		struct rvtrace_component *src;
+		struct rvtrace_path *path;
+
+		src = rvtrace_cpu_source(cpu);
+		if (!src)
+			continue;
+
+		path = rvtrace_create_path(src, NULL, RVTRACE_COMPONENT_MODE_PERF);
+		if (!path)
+			continue;
+
+		*rvtrace_event_cpu_path_ptr(event_data, cpu) = path;
+	}
+
+	/* If we don't have any CPUs ready for tracing, abort */
+	cpu = cpumask_first(&event_data->mask);
+	if (cpu >= nr_cpu_ids)
+		goto err;
+
+	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
+	if (!pagelist)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++)
+		pagelist[i] = virt_to_page(pages[i]);
+
+	event_data->buf.base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!event_data->buf.base) {
+		kfree(pagelist);
+		goto err;
+	}
+
+	event_data->buf.nr_pages = nr_pages;
+	event_data->buf.length = nr_pages * PAGE_SIZE;
+	event_data->buf.pos = 0;
+	return event_data;
+err:
+	rvtrace_free_aux(event_data);
+	return NULL;
+}
+
+static void rvtrace_event_read(struct perf_event *event)
+{
+}
+
+static void rvtrace_event_destroy(struct perf_event *event)
+{
+}
+
+static int rvtrace_event_init(struct perf_event *event)
+{
+	if (event->attr.type != rvtrace_pmu.type)
+		return -EINVAL;
+
+	event->destroy = rvtrace_event_destroy;
+	return 0;
+}
+
+static void rvtrace_event_start(struct perf_event *event, int flags)
+{
+	struct rvtrace_ctxt *ctxt = this_cpu_ptr(&rvtrace_ctxt);
+	struct perf_output_handle *handle = &ctxt->handle;
+	struct rvtrace_event_data *event_data;
+	int cpu = smp_processor_id();
+	struct rvtrace_path *path;
+
+	if (WARN_ON(ctxt->event_data))
+		goto fail;
+
+	/*
+	 * Deal with the ring buffer API and get a handle on the
+	 * session's information.
+	 */
+	event_data = perf_aux_output_begin(handle, event);
+	if (!event_data)
+		goto fail;
+
+	if (!cpumask_test_cpu(cpu, &event_data->mask))
+		goto out;
+
+	event_data->buf.pos = handle->head % event_data->buf.length;
+	path = *rvtrace_event_cpu_path_ptr(event_data, cpu);
+	if (!path) {
+		pr_err("Error. Path not found\n");
+		return;
+	}
+
+	if (rvtrace_path_start(path)) {
+		pr_err("Error. Tracing not started\n");
+		return;
+	}
+
+	/*
+	 * output cpu / trace ID in perf record, once for the lifetime
+	 * of the event.
+	 */
+	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
+		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
+		perf_report_aux_output_id(event, cpu);
+	}
+
+out:
+	/* Tell the perf core the event is alive */
+	event->hw.state = 0;
+	ctxt->event_data = event_data;
+	return;
+fail:
+	event->hw.state = PERF_HES_STOPPED;
+}
+
+static void rvtrace_event_stop(struct perf_event *event, int mode)
+{
+	struct rvtrace_ctxt *ctxt = this_cpu_ptr(&rvtrace_ctxt);
+	struct perf_output_handle *handle = &ctxt->handle;
+	struct rvtrace_event_data *event_data;
+	int ret, cpu = smp_processor_id();
+	struct rvtrace_path *path;
+	size_t size;
+
+	if (event->hw.state == PERF_HES_STOPPED)
+		return;
+
+	if (handle->event &&
+	    WARN_ON(perf_get_aux(handle) != ctxt->event_data))
+		return;
+
+	event_data = ctxt->event_data;
+	ctxt->event_data = NULL;
+
+	if (WARN_ON(!event_data))
+		return;
+
+	if (handle->event && (mode & PERF_EF_UPDATE) && !cpumask_test_cpu(cpu, &event_data->mask)) {
+		event->hw.state = PERF_HES_STOPPED;
+		perf_aux_output_end(handle, 0);
+		return;
+	}
+
+	/* stop tracing */
+	path = *rvtrace_event_cpu_path_ptr(event_data, cpu);
+	if (!path) {
+		pr_err("Error. Path not found\n");
+		return;
+	}
+
+	if (rvtrace_path_stop(path)) {
+		pr_err("Error. Tracing not stopped\n");
+		return;
+	}
+
+	event->hw.state = PERF_HES_STOPPED;
+	if (handle->event && (mode & PERF_EF_UPDATE)) {
+		if (WARN_ON_ONCE(handle->event != event))
+			return;
+		spin_lock(&perf_buf_lock);
+		ret = rvtrace_path_copyto_auxbuf(path, &event_data->buf, &size);
+		spin_unlock(&perf_buf_lock);
+		WARN_ON_ONCE(ret);
+		if (READ_ONCE(handle->event))
+			perf_aux_output_end(handle, size);
+		else
+			WARN_ON(size);
+	}
+}
+
+static int rvtrace_event_add(struct perf_event *event, int mode)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int ret = 0;
+
+	if (mode & PERF_EF_START) {
+		rvtrace_event_start(event, 0);
+		if (hwc->state & PERF_HES_STOPPED)
+			ret = -EINVAL;
+	} else {
+		hwc->state = PERF_HES_STOPPED;
+	}
+
+	return ret;
+}
+
+static void rvtrace_event_del(struct perf_event *event, int mode)
+{
+	rvtrace_event_stop(event, PERF_EF_UPDATE);
+}
+
+PMU_FORMAT_ATTR(event, "config:0-0");
+
+static struct attribute *rvtrace_pmu_formats_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group rvtrace_pmu_format_group = {
+	.name = "format",
+	.attrs = rvtrace_pmu_formats_attr,
+};
+
+static const struct attribute_group *rvtrace_pmu_attr_groups[] = {
+	&rvtrace_pmu_format_group,
+	NULL,
+};
+
+int __init rvtrace_perf_init(void)
+{
+	rvtrace_pmu.capabilities	= (PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE);
+	rvtrace_pmu.attr_groups		= rvtrace_pmu_attr_groups;
+	rvtrace_pmu.task_ctx_nr		= perf_sw_context;
+	rvtrace_pmu.read		= rvtrace_event_read;
+	rvtrace_pmu.event_init		= rvtrace_event_init;
+	rvtrace_pmu.setup_aux		= rvtrace_setup_aux;
+	rvtrace_pmu.free_aux		= rvtrace_free_aux;
+	rvtrace_pmu.start		= rvtrace_event_start;
+	rvtrace_pmu.stop		= rvtrace_event_stop;
+	rvtrace_pmu.add			= rvtrace_event_add;
+	rvtrace_pmu.del			= rvtrace_event_del;
+	rvtrace_pmu.module		= THIS_MODULE;
+
+	return perf_pmu_register(&rvtrace_pmu, RVTRACE_PMU_NAME, -1);
+}
+
+void __exit rvtrace_perf_exit(void)
+{
+	perf_pmu_unregister(&rvtrace_pmu);
+}
diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
index cecf6c153ca6..d5f782ac132f 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -343,4 +343,7 @@ static inline int rvtrace_comp_is_empty(struct rvtrace_component *comp)
 				comp->pdata->control_poll_timeout_usecs);
 }
 
+int rvtrace_perf_init(void);
+void rvtrace_perf_exit(void);
+
 #endif
-- 
2.43.0


