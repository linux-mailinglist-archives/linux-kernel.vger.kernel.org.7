Return-Path: <linux-kernel+bounces-873728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD4C148C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7364227E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A7E32AADC;
	Tue, 28 Oct 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sH+sNXyJ"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6C2E717C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653368; cv=none; b=SDYijxWGHpOppctJnxThSVox/q/rXwfZzPPwMcJcySgFvdJnnKXJI+3WrcJR8Ak/nRwbO1HT1wfkb/9Nyc7BnpqhN9RwTHFAHtNnVzzrUtWYCBhJnc6lKmZPklFR06dMStMxYcud2PVtUJwMnanVak0rSVqGJ2f6vnxIgfHGnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653368; c=relaxed/simple;
	bh=wrjYxTTaCv7Jo6yZO3qotRbSKY/qGtuzUW3D9wKwBbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3meBIZK/qgFLcjUlmNf8//2O9nFF6BVvv8xbb9esBrGp+MLIuCrvIJs2YVjD0IlCLoNAIJAPMgEkgPmfTwgUoh52dFo2OxHPcYRTCfvYMJEoIUKONT4gnDVFwZ/TuSyBebOcPIwO0Me0Oh8EpQjXOjq5BP5l15r7XhCDvbTAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sH+sNXyJ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PzkjwYAsQ2f69IEiQKCPzNE87qJHS3Y/SmzxuyLcBMQ=;
	b=sH+sNXyJ6cC5qvFxAyh5QFM8hpi4AIXlZ+o32t2lL9J+2YyKHM3l4uZfuJAjauW5hsIKFhsIT
	nHWflUTB43+vG48SIdDGbcmTr4OXk5oVfhQF6nAxJGr8dP92GP/0i4YyTm/0uHMqulBDlm8GGRM
	bUlfkErOE1sGoXQpoiSWu4Y=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cwpzp43VjzpStg;
	Tue, 28 Oct 2025 20:08:06 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D41C180B4A;
	Tue, 28 Oct 2025 20:09:23 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 20:09:23 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>, Barry Song
	<baohua@kernel.org>
Subject: [PATCH v5 2/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
Date: Tue, 28 Oct 2025 20:09:00 +0800
Message-ID: <20251028120900.2265511-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251028120900.2265511-1-xiaqinxin@huawei.com>
References: <20251028120900.2265511-1-xiaqinxin@huawei.com>
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
tools/dma/ and add a minimal Makefile.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Barry Song <baohua@kernel.org>
Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/{ => uapi}/linux/map_benchmark.h      | 13 +++--
 kernel/dma/map_benchmark.c                    |  2 +-
 tools/Makefile                                | 13 +++--
 tools/dma/.gitignore                          |  3 +
 tools/dma/Makefile                            | 55 +++++++++++++++++++
 tools/{testing/selftests => }/dma/config      |  0
 .../selftests => }/dma/dma_map_benchmark.c    |  1 -
 tools/testing/selftests/dma/Makefile          |  7 ---
 8 files changed, 74 insertions(+), 20 deletions(-)
 rename include/{ => uapi}/linux/map_benchmark.h (80%)
 create mode 100644 tools/dma/.gitignore
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (99%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

diff --git a/include/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
similarity index 80%
rename from include/linux/map_benchmark.h
rename to include/uapi/linux/map_benchmark.h
index 48e2ff95332f..c2d91088a40d 100644
--- a/include/linux/map_benchmark.h
+++ b/include/uapi/linux/map_benchmark.h
@@ -1,10 +1,12 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
- * Copyright (C) 2022 HiSilicon Limited.
+ * Copyright (C) 2022-2025 HiSilicon Limited.
  */
 
-#ifndef _KERNEL_DMA_BENCHMARK_H
-#define _KERNEL_DMA_BENCHMARK_H
+#ifndef _UAPI_DMA_BENCHMARK_H
+#define _UAPI_DMA_BENCHMARK_H
+
+#include <linux/types.h>
 
 #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS     1024
@@ -29,4 +31,5 @@ struct map_benchmark {
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
 	__u8 expansion[76]; /* For future use */
 };
-#endif /* _KERNEL_DMA_BENCHMARK_H */
+
+#endif /* _UAPI_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index cc19a3efea89..794041a39e65 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -11,13 +11,13 @@
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/map_benchmark.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
+#include <uapi/linux/map_benchmark.h>
 
 struct map_benchmark_data {
 	struct map_benchmark bparam;
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
index 000000000000..94b68cf4147b
--- /dev/null
+++ b/tools/dma/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dma_map_benchmark
+include/linux/map_benchmark.h
diff --git a/tools/dma/Makefile b/tools/dma/Makefile
new file mode 100644
index 000000000000..e4abf37bf020
--- /dev/null
+++ b/tools/dma/Makefile
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+bindir ?= /usr/bin
+
+# This will work when dma is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := dma_map_benchmark
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/map_benchmark.h: ../../include/uapi/linux/map_benchmark.h
+	mkdir -p $(OUTPUT)include/linux 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/map_benchmark.h $@
+
+prepare: $(OUTPUT)include/linux/map_benchmark.h
+
+FORCE:
+
+DMA_MAP_BENCHMARK = dma_map_benchmark
+$(DMA_MAP_BENCHMARK): prepare FORCE
+	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $(DMA_MAP_BENCHMARK)
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+.PHONY: all install clean prepare FORCE
diff --git a/tools/testing/selftests/dma/config b/tools/dma/config
similarity index 100%
rename from tools/testing/selftests/dma/config
rename to tools/dma/config
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
similarity index 99%
rename from tools/testing/selftests/dma/dma_map_benchmark.c
rename to tools/dma/dma_map_benchmark.c
index b12f1f9babf8..5474a450863c 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/dma/dma_map_benchmark.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <linux/types.h>
 #include <linux/map_benchmark.h>
 
 #define NSEC_PER_MSEC	1000000L
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


