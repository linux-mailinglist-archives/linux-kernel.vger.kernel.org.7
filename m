Return-Path: <linux-kernel+bounces-824148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DEB88403
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A898BB62AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDB2F0C45;
	Fri, 19 Sep 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gs6YdGaS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1682ED853
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267504; cv=none; b=TEVwMZPie36TwIT1/hFJu0ZUyTuziqKT7DsvYXaOCQCjygt/Lyux5zuZWo0L7Pza5xElnGw/oQGb7XYp1dn4RgxNCdAoUhXKenj9Ganr1rnAcUlx68bwgxGnc/FBFnnnhuEMbH3DcEinxVKarj5HQgHCG4LgWQbNB9bg9LuA/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267504; c=relaxed/simple;
	bh=4Wtbcd89p34NfKT5wCJUueETmGBbCNHpcCNYAQ7CVuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRn0QUyBpwBq5qxQwcqqk9nKT9HQTO+fgs/fcb/ZbZx0MDLZDDCYKhxwJHXxz4IjPMnzs037gVOn7+ZoXoz1lZ+Vx76E6DisdIGddLflZVJkGULmZEfVZjGEZUqiE4H2DgTe/htJuNiNmFk3wUJhITC4Oy0qMvydZ49tkioL9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gs6YdGaS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1836770b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267501; x=1758872301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrUXReFmfyicqjIKReJGDbVrjEBweEul9LJXTVHzmk4=;
        b=gs6YdGaSS7PaeGNOfBsj7ZhAO13XRJq/q7WGbovjoR1nj5lAPWqipPObpVcKUTz6wR
         I5025xGlMkbnOXfNrEZA5rzdL4Kqqbb4URyFKaCJgkAFBHSnjr+EBiKXdYRJgEuOm9rf
         N63bQ3I8oOpzF54g0/miOqtyOyLLVqhHOS9UHivDBaa0u0NPa87RF9MRcT2GgkyZirCZ
         D25qxrMOgajH4FpWc1DjgX/aMGw4X1ijB9GNusWqBYGcHqrj9bLmimaGZsDWeCsr3chu
         w8hrn7kYgegyvr5I8mM77wGHFBjStIPPaCHTU9xPrgyns8QSPyKj7Sj7TNSOQJBHY4G9
         jE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267501; x=1758872301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrUXReFmfyicqjIKReJGDbVrjEBweEul9LJXTVHzmk4=;
        b=B4a8ZvthkEGB2FitjU9XEbZyQf8whkID89mzOVGJwBJODRK52sLnwMMdDgCx9sGuA9
         2Dal+7vTmAZVbhdh9h43RU+5AFwlSPHqckryHgfjPapk7lrYZiLnUvkQCiMvessplFMp
         B4QkouxD9l5mT5bu+stXcubY5/YP7h3YnLP0lTqQzaQ0F+h/5FZorpZJoyBx/nxNAQ03
         1A4o0eUiKImqodYeLb+dSUvrIm5p+tCZv4Z2DVbGqs3cr1luJIQs6Bmg9wHjU26uc0Ar
         VpZ7y2V5bWXSMmdOZtgtOnnEtBRCjJU9vT/+Dmhko6qwz52ns1/JbGxLp7XQ9JqrIo59
         e+2A==
X-Forwarded-Encrypted: i=1; AJvYcCV+qqfvMEjSYTOrfFi/pv4jpGLq+TaT+er5KRcLNKd7h/QlbEx4xJdSkvppxn1ry8LdcXPE8fJD8zeIEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEf+QtIOsr2D2XEvHEKv08NyX1iksbRLonBhnyr9DnxiHwg2l
	+cVrjSt+ArySFATHlPq0B04bgct+zbgVPSnq6UQ94D630YJ1Zd/6x51uYTug552mO48=
X-Gm-Gg: ASbGncsmEbTHal9EARchE11HjIiz1rbe1LRykc4aD8UwVPCNihyGH+qpchgxl2cB9aP
	47gpwHWVfgjaKa/9xPhn7jYsBH1giDwLq2CumEVvVCvn47aIxHenBVN6GuE7Ps9AW2OA9fgmA4p
	yjX2Cuk8Oa6KVoCYHUB7q5GbtF/BPgNfwiZ6nc8FnTi2IPtTDhA8bz3JBVvPnBp19fK8mTfWrlh
	RPwcJSxwT4xo6Ew1VOvoTzEUF4dODcyfKoCE4J8DqLGkLzBc00Dp32Nsd1GsiITMeLbezd0Fck4
	nx5eWTJ5ypO1OzR40Xs6F/ktld18IeIxwIKL5f6AeVyNGUWVzDRD8mTYURAz4rwreew7etE8ycC
	iyPpmYKwoi6yGreYdxqGcdQXelYzZtSRSMaoJue8fU6TmLA0TP+wijwr6AT+5c8inDYsRUbMryk
	ZZbSsA2V6lP1D4ufgqOL5Es70ltTgUD5f6DdsFsZU1/g==
X-Google-Smtp-Source: AGHT+IHO/IBu5KluVEBZTCVVCP8FOuGD/BwTuyZsvB1MFOiJrJSLMwCJJx47GpnoAoobwSIeA0YuxQ==
X-Received: by 2002:a05:6a21:6d9c:b0:247:b1d9:774 with SMTP id adf61e73a8af0-292588a2f9bmr3836926637.5.1758267501051;
        Fri, 19 Sep 2025 00:38:21 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.38.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:38:20 -0700 (PDT)
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
Subject: [PATCH v3 5/8] riscv: Use Zalasr for smp_load_acquire/smp_store_release
Date: Fri, 19 Sep 2025 15:37:11 +0800
Message-ID: <20250919073714.83063-6-luxu.kernel@bytedance.com>
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

Replace fence instructions with Zalasr instructions during
smp_load_acquire() and smp_store_release() operations.

|----------------------------------|
|    |     __smp_store_release     |
|    |-----------------------------|
|    | zalasr        | !zalasr     |
| rl |-----------------------------|
|    | s{b|h|w|d}.rl | fence rw, w |
|    |               | s{b|h|w|d}  |
|----------------------------------|
|    |    __smp_load_acquire       |
|    |-----------------------------|
|    | zalasr        | !zalasr     |
| aq |-----------------------------|
|    | l{b|h|w|d}.rl | l{b|h|w|d}  |
|    |               | fence r, rw |
|----------------------------------|

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/barrier.h | 91 ++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index b8c5726d86acb..9eaf94a028096 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -51,19 +51,88 @@
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)
 
-#define __smp_store_release(p, v)					\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw, w);						\
-	WRITE_ONCE(*p, v);						\
+extern void __bad_size_call_parameter(void);
+
+#define __smp_store_release(p, v)						\
+do {										\
+	typeof(p) __p = (p);							\
+	union { typeof(*p) __val; char __c[1]; } __u =				\
+		{ .__val = (__force typeof(*p)) (v) };				\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
+					 SB_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u8 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsh %0, 0(%1)\t\n",	\
+					 SH_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u16 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsw %0, 0(%1)\t\n",	\
+					 SW_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u32 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsd %0, 0(%1)\t\n",	\
+					 SD_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (*(__u64 *)__u.__c), "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
 } while (0)
 
-#define __smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r, rw);						\
-	___p1;								\
+#define __smp_load_acquire(p)							\
+({										\
+	union { typeof(*p) __val; char __c[1]; } __u;				\
+	typeof(p) __p = (p);							\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("lb %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LB_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u8 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("lh %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LH_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u16 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("lw %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LW_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u32 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("ld %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LD_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (*(__u64 *)__u.__c) : "r" (__p)	\
+					 : "memory");				\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
+	__u.__val;								\
 })
 
 #ifdef CONFIG_RISCV_ISA_ZAWRS
-- 
2.20.1


