Return-Path: <linux-kernel+bounces-822068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC59B82F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FFA1C23FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F7274FFE;
	Thu, 18 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFLl53Gu"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157E268C42
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172586; cv=none; b=htTE92aCldS673W/MDniRtnWHGA/5nQbCjPnA/6/S9DfVCDc1EDn3VN3fbh2ZQcmMkIcI1O1bMLh2eVh8PHy8ok58TFx9JKTzYxoYKLWtREMkyz/8t6Q8bjYTLAG5tzYXzmyTmNUI4Q+ZHVNPasR9YAN+GXeXkKwWC/SmtaJ1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172586; c=relaxed/simple;
	bh=Rh8EDyP0VnYAbVERnzfNVnPZO1tV+O/kVhDgVIx4GNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b918lPGTPvGZP/QjTTKWwOFyMYQV6STkwZbZvBRNGgiuZ36o4pwFNKll9/bqox4ulFYLcfdv+0vyzpsk/YGz8EjXa0h3dZHN42kEqhfdGHB0ujakEUT53uXPeytHrqBpznE2ot460zqKahn61LHgmo0qmmCNEkQ3NBMkZw3xDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFLl53Gu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77d24db67e0so259593b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172584; x=1758777384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=GFLl53GuPlD4HCdzi4jYtHKBOJPUFem/AoEJqDMe4lIfzEsEQifIyF0rFj30ZBjaEf
         lfMLjkXT3qrJV/pxSDzOiUIxE79iTN/70keU1thcLJNlSondX7qR1FUa15UhQjGafqRl
         S+4lEkmbA+m2ZBdZitesDJrc1fH5vJpugiWYUgTxJLY21YcWQk4jiq1wH03MMdArASKH
         O3C3Buo2HGzZPDBpYTNHBK6AFJjYJVOBDYUPSzzCPUSCnN7Xmz32rDhhjGeIMI1v45Pn
         h7WCoOXrbm28h++Pzb5TD18bo41HQW6UyryYia7N/3bSd5HvrfGTe12VoCXKEaov6XXA
         cZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172584; x=1758777384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiT0MrcHOyv1UJl38CIIzCgovK63Js+Y+q9YvsvWIlo=;
        b=H+B/xm9rlu/PgujVkmVDaD9nBw9QV/kiXVJ7CYsDvks10KC4Ak/s6qzp6SThTIs8Xu
         PVYtZ4LeBaqKGztVamkoADPwAeSZ5Be1vaaBhsUzE428lMJLnLMISONqLVh6HPjf48+U
         w2mp74/QGVmFf/5wBl8PsSa91y5Q6xoKY5ux2fdolT6KRk/r7QJGaXm477zU8R/7sMwr
         bM2gsaWiW5vdiws5w+vk15czfdPCDuXVRqK0nvshtiUvCF85cegrg7Wu0/bOr7mxd+tp
         OL5QdlxYAmMLbyboh5YhPIoDhRL9jS1mVqP8TJAIzjOizjG80cZnqWjPgKV4TDZzNzT2
         pCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSYvgq7DjSSvNdS/BI+nvps15EY05avRkQJHAAx6rGZAofbUQXzdN5/KEsdcSJqfti2f48x1D8j0L7nWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+5H2GmaGbCHA262LH1anGtwi4p4nNJOEUveDd+4kLz6uGM1a
	pTPU81qcjC2t4bIZCeI167VBymXksPm+pevwpStYMYia7tRba0T2W4tA
X-Gm-Gg: ASbGnct19NRBODfNkUkNJDYcEPhdyeeE5fT4I2HTCQmC8kGtMepJkTUTEzOx1YeyX8c
	hDOL6SgIBrsqi4TkjDovirFqaV7VwLHw0rI9xPPtrYAHOLfrVnr1vjPjXu4R+16W602tVSGQdXC
	WWA04ZAl+aXdMb3L/xLMHP2Yct9XRdaNoy3AnRsWN1nnMVPizFO+EvMwPCBNOkLRF5RFsylBeYe
	xt95TYK6nx2kzmz9IMIj78TbvnkJcnulYfrx+OnlUTm2RDLqJELpIXD3JlY/jlNZXBpAto0SvXm
	25OnLWdoNVBB7GIqg8VcN6xlzBhwfd/JREzjR/vTr9IdkUV2oUXkSS6r0nfZrwF4OZY/0+cVgYL
	AUx78GvjjvVtPUMmaWUDscYQufkYdXPdshWLmDiT6Uy9r4fi5ibvetZ0mVlGSC69gRwmS+5axRj
	2TMTeu+c8PKbDC42uFW3Aetg==
X-Google-Smtp-Source: AGHT+IEa23dRQySwPPnr5ub15MBlqUEyaqoSvqVGNsNzpQT7Ye8yNYnLRaw4EeZooTnvYHDwu7FgGw==
X-Received: by 2002:a05:6a00:887:b0:772:8694:1d71 with SMTP id d2e1a72fcca58-77bf45c2008mr5267793b3a.0.1758172583863;
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe7607c8sm1093015b3a.58.2025.09.17.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B2BEE1061EE2; Thu, 18 Sep 2025 14:16:20 +0900 (JST)
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
Subject: [PATCH v11 01/14] x86/um: nommu: elf loader for fdpic
Date: Thu, 18 Sep 2025 14:15:54 +0900
Message-ID: <5a4932bbcdbf79facd544fec7e3d6a6969a40aa1.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
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


