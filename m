Return-Path: <linux-kernel+bounces-740365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D44B0D357
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87361885085
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A462D3207;
	Tue, 22 Jul 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a73XFqX4"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131A2E1C53
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169413; cv=none; b=DtNTKwOHzRbtx/p4SmbgTR9Rq/i0TYpgPube6KAMeuu9aebyhy2Sa/fwbdv30MrprjskR14mj/1KeU+3CXgGZYsZkJgmcsDf8aZsCCZbylB9wBYYqhzahBBaY7KrV6pKrIH8NUJjo+aeKQN0kvricmHY4ktdF7UDXoiGK40BnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169413; c=relaxed/simple;
	bh=RfO7bxnrvkm3EAfuN+XVxgry6A3ikIVlIqCUVBjfqOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sEO57w95c25PH/4jR+wyRXkgQ4pvWHefTiVuAkgF7S+kjhZ1LS4fnxdc5kgT1RyFxrjNNLjI24gGjOkfQ9cs6DDZtCOCdbHV/gATNtA4SXgNuwhZ1ll3RlFS63bHYQlgDN9RNif9W+w3Kd6ILhC6g+nziXyHbrGIbyjAvDeOaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a73XFqX4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1809266f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169410; x=1753774210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=a73XFqX4Yo3wTcWDDPUjR9c1RIdgImY6eJkpUvH3SgAv1vQ0Fd4AzAuBUW3pgA2Xdl
         32R5qZlwP57tYmB+OgXLQLwTenYKwnYsQlyLykP88fdBbzwIJoy0bh9q1pdJqe6UoG09
         bm6NqxvLd1rKPBIhfhS7fp1sLBYNQshY4fzxAChtnb8ARqYlkZSThZHnpgU19WaUJstg
         UNaJ6eFH+t/qS/mCUm+xKTOBRm3XT11T4M3yvL+Joycwc8l19JNxsyhFEibCH2ZxRrPB
         7DdK62IUaKJ20q/V0k6kjtfVv1nYFWf/c0wGpXZHiqVZ1miKfKOd+A6ScRF+5JHiUm5W
         tfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169410; x=1753774210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nImemBj0j8fFHCvjMkwHMba165ZYb0Bk8vw2Jekgh0=;
        b=RQ6CKpaav+BR7g5eAmihlfxXjd9DoqXNMCGfAW4iiAECa+s2YU7qEcVO3JvlM8s5dM
         NUUEoOKPBInOhggJGhDgnlrMV/r6KbYvPSySkSmJz1gLHnen9+TpXpmrh0hX8XPwfo8J
         KM83tUcrF41m2S/1xKJpWorIK0B8YwW52Oe5pAdi6PKA7SbOXeQtSUzc7FK232WMtTs+
         Z4pesNNJYd+brY/qzJj4taRVxV/pOy20ZF+fVZfmQvuktwDaggomRrfOKbZAQrQVcuNx
         9iJ3I9sLDOMobYl+QihxBGBhqvsOrQyNN68M/OMgSLyOisqfbnWEp2Kr9rAyj4BiCQm/
         jP+w==
X-Gm-Message-State: AOJu0Yxsev8gTHCFI1ukL55nNOGMfOz9z9Twl6oadcaa1trXU2Aqb8qT
	U2nMv8Ra4XRGgLMz6BPddtma+tKCxq8jqQbOk97byBtIVilfLQaKH428GLyLcyKsaGEUb33e8hQ
	i7LWrrvGDrpJf9xtP5WuoXCU9/LqStH4aSY52rPsMPgEu1v7fgJU1VIiF/s8O0V2i6quGzfdZPB
	uOcS3bByrQ1k2qK7Vs0kes0YZ3hVylSHzGAQ==
X-Google-Smtp-Source: AGHT+IH5xwjHFcnT9ZTssnfXE3Q1P32gK3BQqmZs4PrBrGP+O6OvsYUUxIAm+s6cVuFs0g46W4zb2E/D
X-Received: from wmbes26.prod.google.com ([2002:a05:600c:811a:b0:442:f9fc:2a02])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:490c:b0:3a4:d02e:84af
 with SMTP id ffacd0b85a97d-3b60e5531d6mr15630107f8f.58.1753169410298; Tue, 22
 Jul 2025 00:30:10 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:29 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=GtM5Ky3cWjJjWfzB1UFTM+fqdT7qquH5JBfrdp2rkyg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPedt3MCbvLrIrClJuMlGRn2KplntZQi+Z87D3b1OO4X
 NiBKyodpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLmEgz/FA9WuPzLcGyS/bnn
 xoLH/Wvc2RzWcc8/IHH80g7b+9nfbjL8r7t/zONsd+U/J6YtdmYuTUWp2q82zvzzPnnXyaqsIhY mRgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-44-ardb+git@google.com>
Subject: [PATCH v6 20/22] efistub/x86: Remap inittext read-execute when needed
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


