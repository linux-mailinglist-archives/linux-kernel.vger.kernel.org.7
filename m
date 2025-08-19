Return-Path: <linux-kernel+bounces-775904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B2B2C621
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0162A7BB8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4BF341AA5;
	Tue, 19 Aug 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cIJShfp6"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E44340D9B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611431; cv=none; b=rh1YB8R4c5Gw4q1ex9Qd/cypXtOYsff/Ml/LtM+B0+Sh3ioumJ4EVZG/GAQ3vAmx/UZ89q2TsWVzlDSSZrH5NMKaxHfu/P/fIWu2eBVMJiXqvq9zBeEDhVr57zgbACM7RUSq35mnBF5bO31DLEtLUWYq7/P1VC0M48JQPaeguzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611431; c=relaxed/simple;
	bh=C/7vu1pdFdl96cDLyMylAeKMWtAacW2yQTWer1AUuXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXYIRxA1x2k0QkNKwj/0KviHtUav25TTzVeT4UtZVa0eSfHzkNr/LBT+ihftHs8lD1rfjvrkSY/yW2fJqeLqNnIUIanf+pQkLFAtXXzEmqzqS1Zn/mcqF7djyC5zIT8+aggP5EMC1aZ3hVX65VNXDpsxM3VMpsW8u2esqg8T+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cIJShfp6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso3276810a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755611429; x=1756216229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwTW7izUdo6CYD8//HAPF56SDtcFaT3RKPdG1y/WRl0=;
        b=cIJShfp6VBxkTfRt5T/D4ilpMnzkBtk6mUS28xue9P0ijUUg+RkVdxPA1mfHrREoYH
         7bTkJu/0Gm2WsUnjRikP6j7uBM9Zjs2JmV5Y4JbL826ucpS7NV5UC+W0p1RVCh3yTHfA
         YRXDg2cRcJbIsZe7d7lYJZBJVl0nfSaKR36Giq7Kej3P2ZZ5HL3TAd9zra5tMBHlPdE6
         uYdtgczMJ9Z7PNNR2kihfJkGAb3wnl954+fIb2dhIcdZtqfGJBVI8UCpzUa2tVUeUoU5
         +sTsAHYyOZQmSuF5Q5SjEDGj+WhezLTyhO9OCBGnD9G91SkDc2fJ8lr2kkR7rWvMhOAS
         uWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611429; x=1756216229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwTW7izUdo6CYD8//HAPF56SDtcFaT3RKPdG1y/WRl0=;
        b=bdu9l8opcl6oR+pNv2pKuWCk/saWckXnnTk9ozxVrfOqhJgEwpqZWQPmsD21wt5bGP
         4W9VmGriy4SZujyA9Bp+LeX+ARDeDmEyLT+LFtgjhPb31yOPk3i0CJYpX5KByoa1iLAq
         zLqY9/D91HZWxTNYb/HrRFwA8HFyABLXvyqCKoCyV90ZKTATqjWmlRfiFnzVrD997MG4
         HGIvGBl1lF8bmJYyymunXr+UdzQhHKXjLpzonYTUNvggdCKTJF9+EURLs6cfHnIj7I6p
         papxz1j2BABxV7xT9L+NwG9SNnj3jqQpXqfN9AcgveNS3RpIJRtVGo0RMDGFWw44OuBh
         VKwA==
X-Forwarded-Encrypted: i=1; AJvYcCWE4UGGwiZcLdIKuoYbveow9NBDD97pNr05T+c0osdL8A9UhUX2lbrwQqkAJCeqv0GwNWpmUyg77qso8gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu77Hl9KY6dIKQc3QlweUgkQH+OqHZmGADuxvA3fT04Mmb3cPK
	FU7kF3c8Ma7aZj23Z3lh9ZDjZqYq6HgNH6kkdCvaA2XkCpNycIL9hRJuYbS31crWihU=
X-Gm-Gg: ASbGncsT11Y/h+7gUyPgJaYXefw0Rf2Bha7KHbOhBAl32qJHmJzELiwlmDICNfGsfw2
	UKNMySP393kX7LWkmoSS/fbV0yvD6G/LQASTJYz8AA10SNlKdv6aR2lzLBWRkbisx2UEGBhA2iH
	3uOCl/qltH75WY1mK9Efh6Y9rwcsKe8MBIewfKohopzzDHQCW+M3BKxzQM/nFUSP3gnen/fDDpH
	aFlWkkuNgm0b/uBKCKp2Wqu2epy274ydTYSz8guMBhA2OXQWlRHEiF9zR+VpW/AcW0yDSGx9pjJ
	wlZnshlf9v/cR57/wH8p1ZWP9EvsgbcW628nblkpSfb93HEVk9pCdcdZ+kM+RGqt5PQupaGnFCP
	woKA49sVn72V9YFgMECdcN5j49wHRJV2fdLcPoaF47r6xf9/BEgwxhttJ
X-Google-Smtp-Source: AGHT+IG3M4152x1Qa0AohjmhQrhbPKACbweaZeZYf2EtQOf2Ag/TgiWDxzHEJsq3FzMfjcT7SEZo1A==
X-Received: by 2002:a17:902:e545:b0:243:8f:6d7d with SMTP id d9443c01a7336-245e04e232fmr28790075ad.50.1755611429240;
        Tue, 19 Aug 2025 06:50:29 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5533c4sm109937815ad.140.2025.08.19.06.50.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Aug 2025 06:50:28 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH 2/2] riscv: introduce percpu.h into include/asm
Date: Tue, 19 Aug 2025 21:50:07 +0800
Message-Id: <20250819135007.85646-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250819135007.85646-1-cuiyunhui@bytedance.com>
References: <20250819135007.85646-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current percpu operations rely on generic implementations, where
raw_local_irq_save() introduces substantial overhead. Optimization
is achieved through atomic operations and preemption disabling.

Since RISC-V does not support lr/sc.b/h, when ZABHA is not supported,
we need to use lr/sc.w instead, which requires some additional mask
operations. In fact, 8/16-bit per-CPU operations are very few. The
counts during system startup are as follows:
Reads: 8-bit: 3, 16-bit: 3, 32-bit: 1531, 64-bit: 471
Writes: 8-bit: 4, 16-bit: 3, 32-bit: 32, 64-bit: 238
Adds: 8-bit: 3, 16-bit: 3, 32-bit: 31858, 64-bit: 7656
Add-Returns: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 2
ANDs: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 0
ANDNOTs: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 0
ORs: 8-bit: 0, 16-bit: 0, 32-bit: 70, 64-bit: 0

hackbench -l 1000:
Reads: 8-bit: 3, 16-bit: 3, 32-bit: 1531, 64-bit: 2522158
Writes: 8-bit: 4, 16-bit: 3, 32-bit: 34, 64-bit: 2521522
Adds: 8-bit: 3, 16-bit: 3, 32-bit: 47771, 64-bit: 19911
Add-Returns: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 2
ANDs: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 0
ANDNOTs: 8-bit: 0, 16-bit: 0, 32-bit: 0, 64-bit: 0
ORs: 8-bit: 0, 16-bit: 0, 32-bit: 70, 64-bit: 0

Based on this, 8bit/16bit per-CPU operations can directly fall back to
the generic implementation.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 0000000000000..5a1fdb37a8056
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#include <linux/preempt.h>
+
+#define PERCPU_RW_OPS(sz)						\
+static inline unsigned long __percpu_read_##sz(void *ptr)		\
+{									\
+	return READ_ONCE(*(u##sz *)ptr);				\
+}									\
+									\
+static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
+{									\
+	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
+}
+
+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
+static inline void							\
+__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
+{									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " zero, %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr)				\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+}
+
+#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)		\
+static inline u##sz							\
+__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
+{									\
+	register u##sz ret;						\
+									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr), [ret] "=r" (ret)		\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+									\
+	return ret + val;						\
+}
+
+#define PERCPU_OP(name, amo_insn)					\
+	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
+	__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
+
+#define PERCPU_RET_OP(name, amo_insn)					\
+	__PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)		\
+	__PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
+
+PERCPU_RW_OPS(8)
+PERCPU_RW_OPS(16)
+PERCPU_RW_OPS(32)
+PERCPU_RW_OPS(64)
+
+PERCPU_OP(add, add)
+PERCPU_OP(andnot, and)
+PERCPU_OP(or, or)
+PERCPU_RET_OP(add, add)
+
+#undef PERCPU_RW_OPS
+#undef __PERCPU_AMO_OP_CASE
+#undef __PERCPU_AMO_RET_OP_CASE
+#undef PERCPU_OP
+#undef PERCPU_RET_OP
+
+#define _pcp_protect(op, pcp, ...)					\
+({									\
+	preempt_disable_notrace();					\
+	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
+	preempt_enable_notrace();					\
+})
+
+#define _pcp_protect_return(op, pcp, args...)				\
+({									\
+	typeof(pcp) __retval;						\
+	preempt_disable_notrace();					\
+	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
+	preempt_enable_notrace();					\
+	__retval;							\
+})
+
+#define this_cpu_read_1(pcp)		_pcp_protect_return(__percpu_read_8, pcp)
+#define this_cpu_read_2(pcp)		_pcp_protect_return(__percpu_read_16, pcp)
+#define this_cpu_read_4(pcp)		_pcp_protect_return(__percpu_read_32, pcp)
+#define this_cpu_read_8(pcp)		_pcp_protect_return(__percpu_read_64, pcp)
+
+#define this_cpu_write_1(pcp, val)	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+#define this_cpu_write_2(pcp, val)	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+#define this_cpu_write_4(pcp, val)	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+#define this_cpu_write_8(pcp, val)	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+
+#define this_cpu_add_4(pcp, val)	_pcp_protect(__percpu_add_amo_case_32, pcp, val)
+#define this_cpu_add_8(pcp, val)	_pcp_protect(__percpu_add_amo_case_64, pcp, val)
+
+#define this_cpu_add_return_4(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
+
+#define this_cpu_add_return_8(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
+
+#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
+#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
+
+#define this_cpu_or_4(pcp, val)	_pcp_protect(__percpu_or_amo_case_32, pcp, val)
+#define this_cpu_or_8(pcp, val)	_pcp_protect(__percpu_or_amo_case_64, pcp, val)
+
+#define this_cpu_xchg_1(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_8(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+
+#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	u128 old__, new__, ret__;					\
+	pcp_op_T__ *ptr__;						\
+	old__ = o;							\
+	new__ = n;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128_local(ptr__, old__, new__);			\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
-- 
2.39.5


