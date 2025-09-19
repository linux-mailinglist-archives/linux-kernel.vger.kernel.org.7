Return-Path: <linux-kernel+bounces-824786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A34B8A25C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2104D4E76D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3B31AF20;
	Fri, 19 Sep 2025 14:58:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FD3164CB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293927; cv=none; b=c9vkM6r6qDbw9x5e5I4Nr254m7VhmLlgoCA7Wcixne4WSA23PZokRDBsItaRAF8rKAo+aeRFtKY1/kVbeieFq+j6ZGdh4HZigbwJaI7FvrceCajLNT6HajuA2jm3WTafCxvb7Ec78MfTRiiiM2BjEsYWrM0UfG/CnomH3ZNkB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293927; c=relaxed/simple;
	bh=yaWY6to0nkNsMfNRA7ayju8gynlgymqTo492+EpfHU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=konloFUWvkKFrh+bmT1amS2Edi4HeaI1nshPtbGLghLsf5+jRrI/Hhk/F2u9mC+EkW6WVxsUH59nO5P0JnGWu5+jBBhKcmKwjwRMu1U5obTFt2lyWXdHE61awCQYgFUglBeX1wzctZrkRDCKNc2M6Gj8Uxc9mYRpLCHm64Fn2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A3FC169C;
	Fri, 19 Sep 2025 07:58:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 860F93F673;
	Fri, 19 Sep 2025 07:58:44 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: cpufeature: add Neoverse-V3AE to BBML2 allow list
Date: Fri, 19 Sep 2025 15:58:30 +0100
Message-ID: <20250919145832.4035534-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919145832.4035534-1-ryan.roberts@arm.com>
References: <20250919145832.4035534-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neoverse-V3AE advertises support for BBML2 and is known to not raise
conflict aborts. So add it to the BBML2_NOABORT allow list.

However, just like Neoverse-V3, Neoverse-V3AE r0p0 and r0p1 suffer from
erratum #3053180, for which the workaround is to always observe
break-before-make requirements for affected revisions. Therefore only
add to the allow list from r0p2 onwards.

For more details see Software Developer Errata Notice (SDEN) document:
    Neoverse V3AE (MP172) SDEN v9.0, erratum 3053180
    https://developer.arm.com/documentation/SDEN-2615521/9-0/

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e1..61180b211293 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2235,6 +2235,7 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 	static const struct midr_range supports_bbml2_noabort_list[] = {
 		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
 		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		MIDR_REV_RANGE(MIDR_NEOVERSE_V3AE, 0, 2, 0xf),
 		{}
 	};
 
-- 
2.43.0


