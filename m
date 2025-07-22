Return-Path: <linux-kernel+bounces-740962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF4B0DD68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715CE1722C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF62ECEA3;
	Tue, 22 Jul 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NKYlE+3Z"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2B2EBBA2;
	Tue, 22 Jul 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193227; cv=none; b=d7tvnykbDsRxfF2Oeqaa2XcgNoAH8bEqUMgN1CT6JYpsWkWkSLk/Qa+epCqQrhtvDimR0z+3mtd8fqW/ngrsVHPhb5gyplG432v77PVv046S+w8my8Ixx49yAMSzopViL2Juz35du6B+76oO4XRmgrcTAzALjLF3VbsG/1C0Ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193227; c=relaxed/simple;
	bh=mBRH/HSPCkGZAyU0WqOEnZEiJvmC652wZwRDeQT/pNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kl/bxvOAXPYc8lh5mxJKnFfGDeoEqwGln86w6cNYGKvPG3Z75i3IhaTVLZIWFRB/QBQC651p8dIH4WR5Im4qJTJUJJarcaWW1/8KhYSlN742SZMOqc6tl7BJUa3sfwwoiYObWGG2TU+dK+YR2/E5WTke8m7YX0d8uuCaAuCZmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NKYlE+3Z; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDWZka018534;
	Tue, 22 Jul 2025 16:06:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yA2RRKl2oVDdym49E5+wiF5DBdat+NbFPa4Wt8IDIm8=; b=NKYlE+3ZnNV/69ZX
	u/7gJ2DzcHEidJUMG3rigjAaCm5tm0Kp/LFyztKkHuNBLeluhs9iO4sKOngBkUM2
	oaionXXGPWanDaqQuG/dCNw3cfHbVigjd+IdahlE0H2N5L9r/bB4X4mCiBmDZO2x
	wr7Wc5PfghIiiRaSBzRSz2tu9mRvbWQnurk/4533d61OuDbCsu8acOGTSYPbZKvZ
	O3f1nSC43LP7Z3LsTrfDeEagxY+ZpYU12SjIHWLtB4wjkbLDJW4FzZi8KaGeANLa
	pnCsKWoYqTr2EuhGxk0Y2DIX8CTPhS+jCXEuDsQBsJCLrob3aEW9eyBpOwwAeaGs
	OAN1ag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800g8pc6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:06:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3A4FD40057;
	Tue, 22 Jul 2025 16:05:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DFBB7A31F6;
	Tue, 22 Jul 2025 16:03:58 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 16:03:58 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Tue, 22 Jul 2025 16:03:29 +0200
Subject: [PATCH v3 12/19] perf: stm32: introduce DDRPERFM driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250722-ddrperfm-upstream-v3-12-7b7a4f3dc8a0@foss.st.com>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Le
 Goffic <legoffic.clement@gmail.com>,
        Julius Werner <jwerner@chromium.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-8018a
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01

Introduce the driver for the DDR Performance Monitor available on
STM32MPU SoC.

On STM32MP2 platforms, the DDRPERFM allows to monitor up to 8 DDR events
that come from the DDR Controller such as read or write events.

On STM32MP1 platforms, the DDRPERFM cannot monitor any event on any
counter, there is a notion of set of events.
Events from different sets cannot be monitored at the same time.
The first chosen event selects the set.
The set is coded in the first two bytes of the config value which is on 4
bytes.

On STM32MP25x series, the DDRPERFM clock is shared with the DDR controller
and may be secured by bootloaders.
Access controllers allow to check access to a resource. Use the access
controller defined in the devicetree to know about the access to the
DDRPERFM clock.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 drivers/perf/Kconfig         |  11 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/stm32_ddr_pmu.c | 896 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 908 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 278c929dc87a..5118535134ee 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -198,6 +198,17 @@ config QCOM_L3_PMU
 	   Adds the L3 cache PMU into the perf events subsystem for
 	   monitoring L3 cache events.
 
+config STM32_DDR_PMU
+	tristate "STM32 DDR PMU"
+	depends on ARCH_STM32 || COMPILE_TEST
+	default m
+	help
+	  Provides support for the DDR performance monitor on STM32MPU platforms.
+	  The monitor provides counters for memory related events.
+	  It allows developers to analyze and optimize DDR performance.
+	  Enabling this feature is useful for performance tuning and debugging memory
+	  subsystem issues on supported hardware.
+
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index de71d2574857..7f83b50feb71 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
+obj-$(CONFIG_STM32_DDR_PMU) += stm32_ddr_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
new file mode 100644
index 000000000000..d09c1375a41f
--- /dev/null
+++ b/drivers/perf/stm32_ddr_pmu.c
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
+ * Author: Clément Le Goffic <clement.legoffic@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/bus/stm32_firewall_device.h>
+#include <linux/clk.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/perf_event.h>
+#include <linux/reset.h>
+
+#define DRIVER_NAME		"stm32_ddr_pmu"
+
+/*
+ * The PMU is able to freeze all counters and generate an interrupt when there
+ * is a counter overflow. But, relying on this means that we lose all the
+ * events that occur between the freeze and the interrupt handler execution.
+ * So we use a polling mechanism to avoid this lost of information.
+ * The fastest counter can overflow in ~7s @600MHz (that is the maximum DDR
+ * frequency supported on STM32MP257), so we poll in 3.5s intervals to ensure
+ * we don't reach this limit.
+ */
+#define POLL_MS			3500
+
+#define DDRPERFM_CTRL		0x000
+#define DDRPERFM_CFG		0x004
+#define DDRPERFM_STATUS		0x008
+#define DDRPERFM_CLR		0x00C
+#define DDRPERFM_TCNT		0x020
+#define DDRPERFM_EVCNT(X)	(0x030 + 8 * (X))
+
+#define DDRPERFM_MP2_CFG0	0x010
+#define DDRPERFM_MP2_CFG1	0x014
+#define DDRPERFM_MP2_CFG5	0x024
+#define DDRPERFM_MP2_DRAMINF	0x028
+#define DDRPERFM_MP2_EVCNT(X)	(0x040 + 4 * (X))
+#define DDRPERFM_MP2_TCNT	0x060
+#define DDRPERFM_MP2_STATUS	0x080
+
+#define MP1_STATUS_BUSY		BIT(16)
+#define MP2_STATUS_BUSY		BIT(31)
+
+#define CTRL_START		BIT(0)
+#define CTRL_STOP		BIT(1)
+
+#define CFG_SEL_MSK		GENMASK(17, 16)
+#define CFG_SEL_SHIFT		16
+#define CFG_EN_MSK		GENMASK(3, 0)
+
+#define MP1_CLR_CNT		GENMASK(3, 0)
+#define MP1_CLR_TIME		BIT(31)
+#define MP2_CLR_CNT		GENMASK(7, 0)
+#define MP2_CLR_TIME		BIT(8)
+
+/* 4 event counters plus 1 dedicated to time */
+#define MP1_CNT_NB		(4 + 1)
+/* Index of the time dedicated counter */
+#define MP1_TIME_CNT_IDX	4
+
+/* 8 event counters plus 1 dedicated to time */
+#define MP2_CNT_NB		(8 + 1)
+/* Index of the time dedicated counter */
+#define MP2_TIME_CNT_IDX	8
+/* 4 event counters per register */
+#define MP2_CNT_SEL_PER_REG	4
+
+/* Arbitrary value used to identify a time event */
+#define TIME_CNT		64
+
+struct stm32_ddr_pmu_reg {
+	unsigned int reg;
+	u32 mask;
+};
+
+struct stm32_ddr_cnt {
+	int idx;
+	struct perf_event *evt;
+	struct list_head cnt_list;
+};
+
+struct stm32_ddr_pmu_regspec {
+	const struct stm32_ddr_pmu_reg stop;
+	const struct stm32_ddr_pmu_reg start;
+	const struct stm32_ddr_pmu_reg enable;
+	const struct stm32_ddr_pmu_reg status;
+	const struct stm32_ddr_pmu_reg clear_cnt;
+	const struct stm32_ddr_pmu_reg clear_time;
+	const struct stm32_ddr_pmu_reg cfg;
+	const struct stm32_ddr_pmu_reg cfg0;
+	const struct stm32_ddr_pmu_reg cfg1;
+	const struct stm32_ddr_pmu_reg dram_inf;
+	const struct stm32_ddr_pmu_reg counter_time;
+	const struct stm32_ddr_pmu_reg counter_evt[];
+};
+
+struct stm32_ddr_pmu {
+	struct pmu pmu;
+	void __iomem *membase;
+	struct device *dev;
+	struct clk *clk;
+	const struct stm32_ddr_pmu_cfg *cfg;
+	struct hrtimer hrtimer;
+	ktime_t poll_period;
+	int selected_set;
+	u32 dram_type;
+	struct list_head counters[];
+};
+
+struct stm32_ddr_pmu_cfg {
+	const struct stm32_ddr_pmu_regspec *regs;
+	const struct attribute_group **attribute;
+	u32 counters_nb;
+	u32 evt_counters_nb;
+	u32 time_cnt_idx;
+	struct stm32_ddr_cnt * (*get_counter)(struct stm32_ddr_pmu *p, struct perf_event *e);
+};
+
+#define STM32_DDR_PMU_EVENT_NUMBER(group, index)	(((group) << 8) | (index))
+#define STM32_DDR_PMU_GROUP_VALUE(event_number)		((event_number) >> 8)
+#define STM32_DDR_PMU_EVENT_INDEX(event_number)		((event_number) & 0xFF)
+
+/* MP1 ddrperfm events */
+enum stm32_ddr_pmu_events_mp1 {
+	PERF_OP_IS_RD			= STM32_DDR_PMU_EVENT_NUMBER(0, 0),
+	PERF_OP_IS_WR			= STM32_DDR_PMU_EVENT_NUMBER(0, 1),
+	PERF_OP_IS_ACTIVATE		= STM32_DDR_PMU_EVENT_NUMBER(0, 2),
+	CTL_IDLE			= STM32_DDR_PMU_EVENT_NUMBER(0, 3),
+	PERF_HPR_REQ_WITH_NO_CREDIT	= STM32_DDR_PMU_EVENT_NUMBER(1, 0),
+	PERF_LPR_REQ_WITH_NO_CREDIT	= STM32_DDR_PMU_EVENT_NUMBER(1, 1),
+	CACTIVE_DDRC			= STM32_DDR_PMU_EVENT_NUMBER(1, 3),
+	PERF_OP_IS_ENTER_POWERDOWN	= STM32_DDR_PMU_EVENT_NUMBER(2, 0),
+	PERF_OP_IS_REFRESH		= STM32_DDR_PMU_EVENT_NUMBER(2, 1),
+	PERF_SELFRESH_MODE		= STM32_DDR_PMU_EVENT_NUMBER(2, 2),
+	DFI_LP_REQ			= STM32_DDR_PMU_EVENT_NUMBER(2, 3),
+	PERF_HPR_XACT_WHEN_CRITICAL	= STM32_DDR_PMU_EVENT_NUMBER(3, 0),
+	PERF_LPR_XACT_WHEN_CRITICAL	= STM32_DDR_PMU_EVENT_NUMBER(3, 1),
+	PERF_WR_XACT_WHEN_CRITICAL	= STM32_DDR_PMU_EVENT_NUMBER(3, 2),
+	DFI_LP_REQ_SCND			= STM32_DDR_PMU_EVENT_NUMBER(3, 3),
+};
+
+/* MP2 ddrperfm events */
+enum stm32_ddr_pmu_events_mp2 {
+	DFI_IS_ACT			= STM32_DDR_PMU_EVENT_NUMBER(0, 0),
+	DFI_IS_PREPB			= STM32_DDR_PMU_EVENT_NUMBER(0, 1),
+	DFI_IS_PREAB			= STM32_DDR_PMU_EVENT_NUMBER(0, 2),
+	DFI_IS_RD			= STM32_DDR_PMU_EVENT_NUMBER(0, 3),
+	DFI_IS_RDA			= STM32_DDR_PMU_EVENT_NUMBER(0, 4),
+	DFI_IS_WR			= STM32_DDR_PMU_EVENT_NUMBER(0, 6),
+	DFI_IS_WRA			= STM32_DDR_PMU_EVENT_NUMBER(0, 7),
+	DFI_IS_MWR			= STM32_DDR_PMU_EVENT_NUMBER(0, 9),
+	DFI_IS_MWRA			= STM32_DDR_PMU_EVENT_NUMBER(0, 10),
+	DFI_IS_MRW			= STM32_DDR_PMU_EVENT_NUMBER(0, 12),
+	DFI_IS_MRR			= STM32_DDR_PMU_EVENT_NUMBER(0, 13),
+	DFI_IS_REFPB			= STM32_DDR_PMU_EVENT_NUMBER(0, 14),
+	DFI_IS_REFAB			= STM32_DDR_PMU_EVENT_NUMBER(0, 15),
+	DFI_IS_MPC			= STM32_DDR_PMU_EVENT_NUMBER(0, 16),
+	PERF_OP_IS_ACT			= STM32_DDR_PMU_EVENT_NUMBER(0, 32),
+	PERF_OP_IS_RD_MP2		= STM32_DDR_PMU_EVENT_NUMBER(0, 33),
+	PERF_OP_IS_WR_MP2		= STM32_DDR_PMU_EVENT_NUMBER(0, 34),
+	PERF_OP_IS_MWR			= STM32_DDR_PMU_EVENT_NUMBER(0, 35),
+	PERF_OP_IS_REF			= STM32_DDR_PMU_EVENT_NUMBER(0, 36),
+	PERF_OP_IS_CRIT_REF		= STM32_DDR_PMU_EVENT_NUMBER(0, 37),
+	PERF_OP_IS_SPEC_REF		= STM32_DDR_PMU_EVENT_NUMBER(0, 38),
+	PERF_OP_IS_ZQCAL		= STM32_DDR_PMU_EVENT_NUMBER(0, 39),
+	PERF_OP_IS_ENTER_POWDN		= STM32_DDR_PMU_EVENT_NUMBER(0, 40),
+	PERF_OP_IS_ENTER_SELFREF	= STM32_DDR_PMU_EVENT_NUMBER(0, 41),
+	PERF_OP_IS_PRE			= STM32_DDR_PMU_EVENT_NUMBER(0, 42),
+	PERF_OP_IS_PRE_FOR_RDWR		= STM32_DDR_PMU_EVENT_NUMBER(0, 43),
+	PERF_OP_IS_PRE_FOR_OTHERS	= STM32_DDR_PMU_EVENT_NUMBER(0, 44),
+	PERF_OP_IS_RD_ACTIVATE		= STM32_DDR_PMU_EVENT_NUMBER(0, 45),
+	PERF_HPR_REQ_WITH_NOCREDIT	= STM32_DDR_PMU_EVENT_NUMBER(0, 48),
+	PERF_LPR_REQ_WITH_NOCREDIT	= STM32_DDR_PMU_EVENT_NUMBER(0, 49),
+	PERF_HPR_XACT_WHEN_CRITICAL_MP2	= STM32_DDR_PMU_EVENT_NUMBER(0, 50),
+	PERF_LPR_XACT_WHEN_CRITICAL_MP2	= STM32_DDR_PMU_EVENT_NUMBER(0, 51),
+	PERF_WR_XACT_WHEN_CRITICAL_MP2	= STM32_DDR_PMU_EVENT_NUMBER(0, 52),
+	PERF_RDWR_TRANSITIONS		= STM32_DDR_PMU_EVENT_NUMBER(0, 53),
+	PERF_WAR_HAZARD			= STM32_DDR_PMU_EVENT_NUMBER(0, 54),
+	PERF_RAW_HAZARD			= STM32_DDR_PMU_EVENT_NUMBER(0, 55),
+	PERF_WAW_HAZARD			= STM32_DDR_PMU_EVENT_NUMBER(0, 56),
+	PERF_RANK			= STM32_DDR_PMU_EVENT_NUMBER(0, 58),
+	PERF_READ_BYPASS		= STM32_DDR_PMU_EVENT_NUMBER(0, 59),
+	PERF_ACT_BYPASS			= STM32_DDR_PMU_EVENT_NUMBER(0, 60),
+	PERF_WINDOW_LIMIT_REACHED_RD	= STM32_DDR_PMU_EVENT_NUMBER(0, 61),
+	PERF_WINDOW_LIMIT_REACHED_WR	= STM32_DDR_PMU_EVENT_NUMBER(0, 62),
+	NO_EVENT			= STM32_DDR_PMU_EVENT_NUMBER(0, 63),
+};
+
+enum stm32_ddr_pmu_memory_type {
+	STM32_DDR_PMU_LPDDR4,
+	STM32_DDR_PMU_LPDDR3,
+	STM32_DDR_PMU_DDR4,
+	STM32_DDR_PMU_DDR3,
+};
+
+static struct stm32_ddr_pmu *to_stm32_ddr_pmu(struct pmu *p)
+{
+	return container_of(p, struct stm32_ddr_pmu, pmu);
+}
+
+static struct stm32_ddr_pmu *hrtimer_to_stm32_ddr_pmu(struct hrtimer *h)
+{
+	return container_of(h, struct stm32_ddr_pmu, hrtimer);
+}
+
+static void stm32_ddr_start_counters(struct stm32_ddr_pmu *pmu)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+
+	writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
+}
+
+static void stm32_ddr_stop_counters(struct stm32_ddr_pmu *pmu)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+
+	writel_relaxed(r->stop.mask, pmu->membase + r->stop.reg);
+}
+
+static void stm32_ddr_clear_time_counter(struct stm32_ddr_pmu *pmu)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+
+	writel_relaxed(r->clear_time.mask, pmu->membase + r->clear_time.reg);
+}
+
+static void stm32_ddr_clear_event_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+
+	writel_relaxed(r->clear_cnt.mask & BIT(counter->idx), pmu->membase + r->clear_cnt.reg);
+}
+
+static void stm32_ddr_clear_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+	u32 status = readl_relaxed(pmu->membase + r->status.reg);
+
+	if (counter->idx == pmu->cfg->time_cnt_idx)
+		stm32_ddr_clear_time_counter(pmu);
+	else
+		stm32_ddr_clear_event_counter(pmu, counter);
+
+	if (status & r->status.mask)
+		dev_err(pmu->dev, "Failed to clear counter %i because the PMU is busy\n",
+			counter->idx);
+}
+
+static void stm32_ddr_counter_enable(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+	u32 val = readl_relaxed(pmu->membase + r->enable.reg);
+
+	val |= BIT(counter->idx);
+	writel_relaxed(val, pmu->membase + r->enable.reg);
+}
+
+static void stm32_ddr_counter_disable(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+	u32 val = readl_relaxed(pmu->membase + r->enable.reg);
+
+	val &= ~BIT(counter->idx);
+	writel_relaxed(val, pmu->membase + r->enable.reg);
+}
+
+static int stm32_ddr_sel_evnt(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
+{
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+	u32 cnt_sel_val;
+
+	u32 group_val = STM32_DDR_PMU_GROUP_VALUE(counter->evt->attr.config);
+	u32 evt_val = STM32_DDR_PMU_EVENT_INDEX(counter->evt->attr.config);
+
+	if (pmu->selected_set != -1 && pmu->selected_set != group_val) {
+		dev_err(pmu->dev, "Selected events are from different set\n");
+		return -EINVAL;
+	}
+	pmu->selected_set = group_val;
+
+	if (pmu->cfg->regs->cfg.reg) {
+		cnt_sel_val = readl_relaxed(pmu->membase + r->cfg.reg);
+		cnt_sel_val &= ~CFG_SEL_MSK;
+		cnt_sel_val |= (CFG_SEL_MSK & (group_val << CFG_SEL_SHIFT));
+		writel_relaxed(cnt_sel_val, pmu->membase + r->cfg.reg);
+
+		return 0;
+	}
+
+	/* We assume cfg0 and cfg1 are filled in the match data */
+	u32 cnt_idx = counter->idx;
+	u32 cnt_sel_evt_reg = r->cfg0.reg;
+
+	if (!(cnt_idx < MP2_CNT_SEL_PER_REG)) {
+		cnt_sel_evt_reg = r->cfg1.reg;
+		cnt_idx -= MP2_CNT_SEL_PER_REG;
+	}
+
+	cnt_sel_val = readl_relaxed(pmu->membase + cnt_sel_evt_reg);
+	cnt_sel_val &= ~GENMASK(8 * cnt_idx + 7, 8 * cnt_idx);
+	cnt_sel_val |= evt_val << (8 * cnt_idx);
+
+	writel_relaxed(cnt_sel_val, pmu->membase + cnt_sel_evt_reg);
+
+	return 0;
+}
+
+static struct stm32_ddr_cnt *stm32_ddr_pmu_get_event_counter_mp1(struct stm32_ddr_pmu *pmu,
+								 struct perf_event *event)
+{
+	u32 config = event->attr.config;
+	u32 event_idx = STM32_DDR_PMU_EVENT_INDEX(config);
+	struct stm32_ddr_cnt *cnt;
+
+	cnt = kzalloc(sizeof(*cnt), GFP_KERNEL);
+	if (!cnt)
+		return ERR_PTR(-ENOMEM);
+
+	cnt->evt = event;
+	cnt->idx = event_idx;
+	event->pmu_private = cnt;
+	list_add(&cnt->cnt_list, &pmu->counters[event_idx]);
+
+	return cnt;
+}
+
+static struct stm32_ddr_cnt *stm32_ddr_pmu_get_event_counter_mp2(struct stm32_ddr_pmu *pmu,
+								 struct perf_event *event)
+{
+	struct stm32_ddr_cnt *cnt;
+	int idx = -1;
+
+	/* Loop on all the counters except TIME_CNT_IDX */
+	for (int i = 0; i < pmu->cfg->evt_counters_nb; i++) {
+		u64 config;
+
+		if (list_empty(&pmu->counters[i])) {
+			idx = i;
+			continue;
+		}
+		config = list_first_entry(&pmu->counters[i], struct stm32_ddr_cnt,
+					  cnt_list)->evt->attr.config;
+		if (config == event->attr.config) {
+			idx = i;
+			break;
+		}
+	}
+
+	if (idx == -1)
+		return ERR_PTR(-ENOENT);
+
+	cnt = kzalloc(sizeof(*cnt), GFP_KERNEL);
+	if (!cnt)
+		return ERR_PTR(-ENOMEM);
+
+	cnt->evt = event;
+	cnt->idx = idx;
+	event->pmu_private = cnt;
+
+	list_add(&cnt->cnt_list, &pmu->counters[idx]);
+
+	return cnt;
+}
+
+static inline struct stm32_ddr_cnt *stm32_get_event_counter(struct stm32_ddr_pmu *pmu,
+							    struct perf_event *event)
+{
+	return pmu->cfg->get_counter(pmu, event);
+}
+
+static int stm32_ddr_pmu_get_counter(struct stm32_ddr_pmu *pmu, struct perf_event *event)
+{
+	u32 time_cnt_idx = pmu->cfg->time_cnt_idx;
+	u32 config = event->attr.config;
+	struct stm32_ddr_cnt *cnt;
+
+	pmu->selected_set = STM32_DDR_PMU_GROUP_VALUE(config);
+
+	if (config == TIME_CNT) {
+		cnt = kzalloc(sizeof(*cnt), GFP_KERNEL);
+		if (!cnt)
+			return -ENOMEM;
+
+		cnt->evt = event;
+		cnt->idx = time_cnt_idx;
+		event->pmu_private = cnt;
+		list_add(&cnt->cnt_list, &pmu->counters[time_cnt_idx]);
+
+		return 0;
+	}
+
+	cnt = stm32_get_event_counter(pmu, event);
+	if (IS_ERR(cnt))
+		return PTR_ERR(cnt);
+
+	if (list_count_nodes(&cnt->cnt_list) == 1) {
+		stm32_ddr_stop_counters(pmu);
+		stm32_ddr_sel_evnt(pmu, cnt);
+		stm32_ddr_counter_enable(pmu, cnt);
+		stm32_ddr_start_counters(pmu);
+	}
+
+	return 0;
+}
+
+static void stm32_ddr_pmu_free_counter(struct stm32_ddr_pmu *pmu,
+				       struct stm32_ddr_cnt *counter)
+{
+	size_t count = list_count_nodes(&counter->cnt_list);
+
+	if (counter->evt->attr.config != TIME_CNT && count == 1)
+		stm32_ddr_counter_disable(pmu, counter);
+
+	list_del(&counter->cnt_list);
+	kfree(counter);
+}
+
+static void stm32_ddr_pmu_event_update_list(struct stm32_ddr_pmu *pmu, struct list_head *list)
+{
+	struct stm32_ddr_cnt *counter = list_first_entry(list, struct stm32_ddr_cnt, cnt_list);
+	const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
+	u32 val;
+
+	if (counter->evt->attr.config != TIME_CNT)
+		val = readl_relaxed(pmu->membase + r->counter_evt[counter->idx].reg);
+	else
+		val = readl_relaxed(pmu->membase + r->counter_time.reg);
+
+	stm32_ddr_clear_counter(pmu, counter);
+
+	list_for_each_entry(counter, list, cnt_list)
+		local64_add(val, &counter->evt->count);
+}
+
+static void stm32_ddr_pmu_event_read(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
+	struct stm32_ddr_cnt *cnt = event->pmu_private;
+
+	hrtimer_start(&pmu->hrtimer, pmu->poll_period, HRTIMER_MODE_REL_PINNED);
+
+	stm32_ddr_stop_counters(pmu);
+
+	stm32_ddr_pmu_event_update_list(pmu, &pmu->counters[cnt->idx]);
+
+	stm32_ddr_start_counters(pmu);
+}
+
+static void stm32_ddr_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
+	struct stm32_ddr_cnt *counter = event->pmu_private;
+	struct hw_perf_event *hw = &event->hw;
+
+	if (WARN_ON_ONCE(!(hw->state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
+
+	stm32_ddr_stop_counters(pmu);
+
+	if (list_count_nodes(&counter->cnt_list) == 1)
+		stm32_ddr_clear_counter(pmu, counter);
+	else
+		stm32_ddr_pmu_event_update_list(pmu, &pmu->counters[counter->idx]);
+
+	stm32_ddr_start_counters(pmu);
+	local64_set(&hw->prev_count, 0);
+	hw->state = 0;
+}
+
+static void stm32_ddr_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	if (WARN_ON_ONCE(hw->state & PERF_HES_STOPPED))
+		return;
+
+	hw->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_UPDATE) {
+		stm32_ddr_pmu_event_read(event);
+		hw->state |= PERF_HES_UPTODATE;
+	}
+}
+
+static int stm32_ddr_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
+	int ret;
+
+	clk_enable(pmu->clk);
+
+	hrtimer_start(&pmu->hrtimer, pmu->poll_period, HRTIMER_MODE_REL_PINNED);
+
+	ret = stm32_ddr_pmu_get_counter(pmu, event);
+	if (ret)
+		return ret;
+
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		stm32_ddr_pmu_event_start(event, flags);
+
+	return 0;
+}
+
+static void stm32_ddr_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
+	struct stm32_ddr_cnt *counter = event->pmu_private;
+	bool events = true;
+
+	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
+
+	stm32_ddr_pmu_free_counter(pmu, counter);
+
+	for (int i = 0; i < pmu->cfg->counters_nb; i++)
+		events = !list_empty(&pmu->counters[i]);
+
+	/* If there is activity nothing to do */
+	if (events)
+		return;
+
+	hrtimer_cancel(&pmu->hrtimer);
+	stm32_ddr_stop_counters(pmu);
+
+	pmu->selected_set = -1;
+
+	clk_disable(pmu->clk);
+}
+
+static int stm32_ddr_pmu_event_init(struct perf_event *event)
+{
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static enum hrtimer_restart stm32_ddr_pmu_poll(struct hrtimer *hrtimer)
+{
+	struct stm32_ddr_pmu *pmu = hrtimer_to_stm32_ddr_pmu(hrtimer);
+
+	stm32_ddr_stop_counters(pmu);
+
+	for (int i = 0; i < MP2_CNT_NB; i++)
+		if (!list_empty(&pmu->counters[i]))
+			stm32_ddr_pmu_event_update_list(pmu, &pmu->counters[i]);
+
+	if (list_empty(&pmu->counters[pmu->cfg->time_cnt_idx]))
+		stm32_ddr_clear_time_counter(pmu);
+
+	stm32_ddr_start_counters(pmu);
+
+	hrtimer_forward_now(hrtimer, pmu->poll_period);
+
+	return HRTIMER_RESTART;
+}
+
+static ssize_t stm32_ddr_pmu_sysfs_show(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(buf, "event=0x%02llx\n", pmu_attr->id);
+}
+
+static int stm32_ddr_pmu_get_memory_type(struct stm32_ddr_pmu *pmu)
+{
+	struct platform_device *pdev = to_platform_device(pmu->dev);
+	struct device_node *memchan;
+
+	memchan = of_parse_phandle(pdev->dev.of_node, "memory-channel", 0);
+	if (!memchan)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Missing device-tree property 'memory-channel'\n");
+
+	if (of_device_is_compatible(memchan, "jedec,lpddr4-channel"))
+		pmu->dram_type = STM32_DDR_PMU_LPDDR4;
+	else if (of_device_is_compatible(memchan, "jedec,lpddr3-channel"))
+		pmu->dram_type = STM32_DDR_PMU_LPDDR3;
+	else if (of_device_is_compatible(memchan, "jedec,ddr4-channel"))
+		pmu->dram_type = STM32_DDR_PMU_DDR4;
+	else if (of_device_is_compatible(memchan, "jedec,ddr3-channel"))
+		pmu->dram_type = STM32_DDR_PMU_DDR3;
+	else
+		return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported memory channel type\n");
+
+	if (pmu->dram_type == STM32_DDR_PMU_LPDDR3)
+		dev_warn(&pdev->dev,
+			 "LPDDR3 supported by DDRPERFM but not supported by DDRCTRL/DDRPHY\n");
+
+	return 0;
+}
+
+#define STM32_DDR_PMU_EVENT_ATTR(_name, _id)			\
+	PMU_EVENT_ATTR_ID(_name, stm32_ddr_pmu_sysfs_show, _id)
+
+static struct attribute *stm32_ddr_pmu_events_attrs_mp[] = {
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_rd, PERF_OP_IS_RD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_wr, PERF_OP_IS_WR),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_activate, PERF_OP_IS_ACTIVATE),
+	STM32_DDR_PMU_EVENT_ATTR(ctl_idle, CTL_IDLE),
+	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_req_with_no_credit, PERF_HPR_REQ_WITH_NO_CREDIT),
+	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_req_with_no_credit, PERF_LPR_REQ_WITH_NO_CREDIT),
+	STM32_DDR_PMU_EVENT_ATTR(cactive_ddrc, CACTIVE_DDRC),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_enter_powerdown, PERF_OP_IS_ENTER_POWERDOWN),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_refresh, PERF_OP_IS_REFRESH),
+	STM32_DDR_PMU_EVENT_ATTR(perf_selfresh_mode, PERF_SELFRESH_MODE),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_lp_req, DFI_LP_REQ),
+	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_xact_when_critical, PERF_HPR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_xact_when_critical, PERF_LPR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_wr_xact_when_critical, PERF_WR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_lp_req_cpy, DFI_LP_REQ),  /* Suffixed '_cpy' to allow the
+								* choice between sets 2 and 3
+								*/
+	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
+	NULL,
+};
+
+static struct attribute_group stm32_ddr_pmu_events_attrs_group_mp = {
+	.name = "events",
+	.attrs = stm32_ddr_pmu_events_attrs_mp,
+};
+
+static struct attribute *stm32_ddr_pmu_events_attrs_mp2[] = {
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_act, DFI_IS_ACT),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_prepb, DFI_IS_PREPB),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_preab, DFI_IS_PREAB),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_rd, DFI_IS_RD),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_rda, DFI_IS_RDA),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_wr, DFI_IS_WR),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_wra, DFI_IS_WRA),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_mwr, DFI_IS_MWR),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_mwra, DFI_IS_MWRA),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_mrw, DFI_IS_MRW),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_mrr, DFI_IS_MRR),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_refpb, DFI_IS_REFPB),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_refab, DFI_IS_REFAB),
+	STM32_DDR_PMU_EVENT_ATTR(dfi_is_mpc, DFI_IS_MPC),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_act, PERF_OP_IS_ACT),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_rd, PERF_OP_IS_RD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_wr, PERF_OP_IS_WR),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_mwr, PERF_OP_IS_MWR),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_ref, PERF_OP_IS_REF),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_crit_ref, PERF_OP_IS_CRIT_REF),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_spec_ref, PERF_OP_IS_SPEC_REF),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_zqcal, PERF_OP_IS_ZQCAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_enter_powdn, PERF_OP_IS_ENTER_POWDN),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_enter_selfref, PERF_OP_IS_ENTER_SELFREF),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_pre, PERF_OP_IS_PRE),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_pre_for_rdwr, PERF_OP_IS_PRE_FOR_RDWR),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_pre_for_others, PERF_OP_IS_PRE_FOR_OTHERS),
+	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_rd_activate, PERF_OP_IS_RD_ACTIVATE),
+	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_req_with_nocredit, PERF_HPR_REQ_WITH_NOCREDIT),
+	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_req_with_nocredit, PERF_LPR_REQ_WITH_NOCREDIT),
+	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_xact_when_critical, PERF_HPR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_xact_when_critical, PERF_LPR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_wr_xact_when_critical, PERF_WR_XACT_WHEN_CRITICAL),
+	STM32_DDR_PMU_EVENT_ATTR(perf_rdwr_transitions, PERF_RDWR_TRANSITIONS),
+	STM32_DDR_PMU_EVENT_ATTR(perf_war_hazard, PERF_WAR_HAZARD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_raw_hazard, PERF_RAW_HAZARD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_waw_hazard, PERF_WAW_HAZARD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_rank, PERF_RANK),
+	STM32_DDR_PMU_EVENT_ATTR(perf_read_bypass, PERF_READ_BYPASS),
+	STM32_DDR_PMU_EVENT_ATTR(perf_act_bypass, PERF_ACT_BYPASS),
+	STM32_DDR_PMU_EVENT_ATTR(perf_window_limit_reached_rd, PERF_WINDOW_LIMIT_REACHED_RD),
+	STM32_DDR_PMU_EVENT_ATTR(perf_window_limit_reached_wr, PERF_WINDOW_LIMIT_REACHED_WR),
+	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
+	NULL
+};
+
+static struct attribute_group stm32_ddr_pmu_events_attrs_group_mp2 = {
+	.name = "events",
+	.attrs = stm32_ddr_pmu_events_attrs_mp2,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-8");
+
+static struct attribute *stm32_ddr_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static const struct attribute_group stm32_ddr_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = stm32_ddr_pmu_format_attrs,
+};
+
+static const struct attribute_group *stm32_ddr_pmu_attr_groups_mp1[] = {
+	&stm32_ddr_pmu_events_attrs_group_mp,
+	&stm32_ddr_pmu_format_attr_group,
+	NULL
+};
+
+static const struct attribute_group *stm32_ddr_pmu_attr_groups_mp2[] = {
+	&stm32_ddr_pmu_events_attrs_group_mp2,
+	&stm32_ddr_pmu_format_attr_group,
+	NULL
+};
+
+static int stm32_ddr_pmu_device_probe(struct platform_device *pdev)
+{
+	struct stm32_firewall firewall;
+	struct stm32_ddr_pmu *pmu;
+	struct reset_control *rst;
+	struct resource *res;
+	int ret;
+
+	pmu = devm_kzalloc(&pdev->dev, struct_size(pmu, counters, MP2_CNT_NB), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pmu);
+	pmu->dev = &pdev->dev;
+
+	pmu->cfg = device_get_match_data(pmu->dev);
+
+	pmu->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(pmu->membase))
+		return PTR_ERR(pmu->membase);
+
+	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
+		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
+		if (ret)
+			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
+		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
+		if (ret)
+			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
+	}
+
+	pmu->clk = devm_clk_get_optional_enabled(pmu->dev, NULL);
+	if (IS_ERR(pmu->clk))
+		return dev_err_probe(pmu->dev, PTR_ERR(pmu->clk), "Failed to get prepare clock\n");
+
+	rst = devm_reset_control_get_optional_exclusive(pmu->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(pmu->dev, PTR_ERR(rst), "Failed to get reset\n");
+
+	reset_control_assert(rst);
+	reset_control_deassert(rst);
+
+	pmu->poll_period = ms_to_ktime(POLL_MS);
+	hrtimer_setup(&pmu->hrtimer, stm32_ddr_pmu_poll, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	for (int i = 0; i < MP2_CNT_NB; i++)
+		INIT_LIST_HEAD(&pmu->counters[i]);
+
+	pmu->selected_set = -1;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr = perf_invalid_context,
+		.start = stm32_ddr_pmu_event_start,
+		.stop = stm32_ddr_pmu_event_stop,
+		.add = stm32_ddr_pmu_event_add,
+		.del = stm32_ddr_pmu_event_del,
+		.read = stm32_ddr_pmu_event_read,
+		.event_init = stm32_ddr_pmu_event_init,
+		.attr_groups = pmu->cfg->attribute,
+		.module = THIS_MODULE,
+	};
+
+	if (pmu->cfg->regs->dram_inf.reg) {
+		ret = stm32_ddr_pmu_get_memory_type(pmu);
+		if (ret)
+			return dev_err_probe(pmu->dev, ret, "Failed to get memory type\n");
+
+		writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
+	}
+
+	ret = perf_pmu_register(&pmu->pmu, DRIVER_NAME, -1);
+	if (ret)
+		return dev_err_probe(pmu->dev, ret,
+				"Couldn't register DDRPERFM driver as a PMU\n");
+
+	clk_disable(pmu->clk);
+
+	return 0;
+}
+
+static void stm32_ddr_pmu_device_remove(struct platform_device *pdev)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&stm32_ddr_pmu->pmu);
+}
+
+static int __maybe_unused stm32_ddr_pmu_device_resume(struct device *dev)
+{
+	struct stm32_ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	clk_enable(pmu->clk);
+	writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
+	clk_disable(pmu->clk);
+
+	return 0;
+}
+
+static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp1 = {
+	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
+	.start =	{ DDRPERFM_CTRL, CTRL_START },
+	.enable =	{ DDRPERFM_CFG },
+	.cfg =		{ DDRPERFM_CFG },
+	.status =	{ DDRPERFM_STATUS, MP1_STATUS_BUSY },
+	.clear_cnt =	{ DDRPERFM_CLR, MP1_CLR_CNT },
+	.clear_time =	{ DDRPERFM_CLR, MP1_CLR_TIME },
+	.counter_time =	{ DDRPERFM_TCNT },
+	.counter_evt =	{
+		{ DDRPERFM_EVCNT(0) },
+		{ DDRPERFM_EVCNT(1) },
+		{ DDRPERFM_EVCNT(2) },
+		{ DDRPERFM_EVCNT(3) },
+	},
+};
+
+static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp2 = {
+	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
+	.start =	{ DDRPERFM_CTRL, CTRL_START },
+	.status =	{ DDRPERFM_MP2_STATUS, MP2_STATUS_BUSY },
+	.clear_cnt =	{ DDRPERFM_CLR, MP2_CLR_CNT },
+	.clear_time =	{ DDRPERFM_CLR, MP2_CLR_TIME },
+	.cfg0 =		{ DDRPERFM_MP2_CFG0 },
+	.cfg1 =		{ DDRPERFM_MP2_CFG1 },
+	.enable =	{ DDRPERFM_MP2_CFG5 },
+	.dram_inf =	{ DDRPERFM_MP2_DRAMINF },
+	.counter_time =	{ DDRPERFM_MP2_TCNT },
+	.counter_evt =	{
+		{ DDRPERFM_MP2_EVCNT(0) },
+		{ DDRPERFM_MP2_EVCNT(1) },
+		{ DDRPERFM_MP2_EVCNT(2) },
+		{ DDRPERFM_MP2_EVCNT(3) },
+		{ DDRPERFM_MP2_EVCNT(4) },
+		{ DDRPERFM_MP2_EVCNT(5) },
+		{ DDRPERFM_MP2_EVCNT(6) },
+		{ DDRPERFM_MP2_EVCNT(7) },
+	},
+};
+
+static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 = {
+	.regs = &stm32_ddr_pmu_regspec_mp1,
+	.attribute = stm32_ddr_pmu_attr_groups_mp1,
+	.counters_nb = MP1_CNT_NB,
+	.evt_counters_nb = MP1_CNT_NB - 1, /* Time counter is not an event counter */
+	.time_cnt_idx = MP1_TIME_CNT_IDX,
+	.get_counter = stm32_ddr_pmu_get_event_counter_mp1,
+};
+
+static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 = {
+	.regs = &stm32_ddr_pmu_regspec_mp2,
+	.attribute = stm32_ddr_pmu_attr_groups_mp2,
+	.counters_nb = MP2_CNT_NB,
+	.evt_counters_nb = MP2_CNT_NB - 1, /* Time counter is an event counter */
+	.time_cnt_idx = MP2_TIME_CNT_IDX,
+	.get_counter = stm32_ddr_pmu_get_event_counter_mp2,
+};
+
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_ddr_pmu_pm_ops, NULL, stm32_ddr_pmu_device_resume);
+
+static const struct of_device_id stm32_ddr_pmu_of_match[] = {
+	{
+		.compatible = "st,stm32mp131-ddr-pmu",
+		.data = &stm32_ddr_pmu_cfg_mp1
+	},
+	{
+		.compatible = "st,stm32mp251-ddr-pmu",
+		.data = &stm32_ddr_pmu_cfg_mp2
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
+
+static struct platform_driver stm32_ddr_pmu_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.pm = pm_sleep_ptr(&stm32_ddr_pmu_pm_ops),
+		.of_match_table = stm32_ddr_pmu_of_match,
+	},
+	.probe = stm32_ddr_pmu_device_probe,
+	.remove = stm32_ddr_pmu_device_remove,
+};
+
+module_platform_driver(stm32_ddr_pmu_driver);
+
+MODULE_AUTHOR("Clément Le Goffic");
+MODULE_DESCRIPTION("STMicroelectronics STM32 DDR performance monitor driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0


