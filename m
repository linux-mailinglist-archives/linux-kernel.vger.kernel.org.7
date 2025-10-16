Return-Path: <linux-kernel+bounces-856923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA616BE5765
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD551890928
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093B2E54A2;
	Thu, 16 Oct 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGGWIWh+"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BE2E3B1C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647907; cv=none; b=oVqw65Qt//2CBdGZd+7udo+E3ehf0R8UzQ1X2oBZBddK4plmgZX5lL3Qj06c46gedhaZCRK4XD4JHVyUYLF/NPHG4qbzmrl2DmPWKmvoV4jmohyFFfVCAce9jrvR00U28CiHFfTfUJq6a/rbEtxZJso8b97IeaOzvEvPZ9p9vPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647907; c=relaxed/simple;
	bh=UvfqvuNzNaKuTenaXI68Nt5jBlIoumMb2oUSP1fRCMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KkuNxes5uaOaSJg+2nkq7xtwSXikd7+Hs2l07hYPW/Vdqf6LFP6DnZ7rcf5UB+2mSy7GVCsxJaJpfJFFTNEE1dkgfDWck9pWAHkJD+nyKFqu7TIVx3tSY478NSgypD9+SHqt/ve4Ltn/wlKTSDZNYQKIWGgBNJYJSALJiZODHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGGWIWh+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f64c5cf62so994643b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760647905; x=1761252705; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Op/cgLXnfaBM2beLrTOCrg+8NoqMY5HOv5BplNGP7NA=;
        b=QGGWIWh+pnserlzUrxPH4BA+m7NV4XzFYkbMzNIguxIBTuEC/tRd98BjX9PCWc/Om6
         HV+6qTn0ePEULdSZbenN2jrWAVNrfO8STKHC1zYhGONz/topHXlF1ZL8sJPawIUUinF8
         U7J+pSaWyOqglKc9VWDoZF+BRqVpbNVJ7QLQSRBTnOareu5SaM9cVmsnWuhnad31xj/j
         SFoqC09DvrgydNg+GlvzqX2S7uAOmGv6GerOqu3aHSDNwZXEH0ZcS+M2lgca3QAeZuju
         Hs9UrjLZLBplEFRbtv7CN9oWDwXcw0swWBVk27OiCfuGFNU4sxxzetxcnw2MVURyJ34t
         aNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647905; x=1761252705;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op/cgLXnfaBM2beLrTOCrg+8NoqMY5HOv5BplNGP7NA=;
        b=pXEm74jj4N+miU29s3quufCMR9TG7glaAuAX/VHH69LxRFT6p8a7tObBnAbH5lFBAw
         JSewovxIprvCR94LcXtjDPanx1fiCLcetR5AdaESzLGehxXPox1cUGMxM6lWMTvMYgx5
         F6+OeGFod6Zhv6Xdc/Ica0M4G6VoZc/RlwVZwSfXQVUz4LZvMKI+Xa3PyrT+EpYVKPKw
         WseVxjLbCHUvczXVwO/PO90czxVpUr5pbSUFAaVNttZUNCZ3UbLgdLVPtRgguYSnNSpT
         mx5cKGMdcZRBPhRdpwG1gZxpXgeoOZyephfgauDISapOaJvUnMBxeuXJ0EubSRDkmbQF
         NbHA==
X-Forwarded-Encrypted: i=1; AJvYcCV5+ihA+D7eukRMiXesi4emsX8UWL15chpd07TIizxROlDcXYt0nkMbhPF28m9pfsPOSP1tOsDUtiE8OfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKHDV5/XSfIDYSoMOXjo3Jqkn/moThRD+YzRBeCfq+CVM4k8l
	l9u3FFW2qPFSlVkw02/qzqcE7xdWMen+CCKwJiWzx2XF+E82okRtrp+2HKsnmIpyajV8cpLg7Pu
	O7Za1RD7wCA==
X-Google-Smtp-Source: AGHT+IGUbpSBAQlWWqITv9bif+XWoD3GdrHFfDFRJdD4RE9Dd+y5C2qTC2uRnG+u/NrbClKTgiG4ImAur+pN
X-Received: from pgip24.prod.google.com ([2002:a63:c158:0:b0:b54:fd1f:ef57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a4:b0:334:974b:6e0f
 with SMTP id adf61e73a8af0-334a86256c3mr1836298637.40.1760647905615; Thu, 16
 Oct 2025 13:51:45 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:25 -0700
In-Reply-To: <20251016205126.2882625-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016205126.2882625-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016205126.2882625-4-irogers@google.com>
Subject: [PATCH v5 3/4] tools headers: Update the linux/unaligned.h copy with
 the kernel sources
From: Ian Rogers <irogers@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

To pick up the changes in:

  vdso: Switch get/put unaligned from packed struct to memcpy

As the code is dependent on __unqual_scalar_typeof, update the tools
version of compiler_types.h to include this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler_types.h | 22 +++++++++++++++
 tools/include/vdso/unaligned.h       | 41 ++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

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
index ff0c06b6513e..9076483c9fbb 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,43 @@
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
+ * non-const type - you can't memcpy into a const type. The
+ * __get_unaligned_ctrl_type gives __unqual_scalar_typeof its required
+ * expression rather than type, a pointer is used to avoid warnings about mixing
+ * the use of 0 and NULL. The void* cast silences ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type *__get_unaligned_ctrl_type __always_unused = NULL;		\
+	__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
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
2.51.0.858.gf9c4a03a3a-goog


