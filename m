Return-Path: <linux-kernel+bounces-727932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C2B0218D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AC05A518C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323072F1FF3;
	Fri, 11 Jul 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5oVx7eR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913052EF664
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250683; cv=none; b=rUkpp5NmQW9MlII+Tp39B6WLiZWZwBPB5pInaVem0md8MQehV877AoMUg7UvC8PU1FfCzcMbVOzcstjtW33TnzkXFMFuNzwDb3X/0ziDfvjvFc1u1705/O3EoykEpn+3xyLk+skCBMXoNrjlUNUcHSISSMlcH94/B7OvYyVtNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250683; c=relaxed/simple;
	bh=AuZ9fTTOEu8jUPZc0v6I8pAQSkyfRml4JgY7xt6+Jko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrsrEWq50cKHPh6qRCWQU+xGWZhOCgdVd9DEG2DQtEpprQBVkcnTstH3oQahBnEEc6alAwzpiZjM3vxFgyagSH1AO8rsr461ekvq67ILu4zsBjAHe77ddDOkeO06eSOMBcHvso75h5dadmiNX38nd7TFYK12ccAFanmdggRR/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5oVx7eR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4090BC4CEED;
	Fri, 11 Jul 2025 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250683;
	bh=AuZ9fTTOEu8jUPZc0v6I8pAQSkyfRml4JgY7xt6+Jko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5oVx7eRlm5cJmNhjSbPJySGMgrCGkb69GM1qLknnOUZ5hzqKNSC/xi5T+5LPaloF
	 mMGGIuXqQih0GCiKWUSfnscKG3nRV2nKK7LDsQDTW5Qa0FX7E7qvM1Z1ICnNE5Y7P2
	 j8EaB0ysrbG+2Uuh+siMhtWr70gDV6faF78BdlvtOPKogPnuGbMFF9wwBxeWA/hsdL
	 ByXJMljfJA6KDwQh1MFNkbKoTd7HQ+kFwYDTmw/esY5+dC+6jBw4YfHrkuYVS24hJS
	 EpnfGuno197YnU/hnJNzk9L6F2gFcD57MjQEfcUh2RPa/yhAELYe2cZQFVqFJrizzb
	 4uR4+DhwT6AwA==
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
Subject: [PATCH 09/10] arm64: mm: Simplify __flush_tlb_range_limit_excess()
Date: Fri, 11 Jul 2025 17:17:31 +0100
Message-Id: <20250711161732.384-10-will@kernel.org>
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

__flush_tlb_range_limit_excess() is unnecessarily complicated:

  - It takes a 'start', 'end' and 'pages' argument, whereas it only
    needs 'pages' (which the caller has computed from the other two
    arguments!).

  - It erroneously compares 'pages' with MAX_TLBI_RANGE_PAGES when
    the system doesn't support range-based invalidation but the range to
    be invalidated would result in fewer than MAX_DVM_OPS invalidations.

Simplify the function so that it no longer takes the 'start' and 'end'
arguments and only considers the MAX_TLBI_RANGE_PAGES threshold on
systems that implement range-based invalidation.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8618a85d5cd3..2541863721af 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -470,21 +470,13 @@ do {									\
 #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
 	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());
 
-static inline bool __flush_tlb_range_limit_excess(unsigned long start,
-		unsigned long end, unsigned long pages, unsigned long stride)
+static inline bool __flush_tlb_range_limit_excess(unsigned long pages,
+						  unsigned long stride)
 {
-	/*
-	 * When the system does not support TLB range based flush
-	 * operation, (MAX_DVM_OPS - 1) pages can be handled. But
-	 * with TLB range based operation, MAX_TLBI_RANGE_PAGES
-	 * pages can be handled.
-	 */
-	if ((!system_supports_tlb_range() &&
-	     (end - start) >= (MAX_DVM_OPS * stride)) ||
-	    pages > MAX_TLBI_RANGE_PAGES)
+	if (system_supports_tlb_range() && pages > MAX_TLBI_RANGE_PAGES)
 		return true;
 
-	return false;
+	return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;
 }
 
 static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
@@ -498,7 +490,7 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
 	end = round_up(end, stride);
 	pages = (end - start) >> PAGE_SHIFT;
 
-	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
+	if (__flush_tlb_range_limit_excess(pages, stride)) {
 		flush_tlb_mm(mm);
 		return;
 	}
@@ -547,7 +539,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 	end = round_up(end, stride);
 	pages = (end - start) >> PAGE_SHIFT;
 
-	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
+	if (__flush_tlb_range_limit_excess(pages, stride)) {
 		flush_tlb_all();
 		return;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


