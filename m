Return-Path: <linux-kernel+bounces-737543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB4B0ADBC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1451C23C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB01F4E57;
	Sat, 19 Jul 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICxRnPSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D542E36ED
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896471; cv=none; b=sF0CHfA9DQn+JCavlD0lA4EFaTnrXLSAZaGYXrR4NsFvD34U9Evqrb7mzlO3K3B+rmI7wnrvEMdJsgSL5F5efq/SaZBDirLQbFbxKe6R9Kduot16vwsOnWbo1Tsogg8y+viOXjuKlnG4qmuOyk34LyT6FykLgeq0M93XLb65LKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896471; c=relaxed/simple;
	bh=vNKzp08fR6rGe3dowzaw73p6nSns3OGxHIzWfBKeCoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8ZEl8uDdJKpKApKB2ifHs2r4NhA0mLmU9YfE/Ik0Xk305hJwYvCHrw/skOeinS2SjXIrKb/DLsGQbNc8Zu6ZwqrFl06D2bIZXRqAVIBl61KFFZL+2qVAwrwiFgzplbZWe7cyLRXJXDwZWW13fvqA3wBhMjl7etjZnRx2LGvJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICxRnPSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68234C4CEE3;
	Sat, 19 Jul 2025 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752896470;
	bh=vNKzp08fR6rGe3dowzaw73p6nSns3OGxHIzWfBKeCoc=;
	h=From:To:Cc:Subject:Date:From;
	b=ICxRnPSScuwdp+SZOPuNnTuroZxiNahWtbCQm7rdVOpcYHcYGPDTbISINBzBw7WYp
	 Htwfy3yVBSSDXPYhv+SuiGJXRquuMAH8407oTxNCnNlN3ONhFLj7HrVOFT2dCAHgGk
	 WDEdjp5zG5hbJVXVcuVnRBVN36fyo242jaUShPKyBSObrjD/i6EOnlegzlYiL0VOna
	 KTqtwC/9c+IHx6fuhLhpTzMDyPmHgI1AY8BfbYNgx4bNJVgtRY2TcGFibEuiluYQhK
	 Z9MXY+APLPoTPvAkNqAoIvLaAD5NBE1IA4Gjj4VVpjAomrdB9mkjftB4FB7r2bqJLZ
	 gycCfC/rVZghQ==
From: Drew Fustini <fustini@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Drew Fustini <fustini@kernel.org>
Subject: [PATCH] riscv: Add sysctl to control discard of vstate during syscall
Date: Fri, 18 Jul 2025 20:39:13 -0700
Message-Id: <20250719033912.1313955-1-fustini@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@tenstorrent.com>

Clobbering the vector registers can significantly increase system call
latency for some implementations. To mitigate this performance impact, a
policy mechanism is provided to administrators, distro maintainers, and
developers to control vector state discard in the form of a sysctl knob:

/proc/sys/abi/riscv_v_vstate_discard

Valid values are:

0: Do not discard vector state during syscall
1: Discard vector state during syscall

The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.

Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 Documentation/arch/riscv/vector.rst | 15 +++++++++++++++
 arch/riscv/Kconfig                  | 10 ++++++++++
 arch/riscv/include/asm/vector.h     |  4 ++++
 arch/riscv/kernel/vector.c          | 16 +++++++++++++++-
 4 files changed, 44 insertions(+), 1 deletion(-)

I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
Blackhole P100 [3] card show that discarding the vector registers
increases null syscall latency by 25%.

The null syscall program [4] executes vsetvli and then calls getppid()
in a loop. The average duration of getppid() is 198 ns when registers
are clobbered in riscv_v_vstate_discard(). The average duration drops
to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
as result of riscv_v_vstate_discard being set to 0.

$ sudo sysctl abi.riscv_v_vstate_discard=1
abi.riscv_v_vstate_discard = 1

$ ./null_syscall --vsetvli
vsetvli complete
 iterations: 1000000000
   duration: 198 seconds
avg latency: 198.73 ns

$ sudo sysctl abi.riscv_v_vstate_discard=0
abi.riscv_v_vstate_discard = 0

$ ./null_syscall --vsetvli
vsetvli complete
 iterations: 1000000000
   duration: 149 seconds
avg latency: 149.89 ns

I'm testing on the tt-blackhole-v6.16-rc1_vstate_discard [5] branch that
has 13 patches, including this one, on top of v6.16-rc1. Most are simple
yaml patches for dt bindings along with dts files and a bespoke network
driver. I don't think the other patches are relevant to this discussion.

This patch applies clean on its own to riscv/for-next and next-20250718.

[1] https://www.sifive.com/cores/intelligence-x200-series
[2] https://tenstorrent.com/en/hardware/blackhole
[3] https://github.com/tenstorrent/tt-bh-linux
[4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
[5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard

diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 3987f5f76a9d..1edbce436015 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -137,4 +137,19 @@ processes in form of sysctl knob:
 As indicated by version 1.0 of the V extension [1], vector registers are
 clobbered by system calls.
 
+Clobbering the vector registers can significantly increase system call latency
+for some implementations. To mitigate the performance impact, a policy mechanism
+is provided to the administrators, distro maintainers, and developers to control
+the vstate discard in the form of a sysctl knob:
+
+* /proc/sys/abi/riscv_v_vstate_discard
+
+    Valid values are:
+
+    * 0: Do not discard vector state during syscall
+    * 1: Discard vector state during syscall
+
+    Reading this file returns the current discard behavior. The initial state is
+    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
+
 1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0aeee50da016..c0039f21d1f0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -655,6 +655,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_V_VSTATE_DISCARD
+	bool "Enable Vector state discard by default"
+	depends on RISCV_ISA_V
+	default n
+	help
+	  Say Y here if you want to enable Vector state discard on syscall.
+	  Otherwise, userspace has to enable it via the sysctl interface.
+
+	  If you don't know what to do here, say N.
+
 config RISCV_ISA_V_UCOPY_THRESHOLD
 	int "Threshold size for vectorized user copies"
 	depends on RISCV_ISA_V
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 45c9b426fcc5..77991013216b 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -40,6 +40,7 @@
 	_res;								\
 })
 
+extern bool riscv_v_vstate_discard_ctl;
 extern unsigned long riscv_v_vsize;
 int riscv_v_setup_vsize(void);
 bool insn_is_vector(u32 insn_buf);
@@ -270,6 +271,9 @@ static inline void __riscv_v_vstate_discard(void)
 {
 	unsigned long vl, vtype_inval = 1UL << (BITS_PER_LONG - 1);
 
+	if (READ_ONCE(riscv_v_vstate_discard_ctl) == 0)
+		return;
+
 	riscv_v_enable();
 	if (has_xtheadvector())
 		asm volatile (THEAD_VSETVLI_T4X0E8M8D1 : : : "t4");
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 184f780c932d..7a4c209ad337 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -26,6 +26,7 @@ static struct kmem_cache *riscv_v_user_cachep;
 static struct kmem_cache *riscv_v_kernel_cachep;
 #endif
 
+bool riscv_v_vstate_discard_ctl = IS_ENABLED(CONFIG_RISCV_ISA_V_VSTATE_DISCARD);
 unsigned long riscv_v_vsize __read_mostly;
 EXPORT_SYMBOL_GPL(riscv_v_vsize);
 
@@ -307,11 +308,24 @@ static const struct ctl_table riscv_v_default_vstate_table[] = {
 	},
 };
 
+static const struct ctl_table riscv_v_vstate_discard_table[] = {
+	{
+		.procname       = "riscv_v_vstate_discard",
+		.data           = &riscv_v_vstate_discard_ctl,
+		.maxlen         = sizeof(riscv_v_vstate_discard_ctl),
+		.mode           = 0644,
+		.proc_handler   = proc_dobool,
+	},
+};
+
 static int __init riscv_v_sysctl_init(void)
 {
-	if (has_vector() || has_xtheadvector())
+	if (has_vector() || has_xtheadvector()) {
 		if (!register_sysctl("abi", riscv_v_default_vstate_table))
 			return -EINVAL;
+		if (!register_sysctl("abi", riscv_v_vstate_discard_table))
+			return -EINVAL;
+	}
 	return 0;
 }
 
-- 
2.34.1


