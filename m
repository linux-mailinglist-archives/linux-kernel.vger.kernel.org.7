Return-Path: <linux-kernel+bounces-771486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34150B287E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE3B6649D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C0304BD2;
	Fri, 15 Aug 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efWb0df2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FA30DEDA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293759; cv=none; b=qzMl+VgUq9j1qZa6UgFldfNVh/pbkkycEtooMVoSvXtIeYFcbWi7Pa9ItSheQz6G1Aj7dOdQJgaqb26MCt6WEaZzzos9q8IMgJjt2YwLfiy4/g8XnwAXx9JH/yYSnQYTHDVHl25eJpR6UGBiKshuGfRM3hIAmIN8tahMrkeCYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293759; c=relaxed/simple;
	bh=/3YdOgnYd6GHMZ2BququByk6yNTsCgpGYwQ2+816BFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tg78tFP7BotweoefoYNL+VPORmshLLdpJ4Uttr2z/pJgzcuur/nIzylT5sKEhEKj2InwiZPcfk+a1LBewZROAKUzYeIv70dA4hP9vSodSX98pZrasD5l6cT8pIVSScAwNcFQzQBwHzB2aYVbqAsGHWVACn8O04x0xJjg/GCyqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efWb0df2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293756; x=1786829756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/3YdOgnYd6GHMZ2BququByk6yNTsCgpGYwQ2+816BFs=;
  b=efWb0df2Oprgw4a5UYMY7aaWHONXxIi9UM1W1Jno7uMSgwwhFpPxW7I6
   Xd58bQ9dR1VxIJTrraNO1PfV/IMX7KWfJ3eNxUkAwApjlTy4I+T6gCz6H
   yiJr2pQgenDTWI2/fLdqqwb56YnPyhM21+UT/QYTo003EP2B6pMhVpaS9
   5aTs5jxklEpEpmdjq/vILLNK9HSM9dLizuzE9RMqDxutbDMK0JazS4V1p
   V8xpk8xj41o1I73kT2rbnsIPYvuExfh9EIQo/KRE7mCH9jzKjrbVjH52L
   S+9E7EZ5aFw+B3QR9Li694FLwUY1wb9N6QhVd7rxnilwdkwNRjCNB2sI0
   g==;
X-CSE-ConnectionGUID: 3AFS5RWsRXa0m9ZZlaAajA==
X-CSE-MsgGUID: mZGkSqKASLKNBf4uvjyvSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707483"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707483"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:48 -0700
X-CSE-ConnectionGUID: Gv298BkmRpOKOksqR8t+2g==
X-CSE-MsgGUID: dFBDLjlVTbmBh9F+9y/BDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319630"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:48 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [POC PATCH 16/17] perf parse-regs: Support the new SIMD format
Date: Fri, 15 Aug 2025 14:34:34 -0700
Message-Id: <20250815213435.1702022-17-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Add has_cap_simd_regs() to check if the new SIMD format is available.
If yes, get the possible mask and qwords.

Add several __weak functions to return qwords and mask for vector and
pred registers.

Only support collecting the vector and pred as a whole, and only the
superset. For example, -I XMM,YMM. Only collect all 16 YMMs.

Examples:
 $perf record -I?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

 $perf record --user-regs=?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/perf_regs.c      | 257 +++++++++++++++++++++-
 tools/perf/util/evsel.c                   |  25 +++
 tools/perf/util/parse-regs-options.c      |  60 ++++-
 tools/perf/util/perf_event_attr_fprintf.c |   6 +
 tools/perf/util/perf_regs.c               |  29 +++
 tools/perf/util/perf_regs.h               |  13 +-
 tools/perf/util/record.h                  |   6 +
 7 files changed, 381 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 12fd93f04802..78027df1af9a 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -13,6 +13,49 @@
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 
+static const struct sample_reg sample_reg_masks_ext[] = {
+	SMPL_REG(AX, PERF_REG_X86_AX),
+	SMPL_REG(BX, PERF_REG_X86_BX),
+	SMPL_REG(CX, PERF_REG_X86_CX),
+	SMPL_REG(DX, PERF_REG_X86_DX),
+	SMPL_REG(SI, PERF_REG_X86_SI),
+	SMPL_REG(DI, PERF_REG_X86_DI),
+	SMPL_REG(BP, PERF_REG_X86_BP),
+	SMPL_REG(SP, PERF_REG_X86_SP),
+	SMPL_REG(IP, PERF_REG_X86_IP),
+	SMPL_REG(FLAGS, PERF_REG_X86_FLAGS),
+	SMPL_REG(CS, PERF_REG_X86_CS),
+	SMPL_REG(SS, PERF_REG_X86_SS),
+#ifdef HAVE_ARCH_X86_64_SUPPORT
+	SMPL_REG(R8, PERF_REG_X86_R8),
+	SMPL_REG(R9, PERF_REG_X86_R9),
+	SMPL_REG(R10, PERF_REG_X86_R10),
+	SMPL_REG(R11, PERF_REG_X86_R11),
+	SMPL_REG(R12, PERF_REG_X86_R12),
+	SMPL_REG(R13, PERF_REG_X86_R13),
+	SMPL_REG(R14, PERF_REG_X86_R14),
+	SMPL_REG(R15, PERF_REG_X86_R15),
+	SMPL_REG(R16, PERF_REG_X86_R16),
+	SMPL_REG(R17, PERF_REG_X86_R17),
+	SMPL_REG(R18, PERF_REG_X86_R18),
+	SMPL_REG(R19, PERF_REG_X86_R19),
+	SMPL_REG(R20, PERF_REG_X86_R20),
+	SMPL_REG(R21, PERF_REG_X86_R21),
+	SMPL_REG(R22, PERF_REG_X86_R22),
+	SMPL_REG(R23, PERF_REG_X86_R23),
+	SMPL_REG(R24, PERF_REG_X86_R24),
+	SMPL_REG(R25, PERF_REG_X86_R25),
+	SMPL_REG(R26, PERF_REG_X86_R26),
+	SMPL_REG(R27, PERF_REG_X86_R27),
+	SMPL_REG(R28, PERF_REG_X86_R28),
+	SMPL_REG(R29, PERF_REG_X86_R29),
+	SMPL_REG(R30, PERF_REG_X86_R30),
+	SMPL_REG(R31, PERF_REG_X86_R31),
+	SMPL_REG(SSP, PERF_REG_X86_SSP),
+#endif
+	SMPL_REG_END
+};
+
 static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
 	SMPL_REG(BX, PERF_REG_X86_BX),
@@ -276,27 +319,159 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
+static bool support_simd_reg(u64 sample_type, u16 qwords, u64 mask, bool pred)
+{
+	struct perf_event_attr attr = {
+		.type				= PERF_TYPE_HARDWARE,
+		.config				= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type			= sample_type,
+		.disabled 			= 1,
+		.exclude_kernel			= 1,
+		.sample_simd_regs_enabled	= 1,
+	};
+	int fd;
+
+	attr.sample_period = 1;
+
+	if (!pred) {
+		attr.sample_simd_vec_reg_qwords = qwords;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			attr.sample_simd_vec_reg_intr = mask;
+		else
+			attr.sample_simd_vec_reg_user = mask;
+	} else {
+		attr.sample_simd_pred_reg_qwords = PERF_X86_OPMASK_QWORDS;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			attr.sample_simd_pred_reg_intr = PERF_X86_SIMD_PRED_MASK;
+		else
+			attr.sample_simd_pred_reg_user = PERF_X86_SIMD_PRED_MASK;
+	}
+
+	if (perf_pmus__num_core_pmus() > 1) {
+		struct perf_pmu *pmu = NULL;
+		__u64 type = PERF_TYPE_RAW;
+
+		/*
+		 * The same register set is supported among different hybrid PMUs.
+		 * Only check the first available one.
+		 */
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			type = pmu->type;
+			break;
+		}
+		attr.config |= type << PERF_PMU_TYPE_SHIFT;
+	}
+
+	event_attr_init(&attr);
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		return true;
+	}
+
+	return false;
+}
+
+static uint64_t intr_simd_mask, user_simd_mask, pred_mask;
+static u16	intr_simd_qwords, user_simd_qwords, pred_qwords;
+
+static bool get_simd_reg_mask(u64 sample_type)
+{
+	u64 mask = GENMASK_ULL(PERF_X86_H16ZMM_BASE - 1, 0);
+	u16 qwords = PERF_X86_ZMM_QWORDS;
+
+	if (support_simd_reg(sample_type, qwords, mask, false)) {
+		if (support_simd_reg(sample_type, qwords, PERF_X86_SIMD_VEC_MASK, false))
+			mask = PERF_X86_SIMD_VEC_MASK;
+	} else {
+		qwords = PERF_X86_YMM_QWORDS;
+		if (!support_simd_reg(sample_type, qwords, mask, false)) {
+			qwords = PERF_X86_XMM_QWORDS;
+			if (!support_simd_reg(sample_type, qwords, mask, false)) {
+				qwords = 0;
+				mask = 0;
+			}
+		}
+	}
+
+	if (sample_type == PERF_SAMPLE_REGS_INTR) {
+		intr_simd_mask = mask;
+		intr_simd_qwords = qwords;
+	} else {
+		user_simd_mask = mask;
+		user_simd_qwords = qwords;
+	}
+
+	if (support_simd_reg(sample_type, qwords, mask, true)) {
+		pred_mask = PERF_X86_SIMD_PRED_MASK;
+		pred_qwords = PERF_X86_OPMASK_QWORDS;
+	}
+
+	return true;
+}
+
+static bool has_cap_simd_regs(void)
+{
+	static bool has_cap_simd_regs;
+	static bool cached;
+
+	if (cached)
+		return has_cap_simd_regs;
+
+	cached = true;
+	has_cap_simd_regs = get_simd_reg_mask(PERF_SAMPLE_REGS_INTR);
+	has_cap_simd_regs |= get_simd_reg_mask(PERF_SAMPLE_REGS_USER);
+
+	return has_cap_simd_regs;
+}
+
 const struct sample_reg *arch__sample_reg_masks(void)
 {
+	if (has_cap_simd_regs())
+		return sample_reg_masks_ext;
 	return sample_reg_masks;
 }
 
-uint64_t arch__intr_reg_mask(void)
+static const struct sample_reg sample_simd_reg_masks_empty[] = {
+	SMPL_REG_END
+};
+
+static const struct sample_reg sample_simd_reg_masks[] = {
+	SMPL_REG(XMM, 1),
+	SMPL_REG(YMM, 2),
+	SMPL_REG(ZMM, 3),
+	SMPL_REG(OPMASK, 32),
+	SMPL_REG_END
+};
+
+const struct sample_reg *arch__sample_simd_reg_masks(void)
+{
+	if (has_cap_simd_regs())
+		return sample_simd_reg_masks;
+	return sample_simd_reg_masks_empty;
+}
+
+static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
 {
 	struct perf_event_attr attr = {
-		.type			= PERF_TYPE_HARDWARE,
-		.config			= PERF_COUNT_HW_CPU_CYCLES,
-		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
-		.precise_ip		= 1,
-		.disabled 		= 1,
-		.exclude_kernel		= 1,
+		.type				= PERF_TYPE_HARDWARE,
+		.config				= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type			= sample_type,
+		.precise_ip			= 1,
+		.disabled 			= 1,
+		.exclude_kernel			= 1,
+		.sample_simd_regs_enabled	= has_simd_regs,
 	};
 	int fd;
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
 	attr.sample_period = 1;
+	if (sample_type == PERF_SAMPLE_REGS_INTR)
+		attr.sample_regs_intr = mask;
+	else
+		attr.sample_regs_user = mask;
 
 	if (perf_pmus__num_core_pmus() > 1) {
 		struct perf_pmu *pmu = NULL;
@@ -318,13 +493,73 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
+		return mask;
 	}
 
-	return PERF_REGS_MASK;
+	return 0;
+}
+
+uint64_t arch__intr_reg_mask(void)
+{
+	uint64_t mask = PERF_REGS_MASK;
+
+	if (has_cap_simd_regs()) {
+		mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
+					 GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
+					 true);
+		mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR,
+					 BIT_ULL(PERF_REG_X86_SSP),
+					 true);
+	} else
+		mask |= __arch__reg_mask(PERF_SAMPLE_REGS_INTR, PERF_REG_EXTENDED_MASK, false);
+
+	return mask;
 }
 
 uint64_t arch__user_reg_mask(void)
 {
-	return PERF_REGS_MASK;
+	uint64_t mask = PERF_REGS_MASK;
+
+	if (has_cap_simd_regs()) {
+		mask |= __arch__reg_mask(PERF_SAMPLE_REGS_USER,
+					 GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16),
+					 true);
+		mask |= __arch__reg_mask(PERF_SAMPLE_REGS_USER,
+					 BIT_ULL(PERF_REG_X86_SSP),
+					 true);
+	}
+
+	return mask;
+}
+
+uint64_t arch__intr_simd_reg_mask(u16 *qwords)
+{
+	if (!has_cap_simd_regs())
+		return 0;
+	*qwords = intr_simd_qwords;
+	return intr_simd_mask;
+}
+
+uint64_t arch__user_simd_reg_mask(u16 *qwords)
+{
+	if (!has_cap_simd_regs())
+		return 0;
+	*qwords = user_simd_qwords;
+	return user_simd_mask;
+}
+
+uint64_t arch__intr_pred_reg_mask(u16 *qwords)
+{
+	if (!has_cap_simd_regs())
+		return 0;
+	*qwords = pred_qwords;
+	return pred_mask;
+}
+
+uint64_t arch__user_pred_reg_mask(u16 *qwords)
+{
+	if (!has_cap_simd_regs())
+		return 0;
+	*qwords = pred_qwords;
+	return pred_mask;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..af6e1c843fc5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1402,12 +1402,37 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
+	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		/* The pred qwords is to implies the set of SIMD registers is used */
+		if (opts->sample_pred_regs_qwords)
+			attr->sample_simd_pred_reg_qwords = opts->sample_pred_regs_qwords;
+		else
+			attr->sample_simd_pred_reg_qwords = 1;
+		attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
+		attr->sample_simd_vec_reg_qwords = opts->sample_vec_regs_qwords;
+		attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
+		evsel__set_sample_bit(evsel, REGS_INTR);
+	}
+
 	if (opts->sample_user_regs && !evsel->no_aux_samples &&
 	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_user |= opts->sample_user_regs;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
 
+	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
+	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
+		if (opts->sample_pred_regs_qwords)
+			attr->sample_simd_pred_reg_qwords = opts->sample_pred_regs_qwords;
+		else
+			attr->sample_simd_pred_reg_qwords = 1;
+		attr->sample_simd_vec_reg_user = opts->sample_user_vec_regs;
+		attr->sample_simd_vec_reg_qwords = opts->sample_vec_regs_qwords;
+		attr->sample_simd_pred_reg_user = opts->sample_user_pred_regs;
+		evsel__set_sample_bit(evsel, REGS_USER);
+	}
+
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		evsel__set_sample_bit(evsel, CPU);
 
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index cda1c620968e..27266038352f 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -4,20 +4,26 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdio.h>
+#include <linux/bitops.h>
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
+#include "record.h"
 
 static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r = NULL;
+	u16 simd_qwords, pred_qwords;
+	u64 simd_mask, pred_mask;
+	struct record_opts *opts;
 	char *s, *os = NULL, *p;
 	int ret = -1;
 	uint64_t mask;
 
+
 	if (unset)
 		return 0;
 
@@ -27,10 +33,17 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	if (intr)
+	if (intr) {
+		opts = container_of(opt->value, struct record_opts, sample_intr_regs);
 		mask = arch__intr_reg_mask();
-	else
+		simd_mask = arch__intr_simd_reg_mask(&simd_qwords);
+		pred_mask = arch__intr_pred_reg_mask(&pred_qwords);
+	} else {
+		opts = container_of(opt->value, struct record_opts, sample_user_regs);
 		mask = arch__user_reg_mask();
+		simd_mask = arch__user_simd_reg_mask(&simd_qwords);
+		pred_mask = arch__user_pred_reg_mask(&pred_qwords);
+	}
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
@@ -50,10 +63,51 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 					if (r->mask & mask)
 						fprintf(stderr, "%s ", r->name);
 				}
+				for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+					if (pred_qwords == r->qwords.pred) {
+						fprintf(stderr, "%s0-%d ", r->name, fls64(pred_mask) - 1);
+						continue;
+					}
+					if (simd_qwords >= r->mask)
+						fprintf(stderr, "%s0-%d ", r->name, fls64(simd_mask) - 1);
+				}
+
 				fputc('\n', stderr);
 				/* just printing available regs */
 				goto error;
 			}
+
+			if (simd_mask || pred_mask) {
+				u16 vec_regs_qwords = 0, pred_regs_qwords = 0;
+
+				for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+					if (!strcasecmp(s, r->name)) {
+						vec_regs_qwords = r->qwords.vec;
+						pred_regs_qwords = r->qwords.pred;
+						break;
+					}
+				}
+
+				/* Just need the highest qwords */
+				if (vec_regs_qwords > opts->sample_vec_regs_qwords) {
+					opts->sample_vec_regs_qwords = vec_regs_qwords;
+					if (intr)
+						opts->sample_intr_vec_regs = simd_mask;
+					else
+						opts->sample_user_vec_regs = simd_mask;
+				}
+				if (pred_regs_qwords > opts->sample_pred_regs_qwords) {
+					opts->sample_pred_regs_qwords = pred_regs_qwords;
+					if (intr)
+						opts->sample_intr_pred_regs = pred_mask;
+					else
+						opts->sample_user_pred_regs = pred_mask;
+				}
+
+				if (r->name)
+					goto next;
+			}
+
 			for (r = arch__sample_reg_masks(); r->name; r++) {
 				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
@@ -65,7 +119,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 			}
 
 			*mode |= r->mask;
-
+next:
 			if (!p)
 				break;
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 66b666d9ce64..fb0366d050cf 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -360,6 +360,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_start_paused, p_unsigned);
 	PRINT_ATTRf(aux_pause, p_unsigned);
 	PRINT_ATTRf(aux_resume, p_unsigned);
+	PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
+	PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
+	PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
+	PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
+	PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
+	PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
 
 	return ret;
 }
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 44b90bbf2d07..0744c77b4ac8 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -21,6 +21,30 @@ uint64_t __weak arch__user_reg_mask(void)
 	return 0;
 }
 
+uint64_t __weak arch__intr_simd_reg_mask(u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__user_simd_reg_mask(u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__intr_pred_reg_mask(u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__user_pred_reg_mask(u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
 static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
@@ -30,6 +54,11 @@ const struct sample_reg * __weak arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
+const struct sample_reg * __weak arch__sample_simd_reg_masks(void)
+{
+	return sample_reg_masks;
+}
+
 const char *perf_reg_name(int id, const char *arch)
 {
 	const char *reg_name = NULL;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index f2d0736d65cc..b932caa73a8a 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -9,7 +9,13 @@ struct regs_dump;
 
 struct sample_reg {
 	const char *name;
-	uint64_t mask;
+	union {
+		struct {
+			uint32_t vec;
+			uint32_t pred;
+		} qwords;
+		uint64_t mask;
+	};
 };
 
 #define SMPL_REG_MASK(b) (1ULL << (b))
@@ -27,6 +33,11 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 const struct sample_reg *arch__sample_reg_masks(void);
+const struct sample_reg *arch__sample_simd_reg_masks(void);
+uint64_t arch__intr_simd_reg_mask(u16 *qwords);
+uint64_t arch__user_simd_reg_mask(u16 *qwords);
+uint64_t arch__intr_pred_reg_mask(u16 *qwords);
+uint64_t arch__user_pred_reg_mask(u16 *qwords);
 
 const char *perf_reg_name(int id, const char *arch);
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index ea3a6c4657ee..825ffb4cc53f 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -59,7 +59,13 @@ struct record_opts {
 	unsigned int  user_freq;
 	u64	      branch_stack;
 	u64	      sample_intr_regs;
+	u64	      sample_intr_vec_regs;
 	u64	      sample_user_regs;
+	u64	      sample_user_vec_regs;
+	u16	      sample_pred_regs_qwords;
+	u16	      sample_vec_regs_qwords;
+	u16	      sample_intr_pred_regs;
+	u16	      sample_user_pred_regs;
 	u64	      default_interval;
 	u64	      user_interval;
 	size_t	      auxtrace_snapshot_size;
-- 
2.38.1


