Return-Path: <linux-kernel+bounces-864091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AFCBF9E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26453B22C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811752D47FF;
	Wed, 22 Oct 2025 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Pyhgp1YY"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC4199BC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105345; cv=none; b=azwnm80DX45WdXjYOOLAqcY5m4KIFUvsxBH5d7tSsHd6IHZT908V5n4RZ+Q5PrO+3nocReKcVmjyxyYdEfJj5qndpcpEHreE6k7THKhc2+0mec4p/ZWTdXKX0VVHViAOz3o2G6FLCoSz3soMa5cNIxD57m+plZTjnpth9OTP3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105345; c=relaxed/simple;
	bh=n7Odz6NS+bnQwWZCL3WKFwArO4bsTVUQTJExvcDVXSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DR9cloJsrrjQxA+lEmL6vV9Xvfm+nKQColxsxjWsaKXGUfh/4AbHWRE0nmoGuOQbquRbvxz+3Lfwh6D+ooX420UoWOMzJU733cDVrkhCI4IcZaCCpJcZOLMqZIDmfVRqOdjOT84k+SlK/PUBRzIBkEn4gNdVWHb/LzXgCw5ixtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pyhgp1YY; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uXV3rd7SjqK04TUdSkx11aA2ynadg5xdRe9N7vt10ho=;
	b=Pyhgp1YYJr5Hn0CUYB9cXP7pEPr79DHgljEkIQTUolVcAmH9+NIn0Ec/cH7gWMW2DtH1DMjVx
	0j5cY6uFOQ+ggFqu7/ilwieAj5JWDBmiG/NYwAei9lFEzwKtvAKTHPZStVYh6AqUkiMHKd1A2fR
	9BbMrZk2SQyCpmr721cpH3o=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4crwKY6M1nznTW3;
	Wed, 22 Oct 2025 11:54:57 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DA6E140155;
	Wed, 22 Oct 2025 11:55:39 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 11:55:38 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v4] tools/dma: move dma_map_benchmark from selftests to tools/dma
Date: Wed, 22 Oct 2025 11:55:28 +0800
Message-ID: <20251022035528.1981892-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)

dma_map_benchmark is a standalone developer tool rather than an
automated selftest. It has no pass/fail criteria, expects manual
invocation, and is built as a normal userspace binary. Move it to
tools/dma/ and add a minimal Makefile.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
Changes since v3:
1) Addressed comments from Barry:
   - Make a few minor modifications from gpio Makefile to dma.
   - Remove include/linux/map_benchmark.h.
Link: https://lore.kernel.org/all/20251021011739.1468912-1-xiaqinxin@huawei.com/

Changes since v2:
1) Fix some x86_64 build errors.
Link: https://lore.kernel.org/all/20251018101402.3079372-1-xiaqinxin@huawei.com/

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
 include/{ => uapi}/linux/map_benchmark.h      | 14 +++--
 kernel/dma/map_benchmark.c                    |  2 +-
 tools/Makefile                                | 13 +++--
 tools/dma/.gitignore                          |  3 +
 tools/dma/Makefile                            | 55 +++++++++++++++++++
 tools/{testing/selftests => }/dma/config      |  0
 .../selftests => }/dma/dma_map_benchmark.c    |  1 -
 tools/testing/selftests/dma/Makefile          |  7 ---
 8 files changed, 75 insertions(+), 20 deletions(-)
 rename include/{ => uapi}/linux/map_benchmark.h (76%)
 create mode 100644 tools/dma/.gitignore
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (99%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

diff --git a/include/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
similarity index 76%
rename from include/linux/map_benchmark.h
rename to include/uapi/linux/map_benchmark.h
index 62674c83bde4..3e4e2ece3f21 100644
--- a/include/linux/map_benchmark.h
+++ b/include/uapi/linux/map_benchmark.h
@@ -1,10 +1,12 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
- * Copyright (C) 2022 HiSilicon Limited.
+ * Copyright (C) 2025 HiSilicon Limited.
  */
 
-#ifndef _KERNEL_DMA_BENCHMARK_H
-#define _KERNEL_DMA_BENCHMARK_H
+#ifndef _UAPI_DMA_BENCHMARK_H
+#define _UAPI_DMA_BENCHMARK_H
+
+#include <linux/types.h>
 
 #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS     1024
@@ -27,5 +29,7 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8 expansion[76]; /* For future use */
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


