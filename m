Return-Path: <linux-kernel+bounces-860075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30799BEF418
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FC764EB598
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27D2BE636;
	Mon, 20 Oct 2025 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TI7PAg8e"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95672BE7CB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934315; cv=none; b=UG8kspCM4USVZdc0IkBVPXr+LtxOmEmgb/UnXFZ+fHisOkWUmkmvt6qYI+KyENvHzzTucIBPY8eUJbvRr9fLjBvg2STFJIcURZI6foLlWdSJqBT6800RfQpYhiaI5camS1KaG7UdsLCgNx8bUo3U1E1DdtY/wY223uMzJBhvj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934315; c=relaxed/simple;
	bh=2UrLom+8S0YfMeVr+t5kLx1uY2+UanG/i4doYApCDfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfeSHpjIP3QKGUEh0+1Pg/hyRqW1RNEA8GI94gtfMTfLV7jvwCFWwr7ucr/d7GRx1yRuQ6WN8PuYukBs9imG4k3QWSOq1Uqu/rqqCl1/w2/Eskyy3OeVsygywy3XOIyPBd5J/i6Johgt9sd+7/zsRi44X/vVtLnSYO4/HDSjpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TI7PAg8e; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2378679a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934311; x=1761539111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPcskIG/1ay0sXA6LTmEjesE/nyn+okHLSoMKeTK/t4=;
        b=TI7PAg8etcfGL3hzAEpu7CylxGLeoIKdbrIdxkjRnZ25lrDKDceBjE+6QcDpnWxYKA
         UdsZJSYCghNutnaP1nfYyoQsdyMVyBYHImZmZ78/T0QJKMz3lKvfbi4URxsCtMHroFMF
         2BU9+0yRwNwOVEfxC+z6t+NDe6lM4u9uRmc35kVU01wIL2V3vFCcMwTuHd846XigF8nw
         nDhfatDjSv6aq76ZXOyJEOanV1Ofsr6siwXu6EfwDPRgSDXCOyAfRNujsGZtly4VqxKZ
         F9K/i3E8YXfhbsdbvxexNTTVnIbGqsrFexIvoIvvvI6Lq8qeDr0J6mF+stcpKsG/niKA
         yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934311; x=1761539111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPcskIG/1ay0sXA6LTmEjesE/nyn+okHLSoMKeTK/t4=;
        b=r5NIgxihnoi+AU/JL8DEwZ+3sVRFynkImAnekR4Jznji9IHtcGDybgANJ8F2rO+T4O
         SCZqLc8oqbIeHkhP002tL2yDpyZT5pUGLuVd5zzKDrPMJ9Y0yx1P8ekf4upifULjy5bu
         65pRP1fc29F0bPSf1hlxDvYVXMZG467i4+zo8QEOPsXPFw9I7PKF8/Hn8NOaDMqs83aD
         A7+oUPOrk1OkfUHQyuupXeWNZndqutRQ55pHLVzk3Ogx20HmQoXNvXm9w8FEaNToJZWa
         Uf8saRLnZcooJGkIyZBgAusW9lL5qKeCf8iOPBW+XcHc4Cd4L7NKT0d2ASzUN6vnhN6m
         +5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrmVAtue9MSHxTboCEaMEWZ8b+zE8K8cZKcDGq0Ua+tndEudza8t7RHf3ddQO17zFfrWJgIWkaSX1xPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAzRgO2NEAdUHxGjyhkfcKZx5zTFSA394ZfZgGcdbpN3Xl/xk
	zibHJbsPBA/xjAKSpEfUsNQ1mU/bgujo0kAYSElA8O1Um9jmhbWzjCND5Ip6Nhw8udw=
X-Gm-Gg: ASbGncturdtPAXoa4KBcxbeh7phhesVDizGXvW8m1W+neT4zy4g4HZlIpxKO/49c3Ow
	gmS8TovqKfSbP0W0UrDu3j/ICgFTz5wXcq0E6xsGuaqf4rMPGVh/XpVopxJmfQ9z1wNUOb/hHj0
	WJB9JybKKEwyAvL92IQ3IaJt1ddYhrTdulLkewY9XCWskWq+IN8vymD6VJBDBmBGbNa/Vhysj2M
	R58cRhWb/NvJgPnuv4ex9nM9tSUj0HzOCG0SzId+m5aAhY2bDhqEoiamRkbz5U5xBpr2FFd8NZA
	CN831LyBxGAhs0SrRbwrLNzpTaj1KUx8LQN0a5ZUj+D7kwafpOutbWRmHH8mFqbx8tp8hzWZtHK
	i8W3U08pl7UnqsbUGFuzOYTjgxyy90ADqZ32BagcVXMXQEGRD3tpLcnG7aSHc89SJLJOM9pB+zn
	Sc8sxDAgo3xbuChedGu8g7pGBehjKkBcD4n0VXXLmd4Dj3zjSluyXgkrzbvV5hjZpjHXBmWfvF3
	ST4AyFilNIE
X-Google-Smtp-Source: AGHT+IEujhnClojcicPbj3y6ytDrc6WWv+RwekLkEKlFozxNxVRIRtmsdedEqStzjhfQZMJDA0LXfw==
X-Received: by 2002:a17:902:f647:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290cb65c5b1mr125810595ad.45.1760934311032;
        Sun, 19 Oct 2025 21:25:11 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm68319325ad.7.2025.10.19.21.25.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:25:10 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 05/10] riscv: Apply Zalasr to smp_load_acquire/smp_store_release
Date: Mon, 20 Oct 2025 12:24:52 +0800
Message-ID: <20251020042457.30915-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
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
|    | l{b|h|w|d}.aq | l{b|h|w|d}  |
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


