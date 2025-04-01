Return-Path: <linux-kernel+bounces-583536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC1A77C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64817A42AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6502045A2;
	Tue,  1 Apr 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3Ys0OKV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED1202C26
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514476; cv=none; b=EZy+qolSCJbPZeNCmTuC9wLj8ChXmCRccE0t4Fu5NF9X8ObumysWjYEN3DoLOeKRocZI8sn20Tk9YBQNd6dtyHs4UQ7ZwI8Q7IVO4LkhoRoldxSVJIh7cGPhG5XvldzaKxYG+kJ436WlZDi1YwHMLCUux+/H5FMTxMDhkZisbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514476; c=relaxed/simple;
	bh=+jsVXUY+JNWjKDWkdCkg/3wzBjLZu5mOtImMQ3fql1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVs5uKYcdXIBLi/pWKJgBk8zDXcbe/AiYCoLBO/C7oxpA0PWnpm6jFi97Rn/Vti6ioekz6gEZzAbq3APa7GwWJN2oMQwCEl9STq/A5djZasG4iY1KZ9ZdpJRHEKzffRPmnQMxGxqnygAQHQa9jK/Pq0tE14BX0DKzek1q8iLH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3Ys0OKV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so32753995e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514473; x=1744119273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdHYlnm7oCIQrR8yQXWXDs/JGWUxXVNjmYJAO6rvmBw=;
        b=P3Ys0OKVDFQ1j+Mak/eyXxJZN3pgOrYgukznUbGWafaTgdn0fQ0WiSSnJ+kYic7Stv
         gEK/XKWP5LWS9dndmHkNbGIEwHwEJThGRQd3qk13HPJO2atjhQPOb5/FN3/PxT0G68nr
         HqWW9Fwzs1Q4HCHgf/ucKvkJF6t0Lh0a3HK1pT5nbj9o9+B5Gkg6gedm1xb/7yOIrEvg
         YQLB+7NIpc+Sk0NCCUo1abvk4TC8LZomiCNh9yb52nreuCAFQ1YnhsN89uFjnnMVp2iY
         bnp1DgoyZ9VqpNdY9HKXBgmuC9onQ0wE77ILUX0EP8BGTUqOTXalPPfwpmbs0e2bTKcC
         lBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514473; x=1744119273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdHYlnm7oCIQrR8yQXWXDs/JGWUxXVNjmYJAO6rvmBw=;
        b=VuOkn16SENcsY6QwgtEpMMx8uxE3/OnvktOHNXEkerX62PkkV5lYbRtruGiq88/rvV
         nv/jclsZRfRqUyTx/qo+Tax1TK8G5KY4R7crV491TovAZlLUcpb8NT9u4jPnRyr1HuRy
         fQruo6sYJQQekzmxji7vJDMqO6TneD9LvdZOCd5ki46q7k4xeCjd+PfRAKrRvsvCSzdz
         1uCamxD5a+7li1hldrQRVzWS2Jc1xSpt/4zKJQy8VJ1Pnna/0ePZLsXdkUt4fmDDXM/w
         eJdej/s6myhqF9dE/4CsqFg7z9E1enavPCved7adtBZCntKYJidN4L3hIIBjxfEa3EP6
         8Qjw==
X-Gm-Message-State: AOJu0Yzy2VHGT+8EcMoU+XoPpiJMSowu+hsgc3P8UIHDWJ1WLL6mkDfp
	PxRWXZ6U25jJAHk+VytVnS0YPRaucdCWRDmNjZ829DX6lfjNj2wPfvS+1azmEthEEKDowQ==
X-Google-Smtp-Source: AGHT+IG4x3Uac6Y88MEiNOljIjoS9AYRY3yNgjLa2c+ZBfDE53M+PxszbnOClR7HCFEi1qXaEnB2o3tn
X-Received: from wmbjg21.prod.google.com ([2002:a05:600c:a015:b0:43c:f60a:4c59])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e8f:b0:43c:ec4c:25b1
 with SMTP id 5b1f17b1804b1-43db62bbe2amr107359285e9.23.1743514473105; Tue, 01
 Apr 2025 06:34:33 -0700 (PDT)
Date: Tue,  1 Apr 2025 15:34:18 +0200
In-Reply-To: <20250401133416.1436741-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401133416.1436741-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3921; i=ardb@kernel.org;
 h=from:subject; bh=GJdt6JvaRkOjRUstkEclqIh4LycHXHj4RdQlgPesOr0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3166iwvV57Pr1dd6HFzzxazmNikkIP+57Qks7WsI5Xq
 mmCzpc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESMnjP8s/7fKHxHZMuuOMeV
 ya5siWtPzNrNuvd68kbD9dMKF6013Mfw30vUsddv1keFe16/5XnU/vcukHvNEM3SN8G/Nm2ZkUQ JCwA=
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401133416.1436741-9-ardb+git@google.com>
Subject: [RFC PATCH 1/6] x86/boot/compressed: Merge local pgtable.h include
 into asm/boot.h
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Merge the local include "pgtable.h" -which declares the API of the
5-level paging trampoline- into <asm/boot.h> so that its implementation
in la57toggle.S as well as the calling code can be decoupled from the
traditional decompressor.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    |  1 -
 arch/x86/boot/compressed/la57toggle.S |  1 -
 arch/x86/boot/compressed/misc.c       |  1 -
 arch/x86/boot/compressed/pgtable.h    | 18 ------------------
 arch/x86/boot/compressed/pgtable_64.c |  1 -
 arch/x86/include/asm/boot.h           | 10 ++++++++++
 6 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index eafd4f185e77..d9dab940ff62 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -35,7 +35,6 @@
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 #include <asm/trapnr.h>
-#include "pgtable.h"
 
 /*
  * Fix alignment at 16 bytes. Following CONFIG_FUNCTION_ALIGNMENT will result
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/compressed/la57toggle.S
index 9ee002387eb1..370075b4d95b 100644
--- a/arch/x86/boot/compressed/la57toggle.S
+++ b/arch/x86/boot/compressed/la57toggle.S
@@ -5,7 +5,6 @@
 #include <asm/boot.h>
 #include <asm/msr.h>
 #include <asm/processor-flags.h>
-#include "pgtable.h"
 
 /*
  * This is the 32-bit trampoline that will be copied over to low memory. It
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1cdcd4aaf395..94b5991da001 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -14,7 +14,6 @@
 
 #include "misc.h"
 #include "error.h"
-#include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
 #include <asm/bootparam_utils.h>
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
deleted file mode 100644
index 6d595abe06b3..000000000000
--- a/arch/x86/boot/compressed/pgtable.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef BOOT_COMPRESSED_PAGETABLE_H
-#define BOOT_COMPRESSED_PAGETABLE_H
-
-#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
-
-#define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
-
-#ifndef __ASSEMBLER__
-
-extern unsigned long *trampoline_32bit;
-
-extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
-
-extern const u16 trampoline_ljmp_imm_offset;
-
-#endif /* __ASSEMBLER__ */
-#endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index d8c5de40669d..5a6c7a190e5b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -4,7 +4,6 @@
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
-#include "pgtable.h"
 #include "../string.h"
 #include "efi.h"
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3f02ff6d333d..02b23aa78955 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -74,6 +74,11 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
+
+#define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
+#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
+
 #ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
@@ -83,6 +88,11 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
 
 extern struct boot_params *boot_params_ptr;
+extern unsigned long *trampoline_32bit;
+extern const u16 trampoline_ljmp_imm_offset;
+
+void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
+
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
-- 
2.49.0.472.ge94155a9ec-goog


