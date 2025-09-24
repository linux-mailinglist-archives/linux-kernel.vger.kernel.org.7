Return-Path: <linux-kernel+bounces-830826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE21B9AA40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662807ABE48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD4314A73;
	Wed, 24 Sep 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOxNC/8s"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E9313D71
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727655; cv=none; b=VHvhqsGdzYX+5XxR+ze/aReHeTWvuN3JGTpm2TfLwdv0YaJjvTLzrayERxgTTWddRfxS32sF7EJZ0ABbwN69V9p0C/85qhZhUhH4wf0u9bfE+E4jDJHGeN6L7KQvtVuXf0lxdnuh+D5mkh/EJxkiRBUy6ritfqNCVgfm1nPkyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727655; c=relaxed/simple;
	bh=zbwGMZy4p1mf7vELCgM3/lRqm/LcVE69qufBNCRSm3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fRQO3cbtDwDpwvM3kWRZRm3uXcUUVz07FSqu+UbK9HMyf1TTdo4PgiYnqd1kngLdGke4wowqwF4kKHN4ZEuHYxDS78RQQcVEB72zJNKf7jBvSiDrokG/ZiBlHbt45T5T4dGEWvl2pqn/N8jSTk+MbgvlOlfTZAs5ZWJAWGlNjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOxNC/8s; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b2e52494b84so282280766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727651; x=1759332451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hU3NU+EE/1FuOChBH3loy566bJ/0QuhejdT7NEwC48=;
        b=yOxNC/8syehU+1vVwVbW9CK5zcbN+afLUhHOYWjuaXLtI8K8P5vgwb7heNQBblLuja
         y4cmfJNZYd/kcOdnsQdebmUVjO8IhifqxMi2lEJsilWgV0EtLqrwSlX9d5W5HslV5vze
         mjWQoIQ9/hHPiUZyRpjKYeWkUFnKL79Xs2HqoHN0pBwWPkp/s87cpI4vm/4db3nU3i+X
         6iJD7Ni8HVdQhbIa+Ts2u61pHz3yitva9r0bmC8hgEitjJQFqE9hULF3cWqF/h9ZgX39
         7sYPG0PH4AaXqK93U3He49kdFPwomRM0pLrRA9+y8eRUT/rn0STOmOdit6goSHtykQJ3
         64ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727651; x=1759332451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hU3NU+EE/1FuOChBH3loy566bJ/0QuhejdT7NEwC48=;
        b=xHbuQLGT9rl7jI53ylQBAHznUQtV4wp6kHORh7B/mSELLz+joCI2g89lU0YwnXS7NK
         WAaIUemSphg5TIDJ46N92f5tWWoY7xX/W/dwTGo8Jg2h13YJCaYn28vgkb8sJ4SSdGD+
         gDvbNS80dOmBdD3cyhI+RDIpBEmaCw+0TuZkCgV+JJ5I6XXXELUUdTQkcdTwgCF974rj
         vwZRvLj5CyspIta7axI69fz4yr5p1ub2joDLLCtfR7BYznFCZMo5Mawq/1yrpuRTz0qw
         fLWDGQW6qiUSPvl5pIrV7t6n+hadX8hxffbGPFmEiU32Bc+YpSNtbTE4JoDWOGzvNcQK
         YZFA==
X-Gm-Message-State: AOJu0YyvAWPVSkM+7OG0PKV/d4XKS+JrXNAR161JzMXMEMsTVoKJbial
	Dq7pzL18I/B63Mc2z52zy98Ny3bopgYQ8qawNDTPbCSy00JIN3+avxrdfT9eXfGwW8/we/5wtA=
	=
X-Google-Smtp-Source: AGHT+IFZ2iwstoaHBb3YCwWIateYZTWtxaliteUts4ieGmp+JuUAeae4kOh4NCMKe4l2erWoMG1yxlHU
X-Received: from edqs17.prod.google.com ([2002:aa7:d791:0:b0:634:6ced:4ca9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c14c:b0:b33:d2f0:d1b6
 with SMTP id a640c23a62f3a-b34bad21acdmr24393666b.30.1758727651707; Wed, 24
 Sep 2025 08:27:31 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:58 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=ardb@kernel.org;
 h=from:subject; bh=v8PXoWY9U3MlvdKFdHLzUBgWgUos6+58xgUiDJkn3es=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK7/HmaafKmd+mXNZxST4s7RjcunHJj3apO1PvLZ526
 M2RXwpCHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BeAiaQx/eJ3bJMQY1x39Zb7w
 yPJ+pWeGwd6STwtF9yyVPbNWm6ldk+F/iONEzTbRl6sZE1zPWk/XmzFTrIDluco3W+WH3/bPrNn NCgA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-15-ardb+git@google.com>
Subject: [PATCH v4 6/7] arm64/efi: Move uaccess en/disable out of efi_set_pgd()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
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
2.51.0.534.gc79095c0ca-goog


