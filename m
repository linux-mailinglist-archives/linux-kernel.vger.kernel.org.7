Return-Path: <linux-kernel+bounces-580278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A80A74FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34EE1786D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305721EE029;
	Fri, 28 Mar 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHK+RkcJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685C1DFDB4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184273; cv=none; b=Lkin8MpkpljF/BwZGboT1f2L2AXZGt/UtBAbFKFOoidygGSQX4GTXFsekwpTaQEeQS9ZZKFtrFo+l8E3G+57+u2XzgJFwG0pje/QG1DK1iuAKAcjXem84LX+HQeS5fqOfol6APkBALp0pzoeCB/GruFyyqASUsv+vGO+SFPu/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184273; c=relaxed/simple;
	bh=I1oawinPrpmX/ze68SGkAt4NjyTIewgNSSbIZ48BhTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Kh7PHwKU3zFjViRXGOK3ZsFWJUSiyUWYUFlTEuBudyXevKbyq4ETSAC1nduDWET6Tq0dCKEi/rvSI7APgaAJzFGPuoyvliI6lJXATtlsUGVzrhq26q1NmsEm5i6utjwx/CVjc08Z+UJBDsbKD6zAvGQUquwWnnDWbxJ82WkJfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHK+RkcJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so3202899a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184266; x=1743789066; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsyV6/wwLM2Jy8DspLKW0GCOUqRvUoz/9FBDtlejMR4=;
        b=wHK+RkcJYKxEYWNriGQikhQq141rAnZj+9AtnP84XpGyX3ZGsEFd73kfXNhGxGJQcq
         lt1cUWhjECrEJPaKZbbh2b0CSHZfWJqU8Re8Pn+RL86TgIUd5r+gHgr9BMXo9ZJoPCSz
         iswTOmU6khxO36/7knuPKfscUzBlDRyfOMusPXf8mJ4dNKKLrpo+I68PjMQQA3lu2PmQ
         J7Je0g9S9mQvrsVyoghU0FxXdoVuCqI7NG8TM2yT0Xwscu1rNdcZ6cNb4/ymZ8pD+IFx
         ahWa4YgMfw4z6tw5kmvQfFrS22BgP7HbM4rNCCwhgPpkXPip4iPkEJAcYkWitbEuV8dB
         IbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184266; x=1743789066;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsyV6/wwLM2Jy8DspLKW0GCOUqRvUoz/9FBDtlejMR4=;
        b=sCUHaVRSRqBfzNuJFCbvYpcJ7yxPMPWvjTHBX48xFB6VddQft96P5msi/baL7AB/HO
         rhrO3hwRqGbt3fV5xtSymzwkMsxwAQkKJeYsHWsnizLWfdmKcmhd5pJfRRVyMDWHYdDK
         h0HObTzgRjJQBXli7ofrNLmGtVjzwihiwJa+kC7caQwEjSex1RC3LRH72P+CLBc+cioK
         NnTt87d9myafgFOLPLh2gC4DO1U6DBSdwHCsz/xSGUzoLd7TFkw8ITeEuOozrVV4+s6X
         v34aw/td/LcGhX0y+tUxRZwDwdXCYm7SqHQvyFr2ckEvieY1+4YBgWgjTF14Vv6Fh36W
         Pviw==
X-Forwarded-Encrypted: i=1; AJvYcCWbWSk9v5MKW7FtC5glq1YL+yaF2rzFE7rT2x9HQyDAwNoNuM1IGXewusCad9YOhyj86SGn3zmQOLvCPmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZr60pPY/bOPOVy+utENpdmJQht1nlinaXGKSCKIx6UjgG1LB
	Wy6rVLMeDwMZ+c0miAy/mkEXO4roQY7r1YNnskBUDt1FQO9z9YO19A+PIsG3UicYo0M7UJJQ/6G
	q/4kiqA==
X-Google-Smtp-Source: AGHT+IG3uR65xLFSi6sRYfBqecxvXkS4QVEfwibi/YybEE1qdve1YH81abj9W59E2AUtPSzALtDW3/D/2xVk
X-Received: from pjbpb17.prod.google.com ([2002:a17:90b:3c11:b0:2fa:2661:76ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2744:b0:2f5:88bb:118
 with SMTP id 98e67ed59e1d1-3053213f8b6mr186176a91.22.1743184265985; Fri, 28
 Mar 2025 10:51:05 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:51 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-21-irogers@google.com>
Subject: [PATCH v5 20/35] perf vendor events: Update jaketown metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update TMA metrics from 4.8 to 5.02. Move INSTS_WRITTEN_TO_IQ.INSTS to
the frontend topic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/jaketown/frontend.json           |  8 ++++
 .../arch/x86/jaketown/jkt-metrics.json        | 40 ++++++++++++++-----
 .../arch/x86/jaketown/metricgroups.json       |  5 +++
 .../pmu-events/arch/x86/jaketown/other.json   |  8 ----
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json b/tools/=
perf/pmu-events/arch/x86/jaketown/frontend.json
index 3cb468da7011..97e7760aeb26 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/frontend.json
@@ -278,5 +278,13 @@
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Valid instructions written to IQ per cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "INSTS_WRITTEN_TO_IQ.INSTS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/too=
ls/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index f8c18741b360..6f636ea0f216 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -127,7 +127,7 @@
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
     {
@@ -211,7 +211,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports=
_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -220,7 +220,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_6, tma_ports=
_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -240,7 +240,7 @@
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
@@ -275,6 +275,12 @@
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_lcp"
     },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
@@ -290,7 +296,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -308,14 +314,14 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
@@ -349,11 +355,18 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_system_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_system_socket_clks / tma_info_system_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -366,6 +379,13 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
@@ -374,7 +394,7 @@
     },
     {
         "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / duration_time",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_uncore_frequency"
     },
@@ -468,7 +488,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_info_system_dram_bw_use",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/metricgroups.json
index 7dc7eb0d3dd3..eb8fbd14138a 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
@@ -9,6 +9,7 @@
     "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
@@ -33,6 +34,7 @@
     "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -48,6 +50,7 @@
     "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
     "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
     "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -75,6 +78,7 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -99,6 +103,7 @@
     "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/other.json b/tools/per=
f/pmu-events/arch/x86/jaketown/other.json
index 42692fa24b6c..970839a9c786 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/other.json
@@ -33,14 +33,6 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Valid instructions written to IQ per cycle.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x17",
-        "EventName": "INSTS_WRITTEN_TO_IQ.INSTS",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock.",
         "Counter": "0,1,2,3",
--=20
2.49.0.472.ge94155a9ec-goog


