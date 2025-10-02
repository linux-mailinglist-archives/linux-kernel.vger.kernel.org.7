Return-Path: <linux-kernel+bounces-839858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFABB296B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C44202CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09672882A5;
	Thu,  2 Oct 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hgKFpkiG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB528725E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385338; cv=none; b=svWgYz8Uuc/dvpuT3oIs1bbsPajIkynRnm2PbtxBQ6y5+UfVq+mCx2k5OAIO+u9n+DdfnLYk6nEVz2XK8MDyjXzZOnkU2JOG1eNK0bWF6dY8qVDskTfTg03NId461q7dyneGHI5GAI/ZF+drPi82ef+oTRoteihAMmZ1K2vBNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385338; c=relaxed/simple;
	bh=lOHsyvTJOJiG0tf9/Mmf+m467IOd18DoT/rpd92xBfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnYAZ8Zs3ztuSrhBkyfuElQU6XMfSmeV7CJZgXY+B/9epn7KAodiQTrRxOib+crfRc0+nSSSaCkopvINXg678y7tsB8KLc8VCa/y44lzoc2tZzrrxdI1ZjD3VZMw3IrRQZsxsVc5NqJ5SebQJTz2bWSzd1uGQCzVg2T0QQvLXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hgKFpkiG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781206cce18so618103b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385336; x=1759990136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpifXrkDvDh1xYGpNX5UKxh32Xx9f0TyTyPM+srBPqY=;
        b=hgKFpkiGxO6yLWiNZjBKobzgsMUAHbQJt6HKIau7q/DEY1GNtfoHHyWGcbwtR3dSAF
         qeW56NmbyMYToy7EY/KWZzjNBaS0X/yw3cX+UFO7BMYTr45+qh4ygiXIpogSJKSHMZP0
         WDaXYHuvwup77gVDsmOyT7my+MMiiLpY+0hkDkhz7Bs9iv94BlV7lEPyFxgp/Yfx6YrU
         lyi6aMK3M4x56Q1cgONiaP2BUsPwZOc18ogiR4ymekjlq44iOjmOkWSry4RfKl/shN6G
         AmL/VNGXWope/c/H4+TkVuhB/RESvB31az9L/dJCEqRHSW8MfXGyIFrterPRQvZDUif3
         zO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385336; x=1759990136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpifXrkDvDh1xYGpNX5UKxh32Xx9f0TyTyPM+srBPqY=;
        b=TwSFRj9NdZQdRP6KJ/a8U93P9JonrFlkHi7dCskVQAR0m8Uw6SFIT4OAR29ufMzMPA
         5veD7By7zIfm1hlFbxwkvOmAnjXbEJwpSbEDHZ4KX7WpZQWgnepfq2000QPk3uddWg1v
         ZAMK4MsCAXjXqY+W5yR0MoyIBkbCar/CaFMe6wuKQFYf1Sz8eMHDKKLyhkSJlOKa869A
         JVOymzj5SP5Lj/3fQqGSnPcFSRCBkFQHCx3hWYdB1DpHW/DyHEj4LzRvQVcxHuO4Pz/n
         a28bYiT4/IQGZ1foEUDRNzhA2GvQ5IkKBKPG0IwC3S1m5HmIU2WacluGrOgptgd2xYXa
         D9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MyiJS1R649AnJHQIFb7e8DZ4hf4XWDX4BhfsXWtDuLlbSm51QW+euwlyBJpC9MxyAQSM1OvvA9xEaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDi5/5+r2xwZ/fmRrMu5x89hrSe1b+zaCeLrrzn9cAF6OESxth
	v1SpB/PCxRG9y0+ssU3QeSQSFlokolsKHzHZzoRf74QyB1rWO5I9TgRjssVaGAwenPQ=
X-Gm-Gg: ASbGncvIm+j2CDG+E/KVuw9vvqZzVafp4/KYhoxpeIbCzizyaEvanPNJKKy5BcmG4/b
	cXKQ4AkqrYkb5Ev1iVDJLU8QONDjcSmxpHRuhJv72CX9gBALINbqznBo17rQQYYrZzJxctxeRER
	BVefwIVUzpBr+mZrJGzSgWXzJPusgWg+rgIouwzOMbU4K1bhqXSVdgYbYE6Eok7xnvjDQ5Lvb/w
	F2wO3hetiK+/Xl3OiIANavBupSYoxD6aWXbwzLOYcN3djs1O3kb8wRKw2BQITtK8Nt1/SOPKNvU
	aPLtfgtGQ12D10Ld2GLgM0mW2UScDHLCsjM66TPxasMTH744u4Tn1XnA7cZLeejY8F1BdFJuvLt
	LwJUEACw6qqpg2orFGVgwqV21NVMEIddsJZB16iBgEY5/jPzFFqTMtWwV5tI1fEO1jCrwvKlYhZ
	4n/lov110rAULvtw==
X-Google-Smtp-Source: AGHT+IGsK5zmN/1TMI8l5ShAU1WG5heF+BcYOUnln5ovyw9K+EhBee4z4X9UbHLvM+t1E8NyUqH7Qw==
X-Received: by 2002:a05:6a21:6da8:b0:2be:8ead:1bec with SMTP id adf61e73a8af0-32a261f1677mr2900159637.24.1759385336405;
        Wed, 01 Oct 2025 23:08:56 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:08:55 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 05/11] rvtrace: Add trace encoder driver
Date: Thu,  2 Oct 2025 11:37:26 +0530
Message-ID: <20251002060732.100213-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Add initial implementation of RISC-V trace encoder driver. The encoder
is defined in the RISC-V Trace Control Interface specification.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/Kconfig           |   7 ++
 drivers/hwtracing/rvtrace/Makefile          |   1 +
 drivers/hwtracing/rvtrace/rvtrace-encoder.c | 107 ++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-encoder.c

diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
index f8f6feea1953..ba35c05f3f54 100644
--- a/drivers/hwtracing/rvtrace/Kconfig
+++ b/drivers/hwtracing/rvtrace/Kconfig
@@ -14,3 +14,10 @@ menuconfig RVTRACE
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called rvtrace.
+
+config RVTRACE_ENCODER
+	tristate "RISC-V Trace Encoder driver"
+	depends on RVTRACE
+	default y
+	help
+	  This driver provides support for RISC-V Trace Encoder component.
diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
index 988525a379cf..f320693a1fc5 100644
--- a/drivers/hwtracing/rvtrace/Makefile
+++ b/drivers/hwtracing/rvtrace/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RVTRACE) += rvtrace.o
 rvtrace-y := rvtrace-core.o rvtrace-platform.o
+obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
diff --git a/drivers/hwtracing/rvtrace/rvtrace-encoder.c b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
new file mode 100644
index 000000000000..45d1c5b12c51
--- /dev/null
+++ b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/rvtrace.h>
+#include <linux/types.h>
+
+#define RVTRACE_COMPONENT_CTRL_ITRACE_MASK	0x1
+#define RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT	2
+#define RVTRACE_COMPONENT_CTRL_INSTMODE_MASK	0x7
+#define RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT	4
+
+static int rvtrace_encoder_start(struct rvtrace_component *comp)
+{
+	u32 val;
+
+	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
+	val |= BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
+	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
+	return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
+				RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 1,
+				comp->pdata->control_poll_timeout_usecs);
+}
+
+static int rvtrace_encoder_stop(struct rvtrace_component *comp)
+{
+	u32 val;
+
+	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
+	val &= ~BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
+	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
+	return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
+				RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 0,
+				comp->pdata->control_poll_timeout_usecs);
+}
+
+static void rvtrace_encoder_setmode(struct rvtrace_component *comp, u32 mode)
+{
+	u32 val;
+
+	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
+	val |= (mode << RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT);
+	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
+}
+
+static int rvtrace_encoder_probe(struct rvtrace_component *comp)
+{
+	int ret;
+
+	rvtrace_encoder_setmode(comp, 0x6);
+	ret = rvtrace_enable_component(comp);
+	if (ret)
+		return dev_err_probe(&comp->dev, ret, "failed to enable encoder.\n");
+
+	return 0;
+}
+
+static void rvtrace_encoder_remove(struct rvtrace_component *comp)
+{
+	int ret;
+
+	ret = rvtrace_disable_component(comp);
+	if (ret)
+		dev_err(&comp->dev, "failed to disable encoder.\n");
+}
+
+static struct rvtrace_component_id rvtrace_encoder_ids[] = {
+	{ .type = RVTRACE_COMPONENT_TYPE_ENCODER,
+	  .version = rvtrace_component_mkversion(1, 0), },
+	{},
+};
+
+static struct rvtrace_driver rvtrace_encoder_driver = {
+	.id_table = rvtrace_encoder_ids,
+	.start = rvtrace_encoder_start,
+	.stop = rvtrace_encoder_stop,
+	.probe = rvtrace_encoder_probe,
+	.remove = rvtrace_encoder_remove,
+	.driver = {
+		.name = "rvtrace-encoder",
+	},
+};
+
+static int __init rvtrace_encoder_init(void)
+{
+	return rvtrace_register_driver(&rvtrace_encoder_driver);
+}
+
+static void __exit rvtrace_encoder_exit(void)
+{
+	rvtrace_unregister_driver(&rvtrace_encoder_driver);
+}
+
+module_init(rvtrace_encoder_init);
+module_exit(rvtrace_encoder_exit);
+
+/* Module information */
+MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com>");
+MODULE_DESCRIPTION("RISC-V Trace Encoder Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


