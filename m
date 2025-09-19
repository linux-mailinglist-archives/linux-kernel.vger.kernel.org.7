Return-Path: <linux-kernel+bounces-824082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA47B88145
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 313A74E11D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFC26773C;
	Fri, 19 Sep 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fm0zP/ph"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271419F13F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265290; cv=none; b=AzFeFH5bKkg3uGkO1WV9UZuqqcgkj0YFWlCG8D3IdPBg4a3UsA+OuYuWi8j+JoxMI3jm5lwHLRKNAZb6KhDcqjHH32B1WQ9dXAKv1L6x4cszRXnK592GSqVLCp03b+fo8IgEBFXblqCD2ewPkM9A/s7F17o7evoaORQDjuLpdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265290; c=relaxed/simple;
	bh=Y7t+dCmDznFOMg60puvUQgl+F0eRulZiopJK2Rp+1T8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHzJo9Tbq/T2zeWo2ZhgADnedPvCki7CuInxtjKYFxiVKJlIV3IZ+pnfscCRpIYA+PLeCHNmUmgMNN13ZkqyiSmxrkXPHfRlduPr97REx7MFU2I2EbXocvk+SsNp5b/Bx3ymoF5RLyzHsI8h6RdRBHN9L+4I1pQVCia/FU7eKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fm0zP/ph; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1698304b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758265287; x=1758870087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ab3i3SAEiCM3mWXvINF+8OQsYTxxSN3LITXrtSETem4=;
        b=fm0zP/phrnX+lr7rCfuA1/CiI/aMNG+CCElUbuzDfYk5ie6PAuOJ2Oirij+nL/0677
         TSVKGaIMifpqhFYxnZc4/Kg3cebpSlY/sjMClnYOtJbQxA+JgYBhLgDwd8D5eMPFzygF
         Kaiq2blqjkSdNGvN1oVVWvXULtWXTfvvYFxkpGBUZNM5rzAHbbTxQhjw5T3TgsL7cbiy
         fRapuyObQ+cKuPM7Nkoe7HFNK6Yr/1evjeeLlGamYnX8CCbJlh5rloQ+n6Tsg76DoO2Z
         clRhA1XhQIkpvg6AKj6oeT5bTyBCY+YK4sVfy6XgDDNU6EjFoT+adyfewMNO3JyhtyGU
         zd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265287; x=1758870087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab3i3SAEiCM3mWXvINF+8OQsYTxxSN3LITXrtSETem4=;
        b=lYJJFEF7DPrK0EOUnkOfd4beLeka1shp2JDoHZbPjbHhC4kq1oAyFG8UC7iM9G/QWg
         3PD2YjCQiS8PYqN+Pxce56T8UjYtaN61QBzQh+5O7cpiC+/Lcp9o8bcAa+j0MYejKyC/
         KXLwj1bEsg4ZqMjE+jU59a8fcdIf/2ZqAs6dq/2AY1GQTzvTjMzT/LuqR6NEjwcOjKQx
         2y2wEhEEzMcuh/hJW+EuzOtNiSbfbHHxYeHdKeRGbkBKEmq+JsenHpRJW10iz3kxfx/P
         ZjvoJVGh5obJFOAVzsqg0jXtqAMgo1PmNskSfeaWVtX8sW1vY9AWBiG5Dy5ZDkyk78pL
         VU2A==
X-Forwarded-Encrypted: i=1; AJvYcCWNGcGq5bGQT15r60weyHVmvKJDswVQAfX865eeMpppukqI+uTSL5Gyhg2rSuEpi9IC30oq71xNQS4Z5Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz550WeKTXIUTBf/XyO0mWMh0aMSShA83TLiJ9aB4qmBq6DEFVI
	IZOZuKZeQFTcpqKQG5ySwucxopiKyQ9gMmca9V6pAqCFgCKsyXvJvIc0JOJTiiGb0Os=
X-Gm-Gg: ASbGncsdDK0Dd2aKDMFzz3SYQeYqrwc88MgUQHuMFhMy3EbzSet2uqMVvTZM0iKz/wA
	OyaTMX34l4fJ2pfF5PmrXmk1g0Fir9ewiVQAzSANE2bh1AsnJNbVLjWnd5kttjBr1vKaGfrwjTd
	iEaYh555r7vuLOyyrAKvbuMzkuvkPtKC9YMe8zcMg0uN2c74ORula4GmLMYSoYJEQpUVBTRXT0g
	mdQy6QbN2CJg3e3o2QTLCfLlRsDW51+l4nb0zuhq0SkUuZpZI6DkKpdw4GCn4P7ij5t4n0RmKAx
	VBRZTm4f3rj45b1YhI02BAOc1af65wR42JdHEwKy5X1Of7ccNQhe4CFzcL1hxsC++/hs/G/DinO
	/RlBlcWk8JPocMpGUWmvTdES/yfgqLqoRrYOvLzMnpqQT56Tj9mUP
X-Google-Smtp-Source: AGHT+IGD8AJEImnKfKuuhZhrYKTm9Rj3WupGLE/Dh4zz0ZaxRpZnsGB2qoYWsNp3E3YyLR4iv/o3eg==
X-Received: by 2002:a05:6a00:3e0a:b0:776:f8f:8ce9 with SMTP id d2e1a72fcca58-77e4ecc343cmr2714103b3a.22.1758265286801;
        Fri, 19 Sep 2025 00:01:26 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dc606e10fsm2938738b3a.65.2025.09.19.00.01.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:01:26 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	cuiyunhui@bytedance.com,
	mchitale@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/1] drivers: firmware: riscv: add unknown NMI support
Date: Fri, 19 Sep 2025 15:00:48 +0800
Message-Id: <20250919070048.94646-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250919070048.94646-1-cuiyunhui@bytedance.com>
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unknown NMI can force the kernel to respond (e.g., panic) when the
system encounters unrecognized critical hardware events, aiding in
troubleshooting system faults. This is implemented via the Supervisor
Software Events (SSE) framework.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/sbi.h     |  1 +
 drivers/firmware/riscv/Kconfig   | 10 +++++
 drivers/firmware/riscv/Makefile  |  1 +
 drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/firmware/riscv/sse_nmi.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 874cc1d7603a5..5801f90a88f62 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
 
 #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS	0x00000000
 #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP		0x00000001
+#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI			0x00000002
 #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS	0x00008000
 #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW	0x00010000
 #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
index ed5b663ac5f91..746bac862ac46 100644
--- a/drivers/firmware/riscv/Kconfig
+++ b/drivers/firmware/riscv/Kconfig
@@ -12,4 +12,14 @@ config RISCV_SBI_SSE
 	  this option provides support to register callbacks on specific SSE
 	  events.
 
+config RISCV_SSE_UNKNOWN_NMI
+	bool "Enable SBI Supervisor Software Events unknown NMI support"
+	depends on RISCV_SBI_SSE
+	default y
+	help
+	  This option enables support for delivering unknown Non-Maskable Interrupt (NMI)
+	  notifications via the Supervisor Software Events (SSE) framework. When enabled,
+	  unknown NMIs can trigger kernel responses (e.g., panic) for unrecognized critical
+	  hardware events, aiding in system fault diagnosis.
+
 endmenu
diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
index c8795d4bbb2ea..9242c6cd5e3e9 100644
--- a/drivers/firmware/riscv/Makefile
+++ b/drivers/firmware/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RISCV_SBI_SSE)		+= riscv_sbi_sse.o
+obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)	+= sse_nmi.o
diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
new file mode 100644
index 0000000000000..43063f42efff0
--- /dev/null
+++ b/drivers/firmware/riscv/sse_nmi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/mm.h>
+#include <linux/nmi.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/sched/debug.h>
+#include <linux/sysctl.h>
+
+#include <asm/irq_regs.h>
+#include <asm/sbi.h>
+
+int panic_on_unknown_nmi = 1;
+struct sse_event *evt;
+static struct ctl_table_header *unknown_nmi_sysctl_header;
+
+const struct ctl_table unknown_nmi_table[] = {
+	{
+		.procname	= "panic_enable",
+		.data		= &panic_on_unknown_nmi,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
+static void nmi_handler(struct pt_regs *regs)
+{
+	pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
+
+	if (panic_on_unknown_nmi)
+		nmi_panic(regs, "NMI: Not continuing");
+
+	pr_emerg("Dazed and confused, but trying to continue\n");
+}
+
+static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	nmi_handler(regs);
+
+	return 0;
+}
+
+static int sse_nmi_init(void)
+{
+	int ret;
+
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
+				 nmi_sse_handler, NULL);
+	if (IS_ERR(evt))
+		return PTR_ERR(evt);
+
+	ret = sse_event_enable(evt);
+	if (ret) {
+		sse_event_unregister(evt);
+		return ret;
+	}
+
+	unknown_nmi_sysctl_header = register_sysctl("kernel", unknown_nmi_table);
+	if (!unknown_nmi_sysctl_header) {
+		sse_event_disable(evt);
+		sse_event_unregister(evt);
+		return -ENOMEM;
+	}
+
+	pr_info("Using SSE for NMI event delivery\n");
+
+	return 0;
+}
+
+static int __init unknow_nmi_init(void)
+{
+	return sse_nmi_init();
+}
+
+late_initcall(unknow_nmi_init);
-- 
2.39.5


