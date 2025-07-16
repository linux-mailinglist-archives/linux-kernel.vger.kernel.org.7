Return-Path: <linux-kernel+bounces-732804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF31B06C42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EBF561133
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1754428FFE6;
	Wed, 16 Jul 2025 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kW/fjnf"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645728D8CA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636173; cv=none; b=dNIS5RFCYP/VGaTsHMgCc1mivB0mtXeYl97xH2xKmb10u6J5Exh/h/aMYp4XwOe54jY0G3XHApQtT/sHQGQgBVcgU+iy48Y1YkSwWSe9bwPeHsJKd0vvi5LE89/wyuWXmBi7U3w6I5UJAWMMdrOHFrrN3Fobd0l2QuV26Xq4U9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636173; c=relaxed/simple;
	bh=RfO7bxnrvkm3EAfuN+XVxgry6A3ikIVlIqCUVBjfqOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0sr2s+5u5sjsAOsKg35+ute4426Q22OVoXuVJzR9SQ5kDuqpXLm8vBsOvM/zvrcr7rlpl2hrwvj/eewJPPbTfisILzUnFPnazgucN2Umol+ftrnNyi+GlR8Iigm+LkF969g1PnnSeUZcJbuzvGSN9VC+uyepwGEXkxO/CMgAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kW/fjnf; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2284098f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636170; x=1753240970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=4kW/fjnf/DWge4T13xs63Wafg6AJnAc9hKjrewFVl1VQ+Uxw8EIrewDpAZxj2S3puL
         lkqycqjnkrMKSMiTzk1a2mQ2y8YAIYg6OAc+SrB4jE8GZi3e+zRsE8xjvzQbhviPl8Ox
         KiK6wA2x/y7d+PMU6065xhwgD5AlbyTLpws6dwO/Eo/+oF4yP7H0XNXSS6OJwoXhsBPT
         A1DCXKVq1oXIj9ApRdZilhz65hznXXbE5DHOIFfLz0QNc4o+2lrs1J402AcepI2GaF7v
         f+rkEcd2Rf1RUR8zuoB23Kq4WG/Hn01ZCWx6ZJbt77UmHwz2ljcen17uhxPyuGU9cDow
         7IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636170; x=1753240970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=eGjJgqz/nKXmeNtL4Y24OV5RlAzfqvEkVNhyjRaHo5FNJyCF4AU4VZ4saKFK/QF8V2
         5mWDCjD8sw/rJ/GHk+FECPQ/3qiczAedbK86IuChD+zaaeiRyDDqHias8POsf8Tb5Qwb
         x72fdtJRPVlOoChQ7HQyMa0g62/NpCdv9AQQQEap3ktkFuI/7RB60/KBaOte2FigUAp3
         w3iTDpAuat2nHqzCSZgA9pQ5KS3/Kf7oeQVd90pYw0fk1id/bc40Li3xYXuffRcX/j1w
         1aymXzEItctogHAdwCmFuVI7Ywc8u4fcPtlI+xPCrQqlj3A/fpxvsHTPzF7FbJlO1qSL
         +kzg==
X-Gm-Message-State: AOJu0YwpOAwQEcjv1WLCWia9FjKhMBy3qyOHnoGuKKiCaWwzbcWEVHrh
	2d+7VEx/Gc+nffnRgekeJnBNRgeN26aEMW6NC/73tj6hlfoT9VmpdVX8f8X1XXExONXAd31zBrm
	pZIPu9GkuauGvFV8sWt016iq3TGFChJymqj4MiqVVmO72tjuwgd28RFZkLBpmIRtXAwziE31ef6
	/TVF0sdb5lXF6TBlniM9/IFRTpcjUOppvqfQ==
X-Google-Smtp-Source: AGHT+IEWhaE99OwCX/esjWHh8KBB3EsOMLyjjInmtN2ZrBnWyDFImIs4h/qmvtFvku7loso+0jZGwFxu
X-Received: from wmcq23.prod.google.com ([2002:a05:600c:c117:b0:453:b96:8ef9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4719:b0:3b5:dbd8:ad5f
 with SMTP id ffacd0b85a97d-3b60dd91d5amr861486f8f.58.1752636169819; Tue, 15
 Jul 2025 20:22:49 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:35 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=GtM5Ky3cWjJjWfzB1UFTM+fqdT7qquH5JBfrdp2rkyg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNcKmnmhN1lVkVhyk1GSrIzbNUyT2uoRXM+9p5t6nFcL
 uzAFZWOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJFvzxgZTgvmbZ3yK6X4/tlU
 B52tDpo7wptyo2bwWv59Pue+SmyuMiPDgjPN/rwfPot+ud2sGO+2Rbq++qDg6Uye2v9LNwZ+0bL jAwA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-44-ardb+git@google.com>
Subject: [PATCH v5 20/22] efistub/x86: Remap inittext read-execute when needed
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Recent EFI x86 systems are more strict when it comes to mapping boot
images, and require that mappings are either read-write or read-execute.

Now that the boot code is being cleaned up and refactored, most of it is
being moved into .init.text [where it arguably belongs] but that implies
that when booting on such strict EFI firmware, we need to take care to
map .init.text (and the .altinstr_aux section that follows it)
read-execute as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       | 2 +-
 arch/x86/boot/compressed/misc.c         | 2 ++
 arch/x86/include/asm/boot.h             | 2 ++
 arch/x86/kernel/vmlinux.lds.S           | 2 ++
 drivers/firmware/efi/libstub/x86-stub.c | 4 +++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a38fdcdb9bd..74657589264d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -73,7 +73,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__start_rodata\|_sinittext\|__inittext_end\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b5991da001..0f41ca0e52c0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -332,6 +332,8 @@ static size_t parse_elf(void *output)
 }
 
 const unsigned long kernel_text_size = VO___start_rodata - VO__text;
+const unsigned long kernel_inittext_offset = VO__sinittext - VO__text;
+const unsigned long kernel_inittext_size = VO___inittext_end - VO__sinittext;
 const unsigned long kernel_total_size = VO__end - VO__text;
 
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 02b23aa78955..f7b67cb73915 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -82,6 +82,8 @@
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
+extern const unsigned long kernel_inittext_offset;
+extern const unsigned long kernel_inittext_size;
 extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5d5e3a95e1f9..4277efb26358 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -227,6 +227,8 @@ SECTIONS
 	 */
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
+		. = ALIGN(PAGE_SIZE);
+		__inittext_end = .;
 	}
 
 	INIT_DATA_SECTION(16)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..0d05eac7c72b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -788,7 +788,9 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	*kernel_entry = addr + entry;
 
-	return efi_adjust_memory_range_protection(addr, kernel_text_size);
+	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
+	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
+						  kernel_inittext_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
-- 
2.50.0.727.gbf7dc18ff4-goog


