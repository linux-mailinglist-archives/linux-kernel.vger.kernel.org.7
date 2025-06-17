Return-Path: <linux-kernel+bounces-689850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D21ADC73A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7FF3B17C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BBE2EA49B;
	Tue, 17 Jun 2025 09:51:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A72EA489
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153886; cv=none; b=CpfqXtrGl9YM/A0u62ELsmwoKfJ/8So31nFvDvev6Lr9BE4tFVbKjMJOJRRypFJvsCE0mXj9lExzbM9F6tKPgqWn8z3XbtAajdzK/yZYMk3zugIVXb1yNvPhrfJWXTR4E/VHUlCv/cczkh1M1MeAn0fFqqZKrmA9IHfaIiFHIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153886; c=relaxed/simple;
	bh=PdW+HizsKVSFDoQfe1bBbPDMR85e8UQb7MF2CbYGEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7V/tX0g2DzLoq970Vkw6DvBQXYYodMNILzxA/gOWUmDpQAChplgw2+Db0NT7+8QM8mwzPyDSMWtts0jM1mDblKEELw7jrSZMqKSkk710xUU3NzJ+ChkIykm2zh+eIXqi6/DPcUxWDfdgVC0GJAW14Re5dIduLgtHRT/0GrCQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5B51688;
	Tue, 17 Jun 2025 02:51:03 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A113F58B;
	Tue, 17 Jun 2025 02:51:21 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Date: Tue, 17 Jun 2025 09:51:02 +0000
Message-ID: <20250617095104.6772-3-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617095104.6772-1-miko.lenczewski@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
and this commit adds a dedicated BBML2 cpufeature to test against
support for.

To support BBML2 in as wide a range of contexts as we can, we want not
only the architectural guarantees that BBML2 makes, but additionally
want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
us having to prove that no recursive faults can be induced in any path
that uses BBML2, allowing its use for arbitrary kernel mappings.

This feature builds on the previous ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
as all early cpus must support BBML2 for us to enable it (and any later
cpus must also support it to be onlined).

Not onlining late cpus that do not support BBML2 is unavoidable, as we
might currently be using BBML2 semantics for kernel memory regions. This
could cause faults in the late cpus, and would be difficult to unwind,
so let us avoid the case altogether.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  5 ++++
 arch/arm64/kernel/cpufeature.c      | 40 +++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 155ebd040c55..bf13d676aae2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -871,6 +871,11 @@ static inline bool system_supports_pmuv3(void)
 	return cpus_have_final_cap(ARM64_HAS_PMUV3);
 }
 
+static inline bool system_supports_bbml2_noabort(void)
+{
+	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f9c947166322..2e80ff237b96 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2213,6 +2213,41 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
+static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
+{
+	/*
+	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
+	 * as possible. This list is therefore an allow-list of known-good
+	 * implementations that both support BBML2 and additionally, fulfill the
+	 * extra constraint of never generating TLB conflict aborts when using
+	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
+	 * kernel contexts difficult to prove safe against recursive aborts).
+	 *
+	 * Note that implementations can only be considered "known-good" if their
+	 * implementors attest to the fact that the implementation never raises
+	 * TLBI conflict aborts for BBML2 mapping granularity changes.
+	 */
+	static const struct midr_range supports_bbml2_noabort_list[] = {
+		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
+		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		{}
+	};
+
+	/* Does our cpu guarantee to never raise TLB conflict aborts? */
+	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
+		return false;
+
+	/*
+	 * We currently ignore the AA64_ID_MMFR2 register, and only care about
+	 * whether the MIDR check passes. This is because we specifically
+	 * care only about a stricter form of BBML2 (one guaranteeing noabort),
+	 * and so the MMFR2 check is pointless (all implementations passing the
+	 * MIDR check should also pass the MMFR2 check).
+	 */
+
+	return true;
+}
+
 #ifdef CONFIG_ARM64_PAN
 static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
@@ -2980,6 +3015,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.capability = ARM64_HAS_BBML2_NOABORT,
+		.type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
+		.matches = has_bbml2_noabort,
+	},
 	{
 		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
 		.capability = ARM64_HAS_LPA2,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 10effd4cff6b..2bd2bfaeddcd 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -45,6 +45,7 @@ HAS_LPA2
 HAS_LSE_ATOMICS
 HAS_MOPS
 HAS_NESTED_VIRT
+HAS_BBML2_NOABORT
 HAS_PAN
 HAS_PMUV3
 HAS_S1PIE
-- 
2.49.0


