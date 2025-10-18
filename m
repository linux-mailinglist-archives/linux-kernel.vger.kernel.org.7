Return-Path: <linux-kernel+bounces-859119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E1BECD0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4628C583D07
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1A288525;
	Sat, 18 Oct 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pF2AWhO5"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099E7483
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760782477; cv=none; b=eoxCTQcIygbIS/sZpQXNEb1yPWjg9GQBDXE6yMoGm41Razrum1Z2AWmYcqgfCN4PfWbxTPknTy8mDi9GzpwiNsQbj+X6eZF6xRIhc45czJmQpz54qdQL1IEuT0Z29MO2KAbV7hq/MtOmTvgmRQeeJZnjpjRCdtYtpXIPiYKqPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760782477; c=relaxed/simple;
	bh=TJxP3UqbksBt6zCrmMG1WKoxccK7TpoXL+cBahZva5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAvWCEJ3+hrDenagOUzZ08T9iWisS0yedLpKEua8awGcPmqlsn030LveoUl7h4vrQ8IS9F7d9UN5ZkIopWg8hel1zGjlLpImPthbrjaD+xJD9oPNEva2o4fr5y5RVfLMwRvSsy/7gCrSnpK53ZTtOb6ihT3Z8ImiLY2FV2rg46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pF2AWhO5; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fdD1g+EgqAoBbR/5pfBU6XXCDFD61JPfA7DpX5xZ62E=;
	b=pF2AWhO52nLj2DGt1fXtJdXY5e/KLlBa30t9+EodGDR44q9izLmn8M2jFpza6hSYfzICNpXJS
	9jE9+lyBqPnGarlucaB+3lsBLqbNLZlDMPU/hLM13Q5fboShdbApMJxEGjyK8vf2fFK/m4f2air
	/trXnWt8K2+IB7Ih+3EvRoQ=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cpcw01HLmzcb1s;
	Sat, 18 Oct 2025 18:13:20 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DD001800B1;
	Sat, 18 Oct 2025 18:14:24 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 18 Oct 2025 18:14:23 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v2] tools/dma: move dma_map_benchmark from selftests to tools/dma
Date: Sat, 18 Oct 2025 18:14:02 +0800
Message-ID: <20251018101402.3079372-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
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
Changes since v1:
1) Addressed comments from Barry:
   - Moved map_benchmark.h from include/linux to include/uapi/linux/.
   - Modified CFLAGS in Makefile to reflect the new header location.

2) Added a .gitignore file to exclude unnecessary files.

3) Restored the 'expansion' field in 'struct map_benchmark':
   - This field was accidentally removed in commit 8ddde07a3d.
   - The change ensures that the structure remains compatible with existing codebases.
Link: https://lore.kernel.org/all/20250814133527.2679261-1-xiaqinxin@huawei.com/
---
 include/linux/map_benchmark.h                 | 22 +------------
 include/uapi/linux/map_benchmark.h            | 33 +++++++++++++++++++
 tools/Makefile                                | 13 ++++----
 tools/dma/.gitignore                          |  2 ++
 tools/dma/Makefile                            | 17 ++++++++++
 tools/{testing/selftests => }/dma/config      |  0
 .../selftests => }/dma/dma_map_benchmark.c    |  0
 tools/testing/selftests/dma/Makefile          |  7 ----
 8 files changed, 60 insertions(+), 34 deletions(-)
 create mode 100644 include/uapi/linux/map_benchmark.h
 create mode 100644 tools/dma/.gitignore
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..c1bcb4b23398 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -6,26 +6,6 @@
 #ifndef _KERNEL_DMA_BENCHMARK_H
 #define _KERNEL_DMA_BENCHMARK_H
 
-#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
-#define DMA_MAP_MAX_THREADS     1024
-#define DMA_MAP_MAX_SECONDS     300
-#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
+#include <uapi/linux/map_benchmark.h>
 
-#define DMA_MAP_BIDIRECTIONAL   0
-#define DMA_MAP_TO_DEVICE       1
-#define DMA_MAP_FROM_DEVICE     2
-
-struct map_benchmark {
-	__u64 avg_map_100ns; /* average map latency in 100ns */
-	__u64 map_stddev; /* standard deviation of map latency */
-	__u64 avg_unmap_100ns; /* as above */
-	__u64 unmap_stddev;
-	__u32 threads; /* how many threads will do map/unmap in parallel */
-	__u32 seconds; /* how long the test will last */
-	__s32 node; /* which numa node this benchmark will run on */
-	__u32 dma_bits; /* DMA addressing capability */
-	__u32 dma_dir; /* DMA data direction */
-	__u32 dma_trans_ns; /* time for DMA transmission in ns */
-	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
-};
 #endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
new file mode 100644
index 000000000000..2a75041803d4
--- /dev/null
+++ b/include/uapi/linux/map_benchmark.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2025 HiSilicon Limited.
+ */
+
+#ifndef _UAPI_DMA_BENCHMARK_H
+#define _UAPI_DMA_BENCHMARK_H
+
+#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_MAX_THREADS     1024
+#define DMA_MAP_MAX_SECONDS     300
+#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
+
+#define DMA_MAP_BIDIRECTIONAL   0
+#define DMA_MAP_TO_DEVICE       1
+#define DMA_MAP_FROM_DEVICE     2
+
+struct map_benchmark {
+	__u64 avg_map_100ns; /* average map latency in 100ns */
+	__u64 map_stddev; /* standard deviation of map latency */
+	__u64 avg_unmap_100ns; /* as above */
+	__u64 unmap_stddev;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	__s32 node; /* which numa node this benchmark will run on */
+	__u32 dma_bits; /* DMA addressing capability */
+	__u32 dma_dir; /* DMA data direction */
+	__u32 dma_trans_ns; /* time for DMA transmission in ns */
+	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76]; /* For future use */
+};
+
+#endif /* _UAPI_DMA_BENCHMARK_H */
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
diff --git a/tools/dma/.gitignore b/tools/dma/.gitignore
new file mode 100644
index 000000000000..b4b99b6ffea3
--- /dev/null
+++ b/tools/dma/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dma_map_benchmark
diff --git a/tools/dma/Makefile b/tools/dma/Makefile
new file mode 100644
index 000000000000..4acbd9e00cfa
--- /dev/null
+++ b/tools/dma/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+bindir ?= /usr/bin
+
+CFLAGS += -idirafter../../include/uapi
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


