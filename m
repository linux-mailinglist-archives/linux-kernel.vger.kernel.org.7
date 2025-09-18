Return-Path: <linux-kernel+bounces-794351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5BB3E06E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E94200414
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9553101AA;
	Mon,  1 Sep 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrwD6VPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F02494F8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723142; cv=none; b=UkDZKgN2Vhz/C7tog15xlgej92Dl18kUbv2MP7FnYbT8GDK7MnOTvDB03oVI625ShH83WJSWbwXt3RxZ7e+jcwdKS0Q62x1s+W9yD32EgrPrVdr7vloXURZEEkmQNy5MlOGHPjpLo/Vpe0RGIyllqrakA4LlNKgujzh76UoTq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723142; c=relaxed/simple;
	bh=8W/KvuCWW+VFgsRBhS/FkFyPyLH/40RCuzTQ8qOpBOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLkN47VLjYxKn26Xzes09O2yIKFVeNOvyDw83WrpNVe6L+7iRiz6C85g8mvkjjQ3WLXNi/QlfRJiQ2h9JHZhKgwD+PAlpRcuw4VfJSpzelnS8kBk/VUafU4oap2IBS8SsERIe93md8Pw7tKFjLITOjd7fl+GBWhPUfZiHaw2PJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrwD6VPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 895A3C4CEF0;
	Mon,  1 Sep 2025 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756723141;
	bh=8W/KvuCWW+VFgsRBhS/FkFyPyLH/40RCuzTQ8qOpBOw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SrwD6VPLeE/ueJkU+9lgvCJ25j9Vg1ZBq1gwhit32inttqtAr66hopVvz1lxFcGbe
	 WgnkrQmdliL5pXezv7A41GXEjVIvtIsi3/OFZFTLBypb3jHiATSarKz7AYrOfhAc2j
	 R02qvVO+hEuKks1wldn0ZS89FoNGmpxtge9oU9gTpkf7p/fHP/ZB0SqWcIk3KRSPSh
	 5rxMkDpmWLHFtu1uDasxVXw+Tr2Js3vdHMAvt5hAQNMg8oUA7KObnD+EBsMLF6pput
	 sg/Ca2HAuT0KTCpYs7RFLuOK1oy5D4xXRt0iGR1j/rC3P38TL8wfAU+rczIUigSzz8
	 SOq1UX9UUBtXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B87CA1002;
	Mon,  1 Sep 2025 10:39:01 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Mon, 01 Sep 2025 12:38:14 +0200
Subject: [PATCH v3] riscv: Use Zalrsc extension to implement atomic
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-p8700-zalrsc-v3-1-ec64fabbe093@htecgroup.com>
X-B4-Tracking: v=1; b=H4sIAJV3tWgC/zXMQQ6CMBCF4auQWTuklEorK+9hXFSYwkSgZGqMk
 XB3q4mrl2/x/g0SCVOCtthA6MmJ45JRHwroRr8MhNxng1b6qGxlcHVWKXz7SVKHoXYncyOjetV
 AvqxCgV+/3OWaHSTO+BiF/D9iKp1D7rtl3VhtsUIvfPdTPA+z56ns4gz7/gEadHmnmQAAAA==
X-Change-ID: 20250714-p8700-zalrsc-f3894be40d06
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Mark Rutland <mark.rutland@arm.com>, Yury Norov <yury.norov@gmail.com>, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>, 
 Jessica Clarke <jrtc27@jrtc27.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chao-ying Fu <cfu@mips.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756723140; l=19816;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=M7fbSkXz/yn8nlKypMSIOu5iE6Pv03bLnBbMzMfzAn4=;
 b=Xzxy18LcxUl9LRpvzfhczHyBP1V3j1p054uwFTUrqJlvA4QTJA6wtlWhKy1Eb5jh/jl6FtBgz
 J0VqM1BC+uMDZFsHm2vhqjXZy/E26iJVgU2gVVFKfITmKKYN6YqUalB
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=Dn4KMnDdgyhlXJNspQQrlHJ04i7/irG29p2H27Avd+8=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250806
 with auth_id=476
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Chao-ying Fu <cfu@mips.com>

Use only LR/SC instructions to implement atomic functions.

Add config ERRATA_MIPS_P8700_AMO_ZALRSC.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Co-developed-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
This patch depends on [1], which implements errata support for the MIPS p8700.

Changes in v3:
- Use alternatives to replace AMO instructions with LR/SC
- Rebase on Alexandre Ghiti's "for-next" branch.
- Link to v2: https://lore.kernel.org/linux-riscv/20241225082412.36727-1-arikalo@gmail.com/

[1] https://lore.kernel.org/linux-riscv/20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com/
---
 arch/riscv/Kconfig.errata                    |  11 ++
 arch/riscv/errata/mips/errata.c              |  13 +-
 arch/riscv/include/asm/atomic.h              |  29 ++--
 arch/riscv/include/asm/bitops.h              |  28 ++--
 arch/riscv/include/asm/cmpxchg.h             |   9 +-
 arch/riscv/include/asm/errata_list.h         | 215 +++++++++++++++++++++++++++
 arch/riscv/include/asm/errata_list_vendors.h |   3 +-
 arch/riscv/include/asm/futex.h               |  41 ++---
 arch/riscv/kernel/entry.S                    |  10 +-
 9 files changed, 291 insertions(+), 68 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index ac64123433e717d3cd4a6d107f1328d27297f9cc..d0bbdbc4fb753e83432c094d58075a3ec17bb43d 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -44,6 +44,17 @@ config ERRATA_MIPS_P8700_PAUSE_OPCODE
 
 	   If you are not using the P8700 processor, say n.
 
+config ERRATA_MIPS_P8700_AMO_ZALRSC
+	bool "Replace AMO instructions with LR/SC on MIPS P8700"
+	depends on ERRATA_MIPS && 64BIT
+	default n
+	help
+	   The MIPS P8700 does not implement the full A extension,
+	   implementing only Zalrsc. Enabling this will replace
+	   all AMO instructions with LR/SC instructions on the P8700.
+
+	   If you are not using the P8700 processor, say n.
+
 config ERRATA_SIFIVE
 	bool "SiFive errata"
 	depends on RISCV_ALTERNATIVE
diff --git a/arch/riscv/errata/mips/errata.c b/arch/riscv/errata/mips/errata.c
index e984a8152208c34690f89d8101571b097485c360..08c5efd58bf242d3831957f91f6338ef49f61238 100644
--- a/arch/riscv/errata/mips/errata.c
+++ b/arch/riscv/errata/mips/errata.c
@@ -23,13 +23,22 @@ static inline bool errata_probe_pause(void)
 	return true;
 }
 
-static u32 mips_errata_probe(void)
+static inline bool errata_probe_zalrsc(unsigned long archid)
+{
+	return archid == 0x8000000000000201;
+}
+
+static u32 mips_errata_probe(unsigned long archid)
 {
 	u32 cpu_req_errata = 0;
 
 	if (errata_probe_pause())
 		cpu_req_errata |= BIT(ERRATA_MIPS_P8700_PAUSE_OPCODE);
 
+	if (errata_probe_zalrsc(archid))
+		cpu_req_errata |= BIT(ERRATA_MIPS_P8700_ZALRSC);
+
+
 	return cpu_req_errata;
 }
 
@@ -38,7 +47,7 @@ void mips_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			    unsigned int stage)
 {
 	struct alt_entry *alt;
-	u32 cpu_req_errata = mips_errata_probe();
+	u32 cpu_req_errata = mips_errata_probe(archid);
 	u32 tmp;
 
 	BUILD_BUG_ON(ERRATA_MIPS_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5b96c2f61adb596caf8ee6355d4ee86dbc19903b..fadfbc30ac1a93786bfd32c3980d256361cc1e95 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -54,12 +54,9 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 static __always_inline							\
 void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
 {									\
-	__asm__ __volatile__ (						\
-		"	amo" #asm_op "." #asm_type " zero, %1, %0"	\
-		: "+A" (v->counter)					\
-		: "r" (I)						\
-		: "memory");						\
-}									\
+	register __maybe_unused c_type ret, temp;			\
+	ALT_ATOMIC_OP(asm_op, I, asm_type, v, ret, temp);		\
+}
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, I)					\
@@ -89,24 +86,16 @@ static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
 					     atomic##prefix##_t *v)	\
 {									\
-	register c_type ret;						\
-	__asm__ __volatile__ (						\
-		"	amo" #asm_op "." #asm_type " %1, %2, %0"	\
-		: "+A" (v->counter), "=r" (ret)				\
-		: "r" (I)						\
-		: "memory");						\
+	register __maybe_unused c_type ret, temp;			\
+	ALT_ATOMIC_FETCH_OP_RELAXED(asm_op, I, asm_type, v, ret, temp);	\
 	return ret;							\
 }									\
 static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
-{									\
-	register c_type ret;						\
-	__asm__ __volatile__ (						\
-		"	amo" #asm_op "." #asm_type ".aqrl  %1, %2, %0"	\
-		: "+A" (v->counter), "=r" (ret)				\
-		: "r" (I)						\
-		: "memory");						\
-	return ret;							\
+{										\
+	register __maybe_unused c_type ret, temp;				\
+	ALT_ATOMIC_FETCH_OP(asm_op, I, asm_type, v, ret, temp);			\
+	return ret;								\
 }
 
 #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2ba70caeb7b9b0e9221882117583f5..02955d3d573d92ffca7beb4b75f039df056cd6ec 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -187,30 +187,27 @@ static __always_inline int variable_fls(unsigned int x)
 
 #if (BITS_PER_LONG == 64)
 #define __AMO(op)	"amo" #op ".d"
+#define __LR	"lr.d"
+#define __SC	"sc.d"
 #elif (BITS_PER_LONG == 32)
 #define __AMO(op)	"amo" #op ".w"
+#define __LR	"lr.w"
+#define __SC	"sc.w"
 #else
 #error "Unexpected BITS_PER_LONG"
 #endif
 
 #define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
 ({								\
-	unsigned long __res, __mask;				\
+	__maybe_unused unsigned long __res, __mask, __temp;				\
 	__mask = BIT_MASK(nr);					\
-	__asm__ __volatile__ (					\
-		__AMO(op) #ord " %0, %2, %1"			\
-		: "=r" (__res), "+A" (addr[BIT_WORD(nr)])	\
-		: "r" (mod(__mask))				\
-		: "memory");					\
+	ALT_TEST_AND_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __mask, __temp);	 \
 	((__res & __mask) != 0);				\
 })
 
 #define __op_bit_ord(op, mod, nr, addr, ord)			\
-	__asm__ __volatile__ (					\
-		__AMO(op) #ord " zero, %1, %0"			\
-		: "+A" (addr[BIT_WORD(nr)])			\
-		: "r" (mod(BIT_MASK(nr)))			\
-		: "memory");
+	__maybe_unused unsigned long __res, __temp;				\
+	ALT_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __temp);
 
 #define __test_and_op_bit(op, mod, nr, addr) 			\
 	__test_and_op_bit_ord(op, mod, nr, addr, .aqrl)
@@ -354,12 +351,9 @@ static __always_inline void arch___clear_bit_unlock(
 static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
-	unsigned long res;
-	__asm__ __volatile__ (
-		__AMO(xor) ".rl %0, %2, %1"
-		: "=r" (res), "+A" (*addr)
-		: "r" (__NOP(mask))
-		: "memory");
+	__maybe_unused unsigned long res, temp;
+
+	ALT_ARCH_XOR_UNLOCK(mask, addr, res, temp);
 	return (res & BIT(7)) != 0;
 }
 
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 80bd52363c68690f33bfd54e0cc40399cd60b57b..290745a03d06062714716491668178f37670f85c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -56,13 +56,8 @@
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
-	__asm__ __volatile__ (						\
-		prepend							\
-		"	amoswap" sfx " %0, %2, %1\n"			\
-		append							\
-		: "=r" (r), "+A" (*(p))					\
-		: "r" (n)						\
-		: "memory");						\
+	__typeof__(*(__ptr)) __maybe_unused temp;					\
+	ALT_ARCH_XCHG(sfx, prepend, append, r, p, n, temp);	\
 })
 
 #define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 6694b5ccdcf85cfe7e767ea4de981b34f2b17b04..481af503e88f4917e54d016b5d875593c016818e 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -25,6 +25,7 @@ ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
 	    __stringify(RISCV_PTR sifive_cip_453_page_fault_trp),	\
 	    SIFIVE_VENDOR_ID, ERRATA_SIFIVE_CIP_453,			\
 	    CONFIG_ERRATA_SIFIVE_CIP_453)
+
 #else /* !__ASSEMBLER__ */
 
 #define ALT_SFENCE_VMA_ASID(asid)					\
@@ -53,6 +54,220 @@ asm(ALTERNATIVE(	\
 	: /* no inputs */	\
 	: "memory")
 
+#ifdef CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC
+#define ALT_ATOMIC_OP(asm_op, I, asm_type, v, ret, temp)		\
+asm(ALTERNATIVE(							\
+		"	amo" #asm_op "." #asm_type " zero, %3, %0\n"	\
+		__nops(3),						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n",					\
+		MIPS_VENDOR_ID,						\
+		ERRATA_MIPS_P8700_ZALRSC,				\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)			\
+	: "+A" (v->counter), "=&r" (ret), "=&r" (temp)			\
+	: "r" (I)							\
+	: "memory")
+
+#define ALT_ATOMIC_FETCH_OP_RELAXED(asm_op, I, asm_type, v, ret, temp)	\
+asm(ALTERNATIVE(							\
+		"	amo" #asm_op "." #asm_type " %1, %3, %0\n"	\
+		__nops(3),						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n",					\
+		MIPS_VENDOR_ID,						\
+		ERRATA_MIPS_P8700_ZALRSC,				\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)			\
+	: "+A" (v->counter), "=&r" (ret), "=&r" (temp)			\
+	: "r" (I)							\
+	: "memory")
+
+#define ALT_ATOMIC_FETCH_OP(asm_op, I, asm_type, v, ret, temp)		\
+asm(ALTERNATIVE(							\
+		"	amo" #asm_op "." #asm_type ".aqrl  %1, %3, %0\n"\
+		__nops(3),						\
+		"1:	lr." #asm_type ".aqrl %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type ".aqrl %2, %2, %0\n"		\
+		"	bnez %2, 1b\n",					\
+		MIPS_VENDOR_ID,						\
+		ERRATA_MIPS_P8700_ZALRSC,				\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)			\
+	: "+A" (v->counter), "=&r" (ret), "=&r" (temp)			\
+	: "r" (I)							\
+	: "memory")
+/* BITOPS.h */
+#define ALT_TEST_AND_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __mask, __temp)	\
+asm(ALTERNATIVE(								\
+		__AMO(op) #ord " zero, %3, %1\n"				\
+		__nops(3),							\
+		"1: " __LR #ord " %0, %1\n"					\
+		#op " %2, %0, %3\n"						\
+		__SC #ord " %2, %2, %1\n"					\
+		"bnez %2, 1b\n",						\
+		MIPS_VENDOR_ID,							\
+		ERRATA_MIPS_P8700_ZALRSC,					\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)				\
+	: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)		\
+	: "r" (mod(__mask))							\
+	: "memory")
+
+#define ALT_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __temp)		\
+asm(ALTERNATIVE(							\
+		__AMO(op) #ord " zero, %3, %1\n"			\
+		__nops(3),						\
+		"1: " __LR #ord " %0, %1\n"				\
+		#op " %2, %0, %3\n"					\
+		__SC #ord " %2, %2, %1\n"				\
+		"bnez %2, 1b\n",					\
+		MIPS_VENDOR_ID,						\
+		ERRATA_MIPS_P8700_ZALRSC,				\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)			\
+	: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
+	: "r" (mod(BIT_MASK(nr)))					\
+	: "memory")
+
+#define ALT_ARCH_XOR_UNLOCK(mask, addr, __res, __temp)	\
+asm(ALTERNATIVE(					\
+		__AMO(xor) ".rl %0, %3, %1\n"		\
+		__nops(3),				\
+		"1: " __LR ".rl %0, %1\n"		\
+		"xor %2, %0, %3\n"			\
+		__SC ".rl %2, %2, %1\n"			\
+		"bnez %2, 1b\n",			\
+		MIPS_VENDOR_ID,				\
+		ERRATA_MIPS_P8700_ZALRSC,		\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)	\
+	: "=&r" (__res), "+A" (*addr), "=&r" (__temp)	\
+	: "r" (__NOP(mask))				\
+	: "memory")
+
+#define ALT_ARCH_XCHG(sfx, prepend, append, r, p, n, temp)	\
+asm(ALTERNATIVE(						\
+		prepend						\
+		"	amoswap" sfx " %0, %3, %1\n"		\
+	    __nops(2)						\
+		append,						\
+		prepend						\
+		"1:	lr" sfx " %0, %1\n"			\
+		"	sc" sfx " %2, %3, %1\n"			\
+		"	bnez %2, 1b\n"				\
+		append,						\
+		MIPS_VENDOR_ID,					\
+		ERRATA_MIPS_P8700_ZALRSC,			\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)		\
+	: "=&r" (r), "+A" (*(p)), "=&r" (temp)			\
+	: "r" (n)						\
+	: "memory")
+
+/* FUTEX.H */
+#define ALT_FUTEX_ATOMIC_OP(insn, ret, oldval, uaddr, oparg, temp)	\
+asm(ALTERNATIVE(							\
+		"1: amo" #insn ".w.aqrl %[ov],%z[op],%[u]\n"		\
+		__nops(3)						\
+		"2:\n"							\
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r]),			\
+		"1:	lr.w.aqrl %[ov], %[u]\n"			\
+		"	" #insn" %[t], %[ov], %z[op]\n"			\
+		"	sc.w.aqrl %[t], %[t], %[u]\n"			\
+		"	bnez %[t], 1b\n"				\
+		"2:\n"							\
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r]),			\
+		MIPS_VENDOR_ID,						\
+		ERRATA_MIPS_P8700_ZALRSC,				\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)			\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),				\
+	  [t] "=&r" (temp), [u] "+m" (*uaddr)				\
+	: [op] "Jr" (oparg)						\
+	: "memory")
+
+#define ALT_FUTEX_ATOMIC_SWAP(ret, oldval, uaddr, oparg, temp)	\
+asm(ALTERNATIVE(						\
+		"1: amoswap.w.aqrl %[ov],%z[op],%[u]\n"		\
+		__nops(3)					\
+		"2:\n"						\
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r]),		\
+		"1:	lr.w.aqrl %[ov], %[u]\n"		\
+		"	mv %[t], %z[op]\n"			\
+		"	sc.w.aqrl %[t], %[t], %[u]\n"		\
+		"	bnez %[t], 1b\n"			\
+		"2:\n"						\
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r]),		\
+		MIPS_VENDOR_ID,					\
+		ERRATA_MIPS_P8700_ZALRSC,			\
+		CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)		\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),			\
+	  [t] "=&r" (temp), [u] "+m" (*uaddr)			\
+	: [op] "Jr" (oparg)					\
+	: "memory")
+
+#else
+#define ALT_ATOMIC_OP(asm_op, I, asm_type, v, ret, temp)	\
+asm("amo" #asm_op "." #asm_type " zero, %1, %0"			\
+	: "+A" (v->counter)					\
+	: "r" (I)						\
+	: "memory")
+
+#define ALT_ATOMIC_FETCH_OP_RELAXED(asm_op, I, asm_type, v, ret, temp)	\
+asm("amo" #asm_op "." #asm_type " %1, %2, %0"				\
+	: "+A" (v->counter), "=r" (ret)					\
+	: "r" (I)							\
+	: "memory")
+
+#define ALT_ATOMIC_FETCH_OP(asm_op, I, asm_type, v, ret, temp)	\
+asm("amo" #asm_op "." #asm_type ".aqrl %1, %2, %0"		\
+	: "+A" (v->counter), "=r" (ret)				\
+	: "r" (I)						\
+	: "memory")
+
+#define ALT_TEST_AND_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __mask, __temp)	\
+asm(__AMO(op) #ord " %0, %2, %1"						\
+	: "=r" (__res), "+A" (addr[BIT_WORD(nr)])				\
+	: "r" (mod(__mask))							\
+	: "memory")
+
+#define ALT_OP_BIT_ORD(op, mod, nr, addr, ord, __res, __temp)	\
+asm(__AMO(op) #ord " zero, %1, %0"				\
+	: "+A" (addr[BIT_WORD(nr)])				\
+	: "r" (mod(BIT_MASK(nr)))				\
+	: "memory")
+
+#define ALT_ARCH_XOR_UNLOCK(mask, addr, __res, __temp)	\
+asm(__AMO(xor) ".rl %0, %2, %1"				\
+	: "=r" (res), "+A" (*addr)			\
+	: "r" (__NOP(mask))				\
+	: "memory")
+
+#define ALT_ARCH_XCHG(sfx, prepend, append, r, p, n, temp)	\
+asm(prepend							\
+	"	amoswap" sfx " %0, %2, %1\n"			\
+	append							\
+	: "=r" (r), "+A" (*(p))					\
+	: "r" (n)						\
+	: "memory")
+
+#define ALT_FUTEX_ATOMIC_OP(insn, ret, oldval, uaddr, oparg, temp)	\
+asm("1: amo" #insn ".w.aqrl %[ov],%z[op],%[u]\n"			\
+	"2:\n"								\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r])				\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),				\
+	  [u] "+m" (*uaddr)						\
+	: [op] "Jr" (oparg)						\
+	: "memory")
+
+#define ALT_FUTEX_ATOMIC_SWAP(ret, oldval, uaddr, oparg, temp)  \
+asm("1: amoswap.w.aqrl %[ov],%z[op],%[u]\n"			\
+	"2:\n"							\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r])			\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),			\
+	  [u] "+m" (*uaddr)					\
+	: [op] "Jr" (oparg)					\
+	: "memory")
+#endif
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/include/asm/errata_list_vendors.h
index 9739a70ed69984ba4fc5f51a4967a58c4b02613a..193b930374d6fce99e6e73d749fd3a84151ed304 100644
--- a/arch/riscv/include/asm/errata_list_vendors.h
+++ b/arch/riscv/include/asm/errata_list_vendors.h
@@ -24,7 +24,8 @@
 
 #ifdef CONFIG_ERRATA_MIPS
 #define	ERRATA_MIPS_P8700_PAUSE_OPCODE 0
-#define	ERRATA_MIPS_NUMBER 1
+#define	ERRATA_MIPS_P8700_ZALRSC 1
+#define	ERRATA_MIPS_NUMBER 2
 #endif
 
 #endif
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 90c86b115e008a1fb08f3da64382fb4a64d9cc2f..0d64f312f0f495f443306e36a0d487e2456343b0 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-extable.h>
+#include <asm/errata_list.h>
 
 /* We don't even really need the extable code, but for now keep it simple */
 #ifndef CONFIG_MMU
@@ -19,48 +20,48 @@
 #define __disable_user_access()		do { } while (0)
 #endif
 
-#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg, temp)	\
 {								\
 	__enable_user_access();					\
-	__asm__ __volatile__ (					\
-	"1:	" insn "				\n"	\
-	"2:						\n"	\
-	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %[r])			\
-	: [r] "+r" (ret), [ov] "=&r" (oldval),			\
-	  [u] "+m" (*uaddr)					\
-	: [op] "Jr" (oparg)					\
-	: "memory");						\
+	ALT_FUTEX_ATOMIC_OP(insn, ret, oldval, uaddr, oparg, temp);	\
 	__disable_user_access();				\
 }
 
+#define __futex_atomic_swap(ret, oldval, uaddr, oparg, temp)	\
+{	\
+	__enable_user_access();					\
+	ALT_FUTEX_ATOMIC_SWAP(ret, oldval, uaddr, oparg, temp);	\
+	__disable_user_access();				\
+}
+
+
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret = 0;
+	int __maybe_unused oldval = 0, ret = 0, temp = 0;
 
 	if (!access_ok(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("amoswap.w.aqrl %[ov],%z[op],%[u]",
-				  ret, oldval, uaddr, oparg);
+		__futex_atomic_swap(ret, oldval, uaddr, oparg, temp);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("amoadd.w.aqrl %[ov],%z[op],%[u]",
-				  ret, oldval, uaddr, oparg);
+		__futex_atomic_op(add,
+				  ret, oldval, uaddr, oparg, temp);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("amoor.w.aqrl %[ov],%z[op],%[u]",
-				  ret, oldval, uaddr, oparg);
+		__futex_atomic_op(or,
+				  ret, oldval, uaddr, oparg, temp);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("amoand.w.aqrl %[ov],%z[op],%[u]",
-				  ret, oldval, uaddr, ~oparg);
+		__futex_atomic_op(and,
+				  ret, oldval, uaddr, oparg, temp);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("amoxor.w.aqrl %[ov],%z[op],%[u]",
-				  ret, oldval, uaddr, oparg);
+		__futex_atomic_op(xor,
+				  ret, oldval, uaddr, oparg, temp);
 		break;
 	default:
 		ret = -ENOSYS;
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3a0ec6fd595691c873717ae1e6af5b3ed9854ca2..708cabd896fb86139eeeff27c4ae73d8c79f0ece 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -72,7 +72,15 @@
 	beq	a2, zero, .Lnew_vmalloc_restore_context
 
 	/* Atomically reset the current cpu bit in new_vmalloc */
-	amoxor.d	a0, a1, (a0)
+	ALTERNATIVE("amoxor.d a0, a1, (a0);	\
+				.rept 3; nop; .endr;",
+				"1: lr.d a2, (a0);	\
+				xor a2, a2, a1;	\
+				sc.d a2, a2, (a0);	\
+				bnez a2, 1b;",
+				MIPS_VENDOR_ID,
+				ERRATA_MIPS_P8700_ZALRSC,
+            CONFIG_ERRATA_MIPS_P8700_AMO_ZALRSC)
 
 	/* Only emit a sfence.vma if the uarch caches invalid entries */
 	ALTERNATIVE("sfence.vma", "nop", 0, RISCV_ISA_EXT_SVVPTC, 1)

---
base-commit: 7d4f659c32a309415078b0bca122fbb26a1e4df5
change-id: 20250714-p8700-zalrsc-f3894be40d06

Best regards,
-- 
Aleksa Paunovic <aleksa.paunovic@htecgroup.com>



