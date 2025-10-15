Return-Path: <linux-kernel+bounces-855285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F50BE0BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111D34046F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035EC2FF67A;
	Wed, 15 Oct 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Alh6XGsl"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B07494
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562068; cv=none; b=NBWZSB7DXazw+boZXakYG5x6Np/MjUEonF7fDd+5cDkMARh4cQIG+UV/l9mHKpnBcZRZ6QNFJvXGYD3f8VwkCW24BYNG1KNj+QUoe16CPWfduN3zSRq/0fxbageFXw6jzLyZduZr9hT74O5N88sfBX9vg3X1kQ1uccU0FJiPkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562068; c=relaxed/simple;
	bh=pgc/OWqzPdhZ+ZByHmG0zKs5YUD6w7p8tgTZ4qv9RYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bu0A+f6SZLIqyvxbPtr92I5bg2n0k98uzgbc+pMajIDXLnVQRtl/eh37T7MZ/yQBbBLh3H4OsgeiTsTah76EpV18alTaSzibCWVAkGbpv7c9SvfNXqwRk2wJdZSjIllY1J0XX5PRSkuAhk+smDw7RZq8Ta8kNWfZCpkQAXHRndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Alh6XGsl; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-63bf373ede2so1280648a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562064; x=1761166864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD0cTRsfkQ0iON4YZtzctxecoLUwl3UhcnKx4hSqyjw=;
        b=Alh6XGslOoaDHLgHMozKhflIJuySiD2Ps3HMUrycl+vPsV7kKs0wodskKQWhpT7thW
         yH6K4ZRHtApemQfJh25HV4lCCQmco/foXE6pq8lYD2KBkl/VbEg8MpOdIafO1jiVuC+u
         BKpCJ+aA9oMVT+8Vwsllw++SkN00Pe29AioPq2zn69rNzXhEfG0oLGJwRWwUsXWan++q
         bvcbHX3CrJNYl0+w3LrFkxY0bpQJXrEDuNNhrZL8XVta/vYpmRd/kY5vFt1ihm1wfJ+n
         zyjpmAOo1VbTdoOwp5Qm7SiDYmMwoXHHwwl2mbJzgFKbl0UPRtELhdHgTMNVOiv/UKfb
         HiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562064; x=1761166864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD0cTRsfkQ0iON4YZtzctxecoLUwl3UhcnKx4hSqyjw=;
        b=RXxT28x4e70ZyITbHik5F5K7+y9gkgPhhHLyIznZgUZ+eyXv3YNtf+MI1e4vRgGzh0
         cEp3MW3a7AhGgW2a1gAY0aryDLyKlAdT0ibjFVNIL28yRxsqrB+e5FwSh1TUTgydcQrD
         f27pIJNS7WX3n0UInUwQZ11vT7kOBH65GV5ULpFM0kTfV2pcS6IRTKgGodUInvDB+hg4
         SG8X1OwNkZUNNwRd6oQmoHtHsPb6ylxjFQfMQL6Knz/fKa17VtSguN98cuGgJUlnFJIz
         92cVZ7O7t8IO8TopFRM1ogVtsPoDbr93IzuwbS/wn5OXvmffH8tuEmmX8MmAEybV+qPb
         djkw==
X-Gm-Message-State: AOJu0YxIZdcSsZ8NMl0NfODQKsQ4n8/LnuXBdghPwReImht0qMn4J5Ec
	wSxbSEOZgunP5jt6pJRD92BtAet9pODQooZLrMrHHOAmm5r6ytY08NCI/HifNMsV/3HH1bszaA=
	=
X-Google-Smtp-Source: AGHT+IHxb8mJwoK5rKnOiIInhvJ4q4VZQJ2QCiVbFL8msAiqQJ16/urDJrNLJku05vTcxZXu/6n/DgR7
X-Received: from edcy14.prod.google.com ([2002:a05:6402:358e:b0:63b:dac2:1b06])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:518b:b0:62f:4915:bc47
 with SMTP id 4fb4d7f45d1cf-639d5b41857mr27245561a12.1.1760562063741; Wed, 15
 Oct 2025 14:01:03 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:37 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615; i=ardb@kernel.org;
 h=from:subject; bh=gYpYJdboczLvZzwBAFCsuy/KXaHSzTBHbFoWrECa7Dw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV1t9cQbj1TMnuX+/1C4+c5tFuobh62Xpm2btO7vfz
 Zmmm+DdUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbCv4aR4aJToYvt8st5Th+S
 nGolgoNnim0RWpP6ZF5fzOmdUoJ1ZowMixcI9ekxzvwTNP3mXMnfTRcy2o4za+5b3DPl4V3pA5f D2AE=
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-11-ardb+git@google.com>
Subject: [PATCH v4 resend 2/7] efi/runtime-wrappers: Keep track of the
 efi_runtime_lock owner
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI runtime wrappers use a file local semaphore to serialize access
to the EFI runtime services. This means that any calls to the arch
wrappers around the runtime services will also be serialized, removing
the need for redundant locking.

For robustness, add a facility that allows those arch wrappers to assert
that the semaphore was taken by the current task.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 17 ++++++++++++++++-
 include/linux/efi.h                     |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 708b777857d3..da8d29621644 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -202,6 +202,8 @@ void efi_call_virt_check_flags(unsigned long flags, const void *caller)
  */
 static DEFINE_SEMAPHORE(efi_runtime_lock, 1);
 
+static struct task_struct *efi_runtime_lock_owner;
+
 /*
  * Expose the EFI runtime lock to the UV platform
  */
@@ -219,6 +221,8 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 	efi_status_t status = EFI_NOT_FOUND;
 	unsigned long flags;
 
+	efi_runtime_lock_owner = current;
+
 	arch_efi_call_virt_setup();
 	flags = efi_call_virt_save_flags();
 
@@ -310,6 +314,7 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 
 	efi_rts_work.status = status;
 	complete(&efi_rts_work.efi_rts_comp);
+	efi_runtime_lock_owner = NULL;
 }
 
 static efi_status_t __efi_queue_work(enum efi_rts_ids id,
@@ -444,8 +449,10 @@ virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
+	efi_runtime_lock_owner = current;
 	status = efi_call_virt_pointer(efi.runtime, set_variable, name, vendor,
 				       attr, data_size, data);
+	efi_runtime_lock_owner = NULL;
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -481,9 +488,11 @@ virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
+	efi_runtime_lock_owner = current;
 	status = efi_call_virt_pointer(efi.runtime, query_variable_info, attr,
 				       storage_space, remaining_space,
 				       max_variable_size);
+	efi_runtime_lock_owner = NULL;
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -509,12 +518,13 @@ virt_efi_reset_system(int reset_type, efi_status_t status,
 		return;
 	}
 
+	efi_runtime_lock_owner = current;
 	arch_efi_call_virt_setup();
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	arch_efi_call_virt(efi.runtime, reset_system, reset_type, status,
 			   data_size, data);
 	arch_efi_call_virt_teardown();
-
+	efi_runtime_lock_owner = NULL;
 	up(&efi_runtime_lock);
 }
 
@@ -587,3 +597,8 @@ efi_call_acpi_prm_handler(efi_status_t (__efiapi *handler_addr)(u64, void *),
 }
 
 #endif
+
+void efi_runtime_assert_lock_held(void)
+{
+	WARN_ON(efi_runtime_lock_owner != current);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa..b23ff8b83219 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1126,6 +1126,8 @@ static inline bool efi_runtime_disabled(void) { return true; }
 extern void efi_call_virt_check_flags(unsigned long flags, const void *caller);
 extern unsigned long efi_call_virt_save_flags(void);
 
+void efi_runtime_assert_lock_held(void);
+
 enum efi_secureboot_mode {
 	efi_secureboot_mode_unset,
 	efi_secureboot_mode_unknown,
-- 
2.51.0.869.ge66316f041-goog


