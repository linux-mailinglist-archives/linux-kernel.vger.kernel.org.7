Return-Path: <linux-kernel+bounces-723055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566BAFE232
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A363188CDDF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB32271446;
	Wed,  9 Jul 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF0F/l0v"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3212836B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048711; cv=none; b=YLRKjHTth8RZoLv4HKADJVEuqcSKEnuGTfclCQcP47H571Zv/DUbqDvE6gVUvwbh4kp47ftq3oEpy0sb1Vqg3zVar3VU0OeMbJEimxm+PEDjRdSFI4o7w2v/aNk4f2k6A0DC1X/QWTH68ainRv9fAsRiUZdKlyrBDjAi6S8RP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048711; c=relaxed/simple;
	bh=RfO7bxnrvkm3EAfuN+XVxgry6A3ikIVlIqCUVBjfqOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMWRGkEUvV6Ur5riVylS+sDmTxCU5+mUbZCn70fepnweLZyfBK0fXC7Y8vedu31QKp9m/g257mvGo+U3Z2Q0jXyIDPVDKR/Aseyp5z9Tv07/ipJ/WtXlN5IEmTjqoB6FsyjAWxt8AeKfmR+T7gikKQKE/tROB4DLWo2sctYbUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF0F/l0v; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so29620055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048708; x=1752653508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=BF0F/l0voutOibePlEIE5JRLptxl3XWBsPUiWM/FASmIwXZKTe26D/TwH/4X52jwC0
         kC9q7bkO7LcL2IpFXd10ixxhdsEUOM3Z2azF4ofRSDYpHrGKZq3Uy43MdJoy053Ce1MA
         eH/CboXi4XqqHY84dgDXzw61XqqDwxw+2esadpE4sDBCievpik1L7a0LjqZhbB1Sxawe
         JOHEfg2gn5jSTOyrzIwN40pRJZMKef33UmE/FK/LHQhB49st+wKS2Qe+ABBvPucAdJVI
         n8meyIsJZSkCkxVnIAjA/AR8/FXVDjD7seTQdcWVhWQGgoHHw2hJdTXeObJM6hFgawIy
         yKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048708; x=1752653508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=peJpJlKYnz2q3kvT+f+EJZNk8hcvsFNCAhguHZg8XRCg2DK9qH8cYNorwYc4BJcfev
         t2NtjR/hFZgEzmx6sojaaC8TG9VqZisjTuc8X/ZmScXjEQOxutBBCIsXAzh5hbPhM+Vq
         TCN3/VNEDMyfNdAfSuifH8gbBaJNDlJBgJZC9+72e7rLXo2/NaqEHHSbhjEieY9GcdrS
         +Ghx7LBlA8/szGUIcNLh3WwZHByHN09QQeCa0TaVl+CgPl1JkcAEJrpGMoYUvuY80vtl
         NjdVYJlNsZBZk9OXUc9mQQNLNgHgC6upZajdaE8GPnKWgF/Uwjh32Mb8d0fD1PgHmcZm
         Tc+g==
X-Gm-Message-State: AOJu0YxKvtlK0r6CgRFTRJw0NtVVekdV0UXC8D2JEVyKOmYxOUkPVd6M
	8mHDhO/XNqCjgxdwwCfpfVQfLjteO2kwnrXI8eyzq4YPM7XyAL5nHljmsfyNykyj8H9ZpPAJIFi
	YthV1RBdxS1wEDL3xGstlSIsRWyV+NbeK+8SeK00oRTfSRad7e3AHX78d9wtoacDqDNBmmHDNF1
	vzBpbrO7RaBRFPE5hySrAnP3Z5KyGCxjHmiQ==
X-Google-Smtp-Source: AGHT+IGLcUgjlVQRyaqCjajb+1CDBAcCjlCAfDiidGnK4vOl/dkPaC7j+KCthgTqkmrDKKS5Sll6dSeP
X-Received: from wmbdz10.prod.google.com ([2002:a05:600c:670a:b0:43c:ef7b:ffac])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6090:b0:453:483b:6272
 with SMTP id 5b1f17b1804b1-454d52f5000mr12473315e9.7.1752048708249; Wed, 09
 Jul 2025 01:11:48 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:09:03 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=GtM5Ky3cWjJjWfzB1UFTM+fqdT7qquH5JBfrdp2rkyg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+dfMCbvLrIrClJuMlGRn2KplntZQi+Z87D3b1OO4X
 NiBKyodpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJfrjD8L/f/+CZ8z8/ma778
 SidtJtnH3mlqEb67SWHdyWtvXXm/2zH8FfaMXjB59Vndd75tV/5Ge7I6WbWVqT5gfxp4++yzA27 7uAE=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-48-ardb+git@google.com>
Subject: [PATCH v4 22/24] efistub/x86: Remap inittext read-execute when needed
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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


