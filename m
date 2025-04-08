Return-Path: <linux-kernel+bounces-593404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F524A7F8C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8148440161
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A077266B70;
	Tue,  8 Apr 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBYR0D04"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB8266B61
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102411; cv=none; b=pCPcCav/mkIwFRjrMIkSEBqXTWx7njhn2ZNEnfcp/CoezTEi5J2GSsHq59H5uPG2UkqEIT2VrdmIuPQ/NH7v9USEruZK1hOnRx8PIfiKs/tvniNtV6HEsBXCUYs8e/1U8y6EziVf2uuv6co0TFhnjydIFCBsVUjA1vUMD6q+1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102411; c=relaxed/simple;
	bh=rGZMX0G8lRLt0dY4UTfyPAeFNjieLVMC1P9MjIC1z4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NLLi9zV2Ay4Dmajobx/Reoeua91j9y/L7FHfuRkJ+FAbrGqEmgMtVps09MztvHvZ1n67Gv85vS5mIoO7qBoikyfV7VnuGdHS7hVtEZm1Iurstw9drcBlN6JDwFLY/9eWcBwDMxjtIpiB1Sf/Q4dB97Rff+nCy3AdqXtZaIYtjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBYR0D04; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2160765f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102408; x=1744707208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut3DF7cdGnYGcsB+1y8GBrdozOKwjcN3MDn2MzZHkLM=;
        b=lBYR0D04NgiJ0QS+0Ffa5Ok/udk+5iT1U844uIBGP1Co7Pon44j9jqtBX33p7XrQTr
         /9KD0GnorE8R0dXfmbq1tp6LDgmyikgs2bEEYj357Th1H78mwdWrHOPVVM29MAejWLto
         CVflXJhInonSyz75MgTzMOaOOMEmVeysx39waMI/oeDFlZaCFrUhZ+4xx4QrCWzsf8yO
         Bsma0Dbpt8+AaeSvzMW7OvBkKTn2deo7Qz6qaMV/CbHFTcI8K1NlxivrMekGpMY3Lmui
         sEIRTdXkZajI6xslHRUq3WgGOzPpchpxWBvBWG5w/wQPi+rGL4358fhHoZO74AicJC11
         7KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102408; x=1744707208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut3DF7cdGnYGcsB+1y8GBrdozOKwjcN3MDn2MzZHkLM=;
        b=Xc5Mc8SqU9h2eETBSM3hRONvKFzFWSldfiO916zzk3tIQoc22ZusjSChS/ccUxNibU
         gGgDoYuDJyi3oHGtGqwMhrVQyMWQDpM/t0zX8ar03T7O2lMpTllNwCzc50O2g38LqNr1
         1iPgfrcNSUaF71EWfc03stOpHBhMBmVPESs5pM4NNaQBksS9ZG26xfMCwETpNPHagFAj
         tJFopu3V4PBp2MGL+XVNPHr44gw3Bw2xmUv/WoCW1ya0bfsPPYsRbFg+9yR1J/dd93aY
         SsDDokYbyEgWaA3igOWle2gIbx+Ertkv3yv1SE9ibtajNLPRp8M4OdDK73UW97xaMPKa
         mWUw==
X-Forwarded-Encrypted: i=1; AJvYcCVdCnOxbwIpwpZfFMRPN5RFyinOUrorNMqQcSub3qSb2nRrjWIYDgtyNUhGyDHpsYSzY5jKoBDMMhoBjHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIusQRDXWEYyFUVggDPaHYJbRwrJvcbPADkhN9huvHW4oD/kP3
	0g8QBejkhZM0ul10rr6X2MUBYONhoiY71Ah0IjCBB3+gaY9nMHePcu7pUHFyeuMu4s92FA==
X-Google-Smtp-Source: AGHT+IGW/r/Kx/mn/IWLI6XXqQKCxtQJ+RSUOZT/+LuyEv9kOyZw0WzMpRZxWL1WPU2nH+qiHEBf4YWJ
X-Received: from wmgg3.prod.google.com ([2002:a05:600d:3:b0:43c:ef1f:48d3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1acf:b0:39c:1f10:c736
 with SMTP id ffacd0b85a97d-39d0de5dfbcmr12437841f8f.43.1744102407776; Tue, 08
 Apr 2025 01:53:27 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:53:01 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139; i=ardb@kernel.org;
 h=from:subject; bh=1OMnBnM3B5uy1EYv4XyX2QqLee71wb5xFGUqQq+IsUU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L4w/OGbPcrtRWK6vreq9/v/qVwNrPZTvlmqZlHNugf
 eatcw5DRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI4yyG/2Xrmu7sn3La/LKs
 Y/z/Ce7yXurMa49OqQ9/mRB9pcGfaQsjw/ZOYV/mS0xfLqzfEaJy8F17rmLA9YkMmjn2mcLbBL5 acAEA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-15-ardb+git@google.com>
Subject: [PATCH v3 6/7] x86/boot: Move early SME init code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the SME initialization code, which runs from the 1:1 mapping of
memory as it operates on the kernel virtual mapping, into the new
sub-directory arch/x86/boot/startup/ where all startup code will reside
that needs to tolerate executing from the 1:1 mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile                             | 1 +
 arch/x86/{mm/mem_encrypt_identity.c => boot/startup/sme.c} | 2 --
 arch/x86/mm/Makefile                                       | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 10319aee666b..ccdfc42a4d59 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,6 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/boot/startup/sme.c
similarity index 99%
rename from arch/x86/mm/mem_encrypt_identity.c
rename to arch/x86/boot/startup/sme.c
index e7fb3779b35f..23d10cda5b58 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/boot/startup/sme.c
@@ -45,8 +45,6 @@
 #include <asm/coco.h>
 #include <asm/sev.h>
 
-#include "mm_internal.h"
-
 #define PGD_FLAGS		_KERNPG_TABLE_NOENC
 #define P4D_FLAGS		_KERNPG_TABLE_NOENC
 #define PUD_FLAGS		_KERNPG_TABLE_NOENC
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5be5a0..3faa60f13a61 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -3,12 +3,10 @@
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
-KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_pgprot.o		:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -16,12 +14,10 @@ KASAN_SANITIZE_pgprot.o		:= n
 KCSAN_SANITIZE := n
 # Avoid recursion by not calling KMSAN hooks for CEA code.
 KMSAN_SANITIZE_cpu_entry_area.o := n
-KMSAN_SANITIZE_mem_encrypt_identity.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
-CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 CFLAGS_REMOVE_pgprot.o			= -pg
 endif
 
@@ -32,7 +28,6 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(src)/../include/asm/trace
 
@@ -63,5 +58,4 @@ obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
-- 
2.49.0.504.g3bcea36a83-goog


