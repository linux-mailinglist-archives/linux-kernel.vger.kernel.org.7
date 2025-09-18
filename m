Return-Path: <linux-kernel+bounces-801557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5789B4469E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E42B16A83B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7F275B1F;
	Thu,  4 Sep 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZArS1Zwf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47F270548
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014908; cv=none; b=aoJTPbigK/4N4owMIOf6p61dCgdZ128ljv+q+fSY7PgHUsiNJqZhgo11xQ4LwTmNY21qIXzX6fEJDbrpJc0r5WYlNxntBB5uUFWJi6zFi30E2+O3IuNVpR5hbfuWZJchk54ysWTxRl4mTai/gOfRGXGCxi+wcEWWmSFYTghxhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014908; c=relaxed/simple;
	bh=EMa/R5Wt/mwcSX+BN+ynglykLoowNX+Fe8IwzxFJ9AA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nFNZktA5QGiW0bUPgbZwF7kpW3bpbYB7REik4a0VBSp4ULC53gxJoMjBCDyjR5Ku9lx+bwZRRVqSnMlmcZyp1zdUGK7JntsGxKOoglQZVmHIYihaVZPzqQ/G+9hs+NqF0s0IfDbRKFWXGPTDn+6zVRsAxFEL9mV4KgePA4RbZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZArS1Zwf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c9304b7bcso15848305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757014905; x=1757619705; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5U21NYXtFXidgUIFHk0jfa8HSJ+8Qupc+eZPXl5Lvs=;
        b=ZArS1Zwfcc1B9eiHS8grS9icbpBJhDnJ5r/6YbeIyRCM539FcfkzaGM2woz8CY1EYZ
         g7JW5rshwfCV1iRyQW8sJID+RmOHClhKGClwUq+YkuR1KZ35TYoNOmlyBeqFFwzph+Mw
         XJle02isf2XkSNa+JtwE8+iCUHdxpFwFAbJVs36W4twJYYk/THrrLUEIeNM1q/HTdiVI
         koVhFYV2fP1GjL45kY01f3UTvDwKNoGbgQ0bGWbtQxKCtFt/PaMdqTZuVmWc7ATPsVSO
         fXQ0VQiIyMNu5+qupwV306XJDVYxP5FEGjORkrrV1CQ3+5nq/pTeGHMijLgwuH3TYddj
         1Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014905; x=1757619705;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5U21NYXtFXidgUIFHk0jfa8HSJ+8Qupc+eZPXl5Lvs=;
        b=HlJiWV0igMepNOaLJA+te4Z0xGQIzo+4myFXFt/w5GjbJtIFxf/TTjGmPgkG2D2FIH
         yGaaxy93g4ZZet3imOfoch3ei7Xy1DyRpo8wkWp4Q6gvi3JoUdNn259TADOjaVkkoNNh
         0sm73aDCsIXteGzz3uO86RqXoVw3EGMRBppJAceVVjYqNnxBOOpIzQ8EgWtVQ+Zw00/P
         s867I3txHfckk9eJu/5Swg096R33XBxJcT2IayDc6BeNPPcDdCjX6h7PJLoGQLI/2tDc
         AeOgM3Goh69K2AWIyCdlnYUbaNY7AdAncsfUzTXats0DmtKK4FWtst85WPX0VZQ6PEPB
         pwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVnNwLReOm622NlG88F1tj07Bt/fVTZG35O4zoJntetlWhpqePPEKeIxkEQpfvLrzu4VtJ0ugeoWYnaFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7WXrE5n0k3CNNO6Poukusf1974pARt8MUOxn+Zm0okPDddHD
	wVMxnzxY1cQtZfX5UJrMNFdkoQ/WTsQLRpwkOLKPufmhAZIABs1nhtVmVKU/9q+HPS3N8X/yLGk
	EKUdle/ECeQ==
X-Google-Smtp-Source: AGHT+IGpGfPDSjKUjtGRYmwUjewNirZB+p9GlZyNGxVdAdOHwwbHEtra92+Yp5diTupe7ZZmc7Xv4+BLmTNg
X-Received: from plhe1.prod.google.com ([2002:a17:903:1c1:b0:245:f81c:1553])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b46:b0:240:48f4:40f7
 with SMTP id d9443c01a7336-24944b29c03mr298099005ad.39.1757014905435; Thu, 04
 Sep 2025 12:41:45 -0700 (PDT)
Date: Thu,  4 Sep 2025 12:41:37 -0700
In-Reply-To: <20250904194139.1540230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904194139.1540230-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904194139.1540230-2-irogers@google.com>
Subject: [PATCH v7 1/3] perf jevents: Add collection of topdown like metrics
 for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Metrics are created using legacy, common and recommended events. As
events may be missing a TryEvent function will give None if an event
is missing. To workaround missing JSON events for cortex-a53, sysfs
encodings are used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 148 ++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index c9aa2d827a82..e8016dec1c87 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,14 +1,152 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup)
 import argparse
 import json
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 
+def Arm64Topdown() -> MetricGroup:
+  """Returns a MetricGroup representing ARM64 topdown like metrics."""
+  def TryEvent(name: str) -> Optional[Event]:
+    # Skip an event if not in the json files.
+    try:
+      return Event(name)
+    except:
+      return None
+  # ARM models like a53 lack JSON for INST_RETIRED but have the
+  # architetural standard event in sysfs. Use the PMU name to identify
+  # the sysfs event.
+  pmu_name = f'armv8_{_args.model.replace("-", "_")}'
+  ins = Event("instructions")
+  ins_ret = Event("INST_RETIRED", f"{pmu_name}/inst_retired/")
+  cycles = Event("cpu\\-cycles")
+  stall_fe = TryEvent("STALL_FRONTEND")
+  stall_be = TryEvent("STALL_BACKEND")
+  br_ret = TryEvent("BR_RETIRED")
+  br_mp_ret = TryEvent("BR_MIS_PRED_RETIRED")
+  dtlb_walk = TryEvent("DTLB_WALK")
+  itlb_walk = TryEvent("ITLB_WALK")
+  l1d_tlb = TryEvent("L1D_TLB")
+  l1i_tlb = TryEvent("L1I_TLB")
+  l1d_refill = Event("L1D_CACHE_REFILL", f"{pmu_name}/l1d_cache_refill/")
+  l2d_refill = Event("L2D_CACHE_REFILL", f"{pmu_name}/l2d_cache_refill/")
+  l1i_refill = Event("L1I_CACHE_REFILL", f"{pmu_name}/l1i_cache_refill/")
+  l1d_access = Event("L1D_CACHE", f"{pmu_name}/l1d_cache/")
+  l2d_access = Event("L2D_CACHE", f"{pmu_name}/l2d_cache/")
+  llc_access = TryEvent("LL_CACHE_RD")
+  l1i_access = Event("L1I_CACHE", f"{pmu_name}/l1i_cache/")
+  llc_miss_rd = TryEvent("LL_CACHE_MISS_RD")
+  ase_spec = TryEvent("ASE_SPEC")
+  ld_spec = TryEvent("LD_SPEC")
+  st_spec = TryEvent("ST_SPEC")
+  vfp_spec = TryEvent("VFP_SPEC")
+  dp_spec = TryEvent("DP_SPEC")
+  br_immed_spec = TryEvent("BR_IMMED_SPEC")
+  br_indirect_spec = TryEvent("BR_INDIRECT_SPEC")
+  br_ret_spec = TryEvent("BR_RETURN_SPEC")
+  crypto_spec = TryEvent("CRYPTO_SPEC")
+  inst_spec = TryEvent("INST_SPEC")
+
+  return MetricGroup("lpm_topdown", [
+      MetricGroup("lpm_topdown_tl", [
+          Metric("lpm_topdown_tl_ipc", "Instructions per cycle", d_ratio(
+              ins, cycles), "insn/cycle"),
+          Metric("lpm_topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
+                 d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
+          Metric("lpm_topdown_tl_stall_be_rate", "Backend stalls to all cycles",
+                 d_ratio(stall_be, cycles), "100%") if stall_be else None,
+      ]),
+      MetricGroup("lpm_topdown_fe_bound", [
+          MetricGroup("lpm_topdown_fe_br", [
+              Metric("lpm_topdown_fe_br_mp_per_insn",
+                     "Branch mispredicts per instruction retired",
+                     d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
+              Metric("lpm_topdown_fe_br_ins_rate",
+                     "Branches per instruction retired", d_ratio(
+                         br_ret, ins_ret), "100%") if br_ret else None,
+              Metric("lpm_topdown_fe_br_mispredict",
+                     "Branch mispredicts per branch instruction",
+                     d_ratio(br_mp_ret, br_ret), "100%") if (br_mp_ret and br_ret) else None,
+          ]),
+          MetricGroup("lpm_topdown_fe_itlb", [
+              Metric("lpm_topdown_fe_itlb_walks", "Itlb walks per insn",
+                     d_ratio(itlb_walk, ins_ret), "walk/insn"),
+              Metric("lpm_topdown_fe_itlb_walk_rate", "Itlb walks per L1I TLB access",
+                     d_ratio(itlb_walk, l1i_tlb) if l1i_tlb else None, "100%"),
+          ]) if itlb_walk else None,
+          MetricGroup("lpm_topdown_fe_icache", [
+              Metric("lpm_topdown_fe_icache_l1i_per_insn",
+                     "L1I cache refills per instruction",
+                     d_ratio(l1i_refill, ins_ret), "l1i/insn"),
+              Metric("lpm_topdown_fe_icache_l1i_miss_rate",
+                     "L1I cache refills per L1I cache access",
+                     d_ratio(l1i_refill, l1i_access), "100%"),
+          ]),
+      ]),
+      MetricGroup("lpm_topdown_be_bound", [
+          MetricGroup("lpm_topdown_be_dtlb", [
+              Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per instruction",
+                     d_ratio(dtlb_walk, ins_ret), "walk/insn"),
+              Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks per L1D TLB access",
+                     d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else None, "100%"),
+          ]) if dtlb_walk else None,
+          MetricGroup("lpm_topdown_be_mix", [
+              Metric("lpm_topdown_be_mix_ld", "Percentage of load instructions",
+                     d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
+              Metric("lpm_topdown_be_mix_st", "Percentage of store instructions",
+                     d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
+              Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD instructions",
+                     d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
+              Metric("lpm_topdown_be_mix_fp",
+                     "Percentage of floating point instructions",
+                     d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
+              Metric("lpm_topdown_be_mix_dp",
+                     "Percentage of data processing instructions",
+                     d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
+              Metric("lpm_topdown_be_mix_crypto",
+                     "Percentage of data processing instructions",
+                     d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
+              Metric(
+                  "lpm_topdown_be_mix_br", "Percentage of branch instructions",
+                  d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
+                          inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
+          ], description="Breakdown of instructions by type. Counts include both useful and wasted speculative instructions"
+                      ) if inst_spec else None,
+          MetricGroup("lpm_topdown_be_dcache", [
+              MetricGroup("lpm_topdown_be_dcache_l1", [
+                  Metric("lpm_topdown_be_dcache_l1_per_insn",
+                         "L1D cache refills per instruction",
+                         d_ratio(l1d_refill, ins_ret), "refills/insn"),
+                  Metric("lpm_topdown_be_dcache_l1_miss_rate",
+                         "L1D cache refills per L1D cache access",
+                         d_ratio(l1d_refill, l1d_access), "100%")
+              ]),
+              MetricGroup("lpm_topdown_be_dcache_l2", [
+                  Metric("lpm_topdown_be_dcache_l2_per_insn",
+                         "L2D cache refills per instruction",
+                         d_ratio(l2d_refill, ins_ret), "refills/insn"),
+                  Metric("lpm_topdown_be_dcache_l2_miss_rate",
+                         "L2D cache refills per L2D cache access",
+                         d_ratio(l2d_refill, l2d_access), "100%")
+              ]),
+              MetricGroup("lpm_topdown_be_dcache_llc", [
+                  Metric("lpm_topdown_be_dcache_llc_per_insn",
+                         "Last level cache misses per instruction",
+                         d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
+                  Metric("lpm_topdown_be_dcache_llc_miss_rate",
+                         "Last level cache misses per last level cache access",
+                         d_ratio(llc_miss_rd, llc_access), "100%")
+              ]) if llc_miss_rd and llc_access else None,
+          ]),
+      ]),
+  ])
+
+
 def main() -> None:
   global _args
 
@@ -29,11 +167,13 @@ def main() -> None:
   )
   _args = parser.parse_args()
 
-  all_metrics = MetricGroup("",[])
-
   directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
   LoadEvents(directory)
 
+  all_metrics = MetricGroup("",[
+      Arm64Topdown(),
+  ])
+
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
   else:
-- 
2.51.0.355.g5224444f11-goog


