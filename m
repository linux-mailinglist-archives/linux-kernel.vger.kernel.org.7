Return-Path: <linux-kernel+bounces-771469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5BB287B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD01AE2FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858F25EFBB;
	Fri, 15 Aug 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy7DAKnM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEC20F079
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293747; cv=none; b=aWeJfNa4H0Xbt/EodVA8wJemAPVy74QsMhIwo973StcWOqI5zDRUyzcTA9siRbN4n67NiUJilzoq7nzHkHJmT7ThVTuvvaHc8VccWLiqCkjWdJ8P6ozyr22RHi6CQ70pN1oxsmR7cXPAarpaqyNDalfmXhM8tfZLRQtJhr8MulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293747; c=relaxed/simple;
	bh=DZkFc7LowHGQZvAVov+4zqtvAvQlPy/rbDTbYOSVbPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaDpGNJgfZ8wLddBLX82sY0XYWg64MnpN+N+7W+xklmpYWlWmjt8nUf2QhDyineZYilrMKbj5x8xDog+K4kv1U4xkMO9XS+e/J8ViPNTm0hPEzhyjOGqth6rDiaYN8fOaamL4iHf0iVTouIt4Sa4u15C5giZLvF7R++Tu6Q3MSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jy7DAKnM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293746; x=1786829746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DZkFc7LowHGQZvAVov+4zqtvAvQlPy/rbDTbYOSVbPo=;
  b=jy7DAKnMhQ18rkO/N4QjCjurgYjo5Gf98vvBLl8fjnXJGkRQoYMWrWZ7
   iTelQhFGz9tzHttO9rD0r13+AJ+X/bdaZpfrk6cU8+MiYAkhvNAV5pltE
   yjxA+CD7wU01do3WnZBOl9IljDWHlJppZnQt86omH3b/F0fYJ71HOMBtb
   48DrdChrzrkfsXfr+bTxDcgH58sDGvm+tRS8yEH6nZfUdB+UCAAwyItBZ
   uiO9eiqSZlWZIaHXUdynnjlsAFYajpkM/SsVMmkTJDo/YQLuZpnCiqSdb
   wSnZEzfm0XhORGg7yHz3DYIxbgmz2PyzkkJzvtSsYkzvC3CMWfzcFFcKQ
   g==;
X-CSE-ConnectionGUID: UF3L5bHIRWG/pfWIYDT3/w==
X-CSE-MsgGUID: s7Onpyc1S9KhRsRKtziqzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707354"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707354"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:45 -0700
X-CSE-ConnectionGUID: ofuBsn7NSG2mG4Erl1wHKA==
X-CSE-MsgGUID: VaMqQY0gRWeBglCaQUHGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319573"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:45 -0700
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
Subject: [PATCH V3 00/17] Support vector and more extended registers in perf
Date: Fri, 15 Aug 2025 14:34:18 -0700
Message-Id: <20250815213435.1702022-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Use the FPU format for the x86_pmu.ext_regs_mask as well
- Add a check before invoking xsaves_nmi()
- Add perf_simd_reg_check() to retrieve the number of available
  registers. If the kernel fails to get the requested registers, e.g.,
  XSAVES fails, nothing dumps to the userspace (the V2 dumps all 0s).
- Add POC perf tool patches

Changes since V1:
- Apply the new interfaces to configure and dump the SIMD registers
- Utilize the existing FPU functions, e.g., xstate_calculate_size,
  get_xsave_addr().

Starting from the Intel Ice Lake, the XMM registers can be collected in
a PEBS record. More registers, e.g., YMM, ZMM, OPMASK, SPP and APX, will
be added in the upcoming Architecture PEBS as well. But it requires the
hardware support.

The patch set provides a software solution to mitigate the hardware
requirement. It utilizes the XSAVES command to retrieve the requested
registers in the overflow handler. The feature isn't limited to the PEBS
event or specific platforms anymore.
The hardware solution (if available) is still preferred, since it has
low overhead (especially with the large PEBS) and is more accurate.

In theory, the solution should work for all X86 platforms. But I only
have newer Inter platforms to test. The patch set only enable the
feature for Intel Ice Lake and later platforms.

The new registers include YMM, ZMM, OPMASK, SSP, and APX.
The sample_regs_user/intr has run out. A new field in the
struct perf_event_attr is required for the registers.

After a long discussion in V1,
https://lore.kernel.org/lkml/3f1c9a9e-cb63-47ff-a5e9-06555fa6cc9a@linux.intel.com/

The new field looks like as below.
@@ -543,6 +545,25 @@ struct perf_event_attr {
        __u64   sig_data;

        __u64   config3; /* extension of config2 */
+
+
+       /*
+        * Defines set of SIMD registers to dump on samples.
+        * The sample_simd_regs_enabled !=0 implies the
+        * set of SIMD registers is used to config all SIMD registers.
+        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
+        * config some SIMD registers on X86.
+        */
+       union {
+               __u16 sample_simd_regs_enabled;
+               __u16 sample_simd_pred_reg_qwords;
+       };
+       __u32 sample_simd_pred_reg_intr;
+       __u32 sample_simd_pred_reg_user;
+       __u16 sample_simd_vec_reg_qwords;
+       __u64 sample_simd_vec_reg_intr;
+       __u64 sample_simd_vec_reg_user;
+       __u32 __reserved_4;
 };
@@ -1016,7 +1037,15 @@ enum perf_event_type {
         *      } && PERF_SAMPLE_BRANCH_STACK
         *
         *      { u64                   abi; # enum perf_sample_regs_abi
-        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+        *        u64                   regs[weight(mask)];
+        *        struct {
+        *              u16 nr_vectors;
+        *              u16 vector_qwords;
+        *              u16 nr_pred;
+        *              u16 pred_qwords;
+        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+        *      } && PERF_SAMPLE_REGS_USER
         *
         *      { u64                   size;
         *        char                  data[size];
@@ -1043,7 +1072,15 @@ enum perf_event_type {
         *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
         *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
         *      { u64                   abi; # enum perf_sample_regs_abi
-        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+        *        u64                   regs[weight(mask)];
+        *        struct {
+        *              u16 nr_vectors;
+        *              u16 vector_qwords;
+        *              u16 nr_pred;
+        *              u16 pred_qwords;
+        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+        *      } && PERF_SAMPLE_REGS_INTR
         *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
         *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
         *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE


Since there is only one vector qwords field, the qwords for the newest
vector should be set by the tools. For example, if the end user wants
XMM0 and YMM1, the vector qwords should be 4. The vector mask should be
0x3. The YMM0 and YMM1 will be dumped to the userspace. It's the tool's
responsibility to output the XMM0 and YMM1 to the end user.

The POC perf tool patches for testing purposes is also attached.

Examples:
 $perf record -I?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

 $perf record --user-regs=?
 available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
 R11 R12 R13 R14 R15 SSP XMM0-31 YMM0-31 ZMM0-31 OPMASK0-7

 $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
 $perf report -D
 ... ...
 237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
 179370/179370: 0xffffffff969627fc period: 124999 addr: 0
 ... intr regs: mask 0x20000000000 ABI 64-bit
 .... SSP   0x0000000000000000
 ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
 .... YMM  [0] 0x0000000000004000
 .... YMM  [0] 0x000055e828695270
 .... YMM  [0] 0x0000000000000000
 .... YMM  [0] 0x0000000000000000
 .... YMM  [1] 0x000055e8286990e0
 .... YMM  [1] 0x000055e828698dd0
 .... YMM  [1] 0x0000000000000000
 .... YMM  [1] 0x0000000000000000
 ... ...
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... OPMASK[0] 0x0000000000100221
 .... OPMASK[1] 0x0000000000000020
 .... OPMASK[2] 0x000000007fffffff
 .... OPMASK[3] 0x0000000000000000
 .... OPMASK[4] 0x0000000000000000
 .... OPMASK[5] 0x0000000000000000
 .... OPMASK[6] 0x0000000000000000
 .... OPMASK[7] 0x0000000000000000
 ... ...

Kan Liang (17):
  perf/x86: Use x86_perf_regs in the x86 nmi handler
  perf/x86: Setup the regs data
  x86/fpu/xstate: Add xsaves_nmi
  perf: Move has_extended_regs() to header file
  perf/x86: Support XMM register for non-PEBS and REGS_USER
  perf: Support SIMD registers
  perf/x86: Move XMM to sample_simd_vec_regs
  perf/x86: Add YMM into sample_simd_vec_regs
  perf/x86: Add ZMM into sample_simd_vec_regs
  perf/x86: Add OPMASK into sample_simd_pred_reg
  perf/x86: Add eGPRs into sample_regs
  perf/x86: Add SSP into sample_regs
  perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
  perf/x86/regs: Only support legacy regs for the PT and PERF_REGS_MASK
    for now
  tools headers: Sync with the kernel sources
  perf parse-regs: Support the new SIMD format
  perf regs: Support the PERF_SAMPLE_REGS_ABI_SIMD

 arch/x86/events/core.c                        | 268 +++++++++++++++++-
 arch/x86/events/intel/core.c                  |  73 ++++-
 arch/x86/events/intel/ds.c                    |  12 +-
 arch/x86/events/perf_event.h                  |  23 ++
 arch/x86/include/asm/fpu/xstate.h             |   3 +
 arch/x86/include/asm/perf_event.h             |  30 +-
 arch/x86/include/uapi/asm/perf_regs.h         |  44 ++-
 arch/x86/kernel/fpu/xstate.c                  |  32 ++-
 arch/x86/kernel/perf_regs.c                   | 127 ++++++++-
 include/linux/perf_event.h                    |  21 ++
 include/linux/perf_regs.h                     |   9 +
 include/uapi/linux/perf_event.h               |  47 ++-
 kernel/events/core.c                          | 109 ++++++-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  44 ++-
 tools/include/uapi/linux/perf_event.h         |  47 ++-
 tools/perf/arch/x86/include/perf_regs.h       |   2 +-
 tools/perf/arch/x86/util/perf_regs.c          | 257 ++++++++++++++++-
 tools/perf/util/evsel.c                       |  41 +++
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/parse-regs-options.c          |  60 +++-
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  45 +++
 tools/perf/util/perf_event_attr_fprintf.c     |   6 +
 tools/perf/util/perf_regs.c                   |  29 ++
 tools/perf/util/perf_regs.h                   |  13 +-
 tools/perf/util/record.h                      |   6 +
 tools/perf/util/sample.h                      |  10 +
 tools/perf/util/session.c                     |  62 +++-
 27 files changed, 1339 insertions(+), 83 deletions(-)

-- 
2.38.1


