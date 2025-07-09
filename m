Return-Path: <linux-kernel+bounces-723201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC3AFE455
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E653A75FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC9288CAD;
	Wed,  9 Jul 2025 09:38:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464828850A;
	Wed,  9 Jul 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053906; cv=none; b=KZ2SJFc+8A0QNHGlhYAuFhbtOjhy0My5wnwror1SlAHMhlr+0+kkN9WpKRGH8Toyyzio1A3zg46Uh0Jxoxgk97jezUaJdjz//kpTcXu2XrbgPWUgKMonrXIvAELULTU9hWSvDkZfbMioyhGPRTgd557LpRRUxyUIIeZwJkwD74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053906; c=relaxed/simple;
	bh=9HnbdpNhe8OY1hF6wbjnKkXFCcZmCwzgwNAa+SNHB1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J80XmsvkZWxA6YsXFrPhxtbzdILvo9/YFiMWRIoapa0yXiC8jV5feRTXDo0mIxLBccT7KGg7YsTMj7FeBW/DV4mFip7ZPeUOLcfWqmTFa+yz+FDFeVzHSR+lESjlR7U1PPxezGwMhYa5DuXpxsrP4OPTD8XJx7SN7jq5a53NAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0854B1655;
	Wed,  9 Jul 2025 02:38:12 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77CE63F738;
	Wed,  9 Jul 2025 02:38:21 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Cc: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: arm64: Fix enforcement of upper bound on MDCR_EL2.HPMN
Date: Wed,  9 Jul 2025 10:38:07 +0100
Message-ID: <20250709093808.920284-2-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709093808.920284-1-ben.horgan@arm.com>
References: <20250709093808.920284-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, u64_replace_bits() was used to no effect as the return value
was ignored. Convert to u64p_replace_bits() so the value is updated in
place.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Fixes: efff9dd2fee7 ("KVM: arm64: Handle out-of-bound write to MDCR_EL2.HPMN")
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..c20bd6f21e60 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2624,7 +2624,7 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
 	 */
 	if (hpmn > vcpu->kvm->arch.nr_pmu_counters) {
 		hpmn = vcpu->kvm->arch.nr_pmu_counters;
-		u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
+		u64p_replace_bits(&val, hpmn, MDCR_EL2_HPMN);
 	}
 
 	__vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);
-- 
2.43.0


