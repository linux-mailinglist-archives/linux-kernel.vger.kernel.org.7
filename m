Return-Path: <linux-kernel+bounces-738968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912DB0BFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D4189DAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC22877CF;
	Mon, 21 Jul 2025 09:12:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EC1798F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089177; cv=none; b=CABo+P6sIN4Dd0I0bIyJam8Ss2kAopzQcy6SMcRz7YPN833JIFnxIBACaAMZ3tLdeWsANYXQz//cDMHDnx7z3lPMvPeTH2f/hNhegHaN3dPq/uDdnveTlj3G1MFYHtSS32AnIDhYpMNfheqQcHPfIRYGD2myQd1mdJzlqyxovrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089177; c=relaxed/simple;
	bh=X5IuqxopbgrZ/xk/4Rm96XqTv5uL59yd4KWknf5JCvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qx9x7lgmblHbzPSevy7DasBkHFQ5kqrMa8bqDpWsdxWuCUDgjeLxwb7tyJd8tVf1L03/+DQTYAusHsZwDJ7ITzXKw6WTr560NXQitGJWkqbeot7ogLcJ2Zj2iYCv+MLgd4IYWpXlzFDq5KgP4SEpa7Ur8SjJYoFMmhgCzYWsLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxaWqSBH5oWrQuAQ--.33438S3;
	Mon, 21 Jul 2025 17:12:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxzsGRBH5oOfofAA--.9767S2;
	Mon, 21 Jul 2025 17:12:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Implement physical address with ELF program header
Date: Mon, 21 Jul 2025 17:12:48 +0800
Message-Id: <20250721091248.3896152-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsGRBH5oOfofAA--.9767S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With structure elf64_phdr, field p_paddr is physical address of the
segment. And it is convenient for qemu to calculate the physical
address when directly boot ELF kernel image.

Otherwise QEMU needs convert virtual address p_vaddr into physical
address, the conversion logic assumes that DMW method is used where
48 bit physical address is supported. However with direct MMU mapping
method with start address from 0xFFFF800000000000, only 47 bit physical
address is supported. QEMU cannot assume the kernel behavior at kernel
loading stage.

Here add physical address indication in ELF program header, it is
convenient to get physical kernel loading address.

Here is output with command readelf -l vmlinux with patch:
  Elf file type is EXEC (Executable file)
  Entry point 0x90000000015f5000
  There are 2 program headers, starting at offset 64
  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    LOAD           0x0000000000010000 0x9000000000200000 0x0000000000200000
                   0x000000000293b000 0x0000000002a79b98  RWE    0x10000

And output with command readelf -l vmlinux without the patch:
  Elf file type is EXEC (Executable file)
  Entry point 0x90000000015f5000
  There are 2 program headers, starting at offset 64
  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    LOAD           0x0000000000010000 0x9000000000200000 0x9000000000200000
                   0x000000000293b000 0x0000000002a79b98  RWE    0x10000

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Set LOAD_OFFSET with PAGE_OFFSET rather than CACHE_BASE, since it
     is generic with PAGE_OFFSET.
  2. Add AT information with missing edata_padding section. 
---
 arch/loongarch/kernel/vmlinux.lds.S | 36 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 08ea921cdec1..8ce6b0d948f4 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -3,10 +3,12 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/orc_lookup.h>
+#include <asm/addrspace.h>
 
 #define PAGE_SIZE _PAGE_SIZE
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define PHYSADDR_MASK			0xffffffffffff /* 48-bit */
+#define LOAD_OFFSET			PAGE_OFFSET
 
 /*
  * Put .bss..swapper_pg_dir as the first thing in .bss. This will
@@ -42,7 +44,7 @@ SECTIONS
 
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	_stext = .;
-	.text : {
+	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -60,7 +62,7 @@ SECTIONS
 	__inittext_begin = .;
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
-	.exit.text : {
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		EXIT_TEXT
 	}
 
@@ -82,7 +84,7 @@ SECTIONS
 	}
 
 	INIT_DATA_SECTION(16)
-	.exit.data : {
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
 		EXIT_DATA
 	}
 
@@ -90,7 +92,7 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
 #endif
 
-	.init.bss : {
+	.init.bss : AT(ADDR(.init.bss) - LOAD_OFFSET) {
 		*(.init.bss)
 	}
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
@@ -101,27 +103,34 @@ SECTIONS
 	_sdata = .;
 	RO_DATA(4096)
 
-	.got : ALIGN(16) { *(.got) }
-	.plt : ALIGN(16) { *(.plt) }
-	.got.plt : ALIGN(16) { *(.got.plt) }
+	. =  ALIGN(16);
+	.got : AT(ADDR(.got) - LOAD_OFFSET) { *(.got) }
+	. =  ALIGN(16);
+	.plt : AT(ADDR(.plt) - LOAD_OFFSET) { *(.plt) }
+	. =  ALIGN(16);
+	.got.plt : AT(ADDR(.got.plt) - LOAD_OFFSET) { *(.got.plt) }
 
 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
 
-	.rela.dyn : ALIGN(8) {
+	. = ALIGN(8);
+	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET) {
 		__rela_dyn_begin = .;
 		 *(.rela.dyn) *(.rela*)
 		__rela_dyn_end = .;
 	}
 
 #ifdef CONFIG_RELR
-	.relr.dyn : ALIGN(8) {
+	. = ALIGN(8);
+	.relr.dyn : AT(ADDR(.relr.dyn) - LOAD_OFFSET) {
 		__relr_dyn_begin = .;
 		 *(.relr.dyn)
 		__relr_dyn_end = .;
 	}
 #endif
 
-	.data.rel : { *(.data.rel*) }
+	.data.rel : AT(ADDR(.data.rel) - LOAD_OFFSET) {
+		*(.data.rel*)
+	}
 
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
@@ -134,10 +143,13 @@ SECTIONS
 
 	ORC_UNWIND_TABLE
 
-	.sdata : {
+	.sdata : AT(ADDR(.sdata) - LOAD_OFFSET) {
 		*(.sdata)
 	}
-	.edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGN); }
+	.edata_padding : AT(ADDR(.edata_padding) - LOAD_OFFSET) {
+		BYTE(0);
+		. = ALIGN(PECOFF_FILE_ALIGN);
+	}
 	_edata =  .;
 
 	BSS_SECTION(0, SZ_64K, 8)

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.39.3


