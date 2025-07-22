Return-Path: <linux-kernel+bounces-741567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F964B0E5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C18C5404D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE728A1EB;
	Tue, 22 Jul 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4Krp/8a"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21617286D5B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221489; cv=none; b=DE9C4nEw23BG9nm3/Q7iZYauddwEsFgJpaoUxtYNMv3Xpk8G8F8rkyN/VcBcJe2TLdvFggML7vYss0ZZV+8mDpImTL3SBhGwuaJtSNqWOdnoxxFVv6QnZ/ntKbU6xeLyBgeYwsT3ktiViHZQHlq8d0o2GtFnScc5LWF+eCH5Qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221489; c=relaxed/simple;
	bh=rXMYeZ6nHjuavtHWLi92BzEDLvzM5iCtn0anCHdQWC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezWAuBXCFt5tmvI9YKq2wEDE2MswZ3jZxcl4PbPg5XeKScCm+XK2tULYq4gmlAwMJvjviPheNCZlxa3P3tnztT/Ig1nH8Zc1ktxQFCAsX3VYkDQX9r6LNrqm1qr/Zlu+SyBcOZ6c6jZOY09HQfrBePHi0hY0ET3nnjO92DXhcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4Krp/8a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so4978274a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221487; x=1753826287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJRSNbAVtnnRSRtWxuuhl6QaFHCsA6vuAmX7FkDxBVU=;
        b=f4Krp/8a0YEsgK14Q505jSUp77XYNt9xulReTZFG3NmEw/b1KqXLz1cMtoSL65txVZ
         xP9KcWPGsYlLHRgH54FFp8uB68vvBsdkY1jhNudZ4iYF8NLjyQgkXfiW3ltZ2FWkQas/
         JkmyuXauCXy+z3nrkdKk2g1XYIBqpe1VLbEOeNz7EJ42RVeWoUi2Gj+oowTsWwB6/C+x
         4YTN4egkI3Zs+X89LsmCGtagHLqFOBFWT6cv3RN/+wrxZzswHHdLkvZjVWflAPdNDxoz
         ulUhyoZJJu9yGFkjJHnJ1VD86E+Osce+6oD4eKsxJHlAKxzD3ttH50YqCx40Q2poyIAT
         lmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221487; x=1753826287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJRSNbAVtnnRSRtWxuuhl6QaFHCsA6vuAmX7FkDxBVU=;
        b=AkCGuyluGl2OlWqhiejdkoQNgwbivEE1bPrw6ntGrPCziSXlVd8eSJQuRBLNXGJm8g
         DWk4PvjltXgs8S7fJa16TIDhGn82fI4LHATGGc1eukj3KKUDGTumuyvO7WDXTm0gSjLt
         LxBEPG4522L35UOE94moL6o/+pLzzMBv5KTk09MzigzpL9VPc9Rogpt9zTt6lw3USzYC
         HNZGXFI61CTH1nXbtpPU6l7o38zl+2OXRFH2cFX5ky/asnmdirZ88jKEdoajcH2G3WFS
         /nd+9bqMiZlCcAp2/Am8VLyk4go2OVN6Y9Yag9F0XQNx/sChPvj7+XuFiYCsQlQp9iLt
         9PLw==
X-Forwarded-Encrypted: i=1; AJvYcCWUVqd71Hv1P4KeI8+idUHSh5VjKUafbe1dt85JbxCAYAGe+/TCN0TkbrIeIYDED9H+Loiw8mNgiy7uj3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDF78/TFk2xuxCQTqIWZhBEl7pNvsrQQ6jneBSDDnTaU13b98c
	Gh/7S31ItgcUipe1sUGeMkf8BcsF/XgfUSiX4jOQjQIiQWzqKaEMIsCnaPmYNHL4MSJ9CiA1gz3
	osstu47pk2Q==
X-Google-Smtp-Source: AGHT+IHdhqHoxMMDAXiufK5PlecdJ/IBjH5JHd18OWhrASaqpf5K8i3TM25fRL4P6wJuPv3uT7mpBTaWZ7Q4
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:312:1c59:43a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e83:b0:31c:15d9:8aa
 with SMTP id 98e67ed59e1d1-31e507fe866mr1144679a91.34.1753221487472; Tue, 22
 Jul 2025 14:58:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:53 -0700
In-Reply-To: <20250722215754.672330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722215754.672330-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-3-irogers@google.com>
Subject: [PATCH v4 2/3] tools headers: Update the linux/unaligned.h copy with
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

  e5f39a57c4c5 vdso: Switch get/put unaligned from packed struct to memcpy

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
2.50.0.727.gbf7dc18ff4-goog


