Return-Path: <linux-kernel+bounces-871694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C18C0E197
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D493E4F627E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9362777FC;
	Mon, 27 Oct 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FVFl+0uB"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA3272E5A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572094; cv=none; b=Hwgg5XAxxhn2/sRQ2GIi8ehab+aC6Bt/twopUChlWW2cuLk2pqQZgYWkAa691fp4enucX24mjDLts1lffLqFmI/Uix3E2B5SNovzJLBAJ3SL88Wy49tbeX9PdMLk14r6xmrxs4ATmwMqKsl8NeIgk1cBud6P+VcMfVsv/6BsKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572094; c=relaxed/simple;
	bh=GxF3YAiTKcr3zOtrpjpMwEjUoA1FC/+7YAOEj26MqrQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOeaMMrB2uPejLbG0lwADPfC4AESeOR4EE7e0swPe6E3AQPtfYLxCnGFttpIOJ4YnvGrZv9FOcLJ+j3bUiE4FTVQBGRhU3UYsMfxEA16Dnz0aWL+I8wqaNn1+msyFVncHAmeABYW6/klmmpt6hfmZ7kcFHJlHCtg/gxdZY/pRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FVFl+0uB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so3356697a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761572092; x=1762176892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Odjt5uwfHY3ZdJdP98Hf6WpyJ1jiYTTMXBvSsOEEh3w=;
        b=FVFl+0uBeKqlMWT8TrTPYj7ovjv6VJQ9iA5mCnaPeLZUbTDdthATjaimeFBhBnzxQ4
         8WINS73vhDWG1me9sqf194xs2ddYzRmxsbwgKT6PSdXsOZCao17zQG2IRnp/girhoL3f
         EfFY8EulZyEj3m+/wrrPu/B68DlsM0BF0dtlUiV9DrZYTGP+ELRz+Za+zOLvBZK8eM+p
         mlXzKDIg1hTu9rYs77l74CrMa3ISDErZeGiClochiwM2VcU5QpJfSPcqKy5aEjfwtfz6
         WDUC5Iaz5o51IbA/80OVxDkD2YDFwG7gGddkQvN7aBrECNlu5hwoCHO/yeAHeiFxD+uY
         rwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572092; x=1762176892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odjt5uwfHY3ZdJdP98Hf6WpyJ1jiYTTMXBvSsOEEh3w=;
        b=A4u7gqCGq7fP6VXD/DlTmS0jKT4oRnbC5LFnZgL+xTFiJNq5S9/H+O74Q5C1fv+pde
         COn0rjy2pt+oCqM8MegXTtbZNrNVaB50pnstztvS5Q2JlYUz6AGZ7Cg2HUKLouc80SZI
         SEDhhol/1p9b5U7UzbuyPPU5xThyAi0HcvbpOEeZ4bG/Wo+ERQ75q+RlH2mSQiuRxU1m
         KI6+3Ff7Uoscm6SQSfP22/b8WHrzbAwIlDewQPNwxRjXLz/YYIxi08XSH8qyLXNb1G4D
         dIakAK8fIR6bMD7kJoOWmWHb7cqmdrae8ROMLu3qIw2VJRB//RFaZrO3prwGwK8qYBAI
         RhAw==
X-Forwarded-Encrypted: i=1; AJvYcCWhH4P03kk4whMN2AzGUsNhjqjZ1ydJdQ42F591i9bQ17R1I7lPIv6Ork530b7wY1jOw0dpbpgTQYRDHO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOBkUqsBFQk6iaw8c1unKKFqaFBOFyFW1r5QLX/gDheugPvAb
	TBmnT1WJVfQ8NhCJ+NItW9Rh7VoXf3ZYMkKRgZlJYSunLrFIBgvUJH2hwZEqZig1JyI=
X-Gm-Gg: ASbGncu0KdsA+Mc/5V7pmbxMHDy7/FLxDWmH1zgk25VB+BxsifVIDv/NRbwnMzLhzPs
	zfjb+kGQ5nmqP4g+e9rneBGMktuiT+OIl7bG9f50wqnwZRVXEjqU5ZNZRNUFs/pM27Vx1X+V8Hq
	hYrGgT/45mW7BI4l3k151QVsyfhmn5J4/XOBBPId8vVVSzBh9J54VcPUYJw2LI9Vam7gW6XfLOC
	fKL/vniek621n3Y9f8rBARp/WEkJ721nDgB61Dr2GIx+IjBkBaKt8KDTVwbzO7p+ZHgtzWiYO5W
	J8cRB9YXvx22m2lrE3Zi2gJyKdKICTReXCbyfGH/XCOMucFlliWdtK43Yn9/iKEAkN/dXhXKXpv
	ZzkneaNoy7zPZyKh8ERbkiBlWXk2mVN+5RKC4PhxJDR8q99syP42CIJFJLd6DxpKqusBiSZwLA+
	MSk2WBi23Ed74YLJ+15wcTNsSRV6PMtk8nwtxIk5WbwNs/
X-Google-Smtp-Source: AGHT+IFne5ygW7GikNTE03OCk2Tf1awZTN7o9D47u9Fff1p6EABVNldt8hq5taNPKjC6COMH28Qghw==
X-Received: by 2002:a17:903:22d1:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2948b957623mr161838015ad.6.1761572091789;
        Mon, 27 Oct 2025 06:34:51 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm82144935ad.69.2025.10.27.06.34.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 06:34:51 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	cuiyunhui@bytedance.com,
	luxu.kernel@bytedance.com,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	songshuaishuai@tinylab.org,
	bjorn@rivosinc.com,
	charlie@rivosinc.com,
	masahiroy@kernel.org,
	valentina.fernandezalanis@microchip.com,
	jassisinghbrar@gmail.com,
	conor.dooley@microchip.com
Subject: [PATCH 1/3] drivers: firmware: riscv: add SSE NMI support
Date: Mon, 27 Oct 2025 21:34:29 +0800
Message-Id: <20251027133431.15321-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251027133431.15321-1-cuiyunhui@bytedance.com>
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for handling Non-Maskable Interrupts (NMIs) through the
RISC-V Supervisor Software Events (SSE) framework. Since each NMI
type(e.g., unknown NMI, etc.) requires a distinct SSE event, a newfile
sse_nmi.c is introduced to manage their registration and enabling.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 MAINTAINERS                      |  7 +++
 arch/riscv/include/asm/sbi.h     |  1 +
 drivers/firmware/riscv/Kconfig   | 10 ++++
 drivers/firmware/riscv/Makefile  |  1 +
 drivers/firmware/riscv/sse_nmi.c | 81 ++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+)
 create mode 100644 drivers/firmware/riscv/sse_nmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bf5416953f45..6df6cbec4d85d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22057,6 +22057,13 @@ S:	Maintained
 F:	drivers/firmware/riscv/riscv_sse.c
 F:	include/linux/riscv_sse.h
 
+RISC-V SSE NMI SUPPORT
+M:	Yunhui Cui <cuiyunhui@bytedance.com>
+R:	Xu Lu <luxu.kernel@bytedance.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/riscv/sse_nmi.c
+
 RISC-V THEAD SoC SUPPORT
 M:	Drew Fustini <fustini@kernel.org>
 M:	Guo Ren <guoren@kernel.org>
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 874cc1d7603a5..52d3fdf2d4cc1 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -486,6 +486,7 @@ enum sbi_sse_attr_id {
 #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
 #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
 #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
+#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI		0xffff0001
 #define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000
 
 #define SBI_SSE_EVENT_PLATFORM		BIT(14)
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
index ed5b663ac5f91..fd16b4c43cf01 100644
--- a/drivers/firmware/riscv/Kconfig
+++ b/drivers/firmware/riscv/Kconfig
@@ -12,4 +12,14 @@ config RISCV_SBI_SSE
 	  this option provides support to register callbacks on specific SSE
 	  events.
 
+config RISCV_SSE_NMI
+	bool "Enable SBI Supervisor Software Events NMI support"
+	depends on RISCV_SBI_SSE
+	default y
+	help
+	  This option enables support for delivering Non-Maskable Interrupt
+	  (NMI) notifications through the Supervisor Software Events (SSE)
+	  framework. When enabled, the system supports some common NMI features
+	  such as unknown NMI handling.
+
 endmenu
diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
index c8795d4bbb2ea..ecf2b31935d9c 100644
--- a/drivers/firmware/riscv/Makefile
+++ b/drivers/firmware/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_RISCV_SBI_SSE)		+= riscv_sbi_sse.o
+obj-$(CONFIG_RISCV_SSE_NMI)		+= sse_nmi.o
diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
new file mode 100644
index 0000000000000..2c1eaea2bbabc
--- /dev/null
+++ b/drivers/firmware/riscv/sse_nmi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "SSE NMI: " fmt
+
+#include <linux/nmi.h>
+#include <linux/riscv_sbi_sse.h>
+#include <linux/sysctl.h>
+
+#include <asm/irq_regs.h>
+#include <asm/sbi.h>
+
+int unknown_nmi_panic;
+static struct sse_event *unknown_nmi_evt;
+static struct ctl_table_header *unknown_nmi_sysctl_header;
+
+static int __init setup_unknown_nmi_panic(char *str)
+{
+	unknown_nmi_panic = 1;
+	return 1;
+}
+__setup("unknown_nmi_panic", setup_unknown_nmi_panic);
+
+const struct ctl_table unknown_nmi_table[] = {
+	{
+		.procname	= "unknown_nmi_panic",
+		.data		= &unknown_nmi_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
+static int unknown_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
+
+	if (unknown_nmi_panic)
+		nmi_panic(regs, "NMI: Not continuing");
+
+	pr_emerg("Dazed and confused, but trying to continue\n");
+
+	return 0;
+}
+
+static int unknown_nmi_init(void)
+{
+	int ret;
+
+	unknown_nmi_evt = sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
+					     unknown_nmi_handler, NULL);
+	if (IS_ERR(unknown_nmi_evt))
+		return PTR_ERR(unknown_nmi_evt);
+
+	ret = sse_event_enable(unknown_nmi_evt);
+	if (ret)
+		goto err_unregister;
+
+	unknown_nmi_sysctl_header = register_sysctl("kernel", unknown_nmi_table);
+	if (!unknown_nmi_sysctl_header) {
+		ret = -ENOMEM;
+		goto err_disable;
+	}
+
+	pr_info("Using SSE for unknown NMI event delivery\n");
+	return 0;
+
+err_disable:
+	sse_event_disable(unknown_nmi_evt);
+err_unregister:
+	sse_event_unregister(unknown_nmi_evt);
+	return ret;
+}
+
+static int __init sse_nmi_init(void)
+{
+	return unknown_nmi_init();
+}
+
+late_initcall(sse_nmi_init);
-- 
2.39.5


