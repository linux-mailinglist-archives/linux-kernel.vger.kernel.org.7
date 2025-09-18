Return-Path: <linux-kernel+bounces-822550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F3B841DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8317B1C8274B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C91302CD7;
	Thu, 18 Sep 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdK8EDVX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496482FB0BF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191441; cv=none; b=QjUUARG+zmVauV/DD6/D6hnRJ/2rFvVcmTsY6NGHfj7uvqbNcBPfIpd5gUNqTHk5KEVY4r2ENe32lqsIXP8JV4BPlqlNRljFePL+iz5KUcEOYr1sybqqaIATCWBWhxFYyB+sKnmdKV/HXuFL4378TsZ06T11pqVZ+bFAjYLYhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191441; c=relaxed/simple;
	bh=DW2Ev36DfFisiSLl+rnUFogK7g/mxLQ+QNCw/NXoxlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ico4pvAFD0dlAI8Ln7QjGxK9pGnV036uqbt74MqXISoNh0C/Is4CiTn9+8Bhx6C5DMK5ixQyZZvhHRo5HC+TjKLs2B+AWCZWNS3ykb6DLy1BD69cOQgBhaDmkQsRUT6wKbzy9FFYGMY77ZIY0Kpi820dNb758AoK7HXld7OjkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdK8EDVX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso7003615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191438; x=1758796238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeKidemFHugBWvlLdngZx3GvGl5BhC7gmcxHsIeIDzM=;
        b=WdK8EDVXcRdGpQWeXdUKaNqKxWsj+eKbyxkm3UcOG3LA+7r73UH2HmkPv7jl9J+V17
         OFKO4mW85xiW/pgC6B54pVVigRy03McVrccke9Q+DMIGcx8VD5Plpm7FkGNW5i5BNs/A
         OpX2i10fJXlXQp6I2KB6ZsuuV9RefAvlONDNAfLOXegn8oDqE6VeiLDEsjDEmvmbptDh
         KIDYE3eblncJRxSA4PqzcJM6YAPCBZU3uVcHrMr3Kinos23G8+c4ZQR0bBFUUws8UArC
         lsJCRWUEaeBXEblwEZmIXcDeIGWHJy3b/cnBqP0VClqRvHPcV5Hp8vmVHKfWFtIRpdD3
         Dsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191438; x=1758796238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeKidemFHugBWvlLdngZx3GvGl5BhC7gmcxHsIeIDzM=;
        b=nxasyxyR/cLpXGWKOlksuhvR+23jZOt33YJ8Y8eml1QlO5NrJSC0/ECKyokCuZVNR8
         izlO2dSIiMwoPLXq+dNhjaA07FiLAYujLIM8gbUMxN4wNcRI6l9YMPGloSgrqKWpCFA8
         jU6yy+YRCajcRnSvsOfeBHf2zlVGHfvExk0P1D+4YUJxIQJ/1OmTXKtQqDbxUW1ylT/A
         9FUKxEuKNrTmvtMhyXqdEo01onTc1J91J47UzYyMJbIsaUlcwfURPUowA6znMNJpgK77
         k2oMGjI8cjoXchweMM4XG6RkcqbXp4OYqE4iK+mouxuWy8rPGh0tbQvSRrKDxWfB0dtJ
         kSWw==
X-Gm-Message-State: AOJu0YxPueU+ZmY/veSI89zqpTMrtxcLEpa06DJzfQ7YuAJvuD5Xx1tl
	EdYlQZsgee1Bn2LiQc1FDhJ7SK2su2zSnxOqj+olh9I/5kYLqF2De43cohBii/NskcdVS+SrEQ=
	=
X-Google-Smtp-Source: AGHT+IGO4Q3fZanqmM0wjFCsbf3Jf0mIV+3pWr1nuubcDlla09trMD8Lvrvc6pAWYylB9LlHYwGCQUbT
X-Received: from wmbhh13.prod.google.com ([2002:a05:600c:530d:b0:45d:cf67:3908])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1554:b0:45d:d6fc:24f7
 with SMTP id 5b1f17b1804b1-462074c55cfmr47460695e9.32.1758191437764; Thu, 18
 Sep 2025 03:30:37 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:14 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; i=ardb@kernel.org;
 h=from:subject; bh=sXlqN2yq2zEV1WP5L/wE4aoN5/FR7QwPK75VLdrzA4A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fYut8ixeb+/ldwe/Zy95q5z8xOp3Z7Xn8vJFqpM+n
 gip5eDpKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZVcnIMIF7L//dMvlJe1Wb
 rH1n/p3Hs5TR8aNi56PZO1wKtNOc8xkZvvPc4/2flPr428W+ecVz+P5FL+Ctl25R7tb+f0rg2cF oJgA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-13-ardb+git@google.com>
Subject: [PATCH v3 3/8] efi/runtime: Deal with arch_efi_call_virt_setup()
 returning failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Deal with arch_efi_call_virt_setup() returning failure, by giving up and
returning an appropriate error code to the caller.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/uv/bios_uv.c          |  3 ++-
 drivers/firmware/efi/runtime-wrappers.c | 20 +++++++++++++-------
 include/linux/efi.h                     |  8 ++++----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index bf31af3d32d6..a442bbe5b1c2 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -32,7 +32,8 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 		 */
 		return BIOS_STATUS_UNIMPLEMENTED;
 
-	ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
+	ret = efi_call_virt_pointer(tab, function, BIOS_STATUS_UNIMPLEMENTED,
+				    (u64)which, a1, a2, a3, a4, a5);
 
 	return ret;
 }
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 708b777857d3..82a27b414485 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -219,7 +219,10 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 	efi_status_t status = EFI_NOT_FOUND;
 	unsigned long flags;
 
-	arch_efi_call_virt_setup();
+	if (!arch_efi_call_virt_setup()) {
+		status = EFI_NOT_READY;
+		goto out;
+	}
 	flags = efi_call_virt_save_flags();
 
 	switch (efi_rts_work.efi_rts_id) {
@@ -308,6 +311,7 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 	efi_call_virt_check_flags(flags, efi_rts_work.caller);
 	arch_efi_call_virt_teardown();
 
+out:
 	efi_rts_work.status = status;
 	complete(&efi_rts_work.efi_rts_comp);
 }
@@ -444,8 +448,8 @@ virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt_pointer(efi.runtime, set_variable, name, vendor,
-				       attr, data_size, data);
+	status = efi_call_virt_pointer(efi.runtime, set_variable, EFI_NOT_READY,
+				       name, vendor, attr, data_size, data);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -481,9 +485,9 @@ virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt_pointer(efi.runtime, query_variable_info, attr,
-				       storage_space, remaining_space,
-				       max_variable_size);
+	status = efi_call_virt_pointer(efi.runtime, query_variable_info,
+				       EFI_NOT_READY, attr, storage_space,
+				       remaining_space, max_variable_size);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -509,12 +513,14 @@ virt_efi_reset_system(int reset_type, efi_status_t status,
 		return;
 	}
 
-	arch_efi_call_virt_setup();
+	if (!arch_efi_call_virt_setup())
+		goto out;
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	arch_efi_call_virt(efi.runtime, reset_system, reset_type, status,
 			   data_size, data);
 	arch_efi_call_virt_teardown();
 
+out:
 	up(&efi_runtime_lock);
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa..325d892e559b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1181,19 +1181,19 @@ static inline void efi_check_for_embedded_firmwares(void) { }
  *    Restores the usual kernel environment once the call has returned.
  */
 
-#define efi_call_virt_pointer(p, f, args...)				\
+#define efi_call_virt_pointer(p, f, busy, args...)			\
 ({									\
-	typeof((p)->f(args)) __s;					\
+	typeof((p)->f(args)) __s = (busy);				\
 	unsigned long __flags;						\
 									\
-	arch_efi_call_virt_setup();					\
+	if (!arch_efi_call_virt_setup()) goto __out;			\
 									\
 	__flags = efi_call_virt_save_flags();				\
 	__s = arch_efi_call_virt(p, f, args);				\
 	efi_call_virt_check_flags(__flags, NULL);			\
 									\
 	arch_efi_call_virt_teardown();					\
-									\
+__out:									\
 	__s;								\
 })
 
-- 
2.51.0.384.g4c02a37b29-goog


