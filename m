Return-Path: <linux-kernel+bounces-724452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003ABAFF309
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E240A3BA2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D02494ED;
	Wed,  9 Jul 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YssNE3ki";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKWT4LAE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417918A6DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093056; cv=none; b=MviB13YwVw1w91cmw/FHJommsIAfpCx+HxAzXW/qQxjaoX0/j6X7Sxi84VMOb8UkdKrazxrASMKiPJMazXYnABRqXOstPXBlK05chm7+JARDilmXq22JBGKt3+1uYmeZUs03zyyniHd/tdEcvEXQxzErpY2rEJCDc9m/cxVTjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093056; c=relaxed/simple;
	bh=vgm4wXz2ieJ8rei31RF9l8O4B5rpM6AEB8ZaDd0ziX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s21ZBORpg1vWAtX3GalFHtD6igCJpHq2VH3e3I6KCAtgtQAo269k8s7Ijwncqh8rAzDx3RX+QuJBNHXehfF1kmYl/+FmXNb4IxP1W7Z+g6h3Yn2T3yLZkzIOGJiP9FlPPCNNA3/vEuQa+Q6drb2usdAsb3/CIaQQYH1egGUBamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YssNE3ki; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKWT4LAE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752093052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29AMpEVvuGmbWizJhTW06iinuJuS98YZlAM+Vegl7tc=;
	b=YssNE3kiD4+3inuu4KTP5ADq3cCDriU9WYcY3dpFc3ClfAFgC/vyyudVqnpHtuNq+aYJxL
	OLcIYqScIx1iVfKw8WmaGNVh53+Y+FHjkaCCj0iVJ8d7Snl3nwuO6TJNaNB8XwACtuj3to
	BqiVFIKgoU40OCCk7eqVq5ooenu0UTOdTzLLTT96POvx6QcTXE/QOgcBkuFew/A9C3ijrl
	4ut6BI7SD2V42P6ypny/LD8NGcB9MAwCR4F05B6LgpA5416z77eEQp99/NJmrxTUYtPAih
	pJhkyLUgpFiwGNi9UY6rebTbiYkdNSWVvf06eEn+ZRE8pOdU2rnhW8j4N3AJIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752093052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29AMpEVvuGmbWizJhTW06iinuJuS98YZlAM+Vegl7tc=;
	b=lKWT4LAEIXn32u+NzSM98aogiCKBEA09gyzZBgE9VwqTCgNO1xGLr3ubXSlmPQndTBwFyW
	BS6w4gbwb7qHrxAg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 4/6] drivers: Reorder headers alphabetically
Date: Wed,  9 Jul 2025 22:30:30 +0200
Message-ID: <20250709203033.90125-5-darwi@linutronix.de>
In-Reply-To: <20250709203033.90125-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
 <20250709203033.90125-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple drivers use the cpuid_*() macros, but implicitly include the
main CPUID header through <asm/processor.h> instead.

Sort their include lines so that <asm/cpuid/api.h> can be explicitly
included next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 drivers/cpufreq/longrun.c                    |  6 +++---
 drivers/cpufreq/powernow-k7.c                | 13 ++++++-------
 drivers/cpufreq/powernow-k8.c                | 16 ++++++++--------
 drivers/cpufreq/speedstep-lib.c              |  5 +++--
 drivers/hwmon/fam15h_power.c                 | 13 +++++++------
 drivers/hwmon/k8temp.c                       | 11 ++++++-----
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 14 +++++++-------
 7 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 1caaec7c280b..263c48b8f628 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -5,15 +5,15 @@
  *  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
  */
 
+#include <linux/cpufreq.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
 #include <linux/timex.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
-#include <asm/cpu_device_id.h>
 
 static struct cpufreq_driver	longrun_driver;
 
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..0608040fcd1e 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -15,20 +15,20 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpufreq.h>
+#include <linux/dmi.h>
+#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/dmi.h>
 #include <linux/timex.h>
-#include <linux/io.h>
 
-#include <asm/timer.h>		/* Needed for recalibrate_cpu_khz() */
-#include <asm/msr.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
+#include <asm/timer.h>		/* Needed for recalibrate_cpu_khz() */
 
 #ifdef CONFIG_X86_POWERNOW_K7_ACPI
 #include <linux/acpi.h>
@@ -691,4 +691,3 @@ MODULE_LICENSE("GPL");
 
 late_initcall(powernow_init);
 module_exit(powernow_exit);
-
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index f7512b4e923e..2b5cdd8f1c0a 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -26,22 +26,22 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/smp.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/string.h>
-#include <linux/cpumask.h>
-#include <linux/io.h>
-#include <linux/delay.h>
 
 #include <asm/msr.h>
 #include <asm/cpu_device_id.h>
 
-#include <linux/acpi.h>
-#include <linux/mutex.h>
 #include <acpi/processor.h>
 
 #define VERSION "version 2.20.00"
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 0b66df4ed513..f08817331aec 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -9,14 +9,15 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpufreq.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
 
 #include <asm/msr.h>
 #include <asm/tsc.h>
+
 #include "speedstep-lib.h"
 
 #define PFX "speedstep-lib: "
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 8ecebea53651..5a5674e85f63 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -6,20 +6,21 @@
  * Author: Andreas Herrmann <herrmann.der.user@googlemail.com>
  */
 
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/err.h>
-#include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/bitops.h>
-#include <linux/cpu.h>
-#include <linux/cpumask.h>
-#include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/time.h>
 #include <linux/topology.h>
-#include <asm/processor.h>
+
 #include <asm/msr.h>
+#include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 15h CPU processor power monitor");
 MODULE_AUTHOR("Andreas Herrmann <herrmann.der.user@googlemail.com>");
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 2b80ac410cd1..8c1efce9a04b 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -7,13 +7,14 @@
  * Inspired from the w83785 and amd756 drivers.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
 #include <asm/processor.h>
 
 #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 3fc679b6f11b..c843cb5fc5c3 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -5,19 +5,19 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/intel_tcc.h>
-#include <linux/err.h>
+#include <linux/module.h>
 #include <linux/param.h>
-#include <linux/device.h>
 #include <linux/platform_device.h>
-#include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/thermal.h>
-#include <linux/debugfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
-- 
2.49.0


