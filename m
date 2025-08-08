Return-Path: <linux-kernel+bounces-760512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE99B1EC48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD74317E620
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640EF28467C;
	Fri,  8 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="eKhn4Loz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38B27F4D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667603; cv=none; b=rEoe/OahMEWB1y79ULKYoMqA/+ON8zr9YnncAEotv7xAZnR2cOJqHfcBUiT/JDfCxcXEwNnnahW/E4gHQBGhPIkw5Wc4+tG+TrNKVYq32x/xRugmvt9WYBuodAe9oPRJaomrYkXeLcnC2VUrKzdpGiU6kkQZiD/95C/89ernuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667603; c=relaxed/simple;
	bh=2plyqNb8xw2OqiDRC5bbDKUhZl6MYEkusAPcVnFESnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIm7uiJKzFpfNRXaxsl/l9JOCder+nUGjaOjxC85vIMTK0nfghJ1MmZpgdtYuqPR2/XyCRn4sG1X4YH1vcUFECc1sRokTZt1Q9P4VsFlqJ0J8MTB8CfB0Xq/LZZSfZX1qbGiztgs8YIG0EXCdggre2OSS2FLRJO6k1UDDIXxDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=eKhn4Loz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so16245535ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754667600; x=1755272400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfQIKkVCQ2tl3OFf5X/XN1agXptqvxm2Y+O9eWMVJdY=;
        b=eKhn4LozDHlKPFxNGJd4avEyN5RKoVElI23d7o5aGwgodXNzAKvr02PZYM65YdQ/M1
         g5soG+vbtBTzui9QCAWu0Njt2wnZtxBP+uFn9Tk+E/Bxw2mWeH6//vLt9WRI+oYxClP8
         JtJakrhhw62WrVDNt/iUphRk9lPDNUc40CnzVKnHEUP8KgTzsAZlA/KDgk0XyZTuWzgx
         JPQsJwI87zhtE8+lv9htzwcie0S0zrxnZ0VBzwb6Y3Lnmz/LG8ACMdlLNIgvc8eJ3Xly
         9x/h7YDW9nNtY30dpHUBe9IcWBo6iwpM3XtSJ2rI9hnPYB2wfQZewoFVZriE44p4r6ar
         Wi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667600; x=1755272400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfQIKkVCQ2tl3OFf5X/XN1agXptqvxm2Y+O9eWMVJdY=;
        b=Q1F6uV3zX865vpGZWX2akMXzj5al4cQ1u9MFMUsV20Hdpj062GYxLsVlgG1b5VaMiR
         wfl11w8WNgDS5/R/sZ4QpX+/mDtlPl7/FIibIXQovP+GIa7y/tjg6X586GHG+Ixp8CB9
         YftydWgl/63GNGmzspgkMZfpWmPYl+V+CAlq/TLyzK4PmmPx2ql3eoYD8/hZpn3+ma4G
         5GhV2Q8gumjUwlkpS3a9sk7nRWLue2If9yq+nQqvo9sQYa8uqAWmnnK7KlpVQnPTRKWQ
         aBsFQs1ZW8C4yDzyzSNPphygL+ffkBYTAZHHMNzWQ5QAbO6RY9Aj8IqgMMnNhUsSpYjU
         +5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQoxzzEFb/N18zM0Uy/i3lF9BNPqUMHq9Ck1Y9kckwu2mEhVtEKAJVynmWO1NjTAkYwBxsCQrAuIzP1X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDJTEgwekr8IM1ZpRhjQw9FyxMxGiglLy0MQPnI7mFaM7GoK+
	wIIN3QpClS/Zwz/1ThngJh/2+tTvkXPQxgwDsCZJ8M+IFhkpZP5d7uoHOxWMdjVu/vA=
X-Gm-Gg: ASbGncvhZMa0JSPe/Eq8qdImYz7JBlxLOlXSY1ihgpEChQwWsJA6G8KNWHKgRuW7R2H
	+F8UEJv6W5VMSvfRYVaf2RmlGXHOgpsVkR7gs0tMCUsOhlBOGTNfrw9Gceh/iS5S7Jb+66fp8H6
	WDrO7a0KHzVUdDpnejCDmMVFsFRhjmntwL0Z9j3vVw7ZqUbkKDoPpICO2KTEqVkj6IA0eqXccxC
	KCAONZg3FN8WjCB3csqovKcfkc8DVWEXTM8l4TYhJEOcHZI8APgaPSHDOBDvsj2sjLy75Qx0fRW
	xis98KBIO+9hTGCo+HWZQMWkb6z22bOeoZBXwojga6zjgfNcxBzsuBUDRrdooWY27ZKn/yltnsG
	s4st+dRqt17VegA==
X-Google-Smtp-Source: AGHT+IGqjz8zxjL07zO8jPhrlaBm55tAc5qokyL7ERWtLOXrPFwaa/jynF+BQZ4fELKdgU55r76vWA==
X-Received: by 2002:a17:902:ecc2:b0:234:f4da:7eeb with SMTP id d9443c01a7336-242c1ffb1f7mr45054915ad.7.1754667599788;
        Fri, 08 Aug 2025 08:39:59 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3218c3c2d58sm1135971a91.16.2025.08.08.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:39:59 -0700 (PDT)
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
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v6 5/5] selftests/riscv: add SSE test module
Date: Fri,  8 Aug 2025 15:38:56 +0000
Message-ID: <20250808153901.2477005-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808153901.2477005-1-cleger@rivosinc.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This module, once loaded, will execute a series of tests using the SSE
framework. The provided script will check for any error reported by the
test module.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 513 ++++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
 5 files changed, 579 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 099b8c1f46f8..c62f58414b29 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector sse
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/sse/Makefile b/tools/testing/selftests/riscv/sse/Makefile
new file mode 100644
index 000000000000..67eaee06f213
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_MODS_DIR := module
+
+TEST_FILES := run_sse_test.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/riscv/sse/module/Makefile b/tools/testing/selftests/riscv/sse/module/Makefile
new file mode 100644
index 000000000000..02018f083456
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/Makefile
@@ -0,0 +1,16 @@
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+obj-m += riscv_sse_test.o
+
+# Ensure that KDIR exists, otherwise skip the compilation
+modules:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
+
+# Ensure that KDIR exists, otherwise skip the clean target
+clean:
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
new file mode 100644
index 000000000000..65df41a2d40a
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#define pr_fmt(fmt) "riscv_sse_test: " fmt
+
+#include <linux/array_size.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/riscv_sse.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/sbi.h>
+#include <asm/sse.h>
+
+#define RUN_LOOP_COUNT		1000
+#define SSE_FAILED_PREFIX	"FAILED: "
+#define sse_err(...)		pr_err(SSE_FAILED_PREFIX __VA_ARGS__)
+
+struct sse_event_desc {
+	u32 evt_id;
+	const char *name;
+	bool can_inject;
+};
+
+static struct sse_event_desc sse_event_descs[] = {
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS,
+		.name = "local_high_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP,
+		.name = "local_double_trap",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS,
+		.name = "global_high_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW,
+		.name = "local_pmu_overflow",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS,
+		.name = "local_low_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS,
+		.name = "global_low_prio_ras",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED,
+		.name = "local_software_injected",
+	},
+	{
+		.evt_id = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED,
+		.name = "global_software_injected",
+	}
+};
+
+static struct sse_event_desc *sse_get_evt_desc(u32 evt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		if (sse_event_descs[i].evt_id == evt)
+			return &sse_event_descs[i];
+	}
+
+	return NULL;
+}
+
+static const char *sse_evt_name(u32 evt)
+{
+	struct sse_event_desc *desc = sse_get_evt_desc(evt);
+
+	return desc != NULL ? desc->name : NULL;
+}
+
+static bool sse_test_can_inject_event(u32 evt)
+{
+	struct sse_event_desc *desc = sse_get_evt_desc(evt);
+
+	return desc != NULL ? desc->can_inject : false;
+}
+
+static struct sbiret sbi_sse_ecall(int fid, unsigned long arg0, unsigned long arg1)
+{
+	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
+}
+
+static int sse_event_attr_get(u32 evt, unsigned long attr_id,
+			      unsigned long *val)
+{
+	struct sbiret sret;
+	unsigned long *attr_buf, phys;
+
+	attr_buf = kmalloc(sizeof(unsigned long), GFP_KERNEL);
+	if (!attr_buf)
+		return -ENOMEM;
+
+	phys = virt_to_phys(attr_buf);
+
+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, 1,
+			 phys, 0, 0);
+	if (sret.error)
+		return sbi_err_map_linux_errno(sret.error);
+
+	*val = *attr_buf;
+
+	return 0;
+}
+
+static int sse_test_signal(u32 evt, unsigned int cpu)
+{
+	unsigned int hart_id = cpuid_to_hartid_map(cpu);
+	struct sbiret ret;
+
+	ret = sbi_sse_ecall(SBI_SSE_EVENT_SIGNAL, evt, hart_id);
+	if (ret.error) {
+		sse_err("Failed to signal event %x, error %ld\n", evt, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	return 0;
+}
+
+static int sse_test_inject_event(struct sse_event *event, u32 evt, unsigned int cpu)
+{
+	int res;
+	unsigned long status;
+
+	if (sse_event_is_global(evt)) {
+		/*
+		 * Due to the fact the completion might happen faster than
+		 * the call to SBI_SSE_COMPLETE in the handler, if the event was
+		 * running on another CPU, we need to wait for the event status
+		 * to be !RUNNING.
+		 */
+		do {
+			res = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &status);
+			if (res) {
+				sse_err("Failed to get status for evt %x, error %d\n", evt, res);
+				return res;
+			}
+			status = status & SBI_SSE_ATTR_STATUS_STATE_MASK;
+		} while (status == SBI_SSE_STATE_RUNNING);
+
+		res = sse_event_set_target_cpu(event, cpu);
+		if (res) {
+			sse_err("Failed to set cpu for evt %x, error %d\n", evt, res);
+			return res;
+		}
+	}
+
+	return sse_test_signal(evt, cpu);
+}
+
+struct fast_test_arg {
+	u32 evt;
+	int cpu;
+	bool completion;
+};
+
+static int sse_test_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	int ret = 0;
+	struct fast_test_arg *targ = arg;
+	u32 test_evt = READ_ONCE(targ->evt);
+	int cpu = READ_ONCE(targ->cpu);
+
+	if (evt != test_evt) {
+		sse_err("Received SSE event id %x instead of %x\n", test_evt, evt);
+		ret = -EINVAL;
+	}
+
+	if (cpu != smp_processor_id()) {
+		sse_err("Received SSE event %d on CPU %d instead of %d\n", evt, smp_processor_id(),
+			cpu);
+		ret = -EINVAL;
+	}
+
+	WRITE_ONCE(targ->completion, true);
+
+	return ret;
+}
+
+static void sse_run_fast_test(struct fast_test_arg *test_arg, struct sse_event *event, u32 evt)
+{
+	unsigned long timeout;
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		WRITE_ONCE(test_arg->completion, false);
+		WRITE_ONCE(test_arg->cpu, cpu);
+		/* Test arg is used on another CPU */
+		smp_wmb();
+
+		ret = sse_test_inject_event(event, evt, cpu);
+		if (ret) {
+			sse_err("event %s injection failed, err %d\n", sse_evt_name(evt), ret);
+			return;
+		}
+
+		timeout = jiffies + HZ / 100;
+		/* We can not use <linux/completion.h> since they are not NMI safe */
+		while (!READ_ONCE(test_arg->completion) &&
+			time_before(jiffies, timeout)) {
+			cpu_relax();
+		}
+		if (!time_before(jiffies, timeout)) {
+			sse_err("Failed to wait for event %s completion on CPU %d\n",
+				sse_evt_name(evt), cpu);
+			return;
+		}
+	}
+}
+
+static void sse_test_injection_fast(void)
+{
+	int i, ret = 0, j;
+	u32 evt;
+	struct fast_test_arg test_arg;
+	struct sse_event *event;
+
+	pr_info("Starting SSE test (fast)\n");
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		evt = sse_event_descs[i].evt_id;
+		WRITE_ONCE(test_arg.evt, evt);
+
+		if (!sse_event_descs[i].can_inject)
+			continue;
+
+		event = sse_event_register(evt, 0, sse_test_handler,
+					   (void *)&test_arg);
+		if (IS_ERR(event)) {
+			sse_err("Failed to register event %s, err %ld\n", sse_evt_name(evt),
+				PTR_ERR(event));
+			goto out;
+		}
+
+		ret = sse_event_enable(event);
+		if (ret) {
+			sse_err("Failed to enable event %s, err %d\n", sse_evt_name(evt), ret);
+			goto err_unregister;
+		}
+
+		pr_info("Starting testing event %s\n", sse_evt_name(evt));
+
+		for (j = 0; j < RUN_LOOP_COUNT; j++)
+			sse_run_fast_test(&test_arg, event, evt);
+
+		pr_info("Finished testing event %s\n", sse_evt_name(evt));
+
+		sse_event_disable(event);
+err_unregister:
+		sse_event_unregister(event);
+	}
+out:
+	pr_info("Finished SSE test (fast)\n");
+}
+
+struct priority_test_arg {
+	unsigned long evt;
+	struct sse_event *event;
+	bool called;
+	u32 prio;
+	struct priority_test_arg *next_evt_arg;
+	void (*check_func)(struct priority_test_arg *arg);
+};
+
+static int sse_hi_priority_test_handler(u32 evt, void *arg,
+					struct pt_regs *regs)
+{
+	struct priority_test_arg *targ = arg;
+	struct priority_test_arg *next = READ_ONCE(targ->next_evt_arg);
+
+	WRITE_ONCE(targ->called, 1);
+
+	if (next) {
+		sse_test_signal(next->evt, smp_processor_id());
+		if (!READ_ONCE(next->called)) {
+			sse_err("Higher priority event %s was not handled %s\n",
+			      sse_evt_name(next->evt), sse_evt_name(evt));
+		}
+	}
+
+	return 0;
+}
+
+static int sse_low_priority_test_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct priority_test_arg *targ = arg;
+	struct priority_test_arg *next = READ_ONCE(targ->next_evt_arg);
+
+	WRITE_ONCE(targ->called, 1);
+
+	if (next) {
+		sse_test_signal(next->evt, smp_processor_id());
+		if (READ_ONCE(next->called)) {
+			sse_err("Lower priority event %s was handle before %s\n",
+				sse_evt_name(next->evt), sse_evt_name(evt));
+		}
+	}
+
+	return 0;
+}
+
+static void sse_test_injection_priority_arg(struct priority_test_arg *args, unsigned int args_size,
+					    sse_event_handler handler, const char *test_name)
+{
+	unsigned int i;
+	int ret;
+	struct sse_event *event;
+	struct priority_test_arg *arg, *first_arg = NULL, *prev_arg = NULL;
+
+	pr_info("Starting SSE priority test (%s)\n", test_name);
+	for (i = 0; i < args_size; i++) {
+		arg = &args[i];
+
+		if (!sse_test_can_inject_event(arg->evt))
+			continue;
+
+		WRITE_ONCE(arg->called, false);
+		WRITE_ONCE(arg->next_evt_arg, NULL);
+		if (prev_arg)
+			WRITE_ONCE(prev_arg->next_evt_arg, arg);
+
+		prev_arg = arg;
+
+		if (!first_arg)
+			first_arg = arg;
+
+		event = sse_event_register(arg->evt, arg->prio, handler, (void *)arg);
+		if (IS_ERR(event)) {
+			sse_err("Failed to register event %s, err %ld\n", sse_evt_name(arg->evt),
+				PTR_ERR(event));
+			goto release_events;
+		}
+		arg->event = event;
+
+		if (sse_event_is_global(arg->evt)) {
+			/* Target event at current CPU */
+			ret = sse_event_set_target_cpu(event, smp_processor_id());
+			if (ret) {
+				sse_err("Failed to set event %s target CPU, err %d\n",
+					sse_evt_name(arg->evt), ret);
+				goto release_events;
+			}
+		}
+
+		ret = sse_event_enable(event);
+		if (ret) {
+			sse_err("Failed to enable event %s, err %d\n", sse_evt_name(arg->evt), ret);
+			goto release_events;
+		}
+	}
+
+	if (!first_arg) {
+		sse_err("No injectable event available\n");
+		return;
+	}
+
+	/* Inject first event, handler should trigger the others in chain. */
+	ret = sse_test_inject_event(first_arg->event, first_arg->evt, smp_processor_id());
+	if (ret) {
+		sse_err("SSE event %s injection failed\n", sse_evt_name(first_arg->evt));
+		goto release_events;
+	}
+
+	/*
+	 * Event are injected directly on the current CPU after calling sse_test_inject_event()
+	 * so that execution is premmpted right away, no need to wait for timeout.
+	 */
+	arg = first_arg;
+	while (arg) {
+		if (!READ_ONCE(arg->called)) {
+			sse_err("Event %s handler was not called\n",
+			      sse_evt_name(arg->evt));
+			ret = -EINVAL;
+		}
+
+
+		event = arg->event;
+		arg = READ_ONCE(arg->next_evt_arg);
+	}
+
+release_events:
+
+	arg = first_arg;
+	while (arg) {
+		event = arg->event;
+		if (!event)
+			break;
+
+		sse_event_disable(event);
+		sse_event_unregister(event);
+		arg = READ_ONCE(arg->next_evt_arg);
+	}
+
+	pr_info("Finished SSE priority test (%s)\n", test_name);
+}
+
+static void sse_test_injection_priority(void)
+{
+	struct priority_test_arg default_hi_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+	};
+
+	struct priority_test_arg default_low_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED },
+
+	};
+	struct priority_test_arg set_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 5 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS, .prio = 15 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS, .prio = 20 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 25 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 30 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP, .prio = 35 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 40 },
+	};
+
+	struct priority_test_arg same_prio_args[] = {
+		{ .evt = SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, .prio = 0 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED, .prio = 10 },
+		{ .evt = SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS, .prio = 20 },
+	};
+
+	sse_test_injection_priority_arg(default_hi_prio_args, ARRAY_SIZE(default_hi_prio_args),
+					sse_hi_priority_test_handler, "high");
+
+	sse_test_injection_priority_arg(default_low_prio_args, ARRAY_SIZE(default_low_prio_args),
+					sse_low_priority_test_handler, "low");
+
+	sse_test_injection_priority_arg(set_prio_args, ARRAY_SIZE(set_prio_args),
+					sse_low_priority_test_handler, "set");
+
+	sse_test_injection_priority_arg(same_prio_args, ARRAY_SIZE(same_prio_args),
+					sse_low_priority_test_handler, "same_prio_args");
+}
+
+
+static bool sse_get_inject_status(u32 evt)
+{
+	int ret;
+	unsigned long val;
+
+	/* Check if injection is supported */
+	ret = sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &val);
+	if (ret)
+		return false;
+
+	return !!(val & BIT(SBI_SSE_ATTR_STATUS_INJECT_OFFSET));
+}
+
+static void sse_init_events(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sse_event_descs); i++) {
+		struct sse_event_desc *desc = &sse_event_descs[i];
+
+		desc->can_inject = sse_get_inject_status(desc->evt_id);
+		if (!desc->can_inject)
+			pr_info("Can not inject event %s, tests using this event will be skipped\n",
+				desc->name);
+	}
+}
+
+static int __init sse_test_init(void)
+{
+	sse_init_events();
+
+	sse_test_injection_fast();
+	sse_test_injection_priority();
+
+	return 0;
+}
+
+static void __exit sse_test_exit(void)
+{
+}
+
+module_init(sse_test_init);
+module_exit(sse_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Clément Léger <cleger@rivosinc.com>");
+MODULE_DESCRIPTION("Test module for SSE");
diff --git a/tools/testing/selftests/riscv/sse/run_sse_test.sh b/tools/testing/selftests/riscv/sse/run_sse_test.sh
new file mode 100644
index 000000000000..888bc4a99cb3
--- /dev/null
+++ b/tools/testing/selftests/riscv/sse/run_sse_test.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Rivos Inc.
+
+MODULE_NAME=riscv_sse_test
+DRIVER="./module/${MODULE_NAME}.ko"
+
+check_test_failed_prefix() {
+	if dmesg | grep -q "${MODULE_NAME}: FAILED:";then
+		echo "${MODULE_NAME} failed, please check dmesg"
+		exit 1
+	fi
+}
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+check_test_requirements()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which insmod > /dev/null 2>&1; then
+		echo "$0: You need insmod installed"
+		exit $ksft_skip
+	fi
+
+	if [ ! -f $DRIVER ]; then
+		echo "$0: You need to compile ${MODULE_NAME} module"
+		exit $ksft_skip
+	fi
+}
+
+check_test_requirements
+
+insmod $DRIVER > /dev/null 2>&1
+rmmod $MODULE_NAME
+check_test_failed_prefix
+
+exit 0
-- 
2.43.0


