Return-Path: <linux-kernel+bounces-728131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC9B023E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93516B47A84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173CB2F3C2E;
	Fri, 11 Jul 2025 18:37:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20852F3C2A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259065; cv=none; b=BPIYM6TsX7L6z9w4zmbr6oDPZvOQ8p3uRd4jjEcmPjb2cR0BF7OiVeeraIrkU1Z2/3MTvwXVAnGyrHf4MnHjI53MessJfgw06AFfLX3yX/sL06sNYxyK+ESGtCF2rHG8M+SqMY7TQWFmC6SXiAR/a1ISKHzGAuMoyjsE8OIdQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259065; c=relaxed/simple;
	bh=xemdn49t+gXUB+2MCdDHAeLCEwOy9d0A43NR+n10jDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee8qX0du9mAsmL4c1jJzjNJVDDy6aQmZvI2Kw+jin8PEw8WPgQGuFN5CTgS/tA4Pn3za9PpC6BRNHf/330KxgKS41hNm1SXiBRo/l6zO53B9Eyz8fC1fNHcAruJLAGzQrGyMYHXBaAlDsb9LWVuIKbt+uaCxL2PDNjPG3oalu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B182247;
	Fri, 11 Jul 2025 11:37:32 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB083F778;
	Fri, 11 Jul 2025 11:37:40 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 12/36] platform: arm64: Move ec devices to an ec subdirectory
Date: Fri, 11 Jul 2025 18:36:24 +0000
Message-Id: <20250711183648.30766-13-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 363c8aea257 "platform: Add ARM64 platform directory" added a
subdirectory for arm64 platform devices, but claims that all such
devices must be 'EC like'.

The arm64 MPAM driver manages an MMIO interface that appears in memory
controllers, caches, IOMMU and connection points on the interconnect.
It doesn't fit into any existing subsystem.

It would be convenient to use this subdirectory for drivers for other
arm64 platform devices which aren't closely coupled to the architecture
code and don't fit into any existing subsystem.

Move the existing code and maintainer entries to be under
drivers/platform/arm64/ec. The MPAM driver will be added under
drivers/platform/arm64/mpam.

Signed-off-by: James Morse <james.morse@arm.com>
---
 MAINTAINERS                                   |  6 +-
 drivers/platform/arm64/Kconfig                | 72 +-----------------
 drivers/platform/arm64/Makefile               |  9 +--
 drivers/platform/arm64/ec/Kconfig             | 73 +++++++++++++++++++
 drivers/platform/arm64/ec/Makefile            | 10 +++
 .../platform/arm64/{ => ec}/acer-aspire1-ec.c |  0
 .../arm64/{ => ec}/huawei-gaokun-ec.c         |  0
 .../arm64/{ => ec}/lenovo-yoga-c630.c         |  0
 8 files changed, 88 insertions(+), 82 deletions(-)
 create mode 100644 drivers/platform/arm64/ec/Kconfig
 create mode 100644 drivers/platform/arm64/ec/Makefile
 rename drivers/platform/arm64/{ => ec}/acer-aspire1-ec.c (100%)
 rename drivers/platform/arm64/{ => ec}/huawei-gaokun-ec.c (100%)
 rename drivers/platform/arm64/{ => ec}/lenovo-yoga-c630.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bac4ea21b64..bea01d413666 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3549,15 +3549,15 @@ S:	Maintained
 F:	arch/arm64/boot/Makefile
 F:	scripts/make_fit.py
 
-ARM64 PLATFORM DRIVERS
-M:	Hans de Goede <hansg@kernel.org>
+ARM64 EC PLATFORM DRIVERS
+M:	Hans de Goede <hdegoede@redhat.com>
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
-F:	drivers/platform/arm64/
+F:	drivers/platform/arm64/ec
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index 06288aebc559..1eb8ab0855e5 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -1,73 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-#
-# EC-like Drivers for aarch64 based devices.
-#
 
-menuconfig ARM64_PLATFORM_DEVICES
-	bool "ARM64 Platform-Specific Device Drivers"
-	depends on ARM64 || COMPILE_TEST
-	default ARM64
-	help
-	  Say Y here to get to see options for platform-specific device drivers
-	  for arm64 based devices, primarily EC-like device drivers.
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if ARM64_PLATFORM_DEVICES
-
-config EC_ACER_ASPIRE1
-	tristate "Acer Aspire 1 Embedded Controller driver"
-	depends on ARCH_QCOM || COMPILE_TEST
-	depends on I2C
-	depends on DRM
-	depends on POWER_SUPPLY
-	depends on INPUT
-	help
-	  Say Y here to enable the EC driver for the (Snapdragon-based)
-	  Acer Aspire 1 laptop. The EC handles battery and charging
-	  monitoring as well as some misc functions like the lid sensor
-	  and USB Type-C DP HPD events.
-
-	  This driver provides battery and AC status support for the mentioned
-	  laptop where this information is not properly exposed via the
-	  standard ACPI devices.
-
-config EC_HUAWEI_GAOKUN
-	tristate "Huawei Matebook E Go Embedded Controller driver"
-	depends on ARCH_QCOM || COMPILE_TEST
-	depends on I2C
-	depends on INPUT
-	depends on HWMON
-	select AUXILIARY_BUS
-
-	help
-	  Say Y here to enable the EC driver for the Huawei Matebook E Go
-	  which is a sc8280xp-based 2-in-1 tablet. The driver handles battery
-	  (information, charge control) and USB Type-C DP HPD events as well
-	  as some misc functions like the lid sensor and temperature sensors,
-	  etc.
-
-	  This driver provides battery and AC status support for the mentioned
-	  laptop where this information is not properly exposed via the
-	  standard ACPI devices.
-
-	  Say M or Y here to include this support.
-
-config EC_LENOVO_YOGA_C630
-	tristate "Lenovo Yoga C630 Embedded Controller driver"
-	depends on ARCH_QCOM || COMPILE_TEST
-	depends on I2C
-	select AUXILIARY_BUS
-	help
-	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
-	  Lenovo Yoga C630, which provides battery and power adapter
-	  information.
-
-	  This driver provides battery and AC status support for the mentioned
-	  laptop where this information is not properly exposed via the
-	  standard ACPI devices.
-
-	  Say M or Y here to include this support.
-
-endif # ARM64_PLATFORM_DEVICES
+source "drivers/platform/arm64/ec/Kconfig"
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
index 46a99eba3264..ce840a8cf8cc 100644
--- a/drivers/platform/arm64/Makefile
+++ b/drivers/platform/arm64/Makefile
@@ -1,10 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for linux/drivers/platform/arm64
-#
-# This dir should only include drivers for EC-like devices.
-#
 
-obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
-obj-$(CONFIG_EC_HUAWEI_GAOKUN)	+= huawei-gaokun-ec.o
-obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
+obj-y             += ec/
diff --git a/drivers/platform/arm64/ec/Kconfig b/drivers/platform/arm64/ec/Kconfig
new file mode 100644
index 000000000000..06288aebc559
--- /dev/null
+++ b/drivers/platform/arm64/ec/Kconfig
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# EC-like Drivers for aarch64 based devices.
+#
+
+menuconfig ARM64_PLATFORM_DEVICES
+	bool "ARM64 Platform-Specific Device Drivers"
+	depends on ARM64 || COMPILE_TEST
+	default ARM64
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for arm64 based devices, primarily EC-like device drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if ARM64_PLATFORM_DEVICES
+
+config EC_ACER_ASPIRE1
+	tristate "Acer Aspire 1 Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	depends on DRM
+	depends on POWER_SUPPLY
+	depends on INPUT
+	help
+	  Say Y here to enable the EC driver for the (Snapdragon-based)
+	  Acer Aspire 1 laptop. The EC handles battery and charging
+	  monitoring as well as some misc functions like the lid sensor
+	  and USB Type-C DP HPD events.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
+config EC_HUAWEI_GAOKUN
+	tristate "Huawei Matebook E Go Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	depends on INPUT
+	depends on HWMON
+	select AUXILIARY_BUS
+
+	help
+	  Say Y here to enable the EC driver for the Huawei Matebook E Go
+	  which is a sc8280xp-based 2-in-1 tablet. The driver handles battery
+	  (information, charge control) and USB Type-C DP HPD events as well
+	  as some misc functions like the lid sensor and temperature sensors,
+	  etc.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
+	  Say M or Y here to include this support.
+
+config EC_LENOVO_YOGA_C630
+	tristate "Lenovo Yoga C630 Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	select AUXILIARY_BUS
+	help
+	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
+	  Lenovo Yoga C630, which provides battery and power adapter
+	  information.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
+	  Say M or Y here to include this support.
+
+endif # ARM64_PLATFORM_DEVICES
diff --git a/drivers/platform/arm64/ec/Makefile b/drivers/platform/arm64/ec/Makefile
new file mode 100644
index 000000000000..b3a7c4096f08
--- /dev/null
+++ b/drivers/platform/arm64/ec/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux/drivers/platform/arm64/ec
+#
+# This dir should only include drivers for EC-like devices.
+#
+
+obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
+obj-$(CONFIG_EC_HUAWEI_GAOKUN)	+= huawei-gaokun-ec.o
+obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
diff --git a/drivers/platform/arm64/acer-aspire1-ec.c b/drivers/platform/arm64/ec/acer-aspire1-ec.c
similarity index 100%
rename from drivers/platform/arm64/acer-aspire1-ec.c
rename to drivers/platform/arm64/ec/acer-aspire1-ec.c
diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform/arm64/ec/huawei-gaokun-ec.c
similarity index 100%
rename from drivers/platform/arm64/huawei-gaokun-ec.c
rename to drivers/platform/arm64/ec/huawei-gaokun-ec.c
diff --git a/drivers/platform/arm64/lenovo-yoga-c630.c b/drivers/platform/arm64/ec/lenovo-yoga-c630.c
similarity index 100%
rename from drivers/platform/arm64/lenovo-yoga-c630.c
rename to drivers/platform/arm64/ec/lenovo-yoga-c630.c
-- 
2.39.5


