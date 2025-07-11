Return-Path: <linux-kernel+bounces-727929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13BB02189
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E3188D301
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963CB2F1981;
	Fri, 11 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8EoeJ8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D22F0E42
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250676; cv=none; b=l1/yf3kYRYU0OiO8I2iItjI5ZhJ670IQOX93Yikbf1YlTlbyiFGzdHCx2olZ7hw6iBIEyTwzd7gdJFFlB80T2ZxCqvRrxnO017BUfpTxORLfxdPiNi0o2zPNXb86RFs7GobMJ2fSFiiQZdVBJJN26FcpuChHUeDBEqAS0u4l154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250676; c=relaxed/simple;
	bh=Xuzx6uwSk0yNzSsVAXXMPAY9gCduvpNUj0iAmpfZdno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VKTEF6Dyi32juiqKIqyguuh/DkHBXGV9XGt6FTRg6+esaCDaMrkMM9zTwf7h9alGxFh4SUwsjreWw3Y+1be4+FH3ZqO01VCSUjwTwwGE/FI9IRpC2UwWIUxKziUZjJkLmydLe1ZxZBQYFVk+jVMjBdCY5SYViL5MkCi5kOhEpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8EoeJ8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755DC4CEED;
	Fri, 11 Jul 2025 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250675;
	bh=Xuzx6uwSk0yNzSsVAXXMPAY9gCduvpNUj0iAmpfZdno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8EoeJ8N9T8OaOoWAHbFraEkEQd6Ze+Ty6mhEeSmdVVdVQ2vIHINyKH8HtEz+v5dJ
	 wpSPpI1Gg/2plhs+yU0fhXRgHc3G5g2Nh4T7LprrsfqHKouSZxOXFX1CrsSYKjgY9q
	 uWbIqK6mopmsNhh522MlTaftjZrATL2gvSI5M+2aycE/kKAmZbDEQGb8hvBJmuk3C7
	 pZo1B23Nbpn7Hz4e1dgrcxkhzxw6tPYIN5bhVjKdFgdcoAf/CFrcb5hdhF5jRVP8xr
	 zTVbW0FjrddOl6kc72mbDxT25XCWW+gF4xmV4OWRO9t+zrLK8kaiFtdUpzndhNKD+h
	 CtQDfARzY3FfA==
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
Subject: [PATCH 06/10] arm64: mm: Simplify __TLBI_RANGE_NUM() macro
Date: Fri, 11 Jul 2025 17:17:28 +0100
Message-Id: <20250711161732.384-7-will@kernel.org>
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

Since commit e2768b798a19 ("arm64/mm: Modify range-based tlbi to
decrement scale"), we don't need to clamp the 'pages' argument to fit
the range for the specified 'scale' as we know that the upper bits will
have been processed in a prior iteration.

Drop the clamping and simplify the __TLBI_RANGE_NUM() macro.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index ddd77e92b268..a8d21e52ef3a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -205,11 +205,7 @@ static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 le
  * range.
  */
 #define __TLBI_RANGE_NUM(pages, scale)					\
-	({								\
-		int __pages = min((pages),				\
-				  __TLBI_RANGE_PAGES(31, (scale)));	\
-		(__pages >> (5 * (scale) + 1)) - 1;			\
-	})
+	(((pages) >> (5 * (scale) + 1)) - 1)
 
 /*
  *	TLB Invalidation
-- 
2.50.0.727.gbf7dc18ff4-goog


