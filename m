Return-Path: <linux-kernel+bounces-818165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D704BB58DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A401BC2BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0C281341;
	Tue, 16 Sep 2025 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KikIV8Ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2378277C94;
	Tue, 16 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999788; cv=none; b=sN4AldCwzefXJL9zV+NDxTz4R/6FE3XIA3o2bAh1o3sS3jjiw/Pa0YEFB/3gmEgysGuob9V4IlmZ2EkVw16aTPaurfyR8vHbnc4EkynmVkGjph4PYLlAgY8O0wKWI3gcqXKNuA8jD5EI1aoqI4xVYQRof9Iq5s5ApvDxaNLXpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999788; c=relaxed/simple;
	bh=sBJWGmKek5xFcrcIe6fkt1J6I70Cz5FeuPn45dYrq6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnyLZNFkrLefEWMocOXzrhEgdAWe29omO8vWtcnbE+/onCs/Z8CuwQmhH3S6UrO86KEpVfnEl5xx6XVsGb6twP6muVxRvGBix9F0pevrEzTH6J1YeSkQWDDpvZWHUMB7FOgeliEM0Qhw+WVmaYVjQz71HY9yiI2Qj389dUQlJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KikIV8Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8BC4CEFC;
	Tue, 16 Sep 2025 05:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757999787;
	bh=sBJWGmKek5xFcrcIe6fkt1J6I70Cz5FeuPn45dYrq6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KikIV8AeyX+lsf0zYNoIgzPJpVqWx3go4UmE0NsnVOVkfH5rAHcExFMKgyp8J+1+6
	 VvUKft/5QNaLsq8BseUOewqG31oPgyPJeYuYS3dsylcE2k97vNuBSSSlts0rnRSQnq
	 pSIM1vTOjF3XS6RSbMz7vAw7xiF4w6ffn1b5cQGGS2RRXsu7GmF8j1lhzx2O2MQBSD
	 1PW6lwubfog/Lz+jR1+ySjf91W7FRn/Hu93R52E/wFTvv3GsAhsfk8wPEeuTyByAos
	 G9njQa2dSHnXYX4QU77WfciTGX/0hm+rHF46Xvw6qqLy7HlRSU1zYt4yXsQz5Ridy6
	 VpqliY3AlcLhg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 15 Sep 2025 22:13:43 -0700
Subject: [PATCH v2 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid ext
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250915-ssqosid-v6-17-rc5-v2-3-2d4b0254dfd6@kernel.org>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
In-Reply-To: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8317; i=fustini@kernel.org;
 h=from:subject:message-id; bh=sBJWGmKek5xFcrcIe6fkt1J6I70Cz5FeuPn45dYrq6o=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWSc+LQyY8mphmy3n8s5HJWSXbucRIptLWxD/1ySsOT/O
 9dn1oLAjlIWBjEOBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBEnu5kZDhYu2+h64qVhS2b
 lqs9LDPX9Lmvabe1MCY5L1zgQ1kHgy7D/7qe7TtPH9/37AlD87WNIZXbPuozJuee3sxYvCth4gG
 zyzwA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the srmcfg CSR defined in the Ssqosid ISA extension
(Supervisor-mode Quality of Service ID). The CSR contains two fields:

  - Resource Control ID (RCID) used determine resource allocation
  - Monitoring Counter ID (MCID) used to track resource usage

Requests from a hart to shared resources like cache will be tagged with
these IDs. This allows the usage of shared resources to be associated
with the task currently running on the hart.

A srmcfg field is added to thread_struct and has the same format as the
srmcfg CSR. This allows the scheduler to set the hart's srmcfg CSR to
contain the RCID and MCID for the task that is being scheduled in. The
srmcfg CSR is only written to if the thread_struct.srmcfg is different
than the current value of the CSR.

A per-cpu variable cpu_srmcfg is used to mirror that state of the CSR.
This is because access to L1D hot memory should be several times faster
than a CSR read. Also, in the case of virtualization, accesses to this
CSR are trapped in the hypervisor.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rename csr to srmcfg, refactor switch_to, rebase on v6.17-rc5]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                        |  7 +++++++
 arch/riscv/Kconfig                 | 17 ++++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 arch/riscv/kernel/Makefile         |  2 ++
 arch/riscv/kernel/qos/Makefile     |  2 ++
 arch/riscv/kernel/qos/qos.c        |  5 +++++
 9 files changed, 88 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..93da9339d2fd6f5a6aed6041dab2282b27d86162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21729,6 +21729,13 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V QOS RESCTRL SUPPORT
+M:	Drew Fustini <fustini@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/kernel/qos/
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@gentoo.org>
 L:	linux-riscv@lists.infradead.org
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 51dcd8eaa24356d947ebe0f1c4a701a3cfc6b757..9b09a7aad29621d99f14d414751e67a43cbdad3a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -605,6 +605,23 @@ config RISCV_ISA_SVNAPOT
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
+	default y
+	help
+	  Adds support for the Ssqosid ISA extension (Supervisor-mode
+	  Quality of Service ID).
+
+	  Ssqosid defines the srmcfg CSR which allows the system to tag the
+	  running process with an RCID (Resource Control ID) and MCID
+	  (Monitoring Counter ID). The RCID is used to determine resource
+	  allocation. The MCID is used to track resource usage in event
+	  counters.
+
+	  For example, a cache controller may use the RCID to apply a
+	  cache partitioning scheme and use the MCID to track how much
+	  cache a process, or a group of processes, is using.
+
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e377059c7004ecd3c29eb36d5c0e36a656..ecc57492264c2a2616e1e147796157512da70e87 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -75,6 +75,13 @@
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
+/* SRMCFG fields */
+#define SRMCFG_RCID_MASK	_AC(0x00000FFF, UL)
+#define SRMCFG_MCID_MASK	SRMCFG_RCID_MASK
+#define SRMCFG_MCID_SHIFT	16
+#define SRMCFG_MASK		((SRMCFG_MCID_MASK << SRMCFG_MCID_SHIFT) | \
+				  SRMCFG_RCID_MASK)
+
 /* Exception cause high bit - is an interrupt if set */
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
 
@@ -317,6 +324,7 @@
 #define CSR_STVAL		0x143
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
+#define CSR_SRMCFG		0x181
 
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 24d3af4d3807e37396744ef26533ac4661abcb4f..cc9548b85d363ecbc3c416e52906107a73e6053d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -122,6 +122,9 @@ struct thread_struct {
 	/* A forced icache flush is not needed if migrating to the previous cpu. */
 	unsigned int prev_cpu;
 #endif
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+	u32 srmcfg;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
new file mode 100644
index 0000000000000000000000000000000000000000..7371e53e9e919b24f17c623ee72a0cbf62eadb2f
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_QOS_H
+#define _ASM_RISCV_QOS_H
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
+#include <linux/sched.h>
+#include <linux/jump_label.h>
+
+#include <asm/barrier.h>
+#include <asm/csr.h>
+#include <asm/hwcap.h>
+
+/* cached value of srmcfg csr for each cpu */
+DECLARE_PER_CPU(u32, cpu_srmcfg);
+
+static inline void __switch_to_srmcfg(struct task_struct *next)
+{
+	u32 *cpu_srmcfg_ptr = this_cpu_ptr(&cpu_srmcfg);
+	u32 thread_srmcfg;
+
+	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
+
+	if (thread_srmcfg != *cpu_srmcfg_ptr) {
+		*cpu_srmcfg_ptr = thread_srmcfg;
+		csr_write(CSR_SRMCFG, thread_srmcfg);
+	}
+}
+
+static __always_inline bool has_srmcfg(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
+
+static __always_inline bool has_srmcfg(void) { return false; }
+#define __switch_to_srmcfg() do { } while (0)
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+#endif /* _ASM_RISCV_QOS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920cac2f14bb626879bb219a2f247cc..a684a3795d3d7f5e027ec0a83c30afd1a18d7228 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/qos.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -119,6 +120,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector() || has_xtheadvector())		\
 		__switch_to_vector(__prev, __next);	\
+	if (has_srmcfg())				\
+		__switch_to_srmcfg(__next);	\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c7b542573407c813a4a45fe9bf78a676599c0503..0108a4e6338a7972b6805ef14048d4e5e8833d82 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -125,3 +125,5 @@ obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
+
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos/
diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..9f996263a86d7e2e410890d2425e74b2277a57ad
--- /dev/null
+++ b/arch/riscv/kernel/qos/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
new file mode 100644
index 0000000000000000000000000000000000000000..7b06f7ae9056b8f2eb53a0eecf5a6512edc29fbe
--- /dev/null
+++ b/arch/riscv/kernel/qos/qos.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/qos.h>
+
+/* cached value of sqoscfg csr for each cpu */
+DEFINE_PER_CPU(u32, cpu_srmcfg);

-- 
2.34.1


