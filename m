Return-Path: <linux-kernel+bounces-873360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62DC13C35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC95A1AA6849
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76A3303A37;
	Tue, 28 Oct 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="g4iOmek2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F643016F7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643045; cv=none; b=BOg75wU8GEGW4iNCfhdn6ErD/SKhdI8O78TohQR/vqKWGnMpRARA+1FEmiJm0kkkXwLosOjjVof/pNSjmx0zFldzMVZs9JVS6hXFFGx1nHTHKWrsbVJlm4sp/I7Mjnev26tb8qBdR3YH0JLl8KpGUduq2lHW+Kpb0Z8WhYzgZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643045; c=relaxed/simple;
	bh=vszDF/cx4qHYXXIt4CCpd4y86yZhshQ+o4PVe1g7Y50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEhZdBt5rjXE5nux+TYUAiIUlBNYtWAa25wdhQH/7L2ie5EodL2dVsTnyfI+h03rfkbqzpplwHHLx2zs7E51y6I8xvbaYiM7F4wka8taLfEcZXehcMDrjTNs7k8I6mvZdQjfMz/IZk8aP18UgKWbV/OmukFfS8DwM6ecNOf9Rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=g4iOmek2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643038;
	bh=vszDF/cx4qHYXXIt4CCpd4y86yZhshQ+o4PVe1g7Y50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4iOmek2Pwb6uaHO9W+u8eso4VNQkDSU25wRqBElFVpQ8AW3A2IfvYY4xFaRdfeK6
	 zEYDZMZis6+oV/rFJ2NiXsUZGNdNOvetfhbmxtX9XJLFGpk9Pzfe6Yir6auEGfA+Be
	 3DzYkFALhdgDxn8UbMJq0+NthKJSN9gSw7gyLDRw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:40 +0100
Subject: [PATCH 05/10] x86/um: Drop gate area handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-5-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=2787;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vszDF/cx4qHYXXIt4CCpd4y86yZhshQ+o4PVe1g7Y50=;
 b=o4JmUMvwtaLOa6D398C8FcQZo9AegfjrZ0mzUtV8o6ruPGtlXeeSvSB1/HNV+nBp+yjVHkJSq
 0+5+Nf0zAGFCVqYDRn7QlgelnwkKGaCgWpd/sXbvXYOnmwS3ORxXiCa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

With the removal of the vDSO passthrough from the host,
FIXADDR_USER_START is always 0 and the gate area setup code is dead.

Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/page.h |  4 ----
 arch/x86/um/Makefile       |  4 ++--
 arch/x86/um/mem_32.c       | 50 ----------------------------------------------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 6f54254aaf44..2d363460d896 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -96,8 +96,4 @@ extern unsigned long uml_physmem;
 
 #endif	/* __ASSEMBLER__ */
 
-#ifdef CONFIG_X86_32
-#define __HAVE_ARCH_GATE_AREA 1
-#endif
-
 #endif	/* __UM_PAGE_H */
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 1767e6061b4d..f9ea75bf43ac 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
 	ptrace.o ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-Linux/
+	subarch.o os-Linux/
 
 ifeq ($(CONFIG_X86_32),y)
 
@@ -26,7 +26,7 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += syscalls_64.o vdso/
+obj-y += mem_64.o syscalls_64.o vdso/
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
deleted file mode 100644
index 29b2203bc82c..000000000000
--- a/arch/x86/um/mem_32.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Richard Weinberger <richrd@nod.at>
- */
-
-#include <linux/mm.h>
-#include <asm/elf.h>
-
-static struct vm_area_struct gate_vma;
-
-static int __init gate_vma_init(void)
-{
-	if (!FIXADDR_USER_START)
-		return 0;
-
-	vma_init(&gate_vma, NULL);
-	gate_vma.vm_start = FIXADDR_USER_START;
-	gate_vma.vm_end = FIXADDR_USER_END;
-	vm_flags_init(&gate_vma, VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC);
-	gate_vma.vm_page_prot = PAGE_READONLY;
-
-	return 0;
-}
-__initcall(gate_vma_init);
-
-struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
-{
-	return FIXADDR_USER_START ? &gate_vma : NULL;
-}
-
-int in_gate_area_no_mm(unsigned long addr)
-{
-	if (!FIXADDR_USER_START)
-		return 0;
-
-	if ((addr >= FIXADDR_USER_START) && (addr < FIXADDR_USER_END))
-		return 1;
-
-	return 0;
-}
-
-int in_gate_area(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma = get_gate_vma(mm);
-
-	if (!vma)
-		return 0;
-
-	return (addr >= vma->vm_start) && (addr < vma->vm_end);
-}

-- 
2.51.1.dirty


