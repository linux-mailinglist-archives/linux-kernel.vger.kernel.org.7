Return-Path: <linux-kernel+bounces-777524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC5B2DA80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467DA72739F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65572E337A;
	Wed, 20 Aug 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="R9BK4qiR"
Received: from 11.mo534.mail-out.ovh.net (11.mo534.mail-out.ovh.net [46.105.33.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE82E1C61
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.33.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687900; cv=none; b=s1atNq5T9IsRiRACyPvZh7cbvQjwKrllMbA2nZESzLtgdvMfPAeu42ygifkpE9Pry2CGNLzmtFOAjQCoOl0N4m9a/iNxhPdS2t5zLd7kDQBp81NOf+e72LClj3V4mkQArtOYNIWK8HxIXOfC1Jk3bMRbiKjn98nLV1P/bdDZGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687900; c=relaxed/simple;
	bh=R63ct+bA5ilQOtHmxLr8yi6FWr6QLYf0GYVKw/4NnoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzyqv07JCtHGlwfsol5FIvU2Dc/92U0efrsNURYdqKv/q6uTlgxZWCIFsDZD7CI9+BfkN3z8XS7pmIb/xS/ROpYfIZaIE/uouFgWFYmNOHBTYLVOmE0ndiohF14fwmI7edyhqZ21sEYir7g5lYFghowOeBNuCKY9pd5mQXmIQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=R9BK4qiR; arc=none smtp.client-ip=46.105.33.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Nrk5T2Qz6Fx7;
	Wed, 20 Aug 2025 11:04:54 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 11:04:54 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.249.47])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Nrk41d0z1xpD;
	Wed, 20 Aug 2025 11:04:54 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.7])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id F0665B832C3;
	Wed, 20 Aug 2025 11:04:52 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-103G0054b37c7ea-705c-45f7-9aa5-f05d190495c8,
                    616188B862BD6F9D24C783D7A018D61FF224AB69) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:147.156.42.5
From: Marcos Del Sol Vives <marcos@orca.pet>
To: linux-kernel@vger.kernel.org
Cc: marcos@orca.pet,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: [PATCH v2] x86: add hintable NOPs emulation
Date: Wed, 20 Aug 2025 13:04:35 +0200
Message-Id: <20250820110437.560107-1-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12382084229308372660
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepuefgheehhffgleeuvddufeffudeuudefjedufeevlefhudejhfffkeduieetkedvnecuffhomhgrihhnpeguvggsihgrnhdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
 epuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrtghoshesohhrtggrrdhpvghtpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
DKIM-Signature: a=rsa-sha256; bh=x+EFp2j9Izu5YN/IrY97Y+OpAvYO4kxK63uYmJvI9PA=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755687895;
 v=1;
 b=R9BK4qiRZWgyGNPaQRDLY0L7S2K4sM0LZ/2CmhEJjn/ZGQZIIA+aNFlWB2jvloxBmYBhNaIc
 eUNVJaRPfDtbpqjUwi8XZgUpi6hKovP5na3X0wnNtXSSOa/+9RO7rbBS+QM2cIvag/khpZQ7U8i
 M6RXvBG+uA+oWYPD6+SZjrp6rXeKXTxwdJlJZeWXlotKo8lQJV8aGuwvsbjxUeRiq6mJ4ad4wjM
 oVP6jYkyoSJxP7ScK22m62XwID1oWFJTKCoYyQ9dIcS0xczfbXNFjUx7VcPtZaE4c+lcDegkSbW
 RfySsaoP+f0RuPdasSwHHB6UhuPIxY62DJfwPkExmwVLw==

Hintable NOPs are a series of instructions introduced by Intel with the
Pentium Pro (i686), and described in US patent US5701442A.

These instructions were reserved to allow backwards-compatible changes
in the instruction set possible, by having old processors treat them as
variable-length NOPs, while having other semantics in modern processors.

Some modern uses are:
 - Multi-byte/long NOPs
 - Indirect Branch Tracking (ENDBR32)
 - Shadow Stack (part of CET)

Some processors advertising i686 compatibility lack full support for
them, which may cause #UD to be incorrectly triggered, crashing software
that uses then with an unexpected SIGILL.

One such software is sudo in Debian bookworm, which is compiled with
GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].

This patch is a much simplified version of my previous patch for x86
instruction emulation [2], that only emulates hintable NOPs.

When #UD is raised, it checks if the opcode corresponds to a hintable NOP
in user space. If true, it warns the user via the dmesg and advances the
instruction pointer, thus emulating its expected NOP behaviour.

[1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
[2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
---
 arch/x86/Kconfig        | 29 +++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..a6daebdc2573 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1286,6 +1286,35 @@ config X86_IOPL_IOPERM
 	  ability to disable interrupts from user space which would be
 	  granted if the hardware IOPL mechanism would be used.
 
+config X86_HNOP_EMU
+	bool "Hintable NOPs emulation"
+	depends on X86_32
+	default y
+	help
+	  Hintable NOPs are a series of instructions introduced by Intel with
+	  the Pentium Pro (i686), and described in US patent US5701442A.
+
+	  These instructions were reserved to allow backwards-compatible
+	  changes in the instruction set possible, by having old processors
+	  treat them as variable-length NOPs, while having other semantics in
+	  modern processors.
+
+	  Some modern uses are:
+	   - Multi-byte/long NOPs
+	   - Indirect Branch Tracking (ENDBR32)
+	   - Shadow Stack (part of CET)
+
+	  Some processors advertising i686 compatibility (such as Cyrix MII,
+	  VIA C3 Nehalem or DM&P Vortex86DX3) lack full support for them,
+	  which may cause SIGILL to be incorrectly raised in user space when
+	  a hintable NOP is encountered.
+
+	  Say Y here if you want the kernel to emulate them, allowing programs
+	  that make use of them to run transparently on such processors.
+
+	  This emulation has no performance penalty for processors that
+	  properly support them, so if unsure, enable it.
+
 config TOSHIBA
 	tristate "Toshiba Laptop support"
 	depends on X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b470590..22b51c4186e7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -295,12 +295,45 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+static bool handle_hnop(struct pt_regs *regs)
+{
+	unsigned char buf[MAX_INSN_SIZE];
+	unsigned long nr_copied;
+	struct insn insn;
+
+	if (!IS_ENABLED(CONFIG_X86_HNOP_EMU))
+		return false;
+
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (nr_copied <= 0)
+		return false;
+
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
+		return false;
+
+	/* Hintable NOPs cover 0F 18 to 0F 1F */
+	if (insn.opcode.bytes[0] != 0x0F ||
+	    insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
+		return false;
+
+	pr_warn_once("%s[%d] uses hintable NOPs that your processor does not support.\n"
+		     "The kernel is emulating them; the performance of this "
+		     "and other executables using them will be impacted.\n",
+		     current->comm, task_pid_nr(current));
+
+	regs->ip += insn.length;
+	return true;
+}
+
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
 static inline void handle_invalid_op(struct pt_regs *regs)
 #endif
 {
+	if (user_mode(regs) && handle_hnop(regs))
+		return;
+
 	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
-- 
2.34.1


