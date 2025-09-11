Return-Path: <linux-kernel+bounces-812076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E5B532A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409127BA62D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53020268C73;
	Thu, 11 Sep 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IwYXCmsq"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFE32274C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594720; cv=none; b=Lx766nUkkXsL2Wj/fwXeha262x9xLFb7cVv4CyrR/38U58r7AI5QMqO01THEjiNgbkNn9NPa1d6LScjYGhyyJxGaDn4aQGz0mci6XEM4qZg2Vfd9hmZJ1q1cTiadOTm9DfhzMkDNDa26LHrybKLpvSqX/nNKRLCszRDsm9iwLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594720; c=relaxed/simple;
	bh=9VcG8YrS1rXpit2kdOeKu3ZwWcOcC68kO51/Ufmrlho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSwiGpJvpDLgJ6FLY+qJ4A6JuH2oVNyK52p7CpOOZ4PB5hs2M51Ds9QPZN4+LfHYtmL5ZH07iRGluZhCXoR3uCTQ9CJK1DRKeDkYf8dNLcwsciXW9UXZyMFavqhBcEdvA7+nsGxjMTGTO2eBoNgfgPAIIMqLbOVhPa5LLmbodLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IwYXCmsq; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757594711; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TvDyvUeEGsS0M8RAvpriy4NmYR/Abif6DtPqta6UZk8=;
	b=IwYXCmsqTRWCcD938fp5PmjkYPygZ8n1xzU30tWQk5huMkcVHVCtdxYQenU6C86Rw8aTtWAH/v92p3R83JL9G9XHyh84+aVhXoKeRzaLc5lh/xYa5RsUE4YzzlIMMhX3BXnklSWXnDlmRqlyGOGxgnaV4uvL0iGU5cCbsYcHs8s=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnmLJic_1757594710 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:45:11 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [RFC PATCH 2/4] riscv: event: Initial riscv trace driver support
Date: Thu, 11 Sep 2025 20:44:46 +0800
Message-ID: <20250911124448.1771-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch implements the riscv trace perf driver. It's suitable
for RISC-V processors that implement the trace specification
(N-Trace or E-Trace). Users can specify the riscv_trace driver
through the perf program.

The driver adds two format attributes, start_addr and stop_addr,
to specify the valid instruction range for tracing. It also
supports specifying the priv_mode (user and kernel) to specify
the valid privilege mode for tracing.

The reference commands are as follows:

  cat /sys/bus/event_source/devices/riscv_trace/format/*
  perf record -e riscv_trace// ls
  perf record -e riscv_trace/start_addr=0x1234,stop_addr=0x5678/ ls
  perf record -e riscv_trace/start_addr=0x1234,stop_addr=0x5678/k ls
  perf report -D

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/Kbuild                       |   1 +
 arch/riscv/Kconfig                      |   2 +
 arch/riscv/events/Kconfig               |  11 ++
 arch/riscv/events/Makefile              |   3 +
 arch/riscv/events/riscv_trace.c         | 145 +++++++++++++++++++++
 arch/riscv/events/riscv_trace.h         | 123 ++++++++++++++++++
 arch/riscv/events/riscv_trace_encoder.c | 109 ++++++++++++++++
 arch/riscv/events/riscv_trace_funnel.c  | 160 ++++++++++++++++++++++++
 arch/riscv/events/riscv_trace_sink.c    | 100 +++++++++++++++
 9 files changed, 654 insertions(+)
 create mode 100644 arch/riscv/events/Kconfig
 create mode 100644 arch/riscv/events/Makefile
 create mode 100644 arch/riscv/events/riscv_trace.c
 create mode 100644 arch/riscv/events/riscv_trace.h
 create mode 100644 arch/riscv/events/riscv_trace_encoder.c
 create mode 100644 arch/riscv/events/riscv_trace_funnel.c
 create mode 100644 arch/riscv/events/riscv_trace_sink.c

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index 126fb738fc44..8107a614c428 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -4,6 +4,7 @@ obj-y += kernel/ mm/ net/
 obj-$(CONFIG_CRYPTO) += crypto/
 obj-y += errata/
 obj-$(CONFIG_KVM) += kvm/
+obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 51dcd8eaa243..145d3424651b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1374,3 +1374,5 @@ endmenu # "CPU Power Management"
 source "arch/riscv/kvm/Kconfig"
 
 source "drivers/acpi/Kconfig"
+
+source "arch/riscv/events/Kconfig"
diff --git a/arch/riscv/events/Kconfig b/arch/riscv/events/Kconfig
new file mode 100644
index 000000000000..c6fb073b29b1
--- /dev/null
+++ b/arch/riscv/events/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Performance monitoring"
+
+config PERF_EVENTS_RISCV_TRACE
+	tristate "RISCV TRACE events"
+	depends on PERF_EVENTS && RISCV
+	default m
+	help
+	  Include support for riscv trace events.
+
+endmenu
diff --git a/arch/riscv/events/Makefile b/arch/riscv/events/Makefile
new file mode 100644
index 000000000000..5014de2847df
--- /dev/null
+++ b/arch/riscv/events/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PERF_EVENTS_RISCV_TRACE) += riscv_trace_pmu.o
+riscv_trace_pmu-objs := riscv_trace.o riscv_trace_encoder.o riscv_trace_funnel.o riscv_trace_sink.o
diff --git a/arch/riscv/events/riscv_trace.c b/arch/riscv/events/riscv_trace.c
new file mode 100644
index 000000000000..e408d9a4034a
--- /dev/null
+++ b/arch/riscv/events/riscv_trace.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/limits.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/perf_event.h>
+
+#include "riscv_trace.h"
+
+LIST_HEAD(riscv_trace_controllers);
+static struct riscv_trace_pmu riscv_trace_pmu;
+
+PMU_FORMAT_ATTR(start_addr, "config:0-63");
+PMU_FORMAT_ATTR(stop_addr,  "config1:0-63");
+
+static struct attribute *riscv_trace_filter_attrs[] = {
+	&format_attr_start_addr.attr,
+	&format_attr_stop_addr.attr,
+	NULL,
+};
+
+static struct attribute_group riscv_trace_filter_attr_group = {
+	.name = "format",
+	.attrs = riscv_trace_filter_attrs,
+};
+
+static const struct attribute_group *riscv_trace_attr_groups[] = {
+	&riscv_trace_filter_attr_group,
+	NULL
+};
+
+static void riscv_trace_init_filter_attrs(struct perf_event *event)
+{
+	riscv_trace_pmu.filter_attr.start_addr = event->attr.config;
+	riscv_trace_pmu.filter_attr.stop_addr  = event->attr.config1;
+
+	if (event->attr.exclude_kernel)
+		riscv_trace_pmu.filter_attr.priv_mode =
+		    RISCV_TRACE_PRIV_MODE_EXCL_KERN;
+	else if (event->attr.exclude_user)
+		riscv_trace_pmu.filter_attr.priv_mode =
+		    RISCV_TRACE_PRIV_MODE_EXCL_USER;
+	else
+		riscv_trace_pmu.filter_attr.priv_mode =
+		    RISCV_TRACE_PRIV_MODE_EXCL_NONE;
+
+	pr_info("start_addr=0x%llx stop_addr=0x%llx priv_mode=%d\n",
+		riscv_trace_pmu.filter_attr.start_addr,
+		riscv_trace_pmu.filter_attr.stop_addr,
+		riscv_trace_pmu.filter_attr.priv_mode);
+}
+
+static int riscv_trace_event_init(struct perf_event *event)
+{
+	if (event->attr.type != riscv_trace_pmu.pmu.type)
+		return -ENOENT;
+
+	riscv_trace_init_filter_attrs(event);
+
+	return 0;
+}
+
+static int riscv_trace_event_add(struct perf_event *event, int flags)
+{
+	pr_info("%s:%d\n", __func__, __LINE__);
+	// TODO: Configuring the trace component
+	return 0;
+}
+
+static void riscv_trace_event_del(struct perf_event *event, int flags)
+{
+	// TODO: Reset the trace component
+	pr_info("%s:%d\n", __func__, __LINE__);
+}
+
+static void riscv_trace_event_start(struct perf_event *event, int flags)
+{
+	pr_info("%s:%d on_cpu=%d cpu=%d\n", __func__, __LINE__,
+		event->oncpu, event->cpu);
+	// TODO: Enable the trace component
+}
+
+static void riscv_trace_event_stop(struct perf_event *event, int flags)
+{
+	pr_info("%s:%d on_cpu=%d cpu=%d\n", __func__, __LINE__,
+		event->oncpu, event->cpu);
+	// TODO: Disable the trace component
+}
+
+static int __init riscv_trace_init(void)
+{
+	struct riscv_trace_component *component;
+
+	riscv_trace_encoder_init();
+	riscv_trace_funnel_init();
+	riscv_trace_sink_init();
+
+	if (get_list_count(&riscv_trace_controllers) == 0)
+		return -ENXIO;
+
+	list_for_each_entry(component, &riscv_trace_controllers, list) {
+		pr_info("type=%s in_num=%d out_num=%d\n",
+			riscv_trace_type2str(component->type),
+			component->in_num, component->out_num);
+		for (int i = 0; i < component->in_num; i++) {
+			pr_info("\t in[%d] type=%s base_addr=0x%llx\n", i,
+				riscv_trace_type2str(component->in[i]->type),
+				component->in[i]->base_addr);
+		}
+		for (int j = 0; j < component->out_num; j++) {
+			pr_info("\t out[%d] type=%s base_addr=0x%llx\n", j,
+				riscv_trace_type2str(component->out[j]->type),
+				component->out[j]->base_addr);
+		}
+	}
+
+	riscv_trace_pmu.pmu.module       = THIS_MODULE,
+	riscv_trace_pmu.pmu.name         = "riscv_trace",
+	riscv_trace_pmu.pmu.capabilities = PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	riscv_trace_pmu.pmu.attr_groups  = riscv_trace_attr_groups;
+	riscv_trace_pmu.pmu.task_ctx_nr  = perf_sw_context,
+	riscv_trace_pmu.pmu.event_init   = riscv_trace_event_init;
+	riscv_trace_pmu.pmu.add          = riscv_trace_event_add;
+	riscv_trace_pmu.pmu.del          = riscv_trace_event_del;
+	riscv_trace_pmu.pmu.start        = riscv_trace_event_start;
+	riscv_trace_pmu.pmu.stop         = riscv_trace_event_stop;
+
+	return perf_pmu_register(&riscv_trace_pmu.pmu, "riscv_trace", -1);
+}
+
+static void __exit riscv_trace_exit(void)
+{
+	perf_pmu_unregister(&riscv_trace_pmu.pmu);
+}
+
+module_init(riscv_trace_init);
+module_exit(riscv_trace_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Chen Pei <cp0613@linux.alibaba.com>");
+MODULE_DESCRIPTION("Driver for RISC-V Trace Device");
diff --git a/arch/riscv/events/riscv_trace.h b/arch/riscv/events/riscv_trace.h
new file mode 100644
index 000000000000..ef0af0d0b2ee
--- /dev/null
+++ b/arch/riscv/events/riscv_trace.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __RISCV_TRACE_H__
+#define __RISCV_TRACE_H__
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/types.h>
+#include <linux/perf_event.h>
+
+#define RISCV_TRACE_ADDR_MASK GENMASK(63, 0)
+
+enum RISCV_TRACE_COMPONENT_TYPE {
+	RISCV_TRACE_ENCODER = 0,
+	RISCV_TRACE_FUNNEL,
+	RISCV_TRACE_SINK,
+};
+
+enum RISCV_TRACE_FUNNEL_LEVEL {
+	LEVEL1_FUNNEL = 1,
+	LEVEL2_FUNNEL = 2,
+};
+
+enum RISCV_TRACE_PRIV_MODE_TYPE {
+	RISCV_TRACE_PRIV_MODE_EXCL_NONE = 0,
+	RISCV_TRACE_PRIV_MODE_EXCL_KERN,
+	RISCV_TRACE_PRIV_MODE_EXCL_USER,
+};
+
+struct riscv_trace_filter_attr {
+	u64 start_addr;
+	u64 stop_addr;
+	u32 priv_mode;		// user&kernel
+};
+
+struct riscv_io_port {
+	bool is_input;		// input=1, output=0
+	u32 endpoint_num;
+	enum RISCV_TRACE_COMPONENT_TYPE type;
+	u64 base_addr;
+};
+
+struct riscv_trace_encoder {
+	u32 cpu;
+};
+
+struct riscv_trace_funnel {
+	enum RISCV_TRACE_FUNNEL_LEVEL level;
+};
+
+struct riscv_trace_sink {
+	;
+};
+
+struct riscv_trace_component {
+	enum RISCV_TRACE_COMPONENT_TYPE type;
+	u64 reg_base;
+	u64 reg_size;
+	struct list_head list;
+
+	union {
+		struct riscv_trace_encoder encoder;
+		struct riscv_trace_funnel funnel;
+		struct riscv_trace_sink sink;
+	};
+
+	u32 in_num;
+	u32 out_num;
+	struct riscv_io_port **in;
+	struct riscv_io_port **out;
+};
+
+extern struct list_head riscv_trace_controllers;
+
+struct riscv_trace_pmu {
+	struct pmu pmu;
+	struct riscv_trace_filter_attr filter_attr;
+};
+
+static inline const char *riscv_trace_type2str(enum RISCV_TRACE_COMPONENT_TYPE
+					       type)
+{
+	switch (type) {
+	case RISCV_TRACE_ENCODER:
+		return "encoder";
+	case RISCV_TRACE_FUNNEL:
+		return "funnel";
+	case RISCV_TRACE_SINK:
+		return "sink";
+	default:
+		return "none";
+	}
+}
+
+static inline int count_device_node_child(struct device_node *parent)
+{
+	struct device_node *child;
+	int count = 0;
+
+	for_each_child_of_node(parent, child) {
+		count++;
+	}
+
+	return count;
+}
+
+static inline int get_list_count(struct list_head *head)
+{
+	u32 count = 0;
+	struct list_head *pos;
+
+	list_for_each(pos, head) {
+		count++;
+	}
+
+	return count;
+}
+
+int riscv_trace_encoder_init(void);
+int riscv_trace_funnel_init(void);
+int riscv_trace_sink_init(void);
+
+#endif /* __RISCV_TRACE_H__ */
diff --git a/arch/riscv/events/riscv_trace_encoder.c b/arch/riscv/events/riscv_trace_encoder.c
new file mode 100644
index 000000000000..fb2c37c3561a
--- /dev/null
+++ b/arch/riscv/events/riscv_trace_encoder.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+#include "riscv_trace.h"
+
+static const struct of_device_id riscv_trace_encoder_of_match[] = {
+	{.compatible = "riscv_trace,encoder-controller", },
+	{ },
+};
+
+int riscv_trace_encoder_init(void)
+{
+	struct riscv_trace_component *component;
+	struct device_node *node, *child_node, *port_node;
+	struct riscv_io_port *io_port;
+	resource_size_t base, size;
+	u32 reg[4];
+	int port_nr;
+	int ret;
+
+	for_each_matching_node(node, riscv_trace_encoder_of_match) {
+		if (!of_device_is_available(node)) {
+			of_node_put(node);
+			continue;
+		}
+
+		component = kzalloc(sizeof(*component), GFP_KERNEL);
+		if (!component)
+			return -ENOMEM;
+		component->type = RISCV_TRACE_ENCODER;
+
+		ret = of_property_read_u32_array(node, "reg", &reg[0], 4);
+		if (ret) {
+			pr_err("Failed to read 'reg'\n");
+			of_node_put(node);
+			return ret;
+		}
+		base = ((resource_size_t) reg[0] << 32) | reg[1];
+		size = ((resource_size_t) reg[2] << 32) | reg[3];
+		pr_info("base=0x%llx size=0x%llx\n", base, size);
+		component->reg_base = (u64)ioremap(base, size);
+		component->reg_size = size;
+		pr_info("reg_base=0x%llx reg_size=0x%llx\n",
+			component->reg_base, component->reg_size);
+
+		ret =
+		    of_property_read_u32(node, "cpu", &component->encoder.cpu);
+		if (ret) {
+			pr_err("Failed to read 'cpu'\n");
+			of_node_put(node);
+			return ret;
+		}
+		pr_info("cpu=%d\n", component->encoder.cpu);
+
+		child_node = of_get_child_by_name(node, "output_port");
+		if (!child_node) {
+			pr_err("Failed to find 'output_port'\n");
+			of_node_put(node);
+			return -ENODEV;
+		}
+		component->out_num = count_device_node_child(child_node);
+		if (component->out_num) {
+			component->out =
+			    krealloc_array(component->out, component->out_num,
+					   sizeof(*component->out), GFP_KERNEL);
+			if (!component->out)
+				return -ENOMEM;
+			port_nr = 0;
+
+			for_each_child_of_node(child_node, port_node) {
+				if (!of_device_is_available(port_node)) {
+					of_node_put(child_node);
+					continue;
+				}
+				pr_info("Found output_port: %pOF\n", port_node);
+				const struct device_node *endpoint_node =
+				    of_parse_phandle(port_node, "endpoint", 0);
+				pr_info("\t endpoint: %pOF\n", endpoint_node);
+
+				of_property_read_u32_array((struct device_node
+							    *)endpoint_node,
+							   "reg", &reg[0], 4);
+
+				io_port =
+				    kmalloc(sizeof(struct riscv_io_port),
+					    GFP_KERNEL);
+				io_port->is_input = false;
+				io_port->endpoint_num = port_nr;
+				io_port->type = RISCV_TRACE_FUNNEL;
+				io_port->base_addr =
+				    ((u64) reg[0] << 32) | reg[1];
+				component->out[port_nr] = io_port;
+				port_nr++;
+			}
+		}
+
+		INIT_LIST_HEAD(&component->list);
+		list_add_tail(&component->list, &riscv_trace_controllers);
+	}
+
+	return ret;
+}
diff --git a/arch/riscv/events/riscv_trace_funnel.c b/arch/riscv/events/riscv_trace_funnel.c
new file mode 100644
index 000000000000..c6d412fd1f90
--- /dev/null
+++ b/arch/riscv/events/riscv_trace_funnel.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+#include "riscv_trace.h"
+
+static const struct of_device_id riscv_trace_funnel_of_match[] = {
+	{.compatible = "riscv_trace,funnel-controller", },
+	{ },
+};
+
+int riscv_trace_funnel_init(void)
+{
+	struct riscv_trace_component *component;
+	struct device_node *node, *child_node, *port_node;
+	struct riscv_io_port *io_port;
+	resource_size_t base, size;
+	u32 reg[4];
+	int port_nr;
+	int ret;
+
+	for_each_matching_node(node, riscv_trace_funnel_of_match) {
+		if (!of_device_is_available(node)) {
+			of_node_put(node);
+			continue;
+		}
+
+		component = kzalloc(sizeof(*component), GFP_KERNEL);
+		if (!component)
+			return -ENOMEM;
+		component->type = RISCV_TRACE_FUNNEL;
+
+		ret = of_property_read_u32_array(node, "reg", &reg[0], 4);
+		if (ret) {
+			pr_err("Failed to read 'reg'\n");
+			of_node_put(node);
+			return ret;
+		}
+		base = ((resource_size_t) reg[0] << 32) | reg[1];
+		size = ((resource_size_t) reg[2] << 32) | reg[3];
+		pr_info("base=0x%llx size=0x%llx\n", base, size);
+		component->reg_base = (u64)ioremap(base, size);
+		component->reg_size = size;
+		pr_info("reg_base=0x%llx reg_size=0x%llx\n",
+			component->reg_base, component->reg_size);
+
+		ret =
+		    of_property_read_u32(node, "level",
+					 &component->funnel.level);
+		if (ret)
+			component->funnel.level = LEVEL1_FUNNEL;
+		pr_info("funnel level=%d\n", component->funnel.level);
+
+		child_node = of_get_child_by_name(node, "input_port");
+		if (!child_node) {
+			pr_err("Failed to find 'input_port'\n");
+			of_node_put(node);
+			return -ENODEV;
+		}
+		component->in_num = count_device_node_child(child_node);
+		if (component->in_num) {
+			component->in =
+			    krealloc_array(component->in, component->in_num,
+					   sizeof(*component->in), GFP_KERNEL);
+			if (!component->in)
+				return -ENOMEM;
+			port_nr = 0;
+
+			for_each_child_of_node(child_node, port_node) {
+				if (!of_device_is_available(port_node)) {
+					of_node_put(child_node);
+					continue;
+				}
+				pr_info("Found input_port: %pOF\n", port_node);
+				const struct device_node *endpoint_node =
+				    of_parse_phandle(port_node, "endpoint", 0);
+				pr_info("\t endpoint: %pOF\n", endpoint_node);
+
+				of_property_read_u32_array((struct device_node
+							    *)endpoint_node,
+							   "reg", &reg[0], 4);
+
+				io_port =
+				    kmalloc(sizeof(struct riscv_io_port),
+					    GFP_KERNEL);
+				io_port->is_input = true;
+				io_port->endpoint_num = port_nr;
+				io_port->type = RISCV_TRACE_ENCODER;
+				io_port->base_addr =
+				    ((u64) reg[0] << 32) | reg[1];
+				component->in[port_nr] = io_port;
+				port_nr++;
+			}
+		}
+
+		child_node = of_get_child_by_name(node, "output_port");
+		if (!child_node) {
+			pr_err("Failed to find 'output_port'\n");
+			of_node_put(node);
+			return -ENODEV;
+		}
+		component->out_num = count_device_node_child(child_node);
+		if (component->out_num) {
+			component->out =
+			    krealloc_array(component->out, component->out_num,
+					   sizeof(*component->out), GFP_KERNEL);
+			if (!component->out)
+				return -ENOMEM;
+			port_nr = 0;
+
+			for_each_child_of_node(child_node, port_node) {
+				if (!of_device_is_available(port_node)) {
+					of_node_put(child_node);
+					continue;
+				}
+				pr_info("Found output_port: %pOF\n", port_node);
+				const struct device_node *endpoint_node =
+				    of_parse_phandle(port_node, "endpoint", 0);
+				pr_info("\t endpoint: %pOF\n", endpoint_node);
+
+				of_property_read_u32_array((struct device_node
+							    *)endpoint_node,
+							   "reg", &reg[0], 4);
+
+				io_port =
+				    kmalloc(sizeof(struct riscv_io_port),
+					    GFP_KERNEL);
+				io_port->is_input = false;
+				io_port->endpoint_num = port_nr;
+				io_port->type = RISCV_TRACE_SINK;
+				io_port->base_addr =
+				    ((u64) reg[0] << 32) | reg[1];
+				component->out[port_nr] = io_port;
+				port_nr++;
+			}
+		}
+
+		for (int i = 0; i < component->in_num; i++) {
+			pr_info("\t in[%d]is_input=%d endpoint_num=%d\n", i,
+				component->in[i]->is_input,
+				component->in[i]->endpoint_num);
+		}
+		for (int j = 0; j < component->out_num; j++) {
+			pr_info("\t out[%d]is_input=%d endpoint_num=%d\n", j,
+				component->out[j]->is_input,
+				component->out[j]->endpoint_num);
+		}
+
+		INIT_LIST_HEAD(&component->list);
+		list_add_tail(&component->list, &riscv_trace_controllers);
+	}
+
+	return ret;
+}
diff --git a/arch/riscv/events/riscv_trace_sink.c b/arch/riscv/events/riscv_trace_sink.c
new file mode 100644
index 000000000000..dbdc153d798c
--- /dev/null
+++ b/arch/riscv/events/riscv_trace_sink.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+#include "riscv_trace.h"
+
+static const struct of_device_id riscv_trace_sink_of_match[] = {
+	{.compatible = "riscv_trace,sink-controller", },
+	{ },
+};
+
+int riscv_trace_sink_init(void)
+{
+	struct riscv_trace_component *component;
+	struct device_node *node, *child_node, *port_node;
+	struct riscv_io_port *io_port;
+	resource_size_t base, size;
+	u32 reg[4];
+	int port_nr;
+	int ret;
+
+	for_each_matching_node(node, riscv_trace_sink_of_match) {
+		if (!of_device_is_available(node)) {
+			of_node_put(node);
+			continue;
+		}
+
+		component = kzalloc(sizeof(*component), GFP_KERNEL);
+		if (!component)
+			return -ENOMEM;
+		component->type = RISCV_TRACE_SINK;
+
+		ret = of_property_read_u32_array(node, "reg", &reg[0], 4);
+		if (ret) {
+			pr_err("Failed to read 'reg'\n");
+			of_node_put(node);
+			return ret;
+		}
+		base = ((resource_size_t) reg[0] << 32) | reg[1];
+		size = ((resource_size_t) reg[2] << 32) | reg[3];
+		pr_info("base=0x%llx size=0x%llx\n", base, size);
+		component->reg_base = (u64)ioremap(base, size);
+		component->reg_size = size;
+		pr_info("reg_base=0x%llx reg_size=0x%llx\n",
+			component->reg_base, component->reg_size);
+
+		child_node = of_get_child_by_name(node, "input_port");
+		if (!child_node) {
+			pr_err("Failed to find 'input_port'\n");
+			of_node_put(node);
+			return -ENODEV;
+		}
+		component->in_num = count_device_node_child(child_node);
+		if (component->in_num) {
+			component->in =
+			    krealloc_array(component->in, component->in_num,
+					   sizeof(*component->in), GFP_KERNEL);
+			if (!component->in)
+				return -ENOMEM;
+			port_nr = 0;
+
+			for_each_child_of_node(child_node, port_node) {
+				if (!of_device_is_available(port_node)) {
+					of_node_put(child_node);
+					continue;
+				}
+				pr_info("Found input_port: %pOF\n", port_node);
+				const struct device_node *endpoint_node =
+				    of_parse_phandle(port_node, "endpoint", 0);
+				pr_info("\t endpoint: %pOF\n", endpoint_node);
+
+				of_property_read_u32_array((struct device_node
+							    *)endpoint_node,
+							   "reg", &reg[0], 4);
+
+				io_port =
+				    kmalloc(sizeof(struct riscv_io_port),
+					    GFP_KERNEL);
+				io_port->is_input = true;
+				io_port->endpoint_num = port_nr;
+				io_port->type = RISCV_TRACE_FUNNEL;
+				io_port->base_addr =
+				    ((u64) reg[0] << 32) | reg[1];
+				component->in[port_nr] = io_port;
+				port_nr++;
+			}
+		}
+
+		INIT_LIST_HEAD(&component->list);
+		list_add_tail(&component->list, &riscv_trace_controllers);
+	}
+
+	return ret;
+}
-- 
2.49.0


