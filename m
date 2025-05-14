Return-Path: <linux-kernel+bounces-647286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220BBAB667F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C341B6352F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3B2222B6;
	Wed, 14 May 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1mgVPui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDF203706;
	Wed, 14 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212744; cv=none; b=N+S7nBj3nZcMGDeeJMuWK7T8Oxtm3r0QfQgFf+Xpg1DMERw3dyLBkQtfgoQ3cZnSVGmiqwze2n8YflEJugX8a31/hH6Yxi49PPM62Zag5q46G/uq0x4hLRx9Ovt5KvTsCOARVeXJvOavAMTazVSBNL+fZ2lnXiP/UQjkxbjIl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212744; c=relaxed/simple;
	bh=9yB4OvyC9KasBkPJiUrHXzNl1JQn8V2XAQTZqrBzgpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gk3t52Vj56dm0HgyK7gEAvjImMRQNQrDc5eG2soBe6rf/t+ylyYXRIhEsGRQ/a6SGDtA4NSFfX5vJPp+ezLivenHby03UpDOZtl/pRSu77/KWCWd2ZmW1kQtZ5adnEqYkbrXtxCv0y5gf8/qR+seUTW4gmupDV5h2n9RscBV0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1mgVPui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67907C4CEEB;
	Wed, 14 May 2025 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212743;
	bh=9yB4OvyC9KasBkPJiUrHXzNl1JQn8V2XAQTZqrBzgpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E1mgVPuiJ1EpMvG3MAkTSOIuR33wREQosHm77PY3VYTkViUHsXnEBE5Eb4VK/P+p2
	 4NSjRZJSoFPvSXN4e09Pu9dR6vsC4nLwZgZGHZM6y616Jt/M1e3PuVQmcQA1XBQrpu
	 zArjpC7MsbgPNNP63lV3Fhg+tTFxXRoFLpbl0fXqOOLabOPbAvalaUfqq9HSu8kmEQ
	 6BnHbjZP/RoPAwyFXRcUfXEI5T82yOdT9w4jwMsPhrYHFpIglquSurwi5vUjMg2GPC
	 O/VUqqicvRgobqhJKxVAQiXPaqG9S9BAn/OciZ3O/5VABADoV/fpdSc5Qry1Sd4vQM
	 93Z5qyRyE+J1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5722DC3ABDE;
	Wed, 14 May 2025 08:52:23 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Wed, 14 May 2025 10:51:51 +0200
Subject: [PATCH v4 2/2] Allow for riscv-clock to pick up mmio address.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-riscv-time-mmio-v4-2-cb0cf2922d66@htecgroup.com>
References: <20250514-riscv-time-mmio-v4-0-cb0cf2922d66@htecgroup.com>
In-Reply-To: <20250514-riscv-time-mmio-v4-0-cb0cf2922d66@htecgroup.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747212741; l=6255;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=EawChFO5r7TY/3C2xSsJ0RVQsku7ZmMDDOElYfUSB3g=;
 b=q5UH5u4knfsYRuGxgnBE7P34wWO4ppjvrkYrN0sBI6X0CgAmUOp54pB9qBMbOxhSJbTErsUlJ
 5bml6qmvX4bAostjIRvE2Hnw9NUXM3JS4nUstQpsZXio10Cjupx4z3G
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Allow faster rdtime access via GCR.U mtime shadow register on RISC-V
devices. This feature can be enabled by setting GCRU_TIME_MMIO during configuration.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
 arch/riscv/include/asm/timex.h    | 48 ++++++++++--------------------
 drivers/clocksource/Kconfig       | 12 ++++++++
 drivers/clocksource/timer-riscv.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69521caceac2ae4d4e040d227d2ae7..2dea35fe32c0b080ff27587088bbbe01fad22ce6 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -7,31 +7,25 @@
 #define _ASM_RISCV_TIMEX_H
 
 #include <asm/csr.h>
+#include <asm/mmio.h>
+
+#include <linux/jump_label.h>
 
 typedef unsigned long cycles_t;
 
+extern u64 __iomem *riscv_time_val;
+extern cycles_t (*get_cycles_ptr)(void);
+extern u32 (*get_cycles_hi_ptr)(void);
+
+#define riscv_time_val riscv_time_val
+
 #ifdef CONFIG_RISCV_M_MODE
 
 #include <asm/clint.h>
 
-#ifdef CONFIG_64BIT
-static inline cycles_t get_cycles(void)
-{
-	return readq_relaxed(clint_time_val);
-}
-#else /* !CONFIG_64BIT */
-static inline u32 get_cycles(void)
-{
-	return readl_relaxed(((u32 *)clint_time_val));
-}
-#define get_cycles get_cycles
+#undef riscv_time_val
 
-static inline u32 get_cycles_hi(void)
-{
-	return readl_relaxed(((u32 *)clint_time_val) + 1);
-}
-#define get_cycles_hi get_cycles_hi
-#endif /* CONFIG_64BIT */
+#define riscv_time_val clint_time_val
 
 /*
  * Much like MIPS, we may not have a viable counter to use at an early point
@@ -45,29 +39,17 @@ static inline unsigned long random_get_entropy(void)
 	return get_cycles();
 }
 #define random_get_entropy()	random_get_entropy()
+#endif
 
-#else /* CONFIG_RISCV_M_MODE */
-
-static inline cycles_t get_cycles(void)
-{
-	return csr_read(CSR_TIME);
-}
-#define get_cycles get_cycles
-
-static inline u32 get_cycles_hi(void)
-{
-	return csr_read(CSR_TIMEH);
-}
-#define get_cycles_hi get_cycles_hi
-
-#endif /* !CONFIG_RISCV_M_MODE */
+#define get_cycles get_cycles_ptr
+#define get_cycles_hi get_cycles_ptr_hi
 
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
 {
 	return get_cycles();
 }
-#else /* CONFIG_64BIT */
+#else /* !CONFIG_64BIT */
 static inline u64 get_cycles64(void)
 {
 	u32 hi, lo;
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 487c8525996724fbf9c6e9726dabb478d86513b9..0f2bb75564c7d2bc9c450a7fb0eef353e5d27e69 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -661,6 +661,18 @@ config CLINT_TIMER
 	  This option enables the CLINT timer for RISC-V systems.  The CLINT
 	  driver is usually used for NoMMU RISC-V systems.
 
+config GCRU_TIME_MMIO
+	bool "GCR.U timer support for RISC-V platforms"
+	depends on !RISCV_M_MODE && RISCV
+	default n
+	help
+        Access GCR.U shadow copy of the RISC-V mtime register
+        on platforms that provide a compatible device, instead of
+        reading the time CSR. Since reading the time CSR
+        traps to M mode on certain platforms, this may be more efficient.
+
+        If you don't know what to do here, say n.
+
 config CSKY_MP_TIMER
 	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
 	depends on CSKY
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 4d7cf338824a3b21461c2756a002236dedc48f5f..1ccf2a95f5bcb28946dcee435f5bbea222c6fac3 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -22,6 +22,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/limits.h>
 #include <clocksource/timer-riscv.h>
 #include <asm/smp.h>
@@ -32,6 +33,42 @@
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
 static bool riscv_timer_cannot_wake_cpu;
 
+u64 __iomem *riscv_time_val __ro_after_init;
+EXPORT_SYMBOL(riscv_time_val);
+
+#ifdef CONFIG_64BIT
+static cycles_t __maybe_unused mmio_get_cycles(void)
+{
+	return readq_relaxed(riscv_time_val);
+}
+#else /* !CONFIG_64BIT */
+static cycles_t __maybe_unused mmio_get_cycles(void)
+{
+	return readl_relaxed(((u32 *)riscv_time_val));
+}
+#endif /* CONFIG_64BIT */
+
+static cycles_t __maybe_unused get_cycles_csr(void)
+{
+	return csr_read(CSR_TIME);
+}
+
+static u32 __maybe_unused mmio_get_cycles_hi(void)
+{
+	return readl_relaxed(((u32 *)riscv_time_val) + 1);
+}
+
+static u32 __maybe_unused get_cycles_hi_csr(void)
+{
+	return csr_read(CSR_TIMEH);
+}
+
+cycles_t (*get_cycles_ptr)(void) = get_cycles_csr;
+EXPORT_SYMBOL(get_cycles_ptr);
+
+u32 (*get_cycles_hi_ptr)(void) = get_cycles_hi_csr;
+EXPORT_SYMBOL(get_cycles_hi_ptr);
+
 static void riscv_clock_event_stop(void)
 {
 	if (static_branch_likely(&riscv_sstc_available)) {
@@ -209,6 +246,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	int cpuid, error;
 	unsigned long hartid;
 	struct device_node *child;
+#if defined(CONFIG_GCRU_TIME_MMIO)
+	u64 mmio_addr;
+	u64 mmio_size;
+	struct device_node *gcru;
+#endif
 
 	error = riscv_of_processor_hartid(n, &hartid);
 	if (error < 0) {
@@ -226,6 +268,25 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+#if defined(CONFIG_GCRU_TIME_MMIO)
+	gcru = of_find_compatible_node(NULL, NULL, "mti,gcru");
+	if (gcru) {
+		if (!of_property_read_reg(gcru, 0, &mmio_addr, &mmio_size)) {
+			riscv_time_val = ioremap((long)mmio_addr, mmio_size);
+			if (riscv_time_val) {
+				pr_info("Using mmio time register at 0x%llx\n",
+					mmio_addr);
+				get_cycles_ptr = &mmio_get_cycles;
+				get_cycles_hi_ptr = &mmio_get_cycles_hi;
+			} else {
+				pr_warn("Unable to use mmio time at 0x%llx\n",
+					mmio_addr);
+			}
+			of_node_put(gcru);
+		}
+	}
+#endif
+
 	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
 	if (child) {
 		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,

-- 
2.34.1



