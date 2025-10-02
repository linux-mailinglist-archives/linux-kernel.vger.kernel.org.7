Return-Path: <linux-kernel+bounces-839862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D1BB2986
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A8E17645A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290B298CCF;
	Thu,  2 Oct 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DxaxHb4z"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858742D0C7E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385359; cv=none; b=YIAPeI0HQE3aavHvNcMiNsGFn1Rvu32UodDhYuOAyH6R4sjRBrH3k1Qs2/7bvRa8AvuK0ReH6nKJou6QuR5Y8YwiB0y7VNiJ5GtlDZjM8VUM0e8L6POyMdRIezL1qJGjieFRu/2yO/oDU3VvyWb94hE319aBt77/O6EEEeJ8kUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385359; c=relaxed/simple;
	bh=slfHC8PAv5VIT8u+nD/h/2IirRKXgHzJULs1SA2PJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fhy8fGkF7bppYXNWwzogSZ6ZkSfO6gjSoLG86K1UWGWmVRfBfUMVQRvvfjPmDUrVSlGbJqysbbMopVfght6DbHJZxuRbpjtW6Gn4N3dSKRTwQtCi3HWs2DSJCsGkCPjuZRz9HfLZ+dfNbA7YyN/Ep8dyBBjuxsw6qxkPjbHDENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DxaxHb4z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so775688b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385357; x=1759990157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUQPfkbJ3dZW7yGpAIpAlgM0v37IerodzZgj+qIzfvU=;
        b=DxaxHb4zY7HJV5iCD5NAtLnBV10HvC4Vi8pKyxGiUYLU3z0ePsxMrKBMXXZrPYtjQJ
         IZMV8vHvIOha6VB4iy9YhwX0v8sk6a+0pzHIy7UUWNEos7CclMOJGuq7Wt1DlbHMunnS
         AFF53q2rqEXlojAoRwBM6wPMSGezJ3iZ3VzVnZv4PXw7t6EcOLgalurQ+DPIEpy0Tnsu
         AEGZpDiCbbYUTZLaPprPC1t311UmSv1lQvyJaQ9EDoQhsKf+eNKyQv9UGcppzJ35Mn31
         D6ho7Vy1yKLPM9d9nOXRumjak3M5zKCRC8x2VyGnWCU+coYN01+g6BSJKH3q8qqCkGBR
         M+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385357; x=1759990157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUQPfkbJ3dZW7yGpAIpAlgM0v37IerodzZgj+qIzfvU=;
        b=hwnP5Ggfx6Yt6fVZN5MAaA0TIbdZH+BA4EItTltXrE1a3H6SWkVR82EHXPX1pbqwnd
         F3Yb0z6BEjpQ78wrcsl84kCerOk9haNGYmNhGpTNaoLQd2xpsL8Eo4eVm/bDUniYbdhk
         89vrPSKTpnCFs4UDi2vYDtvq7xSygUnrBpRn9BoHMT0Ie0EAnrgszt7PdrSbASq1RteF
         hOJ9WyH7iz/JoBSIynxZxbO9N51wrwipZHuZoS4RDEQSno3Vm/Yd4qh8L2qiTERzHOSc
         l1Km4rarlGPnA2F1hSfPjH2xvGr4/kt+EXwKKWnbXI20gsNr95E0btaxEfH8OfrwALyj
         WOzg==
X-Forwarded-Encrypted: i=1; AJvYcCUtN8rlSbVHeaD9gOiDEP69ErdqPbyVUXEI/FyvsGIJCYQSDHBy5Bv/f6SBrEqMKFS6NG2PRsVI6m+K1mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBnMU2zQD0XL6Sy03vXK1rB+8py0nia/1Eq38ksNr1UO/W6Hm
	QBLjruD3Nzdy5igBYJuRPdDZRxGa8P/T/eX3QXODRtNi0AHyOhnGv3FepX4NeS9nzzc=
X-Gm-Gg: ASbGncvLMasH8M/fhB54Ztf0TLey+9PjydEtXb/es9wZjWkbrxH391ClGPk3olXTM1I
	2yRotdcVKnXR3KpCVRAju3sODoKlHtvoQzzMUUWqfI9q+romDDkmBbQu+qbOwMSzL5rdmmWf0GT
	SIUGVndApM+o7dgTK2fKMmfV8mGYdtmJtO5qTJWqCVONVfVccZpIvbNOa+ZVBIqaQNUgT7DHdYm
	0Waa7IH9ctzsgjqWtQs5AqdfBaf/jnv9xNa8zK1etx6sZNzWirbZjh89fwHyvsSCIegX0ZOwIFb
	Lc6B+ExzdnvsYs9s7UOw1E/K0vLNCO4Wlnu/cHtVx9mMKDXZjeht2EeoSbuqF8Bm/HYHheh6ai+
	L8BllWJQ6piusB80OUHG/F8ZawwDy0XG1jsDDhrQQjrPSAyByDflXYrrNg0LHn9JhiFlf4obU7S
	7WQcs=
X-Google-Smtp-Source: AGHT+IFJYhph88TXwzRm6wpDFKmxs7iIGvjnIRXrwoaN/aRyPB6wF1pi6B0teuXwXD5OsXwiw3KiPw==
X-Received: by 2002:a05:6a21:b8a:b0:2ea:41f1:d53a with SMTP id adf61e73a8af0-321e72b876emr7793339637.41.1759385356653;
        Wed, 01 Oct 2025 23:09:16 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:09:16 -0700 (PDT)
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
Subject: [PATCH 08/11] rvtrace: Add perf driver for tracing using perf tool
Date: Thu,  2 Oct 2025 11:37:29 +0530
Message-ID: <20251002060732.100213-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
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
index aef7e9989165..76379c63c5c3 100644
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
index e874899c8b43..5d4e92f22ccd 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -760,11 +760,19 @@ static int __init rvtrace_init(void)
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
index 17d2fd9234c2..0a454707633b 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -335,4 +335,7 @@ static inline void rvtrace_unregister_driver(struct rvtrace_driver *rtdrv)
 		driver_unregister(&rtdrv->driver);
 }
 
+int rvtrace_perf_init(void);
+void rvtrace_perf_exit(void);
+
 #endif
-- 
2.43.0


