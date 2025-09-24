Return-Path: <linux-kernel+bounces-830822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF3B9AA70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5D9321FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98C3115A5;
	Wed, 24 Sep 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vedGRp+/"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F730F942
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727650; cv=none; b=qpdhNmJlUTmyx0Xakog+e8wyAkl1VF1GU8CsdVUEk4LrWNBlcBUA4l97Qg0MNaLaFfLqvsF/416fy6lEoMlrN57R7qOgN3XXHwGB0/EioVYb4EP1imY7hWCvjqeM6uH9xtHyzfnZT1soBOIfrHIJHLgU2x7b8SMbdQ8elx1Lzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727650; c=relaxed/simple;
	bh=OTmZKIoJyIGsumN5ugsnvmysw0VVRiK+YedircHdIAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jTBp/CBtbYvzNvvf1Jp1eNGH9iuO0a8B2266+oMDaH/o3uKVByKBHLqO+xAwGYERT/BOi+U6lIy4vzeWXHkxIKSWAFUiihspUsBY3pwtXw1+0zTo7TM/KWPVp3klf2zKgYN12LvtulcvtS9B/m8CiWm/MH0Gry867hisKwD2D4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vedGRp+/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso2157509f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727647; x=1759332447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwWjpBWZcTXGym3noF7gHRJl5W2piBLt0KG+y6l3/bo=;
        b=vedGRp+/t4T+JOn6EhXSMg8ZzNOmO21xuIAC3TNhfaXUbAyxOYlS7gfMyo0Gh9SKd3
         YodzEZD5zDJVnyGnrpDqslAnr5+8bFYPXq2n9n5pUnd+xTijONM5JJgAW5PN3wuaYnVP
         /i9KHoINQa3JIht7UA6m6T3tIVednhmMbiPwogW6uwmUON4BF0MGsdcQJLYGrHOwAiTM
         Ddr+XfDgDrwajXUQpCnupmvlm5l6pmFgdElPux9Tea8427Q1kFc46YVHfvacgv8Ixeq/
         dqVzqznq6JNtoNSODq3ocv3qIQZaasGz2rZlj1EA1iF3/nOZ0bA7vKrgipq8/QKg6Nnj
         V1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727647; x=1759332447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwWjpBWZcTXGym3noF7gHRJl5W2piBLt0KG+y6l3/bo=;
        b=kQTlTKdXwEIj22JjxZT+HGws6KhjAaWR1bDy9TdmBbMWkZQItHVfCf6PlzHGbQe3Ef
         po/kqKmJycRryaM3dbLVXmrW2X93tJy/vgRYqfDlxAMEuXNLUFJEyQgI+lRqIPq9plh4
         0uZHFJIZKptdE7E8ziEbc/eQEvCzu1k26rE1/cMbZXaiZ3ol2ckVauxmKBNc7MdYQGp+
         fLkpxcQu/UPx6H1tT/IMPal1i385y04hqTa7hRqMtmRxsh6kxX9arFHl3Muj6YEj62Db
         pP23LOtGvO4dCpjo/PQFHaehWv4HR/Z3krEYlrasZYqN5ksR8x03eY0QwX4SjAuhWNUv
         fR7Q==
X-Gm-Message-State: AOJu0YwUuHGLu1ZAqlsf1tfdpCYUdpGrl424L2TnU0XbCy8dLX6/N23y
	1kt4Gwa56ciRz/AH8L+ecSMZwzCGUjro8ygYjlG3MuTIQ9rRm7OK4xfWgjc0nqPF0bPQWHBXew=
	=
X-Google-Smtp-Source: AGHT+IHGECinJiUKwmBsi2i5BTL/1XrbB4XlOrXgcycBFFmPNfL7f9tj5b7kh5fqUrWtiXSAzRu4Fzs/
X-Received: from wmqe18.prod.google.com ([2002:a05:600c:4e52:b0:46d:e5bd:371f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:290c:b0:406:87ba:99a3
 with SMTP id ffacd0b85a97d-40e4ece583amr246427f8f.30.1758727647232; Wed, 24
 Sep 2025 08:27:27 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:54 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615; i=ardb@kernel.org;
 h=from:subject; bh=/a2nMupg28rYcZeL2r8+05MdHmb6xlpT3ZB1lHKuOFY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK7wGW9nWOU/SWMWa5sy8KmnlCS0r+vlOl0ZF2Qeb6z
 b5uq293lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkcZGBkmGdv6Z/kzxv/8rjk
 7oifV7r3lF7pMahmvnru29nw3lun/BgZFpQv6Nu6YoZp9KOJ7Mos3D0adiHflhsI/Dm+f9PKZF4 ffgA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-11-ardb+git@google.com>
Subject: [PATCH v4 2/7] efi/runtime-wrappers: Keep track of the
 efi_runtime_lock owner
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
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
2.51.0.534.gc79095c0ca-goog


