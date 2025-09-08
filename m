Return-Path: <linux-kernel+bounces-806530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EADB49824
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355C1188B6CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F58311C1B;
	Mon,  8 Sep 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NeT+Fz0o"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C6314A9A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355572; cv=none; b=mTt9CW7U8K2LivvxEgstWGY7eCPTJvw6JZ2JiBQngKJDyxgGbzfW7OL3XxEYxARg3jbJkIX/bMex/vXzNcJovbtLNGb89k/2ufRAtAMA3uvlILW67z70FFobCIFWh3WY3EzelArMvxii1hc7/nBvR7gRd/CMNgG1QUcSc29cfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355572; c=relaxed/simple;
	bh=jXwfYL2/7Lf0BTEjs4BfZSg7nS9V9YYwQv44nn3u33o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDfmAlVLA+FK4YDFYFfTIz0TzfIWbvFIw5BG2OuDTKZhGmSboODgOY31tng+6diYwdL4mn3ut26cxFLgCKCc0raO16VbOSH8I51g6s0aCKc1/9WEaXenr1Z50y+cSqhRhPnaRLkErt+rLeX2moI0hvAJHS+WHlHDZb55Dy1b7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NeT+Fz0o; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4075904b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757355569; x=1757960369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk4zQ1AMb6Oi8x2H/9hI9B4kuWghu9H8dMMYPZBZZ9E=;
        b=NeT+Fz0od9tpMDletDseQLAwdqnisL8s+KmyQB9SqOX+Z5esrRW8RR8H1JycV8Zgrt
         uMNsR3109enI4MD4fxaRAOAesLO44R2yXq4osdz3VGUyYzmY0ASvhRVBqtMv/LFujVjk
         tg1Li44WJAEJ4mQZRDIUo3crRidkoI1XBTI/L98RH4dih2gdVrmAoQMh1jelC9mLf3MM
         SRSfPyR7MimgQXbYiKvwJimsxsqKh3Z7bgGHcyKc6uh17sRdf4XUlSydfz4i5Ol+ztGS
         cW/5xNTls4LIDCJIy43b9P1oi4My4rXc6pmjjHyCypG6M49iPe3ex+K0yDXYLKqo5uh9
         jURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355569; x=1757960369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk4zQ1AMb6Oi8x2H/9hI9B4kuWghu9H8dMMYPZBZZ9E=;
        b=DmSg1v11anc+nu/Zat2B5gBTfjDK0ZvATW5n21GaKfgEpYTJ1jQ1iKR1Mq4o3HfmYV
         AEOKxI+wBx9tc8hGcoqZdVjbfLAktc88QU9IWbtXPvBymzUYx4PUoy4F4bBWOJRPhV28
         b0jiwyUx7tIlG3vnDyWNWxYq7qnZTHrARg2D7KixxGPFiFHDfVa5kK7ZLZNgI2mpY/mn
         GgyaqyphWTgLJ2fgne2ah7WGN33ZevRQ/HCU4E5OUCIS1ODEayt1XaoK4mD0IgEefI27
         lkK2a8l4pXbLAGcK126XWOc6bD4CpnTZEW8jTuaYYBaAkydV4TQnINrHO05bOHjlzEwp
         I0qg==
X-Forwarded-Encrypted: i=1; AJvYcCVzZbdWxR4xeN4vb2eBUeSartH2vZ6xgDDY1NzBx8pGb/msBU5LrVAZqcojkJLf24OxNYcESu5IVxFOnJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTqa4vjMPn/tZHdAobokvCuzb0JXqXa5D/XfPf1APN0h+N2H4
	gWE2sjnDGoetk90GuPQzio62TW6Y9tNLmFAkxwIDm1GmQssIgS3kttsH+7MGujHN+WE=
X-Gm-Gg: ASbGnctvtJvS7W3hQD/ljPEq3q5VjQsPlwS3EYlG9tqA1fEv97SAHgX0xm9O7Escdyf
	6nil07JfoHB16soS285JZ4x/DQpt+5xXAA0aO+qlOKWcYdYYBeoXurwT05Hg1YqtRC+kMm20jwq
	MiAIMUn8kW5FyBmXCnA4HqW3N6CIn13uzBx/XkNL/eMiqQS7ZdIUvIy3gAh6koSuuHdeeDzf4qL
	Mvw20h7UVeTQFZyNtiFzUQ+QXeYySGy6n+wQYqfJdTiYJ13btCXnKh563ozDEY7apoW2Iv+mEpv
	jq8RhscbKeRQ+vhMyI/n5QRgAQRWsCLEtIJsITOts+RVduNJekBj1PuLr2SZ+2XNLVmlg8muKKP
	PZOk=
X-Google-Smtp-Source: AGHT+IGp56WXdQv6Bjj6PWmCZdyDxS5/Iilcz4D1q0oTR6IRl28o3n2FdFfFg6AHDOXy4c9oxkyPPg==
X-Received: by 2002:a17:902:fc84:b0:249:34b:29fe with SMTP id d9443c01a7336-25173118df4mr104526735ad.32.1757355568842;
        Mon, 08 Sep 2025 11:19:28 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd763948sm117012755ad.118.2025.09.08.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:19:28 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 3/5] drivers: firmware: add riscv SSE support
Date: Mon,  8 Sep 2025 18:17:05 +0000
Message-ID: <20250908181717.1997461-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908181717.1997461-1-cleger@rivosinc.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add driver level interface to use RISC-V SSE arch support. This interface
allows registering SSE handlers, and receive them. This will be used by
PMU and GHES driver.

Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                            |  15 +
 drivers/firmware/Kconfig               |   1 +
 drivers/firmware/Makefile              |   1 +
 drivers/firmware/riscv/Kconfig         |  15 +
 drivers/firmware/riscv/Makefile        |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 701 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  57 ++
 7 files changed, 793 insertions(+)
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..684d23f852c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21648,6 +21648,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V FIRMWARE DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
+F:	drivers/firmware/riscv/*
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
@@ -21712,6 +21719,14 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V SSE DRIVER
+M:	Clément Léger <cleger@rivosinc.com>
+R:	Himanshu Chauhan <himanshu@thechauhan.dev>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/riscv/riscv_sse.c
+F:	include/linux/riscv_sse.h
+
 RISC-V THEAD SoC SUPPORT
 M:	Drew Fustini <fustini@kernel.org>
 M:	Guo Ren <guoren@kernel.org>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..1894df87b08e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/microchip/Kconfig"
 source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/qcom/Kconfig"
+source "drivers/firmware/riscv/Kconfig"
 source "drivers/firmware/samsung/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4ddec2820c96..6cdd84570ea7 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -34,6 +34,7 @@ obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= qcom/
+obj-y				+= riscv/
 obj-y				+= samsung/
 obj-y				+= smccc/
 obj-y				+= tegra/
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
new file mode 100644
index 000000000000..ed5b663ac5f9
--- /dev/null
+++ b/drivers/firmware/riscv/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Risc-V Specific firmware drivers"
+depends on RISCV
+
+config RISCV_SBI_SSE
+	bool "Enable SBI Supervisor Software Events support"
+	depends on RISCV_SBI
+	default y
+	help
+	  The Supervisor Software Events support allows the SBI to deliver
+	  NMI-like notifications to the supervisor mode software. When enabled,
+	  this option provides support to register callbacks on specific SSE
+	  events.
+
+endmenu
diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
new file mode 100644
index 000000000000..c8795d4bbb2e
--- /dev/null
+++ b/drivers/firmware/riscv/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RISCV_SBI_SSE)		+= riscv_sbi_sse.o
diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
new file mode 100644
index 000000000000..57b6dad92482
--- /dev/null
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "sse: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpu_pm.h>
+#include <linux/hardirq.h>
+#include <linux/list.h>
+#include <linux/percpu-defs.h>
+#include <linux/reboot.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/slab.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+struct sse_event {
+	struct list_head list;
+	u32 evt_id;
+	u32 priority;
+	sse_event_handler_fn *handler;
+	void *handler_arg;
+	/* Only valid for global events */
+	unsigned int cpu;
+
+	union {
+		struct sse_registered_event *global;
+		struct sse_registered_event __percpu *local;
+	};
+};
+
+static int sse_hp_state;
+static bool sse_available __ro_after_init;
+static DEFINE_SPINLOCK(events_list_lock);
+static LIST_HEAD(events);
+static DEFINE_MUTEX(sse_mutex);
+
+struct sse_registered_event {
+	struct sse_event_arch_data arch;
+	struct sse_event *event;
+	unsigned long attr;
+	bool is_enabled;
+};
+
+void sse_handle_event(struct sse_event_arch_data *arch_event,
+		      struct pt_regs *regs)
+{
+	int ret;
+	struct sse_registered_event *reg_evt =
+		container_of(arch_event, struct sse_registered_event, arch);
+	struct sse_event *evt = reg_evt->event;
+
+	ret = evt->handler(evt->evt_id, evt->handler_arg, regs);
+	if (ret)
+		pr_warn("event %x handler failed with error %d\n", evt->evt_id, ret);
+}
+
+static struct sse_event *sse_event_get(u32 evt)
+{
+	struct sse_event *event = NULL;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			if (event->evt_id == evt)
+				return event;
+		}
+	}
+
+	return NULL;
+}
+
+static phys_addr_t sse_event_get_attr_phys(struct sse_registered_event *reg_evt)
+{
+	phys_addr_t phys;
+	void *addr = &reg_evt->attr;
+
+	if (sse_event_is_global(reg_evt->event->evt_id))
+		phys = virt_to_phys(addr);
+	else
+		phys = per_cpu_ptr_to_phys(addr);
+
+	return phys;
+}
+
+static struct sse_registered_event *sse_get_reg_evt(struct sse_event *event)
+{
+	if (sse_event_is_global(event->evt_id))
+		return event->global;
+	else
+		return per_cpu_ptr(event->local, smp_processor_id());
+}
+
+static int sse_sbi_event_func(struct sse_event *event, unsigned long func)
+{
+	struct sbiret ret;
+	u32 evt = event->evt_id;
+	struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
+
+	ret = sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to execute func %lx, event %x, error %ld\n",
+			func, evt, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	if (func == SBI_SSE_EVENT_DISABLE)
+		reg_evt->is_enabled = false;
+	else if (func == SBI_SSE_EVENT_ENABLE)
+		reg_evt->is_enabled = true;
+
+	return 0;
+}
+
+int sse_event_disable_local(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
+}
+EXPORT_SYMBOL_GPL(sse_event_disable_local);
+
+int sse_event_enable_local(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sse_event_enable_local);
+
+static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_evt,
+				      unsigned long attr_id, unsigned long *val)
+{
+	struct sbiret sret;
+	u32 evt = reg_evt->event->evt_id;
+	unsigned long phys;
+
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error) {
+		pr_debug("Failed to get event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+		return sbi_err_map_linux_errno(sret.error);
+	}
+
+	*val = reg_evt->attr;
+
+	return 0;
+}
+
+static int sse_event_attr_set_nolock(struct sse_registered_event *reg_evt,
+				     unsigned long attr_id, unsigned long val)
+{
+	struct sbiret sret;
+	u32 evt = reg_evt->event->evt_id;
+	unsigned long phys;
+
+	reg_evt->attr = val;
+	phys = sse_event_get_attr_phys(reg_evt);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error)
+		pr_debug("Failed to set event %x attr %lx, error %ld\n", evt,
+			 attr_id, sret.error);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+static void sse_global_event_update_cpu(struct sse_event *event,
+					unsigned int cpu)
+{
+	struct sse_registered_event *reg_evt = event->global;
+
+	event->cpu = cpu;
+	arch_sse_event_update_cpu(&reg_evt->arch, cpu);
+}
+
+static int sse_event_set_target_cpu_nolock(struct sse_event *event,
+					   unsigned int cpu)
+{
+	unsigned long hart_id = cpuid_to_hartid_map(cpu);
+	struct sse_registered_event *reg_evt = event->global;
+	u32 evt = event->evt_id;
+	bool was_enabled;
+	int ret;
+
+	if (!sse_event_is_global(evt))
+		return -EINVAL;
+
+	was_enabled = reg_evt->is_enabled;
+	if (was_enabled)
+		sse_event_disable_local(event);
+
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART,
+					hart_id);
+	if (ret == 0)
+		sse_global_event_update_cpu(event, cpu);
+
+	if (was_enabled)
+		sse_event_enable_local(event);
+
+	return 0;
+}
+
+int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
+{
+	int ret;
+
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock) {
+			if (!cpu_online(cpu))
+				return -EINVAL;
+
+			ret = sse_event_set_target_cpu_nolock(event, cpu);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_set_target_cpu);
+
+static int sse_event_init_registered(unsigned int cpu,
+				     struct sse_registered_event *reg_evt,
+				     struct sse_event *event)
+{
+	reg_evt->event = event;
+
+	return arch_sse_init_event(&reg_evt->arch, event->evt_id, cpu);
+}
+
+static void sse_event_free_registered(struct sse_registered_event *reg_evt)
+{
+	arch_sse_free_event(&reg_evt->arch);
+}
+
+static int sse_event_alloc_global(struct sse_event *event)
+{
+	int err;
+	struct sse_registered_event *reg_evt;
+
+	reg_evt = kzalloc(sizeof(*reg_evt), GFP_KERNEL);
+	if (!reg_evt)
+		return -ENOMEM;
+
+	event->global = reg_evt;
+	err = sse_event_init_registered(smp_processor_id(), reg_evt, event);
+	if (err)
+		kfree(reg_evt);
+
+	return err;
+}
+
+static int sse_event_alloc_local(struct sse_event *event)
+{
+	int err;
+	unsigned int cpu, err_cpu;
+	struct sse_registered_event *reg_evt;
+	struct sse_registered_event __percpu *reg_evts;
+
+	reg_evts = alloc_percpu(struct sse_registered_event);
+	if (!reg_evts)
+		return -ENOMEM;
+
+	event->local = reg_evts;
+
+	for_each_possible_cpu(cpu) {
+		reg_evt = per_cpu_ptr(reg_evts, cpu);
+		err = sse_event_init_registered(cpu, reg_evt, event);
+		if (err) {
+			err_cpu = cpu;
+			goto err_free_per_cpu;
+		}
+	}
+
+	return 0;
+
+err_free_per_cpu:
+	for_each_possible_cpu(cpu) {
+		if (cpu == err_cpu)
+			break;
+		reg_evt = per_cpu_ptr(reg_evts, cpu);
+		sse_event_free_registered(reg_evt);
+	}
+
+	free_percpu(reg_evts);
+
+	return err;
+}
+
+static struct sse_event *sse_event_alloc(u32 evt, u32 priority,
+					 sse_event_handler_fn *handler, void *arg)
+{
+	int err;
+	struct sse_event *event;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		return ERR_PTR(-ENOMEM);
+
+	event->evt_id = evt;
+	event->priority = priority;
+	event->handler_arg = arg;
+	event->handler = handler;
+
+	if (sse_event_is_global(evt))
+		err = sse_event_alloc_global(event);
+	else
+		err = sse_event_alloc_local(event);
+
+	if (err) {
+		kfree(event);
+		return ERR_PTR(err);
+	}
+
+	return event;
+}
+
+static int sse_sbi_register_event(struct sse_event *event,
+				  struct sse_registered_event *reg_evt)
+{
+	int ret;
+
+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
+					event->priority);
+	if (ret)
+		return ret;
+
+	return arch_sse_register_event(&reg_evt->arch);
+}
+
+static int sse_event_register_local(struct sse_event *event)
+{
+	int ret;
+	struct sse_registered_event *reg_evt;
+
+	reg_evt = per_cpu_ptr(event->local, smp_processor_id());
+	ret = sse_sbi_register_event(event, reg_evt);
+	if (ret)
+		pr_debug("Failed to register event %x: err %d\n", event->evt_id,
+			 ret);
+
+	return ret;
+}
+
+static int sse_sbi_unregister_event(struct sse_event *event)
+{
+	return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
+}
+
+struct sse_per_cpu_evt {
+	struct sse_event *event;
+	unsigned long func;
+	cpumask_t error;
+};
+
+static void sse_event_per_cpu_func(void *info)
+{
+	int ret;
+	struct sse_per_cpu_evt *cpu_evt = info;
+
+	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
+		ret = sse_event_register_local(cpu_evt->event);
+	else
+		ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
+
+	if (ret)
+		cpumask_set_cpu(smp_processor_id(), &cpu_evt->error);
+}
+
+static void sse_event_free(struct sse_event *event)
+{
+	unsigned int cpu;
+	struct sse_registered_event *reg_evt;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_event_free_registered(event->global);
+		kfree(event->global);
+	} else {
+		for_each_possible_cpu(cpu) {
+			reg_evt = per_cpu_ptr(event->local, cpu);
+			sse_event_free_registered(reg_evt);
+		}
+		free_percpu(event->local);
+	}
+
+	kfree(event);
+}
+
+static int sse_on_each_cpu(struct sse_event *event, unsigned long func,
+			   unsigned long revert_func)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	cpu_evt.event = event;
+	cpumask_clear(&cpu_evt.error);
+	cpu_evt.func = func;
+	on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	/*
+	 * If there are some error reported by CPUs, revert event state on the
+	 * other ones
+	 */
+	if (!cpumask_empty(&cpu_evt.error)) {
+		cpumask_t revert;
+
+		cpumask_andnot(&revert, cpu_online_mask, &cpu_evt.error);
+		cpu_evt.func = revert_func;
+		on_each_cpu_mask(&revert, sse_event_per_cpu_func, &cpu_evt, 1);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int sse_event_enable(struct sse_event *event)
+{
+	int ret = 0;
+
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock) {
+			if (sse_event_is_global(event->evt_id)) {
+				ret = sse_event_enable_local(event);
+			} else {
+				ret = sse_on_each_cpu(event,
+						      SBI_SSE_EVENT_ENABLE,
+						      SBI_SSE_EVENT_DISABLE);
+			}
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sse_event_enable);
+
+static int sse_events_mask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static int sse_events_unmask(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_UNMASK, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+
+static void sse_event_disable_nolock(struct sse_event *event)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_event_disable_local(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_DISABLE;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+}
+
+void sse_event_disable(struct sse_event *event)
+{
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock) {
+			sse_event_disable_nolock(event);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(sse_event_disable);
+
+struct sse_event *sse_event_register(u32 evt, u32 priority,
+				     sse_event_handler_fn *handler, void *arg)
+{
+	struct sse_event *event;
+	int cpu;
+	int ret = 0;
+
+	if (!sse_available)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	guard(mutex)(&sse_mutex);
+	if (sse_event_get(evt))
+		return ERR_PTR(-EEXIST);
+
+	event = sse_event_alloc(evt, priority, handler, arg);
+	if (IS_ERR(event))
+		return event;
+
+	scoped_guard(cpus_read_lock) {
+		if (sse_event_is_global(evt)) {
+			unsigned long preferred_hart;
+
+			ret = sse_event_attr_get_no_lock(event->global,
+							SBI_SSE_ATTR_PREFERRED_HART,
+							&preferred_hart);
+			if (ret)
+				goto err_event_free;
+
+			cpu = riscv_hartid_to_cpuid(preferred_hart);
+			sse_global_event_update_cpu(event, cpu);
+
+			ret = sse_sbi_register_event(event, event->global);
+			if (ret)
+				goto err_event_free;
+
+		} else {
+			ret = sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
+					      SBI_SSE_EVENT_DISABLE);
+			if (ret)
+				goto err_event_free;
+		}
+	}
+
+	scoped_guard(spinlock, &events_list_lock)
+		list_add(&event->list, &events);
+
+	return event;
+
+err_event_free:
+	sse_event_free(event);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(sse_event_register);
+
+static void sse_event_unregister_nolock(struct sse_event *event)
+{
+	struct sse_per_cpu_evt cpu_evt;
+
+	if (sse_event_is_global(event->evt_id)) {
+		sse_sbi_unregister_event(event);
+	} else {
+		cpu_evt.event = event;
+		cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
+	}
+}
+
+void sse_event_unregister(struct sse_event *event)
+{
+	scoped_guard(mutex, &sse_mutex) {
+		scoped_guard(cpus_read_lock)
+			sse_event_unregister_nolock(event);
+
+		scoped_guard(spinlock, &events_list_lock)
+			list_del(&event->list);
+
+		sse_event_free(event);
+	}
+}
+EXPORT_SYMBOL_GPL(sse_event_unregister);
+
+static int sse_cpu_online(unsigned int cpu)
+{
+	struct sse_event *event;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			if (sse_event_is_global(event->evt_id))
+				continue;
+
+			sse_event_register_local(event);
+			if (sse_get_reg_evt(event))
+				sse_event_enable_local(event);
+		}
+	}
+
+	/* Ready to handle events. Unmask SSE. */
+	return sse_events_unmask();
+}
+
+static int sse_cpu_teardown(unsigned int cpu)
+{
+	int ret = 0;
+	unsigned int next_cpu;
+	struct sse_event *event;
+
+	/* Mask the sse events */
+	ret = sse_events_mask();
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock, &events_list_lock) {
+		list_for_each_entry(event, &events, list) {
+			if (!sse_event_is_global(event->evt_id)) {
+				if (event->global->is_enabled)
+					sse_event_disable_local(event);
+
+				sse_sbi_unregister_event(event);
+				continue;
+			}
+
+			if (event->cpu != smp_processor_id())
+				continue;
+
+			/* Update destination hart for global event */
+			next_cpu = cpumask_any_but(cpu_online_mask, cpu);
+			ret = sse_event_set_target_cpu_nolock(event, next_cpu);
+		}
+	}
+
+	return ret;
+}
+
+static void sse_reset(void)
+{
+	struct sse_event *event;
+
+	list_for_each_entry(event, &events, list) {
+		sse_event_disable_nolock(event);
+		sse_event_unregister_nolock(event);
+	}
+}
+
+static int sse_pm_notifier(struct notifier_block *nb, unsigned long action,
+			   void *data)
+{
+	WARN_ON_ONCE(preemptible());
+
+	switch (action) {
+	case CPU_PM_ENTER:
+		sse_events_mask();
+		break;
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		sse_events_unmask();
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_pm_nb = {
+	.notifier_call = sse_pm_notifier,
+};
+
+/*
+ * Mask all CPUs and unregister all events on panic, reboot or kexec.
+ */
+static int sse_reboot_notifier(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	cpuhp_remove_state(sse_hp_state);
+	sse_reset();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sse_reboot_nb = {
+	.notifier_call = sse_reboot_notifier,
+};
+
+static int __init sse_init(void)
+{
+	int ret;
+
+	if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
+		pr_err("Missing SBI SSE extension\n");
+		return -EOPNOTSUPP;
+	}
+	pr_info("SBI SSE extension detected\n");
+
+	ret = cpu_pm_register_notifier(&sse_pm_nb);
+	if (ret) {
+		pr_warn("Failed to register CPU PM notifier...\n");
+		return ret;
+	}
+
+	ret = register_reboot_notifier(&sse_reboot_nb);
+	if (ret) {
+		pr_warn("Failed to register reboot notifier...\n");
+		goto remove_cpupm;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
+				sse_cpu_online, sse_cpu_teardown);
+	if (ret < 0)
+		goto remove_reboot;
+
+	sse_hp_state = ret;
+	sse_available = true;
+
+	return 0;
+
+remove_reboot:
+	unregister_reboot_notifier(&sse_reboot_nb);
+
+remove_cpupm:
+	cpu_pm_unregister_notifier(&sse_pm_nb);
+
+	return ret;
+}
+arch_initcall(sse_init);
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
new file mode 100644
index 000000000000..a1b58e89dd19
--- /dev/null
+++ b/include/linux/riscv_sbi_sse.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef __LINUX_RISCV_SBI_SSE_H
+#define __LINUX_RISCV_SBI_SSE_H
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+struct sse_event;
+struct pt_regs;
+
+typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
+				   struct pt_regs *regs);
+
+#ifdef CONFIG_RISCV_SBI_SSE
+
+struct sse_event *sse_event_register(u32 event_num, u32 priority,
+				     sse_event_handler_fn *handler, void *arg);
+
+void sse_event_unregister(struct sse_event *evt);
+
+int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
+
+int sse_event_enable(struct sse_event *sse_evt);
+
+void sse_event_disable(struct sse_event *sse_evt);
+
+int sse_event_enable_local(struct sse_event *sse_evt);
+int sse_event_disable_local(struct sse_event *sse_evt);
+
+#else
+static inline struct sse_event *sse_event_register(u32 event_num, u32 priority,
+						   sse_event_handler_fn *handler,
+						   void *arg)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void sse_event_unregister(struct sse_event *evt) {}
+
+static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
+					   unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_event_enable(struct sse_event *sse_evt)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void sse_event_disable(struct sse_event *sse_evt) {}
+#endif
+#endif /* __LINUX_RISCV_SBI_SSE_H */
-- 
2.43.0


