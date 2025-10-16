Return-Path: <linux-kernel+bounces-855403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81200BE11C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AEF1884A94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389282E413;
	Thu, 16 Oct 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EDcEwO6v"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A393D81
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574768; cv=none; b=koIyljzygq7ECJm9Y12ih/m2ZhOp6av+RTT/6StMGOmIPuw2AcDp0tg1IqWZe5j04tczkiCfQxCNatjTffGdkjUuuKRGTZlcKaI6TpBkdV+t0UlQ7Ds60Aaf6figLglUPBS6wuiEC+gNKyrZGP5KsrGFaI0hESFLFQ4UkbWuZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574768; c=relaxed/simple;
	bh=8P8NkKCLs3qEUE3ZpJyZIYywS2j6MMoa05Ix0fhl73E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naYTlkbBorpuqv8NCPyWgzAdniKLCf+BpvZG+QwZa3kUT3C/foM2eKUt+C0gc3aZFQGx81C7rx7rYebh91uoLLqtU/oCOxGdhNeqmQwzEtxb9H3R34dxP64+12+WrlaIZQB4f2upuGGsEpdMP5rm9K3mf/IJUoO8b/jsc4VWB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EDcEwO6v; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781010ff051so147849b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760574766; x=1761179566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl/lY8JAaE7A8957nqq7PMXYFhem+rXkxRLcRBl4qnU=;
        b=EDcEwO6vTbwn6PRGCAZC/iZHDh2yKldUqYbpSQfR8rtJJvZ/fp/atqbmA1kNy9eeH2
         1U2zlvRBdDIOxHHWQ4R9hJT3bozQiBW8CPXQC7U+gXyHbp7D7qyfvjTB/PFldN7PJTHv
         h43oDggWPAU66HFTI0ikKxezE5RxC2k6SqtCzDrKwApd0yLXDcLNZywUak4a1wW7IW/9
         6SLH9MfV5LrNOP46hjmMEJGp9vSIwJerI/LbSliR3R6X33x55NANfUfO1R6vvvyBYcjx
         jA+PqMpbR0n4j9HwxOSBIyNlVJ6UCVhZK5tt77HFjX9Nc0JFbkDe4f4YgDi+1FGyyEN1
         lAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760574766; x=1761179566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl/lY8JAaE7A8957nqq7PMXYFhem+rXkxRLcRBl4qnU=;
        b=fYe7TQu20Aer7tke4EZ6nj0/x2eYjvtuHLpoG3hQCUjMDc7nYnJtJxPyRBOqQlZRpz
         wtuOOqRtxgbUu4rzgbOVVcI9mz5z4UUkDYSqW62s0grDM73qXVd8mejxof8bSg0W3PaI
         z8Lu8x6P4glpATbg8ybSFpvUdcsr+6ZGs524GxUciJJwN5MGo9G0HpDrxBrFBzP4beDL
         KsO0kzKwZL4+UGehCH0PTOYvd/XX6RuN9cjIT3RisvyQmzBVouh6Yfcc2ibNU35O96nB
         3ZA85nuw8Feo+CXQEnwcoNBQRf+tUdu1pDxxuAJmlcEYfFnD2RqS754b8cUq08+RjfJK
         3n8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU95mhVb+XDO09AO2VJ+Rl9cGt4ltIxpZgR+sstFox5rVcn9k0L+CFn0NEeztcKmYm9+5xFYJl1JE10M0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXqpSH/LX7ULTOToig//AUTsI+ERAlmhPuEhH8ECq7D3xFRTd
	dV0JiqnVrKRDuCmtxe/3tsVGq/QPnINvX3VVODsX4agoZXokXlSS626MQH15RFY6DiU=
X-Gm-Gg: ASbGncu8FwjbDuyk8tIe+DwpaxIPCJEB8Jfe7IcSqHhnkB3FH+DqtscPR/70GnJ8fgw
	8SToVzIyXJ+IGPnjvyOW0+lNmvzw52d/XwembIcYf7BbX3tLHQtjQ5azHCwyNBUHDJa27vhwrtw
	k7+xEzYRcawWH3v0zi50YmYVO6Y8dpeIbiQiSA25XImwEkqpu0WQxJTPFGk9ai31msCuyGNuEYA
	V0xJnmsQa2idFJrJw361yCKLRg89G1E4PJXj5yrCW1PZq4+FRCV3qhYFJerPd9jYcq0ddMYW1yy
	9Jzue0iaxxIDe/sSLIkjqQNJ1bksY0M5LtY2MuMlg4qlqUT8Zgr+SJVOyedG7+6LTQjnjpFbgRE
	a90+tB6Q40h6Ow5Qv6cuBJdFI+2kLoPSQQApuOt4dJbG9rW/P5Y0jkBZi9Hd/B2R38tBGkax70R
	pqZDQ13oRD7hCMhnPkphfBxkOOVmnPqbQA
X-Google-Smtp-Source: AGHT+IHLzh9TmRMIItVhwqjxb8DLVTBAx6eIunXzY4s4RJzGl3w59VWm5xr1ObSp2GfFAAyuDlXIcQ==
X-Received: by 2002:a05:6a20:12cd:b0:2f8:4558:ad9e with SMTP id adf61e73a8af0-32da839ee26mr41282091637.33.1760574766115;
        Wed, 15 Oct 2025 17:32:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b59sm20620987b3a.2.2025.10.15.17.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:32:45 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Register IPI IRQs with unique names
Date: Wed, 15 Oct 2025 17:32:05 -0700
Message-ID: <20251016003244.3910332-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows different IPIs to be distinguished in tracing output.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/smp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index e650dec44817..5ed5095320e6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -40,6 +40,17 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+static const char * const ipi_names[] = {
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+	[IPI_TIMER]		= "Timer broadcast interrupts",
+	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
+	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
+};
+
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -199,7 +210,7 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
 		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 "IPI", &ipi_dummy_dev);
+					 ipi_names[i], &ipi_dummy_dev);
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
@@ -210,17 +221,6 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 	riscv_ipi_enable();
 }
 
-static const char * const ipi_names[] = {
-	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
-	[IPI_CALL_FUNC]		= "Function call interrupts",
-	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
-	[IPI_IRQ_WORK]		= "IRQ work interrupts",
-	[IPI_TIMER]		= "Timer broadcast interrupts",
-	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
-	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
-};
-
 void show_ipi_stats(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/ipi-names

