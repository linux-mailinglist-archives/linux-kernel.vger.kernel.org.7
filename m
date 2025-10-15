Return-Path: <linux-kernel+bounces-855289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31690BE0BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 893F7358353
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B48304BC3;
	Wed, 15 Oct 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdniQ+/A"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA853016EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562071; cv=none; b=cFIgbF1HrXEl5AjPgCGSecXpvRLYb0Vdrz3q5Av4WYshEusEKkaBEszXT6mnvUhijbiTWofBNysym1ZbhfdmXo0XAfyaA7BgsPiOaHHABT3Sfv2Wky1kQcF9EOjLwsAOunjXaWN7agytD+z4/dV6ef5PjGVqBXFV74A8eyXd9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562071; c=relaxed/simple;
	bh=5L4b1rIUXgU5wl8/jKyJxd4Vt1myFkIrr70lbjcEQg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/uq9Mlk4kqP5/FalyIHPtFZjXlIpOcxpTfof/KJxYs1onYflu1mg+YN1VpVF6Lu7AJ8uFlUBJyrSTCDwhbhjsVyPwQGQBK3JAH57eK520FYVlnpo9nciewQsfzWve+wUoQUskZ5SQhMDa/CyM9F2kY25nHzf7GA0zxg+Llsy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdniQ+/A; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b5b12e9e02eso567866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562068; x=1761166868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtXilHA5AAd1z6GdE3uGsC51Fo0T6TRa6MXgCog/xSk=;
        b=sdniQ+/AIrpNRxg4X/oiZktkjCV3G90M3L9OyRP2IMnm/D65G7fT2/EgGbPJ4UmtRc
         qnWBQ3LO6t+KGMvmXxIZk4Np1xVunWDMnfx8pfSbuH1poz8Ac1yMhwgVJKYKszveu42K
         +J95u90cw4ufhCDW3wNoSh3Q6cAoSGkl72a8W9kj4r4FY+TGsWdTX2LDAzY09DbDt3MM
         iaJ8o9gPYlcx5bsFT9XcIJxtt4Xxjnp9hJvU2cuzbjad7081FFzd+iXBpvsbucWKOPUU
         aYMvzyQAJ4FXsF+z2ZgryrjQrLcyGhEaBWZ/Qxzz9aNqZJX0ZFbeABJecbxY8+oqN0sB
         HMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562068; x=1761166868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtXilHA5AAd1z6GdE3uGsC51Fo0T6TRa6MXgCog/xSk=;
        b=cOYO78WaRhKhtrgsIErYnVbQtsx1b/yrMmeFfnV7LzDGNZpF/dnVvQ/xVCOjGZSnFy
         zVOs+1PRF8k5BD6qY417z39pc0/kB66EQUx6kPmJkpJG0cGnfKtnalxhNbTPozHfRFzS
         ICiac2CEYwRWAlRyOy4lpzmn7FxOiqcxUjbUS8ZTPZjY8L0/wbHl6DersZ8MnzxZ1u0A
         Aptpru6s9JoZL0uUI1X4zhY8cRWn+qqm6FI+B2nBDSZnrZUtWRDnThhG+KJots3Fdgzs
         VoYFQQcBdzuSboZVcXvakKXIpRnObXd+TwG0DmA7oPnjKfJu2rTu++BVrqjWuWocBPfT
         zP+Q==
X-Gm-Message-State: AOJu0YyINLYhIuXOSqkNfj39BxWe0m3RXp6OnMC2N9bACPqfG5y+WKWM
	NVUGnlMNSdBI8F1JiedS+uTQURbl6kLs4/fojiVbC+poyNdojhqyXhONuGTtZxQn9vG7h9fSmw=
	=
X-Google-Smtp-Source: AGHT+IH3ROeCSpPWS9y2jZ7CvrP8/bWnx+s6dPg9rJBua5mdk6FXYUzuc6+UiuwI+/nVZ3rpHBAA+hiX
X-Received: from ejblo1.prod.google.com ([2002:a17:906:fa01:b0:b47:89a2:8c6c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:980f:b0:b45:420c:81c0
 with SMTP id a640c23a62f3a-b50ac0cc34cmr3303674866b.36.1760562068221; Wed, 15
 Oct 2025 14:01:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:41 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=ardb@kernel.org;
 h=from:subject; bh=997YokF8smvlH2+7Du/063cegE+dHugAIUP6dU3Aa2s=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDVzdTg/stWY4eySNf39jeOrDI2WBiyytOz6jjvWbRV
 x/v0FjRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaSeZKR4apV4b0pL78sZ598
 LzA4+I6BwcnoBUdSut9MUZh7iKesm5Phv0fEh9RthhFMgprc7NoZL8o/mqhbhr2MTOZkDl/GnKb KCgA=
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-15-ardb+git@google.com>
Subject: [PATCH v4 resend 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

efi_set_pgd() will no longer be called when invoking EFI runtime
services via the efi_rts_wq work queue, but the uaccess en/disable are
still needed when using PAN emulation using TTBR0 switching. So move
these into the callers.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h | 13 +++----------
 arch/arm64/kernel/efi.c      | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index bcd5622aa096..aa91165ca140 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -126,21 +126,14 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 		if (mm != current->active_mm) {
 			/*
 			 * Update the current thread's saved ttbr0 since it is
-			 * restored as part of a return from exception. Enable
-			 * access to the valid TTBR0_EL1 and invoke the errata
-			 * workaround directly since there is no return from
-			 * exception when invoking the EFI run-time services.
+			 * restored as part of a return from exception.
 			 */
 			update_saved_ttbr0(current, mm);
-			uaccess_ttbr0_enable();
-			post_ttbr_update_workaround();
 		} else {
 			/*
-			 * Defer the switch to the current thread's TTBR0_EL1
-			 * until uaccess_enable(). Restore the current
-			 * thread's saved ttbr0 corresponding to its active_mm
+			 * Restore the current thread's saved ttbr0
+			 * corresponding to its active_mm
 			 */
-			uaccess_ttbr0_disable();
 			update_saved_ttbr0(current, current->active_mm);
 		}
 	}
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 0094f5938ba6..85f65d5c863c 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -169,12 +169,30 @@ void arch_efi_call_virt_setup(void)
 {
 	efi_runtime_assert_lock_held();
 	efi_virtmap_load();
+
+	/*
+	 * Enable access to the valid TTBR0_EL1 and invoke the errata
+	 * workaround directly since there is no return from exception when
+	 * invoking the EFI run-time services.
+	 */
+	uaccess_ttbr0_enable();
+	post_ttbr_update_workaround();
+
 	__efi_fpsimd_begin();
 }
 
 void arch_efi_call_virt_teardown(void)
 {
 	__efi_fpsimd_end();
+
+	/*
+	 * Defer the switch to the current thread's TTBR0_EL1 until
+	 * uaccess_enable(). Do so before efi_virtmap_unload() updates the
+	 * saved TTBR0 value, so the userland page tables are not activated
+	 * inadvertently over the back of an exception.
+	 */
+	uaccess_ttbr0_disable();
+
 	efi_virtmap_unload();
 }
 
-- 
2.51.0.869.ge66316f041-goog


