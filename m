Return-Path: <linux-kernel+bounces-873362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D1C13C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78030344755
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6893043DC;
	Tue, 28 Oct 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bhTSQc+M"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B33019C3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643046; cv=none; b=T4O1e4iBXKo5DLDPz6kv8FdXCWRgjcY0Qb2DXIR2BHhJANdpc94DhCWfUxAu6JUGG6Qi96vgN19EOt//wXVtrbrBLgccA0doOtMlA5ullsmYZKkJT53igHtKSNpFiziZPn5wTl9rQmm3xq9E1XOpKJhaT0a2tPBV6BWxwX8WhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643046; c=relaxed/simple;
	bh=jBXvd5o8xd7AxDkdev4MjEnueBp7q9FqgNwPncpJjP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caWij4YF6oWpQgMbl5bMWUzh+54iDORFlqdNaiYOWP8ghEeIef2FACa/WwEEIBgbxMf2Kkg0XU7wgYkl0F/bPntat3d+4xZYJ8FjX99bKIDL9Ux24zbPKTroO6RZsYM5J439zt/oqg6KHefVIuj09uYALmk3itCsTrC+Wd5Cb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bhTSQc+M; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=jBXvd5o8xd7AxDkdev4MjEnueBp7q9FqgNwPncpJjP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bhTSQc+MY8Q4Cb+L9hfMs4rpSyUf5r09v4+C8O9IY/bbbuhUeh4np0tT66UmWWWFy
	 a8OZaeJ8mBgHbZD8bQdIv0kZBBNNaw8+vPz9/f2gUJ41umiZ1ftofd4YJQOTG5lE7f
	 wBsch4Zd6p/JxPiev10JnJhD5LKWA361L0jQQpNU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:45 +0100
Subject: [PATCH 10/10] um: Always set up AT_HWCAP and AT_PLATFORM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-10-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=3821;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jBXvd5o8xd7AxDkdev4MjEnueBp7q9FqgNwPncpJjP4=;
 b=l/5J9hB4UN4Sm4P7Sd031ZesVQaS000sV+zNJuYPMvpNlqHe+eaZ7Dhvyr9wnNWMKKghulBXM
 bI1FX/3fgRwDwcgAxTVaiUY1rpJZ2iMUr1X0NnzY9WZIKRwnVaUfC9Y
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Historically the code to set up AT_HWCAP and AT_PLATFORM was only built
for 32bit x86 as it was intermingled with the vDSO passthrough code.

Now that vDSO passthrough has been removed, always pass through AT_HWCAP
and AT_PLATFORM.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/Makefile  | 4 +---
 arch/um/os-Linux/elf_aux.c | 7 ++++++-
 arch/um/os-Linux/main.c    | 4 ----
 arch/x86/um/Kconfig        | 3 ---
 arch/x86/um/asm/elf.h      | 7 ++++---
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 70c73c22f715..f8d672d570d9 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -6,7 +6,7 @@
 # Don't instrument UML-specific code
 KCOV_INSTRUMENT                := n
 
-obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
+obj-y = elf_aux.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o skas/
 
@@ -14,8 +14,6 @@ CFLAGS_signal.o += -Wframe-larger-than=4096
 
 CFLAGS_main.o += -Wno-frame-larger-than
 
-obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
-
 obj-$(CONFIG_SMP) += smp.o
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index f8927a5959d8..72f416edf252 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -14,12 +14,17 @@
 #include <elf_user.h>
 #include <mem_user.h>
 #include "internal.h"
+#include <linux/swab.h>
 
+#if __BITS_PER_LONG == 64
+typedef Elf64_auxv_t elf_auxv_t;
+#else
 typedef Elf32_auxv_t elf_auxv_t;
+#endif
 
 /* These are initialized very early in boot and never changed */
 char * elf_aux_platform;
-extern long elf_aux_hwcap;
+long elf_aux_hwcap;
 
 __init void scan_elf_aux( char **envp)
 {
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 730723106228..7e114862a723 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -21,8 +21,6 @@
 
 #define STACKSIZE (8 * 1024 * 1024)
 
-long elf_aux_hwcap;
-
 static void __init set_stklim(void)
 {
 	struct rlimit lim;
@@ -149,9 +147,7 @@ int __init main(int argc, char **argv, char **envp)
 	install_fatal_handler(SIGINT);
 	install_fatal_handler(SIGTERM);
 
-#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	scan_elf_aux(envp);
-#endif
 
 	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv, envp);
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 798c6cc53e82..bdd7c8e39b01 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -34,8 +34,5 @@ config X86_64
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
 
-config ARCH_REUSE_HOST_VSYSCALL_AREA
-	def_bool !64BIT
-
 config GENERIC_HWEIGHT
 	def_bool y
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index fdd5a612f678..22d0111b543b 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -68,9 +68,7 @@
 	pr_reg[16] = PT_REGS_SS(regs);		\
 } while (0);
 
-extern char * elf_aux_platform;
 #define ELF_PLATFORM_FALLBACK "i586"
-#define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
 
 #else
 
@@ -151,7 +149,7 @@ extern char * elf_aux_platform;
 	(pr_reg)[25] = 0;					\
 	(pr_reg)[26] = 0;
 
-#define ELF_PLATFORM "x86_64"
+#define ELF_PLATFORM_FALLBACK "x86_64"
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
@@ -180,6 +178,9 @@ struct task_struct;
 extern long elf_aux_hwcap;
 #define ELF_HWCAP (elf_aux_hwcap)
 
+extern char *elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
+
 #define SET_PERSONALITY(ex) do {} while(0)
 
 #endif

-- 
2.51.1.dirty


