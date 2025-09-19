Return-Path: <linux-kernel+bounces-824149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5561B88397
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE49B566C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9432F1FFE;
	Fri, 19 Sep 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QCqqZ7ug"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEF2BE7B2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267514; cv=none; b=tVgWbXTTDCCZHdmpGFSUteOsHR5lyAyn5hJRYqY6cjTzhly2hWgU3jNedgS+DLZ885Org1d059jspE2D69507nQi8az8eNIqc7YNT+YQIVinfE8hRQjdIQq+annS/e8AEF3G/ns9H6VPlOhRtj1zcjalKTySWCZc+uCrEJ4mCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267514; c=relaxed/simple;
	bh=zDzEd56GJINwCHJtHK5uec2HWJ9F6JHaaxFAcFJeVA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwqsp0J6VrjC3vxQvE1/ZRd3/lMqUj5pPQ7ZjolMZO9FDnwiH38WbOgKGc2yeUhP4pmGaWjOJx2SaipWPCJR2fhIJsaQnCiDMlOM/Y1WnbRoiTq7mPoJgiIyWdCydidwnwGLlZxTRt7uE6bFBeHASj0t20ABwJYoIoh5xpScaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QCqqZ7ug; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761b392d50so2416675b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267512; x=1758872312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3On5utOYIbuVmrZq33FPNGpaqahVTFNH4SYvOX0y2+w=;
        b=QCqqZ7ugkPAgBwTAj6OpCCXDX7RamK7tzEp3cKr2mbn6Tq6rrR7Viwb0w9W9rF0C3X
         nXsssVDskf/okRD5MUTMzNyPdyPk9yUnhyfjBByjX32TU1TLGVLAnmXyJfcVmE6kzoQx
         2wDr0jHvhH/IlJ+vdEtH9c4euFK08JP1KEpi9Oi26Xavf8+X2eikhBQEH0n/WZm//sKf
         q0YOPz1TemLTnx8F13FGH7NlhtLCBVEDkLKgnzbfTadoFnZ+J3Yt53G9axhF6DzA3AvZ
         wsN8xYPJbdEx95wAWGuk3Z8l+Cu1kGIBiL+iRqbgBTy4/J40BHnd9UTEtEl4a0R3x3vJ
         z02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267512; x=1758872312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3On5utOYIbuVmrZq33FPNGpaqahVTFNH4SYvOX0y2+w=;
        b=ciSF7h6212ul41AUb5Zk5oe25IoBUcjlUpYY1N5rilg/Z2Vs2/FUW9niWYYrMhXBTU
         /eTCUPjkP9WCZ2oFJqT4k59OXZxh2+Sr0B77JwNR9R/UM23gR8JGMWWNegDScmFyaM6x
         NARXeLjnMuFGyu6tr6N0llDp97QLxZM3DzVRXClaBz/Bk4pZQaYN+qEpogZgSYtiS8ry
         LJN3n/5s9eguyohds9365/g2KcGXgW/mywwvFiystk5LnL/yEAkkgUGdjyD+P0BxZ0tU
         oaUGKy96jkJtF5F2XiJtuu9YBSFrwAS7AoMtI/L2qUkQW4967ctf/4WX5eF8YMjmkLPD
         Q2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGM3/0vvLv/B09nnwKpQICnpBfvVnMoQEy0ETpreMHqT1cH82Yb5KMVuJUlWBUj8zpXbmO0+3msVy7Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctUVgdk1ZmtbW+KPfjxiUjhofJuttCJ6RTLxqQQtUlYpVPDhm
	vtnTRjhNOZVo33KwPH/Ga1kEWnmBBqC4LD+T8WFkIHQkP+v/zqLOoeOf0DwLITmWh0E=
X-Gm-Gg: ASbGncuiGI+yks3nv2WoA7g9+w6rfhjoOZey+baOJWKCHZuOngsljyIBRnsz3su27A4
	Zifs+sYQuv7qZvvnpVDRzne0sU4Ygc4uLqvUzohR392PkBMgFocEOu2CL062a/sDRpbCy5+LlAo
	R/zYfZviRT3D0mUIGqdsnIbIJ2jRyFBr/BpiBuxO/RJex3QoSISr7J2zMRcF4JrWJeALd1L/Xov
	2AJrQ7R5pDTYNu3k4z0VGY8h5e7hJcOrKVzIB3Arq9cHEo/Qzr/Nl9Ob+5XaMRNfbAbIRMOZjtX
	lpIgl0BqLr7kJzxQQRYfhkd9T78qAk1C8YCtYAXjXcHocfn9hxrFlp8p0dhjIW1M4zOAq6h0L5h
	EahRSGc37QeLmR2jzBaH51s7tpn4PPUxIyHBHBOMwLeqJaznV82e8ohGX2Xtwt1ao3NkGCH+Bg7
	WNbXtwqnTWVfR0Nv45BClfYjMg4095XT17LFMTbtk34w==
X-Google-Smtp-Source: AGHT+IFIJw3ZbMmjD6VhzqUSKT7pqN8ruRnEiHd3w5FK7GBp4ujpuv/Fd0UOkn0D7RcUADn2pVkDew==
X-Received: by 2002:a05:6a20:6a20:b0:24d:d206:699b with SMTP id adf61e73a8af0-2927154982dmr3593051637.41.1758267511524;
        Fri, 19 Sep 2025 00:38:31 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.38.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:38:31 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 6/8] riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
Date: Fri, 19 Sep 2025 15:37:12 +0800
Message-ID: <20250919073714.83063-7-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing arch_xchg/arch_cmpxchg operations are implemented by
inserting fence instructions before or after atomic instructions.
This commit replaces them with real acquire/release semantics.

|----------------------------------------------------------------|
|    |    arch_xchg_release       |     arch_cmpxchg_release     |
|    |-----------------------------------------------------------|
|    | zabha      | !zabha        | zabha+zacas | !(zabha+zacas) |
| rl |-----------------------------------------------------------|
|    |            | (fence rw, w) |             | (fence rw, w)  |
|    | amoswap.rl | lr.w          | amocas.rl   | lr.w           |
|    |            | sc.w.rl       |             | sc.w.rl        |
|----------------------------------------------------------------|
|    |    arch_xchg_acquire       |     arch_cmpxchg_acquire     |
|    |-----------------------------------------------------------|
|    | zabha      | !zabha        | zabha+zacas | !(zabha+zacas) |
| aq |-----------------------------------------------------------|
|    |            | lr.w.aq       |             | lr.w.aq        |
|    | amoswap.aq | sc.w          | amocas.aq   | sc.w           |
|    |            | (fence r, rw) |             | (fence r, rw)  |
|----------------------------------------------------------------|

(fence rw, w), (fence r, rw) here means such instructions will only
be inserted when zalasr is not implemented.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/atomic.h  |   6 --
 arch/riscv/include/asm/cmpxchg.h | 136 ++++++++++++++-----------------
 2 files changed, 63 insertions(+), 79 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5b96c2f61adb5..b79a4f889f339 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -18,12 +18,6 @@
 
 #include <asm/cmpxchg.h>
 
-#define __atomic_acquire_fence()					\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
-
-#define __atomic_release_fence()					\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
-
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE(v->counter);
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 0b749e7102162..207fdba38d1fc 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -15,15 +15,23 @@
 #include <asm/cpufeature-macros.h>
 #include <asm/processor.h>
 
-#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,		\
-			   swap_append, r, p, n)				\
+/*
+ * These macros are here to improve the readability of the arch_xchg_XXX()
+ * and arch_cmpxchg_XXX() macros.
+ */
+#define LR_SFX(x)		x
+#define SC_SFX(x)		x
+#define CAS_SFX(x)		x
+#define SC_PREPEND(x)		x
+#define SC_APPEND(x)		x
+
+#define __arch_xchg_masked(lr_sfx, sc_sfx, swap_sfx, sc_prepend, sc_append,	\
+			   r, p, n)						\
 ({										\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
 	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {		\
 		__asm__ __volatile__ (						\
-			prepend							\
 			"	amoswap" swap_sfx " %0, %z2, %1\n"		\
-			swap_append						\
 			: "=&r" (r), "+A" (*(p))				\
 			: "rJ" (n)						\
 			: "memory");						\
@@ -37,14 +45,16 @@
 		ulong __rc;							\
 										\
 		__asm__ __volatile__ (						\
-		       prepend							\
 		       PREFETCHW_ASM(%5)					\
+		       ALTERNATIVE(__nops(1), sc_prepend,			\
+				   0, RISCV_ISA_EXT_ZALASR, 1)			\
 		       "0:	lr.w %0, %2\n"					\
 		       "	and  %1, %0, %z4\n"				\
 		       "	or   %1, %1, %z3\n"				\
 		       "	sc.w" sc_sfx " %1, %1, %2\n"			\
 		       "	bnez %1, 0b\n"					\
-		       sc_append						\
+		       ALTERNATIVE(__nops(1), sc_append,			\
+				   0, RISCV_ISA_EXT_ZALASR, 1)			\
 		       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 		       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\
 		       : "memory");						\
@@ -53,19 +63,17 @@
 	}									\
 })
 
-#define __arch_xchg(sfx, prepend, append, r, p, n)			\
+#define __arch_xchg(sfx, r, p, n)					\
 ({									\
 	__asm__ __volatile__ (						\
-		prepend							\
 		"	amoswap" sfx " %0, %2, %1\n"			\
-		append							\
 		: "=r" (r), "+A" (*(p))					\
 		: "r" (n)						\
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
-		   sc_append, swap_append)				\
+#define _arch_xchg(ptr, new, lr_sfx, sc_sfx, swap_sfx,			\
+		   sc_prepend, sc_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -73,22 +81,20 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+		__arch_xchg_masked(lr_sfx, sc_sfx, ".b" swap_sfx,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 2:								\
-		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+		__arch_xchg_masked(lr_sfx, sc_sfx, ".h" swap_sfx,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".w" swap_sfx, __ret, __ptr, __new);	\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".d" swap_sfx, __ret, __ptr, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -97,17 +103,23 @@
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "", "", "")
+	_arch_xchg(ptr, x, LR_SFX(""), SC_SFX(""), CAS_SFX(""),		\
+		   SC_PREPEND(__nops(1)), SC_APPEND(__nops(1)))
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "",					\
-		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, LR_SFX(".aq"), SC_SFX(""), CAS_SFX(".aq"),	\
+		   SC_PREPEND(__nops(1)),				\
+		   SC_APPEND(RISCV_ACQUIRE_BARRIER))
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
+	_arch_xchg(ptr, x, LR_SFX(""), SC_SFX(".rl"), CAS_SFX(".rl"),	\
+		   SC_PREPEND(RISCV_RELEASE_BARRIER),			\
+		   SC_APPEND(__nops(1)))
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
+	_arch_xchg(ptr, x, LR_SFX(""), SC_SFX(".aqrl"),			\
+		   CAS_SFX(".aqrl"), SC_PREPEND(__nops(1)),		\
+		   SC_APPEND(__nops(1)))
 
 #define xchg32(ptr, x)							\
 ({									\
@@ -126,9 +138,7 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,					\
-			      sc_prepend, sc_append,				\
-			      cas_prepend, cas_append,				\
+#define __arch_cmpxchg_masked(lr_sfx, sc_sfx, cas_sfx, sc_prepend, sc_append,	\
 			      r, p, o, n)					\
 ({										\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
@@ -138,9 +148,7 @@
 		r = o;								\
 										\
 		__asm__ __volatile__ (						\
-			cas_prepend							\
 			"	amocas" cas_sfx " %0, %z2, %1\n"		\
-			cas_append							\
 			: "+&r" (r), "+A" (*(p))				\
 			: "rJ" (n)						\
 			: "memory");						\
@@ -155,15 +163,17 @@
 		ulong __rc;							\
 										\
 		__asm__ __volatile__ (						\
-			sc_prepend							\
-			"0:	lr.w %0, %2\n"					\
+			ALTERNATIVE(__nops(1), sc_prepend,			\
+				    0, RISCV_ISA_EXT_ZALASR, 1)			\
+			"0:	lr.w" lr_sfx " %0, %2\n"			\
 			"	and  %1, %0, %z5\n"				\
 			"	bne  %1, %z3, 1f\n"				\
 			"	and  %1, %0, %z6\n"				\
 			"	or   %1, %1, %z4\n"				\
 			"	sc.w" sc_sfx " %1, %1, %2\n"			\
 			"	bnez %1, 0b\n"					\
-			sc_append							\
+			ALTERNATIVE(__nops(1), sc_append,			\
+				    0, RISCV_ISA_EXT_ZALASR, 1)			\
 			"1:\n"							\
 			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 			: "rJ" ((long)__oldx), "rJ" (__newx),			\
@@ -174,9 +184,7 @@
 	}									\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
-		       sc_prepend, sc_append,				\
-		       cas_prepend, cas_append,				\
+#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,	sc_prepend, sc_append,	\
 		       r, p, co, o, n)					\
 ({									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&			\
@@ -184,9 +192,7 @@
 		r = o;							\
 									\
 		__asm__ __volatile__ (					\
-			cas_prepend					\
 			"	amocas" cas_sfx " %0, %z2, %1\n"	\
-			cas_append					\
 			: "+&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -194,12 +200,14 @@
 		register unsigned int __rc;				\
 									\
 		__asm__ __volatile__ (					\
-			sc_prepend					\
+			ALTERNATIVE(__nops(1), sc_prepend,		\
+				    0, RISCV_ISA_EXT_ZALASR, 1)		\
 			"0:	lr" lr_sfx " %0, %2\n"			\
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc" sc_sfx " %1, %z4, %2\n"		\
 			"	bnez %1, 0b\n"				\
-			sc_append					\
+			ALTERNATIVE(__nops(1), sc_append,		\
+				    0, RISCV_ISA_EXT_ZALASR, 1)		\
 			"1:\n"						\
 			: "=&r" (r), "=&r" (__rc), "+A" (*(p))		\
 			: "rJ" (co o), "rJ" (n)				\
@@ -207,9 +215,8 @@
 	}								\
 })
 
-#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
-		      sc_prepend, sc_append,				\
-		      cas_prepend, cas_append)				\
+#define _arch_cmpxchg(ptr, old, new, lr_sfx, sc_sfx, cas_sfx,		\
+		      sc_prepend, sc_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __old = (old);				\
@@ -218,27 +225,23 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
+		__arch_cmpxchg_masked(lr_sfx, sc_sfx, ".b" cas_sfx,	\
 				      sc_prepend, sc_append,		\
-				      cas_prepend, cas_append,		\
 				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
+		__arch_cmpxchg_masked(lr_sfx, sc_sfx, ".h" cas_sfx,	\
 				      sc_prepend, sc_append,		\
-				      cas_prepend, cas_append,		\
 				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
-		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
+		__arch_cmpxchg(".w" lr_sfx, ".w" sc_sfx, ".w" cas_sfx,	\
 			       sc_prepend, sc_append,			\
-			       cas_prepend, cas_append,			\
 			       __ret, __ptr, (long)(int)(long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
+		__arch_cmpxchg(".d" lr_sfx, ".d" sc_sfx, ".d" cas_sfx,	\
 			       sc_prepend, sc_append,			\
-			       cas_prepend, cas_append,			\
 			       __ret, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
@@ -247,40 +250,27 @@
 	(__typeof__(*(__ptr)))__ret;					\
 })
 
-/*
- * These macros are here to improve the readability of the arch_cmpxchg_XXX()
- * macros.
- */
-#define SC_SFX(x)	x
-#define CAS_SFX(x)	x
-#define SC_PREPEND(x)	x
-#define SC_APPEND(x)	x
-#define CAS_PREPEND(x)	x
-#define CAS_APPEND(x)	x
-
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 	_arch_cmpxchg((ptr), (o), (n),					\
-		      SC_SFX(""), CAS_SFX(""),				\
-		      SC_PREPEND(""), SC_APPEND(""),			\
-		      CAS_PREPEND(""), CAS_APPEND(""))
+		      LR_SFX(""), SC_SFX(""), CAS_SFX(""),		\
+		      SC_PREPEND(__nops(1)), SC_APPEND(__nops(1)))
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 	_arch_cmpxchg((ptr), (o), (n),					\
-		      SC_SFX(""), CAS_SFX(""),				\
-		      SC_PREPEND(""), SC_APPEND(RISCV_ACQUIRE_BARRIER),	\
-		      CAS_PREPEND(""), CAS_APPEND(RISCV_ACQUIRE_BARRIER))
+		      LR_SFX(".aq"), SC_SFX(""), CAS_SFX(".aq"),	\
+		      SC_PREPEND(__nops(1)),				\
+		      SC_APPEND(RISCV_ACQUIRE_BARRIER))
 
 #define arch_cmpxchg_release(ptr, o, n)					\
 	_arch_cmpxchg((ptr), (o), (n),					\
-		      SC_SFX(""), CAS_SFX(""),				\
-		      SC_PREPEND(RISCV_RELEASE_BARRIER), SC_APPEND(""),	\
-		      CAS_PREPEND(RISCV_RELEASE_BARRIER), CAS_APPEND(""))
+		      LR_SFX(""), SC_SFX(".rl"), CAS_SFX(".rl"),	\
+		      SC_PREPEND(RISCV_RELEASE_BARRIER),		\
+		      SC_APPEND(__nops(1)))
 
 #define arch_cmpxchg(ptr, o, n)						\
 	_arch_cmpxchg((ptr), (o), (n),					\
-		      SC_SFX(".rl"), CAS_SFX(".aqrl"),			\
-		      SC_PREPEND(""), SC_APPEND(RISCV_FULL_BARRIER),	\
-		      CAS_PREPEND(""), CAS_APPEND(""))
+		      LR_SFX(""), SC_SFX(".aqrl"), CAS_SFX(".aqrl"),	\
+		      SC_PREPEND(__nops(1)), SC_APPEND(__nops(1)))
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 	arch_cmpxchg_relaxed((ptr), (o), (n))
-- 
2.20.1


