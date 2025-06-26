Return-Path: <linux-kernel+bounces-703829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECFAE9545
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 07:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BA617A5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 05:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9942264CA;
	Thu, 26 Jun 2025 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVb5VnCv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B32221DB2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916917; cv=none; b=U4bLQ96It3Ws/FPR6UN6/PtTTEMi6Q+A8S+FnkC7d54HFohj9/VT/OdWvPfvU4zYtQxGgsUCTo4hty/ahdQlzOBcflUibFaYdFqoMhMoQZnSzvASuY5H0ECwDBQgei2Z4a7427x0AOJXSv8yroFXh57n4O/W7a1cawcMGVxQG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916917; c=relaxed/simple;
	bh=I2DV6rRx2Cjv+IUAW0F5JSmoyWJANossHcJsAVjMTU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LunYG2MdjqDPwVuezscmHyzltHPfjUXbmDkE13LOnvVZwasQRe1vhxjiArQRghIYxs6ioIVCvD6zWBag2hU3MZIAN+ZR6J1NmP1zMYLUtXlhxIzgeI49nBxbYaR8vg7T9QUqgHXhuOI2LhFehMfJrVqU3+V0UpWy5k/g3ONsns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVb5VnCv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-237f8d64263so6289035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750916915; x=1751521715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=No7VYJnrsaMBClQyRTA21U4NQdkCFvGbDpgoUA5SP00=;
        b=WVb5VnCvREVkiQCpG7w21OmHZdDFpF5K2Goe006se2Kfad2K7x2IrqEFTMvhpa6+Cu
         SjUafPDIO+K/GAJDqN7E9W5E+M8JEBd30ufj4XTGeezubNjLyaG8k9BxSkWapXbVCzy6
         jy50rzu4qsrzs+o/sIAZyWqvmszrN0uxyPYgxe1m8CLaOFtdTsEz1nsiq9/MMKzw+DIB
         MTTEIV8HB5LQmh0Lbo3GEE85iiSuT9XNnJqdWDhh9sj7I9E05dwdVP/Z0jXiss4/rBw8
         CDs1/r/ZMD8gLCjEl/c6rdXBBne9HJHOfjDlhFBfvZW10aqdB1polgEsIGcrEAVTRkmu
         U/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916915; x=1751521715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=No7VYJnrsaMBClQyRTA21U4NQdkCFvGbDpgoUA5SP00=;
        b=mHwmleHi9azzehQtgeBDcCAFydeLFdodbAjoJ2u9yXE/s0lp4AZQFNgZQBJauDoca4
         y53Seozb+q5lPwgGfofVM2MyaEdsHkAjgRTUpXsLSRI3hpj4pDaQD4HdROonvJrdTu7A
         /NtlYMgzNwXwZvEkW8PQrl58LVGJeVJmeNZ3YOEAysgZv+4q2f113qAJq9oSePn5sopq
         r7Xdvn066NwlrNdfIVePMvQL0foB81KKcyDT5LuozzG50Z1GjUSAbelxkL7fvlbhevsJ
         btQJrV3sDnosdf+A0M/+rQz7GtrLQ0sHJUQF2BowIsP0T5piTEMwenSeMWU7jgkAsytp
         AVYw==
X-Forwarded-Encrypted: i=1; AJvYcCV6h17/si2mPuOPXl7jX2W5SXbNr3Ss2FH94lB8oKIM5NfH3kQUk20Ra6yYFZLrLIHRKMKsaqgydh8xM3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwN1gKz92WbvAoRbaOz3DZ+KB1aw5ay4i4gH33V5+5EspwPQ4
	E36rEahMH1/H8KOahu+CIUGAlQUabydNINqjG2SI3xK4wISiehSf+lnGH75KUf9cT/a4nWWRLML
	4WoRC1weaIw==
X-Google-Smtp-Source: AGHT+IEsY38vIXEEuF4IRkd5xvRhTuGPG8ULpVkQr9FeQ29MCI+w1O99arFqY6BeYv2pTQt//M6Fxu4UQHw5
X-Received: from plof2.prod.google.com ([2002:a17:902:8602:b0:234:d477:3b7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:234:88f5:c0d1
 with SMTP id d9443c01a7336-238c86ee242mr41530295ad.10.1750916915313; Wed, 25
 Jun 2025 22:48:35 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:48:25 -0700
In-Reply-To: <20250626054826.433453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626054826.433453-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626054826.433453-3-irogers@google.com>
Subject: [PATCH v3 2/3] tools headers: Update the linux/unaligned.h copy with
 the kernel sources
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To pick up the changes in:

  fe9b2b7b3583 vdso: Switch get/put unaligned from packed struct to memcpy

As the code is dependent on __unqual_scalar_typeof, update the tools
version of compiler_types.h to include this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler_types.h | 22 ++++++++++++++++
 tools/include/vdso/unaligned.h       | 39 +++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index d09f9dc172a4..890982283a5e 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -40,4 +40,26 @@
 #define asm_goto_output(x...) asm goto(x)
 #endif
 
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+/*
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(signed type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+
 #endif /* __LINUX_COMPILER_TYPES_H */
diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index ff0c06b6513e..0ccbcc9aa493 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,41 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
-	__get_pptr->x;									\
+#include <linux/compiler_types.h>
+
+/**
+ * __get_unaligned_t - read an unaligned value from memory.
+ * @type:	the type to load from the pointer.
+ * @ptr:	the pointer to load from.
+ *
+ * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
+ * from approaches like type punning that require -fno-strict-aliasing in order
+ * to be correct. As type may be const, use __unqual_scalar_typeof to map to a
+ * non-const type - you can't memcpy into a const type. The void* cast silences
+ * ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type __get_unaligned_ctrl_type __always_unused;			\
+	__unqual_scalar_typeof(__get_unaligned_ctrl_type) __get_unaligned_val; \
+	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
+			 sizeof(__get_unaligned_val));			\
+	__get_unaligned_val;						\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {						\
-	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
-	__put_pptr->x = (val);								\
+/**
+ * __put_unaligned_t - write an unaligned value to memory.
+ * @type:	the type of the value to store.
+ * @val:	the value to store.
+ * @ptr:	the pointer to store to.
+ *
+ * Use memcpy to affect an unaligned type sized store avoiding undefined
+ * behavior from approaches like type punning that require -fno-strict-aliasing
+ * in order to be correct. The void* cast silences ubsan warnings.
+ */
+#define __put_unaligned_t(type, val, ptr) do {				\
+	type __put_unaligned_val = (val);				\
+	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
+			 sizeof(__put_unaligned_val));			\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


