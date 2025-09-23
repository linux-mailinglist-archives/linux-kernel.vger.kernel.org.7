Return-Path: <linux-kernel+bounces-829452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7252CB971EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28332E5580
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100232D6E7F;
	Tue, 23 Sep 2025 17:49:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313952D541B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649795; cv=none; b=sB/FUEgJo/2+9Vghcs6m1DDDyYWKvlrbiTUweL/b342MSl3KAormFBztHN+eBYHdUIpy2nFIicDkG/QLNq0PTOUJMYHC3A9Db5ZINpvt5lyRjkbzxtdqP4j7A38SeOYyN6miaBrCflvu0CwZeyN0nmPRu6kH3U/Hi0+Pab06uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649795; c=relaxed/simple;
	bh=Urr8+VR0qOSdsILBhXsPbRbFoSlNV8lWhdKoJwi+ahE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs/IK5WZQQhLREF7a7lGeeiGcZ1xZPYjt4Pe2Kf7muNWE03pKulCSs7Z6eG2Me9aBP2aIZC0LHSuhD5qQq3vr1pYfX8GiGW+3OZUwFIBirNSSx0C4nA54aXrd9NAyoNY1wYr1edPMQVY8fSE09S5hDpE1TMHAoJ5abSEk4gaNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8739497;
	Tue, 23 Sep 2025 10:49:43 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.30.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AE8B3F5A1;
	Tue, 23 Sep 2025 10:49:47 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kasan-dev@googlegroups.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [RFC PATCH 09/16] arm64/insn: always inline aarch64_insn_gen_add_sub_imm()
Date: Tue, 23 Sep 2025 18:48:56 +0100
Message-ID: <20250923174903.76283-10-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174903.76283-1-ada.coupriediaz@arm.com>
References: <20250923174903.76283-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it is always called with an explicit instruction adsb type and variant,
we can check for their validity at compile time and remove
the runtime error print.

This is not the case for the immediate error print, as it checks
dynamically. However, it should not occur in practice and will still
generate a fault BRK, so remove it.

This makes `aarch64_insn_gen_add_sub_imm()` safe for inlining
and usage from patching callbacks, as both
`aarch64_insn_encode_register()` and `aarch64_insn_encode_immediate()`
have been made safe in previous commits.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/insn.h | 68 +++++++++++++++++++++++++++++++++--
 arch/arm64/lib/insn.c         | 62 --------------------------------
 2 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index a94ecc9140f1..a7caafd6f02b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -627,6 +627,8 @@ static __always_inline bool aarch64_get_imm_shift_mask(
 #define ADR_IMM_HISHIFT		5
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
+#define AARCH64_INSN_LSL_12	BIT(22)
+
 
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
@@ -788,10 +790,72 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register state,
 				   enum aarch64_insn_size_type size,
 				   enum aarch64_insn_ldst_type type);
-u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
+
+static __always_inline u32 aarch64_insn_gen_add_sub_imm(
+				 enum aarch64_insn_register dst,
 				 enum aarch64_insn_register src,
 				 int imm, enum aarch64_insn_variant variant,
-				 enum aarch64_insn_adsb_type type);
+				 enum aarch64_insn_adsb_type type)
+{
+	compiletime_assert(type >= AARCH64_INSN_ADSB_ADD &&
+		type <= AARCH64_INSN_ADSB_SUB_SETFLAGS,
+		"unknown add/sub encoding");
+	compiletime_assert(variant == AARCH64_INSN_VARIANT_32BIT ||
+		variant == AARCH64_INSN_VARIANT_64BIT,
+		"unknown variant encoding");
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_ADSB_ADD:
+		insn = aarch64_insn_get_add_imm_value();
+		break;
+	case AARCH64_INSN_ADSB_SUB:
+		insn = aarch64_insn_get_sub_imm_value();
+		break;
+	case AARCH64_INSN_ADSB_ADD_SETFLAGS:
+		insn = aarch64_insn_get_adds_imm_value();
+		break;
+	case AARCH64_INSN_ADSB_SUB_SETFLAGS:
+		insn = aarch64_insn_get_subs_imm_value();
+		break;
+	default:
+		return AARCH64_BREAK_FAULT;
+	}
+
+	switch (variant) {
+	case AARCH64_INSN_VARIANT_32BIT:
+		break;
+	case AARCH64_INSN_VARIANT_64BIT:
+		insn |= AARCH64_INSN_SF_BIT;
+		break;
+	default:
+		return AARCH64_BREAK_FAULT;
+	}
+
+	/* We can't encode more than a 24bit value (12bit + 12bit shift) */
+	if (imm & ~(BIT(24) - 1))
+		goto out;
+
+	/* If we have something in the top 12 bits... */
+	if (imm & ~(SZ_4K - 1)) {
+		/* ... and in the low 12 bits -> error */
+		if (imm & (SZ_4K - 1))
+			goto out;
+
+		imm >>= 12;
+		insn |= AARCH64_INSN_LSL_12;
+	}
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, src);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
+
+out:
+	return AARCH64_BREAK_FAULT;
+}
+
 u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
 			 enum aarch64_insn_register reg,
 			 enum aarch64_insn_adr_type type);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 15634094de05..34b6f1c692b4 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -17,7 +17,6 @@
 #include <asm/kprobes.h>
 
 #define AARCH64_INSN_N_BIT	BIT(22)
-#define AARCH64_INSN_LSL_12	BIT(22)
 
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn)
 {
@@ -585,67 +584,6 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
 }
 #endif
 
-u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
-				 enum aarch64_insn_register src,
-				 int imm, enum aarch64_insn_variant variant,
-				 enum aarch64_insn_adsb_type type)
-{
-	u32 insn;
-
-	switch (type) {
-	case AARCH64_INSN_ADSB_ADD:
-		insn = aarch64_insn_get_add_imm_value();
-		break;
-	case AARCH64_INSN_ADSB_SUB:
-		insn = aarch64_insn_get_sub_imm_value();
-		break;
-	case AARCH64_INSN_ADSB_ADD_SETFLAGS:
-		insn = aarch64_insn_get_adds_imm_value();
-		break;
-	case AARCH64_INSN_ADSB_SUB_SETFLAGS:
-		insn = aarch64_insn_get_subs_imm_value();
-		break;
-	default:
-		pr_err("%s: unknown add/sub encoding %d\n", __func__, type);
-		return AARCH64_BREAK_FAULT;
-	}
-
-	switch (variant) {
-	case AARCH64_INSN_VARIANT_32BIT:
-		break;
-	case AARCH64_INSN_VARIANT_64BIT:
-		insn |= AARCH64_INSN_SF_BIT;
-		break;
-	default:
-		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
-		return AARCH64_BREAK_FAULT;
-	}
-
-	/* We can't encode more than a 24bit value (12bit + 12bit shift) */
-	if (imm & ~(BIT(24) - 1))
-		goto out;
-
-	/* If we have something in the top 12 bits... */
-	if (imm & ~(SZ_4K - 1)) {
-		/* ... and in the low 12 bits -> error */
-		if (imm & (SZ_4K - 1))
-			goto out;
-
-		imm >>= 12;
-		insn |= AARCH64_INSN_LSL_12;
-	}
-
-	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
-
-	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, src);
-
-	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
-
-out:
-	pr_err("%s: invalid immediate encoding %d\n", __func__, imm);
-	return AARCH64_BREAK_FAULT;
-}
-
 u32 aarch64_insn_gen_bitfield(enum aarch64_insn_register dst,
 			      enum aarch64_insn_register src,
 			      int immr, int imms,
-- 
2.43.0


