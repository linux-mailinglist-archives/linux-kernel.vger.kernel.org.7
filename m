Return-Path: <linux-kernel+bounces-768920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC4B267F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C96D1CC0E99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642223002D7;
	Thu, 14 Aug 2025 13:35:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61748302742
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178535; cv=none; b=GnOuXQlX6OxvrCnIJ2ySwKOE/HklYW7WZRI05BvnVV0dg6bnaTSVCX/88cBjltATpus0XJzHY7yzaISGfffMvTD30PHAbwWi3CNy4FihtKsVZTrAGrDUFIO7QtLUu5Aq+tsl2qZAoiej2wq1d3RTbFHP70/VFy3czYBxThd7jTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178535; c=relaxed/simple;
	bh=m6jNJSRIzay4UbyA8G8CGb1t07TXqJne8yRnONz3TgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEiXIXO6sako8RyUt2FRFuvU31OMQo04cmXpZptG+6dczi7dJYB9DtqF/95tsuO8HU5yXKKnNU2Awr+flYJcCsPVgOX6voPePpyaI9mO9BtyVwtKdtanmZOpZtpfg59ak5aleckndXwZ+yfMVf++lznI4hpO1FVQBC/9+t/jYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2mND44sXzdc5R;
	Thu, 14 Aug 2025 21:31:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id E8AC11402EB;
	Thu, 14 Aug 2025 21:35:28 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 21:35:28 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>
Subject: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
Date: Thu, 14 Aug 2025 21:35:26 +0800
Message-ID: <20250814133527.2679261-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250814133527.2679261-1-xiaqinxin@huawei.com>
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

dma_map_benchmark is a standalone developer tool rather than an
automated selftest. It has no pass/fail criteria, expects manual
invocation, and is built as a normal userspace binary. Move it to
tools/dma/ and add a minimal, the original selftest/dma/Makefile
entry is removed to avoid duplication.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 tools/Makefile                                  | 13 +++++++------
 tools/dma/Makefile                              | 17 +++++++++++++++++
 tools/{testing/selftests => }/dma/config        |  0
 .../selftests => }/dma/dma_map_benchmark.c      |  0
 tools/testing/selftests/dma/Makefile            |  7 -------
 5 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

diff --git a/tools/Makefile b/tools/Makefile
index c31cbbd12c45..cb40961a740f 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -14,6 +14,7 @@ help:
 	@echo '  counter                - counter tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
+	@echo '  dma                    - tools for DMA mapping'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
 	@echo '  firmware               - Firmware tools'
 	@echo '  freefall               - laptop accelerometer program for disk protection'
@@ -69,7 +70,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
+counter dma firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -122,7 +123,7 @@ kvm_stat: FORCE
 ynl: FORCE
 	$(call descend,net/ynl)
 
-all: acpi counter cpupower gpio hv firewire \
+all: acpi counter cpupower dma gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -134,7 +135,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
+counter_install dma_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -164,7 +165,7 @@ kvm_stat_install:
 ynl_install:
 	$(call descend,net/$(@:_install=),install)
 
-install: acpi_install counter_install cpupower_install gpio_install \
+install: acpi_install counter_install cpupower_install dma_install gpio_install \
 		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
@@ -178,7 +179,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
+counter_clean dma_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -224,7 +225,7 @@ build_clean:
 ynl_clean:
 	$(call descend,net/$(@:_clean=),clean)
 
-clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
+clean: acpi_clean counter_clean cpupower_clean dma_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
diff --git a/tools/dma/Makefile b/tools/dma/Makefile
new file mode 100644
index 000000000000..841b54896288
--- /dev/null
+++ b/tools/dma/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+bindir ?= /usr/bin
+
+CFLAGS += -I../../include -I../../usr/include
+
+TARGET = dma_map_benchmark
+
+all: $(TARGET)
+
+$(TARGET): $(TARGET).c
+	$(CC) $(CFLAGS) $< -o $@
+
+install: all
+	install -D -m 755 $(TARGET) $(DESTDIR)$(bindir)/$(TARGET)
+
+clean:
+	rm -f $(TARGET)
diff --git a/tools/testing/selftests/dma/config b/tools/dma/config
similarity index 100%
rename from tools/testing/selftests/dma/config
rename to tools/dma/config
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
similarity index 100%
rename from tools/testing/selftests/dma/dma_map_benchmark.c
rename to tools/dma/dma_map_benchmark.c
diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
deleted file mode 100644
index cd8c5ece1cba..000000000000
--- a/tools/testing/selftests/dma/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-CFLAGS += -I../../../../usr/include/
-CFLAGS += -I../../../../include/
-
-TEST_GEN_PROGS := dma_map_benchmark
-
-include ../lib.mk
-- 
2.33.0


