Return-Path: <linux-kernel+bounces-822231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F40B835CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0101C27394
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7612EC55B;
	Thu, 18 Sep 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sciqb97b"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C812EBDD7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181161; cv=none; b=BHavZd4s+UdI7IqB0PcmObzUNI2u8+Fwqcuy365plpcuTORm3dm3w34heh0Nf7udjrrUf/iKyLnj5XmzTxFr/Bj/9N4FFhBhRmEHWIjGC96QuaK2P++NXDJy8atBmHOwdegIyyXVbcL57COq0M2uC+4NgMYJeHZCq2UeSmjQrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181161; c=relaxed/simple;
	bh=Rh8EDyP0VnYAbVERnzfNVnPZO1tV+O/kVhDgVIx4GNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjhIZKeiUcML0hkRgnfJJtlZb0kfXNVGIgsq8OPgxtb0KIAEBP2Gn9ZeCrisfpKfDtEvVhVScRQhcSI/eBuN8NlPSQ+lErPyxFxD9Doc9EdPKML25wsxNZpCEiiXV361EKWX8RdSYDkPaauY6l91uNWTBKTEAlEM9oYgD3WctmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sciqb97b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf6058aso8623725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181159; x=1758785959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=Sciqb97bttyGOWmpz8VwjxB0BSFchh4Q5b1BAAG/GKsi4bEkJy8/Fo5JQVFZ4pNGVs
         zbCjzI5xveg/xAJ4DksB0flD+g1przwl2U5zJ03i3T9atiV8pQIcJQJzp7HIG41MLFxC
         DohqxgXk/nCdcwzwG2p96P/VNVlbkKkteyXq+V6XE1hXbtAZXprYRHFwpxEvjFcryHfs
         L50tb14E07y3Mi+stRFqu9+W5EcT37E5oTVCbBbRyu98fEalZs8QDptpj5V0bWq2qMjU
         oI5nEfBa10GmFS0q8ng0T611N51+Pr/SwFQcabVMvQ80WTeinoBFMm+UZDPcu30PbtGY
         PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181159; x=1758785959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=uVNhaPs65fM+OFEtQyy7Fo83h35VLaJBcs+0wLe3m4HOBkq51fdRR3zMx7jmH3eny6
         pKVxdMdmORd562MOx1j+LKZygiOjQLyA4rO7MBDNAlFwBds7ciR6zYQSU5geNBp7lf0h
         rsU90ok4Ra1p+1+bX+oaf02vZQ+2w0Zz+vpL4OiPf0QPO7RvcQ8HcTmHsygiTsTt+5Tf
         oU4QHthd8oXM+4e2DBeULfxusRjhy5flQv2VQ9wrSWKjTc14qx3VHi4GPNbKOnca3cOz
         QQgeWVE3exhOLlwJcmQ7CQ0p4OKzyARsuvrGgRZISfggbjbRCngaO5/pISLZT93IxvQl
         D2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlQH4Ellka/pxPpII+522dTZ9cFV3VOaylm9kshnY27zXD8d7dDGAr6zblEbSpYVjDb6sHhUT5JXVWHq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWj1EHhleEHAm0fp7EhdEzZjO4siq8ob5NpcQZGeMVRBRQ6Cyt
	J8eDFvP5Cyis9Lh3Q2V5L7F/jVXLTTaGD9HOASvQn2YSRG0Xvq91xHXD
X-Gm-Gg: ASbGncvdLky+0IzuulmON9qo7zOaiwt0/k2VcKKryMJX8irtwp/x1G/bGY3K77st7eN
	B0MQeW/fycrGN9R0aaEM3fcStTP5VW0VyW8wMP/RCeDCufeBPMYGfkhGIsGBoPSJeKstcQ4QrE4
	/v8pmcawyAleTmA9KkBIi78l6NjGOnAcY/J4UBqIZrODdZEO1HRNHCStLK0TB/8orbv7HS+fW57
	SfvQI1zlCga+HpQAmhTcHltnalbtsR69/WTbirJHuC7jUgRwXUwYIFuj9IUqxyz89btM96MwCSo
	rlPqSoLPuMJaE3Q6Q10NmyiyoydG8UGSyL7NVe+10aGCJADYG2s6P8LKWfb8YCcI0p/JmPLA+G7
	YIOEN1mU15N0XF/rnEZT8ankVml6CIXxnA3BrKwhoVZ9baEHfJErxKgqhZ7L/2WwemBNxLOaw+I
	srhrYnVeZDQO8=
X-Google-Smtp-Source: AGHT+IEhAan4I4Yy608aj+94bqPtnH0sZCzGPXalqh2iDtPG1/N54CnlninxatIc4ohWkAdwd6ge3w==
X-Received: by 2002:a17:902:d504:b0:24c:af64:ae11 with SMTP id d9443c01a7336-26813903478mr67341765ad.44.1758181158787;
        Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275fb3csm4555900a91.20.2025.09.18.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4BB8A10620FC; Thu, 18 Sep 2025 16:39:16 +0900 (JST)
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
Subject: [PATCH RESEND v11 01/13] x86/um: nommu: elf loader for fdpic
Date: Thu, 18 Sep 2025 16:38:56 +0900
Message-ID: <5a4932bbcdbf79facd544fec7e3d6a6969a40aa1.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
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
index 4d0e4239f3cc..e9661846b4a3 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -17,6 +17,11 @@ typedef struct mm_context {
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #endif
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
index 62ed5d68a978..33f69f1eac10 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
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
index bd2f530e5740..419ba0282806 100644
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


