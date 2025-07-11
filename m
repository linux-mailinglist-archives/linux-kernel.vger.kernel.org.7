Return-Path: <linux-kernel+bounces-727928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84FB02188
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0726B18874E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7392F0C5A;
	Fri, 11 Jul 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHUsYN57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C92EF2B7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250673; cv=none; b=FcyVm9KDoJ10IVDqtT9e5rR7+6LWIcxQHZLnV6YeU63Mgc6mnH7aiNX7InM21rDCqNkpqyI+HyDZr++C7gTQxHzsLeuMelaBmQaExj6aiUFjoLXCLe2Gyb3Jz+OOUzy8QFjsTJSuc/3yTvooPZdOwhFgwYs8E8AXbbEollfSFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250673; c=relaxed/simple;
	bh=7sV42ef3qnlm42vIFFwnfcJvwECcndeyiu5SfLlYqu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5uYxlG1buyWGKf7MVgb2EMP0j6h/nvxiFWnL9CYLzJHfpsThKjpcrWFkQ8uldr35PXHkbNPpywfnZU5fRee3zcgKqXEsLpJ4rFEoj56eCN2mCpk2f0SNP2vsVNqdDP9YIhdDNeed4xK9E/2/McszSIb1BNgtP8FZRNf303jW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHUsYN57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75292C4CEF0;
	Fri, 11 Jul 2025 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250673;
	bh=7sV42ef3qnlm42vIFFwnfcJvwECcndeyiu5SfLlYqu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHUsYN57p1WCIQfYJxnAcETmaWxcXbEabSHhQaNdnDM8HofRM9KnCq1IdbaSnmyrf
	 J7InC+Ann/tJcPuIv1jpvuORX0zhlsYKdRnfWof9E2FsJwPzeDUN1b5SEWUdAUoldZ
	 0mP7m/GtRFrsTg7XjJGQCrOsEer5oCE2sfGAf9oW294bYXa4E4dNgqj9HouLH2JIhG
	 1KvVdLEGDj9KxTL/vBCwMUfYD1psoaQ9Um8A/NB4KGs9z3Q930aiw2jn+czdJHDj5Z
	 lmqpwikWby6DauZlUIzFKKAr+np+pHFCmhHlyOqAA0xvlahFnddcJO8kSscThWe8mX
	 tBgfVZ+2LEpUQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 05/10] arm64: mm: Re-implement the __tlbi_level macro in C
Date: Fri, 11 Jul 2025 17:17:27 +0100
Message-Id: <20250711161732.384-6-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711161732.384-1-will@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__tlbi_level() is just a simple macro around __tlbi_level_op(), so merge
the two into a single C function. Drop the redundant comparison of
'u32 level' against 0 and tidy up the code a little while we're at it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 728b00f3e1f4..ddd77e92b268 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -128,8 +128,17 @@ enum tlbi_op {
 	___GEN_TLBI_OP_CASE(op);					\
 		break
 
-static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
+static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)
 {
+	u64 arg = addr;
+
+	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) && level <= 3) {
+		u64 ttl = level | (get_trans_granule() << 2);
+
+		arg &= ~TLBI_TTL_MASK;
+		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);
+	}
+
 	switch (op) {
 	__GEN_TLBI_OP_ASID_CASE(vae1is);
 	__GEN_TLBI_OP_CASE(vae2is);
@@ -145,20 +154,6 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
 #undef __GEN_TLBI_OP_ASID_CASE
 #undef ___GEN_TLBI_OP_CASE
 
-#define __tlbi_level(op, addr, level) do {				\
-	u64 arg = addr;							\
-									\
-	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) &&	\
-	    level >= 0 && level <= 3) {					\
-		u64 ttl = level & 3;					\
-		ttl |= get_trans_granule() << 2;			\
-		arg &= ~TLBI_TTL_MASK;					\
-		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
-	}								\
-									\
-	__tlbi_level_op(op, arg);					\
-} while(0)
-
 /*
  * This macro creates a properly formatted VA operand for the TLB RANGE. The
  * value bit assignments are:
-- 
2.50.0.727.gbf7dc18ff4-goog


