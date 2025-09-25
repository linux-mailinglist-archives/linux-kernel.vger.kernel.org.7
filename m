Return-Path: <linux-kernel+bounces-831791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35110B9D8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600C57B2BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61732E8DFC;
	Thu, 25 Sep 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFAP1Zhf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6782EA15E;
	Thu, 25 Sep 2025 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780939; cv=none; b=VvgVNel8b5QuP8sCx3ODhY3uatRyfDucm2kHkQRjg6M1SaV0x4nyJBJpiMhI1jK2pjgWA+c3SnEW4O8kwiXabsqFYZxwrPzXjMXP13jrM3odrlO2dfIMiloeHlM+PP+hrTEbza73lhPyfnG+Z8FbBBV9w5asg0/3y/oQnQ9XGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780939; c=relaxed/simple;
	bh=7yjobCrwNZBCTQFyRjWqP+yOtmtcedgw31livlnVAf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIyTuBAXWeE4jVkdnf5FbLxfAc/cyrX2zl9cHcloVmuToFhfnK5q24PbGYMYt+ZoqojewrSaDi8TaojgugsAao4joaEpHlcyCWZJ52AvgfTLnBZkmHi0w6dfnjKT+ILiMVDwj7aMgoJTCD5snvoPMCdl/BWh+a45hPFoCrNOUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFAP1Zhf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780937; x=1790316937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7yjobCrwNZBCTQFyRjWqP+yOtmtcedgw31livlnVAf8=;
  b=kFAP1ZhfHQIn5HGeW6AyFa8Yl0RNeZrNdrtXzd/AQ55sDJ3Z0Zfrkm1L
   zGxFJrEEDXjzTrZAOd8ZdEO9HTtxvLNGFkGhlJp7pZI5aq1joyRPwnrp3
   7H9G5HCI7Ik/gF/QLWpfFX3DQv8SAwMi07UbkomhdrIF+Yhb7SVakN8v8
   1qneNnIkd6Vv2ZQS573OD/XR0uxZXGDdzgxAyN8cNvu9rTn011Sv65piL
   Ng4hcSyBllk8Rf3WTevo8pzc4qTo2kEjVmfAy9potrPkmOcMKAlIpMB3P
   FbMAGz1q02OF9k3XBMVH7AsSwO+hLXy3sY6H1LNP58QMLejrser1h3D/0
   A==;
X-CSE-ConnectionGUID: SnhuJMvDS/qvgYcLPjPnOw==
X-CSE-MsgGUID: q172ym4dRVyRirga3jOSfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139646"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:36 -0700
X-CSE-ConnectionGUID: ueVFSmbAQEmlp8llsJFWaQ==
X-CSE-MsgGUID: 7PpyNxPxQ56q2AOZeo2dUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528704"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 16/17] perf tools: parse-regs: Support the new SIMD format
Date: Thu, 25 Sep 2025 14:12:12 +0800
Message-Id: <20250925061213.178796-17-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
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
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/perf_regs.c      | 443 +++++++++++++++++++++-
 tools/perf/util/evsel.c                   |  25 ++
 tools/perf/util/parse-regs-options.c      | 133 ++++++-
 tools/perf/util/perf_event_attr_fprintf.c |   6 +
 tools/perf/util/perf_regs.c               |  54 +++
 tools/perf/util/perf_regs.h               |  10 +
 tools/perf/util/record.h                  |   6 +
 7 files changed, 663 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 12fd93f04802..2e7a93d34cd1 100644
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
@@ -276,27 +319,377 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
+static bool support_simd_reg(u64 sample_type, u16 qwords, u64 mask, bool pred)
+{
+	struct perf_event_attr attr = {
+		.type				= PERF_TYPE_HARDWARE,
+		.config				= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type			= sample_type,
+		.disabled			= 1,
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
+static bool __arch_simd_reg_mask(u64 sample_type, int reg, uint64_t *mask, u16 *qwords)
+{
+	bool supported = false;
+	u64 bits;
+
+	*mask = 0;
+	*qwords = 0;
+
+	switch (reg) {
+	case PERF_REG_X86_XMM:
+		bits = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
+		supported = support_simd_reg(sample_type, PERF_X86_XMM_QWORDS, bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_XMM_QWORDS;
+		}
+		break;
+	case PERF_REG_X86_YMM:
+		bits = BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
+		supported = support_simd_reg(sample_type, PERF_X86_YMM_QWORDS, bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_YMM_QWORDS;
+		}
+		break;
+	case PERF_REG_X86_ZMM:
+		bits = BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
+		supported = support_simd_reg(sample_type, PERF_X86_ZMM_QWORDS, bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_ZMM_QWORDS;
+			break;
+		}
+
+		bits = BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
+		supported = support_simd_reg(sample_type, PERF_X86_ZMM_QWORDS, bits, false);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_ZMMH_QWORDS;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return supported;
+}
+
+static bool __arch_pred_reg_mask(u64 sample_type, int reg, uint64_t *mask, u16 *qwords)
+{
+	bool supported = false;
+	u64 bits;
+
+	*mask = 0;
+	*qwords = 0;
+
+	switch (reg) {
+	case PERF_REG_X86_OPMASK:
+		bits = BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
+		supported = support_simd_reg(sample_type, PERF_X86_OPMASK_QWORDS, bits, true);
+		if (supported) {
+			*mask = bits;
+			*qwords = PERF_X86_OPMASK_QWORDS;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return supported;
+}
+
+static bool has_cap_simd_regs(void)
+{
+	uint64_t mask = BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
+	u16 qwords = PERF_X86_XMM_QWORDS;
+	static bool has_cap_simd_regs;
+	static bool cached;
+
+	if (cached)
+		return has_cap_simd_regs;
+
+	has_cap_simd_regs = __arch_simd_reg_mask(PERF_SAMPLE_REGS_INTR,
+						 PERF_REG_X86_XMM, &mask, &qwords);
+	has_cap_simd_regs |= __arch_simd_reg_mask(PERF_SAMPLE_REGS_USER,
+						 PERF_REG_X86_XMM, &mask, &qwords);
+	cached = true;
+
+	return has_cap_simd_regs;
+}
+
+
+static const struct sample_reg sample_simd_reg_masks[] = {
+	SMPL_REG(XMM, PERF_REG_X86_XMM),
+	SMPL_REG(YMM, PERF_REG_X86_YMM),
+	SMPL_REG(ZMM, PERF_REG_X86_ZMM),
+	SMPL_REG_END
+};
+
+static const struct sample_reg sample_pred_reg_masks[] = {
+	SMPL_REG(OPMASK, PERF_REG_X86_OPMASK),
+	SMPL_REG_END
+};
+
+const struct sample_reg *arch__sample_simd_reg_masks(void)
+{
+	return sample_simd_reg_masks;
+}
+
+const struct sample_reg *arch__sample_pred_reg_masks(void)
+{
+	return sample_pred_reg_masks;
+}
+
+static bool x86_intr_simd_updated;
+static u64 x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
+static u16 x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
+static bool x86_user_simd_updated;
+static u64 x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_REGS];
+static u16 x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_REGS];
+
+static bool x86_intr_pred_updated;
+static u64 x86_intr_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
+static u16 x86_intr_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
+static bool x86_user_pred_updated;
+static u64 x86_user_pred_mask[PERF_REG_X86_MAX_PRED_REGS];
+static u16 x86_user_pred_qwords[PERF_REG_X86_MAX_PRED_REGS];
+
+static uint64_t __arch__simd_reg_mask(u64 sample_type)
+{
+	const struct sample_reg *r = NULL;
+	bool supported;
+	u64 mask = 0;
+	int reg;
+
+	if (!has_cap_simd_regs())
+		return 0;
+
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		supported = false;
+
+		if (!r->mask)
+			continue;
+		reg = fls64(r->mask) - 1;
+
+		if (reg >= PERF_REG_X86_MAX_SIMD_REGS)
+			break;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			supported = __arch_simd_reg_mask(sample_type, reg,
+							 &x86_intr_simd_mask[reg],
+							 &x86_intr_simd_qwords[reg]);
+		else if (sample_type == PERF_SAMPLE_REGS_USER)
+			supported = __arch_simd_reg_mask(sample_type, reg,
+							 &x86_user_simd_mask[reg],
+							 &x86_user_simd_qwords[reg]);
+		if (supported)
+			mask |= BIT_ULL(reg);
+	}
+
+	if (sample_type == PERF_SAMPLE_REGS_INTR)
+		x86_intr_simd_updated = true;
+	else
+		x86_user_simd_updated = true;
+
+	return mask;
+}
+
+static uint64_t __arch__pred_reg_mask(u64 sample_type)
+{
+	const struct sample_reg *r = NULL;
+	bool supported;
+	u64 mask = 0;
+	int reg;
+
+	if (!has_cap_simd_regs())
+		return 0;
+
+	for (r = arch__sample_pred_reg_masks(); r->name; r++) {
+		supported = false;
+
+		if (!r->mask)
+			continue;
+		reg = fls64(r->mask) - 1;
+
+		if (reg >= PERF_REG_X86_MAX_PRED_REGS)
+			break;
+		if (sample_type == PERF_SAMPLE_REGS_INTR)
+			supported = __arch_pred_reg_mask(sample_type, reg,
+							 &x86_intr_pred_mask[reg],
+							 &x86_intr_pred_qwords[reg]);
+		else if (sample_type == PERF_SAMPLE_REGS_USER)
+			supported = __arch_pred_reg_mask(sample_type, reg,
+							 &x86_user_pred_mask[reg],
+							 &x86_user_pred_qwords[reg]);
+		if (supported)
+			mask |= BIT_ULL(reg);
+	}
+
+	if (sample_type == PERF_SAMPLE_REGS_INTR)
+		x86_intr_pred_updated = true;
+	else
+		x86_user_pred_updated = true;
+
+	return mask;
+}
+
+uint64_t arch__intr_simd_reg_mask(void)
+{
+	return __arch__simd_reg_mask(PERF_SAMPLE_REGS_INTR);
+}
+
+uint64_t arch__user_simd_reg_mask(void)
+{
+	return __arch__simd_reg_mask(PERF_SAMPLE_REGS_USER);
+}
+
+uint64_t arch__intr_pred_reg_mask(void)
+{
+	return __arch__pred_reg_mask(PERF_SAMPLE_REGS_INTR);
+}
+
+uint64_t arch__user_pred_reg_mask(void)
+{
+	return __arch__pred_reg_mask(PERF_SAMPLE_REGS_USER);
+}
+
+static uint64_t arch__simd_reg_bitmap_qwords(int reg, u16 *qwords, bool intr)
+{
+	uint64_t mask = 0;
+
+	*qwords = 0;
+	if (reg < PERF_REG_X86_MAX_SIMD_REGS) {
+		if (intr) {
+			*qwords = x86_intr_simd_qwords[reg];
+			mask = x86_intr_simd_mask[reg];
+		} else {
+			*qwords = x86_user_simd_qwords[reg];
+			mask = x86_user_simd_mask[reg];
+		}
+	}
+
+	return mask;
+}
+
+static uint64_t arch__pred_reg_bitmap_qwords(int reg, u16 *qwords, bool intr)
+{
+	uint64_t mask = 0;
+
+	*qwords = 0;
+	if (reg < PERF_REG_X86_MAX_PRED_REGS) {
+		if (intr) {
+			*qwords = x86_intr_pred_qwords[reg];
+			mask = x86_intr_pred_mask[reg];
+		} else {
+			*qwords = x86_user_pred_qwords[reg];
+			mask = x86_user_pred_mask[reg];
+		}
+	}
+
+	return mask;
+}
+
+uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords)
+{
+	if (!x86_intr_simd_updated)
+		arch__intr_simd_reg_mask();
+	return arch__simd_reg_bitmap_qwords(reg, qwords, true);
+}
+
+uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords)
+{
+	if (!x86_user_simd_updated)
+		arch__user_simd_reg_mask();
+	return arch__simd_reg_bitmap_qwords(reg, qwords, false);
+}
+
+uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords)
+{
+	if (!x86_intr_pred_updated)
+		arch__intr_pred_reg_mask();
+	return arch__pred_reg_bitmap_qwords(reg, qwords, true);
+}
+
+uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords)
+{
+	if (!x86_user_pred_updated)
+		arch__user_pred_reg_mask();
+	return arch__pred_reg_bitmap_qwords(reg, qwords, false);
+}
+
 const struct sample_reg *arch__sample_reg_masks(void)
 {
+	if (has_cap_simd_regs())
+		return sample_reg_masks_ext;
 	return sample_reg_masks;
 }
 
-uint64_t arch__intr_reg_mask(void)
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
+		.disabled			= 1,
+		.precise_ip			= 1,
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
@@ -318,13 +711,41 @@ uint64_t arch__intr_reg_mask(void)
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
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..98996e672794 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1387,12 +1387,37 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
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
index cda1c620968e..c66d0769096b 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -4,19 +4,104 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdio.h>
+#include <linux/bitops.h>
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/perf_regs.h"
 #include "util/parse-regs-options.h"
+#include "record.h"
+
+static void __print_simd_regs(bool intr, uint64_t simd_mask, uint64_t pred_mask)
+{
+	const struct sample_reg *r = NULL;
+	uint64_t bitmap = 0;
+	u16 qwords = 0;
+	int idx;
+
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		if (r->mask & simd_mask) {
+			idx = fls64(r->mask) - 1;
+			if (intr)
+				bitmap = arch__intr_simd_reg_bitmap_qwords(idx, &qwords);
+			else
+				bitmap = arch__user_simd_reg_bitmap_qwords(idx, &qwords);
+			if (bitmap)
+				fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
+		}
+	}
+
+	for (r = arch__sample_pred_reg_masks(); r->name; r++) {
+		if (r->mask & pred_mask) {
+			idx = fls64(r->mask) - 1;
+			if (intr)
+				bitmap = arch__intr_pred_reg_bitmap_qwords(idx, &qwords);
+			else
+				bitmap = arch__user_pred_reg_bitmap_qwords(idx, &qwords);
+			if (bitmap)
+				fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
+		}
+	}
+}
+
+static uint64_t __get_simd_reg_bitmask_qwords(bool intr, char *reg_name, u16 *qwords)
+{
+	const struct sample_reg *r = NULL;
+	uint64_t bitmap = 0;
+	int idx;
+
+	*qwords = 0;
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		if (!strcasecmp(reg_name, r->name)) {
+			if (!fls64(r->mask))
+				continue;
+			idx = fls64(r->mask) - 1;
+			if (intr)
+				bitmap = arch__intr_simd_reg_bitmap_qwords(idx, qwords);
+			else
+				bitmap = arch__user_simd_reg_bitmap_qwords(idx, qwords);
+			break;
+		}
+	}
+
+	return bitmap;
+}
+
+static uint64_t __get_pred_reg_bitmask_qwords(bool intr, char *reg_name, u16 *qwords)
+{
+	const struct sample_reg *r = NULL;
+	uint64_t bitmap = 0;
+	int idx;
+
+	*qwords = 0;
+	for (r = arch__sample_pred_reg_masks(); r->name; r++) {
+		if (!strcasecmp(reg_name, r->name)) {
+			if (!fls64(r->mask))
+				continue;
+			idx = fls64(r->mask) - 1;
+			if (intr)
+				bitmap = arch__intr_pred_reg_bitmap_qwords(idx, qwords);
+			else
+				bitmap = arch__user_pred_reg_bitmap_qwords(idx, qwords);
+			break;
+		}
+	}
+
+	return bitmap;
+}
 
 static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r = NULL;
+	struct record_opts *opts;
 	char *s, *os = NULL, *p;
 	int ret = -1;
 	uint64_t mask;
+	uint64_t simd_mask;
+	uint64_t pred_mask;
+	uint64_t bitmap = 0;
+	u16 qwords = 0;
 
 	if (unset)
 		return 0;
@@ -27,10 +112,17 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	if (*mode)
 		return -1;
 
-	if (intr)
+	if (intr) {
+		opts = container_of(opt->value, struct record_opts, sample_intr_regs);
 		mask = arch__intr_reg_mask();
-	else
+		simd_mask = arch__intr_simd_reg_mask();
+		pred_mask = arch__intr_pred_reg_mask();
+	} else {
+		opts = container_of(opt->value, struct record_opts, sample_user_regs);
 		mask = arch__user_reg_mask();
+		simd_mask = arch__user_simd_reg_mask();
+		pred_mask = arch__user_pred_reg_mask();
+	}
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
@@ -50,10 +142,45 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 					if (r->mask & mask)
 						fprintf(stderr, "%s ", r->name);
 				}
+				if (simd_mask || pred_mask)
+					__print_simd_regs(intr, simd_mask, pred_mask);
+
 				fputc('\n', stderr);
 				/* just printing available regs */
 				goto error;
 			}
+
+			if (simd_mask) {
+				bitmap = __get_simd_reg_bitmask_qwords(intr, s, &qwords);
+
+				/* Just need the highest qwords */
+				if (qwords > opts->sample_vec_regs_qwords) {
+					opts->sample_vec_regs_qwords = qwords;
+					if (intr)
+						opts->sample_intr_vec_regs = bitmap;
+					else
+						opts->sample_user_vec_regs = bitmap;
+				}
+
+				if (bitmap)
+					goto next;
+			}
+			if (pred_mask) {
+				bitmap = __get_pred_reg_bitmask_qwords(intr, s, &qwords);
+
+				/* Just need the highest qwords */
+				if (qwords > opts->sample_pred_regs_qwords) {
+					opts->sample_pred_regs_qwords = qwords;
+					if (intr)
+						opts->sample_intr_pred_regs = bitmap;
+					else
+						opts->sample_user_pred_regs = bitmap;
+				}
+
+				if (bitmap)
+					goto next;
+			}
+
 			for (r = arch__sample_reg_masks(); r->name; r++) {
 				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
@@ -65,7 +192,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
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
index 44b90bbf2d07..107bbf7dbcfe 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -21,6 +21,50 @@ uint64_t __weak arch__user_reg_mask(void)
 	return 0;
 }
 
+uint64_t __weak arch__intr_simd_reg_mask(void)
+{
+	return 0;
+}
+
+uint64_t __weak arch__user_simd_reg_mask(void)
+{
+	return 0;
+}
+
+uint64_t __weak arch__intr_pred_reg_mask(void)
+{
+	return 0;
+}
+
+uint64_t __weak arch__user_pred_reg_mask(void)
+{
+	return 0;
+}
+
+uint64_t __weak arch__intr_simd_reg_bitmap_qwords(int reg  __maybe_unused, u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__user_simd_reg_bitmap_qwords(int reg __maybe_unused, u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__intr_pred_reg_bitmap_qwords(int reg  __maybe_unused, u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
+uint64_t __weak arch__user_pred_reg_bitmap_qwords(int reg __maybe_unused, u16 *qwords)
+{
+	*qwords = 0;
+	return 0;
+}
+
 static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
@@ -30,6 +74,16 @@ const struct sample_reg * __weak arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
+const struct sample_reg * __weak arch__sample_simd_reg_masks(void)
+{
+	return sample_reg_masks;
+}
+
+const struct sample_reg * __weak arch__sample_pred_reg_masks(void)
+{
+	return sample_reg_masks;
+}
+
 const char *perf_reg_name(int id, const char *arch)
 {
 	const char *reg_name = NULL;
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index f2d0736d65cc..cd98f9b9f964 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -27,6 +27,16 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op);
 uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 const struct sample_reg *arch__sample_reg_masks(void);
+const struct sample_reg *arch__sample_simd_reg_masks(void);
+const struct sample_reg *arch__sample_pred_reg_masks(void);
+uint64_t arch__intr_simd_reg_mask(void);
+uint64_t arch__user_simd_reg_mask(void);
+uint64_t arch__intr_pred_reg_mask(void);
+uint64_t arch__user_pred_reg_mask(void);
+uint64_t arch__intr_simd_reg_bitmap_qwords(int reg, u16 *qwords);
+uint64_t arch__user_simd_reg_bitmap_qwords(int reg, u16 *qwords);
+uint64_t arch__intr_pred_reg_bitmap_qwords(int reg, u16 *qwords);
+uint64_t arch__user_pred_reg_bitmap_qwords(int reg, u16 *qwords);
 
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
2.34.1


