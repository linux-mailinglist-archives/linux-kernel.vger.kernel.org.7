Return-Path: <linux-kernel+bounces-829456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0FB971FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4FF4A8292
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41B2DC359;
	Tue, 23 Sep 2025 17:50:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A52DAFD7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649802; cv=none; b=bXdPkfaTElFxdst9zxBo/MJPjj9b6iXt+rV6dEEHeu4akMySuoGa0KS5SAtUZSv2/MbE+D+3f77OZKzqXETY90OSkLbUUxUiXnUs3f9naHPMoVHgvlCMZrnorUTN4VwFvrKxHZ/IjpNBvZb4f2gTzzKtoj8kTebK8JK/78j4Q4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649802; c=relaxed/simple;
	bh=RoPt2nnGJMaaDYrbv6yIXtOoFlsHlJGSMI3Dq37b3KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2Lrym+utwTOOX68/0zTW4Gr8G1Gon63UjtQgiAH2MbK+lwQ2uHXiSVrem7sZkQiB1dvfNlcBq94yOKxiDOkBXghXU+lPE3ZEoDOXaYrYKdbykLjDziZ93HZ2md9HGQZbJ13Jt3E2bgKsDPvxVv9keR8cfqLOQ5w+VmrUKf2hUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB86497;
	Tue, 23 Sep 2025 10:49:51 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.30.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62B403F5A1;
	Tue, 23 Sep 2025 10:49:56 -0700 (PDT)
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
Subject: [RFC PATCH 11/16] arm64/insn: always inline aarch64_insn_gen_extr()
Date: Tue, 23 Sep 2025 18:48:58 +0100
Message-ID: <20250923174903.76283-12-ada.coupriediaz@arm.com>
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

As it is always called with an explicit variant, we can check for
its validity at compile time and remove the runtime error print.

This makes `aarch64_insn_gen_extr()` safe for inlining
and usage from patching callbacks, as both
`aarch64_insn_encode_immediate()` and `aarch64_insn_encode_register()`
have been made safe in previous commits.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/insn.h | 39 ++++++++++++++++++++++++++++++-----
 arch/arm64/lib/insn.c         | 32 ----------------------------
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 6e6a53d4d750..4ba4d5c50137 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -1111,12 +1111,41 @@ static __always_inline u32 aarch64_insn_gen_logical_immediate(
 	return aarch64_encode_immediate(imm, variant, insn);
 }
 
+static __always_inline u32 aarch64_insn_gen_extr(
+			 enum aarch64_insn_variant variant,
+			 enum aarch64_insn_register Rm,
+			 enum aarch64_insn_register Rn,
+			 enum aarch64_insn_register Rd,
+			 u8 lsb)
+{
+	compiletime_assert(variant == AARCH64_INSN_VARIANT_32BIT ||
+		variant == AARCH64_INSN_VARIANT_64BIT,
+		"unknown variant encoding");
+	u32 insn;
+
+	insn = aarch64_insn_get_extr_value();
+
+	switch (variant) {
+	case AARCH64_INSN_VARIANT_32BIT:
+		if (lsb > 31)
+			return AARCH64_BREAK_FAULT;
+		break;
+	case AARCH64_INSN_VARIANT_64BIT:
+		if (lsb > 63)
+			return AARCH64_BREAK_FAULT;
+		insn |= AARCH64_INSN_SF_BIT;
+		insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_N, insn, 1);
+		break;
+	default:
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_S, insn, lsb);
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, Rd);
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
+}
 
-u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
-			  enum aarch64_insn_register Rm,
-			  enum aarch64_insn_register Rn,
-			  enum aarch64_insn_register Rd,
-			  u8 lsb);
 #ifdef CONFIG_ARM64_LSE_ATOMICS
 u32 aarch64_insn_gen_atomic_ld_op(enum aarch64_insn_register result,
 				  enum aarch64_insn_register address,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 8d38bf4bf203..71df4d72ac81 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1021,38 +1021,6 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
 	return insn & CRM_MASK;
 }
 
-u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
-			  enum aarch64_insn_register Rm,
-			  enum aarch64_insn_register Rn,
-			  enum aarch64_insn_register Rd,
-			  u8 lsb)
-{
-	u32 insn;
-
-	insn = aarch64_insn_get_extr_value();
-
-	switch (variant) {
-	case AARCH64_INSN_VARIANT_32BIT:
-		if (lsb > 31)
-			return AARCH64_BREAK_FAULT;
-		break;
-	case AARCH64_INSN_VARIANT_64BIT:
-		if (lsb > 63)
-			return AARCH64_BREAK_FAULT;
-		insn |= AARCH64_INSN_SF_BIT;
-		insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_N, insn, 1);
-		break;
-	default:
-		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
-		return AARCH64_BREAK_FAULT;
-	}
-
-	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_S, insn, lsb);
-	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, Rd);
-	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, Rn);
-	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
-}
-
 static u32 __get_barrier_crm_val(enum aarch64_insn_mb_type type)
 {
 	switch (type) {
-- 
2.43.0


