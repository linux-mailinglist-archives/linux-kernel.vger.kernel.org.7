Return-Path: <linux-kernel+bounces-727924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C213B02180
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752FA16653A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FD3C30;
	Fri, 11 Jul 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu3CDGI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAB2EF2BE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250664; cv=none; b=gbovGby6AWd2QGJUg0ZIPUKNWq0i4P8oGh5Bt5UN2hOH0HBAsw23JYAwaSP4VHcby9OQE1fqDq13WSAp4n5o5rzOOurLYEapAQqeTE8Yilqzc0LHa733kKSQkQT6FmMg4O3jtxA4QXob58zQArX5r8zPEB3peDq2PQb2Wv3LLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250664; c=relaxed/simple;
	bh=OxLUcaS+mva8YPmoE0SCu30mpSKl3MfgIv/3sz5pLSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faQk4QFKW7lbSH4QnZpiOUkzuy3UWctnIJxVEeI4XumlFiC7OcAft5GFGrax5QaSU2vJZYz+5jgF5d7lp9BGQqw/gFqXgc+Y3q+ldNc1rjiMkU7T/kre0TIobll7paRtL6SNJ9vh6F1a53o+uQ2vGBn0WheJJ7RN5E3Z950cscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu3CDGI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA647C4CEED;
	Fri, 11 Jul 2025 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250663;
	bh=OxLUcaS+mva8YPmoE0SCu30mpSKl3MfgIv/3sz5pLSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pu3CDGI7gtFmF+qiVxu4UuGFf0kYyLet7UFwqfJtrlybo5L+Aw5JYH6JhSUi4TUEP
	 y5m2Ke1W0ppaxpDSdnJd+acjFjWKxp20q3eKPIb2ftjpJ4NfUbDSvfVDz435hOGCFS
	 wovLcYQWByRaS+uoaEMWxkRlwfWVvENvWMxbuCbb8YVniNQ6dIcp8VPEoGVFy+Ts3F
	 xJE7oJ9B+6wIrDfopjzrVq9Yg+fBm+8LVmFrZVe7UHCKo3RlaUugw2L7J1N3ZdF/Zc
	 SVyFGzIfFH+xtnqHFxhj3AT52CJraXOPLlUb8bs+QVjk6nGv8YhbzAZG7/FilvET8E
	 6BuzS8K5pzyYA==
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
Subject: [PATCH 01/10] arm64: mm: Introduce a C wrapper for by-level TLB invalidation helpers
Date: Fri, 11 Jul 2025 17:17:23 +0100
Message-Id: <20250711161732.384-2-will@kernel.org>
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

In preparation for reducing our reliance on complex preprocessor macros
for TLB invalidation routines, introduce a new C wrapper for by-level
TLB invalidation helpers which can be used instead of the __tlbi() macro
and can additionally be called from C code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index aa9efee17277..1c7548ec6cb7 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -88,6 +88,16 @@ static inline unsigned long get_trans_granule(void)
 	}
 }
 
+enum tlbi_op {
+	vae1is,
+	vae2is,
+	vale1is,
+	vale2is,
+	vaale1is,
+	ipas2e1,
+	ipas2e1is,
+};
+
 /*
  * Level-based TLBI operations.
  *
@@ -105,6 +115,27 @@ static inline unsigned long get_trans_granule(void)
 
 #define TLBI_TTL_UNKNOWN	INT_MAX
 
+#define __GEN_TLBI_OP_CASE(op)						\
+	case op:							\
+		__tlbi(op, arg);					\
+		break
+
+static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
+{
+	switch (op) {
+	__GEN_TLBI_OP_CASE(vae1is);
+	__GEN_TLBI_OP_CASE(vae2is);
+	__GEN_TLBI_OP_CASE(vale1is);
+	__GEN_TLBI_OP_CASE(vale2is);
+	__GEN_TLBI_OP_CASE(vaale1is);
+	__GEN_TLBI_OP_CASE(ipas2e1);
+	__GEN_TLBI_OP_CASE(ipas2e1is);
+	default:
+		BUILD_BUG();
+	}
+}
+#undef __GEN_TLBI_OP_CASE
+
 #define __tlbi_level(op, addr, level) do {				\
 	u64 arg = addr;							\
 									\
@@ -116,7 +147,7 @@ static inline unsigned long get_trans_granule(void)
 		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
 	}								\
 									\
-	__tlbi(op, arg);						\
+	__tlbi_level_op(op, arg);					\
 } while(0)
 
 #define __tlbi_user_level(op, arg, level) do {				\
-- 
2.50.0.727.gbf7dc18ff4-goog


