Return-Path: <linux-kernel+bounces-757835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA4B1C73E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F353BE0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105828C03B;
	Wed,  6 Aug 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW8nrRmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2D28C016
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489014; cv=none; b=kJzApLyyqa5Uxb4Az60JLb9ia19+Tb19EGFarThcCe4f6hhuMjVjukHApG8k+z6yWTkGRt7n9dp64G8nSTrEU9YgwBqegqg7gPU1smOtDZXNaPp6ddETcAa0bsm8+/WR+l3TscCXqQwyRpwWTlVsymKc6nhd4QED5MNE23KoP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489014; c=relaxed/simple;
	bh=ICpbu6eWi8YuUN9YDghhH3v6dG09Fo1rrSV+s0Xg7G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V7XKWVV65p6z7xX3ioDKQplZa99sP+5ro47upKgvayJmn1e2edAW9e0hB7Iu++VWpMo5mlPhO5KutsgwGebgiQjUEc7cNQvym+6v6damVPOGxh7+/7l/+AReiw7GZTlcximJA1ctx4aYkp3WxjL9HbT+RlNlf3MlPykUmZ+Pf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW8nrRmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E28C4CEE7;
	Wed,  6 Aug 2025 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754489013;
	bh=ICpbu6eWi8YuUN9YDghhH3v6dG09Fo1rrSV+s0Xg7G4=;
	h=From:Date:Subject:To:Cc:From;
	b=KW8nrRmMyBVddCHFcTFzs3faCvQGoNzoxqpeCdtCgw39xEboiJqEoW8bfcjJe8mA5
	 6ZlctH9KabvRE/RhA2Lt1yXJVI56zBizgGBB9jeukgU7DFQjmJXbCXRm/dLXtQk03Q
	 5fpp8YRZjK01QsNOEkFBqQJpD2mMGhvbiFlkNNtmycuf8ZsME8FlBEjF1oeK3wg2Ba
	 zRxnIDI4ksf6jSfuWSi6Pz9JaWJ82R+8FacFE29rTzCtrDlQWs9l13ZubTaJIl8dF9
	 PZu961i507++0naQYmHvFwrBWVlWY+RMuj+Nu4OIF7HCum5JueIIM1yB6MwqPkcDsE
	 nkdypTZthKBeA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 06 Aug 2025 07:03:28 -0700
Subject: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK9gk2gC/0XMQQ6CMBCF4auQWVvSaVMFV97DGFLoABO1mGklJ
 oS727gxb/Ut3r9BImFKcK42EFo58RILzKGCYfZxIsWhGIw2TjfaKeE0rF1Zyj5TFwq9BGVs73H
 AgP2xgXJ+CY38+YWvt+JRlqfKs5D/507YamtbNDVatK1zCtX4TpkjX+4kkR71IhPs+xd6CeMhp
 gAAAA==
X-Change-ID: 20250805-riscv_v_vstate_discard-23ba1c1d1b68
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Andy Chiu <andybnac@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>, Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7566; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Y7GvDdAyH5eWKWL3Rtfcl6rjEuDiaFbWqc5VZCfPJ4c=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWRMTtiqH/xnza5Hkxk/KHbMt7txXCRcxbbEcUFvW/dmh
 rdKFQ5mHaUsDGIcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJsBkzMjTv+Tzlx+rGs38m
 H9rqp9tfXH/WLvH/ZT3Dmxfv90yZu6aEkWGi0101KfnE3gMpjG2LPGPqltU+5//Z+sPOt0d82tX
 M67wA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

From: Drew Fustini <dfustini@tenstorrent.com>

Clobbering the vector registers can significantly increase system call
latency for some implementations. To mitigate this performance impact, a
sysctl knob is provided that controls whether the vector state is
discarded in the syscall path:

/proc/sys/abi/riscv_v_vstate_discard

Valid values are:

0: Vector state is not always clobbered in all syscalls
1: Mandatory clobbering of vector state in all syscalls

The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.

Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
Changes in v2:
 - Reword the description of the abi.riscv_v_vstate_discard sysctl to
   clarify that option '0' does not preserve the vector state - it just
   means that vector state will not always be clobbered in the syscall
   path.
 - Add clarification suggested by Palmer in v1 to the "Vector Register
   State Across System Calls" documentation section.
 - v1: https://lore.kernel.org/linux-riscv/20250719033912.1313955-1-fustini@kernel.org/

Test results:
-------------
I've tested the impact of riscv_v_vstate_discard() on the SiFive X280
cores [1] in the Tenstorrent Blackhole SoC [2]. The results from the
Blackhole P100 [3] card show that discarding the vector registers
increases null syscall latency by 25%.

The null syscall program [4] executes vsetvli and then calls getppid()
in a loop. The average duration of getppid() is 198 ns when registers
are clobbered in riscv_v_vstate_discard(). The average duration drops
to 149 ns when riscv_v_vstate_discard() skips clobbering the registers
becaise riscv_v_vstate_discard is set to 0.

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

This patch applies clean on its own to riscv/for-next.

[1] https://www.sifive.com/cores/intelligence-x200-series
[2] https://tenstorrent.com/en/hardware/blackhole
[3] https://github.com/tenstorrent/tt-bh-linux
[4] https://gist.github.com/tt-fustini/ab9b217756912ce75522b3cce11d0d58
[5] https://github.com/tenstorrent/linux/tree/tt-blackhole-v6.16-rc1_vstate_discard

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/arch/riscv/vector.rst | 22 ++++++++++++++++++++--
 arch/riscv/Kconfig                  | 10 ++++++++++
 arch/riscv/include/asm/vector.h     |  4 ++++
 arch/riscv/kernel/vector.c          | 16 +++++++++++++++-
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -134,7 +134,25 @@ processes in form of sysctl knob:
 3.  Vector Register State Across System Calls
 ---------------------------------------------
 
-As indicated by version 1.0 of the V extension [1], vector registers are
-clobbered by system calls.
+Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
+where vector registers are clobbered by system calls. Specifically:
+
+    Executing a system call causes all caller-saved vector registers
+    (v0-v31, vl, vtype) and vstart to become unspecied.
+
+However, clobbering the vector registers can significantly increase system call
+latency for some implementations. To mitigate this performance impact, a sysctl
+knob is provided that controls whether vector state is always discarded in the
+syscall path:
+
+* /proc/sys/abi/riscv_v_vstate_discard
+
+    Valid values are:
+
+    * 0: Vector state is not always clobbered in all syscalls
+    * 1: Mandatory clobbering of vector state in all syscalls
+
+    Reading this file returns the current discard behavior. The initial state is
+    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
 
 1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_V_VSTATE_DISCARD
+	bool "Enable Vector state discard by default"
+	depends on RISCV_ISA_V
+	default n
+	help
+	  Say Y here if you want to always discard vector state in syscalls.
+	  Otherwise, userspace has to enable it via the sysctl interface.
+
+	  If you don't know what to do here, say N.
+
 config RISCV_ISA_V_UCOPY_THRESHOLD
 	int "Threshold size for vectorized user copies"
 	depends on RISCV_ISA_V
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 45c9b426fcc52321d55d1a4a42030c3b988e53c0..77991013216b9aea1744540caef38589338717ff 100644
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
index 901e67adf57608385e6815be1518e70216236eda..d81dcc86e794896dd36803d6e7540aad1dc37d79 100644
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
base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
change-id: 20250805-riscv_v_vstate_discard-23ba1c1d1b68

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


