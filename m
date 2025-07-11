Return-Path: <linux-kernel+bounces-727925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D56B02181
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF2188B9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B742EF9A0;
	Fri, 11 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4MVo+eE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954632EF66B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250666; cv=none; b=Jc5dn1zSznuH/vS5Ex4d3eogauW4A0MgfYCyOFqTxMw2AiNjorQ+0hynEKuUMOxpQAS13eUfeWd8kl5/Km5hxp4+v2IrUIWGmJr2HhQDsieaiABOO4aTHGIaEfsfa90ggowZY9nY2Nthm1jStfODwE2TgWjeCtowWrEwGQJR8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250666; c=relaxed/simple;
	bh=q5+HuLJh1JU1y/46sorbdFwVVHM1smyj615SFqQ/6i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqywUxiAf5BQ1QUXgeFZKaKpvWaKWjumuW8lnHxOHnw/OI1WJgDDHpCuvnoXHawNf+bRIBjmexmxXsYkyP+wdtJRXBLviottyNg/BDhC8WQG+LkaD5hq/zcpEdoFDa5uLJUvjVhjPA9/bQSstCu/DB4mPOYHgJX6VwaL4H3MGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4MVo+eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4805CC4CEF5;
	Fri, 11 Jul 2025 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250666;
	bh=q5+HuLJh1JU1y/46sorbdFwVVHM1smyj615SFqQ/6i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4MVo+eEZhW6ZtkMaOr5iS7MraQkoRsWptpg+/xXCDh9nyCeKzpJ3qzBhljEOupxN
	 X8tGW8EPr5PUWkVFX7h1YMA3+g7GDp7V53CuIPkhGzp5eK98l8OmFAF1RRmkerE55R
	 JhcXBJr5t/9WR9V7BV9j2kLXUl3olanDE+L2yoWCehqigvku5iab7x2b700RcAvnRD
	 fn9izzwO8Z7VEmu2z/lBWNyfxmxCU9SdRpK/CiBmZI5WtlEGiQY3S9+ZMgsj/HAKAT
	 kqiqykYPCVHzVF0nbEFiV0cOWKtvXgvYprHDKx4EKAQxo0LcVtaSDeuc5AW0eBuERM
	 A0eebe0uqA7Ww==
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
Subject: [PATCH 02/10] arm64: mm: Introduce a C wrapper for by-range TLB invalidation helpers
Date: Fri, 11 Jul 2025 17:17:24 +0100
Message-Id: <20250711161732.384-3-will@kernel.org>
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
for TLB invalidation routines, introduce a new C wrapper for by-range
TLB invalidation helpers which can be used instead of the __tlbi() macro
and can additionally be called from C code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 1c7548ec6cb7..4408aeebf4d5 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -418,6 +418,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
  *    operations can only span an even number of pages. We save this for last to
  *    ensure 64KB start alignment is maintained for the LPA2 case.
  */
+#define __GEN_TLBI_OP_CASE(op)						\
+	case op:							\
+		__tlbi(r ## op, arg);					\
+		break
+
+static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
+{
+	switch (op) {
+	__GEN_TLBI_OP_CASE(vae1is);
+	__GEN_TLBI_OP_CASE(vale1is);
+	__GEN_TLBI_OP_CASE(vaale1is);
+	__GEN_TLBI_OP_CASE(ipas2e1is);
+	default:
+		BUILD_BUG();
+	}
+}
+#undef __GEN_TLBI_OP_CASE
+
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user, lpa2)	\
 do {									\
@@ -445,7 +463,7 @@ do {									\
 		if (num >= 0) {						\
 			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
 						scale, num, tlb_level);	\
-			__tlbi(r##op, addr);				\
+			__tlbi_range(op, addr);				\
 			if (tlbi_user)					\
 				__tlbi_user(r##op, addr);		\
 			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
-- 
2.50.0.727.gbf7dc18ff4-goog


