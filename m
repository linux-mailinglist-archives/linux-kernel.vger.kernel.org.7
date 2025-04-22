Return-Path: <linux-kernel+bounces-614035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5335A96573
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DAD3AEAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639D214A93;
	Tue, 22 Apr 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiTYFkJn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DB20B803
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316477; cv=none; b=ViwPOaS7Rz/7YOXYhQAasaEQChy4jMiQvwZkIo/IF2J+3Xv1rM0UpccPtktFKUbw1PSdKMkt5DRXxJtgVFmXWVL8X7MM4EZ1G1CWgJDLbGQbaYpQU+6eDrX0zUUEUJZ3N54cr7cNz1pEv6n7YbG7dwRJRoxLFwasxzq9IWVosks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316477; c=relaxed/simple;
	bh=OZC01qFvs+z6NnFJ35K2gqqtQjNtdb1vBdWCiuPeZkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZqN+vbExAvb7r12DWP2bg5cnh7q6mf3cIlzUU/8nBwDY10LgyJUj3EvHqvkcA17d/0F8uD2amRgpXWCCO7w2r54X9JyXGs4/3SbmhPiozJkPN98OZGhderFhI3zy2zrGCBj64+APqgP9aKyoQvyPoZgXsmRWsgNwCE/RL4rVgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiTYFkJn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so28497575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745316474; x=1745921274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws8tmZmzNzitVKHYH495oHPaAWftQig6IJtfdT6v6zc=;
        b=OiTYFkJnZT3qAnomg1JPhYYRp99s0TMS9b3wy64HJRj4zeyV8eFhQk3oX/N0kzer5z
         1erOBc1iM8hq/fvFhTo2gIVdjCyuRE/S/vabWgwKll+XJApS7tDrRMJLvFLffWH8mem5
         Ruag/3VJX/cRoPbkzRdb6dm/suEK4sAgBoK6qK5/P7fukA0mFjlljI6XsjIfhxnltArW
         OcKLf8z69xQqygjndlYPbvAg9/dm5BJah5JRT3kVy83l0l9ePNu5DrNhz5lMjSQ3O0mv
         KD+yGn8CACD7QvE3/oBVpvDp5xjzVinYqJTuW03BeCbE2KKtsEFGWUI/AH70NM3rgLok
         D+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316474; x=1745921274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws8tmZmzNzitVKHYH495oHPaAWftQig6IJtfdT6v6zc=;
        b=pts5rRqUQ1QZgJkNuZUcUmGMwKpBzXjtzTrrf3dcPqgMwYxGKp/4zmQGVdYNFx03SL
         xPfDV02r4rLLYH56L7KA2uLCK6LnrJnECHLANreRjn/nVEVSKn3GMxQjxqXxgaLhuZIt
         gvK6GNlAFoui94iuaeyxIqKU/70CPCGStrO7T45o63nieKlTXlVZD2yaGNPNtu0ZXJU5
         kSIY6MFPaDC7FnzV6Yh8G9GMiGp/JjQZHd+i5nJkghVXw62HuZPVlxim5k/vaXJv6SHx
         FIC9DO04aSHutsUBsKpgg7u7vHNcl9xtgasGUQUepUYp6IC11iWasMOp7zGQ80+8RFXy
         wfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0wE1D8QxIiJBODxy7Wsf/LrOnpxf2u0EgHzr73kNfpagSezoCIX13euwjakwY4JhVTSYKj3HuK6f2R5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbLtvgoF1rgtrhQLsmQwEp5b6KYdJkVk1xo6Cmld0+5UihNa4
	R4BVZKlvCImk++XTQsGh58AUS1HNa8qr+zMK1Mz9wL8HPmV1UEAcDP4794LsMcBVZ9wzbA==
X-Google-Smtp-Source: AGHT+IEsttKPc+1+pKNp7wkrPzKN6VR701tpMP/CW7FNllIuNswL8vMW3YW3zCuV2chYoM5R1a48fkwQ
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:440:5d62:5112])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6da1:0:b0:39e:e259:91fd
 with SMTP id ffacd0b85a97d-39efba3cbbbmr12965416f8f.17.1745316473972; Tue, 22
 Apr 2025 03:07:53 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:07:34 +0200
In-Reply-To: <20250422100728.208479-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=ardb@kernel.org;
 h=from:subject; bh=KbofsdXhZq5FJV6/iTzACT581EDT107l3QmYOrFF/SU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYM9K6tdQlZX18VTVZD5U4KU+89rsWY8U8+8cj5x9dXax
 Y7e55Z1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm8d2X4w6cs5zrZdvuntbLL
 jbva9n5p2Lr01SahS4en9lo+iXvOuIiR4bbH9LYNztfO6tovfTOl8EL2qv4wO42sWWeSXq16Ira siRkA
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250422100728.208479-12-ardb+git@google.com>
Subject: [PATCH v3 5/5] x86/efistub: Don't bother enabling SEV in the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the last things the EFI stub does before handing over to the core
kernel when booting as a SEV guest is enabling SEV, even though this is
mostly redundant: one of the first things the core kernel does is
calling sme_enable(), after setting up the early GDT and IDT but before
even setting up the kernel page tables. sme_enable() performs the same
SEV-SNP initialization that the decompressor performs in sev_enable().

So let's just drop this call to sev_enable(), and rely on the core
kernel to initiaize SEV correctly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sev.h              | 2 --
 drivers/firmware/efi/libstub/x86-stub.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 8637a65973ef..d762cc0fd47e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -443,7 +443,6 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
-extern void sev_enable(struct boot_params *bp);
 
 /*
  * RMPADJUST modifies the RMP permissions of a page of a lesser-
@@ -531,7 +530,6 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
-static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d9ae1a230d39..6b4f5ac91e7f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -936,12 +936,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	/*
-	 * Call the SEV init code while still running with the firmware's
-	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-	 */
-	sev_enable(boot_params);
-
 	efi_5level_switch();
 
 	enter_kernel(kernel_entry, boot_params);
-- 
2.49.0.805.g082f7c87e0-goog


