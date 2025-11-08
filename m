Return-Path: <linux-kernel+bounces-891379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EEC42910
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7553B373A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510322E0402;
	Sat,  8 Nov 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqTs+69F"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF125A630
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589158; cv=none; b=sAmHKfQg0oWPpS0hpbpJclPyFR9h3iP5SPrP56SIjm4DFI/0MUFVAuEpaIJ6LRGtH0Gq/ijMyLi1mFXBfb8U0RwfLB8TgrQVB9eccp62KufjqbpHK75u5SpFROspz5rkAfzUIwW8ocZ5MGb5Xs1Q92f31FuyBX2gdb5rKqKXiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589158; c=relaxed/simple;
	bh=CvYzjfP7rw4yGGJRdX8B4balTna1wcyExbLjMjY+2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxrib6CwtcN99mbDIHRrMoDa+R5drr99mnU3L45Pp8okc2RhZ/ZmQ+lH7vxFIhGSvXqhc8Lf2HCugsFkQxpN8y+aejKb18K+z7sO3tOPxy99NKToz2HmbrHGsO6mPw7sQC3rUkilHCyZvqDauJaoYm8eF9bibpS3FSTHGmaM8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqTs+69F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-294fe7c2e69so16024105ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589156; x=1763193956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=gqTs+69FF3kfegUNdsmb18tTgXgdmSAcwoBmMo2qY9VZ15WHGKOa4bNugon5P4NFtV
         In69Hm9lejo6f6eP+dUFGpx5UufFPKv5ynI8vdiSqtwoCDF4OxoGvLUe883EYB5b5w/A
         pPk3EzsZg3LhYKhqh6k5fQJ0PaRPIy0kwerWgVO3Cna3vXQ/L5vWJhzaujkFXZVk9LgC
         WbSDJOWbM77DmUYySQLqEzF+hONP2fIZfGnbmeTxUonIL8636xLQwaM5BRQasFnbMUUb
         N6AgSHss9MziDejNG1b0xXcnMu+twLJMyQiAPg5ePA2td6N9WiY4A4VVoKMQZ0ijoMYT
         JonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589156; x=1763193956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=CiFRbGX5y6A0s0RWPRWYrnmdBc8WCUGS4GdCkYXyIeQSWLSkNwIawo3F7Z7VYKM6M0
         dDwXYjbfeEq9wTCH2xdnDxfKTHDqXAjW9DEFVZ7buUTn9YHw7dpk6DSj07o+hHqHkIgx
         ANx2sChjZO2UTznAo7wF2v1kxPFEGfJfraMDEH/84eJIL/231aO5N8MMIBkTV6vC8So3
         hgZaG31l2WIWijp4uf/TOCBVUTiulCZzIxRCOUNbRGEoditD4vSojGbu/0J0r5GLmgf2
         cFE0AWu49egukkiWG7C2+4CVaGE2CtkJhqd+FPLq3PZLgHxo392gsU2hozYyDAJ95Hw5
         PWOg==
X-Forwarded-Encrypted: i=1; AJvYcCUqXFGqQmaRWIWaTRJ5UfuTqyj/CeL3dF/w3QizCyLK7m0VRLxc+sHWepop0OWEIdFKHBf3Q51yKYFtKuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nGtbZar7UA7oRZpWL8stLzwCAnhZ3iDpWYVh49RPIxYY5Y4k
	11eVFSSIttNhhluOTSvydFzVTsj7pexYaMlsmuZ5WaXBk9WXB+S367fy5Sdy48IH
X-Gm-Gg: ASbGnctH+cbgSAHHM+6jLT0hA998hBo0DtxGouGKU8v1HUn1Aji/wk6ZTWbVKf6SEQN
	fZR9vAAE9UTvaTgzqOdTgwMIvlPBu66qNuRjiIq8yzOYvzQxEe5RyCGArwh7NTQaXPbD5RXdeqk
	rrY8WAy2SFcsT2DKL03cIwI6iCWmAR3fMIkaBLPshZPlm64gAfSlvszE2TL5l6ecwGF6BAt6zWa
	+eXAYltP0WNXz9JqJGmnsD6ltqqRODCXte587aGaeFsVs9z/c/FEOQ8zQifKEbudqZDKzWUan0P
	w8VTL7129xFQhZPAhlb2PpQvGmbAXRdiYMJN0MtI9P63xGI21Gibgxt88e6S0o/Y1mWfyCGdSg9
	KfwXFQLfCCUHjIdmMy2/HneNjAUpDOrQzibSsO6viGR2dmymKg6xDMftdMD00lSobyeL0ARDmZw
	xCC+eUjGSXLxElRE9cjrxgqnwGomXZrM1bnQfgBCGxcFVdAaEbtl8qxvlgExcKamO83XE=
X-Google-Smtp-Source: AGHT+IFNIgTTAZ2Vl2vkAxBvJV+q8EYjnppJ5K0pIHpzL9Ue02aCEVYgWqO6SIqSBUirhrY7QzbLaw==
X-Received: by 2002:a17:903:ac6:b0:295:269d:87cf with SMTP id d9443c01a7336-297e5619d74mr21459175ad.5.1762589156346;
        Sat, 08 Nov 2025 00:05:56 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm83340945ad.7.2025.11.08.00.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:05:55 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0019311388C7; Sat,  8 Nov 2025 17:05:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 01/13] x86/um: nommu: elf loader for fdpic
Date: Sat,  8 Nov 2025 17:05:36 +0900
Message-ID: <59210140957e95ab0df73125bfdb035913a468b1.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 07d48738b402..82a919132aff 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -21,6 +21,11 @@ typedef struct mm_context {
 	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 86d74f9d33cf..62e9916078ec 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 22d0111b543b..388fe669886c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -158,8 +159,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..0a92bebd5f75 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.43.0


