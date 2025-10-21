Return-Path: <linux-kernel+bounces-862188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA4ABF4A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 229E94E21E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65515256C76;
	Tue, 21 Oct 2025 05:20:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58524168D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024037; cv=none; b=ZP4prb9vtKILlUmATNC5KufXnFIyN7IVBSnRXNU08vfOHu/AYfX3U0w4gFjMcGL5FL100rk41bnMG0JQVgY8NQv1wbnOQYfO+M2HN798BGvRJLNyDeZRQydIot7WsrbDW1NRlNKJRq/bZUwmEQs3EEm9riTPVrTWvKr8OLszyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024037; c=relaxed/simple;
	bh=anFenXs5SSmIQDDFcAAXj+497BeD1hkVlrd+XbtHMbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPlTGT5mbmOVp/A4X4/M7CRraWCMVL3ruccl6zIW2acCuZO46x+OAtZ/HWc2PJMBR1kUtXfLLD3hdR2XBK6WSJD//qIt29EE3ewE99CiGjUi7EhUsUJ+7qfmgvxkvBfkrXdqwdD/fOjoyGhjAP+L9H1N0sYzh+IWPRiy6wHFZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA446175D;
	Mon, 20 Oct 2025 22:20:26 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D9943F59E;
	Mon, 20 Oct 2025 22:20:33 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64/mm: Drop redundant 'level' range trimming in __tlbi_level()
Date: Tue, 21 Oct 2025 06:20:21 +0100
Message-Id: <20251021052022.2898275-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251021052022.2898275-1-anshuman.khandual@arm.com>
References: <20251021052022.2898275-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page table level value has already known to be in the range [0..3] before
entering inside the conditional 'if' loop. Hence any subsequent trimming
is just redundant and can be dropped off.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 18a5dc0c9a54..131096094f5b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -110,7 +110,7 @@ static inline unsigned long get_trans_granule(void)
 									\
 	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) &&	\
 	    level >= 0 && level <= 3) {					\
-		u64 ttl = level & 3;					\
+		u64 ttl = level;					\
 		ttl |= get_trans_granule() << 2;			\
 		arg &= ~TLBI_TTL_MASK;					\
 		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
-- 
2.30.2


