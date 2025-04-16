Return-Path: <linux-kernel+bounces-604606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53656A89680
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93106189D35A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291429117D;
	Tue, 15 Apr 2025 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ+y+La1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F828F538;
	Tue, 15 Apr 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705462; cv=none; b=W0TTNz2bX9I5mJbxuUg4Y+kS0X9Lp0URd+uerkQbRxOYjZVQU5yyEc2JlZ5Q7Z6hjGcufQ8MrKo7+OnKZDOOKoqzrY5gsZhF7a/TKqaNHBnTC06tinYQcQ7ce9C7Burt4x+PTNxOlNVfc8xTspKIw3bSimQ/7Muzi/8SXf9jZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705462; c=relaxed/simple;
	bh=pKsfa88mosn9f8QHFusnwOz+UfKkd03V/+U8xSDrrKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2S4vdTmCgd237EkKXV4SNHbT8nRvNNfFUoJDVu9dbuf26ADaEUHlvsdsm1V4LbPgAp+oiJPfTKkWbYM9ftAEXEG+JOgjmmW01ZIhhcix5nb5AzndpqdLddeExD2FcfsK1AGEna32q8wFO5Y5kD20gEjd6untskXhIGSvW9Y6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ+y+La1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705461; x=1776241461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKsfa88mosn9f8QHFusnwOz+UfKkd03V/+U8xSDrrKE=;
  b=NJ+y+La1b7IzSQzws1i1fz/4JZOaIqork05dkqzSPwBJByIs4DwRJHDq
   q/N0y4w6FuCUv728lAY2V8Cc6Ym0D2Sqt34sIE2YS5ujlVDfLZBIIOb9V
   jROTDIWaJKy4dOdesx08thm8N/dhme2mwtyMrurmXKTzRe0UuyrqRd+GD
   CG3OQ6X42MKsYmpgyuCLpeWzHOINVJiH72y6cOKI76JdU4eK6AyTZ3u4+
   w1s26h6JDjjzWUdMjdDztTS5GRYZGIPU1BxKvlv56PVHiRSwivnFfeuhG
   +KJf8jWMNL+VN3phEI8v1Q0uCO8MGS9q415cCS0Kd8REkaJV3ozWuSFCr
   g==;
X-CSE-ConnectionGUID: gzlI68AERBW9szAyj1UvuA==
X-CSE-MsgGUID: xV0DeVlCRIui/GVjxF92eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116159"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:19 -0700
X-CSE-ConnectionGUID: bgDEVn2BSoqbL9vF3Z8yRg==
X-CSE-MsgGUID: eFhq9IZ9QMiQ9oPaFOdyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055687"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:14 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 19/22] perf tools: Enhance arch__intr/user_reg_mask() helpers
Date: Tue, 15 Apr 2025 11:44:25 +0000
Message-Id: <20250415114428.341182-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch-PEBS supports to capture more higher-width vector registers, like
YMM/ZMM registers, while the return value "uint64_t" of these 2 helpers
is not enough to represent these new added registors. Thus enhance these
two helpers by passing a "unsigned long" pointer, so these two helpers
can return more bits via this pointer.

Currently only sample_intr_regs supports these new added vector
registers, but change arch__user_reg_mask() for the sake of consistency
as well.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/arm/util/perf_regs.c       |  8 ++++----
 tools/perf/arch/arm64/util/perf_regs.c     | 11 ++++++-----
 tools/perf/arch/csky/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/loongarch/util/perf_regs.c |  8 ++++----
 tools/perf/arch/mips/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/powerpc/util/perf_regs.c   | 17 +++++++++--------
 tools/perf/arch/riscv/util/perf_regs.c     |  8 ++++----
 tools/perf/arch/s390/util/perf_regs.c      |  8 ++++----
 tools/perf/arch/x86/util/perf_regs.c       | 13 +++++++------
 tools/perf/util/evsel.c                    |  6 ++++--
 tools/perf/util/parse-regs-options.c       |  6 +++---
 tools/perf/util/perf_regs.c                |  8 ++++----
 tools/perf/util/perf_regs.h                |  4 ++--
 13 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
index f94a0210c7b7..14f18d518c96 100644
--- a/tools/perf/arch/arm/util/perf_regs.c
+++ b/tools/perf/arch/arm/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 09308665e28a..9bcf4755290c 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -140,12 +140,12 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type                   = PERF_TYPE_HARDWARE,
@@ -170,10 +170,11 @@ uint64_t arch__user_reg_mask(void)
 		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
-			return attr.sample_regs_user;
+			*(uint64_t *)mask = attr.sample_regs_user;
+			return;
 		}
 	}
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/csky/util/perf_regs.c
+++ b/tools/perf/arch/csky/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
index f94a0210c7b7..14f18d518c96 100644
--- a/tools/perf/arch/loongarch/util/perf_regs.c
+++ b/tools/perf/arch/loongarch/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/mips/util/perf_regs.c b/tools/perf/arch/mips/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/mips/util/perf_regs.c
+++ b/tools/perf/arch/mips/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index bd36cfd420a2..e5d042305030 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -187,7 +187,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 	return SDT_ARG_VALID;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type                   = PERF_TYPE_HARDWARE,
@@ -199,7 +199,7 @@ uint64_t arch__intr_reg_mask(void)
 	};
 	int fd;
 	u32 version;
-	u64 extended_mask = 0, mask = PERF_REGS_MASK;
+	u64 extended_mask = 0;
 
 	/*
 	 * Get the PVR value to set the extended
@@ -210,8 +210,10 @@ uint64_t arch__intr_reg_mask(void)
 		extended_mask = PERF_REG_PMU_MASK_300;
 	else if ((version == PVR_POWER10) || (version == PVR_POWER11))
 		extended_mask = PERF_REG_PMU_MASK_31;
-	else
-		return mask;
+	else {
+		*(u64 *)mask = PERF_REGS_MASK;
+		return;
+	}
 
 	attr.sample_regs_intr = extended_mask;
 	attr.sample_period = 1;
@@ -224,14 +226,13 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		mask |= extended_mask;
+		*(u64 *)mask = PERF_REGS_MASK | extended_mask;
 	}
-	return mask;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/riscv/util/perf_regs.c
+++ b/tools/perf/arch/riscv/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
index 6b1665f41180..56c84fc91aff 100644
--- a/tools/perf/arch/s390/util/perf_regs.c
+++ b/tools/perf/arch/s390/util/perf_regs.c
@@ -6,14 +6,14 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
 
 const struct sample_reg *arch__sample_reg_masks(void)
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 9f492568f3b4..5b163f0a651a 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -283,7 +283,7 @@ const struct sample_reg *arch__sample_reg_masks(void)
 	return sample_reg_masks;
 }
 
-uint64_t arch__intr_reg_mask(void)
+void arch__intr_reg_mask(unsigned long *mask)
 {
 	struct perf_event_attr attr = {
 		.type			= PERF_TYPE_HARDWARE,
@@ -295,6 +295,9 @@ uint64_t arch__intr_reg_mask(void)
 		.exclude_kernel		= 1,
 	};
 	int fd;
+
+	*(u64 *)mask = PERF_REGS_MASK;
+
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
@@ -320,13 +323,11 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
+		*(u64 *)mask = PERF_REG_EXTENDED_MASK | PERF_REGS_MASK;
 	}
-
-	return PERF_REGS_MASK;
 }
 
-uint64_t arch__user_reg_mask(void)
+void arch__user_reg_mask(unsigned long *mask)
 {
-	return PERF_REGS_MASK;
+	*(uint64_t *)mask = PERF_REGS_MASK;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..6e71187d6a93 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1056,17 +1056,19 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
 			const char *arch = perf_env__arch(evsel__env(evsel));
+			uint64_t mask = 0;
 
+			arch__user_reg_mask((unsigned long *)&mask);
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-			    DWARF_MINIMAL_REGS(arch) != arch__user_reg_mask()) {
+			    DWARF_MINIMAL_REGS(arch) != mask) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS(arch);
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= arch__user_reg_mask();
+				attr->sample_regs_user |= mask;
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index cda1c620968e..3dcd8dc4f81b 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -16,7 +16,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 	const struct sample_reg *r = NULL;
 	char *s, *os = NULL, *p;
 	int ret = -1;
-	uint64_t mask;
+	uint64_t mask = 0;
 
 	if (unset)
 		return 0;
@@ -28,9 +28,9 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 		return -1;
 
 	if (intr)
-		mask = arch__intr_reg_mask();
+		arch__intr_reg_mask((unsigned long *)&mask);
 	else
-		mask = arch__user_reg_mask();
+		arch__user_reg_mask((unsigned long *)&mask);
 
 	/* str may be NULL in case no arg is passed to -I */
 	if (str) {
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 44b90bbf2d07..7a96290fd1e6 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -11,14 +11,14 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 	return SDT_ARG_SKIP;
 }
 
-uint64_t __weak arch__intr_reg_mask(void)
+void __weak arch__intr_reg_mask(unsigned long *mask)
 {
-	return 0;
+	*(uint64_t *)mask = 0;
 }
 
-uint64_t __weak arch__user_reg_mask(void)
+void __weak arch__user_reg_mask(unsigned long *mask)
 {
-	return 0;
+	*(uint64_t *)mask = 0;
 }
 
 static const struct sample_reg sample_reg_masks[] = {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index f2d0736d65cc..316d280e5cd7 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -24,8 +24,8 @@ enum {
 };
 
 int arch_sdt_arg_parse_op(char *old_op, char **new_op);
-uint64_t arch__intr_reg_mask(void);
-uint64_t arch__user_reg_mask(void);
+void arch__intr_reg_mask(unsigned long *mask);
+void arch__user_reg_mask(unsigned long *mask);
 const struct sample_reg *arch__sample_reg_masks(void);
 
 const char *perf_reg_name(int id, const char *arch);
-- 
2.40.1


