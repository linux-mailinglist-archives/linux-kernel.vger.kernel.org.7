Return-Path: <linux-kernel+bounces-811401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD9B52899
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DED561E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024E258EFF;
	Thu, 11 Sep 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG/fBUtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721E2580CA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571381; cv=none; b=s8KFwHN6f0GeTi4PORMynWgKt6R9XsmG0kbL4ptrTbLJPN8oMTYNRV+gZNpty5CFMXHgkBhkt67XH464o1Chxn03HiJy1p+7kgWrksIKrylYVIQN3PYDLJkoRdG7a7LYlWwDe0ReG8IMmnEUqjoixSY4E8lRZooVblaZhP/xbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571381; c=relaxed/simple;
	bh=DjZFghpksciORuCBXL9QHTMWwRCOpfkdCfMsBDk4Gco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAThaKDkvr1feV9BNqjy645IywiRbCPciFr6xkoZPE2aQ78a8wOsStPSAqkLxxDsPf3i44H7K2oVwVsxrtPo0TelJVdewYUrBtlkXl+EavGgRhmyp88FS/nKpomcbKFNZNpzkNp211X4jBBc/tv+wdbqGNIUX5xREHsVr43XGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG/fBUtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80D8C4CEFB;
	Thu, 11 Sep 2025 06:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757571381;
	bh=DjZFghpksciORuCBXL9QHTMWwRCOpfkdCfMsBDk4Gco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CG/fBUtlwMTX66LfpJ44F0Mfdscvv5wuStqf9gQg2XqoEJMVyMp+GDTHuDnxpW/lN
	 KAMB2X4mptp5ik+yN8g7jiQI/FTn7HUA2hsAaZ11swY+VWeSYTw1I1Lnopq2QdJuuj
	 +ckDi0tf0oQ/rMnUIjdBY+jGy4OOfC1fMiCL6bU8ZTFXVnygfGxDy459j/dErcFdR2
	 MmeKjatDMd2gc4PKuzU3g3hk5PkGXWoB+FGp+0LGtdD8G6D4dWAMHg6dbNQIgaN2E9
	 0FDvvFY7M2ocGzlajP0DWW7Mx81YYs+SxJrItLuLx1KrL4+08r+gObR201fYn+QpMT
	 zePeWtUg/oh/g==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 10 Sep 2025 23:15:30 -0700
Subject: [PATCH 2/2] RISC-V: Add support for srmcfg CSR from Ssqosid ext
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-ssqosid-v6-17-rc5-v1-2-72cb8f144615@kernel.org>
References: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
In-Reply-To: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6981; i=fustini@kernel.org;
 h=from:subject:message-id; bh=DjZFghpksciORuCBXL9QHTMWwRCOpfkdCfMsBDk4Gco=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQcyjR+sMD9r3uqt71DcMPH1QvDr9obnT/LFSkcz160L
 aHIzq+uo5SFQYyDQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjCRe1qMDCeVbsga6k18sCPQ
 aDPnhqYJU79ZSE3pks8tW6l/M/bajUiG/+Wqs5ab+bGrfqkQq/n8o4Et5iXvZe7sug2PaxtzmmT
 mcwAA
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
 MAINTAINERS                        |  6 ++++++
 arch/riscv/Kconfig                 | 17 ++++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 6 files changed, 78 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..02a71e4b4a8f045be03f9c77a5d2314ee61d29f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21729,6 +21729,12 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V QOS RESCTRL SUPPORT
+M:	Drew Fustini <fustini@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	arch/riscv/include/asm/qos.h
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
index 0000000000000000000000000000000000000000..418ac8383fb7808c6e3f421a8d4e9389b702a264
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
+static DEFINE_PER_CPU(u32, cpu_srmcfg);
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
+	return riscv_has_extension_likely(RISCV_ISA_EXT_SSQOSID);
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

-- 
2.34.1


