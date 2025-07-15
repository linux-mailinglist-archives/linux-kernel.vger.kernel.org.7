Return-Path: <linux-kernel+bounces-732235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21308B063DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1400581280
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C8257452;
	Tue, 15 Jul 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sYcmM2V3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C611247298
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595426; cv=none; b=SrKe5EoaCC+cLHQPk3wmqaOjW1qaar9kkS8zwOBc4VVviG689zy6tABgWuGbVGyWrmqKeC3kcZbNgDh66skJbLtGD8IFLaXW8sCvQhqh8gC518z+gRmBt9HDa+k+ZetPpuKWm3jncsgrigUyKAHYU9YqvMIZbJBT0rInq0t8okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595426; c=relaxed/simple;
	bh=z1VMtrMkQhrwjS9d23Ae99O3j5UUI1IJevnip0Li2hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvjL4WInDiaGA+3E5TGC8MvqCCKlIK9nAaiaGsqBZiaGtF8pI20dNTZTHHMJvs5sDKwwxxbdHSxh9WA/12f6RvVe9rZrbr8BcdZoLyvCmlKw6tLVXp4c/nerJ3GTNXYiR++myfN15DfsJ3R8I5rA+SM3TQaMFcBWPzpTkY8wzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sYcmM2V3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73972a54919so5149557b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752595424; x=1753200224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqOfxrmuP7GYj+ITGwkimiGPyMW49733tVgJyRtzAo8=;
        b=sYcmM2V3+y0Y4QMrFK1IyLEfTnAc6hTN7TXKVP8bfdYcp8JGpKPKa2dOwQRgeE/nRm
         wR9A6txOWC+M2wdQzS97UWGZtE7AJmuV2nWio9jkKMg36EgaYtTdS2vWuOr1VTc6eUlQ
         kijSe3gyX4cxN2HNzn4MERUT5E5z0QxfXb4VzelSOvAtdR8y15ICHPZI29AWawfIE3iB
         bvyMjGWZ0LiflX70Fe+llyQz+loGRgcaTed7IqrUYSsmJ30NknATVtL9MHx5b8p+E1km
         pCMxyLeJABrth5slUUqRksGmSCZBG3xcGXcCnKfZWvzs9yklbZjhlK0gVmt4GHPZxCq2
         BiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595424; x=1753200224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqOfxrmuP7GYj+ITGwkimiGPyMW49733tVgJyRtzAo8=;
        b=XFxAc/BSy3zUqkUJE98hOHvCVVUTfSVKZBO4FMU06dhRFtL4FeTNRTiimgGCIq7YWw
         b3AcrFRA0YEVQygAqkCGlyYO273DYFoo1kmTqltElNySkFRjtYqYxQisxX4CSIVLbfvk
         iR9WQoxmDCa4xzVDA9Fw3z8pqDQOiaPcVNZqEgEErB0pmyB+qI285rW3yeUkdOCSuuvP
         MaL6d3fELeCrBGX01ZjaYtE8wlqd5P8cyaU68TAq1iaNPJ6LBkDHo0uKglyxJZ1iRvV7
         lHgctR7WAHHKlSy8tK6ejZ9JdIdEMttv2kZ6ecvCEyYedbwfhngK6+CuPv8imbAmoTg7
         fRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJSQMm1g1gS2GCEBjb95QUAL3BD9qoyPRSUhhY3iSoVW0pCd152qptYBawoCNP5hzAnnRSCzOVnBVQYLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFj+iUnl2zuXom/4vtRAtuETtG7iOyDAqI+pWRCUFEMwcX+hG
	xk/NU9/+wuIsZrCEH3mcblolyI/LatUeJuivr3d49ipM+z2uiS7rZOA63wDZgwr5duc=
X-Gm-Gg: ASbGnct6+qzEBckIBjs20jhlqtEV55Dn5FrCNyv7SM1epazO+ZLuAHwWJwpA3/FVyho
	i8J9FDa7LYhkuDvDRRVM3rep7c5FGpjRFWbgaQa3lY0z9CKgWiuxM4psrtxuipvP4PXbVnvcFrC
	jeVMsoEYaQCT0thDm0SYrup0WYdAN68sMLj6nth1+0AlZt9Cn8YUEW0ri/gmsq/LCFFkOZdfPM4
	g/FwCNSuLkZ0ODPs25iNdDOD8LyQvvsbRdMcq4g4LrkwXi+lsN0OCsPdTQUZt0H7oVrK/NAa68j
	mmr4kg981sSxmTtTE53873zCHw1rgqfYLJsjHp7JdA/PWxzHxUTc8at8UiYM4sLed9Ws2wPJpqE
	l+To=
X-Google-Smtp-Source: AGHT+IHDVMlZLgmYUoZyYp4THO/CfTh98DfuE74EXplt94mzpfi21MjcE4zZib331IU+ay+/EwkXlg==
X-Received: by 2002:a05:6a00:c94:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-74ee2557a2bmr24319785b3a.15.1752595423619;
        Tue, 15 Jul 2025 09:03:43 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f856fdsm12546532b3a.144.2025.07.15.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:03:43 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v5 4/5] perf: RISC-V: add support for SSE event
Date: Tue, 15 Jul 2025 16:02:32 +0000
Message-ID: <20250715160234.454848-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715160234.454848-1-cleger@rivosinc.com>
References: <20250715160234.454848-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to use SSE within PMU drivers, register a SSE handler for the
local PMU event. Reuse the existing overflow IRQ handler and pass
appropriate pt_regs. Add a config option RISCV_PMU_SSE to select event
delivery via SSE events.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 drivers/perf/Kconfig           | 10 +++++
 drivers/perf/riscv_pmu.c       | 19 +++++++++
 drivers/perf/riscv_pmu_sbi.c   | 71 +++++++++++++++++++++++++++++-----
 include/linux/perf/riscv_pmu.h |  3 ++
 4 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 278c929dc87a..3310076ca7b0 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -105,6 +105,16 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config RISCV_PMU_SSE
+	depends on RISCV_PMU && RISCV_SSE
+	bool "RISC-V PMU SSE events"
+	default n
+	help
+	  Say y if you want to use SSE events to deliver PMU interrupts. This
+	  provides a way to profile the kernel at any level by using NMI-like
+	  SSE events. SSE events being really intrusive, this option allows
+	  to select it only if needed.
+
 config STARFIVE_STARLINK_PMU
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	depends on 64BIT
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 7644147d50b4..1eb28381b80f 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -13,6 +13,7 @@
 #include <linux/irqdesc.h>
 #include <linux/perf/riscv_pmu.h>
 #include <linux/printk.h>
+#include <linux/riscv_sse.h>
 #include <linux/smp.h>
 #include <linux/sched_clock.h>
 
@@ -254,6 +255,22 @@ void riscv_pmu_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
+static void riscv_pmu_disable(struct pmu *pmu)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(pmu);
+
+	if (rvpmu->sse_evt)
+		sse_event_disable_local(rvpmu->sse_evt);
+}
+
+static void riscv_pmu_enable(struct pmu *pmu)
+{
+	struct riscv_pmu *rvpmu = to_riscv_pmu(pmu);
+
+	if (rvpmu->sse_evt)
+		sse_event_enable_local(rvpmu->sse_evt);
+}
+
 static int riscv_pmu_add(struct perf_event *event, int flags)
 {
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
@@ -411,6 +428,8 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 		.event_mapped	= riscv_pmu_event_mapped,
 		.event_unmapped	= riscv_pmu_event_unmapped,
 		.event_idx	= riscv_pmu_event_idx,
+		.pmu_enable	= riscv_pmu_enable,
+		.pmu_disable	= riscv_pmu_disable,
 		.add		= riscv_pmu_add,
 		.del		= riscv_pmu_del,
 		.start		= riscv_pmu_start,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895..8c1ac7985df6 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
+#include <linux/riscv_sse.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
@@ -948,10 +949,10 @@ static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
 }
 
-static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
+				       struct pt_regs *regs, bool from_sse)
 {
 	struct perf_sample_data data;
-	struct pt_regs *regs;
 	struct hw_perf_event *hw_evt;
 	union sbi_pmu_ctr_info *info;
 	int lidx, hidx, fidx;
@@ -959,7 +960,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct perf_event *event;
 	u64 overflow;
 	u64 overflowed_ctrs = 0;
-	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
@@ -969,13 +969,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	/* Firmware counter don't support overflow yet */
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	if (fidx == RISCV_MAX_COUNTERS) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		if (!from_sse)
+			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
+		if (!from_sse)
+			ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}
 
@@ -990,16 +992,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
-	 * all the counters to avoid any race condition.
+	 * all the counters to avoid any race condition. When using SSE,
+	 * interrupt is cleared when stopping counters.
 	 */
-	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
+	if (!from_sse)
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 
 	/* No overflow bit is set */
 	if (!overflow)
 		return IRQ_NONE;
 
-	regs = get_irq_regs();
-
 	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
 		struct perf_event *event = cpu_hw_evt->events[lidx];
 
@@ -1055,6 +1057,51 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
+{
+	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
+}
+
+#ifdef CONFIG_RISCV_PMU_SSE
+static int pmu_sbi_ovf_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	struct cpu_hw_events __percpu *hw_events = arg;
+	struct cpu_hw_events *hw_event = raw_cpu_ptr(hw_events);
+
+	pmu_sbi_ovf_handler(hw_event, regs, true);
+
+	return 0;
+}
+
+static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
+{
+	int ret;
+	struct sse_event *evt;
+	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
+
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, 0,
+				 pmu_sbi_ovf_sse_handler, hw_events);
+	if (IS_ERR(evt))
+		return PTR_ERR(evt);
+
+	ret = sse_event_enable(evt);
+	if (ret) {
+		sse_event_unregister(evt);
+		return ret;
+	}
+
+	pr_info("using SSE for PMU event delivery\n");
+	pmu->sse_evt = evt;
+
+	return ret;
+}
+#else
+static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1105,6 +1152,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 	struct irq_domain *domain = NULL;
 
+	ret = pmu_sbi_setup_sse(pmu);
+	if (!ret)
+		return 0;
+
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
@@ -1139,7 +1190,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
-	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
 		return ret;
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 701974639ff2..d4a5c55fe077 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -28,6 +28,8 @@
 
 #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
 
+struct sse_event;
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
@@ -54,6 +56,7 @@ struct riscv_pmu {
 	char		*name;
 
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
+	struct sse_event *sse_evt;
 
 	unsigned long	cmask;
 	u64		(*ctr_read)(struct perf_event *event);
-- 
2.43.0


