Return-Path: <linux-kernel+bounces-853833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF8BDCB43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4DD19A7314
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE530FF23;
	Wed, 15 Oct 2025 06:23:06 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1230FF1C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509382; cv=none; b=qv7Vr1qjtIJ0E9AyQwsiJxZbchabv0i525TJcsPNayAKwUsX8CTnwhHxyEtXKw8zAnGXyQkGUdYfj23/DieE+gR/7d+Ui1RJ3suqmhxYSKEPcyPzHEbIqCRGcFL669bp4fbTSlSUCQxMRJplxi0k7uY+YaEFGVS+U7tSFwyNz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509382; c=relaxed/simple;
	bh=jk6V8uAWe05WcVxwCmCyOuLV3NnfCAjwrc4eKkGZJ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp/yPZEikdHCF4oIdCb3nzQDMr3XNnvCWi7IQEpjQ8yfI5KujKCj/tReDqs3PismsfEWzjYHkmwUanc5+p5pcUJZ6fvG4GIBUlIYYzJPh4LtIW6YU2M0+ILlNf+9um6umNM8hFrJhqU7NZG/LfeYpab3vN9Ryfqbanvyrfty4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz19t1760509371td6f1d5ef
X-QQ-Originating-IP: MUaYd5o57zoY0W6wIrPI4YBjDwhi9ENIo8kee4n+TZM=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:22:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6832363004775497478
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 8/8] riscv: use PUSHSECTION in ex_table, jump_table, bug_table and alternatives
Date: Wed, 15 Oct 2025 14:22:39 +0800
Message-ID: <22B977FCB8434D8A+8905ca92f19047804ba693f7cd3b2ef1e2721bad.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NGX5+lQVxpC+qFWJXzXeWgsOzhZAmPuembL2fF5KoOSXQi8iukHfOy5k
	X0MT0b+9ZrSkiHUJu84isQIPUnudT0PLb4UjvXt8pixKOKSH5HXF0XjE7N6eYbqZLDO9i1K
	7vVrAvmJFQycuYqQ+uKPVJr2YClr+HjULZlKkVFhb5gPXbgk/A5RUADGpgEUVfehh3IbTr1
	GNg1kPbJgTe0jNhjYKG1NEn1Ysi1OZg2MSB1xVGO3QgWhDFr7r7JVU6fADSfdv5qPAtRns5
	s3H0t+w0lQfzkV1ehbC5qLhTQwB8LWaC6JG3OZaUDCj2utZNWm5i+totgWxDRxH029rmWq6
	XZjub37WOyhUF+zAeOO1DhXMxZFcnrOYoWZHc1kiOL/tyT0i3pYOmSFq6d+gqTQ3PR3a8Tb
	ghO7WXBmWDkV9qCBvnxfV6IpamYu0eNgrRY0bp6vrF3qPZuVK/Innb9SAXKHehjFYmiS84Z
	smRhiqcwB+2QciPeMGzOaAh2Myn/OUXPXkpiBj7grdS2PM7L/c87fHLbBLS9Uwrac42TCqw
	mkAmBvD8JYLTmXVfrSmrLIC/8Fn/eFtvzyUVeGaEw60aXoHv7HAjN6b+qDha3ri8QZWyuEZ
	F6mX0z6q1uopQFiIEaujAUEhJDQUJHAOmJIRZmM6kNRN9ll81w5RVQ90i33/ex9MFyA4rbo
	Kay6B1v730YN6nOY9TRjwAC92WEJWDEs2RTCToEvhg2YhQQFo6B0SOIvrSpnG17/JBZgBzW
	H4u6A+sF7ErTDWWgNamI3FUMs1BxuvChPLGHRbWeecZHvM8y6XB8kWm55RPzhsjS8qCdPJh
	tsOfF5pqw8euqsYNU1hMh5jcFWDQ0j0GsapCPl/XPqjCw/t1xl/JWcj9KTokgOVU6wWbtuc
	jLJQdvZDdL4HOdrmCHNN/DKe9Mg1tCtrFBO5l/86Ky0yaKTkEwsumqHar80eMtovgQkKfUz
	B1vohgim3jYoDZYciXS3GWMaF4vDzexNdGXDLnFEwUx/7dx1oHqnzNHz/
X-QQ-XMRINFO: M8wFrcb6n6Ii4I6kYxweyY8=
X-QQ-RECHKSPAM: 0

Replace plain .pushsection with the new PUSHSECTION macro for __ex_table,
__bug_table, __jump_table, and .alternative on RISC-V.

PUSHSECTION establishes proper references between the caller and the
generated sections, allowing --gc-sections to recognize their dependencies
correctly. This avoids the need for KEEP() and prevents dependency
inversion where unused sections keep others alive.

With this change, CONFIG_TRIM_UNUSED_SYSCALLS can correctly discard unused
syscalls together with their exception tables.

This update takes effect only when built with an assembler that supports
BFD_RELOC_NONE, and falls back to the existing behavior otherwise.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 arch/riscv/include/asm/alternative-macros.h |  8 +++++---
 arch/riscv/include/asm/asm-extable.h        | 10 ++++++----
 arch/riscv/include/asm/bug.h                |  2 +-
 arch/riscv/include/asm/jump_label.h         |  3 ++-
 arch/riscv/kernel/vmlinux.lds.S             |  9 ++++++++-
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 9619bd5c8eba..dd24c3e1117b 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -2,9 +2,11 @@
 #ifndef __ASM_ALTERNATIVE_MACROS_H
 #define __ASM_ALTERNATIVE_MACROS_H
 
+#include <linux/compiler.h>
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 
-#ifdef __ASSEMBLER__
+#ifdef __ASSEMBLY__
 
 .macro ALT_ENTRY oldptr newptr vendor_id patch_id new_len
 	.4byte \oldptr - .
@@ -16,7 +18,7 @@
 
 .macro ALT_NEW_CONTENT vendor_id, patch_id, enable = 1, new_c
 	.if \enable
-	.pushsection .alternative, "a"
+	PUSHSECTION .alternative, "a"
 	ALT_ENTRY 886b, 888f, \vendor_id, \patch_id, 889f - 888f
 	.popsection
 	.subsection 1
@@ -67,7 +69,7 @@
 
 #define ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)		\
 	".if " __stringify(enable) " == 1\n"				\
-	".pushsection .alternative, \"a\"\n"				\
+	PUSHSECTION(.alternative, "a")					\
 	ALT_ENTRY("886b", "888f", __stringify(vendor_id), __stringify(patch_id), "889f - 888f") \
 	".popsection\n"							\
 	".subsection 1\n"						\
diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 37d425d7a762..24eb29f2ef82 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_ASM_EXTABLE_H
 #define __ASM_ASM_EXTABLE_H
 
+#include <linux/compiler.h>
+
 #define EX_TYPE_NONE			0
 #define EX_TYPE_FIXUP			1
 #define EX_TYPE_BPF			2
@@ -10,10 +12,10 @@
 
 #ifdef CONFIG_MMU
 
-#ifdef __ASSEMBLER__
+#ifdef __ASSEMBLY__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	.pushsection	__ex_table, "a";		\
+	PUSHSECTION __ex_table, "a";			\
 	.balign		4;				\
 	.long		((insn) - .);			\
 	.long		((fixup) - .);			\
@@ -31,8 +33,8 @@
 #include <linux/stringify.h>
 #include <asm/gpr-num.h>
 
-#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	".pushsection	__ex_table, \"a\"\n"		\
+#define __ASM_EXTABLE_RAW(insn, fixup, type, data)      \
+	PUSHSECTION(__ex_table, "a")			\
 	".balign	4\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 4c03e20ad11f..855860c34209 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -54,7 +54,7 @@ typedef u32 bug_insn_t;
 #define ARCH_WARN_ASM(file, line, flags, size)			\
 		"1:\n\t"					\
 			"ebreak\n"				\
-			".pushsection __bug_table,\"aw\"\n\t"	\
+			PUSHSECTION(__bug_table, "aw")          \
 		"2:\n\t"					\
 		__BUG_ENTRY(file, line, flags) "\n\t"		\
 			".org 2b + " size "\n\t"                \
diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 3ab5f2e3212b..1134a9bc95a7 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -11,13 +11,14 @@
 
 #include <linux/types.h>
 #include <asm/asm.h>
+#include <linux/compiler.h>
 
 #define HAVE_JUMP_LABEL_BATCH
 
 #define JUMP_LABEL_NOP_SIZE 4
 
 #define JUMP_TABLE_ENTRY(key, label)			\
-	".pushsection	__jump_table, \"aw\"	\n\t"	\
+	PUSHSECTION(__jump_table, "aw")	                \
 	".align		" RISCV_LGPTR "		\n\t"	\
 	".long		1b - ., " label " - .	\n\t"	\
 	"" RISCV_PTR "	" key " - .		\n\t"	\
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 61bd5ba6680a..e6d117047226 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -7,6 +7,13 @@
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define RUNTIME_DISCARD_EXIT
 
+#ifdef CONFIG_PUSHSECTION_WITH_RELOC
+#define NOKEEP___jump_table 1
+#define NOKEEP___ex_table 1
+#define NOKEEP___bug_table 1
+#define NOKEEP_alternative 1
+#endif
+
 #ifdef CONFIG_XIP_KERNEL
 #include "vmlinux-xip.lds.S"
 #else
@@ -117,7 +124,7 @@ SECTIONS
 	. = ALIGN(8);
 	.alternative : {
 		__alt_start = .;
-		KEEP(*(.alternative))
+		COND_KEEP(alternative, *(.alternative*))
 		__alt_end = .;
 	}
 	__init_end = .;
-- 
2.43.0


