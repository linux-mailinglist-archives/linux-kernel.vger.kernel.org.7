Return-Path: <linux-kernel+bounces-770129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FCB2771C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E361C8623A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6A220680;
	Fri, 15 Aug 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="t+Zxn+B2"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B91514F7;
	Fri, 15 Aug 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229782; cv=none; b=b/7RRgNQrcvDokeS9XhVR8t4RPUCbfplPLQZlDlG7Ml5k2SJYXcwMgnYF/Xrrl4RescMGDyFmbg2MhyH+pTugKfzESA41cqU63UWx2Kco4wTp/lof+PbVhGu/ufCzRaEBO64Ze7ashZYkiynWrvw/5/3O4pzXv8qYTE3w76Id9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229782; c=relaxed/simple;
	bh=cauXBFk4tE6lWLQXyaLXuOCAJb35Bq/CwMVdNesQLgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPTAZ4B5fFaAdwTUeBXRvFAyxHgf/lmWCYeqgPX8OoNVcHf2t+QXmw+LMhHjUJTAmYKUNOPoc8R0ZV6Y7SwrRpiR7YoOl6FIMQ160t+qiSPe+Tfc6k3PA1MyBNJDSEgmo638Qi5XN4uinGRzgjfGaxTIFCclnokGfjOY6K6S15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=t+Zxn+B2; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1755229781; x=1786765781;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cauXBFk4tE6lWLQXyaLXuOCAJb35Bq/CwMVdNesQLgo=;
  b=t+Zxn+B2QDH3HrfjzYBxmWpj8N3fp96iIJex626xPG1sb018Vz0ho5Wq
   H46DVhCP2qIaecSsVlM7CZn7aaCSuJVwfPYIw1SKtRecMBORfkRcyBr6m
   xKiNGaZR2mkJC8TyQdvCZv8BmRRq80bXd2apTRpC1xJ6e9AFfzfRnm3Qe
   jPTK6eFmWJ4rcCoSd+vNXuhtNrwzot2Sa0O1txP4F1UUjHmsmcnLg5kLH
   DYCYr0J04VsBuMm19uajwTbPa+dtwBmOCylB6yGRtpFNnfzSjpnU2N/qJ
   LChejpptDf2G26gV7za3gTS27l/0u+oDcdPlv5DKr+fALyBTuqtRjHaw2
   g==;
X-CSE-ConnectionGUID: 9ldmbF0yQMi+lIzcLpvFFw==
X-CSE-MsgGUID: MF39G4vAROKSNjOE61i6pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="209397936"
X-IronPort-AV: E=Sophos;i="6.17,290,1747666800"; 
   d="scan'208";a="209397936"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([51.138.80.169])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 12:48:29 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id D09BB42A318;
	Fri, 15 Aug 2025 03:48:28 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 8A1251020977;
	Fri, 15 Aug 2025 03:48:23 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id DC24482918F;
	Fri, 15 Aug 2025 03:48:15 +0000 (UTC)
From: Koichi Okuno <fj2767dz@fujitsu.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@fujitsu.com>
Subject: [PATCH v7 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Date: Fri, 15 Aug 2025 12:47:28 +0900
Message-ID: <20250815034751.3726963-2-fj2767dz@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new dynamic PMU to the Perf Events framework to program and
control the Uncore MAC PMUs in Fujitsu chips.

This driver was created with reference to drivers/perf/qcom_l3_pmu.c.

This driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:

perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls

FUJITSU-MONAKA PMU Events Specification v1.1 URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
---
 .../admin-guide/perf/fujitsu_mac_pmu.rst      |  73 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/fujitsu_mac_pmu.c                | 552 ++++++++++++++++++
 5 files changed, 636 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
 create mode 100644 drivers/perf/fujitsu_mac_pmu.c

diff --git a/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
new file mode 100644
index 000000000000..383f3c1bbde7
--- /dev/null
+++ b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
@@ -0,0 +1,73 @@
+====================================================
+Fujitsu Uncore MAC Performance Monitoring Unit (PMU)
+====================================================
+
+This driver supports the Uncore MAC PMUs found in Fujitsu chips.
+Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
+mac_iod<iod>_mac<mac>_ch<ch>.
+
+The driver provides a description of its available events and configuration
+options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/.
+This driver exports:
+- formats, used by perf user space and other tools to configure events
+- events, used by perf user space and other tools to create events
+  symbolically, e.g.:
+    perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
+- cpumask, used by perf user space and other tools to know on which CPUs
+  to open the events
+
+This driver supports the following events:
+- cycles
+  This event counts MAC cycles at MAC frequency.
+- read-count
+  This event counts the number of read requests to MAC.
+- read-count-request
+  This event counts the number of read requests including retry to MAC.
+- read-count-return
+  This event counts the number of responses to read requests to MAC.
+- read-count-request-pftgt
+  This event counts the number of read requests including retry with PFTGT
+  flag.
+- read-count-request-normal
+  This event counts the number of read requests including retry without PFTGT
+  flag.
+- read-count-return-pftgt-hit
+  This event counts the number of responses to read requests which hit the
+  PFTGT buffer.
+- read-count-return-pftgt-miss
+  This event counts the number of responses to read requests which miss the
+  PFTGT buffer.
+- read-wait
+  This event counts outstanding read requests issued by DDR memory controller
+  per cycle.
+- write-count
+  This event counts the number of write requests to MAC (including zero write,
+  full write, partial write, write cancel).
+- write-count-write
+  This event counts the number of full write requests to MAC (not including
+  zero write).
+- write-count-pwrite
+  This event counts the number of partial write requests to MAC.
+- memory-read-count
+  This event counts the number of read requests from MAC to memory.
+- memory-write-count
+  This event counts the number of full write requests from MAC to memory.
+- memory-pwrite-count
+  This event counts the number of partial write requests from MAC to memory.
+- ea-mac
+  This event counts energy consumption of MAC.
+- ea-memory
+  This event counts energy consumption of memory.
+- ea-memory-mac-write
+  This event counts the number of write requests from MAC to memory.
+- ea-ha
+  This event counts energy consumption of HA.
+
+  'ea' is the abbreviation for 'Energy Analyzer'.
+
+Examples for use with perf::
+
+  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
+
+Given that these are uncore PMUs the driver does not support sampling, therefore
+"perf record" will not work. Per-task perf sessions are not supported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 072b510385c4..e0262060db17 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -29,3 +29,4 @@ Performance monitor support
    cxl
    ampere_cspmu
    mrvl-pem-pmu
+   fujitsu_mac_pmu
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index a9188dec36fe..ab4e44c99a53 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
 	 can give information about memory throughput and other related
 	 events.
 
+config FUJITSU_MAC_PMU
+	bool "Fujitsu Uncore MAC PMU"
+	depends on (ARM64 && (ACPI || COMPILE_TEST))
+	help
+	 Provides support for the Uncore MAC performance monitor unit (PMU)
+	 in Fujitsu processors.
+	 Adds the Uncore MAC PMU into the perf events subsystem for
+	 monitoring Uncore MAC events.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 192fc8b16204..be7f74c3b14c 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
 obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
+obj-$(CONFIG_FUJITSU_MAC_PMU) += fujitsu_mac_pmu.o
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
new file mode 100644
index 000000000000..1031e0221bb2
--- /dev/null
+++ b/drivers/perf/fujitsu_mac_pmu.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Uncore MAC PMUs in Fujitsu chips.
+ *
+ * See Documentation/admin-guide/perf/fujitsu_mac_pmu.rst for more details.
+ *
+ * This driver is based on drivers/perf/qcom_l3_pmu.c
+ * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Fujitsu. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/* Number of counters on each PMU */
+#define MAC_NUM_COUNTERS  8
+/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
+#define MAC_EVTYPE_MASK   0xFF
+
+/* Perfmon registers */
+#define MAC_PM_EVCNTR(__cntr)           (0x000 + (__cntr) * 8)
+#define MAC_PM_CNTCTL(__cntr)           (0x100 + (__cntr) * 8)
+#define MAC_PM_CNTCTL_RESET             0
+#define MAC_PM_EVTYPE(__cntr)           (0x200 + (__cntr) * 8)
+#define MAC_PM_EVTYPE_EVSEL(__val)      FIELD_GET(MAC_EVTYPE_MASK, __val)
+#define MAC_PM_CR                       0x400
+#define MAC_PM_CR_RESET                 BIT(1)
+#define MAC_PM_CR_ENABLE                BIT(0)
+#define MAC_PM_CNTENSET                 0x410
+#define MAC_PM_CNTENSET_IDX(__cntr)     BIT(__cntr)
+#define MAC_PM_CNTENCLR                 0x418
+#define MAC_PM_CNTENCLR_IDX(__cntr)     BIT(__cntr)
+#define MAC_PM_CNTENCLR_RESET           0xFF
+#define MAC_PM_INTENSET                 0x420
+#define MAC_PM_INTENSET_IDX(__cntr)     BIT(__cntr)
+#define MAC_PM_INTENCLR                 0x428
+#define MAC_PM_INTENCLR_IDX(__cntr)     BIT(__cntr)
+#define MAC_PM_INTENCLR_RESET           0xFF
+#define MAC_PM_OVSR                     0x440
+#define MAC_PM_OVSR_OVSRCLR_RESET       0xFF
+
+#define MAC_EVENT_CYCLES                        0x000
+#define MAC_EVENT_READ_COUNT                    0x010
+#define MAC_EVENT_READ_COUNT_REQUEST            0x011
+#define MAC_EVENT_READ_COUNT_RETURN             0x012
+#define MAC_EVENT_READ_COUNT_REQUEST_PFTGT      0x013
+#define MAC_EVENT_READ_COUNT_REQUEST_NORMAL     0x014
+#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT   0x015
+#define MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS  0x016
+#define MAC_EVENT_READ_WAIT                     0x017
+#define MAC_EVENT_WRITE_COUNT                   0x020
+#define MAC_EVENT_WRITE_COUNT_WRITE             0x021
+#define MAC_EVENT_WRITE_COUNT_PWRITE            0x022
+#define MAC_EVENT_MEMORY_READ_COUNT             0x040
+#define MAC_EVENT_MEMORY_WRITE_COUNT            0x050
+#define MAC_EVENT_MEMORY_PWRITE_COUNT           0x060
+#define MAC_EVENT_EA_MAC                        0x080
+#define MAC_EVENT_EA_MEMORY                     0x090
+#define MAC_EVENT_EA_MEMORY_MAC_WRITE           0x092
+#define MAC_EVENT_EA_HA                         0x0a0
+
+struct mac_pmu {
+	struct pmu		pmu;
+	struct hlist_node	node;
+	void __iomem		*regs;
+	struct perf_event	*events[MAC_NUM_COUNTERS];
+	unsigned long		used_mask[BITS_TO_LONGS(MAC_NUM_COUNTERS)];
+	cpumask_t		cpumask;
+};
+
+#define to_mac_pmu(p) (container_of(p, struct mac_pmu, pmu))
+
+static int mac_pmu_cpuhp_state;
+
+static void fujitsu_mac_counter_start(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Initialize the hardware counter and reset prev_count*/
+	local64_set(&event->hw.prev_count, 0);
+	writeq_relaxed(0, macpmu->regs + MAC_PM_EVCNTR(idx));
+
+	/* Set the event type */
+	writeq_relaxed(MAC_PM_EVTYPE_EVSEL(event->attr.config), macpmu->regs + MAC_PM_EVTYPE(idx));
+
+	/* Enable interrupt generation by this counter */
+	writeq_relaxed(MAC_PM_INTENSET_IDX(idx), macpmu->regs + MAC_PM_INTENSET);
+
+	/* Finally, enable the counter */
+	writeq_relaxed(MAC_PM_CNTCTL_RESET, macpmu->regs + MAC_PM_CNTCTL(idx));
+	writeq_relaxed(MAC_PM_CNTENSET_IDX(idx), macpmu->regs + MAC_PM_CNTENSET);
+}
+
+static void fujitsu_mac_counter_stop(struct perf_event *event,
+				     int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Disable the counter */
+	writeq_relaxed(MAC_PM_CNTENCLR_IDX(idx), macpmu->regs + MAC_PM_CNTENCLR);
+
+	/* Disable interrupt generation by this counter */
+	writeq_relaxed(MAC_PM_INTENCLR_IDX(idx), macpmu->regs + MAC_PM_INTENCLR);
+}
+
+static void fujitsu_mac_counter_update(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u64 prev, new;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		new = readq_relaxed(macpmu->regs + MAC_PM_EVCNTR(idx));
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) != prev);
+
+	local64_add(new - prev, &event->count);
+}
+
+static inline void fujitsu_mac__init(struct mac_pmu *macpmu)
+{
+	int i;
+
+	writeq_relaxed(MAC_PM_CR_RESET, macpmu->regs + MAC_PM_CR);
+
+	writeq_relaxed(MAC_PM_CNTENCLR_RESET, macpmu->regs + MAC_PM_CNTENCLR);
+	writeq_relaxed(MAC_PM_INTENCLR_RESET, macpmu->regs + MAC_PM_INTENCLR);
+	writeq_relaxed(MAC_PM_OVSR_OVSRCLR_RESET, macpmu->regs + MAC_PM_OVSR);
+
+	for (i = 0; i < MAC_NUM_COUNTERS; ++i) {
+		writeq_relaxed(MAC_PM_CNTCTL_RESET, macpmu->regs + MAC_PM_CNTCTL(i));
+		writeq_relaxed(MAC_PM_EVTYPE_EVSEL(0), macpmu->regs + MAC_PM_EVTYPE(i));
+	}
+
+	/*
+	 * Use writeq here to ensure all programming commands are done
+	 * before proceeding
+	 */
+	writeq(MAC_PM_CR_ENABLE, macpmu->regs + MAC_PM_CR);
+}
+
+static irqreturn_t fujitsu_mac__handle_irq(int irq_num, void *data)
+{
+	struct mac_pmu *macpmu = data;
+	/* Read the overflow status register */
+	long status = readq_relaxed(macpmu->regs + MAC_PM_OVSR);
+	int idx;
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	/* Clear the bits we read on the overflow status register */
+	writeq_relaxed(status, macpmu->regs + MAC_PM_OVSR);
+
+	for_each_set_bit(idx, &status, MAC_NUM_COUNTERS) {
+		struct perf_event *event;
+
+		event = macpmu->events[idx];
+		if (!event)
+			continue;
+
+		fujitsu_mac_counter_update(event);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fujitsu_mac__pmu_enable(struct pmu *pmu)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(pmu);
+
+	/* Ensure the other programming commands are observed before enabling */
+	wmb();
+
+	writeq_relaxed(MAC_PM_CR_ENABLE, macpmu->regs + MAC_PM_CR);
+}
+
+static void fujitsu_mac__pmu_disable(struct pmu *pmu)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(pmu);
+
+	writeq_relaxed(0, macpmu->regs + MAC_PM_CR);
+
+	/* Ensure the basic counter unit is stopped before proceeding */
+	wmb();
+}
+
+/*
+ * We must NOT create groups containing events from multiple hardware PMUs,
+ * although mixing different software and hardware PMUs is allowed.
+ */
+static bool fujitsu_mac__validate_event_group(struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counters;
+
+	if (leader->pmu != event->pmu && !is_software_event(leader))
+		return false;
+
+	/* The sum of the counters used by the event and its leader event */
+	counters = 2;
+
+	for_each_sibling_event(sibling, leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != event->pmu)
+			return false;
+		counters++;
+	}
+
+	/*
+	 * If the group requires more counters than the HW has, it
+	 * cannot ever be scheduled.
+	 */
+	return counters <= MAC_NUM_COUNTERS;
+}
+
+static int fujitsu_mac__event_init(struct perf_event *event)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Is the event for this PMU? */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * Sampling not supported since these events are not
+	 * core-attributable.
+	 */
+	if (hwc->sample_period)
+		return -EINVAL;
+
+	/*
+	 * Task mode not available, we run the counters as socket counters,
+	 * not attributable to any CPU and therefore cannot attribute per-task.
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/* Validate the group */
+	if (!fujitsu_mac__validate_event_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, like this one, where
+	 * each event could be theoretically assigned to a different CPU.
+	 * To mitigate this, we enforce CPU assignment to one designated
+	 * processor (the one described in the "cpumask" attribute exported
+	 * by the PMU device). perf user space tools honor this and avoid
+	 * opening more than one copy of the events.
+	 */
+	event->cpu = cpumask_first(&macpmu->cpumask);
+
+	return 0;
+}
+
+static void fujitsu_mac__event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state = 0;
+	fujitsu_mac_counter_start(event);
+}
+
+static void fujitsu_mac__event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	fujitsu_mac_counter_stop(event, flags);
+	if (flags & PERF_EF_UPDATE)
+		fujitsu_mac_counter_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int fujitsu_mac__event_add(struct perf_event *event, int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Try to allocate a counter. */
+	idx = bitmap_find_free_region(macpmu->used_mask, MAC_NUM_COUNTERS, 0);
+	if (idx < 0)
+		/* The counters are all in use. */
+		return -EAGAIN;
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	macpmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		fujitsu_mac__event_start(event, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void fujitsu_mac__event_del(struct perf_event *event, int flags)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Stop and clean up */
+	fujitsu_mac__event_stop(event, flags | PERF_EF_UPDATE);
+	macpmu->events[hwc->idx] = NULL;
+	bitmap_release_region(macpmu->used_mask, hwc->idx, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+}
+
+static void fujitsu_mac__event_read(struct perf_event *event)
+{
+	fujitsu_mac_counter_update(event);
+}
+
+#define MAC_PMU_FORMAT_ATTR(_name, _config)				      \
+	(&((struct dev_ext_attribute[]) {				      \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		  .var = (void *) _config, }				      \
+	})[0].attr.attr)
+
+static struct attribute *fujitsu_mac_pmu_formats[] = {
+	MAC_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_format_group = {
+	.name = "format",
+	.attrs = fujitsu_mac_pmu_formats,
+};
+
+static ssize_t mac_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define MAC_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, mac_pmu_event_show, _id)
+
+static struct attribute *fujitsu_mac_pmu_events[] = {
+	MAC_EVENT_ATTR(cycles, MAC_EVENT_CYCLES),
+	MAC_EVENT_ATTR(read-count, MAC_EVENT_READ_COUNT),
+	MAC_EVENT_ATTR(read-count-request, MAC_EVENT_READ_COUNT_REQUEST),
+	MAC_EVENT_ATTR(read-count-return, MAC_EVENT_READ_COUNT_RETURN),
+	MAC_EVENT_ATTR(read-count-request-pftgt, MAC_EVENT_READ_COUNT_REQUEST_PFTGT),
+	MAC_EVENT_ATTR(read-count-request-normal, MAC_EVENT_READ_COUNT_REQUEST_NORMAL),
+	MAC_EVENT_ATTR(read-count-return-pftgt-hit, MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT),
+	MAC_EVENT_ATTR(read-count-return-pftgt-miss, MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS),
+	MAC_EVENT_ATTR(read-wait, MAC_EVENT_READ_WAIT),
+	MAC_EVENT_ATTR(write-count, MAC_EVENT_WRITE_COUNT),
+	MAC_EVENT_ATTR(write-count-write, MAC_EVENT_WRITE_COUNT_WRITE),
+	MAC_EVENT_ATTR(write-count-pwrite, MAC_EVENT_WRITE_COUNT_PWRITE),
+	MAC_EVENT_ATTR(memory-read-count, MAC_EVENT_MEMORY_READ_COUNT),
+	MAC_EVENT_ATTR(memory-write-count, MAC_EVENT_MEMORY_WRITE_COUNT),
+	MAC_EVENT_ATTR(memory-pwrite-count, MAC_EVENT_MEMORY_PWRITE_COUNT),
+	MAC_EVENT_ATTR(ea-mac, MAC_EVENT_EA_MAC),
+	MAC_EVENT_ATTR(ea-memory, MAC_EVENT_EA_MEMORY),
+	MAC_EVENT_ATTR(ea-memory-mac-write, MAC_EVENT_EA_MEMORY_MAC_WRITE),
+	MAC_EVENT_ATTR(ea-ha, MAC_EVENT_EA_HA),
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_events_group = {
+	.name = "events",
+	.attrs = fujitsu_mac_pmu_events,
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mac_pmu *macpmu = to_mac_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &macpmu->cpumask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *fujitsu_mac_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group fujitsu_mac_pmu_cpumask_attr_group = {
+	.attrs = fujitsu_mac_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *fujitsu_mac_pmu_attr_grps[] = {
+	&fujitsu_mac_pmu_format_group,
+	&fujitsu_mac_pmu_events_group,
+	&fujitsu_mac_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int fujitsu_mac_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
+
+	/* If there is not a CPU/PMU association pick this CPU */
+	if (cpumask_empty(&macpmu->cpumask))
+		cpumask_set_cpu(cpu, &macpmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_mac_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &macpmu->cpumask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&macpmu->pmu, cpu, target);
+	cpumask_set_cpu(target, &macpmu->cpumask);
+
+	return 0;
+}
+
+static int fujitsu_mac_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev;
+	struct mac_pmu *macpmu;
+	struct resource *memrc;
+	char *name;
+	int ret;
+	u64 uid;
+
+	acpi_dev = ACPI_COMPANION(dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	ret = acpi_dev_uid_to_integer(acpi_dev, &uid);
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
+
+	macpmu = devm_kzalloc(dev, sizeof(*macpmu), GFP_KERNEL);
+	if (!macpmu)
+		return -ENOMEM;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
+			      (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
+	if (!name)
+		return -ENOMEM;
+
+	macpmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.pmu_enable	= fujitsu_mac__pmu_enable,
+		.pmu_disable	= fujitsu_mac__pmu_disable,
+		.event_init	= fujitsu_mac__event_init,
+		.add		= fujitsu_mac__event_add,
+		.del		= fujitsu_mac__event_del,
+		.start		= fujitsu_mac__event_start,
+		.stop		= fujitsu_mac__event_stop,
+		.read		= fujitsu_mac__event_read,
+
+		.attr_groups	= fujitsu_mac_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	};
+
+	macpmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
+	if (IS_ERR(macpmu->regs))
+		return PTR_ERR(macpmu->regs);
+
+	fujitsu_mac__init(macpmu);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_irq(dev, ret, fujitsu_mac__handle_irq, 0,
+			       name, macpmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
+				     &memrc->start);
+
+	/* Add this instance to the list used by the offline callback */
+	ret = cpuhp_state_add_instance(mac_pmu_cpuhp_state, &macpmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error registering hotplug");
+
+	ret = perf_pmu_register(&macpmu->pmu, name, -1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register MAC PMU\n");
+
+	dev_dbg(dev, "Registered %s, type: %d\n", name, macpmu->pmu.type);
+
+	return 0;
+}
+
+static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
+	{ "FUJI200C", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fujitsu_mac_pmu_acpi_match);
+
+static struct platform_driver fujitsu_mac_pmu_driver = {
+	.driver = {
+		.name = "fujitsu-mac-pmu",
+		.acpi_match_table = fujitsu_mac_pmu_acpi_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = fujitsu_mac_pmu_probe,
+};
+
+static int __init register_fujitsu_mac_pmu_driver(void)
+{
+	int ret;
+
+	/* Install a hook to update the reader CPU in case it goes offline */
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/fujitsu/mac:online",
+				      fujitsu_mac_pmu_online_cpu,
+				      fujitsu_mac_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	mac_pmu_cpuhp_state = ret;
+	return platform_driver_register(&fujitsu_mac_pmu_driver);
+}
+device_initcall(register_fujitsu_mac_pmu_driver);
-- 
2.43.0


