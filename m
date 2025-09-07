Return-Path: <linux-kernel+bounces-804779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A19B47CE4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F2C17DFC1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89552848BE;
	Sun,  7 Sep 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCv0+pnr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A506E552
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270068; cv=none; b=I83mYIedIwWe9KpFQKPGSe3sB8tSs3cargFlD42nJCfchR/gjqcuNkwq3hPDUFIWxyW/GqVB8hR2j28vdqPdeqh5/9vjkvLPgF0v0KqHnShmt3GBSLCBHBXFiQXo6sAxM0P7uhBRfICS8GQ8A6S+2q8QvLtBtINbOkVfIj1z+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270068; c=relaxed/simple;
	bh=V/olui1zCKk/MD3zcDaBAsqW3JfMyTaMRNWIBGAy0gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZzH+gY5tsrhhvgezeFmX7Yr8ax+7gCzO/mY/2OJeqJFC+jbdN5Bn8Rp1/U9fbC1HRMF3A6YemQQ7mnaLGfGJFWIOy98Hkkp09oaAeWH8IhyCpTR8E6mPAjTquTMyPVu5Pynj4F8Wtwai26ZdsO3uJi1VG5yOXrIeFxUkWbHa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCv0+pnr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0472bd218bso592646566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757270065; x=1757874865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcuO7EBQB4DV8eVMLXuTBf9tOswjdlII0qkfljFwntI=;
        b=bCv0+pnr3776y2Xy9+bJ8gJSQ8vloQZ8Jl8VbT60vy2jXiRqEAjU4FDAw/GcmK7gO6
         UtUNXPCOrIZxYPYU2heEfPcd9IIGVlGQ7AE2aGbe9bIrKx0FQ2XcMiwV5n++twskg+1E
         J0ly2wcCcWMBoIaXcis4VbTzP0oxN0W07aWch3/QPD+l96BuoQP67b62nhDqlNnfSnV2
         HjZmB3I/3lRGjh0BhdKd/efJTsfqhO4lsoKNqDgeWaUAGdqTdic0Pu3m6PDaROZqCZ65
         qS6k+LHIUQxoCjiBX55JU0P7nrML8gbqd7gvZjRKqtuTtz49/kRTSdXJN81pDQ3D1zhS
         1ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757270065; x=1757874865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcuO7EBQB4DV8eVMLXuTBf9tOswjdlII0qkfljFwntI=;
        b=KzjKBvtssULx4Pqzj1+6COuj6aJnKzloweR1yImqYo9iC+OQEacRxh0XQfqKWMlUAv
         vP/lWZ8TsFNnaOuU9BHjNtX+bFa1/rvBPAlif1lL4ZNVSUPAz2UEXFjhXkHqzDoyXM1n
         0hUgl3U92hPGWt8j822FFySSjxp0qL4Gr0kyjLvkElsDoUu6WcuJ3xO38eOPiLQ3zYOq
         rxmXIjZAP+J3EaTjae8ulHnZuWzhHv8S5k+3CSNtDqtmFrGtYfLLUQzj3uicBMTRXgvr
         IHaohgtUAo4h620mSPFuoIbZ9KJMkruwtJqQ4b1HIUlBBynIWh3vVCQw7hFwaV3nG/w9
         pCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUlYYM0T4W8Ke2N2kjJZBry8x20qoJPaeiIB2CoG9ZYF+HMZgEI3KKJGrZNw6/Er8YJ2ICrTZK5IggGoCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDggv2HZK0k7MEv5DSZ7d966FntPeW2ca1+QLAcV0o3+kRtLw
	MMBOa27H3QfTYHSwvKV65W2iec0AHgPmBjC54Uuc3/bKsqF1hX3dmnDePQ6K7w==
X-Gm-Gg: ASbGnctEAHg+rKU+fDjPZrLOAUTKHneXLi1ii9IW6UbH/GOQezN4yvxxnDm2u1ztqVe
	a61Y5BS4z1ZaJRM5EV00eW2mBFvFPlXgQBpqQXt/ldF/7qKnCeqdGqVKbTZs6jd3/n/sw8N7zOO
	1IdEsqG5s9ps2SiFLdieIZqaEmN80qxziQ3xsOd1Bv22VYMu2vXRXB97mRP6Mc2zYNZQEISpft1
	5FCGDviIX9IOEvzkZWigkO2l2tEri/fdS3VgmB5lxUqpZCJRm01MERrpsE/L2dD1MSSpC6Z5jCp
	tq6Wldff4S0anLFErjYgVJq/sjyQorM7udAQGv/P66sVQeg6TsFCJtPpDnBNO8ed6sFzZC4JC0X
	mFIf8ttJx2/75Q3H2a9qpB8k=
X-Google-Smtp-Source: AGHT+IEzlJcAQNbFCKCNJAGfyIE1M0R6JOmtvKkELsapJjB7ASpZ52sJbajMod0TuEe5I+ZCdYYWhQ==
X-Received: by 2002:a17:906:fe46:b0:b04:5cca:9963 with SMTP id a640c23a62f3a-b04b155a032mr584177566b.41.1757270064412;
        Sun, 07 Sep 2025 11:34:24 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04b0f0cdc3sm444495166b.84.2025.09.07.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:34:23 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v2] x86: Remove code depending on __GCC_ASM_FLAG_OUTPUTS__
Date: Sun,  7 Sep 2025 20:33:38 +0200
Message-ID: <20250907183420.48569-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The minimum supported GCC version is 8.1, which supports flag
output operands and always defines __GCC_ASM_FLAG_OUTPUTS__ macro.

Remove code depending on __GCC_ASM_FLAG_OUTPUTS__ and use
the "=@ccCOND" flag output operand directly.

Use the equivalent "=@ccz" instad of "=@cce" flag output operand for
CMPXCHG8B and CMPXCHG16B instructions. These instructions set
a single flag bit, and "=@ccz" is used to distinguish the CC user
from comparison instructions, where set ZERO flag indeed means
that the values are equal.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Mention why "=@ccz" is used instead of "=@cce" for CMPXCHG{8,16}B.
---
 arch/x86/boot/bitops.h               |  2 +-
 arch/x86/boot/boot.h                 |  8 ++++----
 arch/x86/boot/string.c               |  4 ++--
 arch/x86/include/asm/archrandom.h    |  6 ++----
 arch/x86/include/asm/asm.h           | 12 ------------
 arch/x86/include/asm/bitops.h        | 18 ++++++------------
 arch/x86/include/asm/cmpxchg.h       | 12 ++++--------
 arch/x86/include/asm/cmpxchg_32.h    |  6 ++----
 arch/x86/include/asm/cmpxchg_64.h    |  3 +--
 arch/x86/include/asm/percpu.h        | 12 ++++--------
 arch/x86/include/asm/rmwcc.h         | 26 ++------------------------
 arch/x86/include/asm/sev.h           |  3 +--
 arch/x86/include/asm/signal.h        |  3 +--
 arch/x86/include/asm/special_insns.h |  3 +--
 arch/x86/include/asm/uaccess.h       |  7 +++----
 tools/arch/x86/include/asm/asm.h     | 12 ------------
 tools/perf/bench/find-bit-bench.c    |  2 +-
 17 files changed, 35 insertions(+), 104 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 8518ae214c9b..79e15971529d 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -27,7 +27,7 @@ static inline bool variable_test_bit(int nr, const void *addr)
 	bool v;
 	const u32 *p = addr;
 
-	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
+	asm("btl %2,%1" : "=@ccc" (v) : "m" (*p), "Ir" (nr));
 	return v;
 }
 
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 60580836daf7..a3c58ebe3662 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -155,15 +155,15 @@ static inline void wrgs32(u32 v, addr_t addr)
 static inline bool memcmp_fs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("fs repe cmpsb" CC_SET(nz)
-		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm volatile("fs repe cmpsb"
+		     : "=@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("gs repe cmpsb" CC_SET(nz)
-		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm volatile("gs repe cmpsb"
+		     : "=@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index f35369bb14c5..b25c6a9303b7 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -32,8 +32,8 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe cmpsb" CC_SET(nz)
-	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm("repe cmpsb"
+	    : "=@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..4c305305871b 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -23,8 +23,7 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
 		asm volatile("rdrand %[out]"
-			     CC_SET(c)
-			     : CC_OUT(c) (ok), [out] "=r" (*v));
+			     : "=@ccc" (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -35,8 +34,7 @@ static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
 	asm volatile("rdseed %[out]"
-		     CC_SET(c)
-		     : CC_OUT(c) (ok), [out] "=r" (*v));
+		     : "=@ccc" (ok), [out] "=r" (*v));
 	return ok;
 }
 
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index f963848024a5..d5c8d3afe196 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -122,18 +122,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 }
 #endif
 
-/*
- * Macros to generate condition code outputs from inline assembly,
- * The output operand must be type "bool".
- */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=qm"
-#endif
-
 #ifdef __KERNEL__
 
 # include <asm/extable_fixup_types.h>
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index eebbc8889e70..33153dcd119c 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -99,8 +99,7 @@ static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 {
 	bool negative;
 	asm_inline volatile(LOCK_PREFIX "xorb %2,%1"
-		CC_SET(s)
-		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
+		: "=@ccs" (negative), WBYTE_ADDR(addr)
 		: "iq" ((char)mask) : "memory");
 	return negative;
 }
@@ -149,8 +148,7 @@ arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm(__ASM_SIZE(bts) " %2,%1"
-	    CC_SET(c)
-	    : CC_OUT(c) (oldbit)
+	    : "=@ccc" (oldbit)
 	    : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -175,8 +173,7 @@ arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=@ccc" (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -187,8 +184,7 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(btc) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=@ccc" (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
 
 	return oldbit;
@@ -211,8 +207,7 @@ static __always_inline bool constant_test_bit_acquire(long nr, const volatile un
 	bool oldbit;
 
 	asm volatile("testb %2,%1"
-		     CC_SET(nz)
-		     : CC_OUT(nz) (oldbit)
+		     : "=@ccnz" (oldbit)
 		     : "m" (((unsigned char *)addr)[nr >> 3]),
 		       "i" (1 << (nr & 7))
 		     :"memory");
@@ -225,8 +220,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	bool oldbit;
 
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=@ccc" (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
 
 	return oldbit;
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index b61f32c3459f..a88b06f1c35e 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -166,8 +166,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgb %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "q" (__new)			\
@@ -178,8 +177,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgw %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
@@ -190,8 +188,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgl %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
@@ -202,8 +199,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgq %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 371f7906019e..1f80a62be969 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -46,8 +46,7 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new
 	bool ret;							\
 									\
 	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
+		     : "=@ccz" (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -125,8 +124,7 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 		ALTERNATIVE(_lock_loc					\
 			    "call cmpxchg8b_emu",			\
 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		CC_SET(e)						\
-		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+		: ALT_OUTPUT_SP("=@ccz" (ret),				\
 				"+a" (o.low), "+d" (o.high))		\
 		: "b" (n.low), "c" (n.high),				\
 		  [ptr] "S" (_ptr)					\
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 71d1e72ed879..5afea056fb20 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -66,8 +66,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old,
 	bool ret;							\
 									\
 	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
+		     : "=@ccz" (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b0d03b6c279b..332428caaed2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -309,8 +309,7 @@ do {									\
 									\
 	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
 		  __percpu_arg([var])					\
-		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
+		  : "=@ccz" (success),					\
 		    [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
@@ -367,8 +366,7 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+		: ALT_OUTPUT_SP("=@ccz" (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
 		: "b" (new__.low), "c" (new__.high),			\
@@ -436,8 +434,7 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+		: ALT_OUTPUT_SP("=@ccz" (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
 		: "b" (new__.low), "c" (new__.high),			\
@@ -585,8 +582,7 @@ do {									\
 	bool oldbit;							\
 									\
 	asm volatile("btl %[nr], " __percpu_arg([var])			\
-		     CC_SET(c)						\
-		     : CC_OUT(c) (oldbit)				\
+		     : "=@ccc" (oldbit)					\
 		     : [var] "m" (__my_cpu_var(_var)),			\
 		       [nr] "rI" (_nr));				\
 	oldbit;								\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 3821ee3fae35..54c8fc430684 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -6,37 +6,15 @@
 
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
-#ifndef __GCC_ASM_FLAG_OUTPUTS__
-
-/* Use asm goto */
-
-#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
-({									\
-	bool c = false;							\
-	asm goto (fullop "; j" #cc " %l[cc_label]"		\
-			: : [var] "m" (_var), ## __VA_ARGS__		\
-			: clobbers : cc_label);				\
-	if (0) {							\
-cc_label:	c = true;						\
-	}								\
-	c;								\
-})
-
-#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
-/* Use flags output or a set instruction */
-
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
-	asm_inline volatile (fullop CC_SET(cc)				\
-			: [var] "+m" (_var), CC_OUT(cc) (c)		\
+	asm_inline volatile (fullop					\
+			: [var] "+m" (_var), "=@cc" #cc (c)		\
 			: __VA_ARGS__ : clobbers);			\
 	c;								\
 })
 
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
 #define GEN_UNARY_RMWcc_4(op, var, cc, arg0)				\
 	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index d7be1ff3f7e0..00475b814ac4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -491,8 +491,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
 	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
-		     CC_SET(c)
-		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
+		     : "=@ccc"(no_rmpupdate), "=a"(rc)
 		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
 		     : "memory", "cc");
 
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index c72d46175374..5c03aaa89014 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -83,8 +83,7 @@ static inline int __const_sigismember(sigset_t *set, int _sig)
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	bool ret;
-	asm("btl %2,%1" CC_SET(c)
-	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
+	asm("btl %2,%1" : "=@ccc"(ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index c99914569352..46aa2c9c1bda 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -284,8 +284,7 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	 * See movdir64b()'s comment on operand specification.
 	 */
 	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
-		     CC_SET(z)
-		     : CC_OUT(z) (zf), "+m" (*__dst)
+		     : "=@ccz" (zf), "+m" (*__dst)
 		     : "m" (*__src), "a" (__dst), "d" (__src));
 
 	/* Submission failure is indicated via EFLAGS.ZF=1 */
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..91a3fb8ae7ff 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -378,7 +378,7 @@ do {									\
 	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
-		     : CC_OUT(z) (success),				\
+		     : "=@ccz" (success),				\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
 		     : [new] ltype (__new)				\
@@ -397,7 +397,7 @@ do {									\
 	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
-		     : CC_OUT(z) (success),				\
+		     : "=@ccz" (success),				\
 		       "+A" (__old),					\
 		       [ptr] "+m" (*_ptr)				\
 		     : "b" ((u32)__new),				\
@@ -417,11 +417,10 @@ do {									\
 	__typeof__(*(_ptr)) __new = (_new);				\
 	asm volatile("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
-		     CC_SET(z)						\
 		     "2:\n"						\
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
 					   %[errout])			\
-		     : CC_OUT(z) (success),				\
+		     : "=@ccz" (success),				\
 		       [errout] "+r" (__err),				\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index dbe39b44256b..6e1b357c374b 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -108,18 +108,6 @@
 
 #endif
 
-/*
- * Macros to generate condition code outputs from inline assembly,
- * The output operand must be type "bool".
- */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=qm"
-#endif
-
 #ifdef __KERNEL__
 
 /* Exception table entry */
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..e697c20951bc 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -37,7 +37,7 @@ static noinline void workload(int val)
 	accumulator++;
 }
 
-#if (defined(__i386__) || defined(__x86_64__)) && defined(__GCC_ASM_FLAG_OUTPUTS__)
+#if defined(__i386__) || defined(__x86_64__)
 static bool asm_test_bit(long nr, const unsigned long *addr)
 {
 	bool oldbit;
-- 
2.51.0


