Return-Path: <linux-kernel+bounces-775308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B79B2BDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A437BD669
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC931984B;
	Tue, 19 Aug 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/k5vAiV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D8D2FF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596503; cv=none; b=H0mwXEB44JbnBigeR2gIrsbOChoTZFnyPwt/yB4sEN0cvY60B2aA4cOv9Qv5rxi00ZhOnMwspHLq+4+l6+R3cU7SlwJJ9/hZ+aKv7Ciu4Ip1qxiEC4/BR45KO+87hVJNG+PxRZp5uffivAOAJdCa3ZOdpVOaBBc1syYCuRqQZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596503; c=relaxed/simple;
	bh=xOarV5e+3YNSU48lNwlUN9/9XMp5L43lGU/6eiA9mO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YuL1KoRv5wddJChQsXQYbvXQVOngVeEguKStuUHkWSbLez3Pi9WAuTeYlY091hFihKT2AgdYdkWKN57xV39mOLF7ayGKsSWwNMf1JlOx2N8ZmBys63oZWOS6LzoVgvC4MhtOFgL1exP2DhRyKYthW1de3Y3hv/Aj3FKUaoaJrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/k5vAiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1592DC4CEF1;
	Tue, 19 Aug 2025 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755596502;
	bh=xOarV5e+3YNSU48lNwlUN9/9XMp5L43lGU/6eiA9mO4=;
	h=From:Date:Subject:To:Cc:From;
	b=u/k5vAiVhcTK6Nc0HJ/U14E/6dB8RcvKcbYnlpLW6I0rtpY1zbFPAv7HC6OXRmgTX
	 vrhHIrh6hqkduMYHjvTfymbaOj4COxFhY8zffLqBdCj5Hm2tDQz5cNGdgM0zDCVshY
	 iGtk+cjSc3PnCQLLDFuVMTKH1jsLZhkJ7zLzUUAEIMof9LmqeBY0zbgdCv7+sTZ6w9
	 Pi2WaB8Upu35lr986v+HPfdTkmHgj9jux3CsrTMMJkRp9v3CCqn9ahVK0EcPj5FTs2
	 c1GdYxZ5Ru2ghR+jAc5XjOhEDwxScZk7gEjuM9Jp53adZ4FuSOC3q7Y1Kb63qJ2715
	 jnjI0Xx2pT8UA==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 19 Aug 2025 02:40:21 -0700
Subject: [PATCH v3] riscv: Add sysctl to control discard of vstate on
 syscall entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-riscv_v_vstate_discard-v3-1-0af577dafdc2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIRGpGgC/3XMSwrCMBSF4a2UOzaSB4boyH2IlDxu2qAm5aYEo
 XTvBkdO5Iy+wfk3qEgJK1yGDQhbqqnkDnUYwM82T8hS6AbJ5YkbYRil6tvYV1e74hg6LQWG5uy
 UMAK59dDPC2FM72/4du+OVF5snQntT47rf7kmmWDaxaCFk14qd30gZXweC02w7x/2Ta7QtwAAA
 A==
X-Change-ID: 20250818-riscv_v_vstate_discard-e89b3181e0ac
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Samuel Holland <samuel.holland@sifive.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Andy Chiu <andybnac@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Darius Rad <darius@bluespec.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Florian Weimer <fweimer@redhat.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8992; i=fustini@kernel.org;
 h=from:subject:message-id; bh=uba8VRyKfqdIPV5Y4bvgoG08DFOgpwXKqRKfx3Q+Rm8=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQscbu6ZNP3OSUuSquWTLFL7D0cr82YxWI6vyn20PR0s
 Wkmj68FdpSyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmsjiHkaHtYYjA6dj0S67J
 yjcu6zZf5+U9sPx1rq9fldeaCV+/TLBnZLh3sPa6dUeNk+lzs+3nRLjrRWMXcMcEvlbq4C6TdDv
 wmwcA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

From: Drew Fustini <dfustini@tenstorrent.com>

Vector registers are always clobbered in the syscall entry path to
enforce the documented ABI that vector state is not preserved across
syscalls. However, this operation can be slow on some RISC-V cores.
To mitigate this performance impact, add a sysctl knob to control
whether vector state is discarded in the syscall entry path:

/proc/sys/abi/riscv_v_vstate_discard

Valid values are:

0: Vector state is not intentionally clobbered when entering a syscall
1: Vector state is always clobbered when entering a syscall

The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.

Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Changes in v3:
 - Reword the Kconfig description to clarify that the sysctl can still
   be changed during runtime regardless of the initial value chosen
 - Improve the description of vstate clobbering and the sysctl in
   section 3 of vector.rst
 - v2: https://lore.kernel.org/linux-riscv/20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org/

Changes in v2:
 - Reword the description of the abi.riscv_v_vstate_discard sysctl to
   clarify that option '0' does not preserve the vector state - it just
   means that vector state will not always be clobbered in the syscall
   path.
 - Add clarification suggested by Palmer in v1 to the "Vector Register
   State Across System Calls" documentation section.
 - v1: https://lore.kernel.org/linux-riscv/20250719033912.1313955-1-fustini@kernel.org/

Test results:
I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
Blackhole P100 [3] card show that discarding the vector registers
increases null syscall latency by 25%.

The null syscall program [4] executes vsetvli and then calls getppid()
in a loop. The average duration of getppid() is 198 ns when registers
are clobbered in riscv_v_vstate_discard(). The average duration drops
to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
because riscv_v_vstate_discard is set to 0.

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

This patch applies clean on its own mainline and riscv/for-next.

[1] https://www.sifive.com/cores/intelligence-x200-series
[2] https://tenstorrent.com/en/hardware/blackhole
[3] https://github.com/tenstorrent/tt-bh-linux
[4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
[5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/arch/riscv/vector.rst | 27 +++++++++++++++++++++++++--
 arch/riscv/Kconfig                  | 20 ++++++++++++++++++++
 arch/riscv/include/asm/vector.h     |  4 ++++
 arch/riscv/kernel/vector.c          | 16 +++++++++++++++-
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..2a6b52990ee75a60d8ebd1b4b1292838358bc9f2 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -134,7 +134,30 @@ processes in form of sysctl knob:
 3.  Vector Register State Across System Calls
 ---------------------------------------------
 
-As indicated by version 1.0 of the V extension [1], vector registers are
-clobbered by system calls.
+Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
+where vector registers are clobbered by system calls. Specifically:
+
+    Executing a system call causes all caller-saved vector registers
+    (v0-v31, vl, vtype) and vstart to become unspecified.
+
+Linux clobbers the vector registers (e.g. discards vector state) on the syscall
+entry path. This is done to identify userspace programs that mistakenly expect
+vector registers to be preserved across syscalls. This can be helpful for
+debugging and testing. However, clobbering vector state can negatively impact
+performance on some RISC-V implementations, and is not strictly necessary.
+
+To mitigate this performance impact, a sysctl knob is provided that controls
+whether vector state is always clobbered on syscall entry:
+
+* /proc/sys/abi/riscv_v_vstate_discard
+
+    Valid values are:
+
+    * 0: Vector state is not always clobbered in all syscalls
+    * 1: Mandatory clobbering of vector state in all syscalls
+
+    Reading this file returns the current discard behavior. Write to '0' or '1'
+    to file to change the current behavior. The initial state is controlled by
+    CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
 
 1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 451eb23d86c96307422d95e233e35b97569e9816..c0c64d1a4dfe2b0058e3265082b6e3c5207755c7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -654,6 +654,26 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_V_VSTATE_DISCARD
+	bool "Enable Vector state discard by default"
+	depends on RISCV_ISA_V
+	default n
+	help
+	  Discarding vector state (also known as clobbering) on syscall entry
+	  can help identify userspace programs that are mistakenly relying on
+	  vector registers being preserved across syscalls. This can be useful
+	  for debugging and testing. However, this behavior can negatively
+	  impact performance on some RISC-V implementations and is not strictly
+	  necessary.
+
+	  Select Y here if you want mandatory clobbering of vector state even
+	  though it can increase the duration of syscalls on some RISC-V cores.
+	  If you don't know what to do, then select N.
+
+	  This choice sets the initial value of the abi.riscv_v_vstate_discard
+	  sysctl. Regardless of whether you choose Y or N, the sysctl can still
+	  be changed by the user while the system is running.
+
 config RISCV_ISA_V_UCOPY_THRESHOLD
 	int "Threshold size for vectorized user copies"
 	depends on RISCV_ISA_V
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index b61786d43c2054f71727356fa9718b91ec97a38b..9d236e456d608fe363cd566a526e07fea970818e 100644
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
index 184f780c932d443d81eecac7a6fb8070ee7a5824..7a4c209ad337efd7a3995cfc7cf1700c03e55b40 100644
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
 

---
base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
change-id: 20250818-riscv_v_vstate_discard-e89b3181e0ac

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


