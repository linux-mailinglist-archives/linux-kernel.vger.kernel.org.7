Return-Path: <linux-kernel+bounces-776786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C9B2D17C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1EA7A4F01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91B239E63;
	Wed, 20 Aug 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="DLoMHjIp"
Received: from smtpout9.mo534.mail-out.ovh.net (smtpout9.mo534.mail-out.ovh.net [178.33.251.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60364286A1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653715; cv=none; b=STAxSYjUqXfLlsOjmbB67VI6kk0VkD78DJaWVVfJMc/XpjFYInnozCuCRREN/XGIU2pi+OyJM4NWeYE4U2AePj4ZJc9781owq5DK5RGw1GLzy0fnfsSXDPGvCBEQ8+6o1rDOu1EgPpbVX2nObXVCplKTjFBd8vwnZd/Zya9sRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653715; c=relaxed/simple;
	bh=rEGUdLdYVu2O8FczaKYP5OZWsJUxfL+M3oz4vGGRb4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fm0oZQ6WBsMsOHpCtk3dYWSKnrKBKRO3vRMDPlbd+Wt1EN7/v0q3lEgyaQ1v3DyYcqtw2x+RiHrNqk8gafgfv5h9N7HocF+lu0qsksoRm90yD89PckqNQb72jO17xYs5qE+aOdFiX5xjmHP4xOXdq8dQqpkkK7vNR3eU4cgtcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=DLoMHjIp; arc=none smtp.client-ip=178.33.251.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c68CJ53Dgz6J4N;
	Wed, 20 Aug 2025 01:35:08 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 01:35:08 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.120])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c68CJ1gHYz1xqh;
	Wed, 20 Aug 2025 01:35:08 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.6])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 6FA1AB832B0;
	Wed, 20 Aug 2025 01:35:05 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-110S004d9dfd888-a399-4d2f-8cb0-63ca658c155c,
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
	Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: [PATCH] x86: add hintable NOPs emulation
Date: Wed, 20 Aug 2025 03:34:46 +0200
Message-Id: <20250820013452.495481-1-marcos@orca.pet>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2759580673819301556
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepuefgheehhffgleeuvddufeffudeuudefjedufeevlefhudejhfffkeduieetkedvnecuffhomhgrihhnpeguvggsihgrnhdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupddugeejrdduheeirdegvddrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrih
 hlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=CsQnIhdXrK/ETPThlmhZAM66QBjqMjXe5P33hEraYTc=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755653709;
 v=1;
 b=DLoMHjIpV9u3p4EMgbxNd8/23Ab5UkwbfQWNcD4rQ7magTnB7DLfkFmSS4Zy+Ab9cEJBlcIw
 gGtABlL4ib6ZalI6tyyvYvJCz/3yhIuI3HJReenYOYAyoDUFj3uTYOiG3HhEHn1NvoCLhWpDZii
 RhGZu/BpBgTNCeLjtjAhENPoRHh0d8IZ9v5nCU4SUUBaa8QoCwukTt1Ejo1b6wRWpnkSRXU5k7D
 iGB1FfKAlu9JoRIpzGGo/kgonzAQAQdKEiaraJczXzIsY+ibJsuvwqypbxehgLSxkP6bf8qxbaa
 BHiQ2Us5YgEDgHYjPatkcc3z9nRMXeFg4sMG5NiGhUfzg==

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
 arch/x86/Kconfig                 | 29 +++++++++++++++++++++++++
 arch/x86/include/asm/processor.h |  4 ++++
 arch/x86/kernel/process.c        |  3 +++
 arch/x86/kernel/traps.c          | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

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
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bde58f6510ac..c34fb678c4de 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -499,6 +499,10 @@ struct thread_struct {
 
 	unsigned int		iopl_warn:1;
 
+#ifdef CONFIG_X86_HNOP_EMU
+	unsigned int		hnop_warn:1;
+#endif
+
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
 	 * context switch. Store it in thread_struct to avoid a lookup in
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1b7960cf6eb0..6ec8021638d0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,6 +178,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.io_bitmap = NULL;
 	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
+#ifdef CONFIG_X86_HNOP_EMU
+	p->thread.hnop_warn = 0;
+#endif
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b470590..2dcb7d7edf8a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -295,12 +295,48 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+#ifdef CONFIG_X86_HNOP_EMU
+static bool handle_hnop(struct pt_regs *regs)
+{
+	struct thread_struct *t = &current->thread;
+	unsigned char buf[MAX_INSN_SIZE];
+	unsigned long nr_copied;
+	struct insn insn;
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
+		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
+		return false;
+
+	if (!t->hnop_warn) {
+		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
+		       current->comm, task_pid_nr(current), regs->ip);
+		t->hnop_warn = 1;
+	}
+
+	regs->ip += insn.length;
+	return true;
+}
+#endif
+
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
 static inline void handle_invalid_op(struct pt_regs *regs)
 #endif
 {
+#ifdef CONFIG_X86_HNOP_EMU
+	if (user_mode(regs) && handle_hnop(regs))
+		return;
+#endif
+
 	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
-- 
2.34.1


