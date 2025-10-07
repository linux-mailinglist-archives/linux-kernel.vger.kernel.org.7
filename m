Return-Path: <linux-kernel+bounces-844103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5ABC1020
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAB9B34E204
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88B2D877C;
	Tue,  7 Oct 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzalYBIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801428F4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832767; cv=none; b=LITOvxfi1PsQFCm5bA1zYApd8EA+cNnAZkhi7NzlpEY1qjiqAL3iPOWzixNZT7k9ucK/yoIKcnFoVKp+6u6xq1PgZ0lBMWbcwi4p4YsyLCF28E88reDfwO5X2aV5nRhtiOdgvaTJrT6uv1zW0l/+5OiPZ6ium0TQxed0WQ85Ggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832767; c=relaxed/simple;
	bh=Bvl2ChImxgS0j7pE2mZq01mesct/mBT06Z3hhwBQYhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aezfRLjKZXX2oRxXGZNKxVbHd2jPtrXJVQxhbwOrDFwBw9I3bAY4hoQJrG2XeBWWafG3izax0dw0BJd3R+/jCzNOiwneAhQkU8rvEp2QBLaty35e++VLSs6OPedNUwK9qpMyIf2hNSwlUEBW/4TXz0xL+8iuOFVVuhRVh1Y+YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzalYBIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD1C4CEF1;
	Tue,  7 Oct 2025 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759832765;
	bh=Bvl2ChImxgS0j7pE2mZq01mesct/mBT06Z3hhwBQYhk=;
	h=From:To:Cc:Subject:Date:From;
	b=AzalYBIZ46U8TQOJ/BdtoBHCDYL0IlollYqNRTKto6tmDpwW36bl6n1oDkcJHdek+
	 ObIRDuby4KQyLzE4fouU04ViQ44OLlt4l7/Q+w3PPreAunRoNM22zBGKRuTqXF2KZo
	 ub9XTeK9fgy/vf4CqY9BxZ/eVfwauVGXyr6B/dKpmp8pmRjCNJftAlKCdZOMDgIBYf
	 bk3s8HRKc/Jx1t3TcHRBV6IB+RklX6bu13NiH81fK91u3bw1Exk11YBM5E8R54c4Q7
	 bPGkkW6ukRfMmtjPMbqWnwPEtzCq0USOij0Tw10BHkgMBP17M55uceroIXPrx1cVtd
	 QDaF7JTesmcSA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2] arm64/sysreg: Fix GIC CDEOI instruction encoding
Date: Tue,  7 Oct 2025 12:26:00 +0200
Message-ID: <20251007102600.879337-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GIC CDEOI system instruction requires the Rt field to be set to 0b11111
otherwise the instruction behaviour becomes CONSTRAINED UNPREDICTABLE.

Currenly, its usage is encoded as a system register write, with a constant
0 value:

write_sysreg_s(0, GICV5_OP_GIC_CDEOI)

While compiling with GCC, the 0 constant value, through these asm
constraints and modifiers ('x' modifier and 'Z' constraint combo):

asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));

forces the compiler to issue the XZR register for the MSR operation (ie
that corresponds to Rt == 0b11111) issuing the right instruction encoding.

Unfortunately LLVM does not yet understand that modifier/constraint
combo so it ends up issuing a different register from XZR for the MSR
source, which in turns means that it encodes the GIC CDEOI instruction
wrongly and the instruction behaviour becomes CONSTRAINED UNPREDICTABLE
that we must prevent.

Add a conditional to write_sysreg_s() macro that detects whether it
is passed a constant 0 value and issues an MSR write with XZR as source
register - explicitly doing what the asm modifier/constraint is meant to
achieve through constraints/modifiers, fixing the LLVM compilation issue.

Fixes: 7ec80fb3f025 ("irqchip/gic-v5: Add GICv5 PPI support")
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
v1: https://lore.kernel.org/lkml/20251006100758.624934-1-lpieralisi@kernel.org/

 arch/arm64/include/asm/sysreg.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6455db1b54fd..c231d2a3e515 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1220,10 +1220,19 @@
 	__val;								\
 })
 
+/*
+ * The "Z" constraint combined with the "%x0" template should be enough
+ * to force XZR generation if (v) is a constant 0 value but LLVM does not
+ * yet understand that modifier/constraint combo so a conditional is required
+ * to nudge the compiler into using XZR as a source for a 0 constant value.
+ */
 #define write_sysreg_s(v, r) do {					\
 	u64 __val = (u64)(v);						\
 	u32 __maybe_unused __check_r = (u32)(r);			\
-	asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));		\
+	if (__builtin_constant_p(__val) && __val == 0)			\
+		asm volatile(__msr_s(r, "xzr"));			\
+	else								\
+		asm volatile(__msr_s(r, "%x0") : : "r" (__val));	\
 } while (0)
 
 /*
-- 
2.48.0


