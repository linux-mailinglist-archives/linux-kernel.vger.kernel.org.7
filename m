Return-Path: <linux-kernel+bounces-691362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B6ADE3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E997A9094
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A7207A22;
	Wed, 18 Jun 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LEgBhpZt"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640E1EF39F;
	Wed, 18 Jun 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228628; cv=none; b=VNAciGINvIJqP+OWW03pgMQZwO+34b92NEpxqLuxyft9doZWRtk/dJ2tBmCclRdHvHzBeSPIwWf0MLtLYjlX94ybmo5vJwtxNPZClHVY3+z1FaD73Y6rYoQuqDos0Rx1i8lUxsM9EfuoiUMhzxBBHAoZSbMj3XlF+DpzVF+ge74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228628; c=relaxed/simple;
	bh=CeM3TrrTAoJ+FVlEhnI1qRxdC5khkvegE/M+otO9CYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tICoEvlP8hw0b/ucUlXlCaoYv1QdcLr5+E7NS6XOEraAnclVHLrSLOYX91ZnbHHVl276KL+sFrQ331BqfrlI+jO797Hiv5OWC8WGL7xTzEzlRLHG0iCQ509zhP6olTJte3o0OtLikU9t95Ifw2T+8QzHbuLgioKQMOW4dW4RiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LEgBhpZt; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1750228623; x=1781764623;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CeM3TrrTAoJ+FVlEhnI1qRxdC5khkvegE/M+otO9CYQ=;
  b=LEgBhpZtLMMWQzvbXPzD6pbFNZgdmvWJ7lroNUjIvLDkLPUXbfMzUVji
   xIT3+p+PLHOlH9OQ7i44M4vlReegWA2WLmbLtzwUxE1g8ps+C/L9/afNy
   eh7lmMaZcauw6iO0TcwPqps0Z1rIPX3vUQXI6z3IObQRVKg7Mw2bgz9tw
   W4HdSZn3r+6CTtZBtWsj8HOvL0Qnuv0D+owBt28CisPC7YCLv/Lt5h1FZ
   7S+sIVSyZLhmGa7cTqeZ5OHFHQ62FeWTeOveWLti/Gdlk0VLXUL0m3RaO
   6CtFdD/bBEEWlUE/BdwdlFXgJw/m/TPHuIALvZUCpDSyJGRBz5jCMqqSB
   Q==;
X-CSE-ConnectionGUID: 72MzON7SROmlBTeLvjNQ8Q==
X-CSE-MsgGUID: uYoInsg7T7qAb6qmZc+yhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="181998007"
X-IronPort-AV: E=Sophos;i="6.16,245,1744038000"; 
   d="scan'208";a="181998007"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:37:00 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 16075E8FE4;
	Wed, 18 Jun 2025 15:36:58 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B7C5CD8AC6;
	Wed, 18 Jun 2025 15:36:57 +0900 (JST)
Received: from sm-x86-amd03.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om2.fujitsu.com (Postfix) with ESMTP id B7D194005775F;
	Wed, 18 Jun 2025 15:36:56 +0900 (JST)
From: "Kotaro, Tokai" <fj0635gf@aa.jp.fujitsu.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kotaro, Tokai" <fj0635gf@aa.jp.fujitsu.com>
Subject: [PATCH] perf vendor events arm64: Update FUJITSU-MONAKA pmu event
Date: Wed, 18 Jun 2025 15:35:42 +0900
Message-ID: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update pmu events for FUJITSU-MONAKA.
And, also updated common-and-microarch.json.

FUJITSU-MONAKA PMU Events Specification v1.1 and Errata v1.0 URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Arm Architecture Reference Version L.b URL:
https://developer.arm.com/documentation/ddi0487/lb/?lang=en

Signed-off-by: Kotaro, Tokai <fj0635gf@aa.jp.fujitsu.com>
---
 .../arch/arm64/common-and-microarch.json      | 70 +++++++++++++
 .../arm64/fujitsu/monaka/core-imp-def.json    |  2 +-
 .../fujitsu/monaka/cycle_accounting.json      |  4 +-
 .../arch/arm64/fujitsu/monaka/exception.json  |  2 +-
 .../arm64/fujitsu/monaka/fp_operation.json    | 98 +++++++++++++++----
 .../arch/arm64/fujitsu/monaka/l1d_cache.json  | 10 +-
 .../arch/arm64/fujitsu/monaka/l1i_cache.json  |  8 +-
 .../arch/arm64/fujitsu/monaka/l2_cache.json   | 28 +++---
 .../arch/arm64/fujitsu/monaka/l3_cache.json   | 63 ++++++------
 .../arch/arm64/fujitsu/monaka/ll_cache.json   |  2 +-
 .../arch/arm64/fujitsu/monaka/pipeline.json   |  6 +-
 .../arm64/fujitsu/monaka/spec_operation.json  | 12 +--
 .../arch/arm64/fujitsu/monaka/stall.json      |  4 +-
 .../arch/arm64/fujitsu/monaka/sve.json        | 44 ++++-----
 .../arch/arm64/fujitsu/monaka/tlb.json        | 56 +++++------
 15 files changed, 265 insertions(+), 144 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index e40be37addf8..2416d9f8a83d 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -1833,5 +1833,75 @@
         "EventCode": "0x8324",
         "EventName": "L1I_CACHE_REFILL_PERCYC",
         "BriefDescription": "Level 1 instruction or unified cache refills in progress."
+    },
+    {
+        "EventCode": "0x8431",
+        "EventName": "ASE_FP_VREDUCE_SPEC",
+        "BriefDescription": "Floating-point operation_speculatively_executed, Advanced SIMD pairwise or reduction."
+    },
+    {
+        "EventCode": "0x8432",
+        "EventName": "SVE_FP_PREDUCE_SPEC",
+        "BriefDescription": "Floating-point operation_speculatively_executed, Advanced SIMD pairwise add step or pairwise reduce step."
+    },
+    {
+        "EventCode": "0x8443",
+        "EventName": "ASE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "Advanced SIMD data processing operation speculatively_executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x8444",
+        "EventName": "ASE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "Advanced SIMD data processing operation speculatively_executed, smallest type is 8-bit floating-point."
+    },
+    {
+        "EventCode": "0x844B",
+        "EventName": "ASE_SVE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "Advanced SIMD data processing or SVE data processing operation speculatively_executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x844C",
+        "EventName": "ASE_SVE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "Advanced SIMD data processing or SVE data processing operation speculatively_executed, smallest type is 8-bit floating-point."
+    },
+    {
+        "EventCode": "0x8463",
+        "EventName": "SVE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "SVE data processing operation speculatively_executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x8464",
+        "EventName": "SVE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "SVE data processing operation speculatively_executed, smallest type is 8-bit floating-point."
+    },
+    {
+        "EventCode": "0x8473",
+        "EventName": "FP_BF16_MIN_SPEC",
+        "BriefDescription": "Floating-point operation speculatively_executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x8474",
+        "EventName": "FP_FP8_MIN_SPEC",
+        "BriefDescription": "Floating-point operation speculatively_executed, smallest type is 8-bit floating-point."
+    },
+    {
+        "EventCode": "0x8483",
+        "EventName": "FP_BF16_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "Non-scalable element arithmetic operations speculatively executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x8484",
+        "EventName": "FP_FP8_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "Non-scalable element arithmetic operations speculatively executed, smallest type is 8-bit floating-point."
+    },
+    {
+        "EventCode": "0x848B",
+        "EventName": "FP_BF16_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "Scalable element arithmetic operations speculatively executed, smallest type is BFloat16 floating-point."
+    },
+    {
+        "EventCode": "0x848C",
+        "EventName": "FP_FP8_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "Scalable element arithmetic operations speculatively executed, smallest type is 8-bit floating-point."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
index 52f5ca1482fe..57a854ff5033 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
@@ -1,6 +1,6 @@
 [
     {
         "ArchStdEvent": "L1I_CACHE_PRF",
-        "BriefDescription": "This event counts fetch counted by either Level 1 instruction hardware prefetch or Level 1 instruction software prefetch."
+        "BriefDescription": "This event counts L1I_CACHE caused by hardware prefetch or software prefetch."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
index 24ff5d8dbb98..84374adbb0f8 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
@@ -12,12 +12,12 @@
     {
         "EventCode": "0x0184",
         "EventName": "LD_COMP_WAIT",
-        "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache and memory access."
+        "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache, L3 cache and memory access."
     },
     {
         "EventCode": "0x0185",
         "EventName": "LD_COMP_WAIT_EX",
-        "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache and memory access."
+        "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache, L3 cache and memory access."
     },
     {
         "EventCode": "0x0186",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
index f231712fe261..fba66bbcfeb5 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
@@ -33,7 +33,7 @@
     },
     {
         "ArchStdEvent": "EXC_SMC",
-        "BriefDescription": "This event counts only Secure Monitor Call exceptions. The counter does not increment on SMC instructions trapped as a Hyp Trap exception."
+        "BriefDescription": "This event counts only Secure Monitor Call exceptions. This event does not increment on SMC instructions trapped as a Hyp Trap exception."
     },
     {
         "ArchStdEvent": "EXC_HVC",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
index a3c368959199..2ffdc16530dd 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
@@ -2,7 +2,7 @@
     {
         "EventCode": "0x0105",
         "EventName": "FP_MV_SPEC",
-        "BriefDescription": "This event counts architecturally executed floating-point move operations."
+        "BriefDescription": "This event counts architecturally executed floating-point move operation."
     },
     {
         "EventCode": "0x0112",
@@ -24,7 +24,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point operation."
     },
     {
         "ArchStdEvent": "FP_HP_SPEC",
@@ -40,7 +40,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_HP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE half-precision floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE half-precision floating-point operation."
     },
     {
         "ArchStdEvent": "FP_SP_SPEC",
@@ -56,7 +56,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_SP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE single-precision floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE single-precision floating-point operation."
     },
     {
         "ArchStdEvent": "FP_DP_SPEC",
@@ -72,7 +72,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_DP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE double-precision floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE double-precision floating-point operation."
     },
     {
         "ArchStdEvent": "FP_DIV_SPEC",
@@ -88,7 +88,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_DIV_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point divide operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point divide operation."
     },
     {
         "ArchStdEvent": "FP_SQRT_SPEC",
@@ -104,7 +104,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_SQRT_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point square root operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point square root operation."
     },
     {
         "ArchStdEvent": "ASE_FP_FMA_SPEC",
@@ -116,11 +116,11 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_FMA_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point FMA operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point FMA operation."
     },
     {
         "ArchStdEvent": "FP_MUL_SPEC",
-        "BriefDescription": "This event counts architecturally executed floating-point multiply operations."
+        "BriefDescription": "This event counts architecturally executed floating-point multiply operation."
     },
     {
         "ArchStdEvent": "ASE_FP_MUL_SPEC",
@@ -132,11 +132,11 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_MUL_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point multiply operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point multiply operation."
     },
     {
         "ArchStdEvent": "FP_ADDSUB_SPEC",
-        "BriefDescription": "This event counts architecturally executed floating-point add or subtract operations."
+        "BriefDescription": "This event counts architecturally executed floating-point add or subtract operation."
     },
     {
         "ArchStdEvent": "ASE_FP_ADDSUB_SPEC",
@@ -148,19 +148,19 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_ADDSUB_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point add or subtract operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point add or subtract operation."
     },
     {
         "ArchStdEvent": "ASE_FP_RECPE_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD floating-point reciprocal estimate operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD floating-point reciprocal estimate operation."
     },
     {
         "ArchStdEvent": "SVE_FP_RECPE_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE floating-point reciprocal estimate operations."
+        "BriefDescription": "This event counts architecturally executed SVE floating-point reciprocal estimate operation."
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_RECPE_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point reciprocal estimate operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point reciprocal estimate operation."
     },
     {
         "ArchStdEvent": "ASE_FP_CVT_SPEC",
@@ -172,15 +172,15 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_CVT_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point convert operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point convert operation."
     },
     {
         "ArchStdEvent": "SVE_FP_AREDUCE_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE floating-point accumulating reduction operations."
+        "BriefDescription": "This event counts architecturally executed SVE floating-point accumulating reduction operation."
     },
     {
         "ArchStdEvent": "ASE_FP_PREDUCE_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD floating-point pairwise add step operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD floating-point pairwise add step operation."
     },
     {
         "ArchStdEvent": "SVE_FP_VREDUCE_SPEC",
@@ -188,15 +188,15 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_VREDUCE_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE floating-point vector reduction operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE floating-point vector reduction operation."
     },
     {
         "ArchStdEvent": "FP_SCALE_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE arithmetic operations. See FP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by (128 / CSIZE) and by twice that amount for operations that would also be counted by SVE_FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed SVE arithmetic operation. See FP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by (128 / CSIZE) and by twice that amount for operations that would also be counted by SVE_FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_FIXED_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed v8SIMD&FP arithmetic operations. See FP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. The event counter is incremented by the specified number of elements for Advanced SIMD operations or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed v8SIMD&FP arithmetic operation. See FP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by the specified number of elements for Advanced SIMD operations or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "ASE_SVE_FP_DOT_SPEC",
@@ -205,5 +205,61 @@
     {
         "ArchStdEvent": "ASE_SVE_FP_MMLA_SPEC",
         "BriefDescription": "This event counts architecturally executed microarchitectural Advanced SIMD or SVE floating-point matrix multiply operation."
+    },
+    {
+        "ArchStdEvent": "ASE_FP_VREDUCE_SPEC",
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD floating-point vector reduction operation."
+    },
+    {
+        "ArchStdEvent": "SVE_FP_PREDUCE_SPEC",
+        "BriefDescription": "This event counts architecturally executed SVE floating-point pairwise add step operation."
+    },
+    {
+        "ArchStdEvent": "ASE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD data processing operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "ASE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD data processing operations, smallest type is 8-bit floating-point."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD data processing or SVE data processing operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD data processing or SVE data processing operations, smallest type is 8-bit floating-point."
+    },
+    {
+        "ArchStdEvent": "SVE_FP_BF16_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed SVE data processing operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "SVE_FP_FP8_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed SVE data processing operations, smallest type is 8-bit floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_BF16_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed data processing operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_FP8_MIN_SPEC",
+        "BriefDescription": "This event counts architecturally executed data processing operations, smallest type is 8-bit floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_BF16_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "This event counts architecturally executed non-scalable element arithmetic operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_FP8_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "This event counts architecturally executed non-scalable element arithmetic operations, smallest type is 8-bit floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_BF16_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "This event counts architecturally executed scalable element arithmetic operations, smallest type is BFloat16 floating-point."
+    },
+    {
+        "ArchStdEvent": "FP_FP8_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "This event counts architecturally executed scalable element arithmetic operations, smallest type is 8-bit floating-point."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
index b0818a2fedb0..a2ff3b49ac0d 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
@@ -72,11 +72,11 @@
     },
     {
         "ArchStdEvent": "L1D_CACHE_HWPRF",
-        "BriefDescription": "This event counts access counted by L1D_CACHE that is due to a hardware prefetch."
+        "BriefDescription": "This event counts L1D_CACHE caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L1D_CACHE_HWPRF that causes a refill of the Level 1 data cache from outside of the Level 1 data cache."
+        "BriefDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L1D_CACHE_HIT_RD",
@@ -100,14 +100,14 @@
     },
     {
         "ArchStdEvent": "L1D_CACHE_PRF",
-        "BriefDescription": "This event counts fetch counted by either Level 1 data hardware prefetch or Level 1 data software prefetch."
+        "BriefDescription": "This event counts L1D_CACHE caused by hardware prefetch or software prefetch."
     },
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_PRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L1D_CACHE_PRF that causes a refill of the Level 1 data cache from outside of the Level 1 data cache."
+        "BriefDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch or software prefetch."
     },
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_PERCYC",
-        "BriefDescription": "The counter counts by the number of cache refills counted by L1D_CACHE_REFILL in progress on each Processor cycle."
+        "BriefDescription": "This counter counts by the number of cache refills counted by L1D_CACHE_REFILL in progress on each Processor cycle."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
index 8680d8ec461d..5250af8631c0 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
@@ -23,11 +23,11 @@
     },
     {
         "ArchStdEvent": "L1I_CACHE_HWPRF",
-        "BriefDescription": "This event counts access counted by L1I_CACHE that is due to a hardware prefetch."
+        "BriefDescription": "This event counts L1I_CACHE caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L1I_CACHE_REFILL_HWPRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L1I_CACHE_HWPRF that causes a refill of the Level 1 instruction cache from outside of the Level 1 instruction cache."
+        "BriefDescription": "This event counts L1I_CACHE_REFILL caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L1I_CACHE_HIT_RD",
@@ -43,10 +43,10 @@
     },
     {
         "ArchStdEvent": "L1I_CACHE_REFILL_PRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L1I_CACHE_PRF that causes a refill of the Level 1 instruction cache from outside of the Level 1 instruction cache."
+        "BriefDescription": "This event counts L1I_CACHE_REFILL caused by hardware prefetch or software prefetch."
     },
     {
         "ArchStdEvent": "L1I_CACHE_REFILL_PERCYC",
-        "BriefDescription": "The counter counts by the number of cache refills counted by L1I_CACHE_REFILL in progress on each Processor cycle."
+        "BriefDescription": "This counter counts by the number of cache refills counted by L1I_CACHE_REFILL in progress on each Processor cycle."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
index 9e092752e6db..67f9151d7685 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
@@ -21,19 +21,19 @@
     },
     {
         "ArchStdEvent": "L2D_CACHE_RD",
-        "BriefDescription": "This event counts L2D CACHE caused by read access."
+        "BriefDescription": "This event counts L2D_CACHE caused by read access."
     },
     {
         "ArchStdEvent": "L2D_CACHE_WR",
-        "BriefDescription": "This event counts L2D CACHE caused by write access."
+        "BriefDescription": "This event counts L2D_CACHE caused by write access."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_RD",
-        "BriefDescription": "This event counts L2D CACHE_REFILL caused by read access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by read access."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_WR",
-        "BriefDescription": "This event counts L2D CACHE_REFILL caused by write access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by write access."
     },
     {
         "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
@@ -57,7 +57,7 @@
     {
         "EventCode": "0x0305",
         "EventName": "L2D_CACHE_HWPRF_ADJACENT",
-        "BriefDescription": "This event counts L2D_CACHE caused by hardware adjacent prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE caused by hardware adjacent prefetch."
     },
     {
         "EventCode": "0x0308",
@@ -111,7 +111,7 @@
     },
     {
         "ArchStdEvent": "L2D_CACHE_LMISS_RD",
-        "BriefDescription": "This event counts operations that cause a refill of the L2D cache that incurs additional latency."
+        "BriefDescription": "This event counts operations that cause a refill of the L2 cache that incurs additional latency."
     },
     {
         "ArchStdEvent": "L2D_CACHE_MISS",
@@ -119,23 +119,23 @@
     },
     {
         "ArchStdEvent": "L2D_CACHE_HWPRF",
-        "BriefDescription": "This event counts access counted by L2D_CACHE that is due to a hardware prefetch."
+        "BriefDescription": "This event counts L2D_CACHE caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_HWPRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L2D_CACHE_HWPRF that causes a refill of the Level 2 cache, or any Level 1 data and instruction cache of this PE, from outside of those caches."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch."
     },
     {
         "ArchStdEvent": "L2D_CACHE_HIT_RD",
-        "BriefDescription": "This event counts demand read counted by L2D_CACHE_RD that hits in the Level 2 data cache."
+        "BriefDescription": "This event counts demand read counted by L2D_CACHE_RD that hits in the Level 2 cache."
     },
     {
         "ArchStdEvent": "L2D_CACHE_HIT_WR",
-        "BriefDescription": "This event counts demand write counted by L2D_CACHE_WR that hits in the Level 2 data cache."
+        "BriefDescription": "This event counts demand write counted by L2D_CACHE_WR that hits in the Level 2 cache."
     },
     {
         "ArchStdEvent": "L2D_CACHE_HIT",
-        "BriefDescription": "This event counts access counted by L2D_CACHE that hits in the Level 2 data cache."
+        "BriefDescription": "This event counts access counted by L2D_CACHE that hits in the Level 2 cache."
     },
     {
         "ArchStdEvent": "L2D_LFB_HIT_RD",
@@ -147,14 +147,14 @@
     },
     {
         "ArchStdEvent": "L2D_CACHE_PRF",
-        "BriefDescription": "This event counts fetch counted by either Level 2 data hardware prefetch or Level 2 data software prefetch."
+        "BriefDescription": "This event counts L2D_CACHE caused by hardware prefetch or software prefetch."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_PRF",
-        "BriefDescription": "This event counts hardware prefetch counted by L2D_CACHE_PRF that causes a refill of the Level 2 data cache from outside of the Level 1 data cache."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch or software prefetch."
     },
     {
         "ArchStdEvent": "L2D_CACHE_REFILL_PERCYC",
-        "BriefDescription": "The counter counts by the number of cache refills counted by L2D_CACHE_REFILL in progress on each Processor cycle."
+        "BriefDescription": "This counter counts by the number of cache refills counted by L2D_CACHE_REFILL in progress on each Processor cycle."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
index 3f3e0d22ac68..cf49c4d452b7 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
@@ -30,17 +30,17 @@
     {
         "EventCode": "0x0394",
         "EventName": "L2D_CACHE_REFILL_L3D_CACHE_PRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch or software prefetch."
     },
     {
         "EventCode": "0x0395",
         "EventName": "L2D_CACHE_REFILL_L3D_CACHE_HWPRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch."
     },
     {
         "EventCode": "0x0396",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS",
-        "BriefDescription": "This event counts operations that cause a miss of the L3 cache."
+        "BriefDescription": "This event counts operations that cause a miss of the L3 cache. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x0397",
@@ -60,17 +60,17 @@
     {
         "EventCode": "0x039A",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_PRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch or software prefetch. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x039B",
         "EventName": "L2D_CACHE_REFILL_L3D_MISS_HWPRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x039C",
         "EventName": "L2D_CACHE_REFILL_L3D_HIT",
-        "BriefDescription": "This event counts operations that cause a hit of the L3 cache."
+        "BriefDescription": "This event counts operations that cause a hit of the L3 cache. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x039D",
@@ -90,70 +90,65 @@
     {
         "EventCode": "0x03A0",
         "EventName": "L2D_CACHE_REFILL_L3D_HIT_PRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by prefetch access."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by hardware prefetch or software prefetch. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x03A1",
         "EventName": "L2D_CACHE_REFILL_L3D_HIT_HWPRF",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by hardware prefetch access."
-    },
-    {
-        "EventCode": "0x03A2",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests hit the PFTGT buffer."
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by hardware prefetch. Note: This event may count inaccurately."
     },
     {
         "EventCode": "0x03A3",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand access."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_PFTGT_HIT",
+        "BriefDescription": "This event counts the number of L3 cache misses caused by demand access where the requests hit the PFTGT buffer."
     },
     {
         "EventCode": "0x03A4",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM_RD",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand read access."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_RD_PFTGT_HIT",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM_PFTGT_HIT caused by read access."
     },
     {
         "EventCode": "0x03A5",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM_WR",
-        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand write access."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_WR_PFTGT_HIT",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM_PFTGT_HIT caused by write access."
     },
     {
         "EventCode": "0x03A6",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_L_MEM",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access the memory in the same socket as the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_L_MEM",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access the memory in the same socket as the requests."
     },
     {
         "EventCode": "0x03A7",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_MEM",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access the memory in the different socket from the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_FR_MEM",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access the memory in the different socket from the requests."
     },
     {
         "EventCode": "0x03A8",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_L_L2",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access the different L2 cache from the requests in the same Numa nodes as the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_L_L2",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access the different L2 cache from the requests in the same Numa nodes as the requests."
     },
     {
         "EventCode": "0x03A9",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_NR_L2",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access L2 cache in the different Numa nodes from the requests in the same socket as the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_NR_L2",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access L2 cache in the different Numa nodes from the requests in the same socket as the requests."
     },
     {
         "EventCode": "0x03AA",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_NR_L3",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access L3 cache in the different Numa nodes from the requests in the same socket as the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_NR_L3",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access L3 cache in the different Numa nodes from the requests in the same socket as the requests."
     },
     {
         "EventCode": "0x03AB",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L2",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access L2 cache in the different socket from the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_FR_L2",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access L2 cache in the different socket from the requests."
     },
     {
         "EventCode": "0x03AC",
-        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L3",
-        "BriefDescription": "This event counts the number of L3 cache misses where the requests access L3 cache in the different socket from the requests."
+        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_FR_L3",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS_DM where the requests access L3 cache in the different socket from the requests."
     },
     {
         "ArchStdEvent": "L3D_CACHE_LMISS_RD",
-        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and  a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
+        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3 cache, and a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events. Note: This event may count inaccurately."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
index a441b84729ab..d49d9f6df72c 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
@@ -5,6 +5,6 @@
     },
     {
         "ArchStdEvent": "LL_CACHE_MISS_RD",
-        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
+        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3 cache, and a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events. Note: This event may count inaccurately."
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
index 3cc3105f4a5e..15cf54730b85 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
@@ -147,17 +147,17 @@
     {
         "EventCode": "0x02B0",
         "EventName": "L1_PIPE_COMP_GATHER_2FLOW",
-        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 2 flows because 2 elements could not be combined."
+        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 2-flows because 2 elements could not be combined."
     },
     {
         "EventCode": "0x02B1",
         "EventName": "L1_PIPE_COMP_GATHER_1FLOW",
-        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 1 flow because 2 elements could be combined."
+        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 1-flow because 2 elements could be combined."
     },
     {
         "EventCode": "0x02B2",
         "EventName": "L1_PIPE_COMP_GATHER_0FLOW",
-        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 0 flow because both predicate values are 0."
+        "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 0-flow because both predicate values are 0."
     },
     {
         "EventCode": "0x02B3",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
index 4841b43e2871..1caf3baeae4e 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
@@ -81,7 +81,7 @@
     },
     {
         "ArchStdEvent": "CSDB_SPEC",
-        "BriefDescription": "This event counts speculatively executed control speculation barrier instructions."
+        "BriefDescription": "This event counts architecturally executed control speculation barrier instructions."
     },
     {
         "EventCode": "0x0108",
@@ -91,17 +91,17 @@
     {
         "EventCode": "0x0109",
         "EventName": "IEL_SPEC",
-        "BriefDescription": "This event counts architecturally executed inter-element manipulation operations."
+        "BriefDescription": "This event counts architecturally executed inter-element manipulation operation."
     },
     {
         "EventCode": "0x010A",
         "EventName": "IREG_SPEC",
-        "BriefDescription": "This event counts architecturally executed inter-register manipulation operations."
+        "BriefDescription": "This event counts architecturally executed inter-register manipulation operation."
     },
     {
         "EventCode": "0x011A",
         "EventName": "BC_LD_SPEC",
-        "BriefDescription": "This event counts architecturally executed SIMD broadcast floating-point load operations."
+        "BriefDescription": "This event counts architecturally executed SIMD broadcast floating-point load operation."
     },
     {
         "EventCode": "0x011B",
@@ -130,7 +130,7 @@
     },
     {
         "ArchStdEvent": "ASE_INST_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD operation."
     },
     {
         "ArchStdEvent": "INT_SPEC",
@@ -158,7 +158,7 @@
     },
     {
         "ArchStdEvent": "NONFP_SPEC",
-        "BriefDescription": "This event counts architecturally executed non-floating-point operations."
+        "BriefDescription": "This event counts architecturally executed non-floating-point operation."
     },
     {
         "ArchStdEvent": "INT_SCALE_OPS_SPEC",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
index 5fb81e2a0a07..e1e16d513828 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
@@ -5,7 +5,7 @@
     },
     {
         "ArchStdEvent": "STALL_BACKEND",
-        "BriefDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because the backend is unable to accept any operations."
+        "BriefDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because the backend is unable to accept any operation."
     },
     {
         "ArchStdEvent": "STALL",
@@ -69,7 +69,7 @@
     },
     {
         "ArchStdEvent": "STALL_BACKEND_L2D",
-        "BriefDescription": "This event counts every cycle counted by STALL_BACKEND_MEMBOUND when there is a demand data miss in L2D cache."
+        "BriefDescription": "This event counts every cycle counted by STALL_BACKEND_MEMBOUND when there is a demand data miss in L2 cache."
     },
     {
         "ArchStdEvent": "STALL_BACKEND_CPUBOUND",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
index e66b5af00f90..88cab0caf49e 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
@@ -13,11 +13,11 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_INST_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE operation."
     },
     {
         "ArchStdEvent": "UOP_SPEC",
-        "BriefDescription": "This event counts all architecturally executed micro-operations."
+        "BriefDescription": "This event counts all architecturally executed micro-operation."
     },
     {
         "ArchStdEvent": "SVE_MATH_SPEC",
@@ -29,7 +29,7 @@
     },
     {
         "ArchStdEvent": "FP_FMA_SPEC",
-        "BriefDescription": "This event counts architecturally executed floating-point fused multiply-add and multiply-subtract operations."
+        "BriefDescription": "This event counts architecturally executed floating-point fused multiply-add and multiply-subtract operation."
     },
     {
         "ArchStdEvent": "FP_RECPE_SPEC",
@@ -41,15 +41,15 @@
     },
     {
         "ArchStdEvent": "ASE_INT_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD integer operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD integer operation."
     },
     {
         "ArchStdEvent": "SVE_INT_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE integer operations."
+        "BriefDescription": "This event counts architecturally executed SVE integer operation."
     },
     {
         "ArchStdEvent": "ASE_SVE_INT_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE integer operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE integer operation."
     },
     {
         "ArchStdEvent": "SVE_INT_DIV_SPEC",
@@ -69,7 +69,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_INT_MUL_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE integer multiply operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE integer multiply operation."
     },
     {
         "ArchStdEvent": "SVE_INT_MUL64_SPEC",
@@ -77,19 +77,19 @@
     },
     {
         "ArchStdEvent": "SVE_INT_MULH64_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE integer 64-bit x 64-bit multiply returning high part operations."
+        "BriefDescription": "This event counts architecturally executed SVE integer 64-bit x 64-bit multiply returning high part operation."
     },
     {
         "ArchStdEvent": "ASE_NONFP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD non-floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD non-floating-point operation."
     },
     {
         "ArchStdEvent": "SVE_NONFP_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE non-floating-point operations."
+        "BriefDescription": "This event counts architecturally executed SVE non-floating-point operation."
     },
     {
         "ArchStdEvent": "ASE_SVE_NONFP_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE non-floating-point operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE non-floating-point operation."
     },
     {
         "ArchStdEvent": "ASE_INT_VREDUCE_SPEC",
@@ -101,7 +101,7 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_INT_VREDUCE_SPEC",
-        "BriefDescription": "This event counts architecturally executed Advanced SIMD and SVE integer reduction operations."
+        "BriefDescription": "This event counts architecturally executed Advanced SIMD or SVE integer reduction operation."
     },
     {
         "ArchStdEvent": "SVE_PERM_SPEC",
@@ -149,11 +149,11 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_LD_SPEC",
-        "BriefDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD load instructions."
+        "BriefDescription": "This event counts architecturally executed operations that read from memory due to Advanced SIMD or SVE load instructions."
     },
     {
         "ArchStdEvent": "ASE_SVE_ST_SPEC",
-        "BriefDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD store instructions."
+        "BriefDescription": "This event counts architecturally executed operations that write to memory due to Advanced SIMD or SVE store instructions."
     },
     {
         "ArchStdEvent": "PRF_SPEC",
@@ -197,11 +197,11 @@
     },
     {
         "ArchStdEvent": "ASE_SVE_LD_MULTI_SPEC",
-        "BriefDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD multiple vector contiguous structure load instructions."
+        "BriefDescription": "This event counts architecturally executed operations that read from memory due to Advanced SIMD or SVE multiple vector contiguous structure load instructions."
     },
     {
         "ArchStdEvent": "ASE_SVE_ST_MULTI_SPEC",
-        "BriefDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD multiple vector contiguous structure store instructions."
+        "BriefDescription": "This event counts architecturally executed operations that write to memory due to Advanced SIMD or SVE multiple vector contiguous structure store instructions."
     },
     {
         "ArchStdEvent": "SVE_LD_GATHER_SPEC",
@@ -221,27 +221,27 @@
     },
     {
         "ArchStdEvent": "FP_HP_SCALE_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE half-precision arithmetic operations. See FP_HP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 8, or by 16 for operations that would also be counted by SVE_FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed SVE half-precision arithmetic operation. See FP_HP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 8, or by 16 for operations that would also be counted by SVE_FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_HP_FIXED_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed v8SIMD&FP half-precision arithmetic operations. See FP_HP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by the number of 16-bit elements for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed v8SIMD&FP half-precision arithmetic operation. See FP_HP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by the number of 16-bit elements for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_SP_SCALE_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE single-precision arithmetic operations. See FP_SP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 4, or by 8 for operations that would also be counted by SVE_FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed SVE single-precision arithmetic operation. See FP_SP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 4, or by 8 for operations that would also be counted by SVE_FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_SP_FIXED_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed v8SIMD&FP single-precision arithmetic operations. See FP_SP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by the number of 32-bit elements for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed v8SIMD&FP single-precision arithmetic operation. See FP_SP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by the number of 32-bit elements for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_DP_SCALE_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed SVE double-precision arithmetic operations. See FP_DP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 2, or by 4 for operations that would also be counted by SVE_FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed SVE double-precision arithmetic operation. See FP_DP_SCALE_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 2, or by 4 for operations that would also be counted by SVE_FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "FP_DP_FIXED_OPS_SPEC",
-        "BriefDescription": "This event counts architecturally executed v8SIMD&FP double-precision arithmetic operations. See FP_DP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 2 for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
+        "BriefDescription": "This event counts architecturally executed v8SIMD&FP double-precision arithmetic operation. See FP_DP_FIXED_OPS_SPEC of ARMv9 Reference Manual for more information. This event counter is incremented by 2 for Advanced SIMD operations, or by 1 for scalar operations, and by twice those amounts for operations that would also be counted by FP_FMA_SPEC."
     },
     {
         "ArchStdEvent": "ASE_SVE_INT_DOT_SPEC",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
index edc7cb8696c8..f54029ba369a 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
@@ -104,72 +104,72 @@
     {
         "EventCode": "0x0C10",
         "EventName": "L1I_TLB_REFILL_4K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 4KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 4KB page."
     },
     {
         "EventCode": "0x0C11",
         "EventName": "L1I_TLB_REFILL_64K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 64KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 64KB page."
     },
     {
         "EventCode": "0x0C12",
         "EventName": "L1I_TLB_REFILL_2M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 2MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 2MB page."
     },
     {
         "EventCode": "0x0C13",
         "EventName": "L1I_TLB_REFILL_32M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 32MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 32MB page."
     },
     {
         "EventCode": "0x0C14",
         "EventName": "L1I_TLB_REFILL_512M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 512MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 512MB page."
     },
     {
         "EventCode": "0x0C15",
         "EventName": "L1I_TLB_REFILL_1G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 1GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 1GB page."
     },
     {
         "EventCode": "0x0C16",
         "EventName": "L1I_TLB_REFILL_16G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1I in 16GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1I in 16GB page."
     },
     {
         "EventCode": "0x0C18",
         "EventName": "L1D_TLB_REFILL_4K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 4KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 4KB page."
     },
     {
         "EventCode": "0x0C19",
         "EventName": "L1D_TLB_REFILL_64K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 64KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 64KB page."
     },
     {
         "EventCode": "0x0C1A",
         "EventName": "L1D_TLB_REFILL_2M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 2MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 2MB page."
     },
     {
         "EventCode": "0x0C1B",
         "EventName": "L1D_TLB_REFILL_32M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 32MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 32MB page."
     },
     {
         "EventCode": "0x0C1C",
         "EventName": "L1D_TLB_REFILL_512M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 512MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 512MB page."
     },
     {
         "EventCode": "0x0C1D",
         "EventName": "L1D_TLB_REFILL_1G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 1GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 1GB page."
     },
     {
         "EventCode": "0x0C1E",
         "EventName": "L1D_TLB_REFILL_16G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L1D in 16GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L1D in 16GB page."
     },
     {
         "EventCode": "0x0C20",
@@ -244,72 +244,72 @@
     {
         "EventCode": "0x0C30",
         "EventName": "L2I_TLB_REFILL_4K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2Iin 4KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 4KB page."
     },
     {
         "EventCode": "0x0C31",
         "EventName": "L2I_TLB_REFILL_64K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 64KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 64KB page."
     },
     {
         "EventCode": "0x0C32",
         "EventName": "L2I_TLB_REFILL_2M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 2MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 2MB page."
     },
     {
         "EventCode": "0x0C33",
         "EventName": "L2I_TLB_REFILL_32M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 32MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 32MB page."
     },
     {
         "EventCode": "0x0C34",
         "EventName": "L2I_TLB_REFILL_512M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 512MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 512MB page."
     },
     {
         "EventCode": "0x0C35",
         "EventName": "L2I_TLB_REFILL_1G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 1GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 1GB page."
     },
     {
         "EventCode": "0x0C36",
         "EventName": "L2I_TLB_REFILL_16G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2I in 16GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2I in 16GB page."
     },
     {
         "EventCode": "0x0C38",
         "EventName": "L2D_TLB_REFILL_4K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 4KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 4KB page."
     },
     {
         "EventCode": "0x0C39",
         "EventName": "L2D_TLB_REFILL_64K",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 64KB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 64KB page."
     },
     {
         "EventCode": "0x0C3A",
         "EventName": "L2D_TLB_REFILL_2M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 2MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 2MB page."
     },
     {
         "EventCode": "0x0C3B",
         "EventName": "L2D_TLB_REFILL_32M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 32MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 32MB page."
     },
     {
         "EventCode": "0x0C3C",
         "EventName": "L2D_TLB_REFILL_512M",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 512MB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 512MB page."
     },
     {
         "EventCode": "0x0C3D",
         "EventName": "L2D_TLB_REFILL_1G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 1GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 1GB page."
     },
     {
         "EventCode": "0x0C3E",
         "EventName": "L2D_TLB_REFILL_16G",
-        "BriefDescription": "This event counts operations that cause a TLB refill to the L2D in 16GB page."
+        "BriefDescription": "This event counts operations that cause a TLB refill of the L2D in 16GB page."
     },
     {
         "ArchStdEvent": "DTLB_WALK_PERCYC",
-- 
2.43.5


