Return-Path: <linux-kernel+bounces-607694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50990A9097E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B6F7A7A04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCC217736;
	Wed, 16 Apr 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sppd8vZ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD6217663
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822691; cv=none; b=OEVZn+qvjGTwk2LppPYYMbS76hFFiug4B5HHVaD5Idv9YFjbSeVoO6cAczpNgxG3ZrKcEr8sn5NN9ZZEJr0v/ccSDWncdxD2ClrH3S/+VeQt4XIGc8mgIsDphIVWy7RM2XdWYAlQXOJKd+aM8kEVpfpFeH6v6x7g+Lcj70kXpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822691; c=relaxed/simple;
	bh=XBtyQHzEjNNgjgTe/YKXlSvf7rqCznV9aavmpW/Wb6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGsF8phGJT/AkcZTcD6au0ys58bBAxP62KrD4/WFkzgAF2048vZhbakSJJjOMd2gpczSfySN9ggAS4zA1gDNhCwufjkdhdL92m4smOdKjSFAKY4ZGzGT0EW19+QNysIpTnhk8RoG1V7PKaTKBJ+5A+bx0u+7nrXIHIJ+tDqQHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sppd8vZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cec217977so41817545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744822688; x=1745427488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnocHU1mfccFDedSoFZAIkdUs0QWEX0U3+1AYetVeiI=;
        b=1sppd8vZQuzWrmvn3nt85kx1a8OdOFmXcL1W7Sd7g9jZbwRP7/x9h9MlzybonQVl37
         X2kByUNAViUL5dZFEc1PwxIZut6YaxpilddRYpEqv+dOUZy8l1xyNUf6M/7vU2m1xclB
         WiUekdrOyxMsoqXfS+gZHiDbdQSnia0aw4ClF6ppNrc87YOzQs5w0O7kh/Am4IdbR1Mq
         Za7C0Gw9aQH1Up5dMg4T98FWTJLnNWbg4T3cMg3mWmaSdSJkBU8HBELbJX2hQ3uPoMqb
         5vQhPU7WpkpsAVpKForMMcNzHyu6KoioVFKsUMhz6e6BJ2xWz5KgrI9CrlNkFIJkqZyG
         /9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822688; x=1745427488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnocHU1mfccFDedSoFZAIkdUs0QWEX0U3+1AYetVeiI=;
        b=chFifKOTpoS54THyAdvUKANVQ+EBZuFRlwtqLm8afPc0wOwcwMe21QbelAYglmoxDA
         ztvHNYZM1jV1j+qaPFUvg90XnHOU+NWvHcdKFPb0/aXCgPvgX20w+btFAGJMf9aOGGZJ
         SUnY+24xK+cHQJdVYHPBSxOP9DcMHxkOZeuFNVcRTlCTBZHZAV2mEC/sox7jb0P/Fyv1
         qjoZHxppwkr/Thoy+qPR2ML00fX22JaagWfjf8zGUhSWMtq6KA4+fs3wo7GcoSc/Ac1j
         q9DvLQSTRYY+/tZFJ4oxrnc3Pm/W66AWzXB3ss2hXEi7C59PDBgeGn6tUAnQr++wIuFC
         vpTA==
X-Forwarded-Encrypted: i=1; AJvYcCUEdtMKFYFJALGxpsKk5YiDrHe9fMN/yp9x0U3jN4HeBmY1E6xZBAbKVhnyIZfSmaARrEGfGty9/LCYa8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwudyJZ4uT/CI5FmwgiA3F6Pjwj4SOOUllq2w0FG+jj7Ul4KoII
	p1MGpAE2qArnNkJcg4SoXGLd7hF7z+APZaKwvL2z3F8U9kwj3NdTzxGX/ZSbpIdHZIvr3w==
X-Google-Smtp-Source: AGHT+IHDioEa0asrZ6ktU/OURO4/16oUCUp0FKLWlZ90m8fNpNQzxk3VCdHZXCpqHBL07mSKMbNi7FOR
X-Received: from wmbg21.prod.google.com ([2002:a05:600c:a415:b0:43d:1f28:b8bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64c8:0:b0:391:43cb:43fa
 with SMTP id ffacd0b85a97d-39ee5badbdemr2741778f8f.51.1744822688464; Wed, 16
 Apr 2025 09:58:08 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:57:48 +0200
In-Reply-To: <20250416165743.4080995-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416165743.4080995-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=ardb@kernel.org;
 h=from:subject; bh=rtVhNZoNBTlEaY8pB6Ac8e2FfcEyp0oDiXBE2BvNGnU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3/w17N3x0v3PYc+yD95L9E/l2/F7cjXzz+afd1nsbJR
 K0Pv+b1dJSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICLpDH8ZmEsPj3jjWjTgsRL
 +hXdz02sSrbVyyaZLCxX5vs7zczVgpFh5p2lfRf3hPO/vj3j71OtPZcnczp2aC4MdvufLLUvYms LBwA=
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416165743.4080995-10-ardb+git@google.com>
Subject: [PATCH v2 4/4] x86/efistub: Don't bother enabling SEV in the EFI stub
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
even setting up the kernel page tables.

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


