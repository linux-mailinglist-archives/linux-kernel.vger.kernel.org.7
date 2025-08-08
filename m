Return-Path: <linux-kernel+bounces-760511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B347B1EC43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153423B9E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70554284B51;
	Fri,  8 Aug 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DAUEtjHL"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E833284B39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667594; cv=none; b=Ja8fe9IpAjtGNFAnhDuZ+vCYEbX0q0do07tMv9BXxxzv2CR2gGlXZPjHhCsp6NUql0iWfz7OkMxX2SuKF37e0wxm9tGyyJgH3C4iCd9Hsp+SbdGdtTjRu1tAbcjx3Jy4nEx1rWy00gME/lvHvRfTtmkqKZS76X0MHCjffZKILtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667594; c=relaxed/simple;
	bh=HoRNw8NeBBoFMFiimyPe6hSzQx6L18MHLb6O6z3DLVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae28pidDmnuRjRIz7Xb/gcaMP0QCduiUlekwL4mTYbd7Wwu4GOk3IN85MlTXjFPo31zwb1QbHsYdR52WIiGIPsa+osuMIheu/b/P03k5SVMtXZdBnAuEw3r5XZylTnW/qT8qBf54+8rO/hq+ww74rBVj/O8NDVRoFGD9V05dmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DAUEtjHL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1709408a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754667591; x=1755272391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvmMQppGzlyK1V459PeF8q1FGyH1g7f7ZgjlVByhCvs=;
        b=DAUEtjHL9+YYfIiHWmAFtG+nv4N+QCCGqnSazmI2ts9hRv8U0whrdj/27Ug8sXNew9
         O41A6M3IYekazFnsRUL1YbViYLHWlZfvQ6KFy5Onx51gRbMuuF5lROxOvJVY37JZchBZ
         AWNjyOISzF0kN3YavhBZMWKeytD2xO9vGIlZcoY+v0/MibMsR37mUkVAB2XNUEtKF7tI
         D33F6FLhttSjZZg++P5mkLv16dhHyVdQj4LSM3+2XKIfj3Bwtr3aU9haTH3uAsJSdpwt
         +NLsqL1lHIC8z1kXQ/1/wOr0AhdbAVTzgZ9GonvZ14A2ZfQgl7zefTi++zzSY9jo8K32
         q9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667591; x=1755272391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvmMQppGzlyK1V459PeF8q1FGyH1g7f7ZgjlVByhCvs=;
        b=Ybxw3cKw1jPXVy7IiumqF0e2FqPfPhB7Qr7PXS0wS8t3vXorY/vW3LqCtcxjeDcD6n
         EQUBVtkpjldxHxxtEMp3aRJ0yZNnEIkCPUkw/Jp6Dx4pPK7APtkd5DlO9W+4JWnMcyjQ
         8PwZVaZzK7wrBlPaO+mstxsRs+9J33LJusEspH83WJ5nmLy+WZbI7yo7w8FQQZauM74C
         vRCwj/O5k4LXiWdrkkaJ3Yyw4LtJwuJyy3+2Tg9MssH4UyYCQx4H9senj0MSW0/bujIp
         BhcYkYYAY5y1U7IAVFWvA+ZYOYkILFgfTaC9bqCTXWKABUbHEjWKWn7T/orXLqRyz0t1
         yOtg==
X-Forwarded-Encrypted: i=1; AJvYcCWUlYA+XCJ7FfL69LN6r0k7QOftlQMB8v9E5uhGm24iJR8gqxOjwGx8MiSEHvhdjjAsCuQLrDxGhEqBxJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JHGqp1Mkg8euYZFFM5uVaqtIsOSg0cuu8nt5tUQ7/JuOuh52
	tdPY6jsHF2Je91bkxJ9bgbadhr96nW0msB1Vpg+jkXd7ceC1Bg5IbWhCQOCCUAlVJog=
X-Gm-Gg: ASbGnct49UCtn8JOQIpKBk5DXetZ6w1BJUgvHyQRpby78BVLjx1gnl199HKtJqY6KxG
	G83gFKtlVfg3VSC318/Fr+CR/8G4e/Kw0HHggAF5saLe4bgwI9Jsi3xtm7dr591Yg4eRD/oMPwl
	YflvRJsse/UwzWxrncRvnlDmaRAwkfCbpKQ68DwUGjI5hY3Onj4VxtuEn0H4jPYOwtmsSHZuj79
	SLIWrucKwzxW9r8il7hMegehVMAEOS2NsGmqcSjeeRdUxSi0MpoSH4kSN5NMz379tTvp8zkaG5g
	4JSL4EQ3I3fHhs7scu0PvvoSWTssvR/ROT+gopATvm72KiP1+FyvN+dmLNJNpCeyz2KhDqOPTWn
	SPtw=
X-Google-Smtp-Source: AGHT+IGGV7QKPYmSz7Mf7+cp35kxVzbsnvhdLApwmQzEaWp5jQeO3Ij9R7B98ce2bxwO0Y+lnCT38g==
X-Received: by 2002:a17:902:d592:b0:235:779:ede5 with SMTP id d9443c01a7336-242c2250093mr48550665ad.40.1754667591429;
        Fri, 08 Aug 2025 08:39:51 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3218c3c2d58sm1135971a91.16.2025.08.08.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:39:50 -0700 (PDT)
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
Subject: [PATCH v6 4/5] perf: RISC-V: add support for SSE event
Date: Fri,  8 Aug 2025 15:38:55 +0000
Message-ID: <20250808153901.2477005-5-cleger@rivosinc.com>
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
index a9188dec36fe..8cf0befaf2c0 100644
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


